/*********************/
/* Header de PRINT.C */
/*********************/
#if !defined (__IMAGE_IO)
#include "..\tools\image_io.h"
#endif

#define PWRITERR  -1
#define PTIMEOUT  -2
#define PNOGDOS   -3
#define PNOHANDLE -4
#define PCANCEL   -5
#define PROTERR   -6
#define PNODRIVER -7


/******************************************************/
/* Sortie d'une image suir imprimante. Nécessite GDOS */
/******************************************************/
int print_image(MFDB *raster, INFO_IMAGE *info) ;
