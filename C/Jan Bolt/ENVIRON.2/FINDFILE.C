/*===============================================================*
 *                                                               *
 * findfile.c                                                    *
 *                                                               *
 * sucht file in allen Verzeichnissen von PATH,                  *
 * gibt kompletten Pfadnamen zur�ck,                             *
 * oder NULL bei vergeblicher Suche                              *
 *                                                               *
 * 24.05.90 Jan Bolt                                             *
 *                                                               *
 * Turbo C                                                       *
 *===============================================================*/
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tos.h>

#define is_file(f) (Fsfirst(f,0) == 0)

char *findfile(char *file)
     {
     static char tmp[PATH_MAX];
     char *path, *p;

     if (strchr(file, '\\') || strchr(file, ':')) /* file enth�lt Pfad */
        return (is_file(file)) ? file : NULL;

     if ((path=getenv("PATH")) == NULL || /* falls PATH nicht existiert */
         *path == '\0')                   /* oder leer */
        path = ".";                       /* path = akt Directory */

     while (*path != '\0')
           {
           p = tmp;
           while (*path != '\0' &&
                  *path != ';'  &&
                  *path != ',')      /* Directory aus PATH */
                 *p++ = *path++;     /* nach tmp kopieren  */
           if (*path != '\0')        /* Separator �berspringen */
              path++;
           if (p[-1] != '\\')        /* Directory mit \ */
              *p++ = '\\';           /* abschlie�en */
           strcpy(p, file);          /* file anh�ngen */
           if (is_file(tmp))
              return tmp;
           }
     return NULL;
     }

