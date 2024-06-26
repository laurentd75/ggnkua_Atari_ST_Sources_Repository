/*******************************/
/* Gestion du format Neochrome */
/*******************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include     "..\tools\xgem.h"
#include "..\tools\image_io.h"


typedef struct
{
  int  zero ;     /* Toujours nul */
  int  resol ;    /* 0 : basse, 1 : Moyenne, 2 : Haute */
  int  pal[16] ;  /* Palette RVB 3 bits */
  char anim[12] ;
  int  v_anim ;
  int  nb_pas ;
  int  off_x ;    /* Toujours 0 */
  int  off_y ;    /* Toujours 0 */
  int  largeur ;  /* Toujours 320 */
  int  hauteur ;  /* Toujours 200 */
  int  reserved[34] ;
}
NEO_HEADER ;

#pragma warn -par
int neo_load(char *name, MFDB *out, GEM_WINDOW *wprog)
{
  NEO_HEADER header ;
  FILE       *stream ;

  perf_start( PERF_DISK, &PerfInfo ) ;
  stream = fopen(name, "rb") ;
  if (stream == NULL) return(-1) ;
  
  fread(&header, sizeof(NEO_HEADER), 1, stream) ;
  out->fd_nplanes = 4 ;
  out->fd_w       = 320 ; 
  out->fd_h       = 200 ;
  out->fd_stand   = 0 ;
  out->fd_wdwidth = out->fd_w/16 ;
  out->fd_addr    = malloc(32000) ;
  if (out->fd_addr == NULL)
  {
    fclose(stream) ;
    return(-3) ;
  }

  fread(out->fd_addr, 32000, 1, stream) ;
  fclose(stream) ;
  perf_stop( PERF_DISK, &PerfInfo ) ;

  return(0) ;
}
#pragma warn +par

int neo_identify(char *nom, INFO_IMAGE *inf)
{
  NEO_HEADER header ;
  FILE       *stream ;
  long       tcol ;
  int        i, *pt ;
  int        ind ;
  int        coe ;

  stream = fopen(nom, "rb") ;
  if (stream == NULL) return(-1) ;

  fread(&header, sizeof(NEO_HEADER), 1, stream) ;
  fclose(stream) ;

  inf->version  = 0 ;
  inf->compress = 0 ;
  inf->largeur  = 320 ;
  inf->hauteur  = 200 ;
  inf->nplans   = 4 ;
  inf->nb_cpal  = 16 ;
  inf->lpix     = 72 ; /* On ne sait pas */
  inf->hpix     = 72 ;

  tcol = nb_colors ;
  if (inf->nb_cpal > nb_colors) tcol = inf->nb_cpal ;
  inf->palette = malloc(6*tcol) ;
  if (inf->palette == NULL) return(-3) ;

  pt  = (int *) inf->palette ;
  coe = 1000/7 ;
  for (i = 0; i < inf->nb_cpal; i++)
  {
    ind       = 3*i ;
    pt[ind]   = ((header.pal[i] >> 8) & 0x0007)*coe ; /* Rouge */
    pt[1+ind] = ((header.pal[i] >> 4) & 0x0007)*coe ; /* Vert  */
    pt[2+ind] = (header.pal[i] & 0x0007)*coe     ;    /* Bleu  */
  }
  inf->nb_cpal = 16 ;

  return(0) ;
}

int neo_sauve(char *name, MFDB *img, INFO_IMAGE *inf)
{
  NEO_HEADER header ;
  FILE       *stream ;
  int        i ;
  int        coe ;
  int        *pt ;

  if ((img->fd_w != 320) || (img->fd_h != 200) || (img->fd_nplanes != 4))
    return(-4) ;

  if (inf->palette != NULL)
  {
    coe = 1000/7 ;
    pt = (int *) inf->palette ;
    memset(&header.pal, 0, 16*2) ;
    for (i = 0; i < inf->nb_cpal; i++)
    {
      header.pal[i] = (((pt[3*i]/coe) & 0x07) << 8) +
                      (((pt[3*i+1]/coe) & 0x07) << 4) +
                      ((pt[3*i+2]/coe) & 0x07) ;
    }
  }

  header.zero    = 0 ;
  header.resol   = 0 ;
  memset(&header.anim, 0, 12) ;
  header.v_anim  = 0 ;
  header.nb_pas  = 0 ;
  header.off_x   = 0 ;
  header.off_y   = 0 ;
  header.largeur = 0 ; /* Normalement 320 et 200 mais certains */
  header.hauteur = 0 ; /* logiciels ne comprennent plus !      */
  memset(&header.reserved, 0, 34*2) ;

  stream = fopen(name, "wb") ;
  if (stream == NULL) return(-1) ;

  fwrite(&header, sizeof(NEO_HEADER), 1, stream) ;
  if (fwrite(img->fd_addr, 32000, 1, stream) != 1)
  {
    fclose(stream); 
    return(-2) ;
  }

  if (fclose(stream)) return(-2) ;

  return(0) ;
}

void neo_getdrvcaps(INFO_IMAGE_DRIVER *caps)
{
  char kext[] = "PI1\0PI2\0PI3\0PC1\0PC2\0PC3\0\0" ;

  caps->iid = IID_NEO ;
  strcpy( caps->short_name, "NEO" ) ;
  strcpy( caps->name, "Neochrome" ) ;
  caps->version = 0x0400 ;

  caps->inport1         = 0 ;
  caps->inport2         = 0 ;
  caps->inport4         = 1 ;
  caps->inport8         = 0 ;
  caps->inport16        = 0 ;
  caps->inport24        = 0 ;
  caps->inport32        = 0 ;
  caps->inport_nocmp    = 1 ;
  caps->inport_rle      = 0 ;
  caps->inport_lzw      = 0 ;
  caps->inport_packbits = 0 ;
  caps->inport_jpeg     = 0 ;
  caps->inport_rfu      = 0 ;

  caps->export1         = 0 ;
  caps->export2         = 0 ;
  caps->export4         = 1 ;
  caps->export8         = 0 ;
  caps->export16        = 0 ;
  caps->export24        = 0 ;
  caps->export32        = 0 ;
  caps->export_nocmp    = 1 ;
  caps->export_rle      = 0 ;
  caps->export_lzw      = 0 ;
  caps->export_packbits = 0 ;
  caps->export_jpeg     = 0 ;
  caps->export_rfu      = 0 ;
  
  memcpy( caps->known_extensions, kext, sizeof(kext) ) ;
}
