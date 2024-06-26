/*********************/
/* TARGA_IO.C header */
/*********************/
#if !defined(__TARGA)
#define __TARGA

#if !defined(__IMAGE_IO)
#include "..\tools\image_io.h"
#endif


int  targa_load(INFO_IMAGE* inf) ;
int  targa_identify(char* nom, INFO_IMAGE* inf) ;
int  targa_sauve(char* name, MFDB* img, INFO_IMAGE* info, GEM_WINDOW* wprog) ;
void targa_getdrvcaps(INFO_IMAGE_DRIVER* caps) ;


#endif
