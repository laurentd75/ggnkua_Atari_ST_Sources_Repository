/**********************************************/
/* Modul:   MEMORY.C                          */
/* ------------------------------------------ */
/* Funktionen:                                */
/*    Speicherverwaltung f�r ATARI ST/TT      */
/* Ersteller:                                 */
/*    Hartmut Klindtworth, 14.04.1992         */
/*    Copyright 1992 by MAXON-Verlag, Eschborn*/
/**********************************************/

/*= INCLUDES =================================*/
#include <ext.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*= PROTOTYPEN ===============================*/
int   init_malloc( long maxmem );
int   ende( void );
void  *mallocn(int vh, long groesse);
long  check( void );
int   freen(int vh, void *oldadr);
void *reallocn(int vh,void *oldadr,size_t great);
int   Mshrinkn(int vh, int zero, void *block,
                                 long newsize);
void  *callocn( int vh, long nitems,long size);


/*= DEFINES ==================================*/
            /* Anzahl des noch z.Vfg. st. Sp. */
#define RESERVE_MEMORY  128*1024L 
          /* Anzahl der Memory-Speicherbl�cke */
#define MAXMEMP     100
                    /* Nur f�r LONG definiert */
#define GERADE(a)   ((a+1)&-2L)   

/*= Globale Variablen ========================*/
char *mempa[MAXMEMP];
/*  MEMoryPointerArray
    Im vorderen und hinteren Teil werden  
    Pointer gesichert, die auf die zugeteilten
    Speicherbereiche zeigen                   */
long gamem[MAXMEMP];
/*  Memorygr��e  (Gr��enArray f�r MEMory)
    Im vorderen und hinteren Teil befindet sich
    die Gr��e eines einzelnen Speicherblockes.*/
int va, ha;
/*  Anzahl der belegten Spbl. vorne/hinten  */

/* Routine:   init_malloc                     */
/* ------------------------------------------ */
/* Funktion:  initialisiert Speicher          */
/* Funktionsweise:                            */
/*  pr�ft wieviel Speicher angefordert werden */
/*  kann und reserviert diesen in Abh�nigkeit */
/*  der von RESERVE-MEMORY und maximalgroesse */
/* �bergabe:  long maxmem                     */
/*  maximale Speicheranforderung,falls m�glich*/
/*  ==0 => Parameter unwichtig                */
/* R�ckgabe:  int                             */
/*  -1 bei Fehler, sonst 0                    */
int init_malloc( long maxmem )
{ /*  Fragt nach, wieviel Speicher frei ist   */
  gamem[0]=(long)coreleft();  
  if(gamem[0]<=0) return(-1);
  if(maxmem>0 && gamem[0]>maxmem)
      gamem[0]=maxmem;
  else
  { gamem[0]-=RESERVE_MEMORY; 
    if(gamem[0]<=0) return(-1);
  }
  gamem[0]=GERADE(gamem[0]-1);
  mempa[0]=(char *)malloc(gamem[0]);

  return(0);
}

/* Routine:   ende                            */
/* ------------------------------------------ */
/* Funktion:  �berpr�ft evtl. Fehler in der   */
/*  Speicherverwaltung und ruft end auf       */
/* Funktionsweise:  Sollte zu viel Speicher   */
/*  reserviert sein, so wird angezeigt, wo    */
/*  noch Speicher zur�ckgegeben werden sollte.*/
/*  Oder es kann sein, da� zu viele frei ge-  */
/*  geben worden sind, dann wird auch eine    */
/*  Meldung ausgeben. Ganz zum Schlu� wird    */
/*  free() aufgerufen, um den Speicher wieder */
/*  an das Betriebssystem zur�ckzugeben.      */
/* R�ckgabe:  int                             */
/*  0 => kein Fehler, -1 => Fehler            */
int ende( void )
{ char  text[80];     /* Textspeicherung      */
  int   i,            /* Laufvariable         */
        fehler=0;     /* Gibt evtl. Fehler an */

  if(va>0)
  { puts("Es sind noch folgende Speicherbl�cke"
                " nicht zur�ckgegeben worden:");
    for(i=1; i<=va; i++)
    { memset(text,0,sizeof(text));
      strcpy(text,"Vordere Speicheradresse: ");
      ltoa((long)mempa[i],text+strlen(text),10);
      strcat(text," mit Speicher: ");
      ltoa(gamem[i],text+strlen(text),10);
      puts(text);
    }
    fehler=-1;
    while(kbhit())  getch();
    while(kbhit()==0);
    getch();
  }
  
  if(ha>0)
  { if(va<=0)
      puts("Es sind noch folgende Speicher"
        "bl�cke nicht zur�ckgegeben worden:");

    for(i=1; i<=ha; i++)
    { memset(text,0,sizeof(text));
      strcpy(text,"Hintere Speicheradresse: ");
      ltoa((long)mempa[MAXMEMP-i],
                    text+strlen(text),10);
      strcat(text," mit Speicher: ");
      ltoa(gamem[MAXMEMP-i],
                        text+strlen(text),10);
      puts(text);
    }
    fehler=-1;
    while(kbhit())  getch();
    while(kbhit()==0);
    getch();
  }
  
  if(va<0 || ha<0)
  { puts("Es sind zuviele Speicherpl�tze"
          " freigegeben worden:");
    memset(text,0,sizeof(text));
    strcpy(text,"Vorderer Speicherindex: ");
    itoa(va,text+strlen(text),10);
    strcat(text,"    Hinterer Speicherindex: ");
    itoa(ha,text+strlen(text),10);
    puts(text);
    fehler=-1;
    while(kbhit())  getch();
    while(kbhit()==0);
    getch();
  }
  /* Gesamten Speicherplatz wieder freigeben  */
  free( (void *)mempa[0] );

  return(fehler);
}

/* Routine:   mallocn (malloc)                */
/* ------------------------------------------ */
/* Funktion:  reserviert Speicher             */
/* Funktionsweise:  Wird der Speicher nur     */
/*  vorr�bergehend genutzt, so wird eine 1 in */
/*  vh �bergeben. Damit mu� der Speicher am   */
/*  Ende des Speicherblocks reserviert werden.*/
/*  Dabei wird ein check durchgef�hrt, ob     */
/*  �berhaupt noch soviel Speicher vorhanden  */
/*  ist. Dabei wird der Speicherz�hler hinten */
/*  um einen erh�ht und die Adresse des freien*/
/*  Speichers wird berechnet. Diese Adresse   */
/*  und die Gr��e werden in die daf�r vorge-  */
/*  sehenen globalen Arrays eingetragen.      */
/*  Entsprechend  wird bei einer vorderen     */
/*  Allozierung des Speichers gehandelt.      */
/* �bergabe:  long groesse                    */
/*  Gr��e des gew�nschten Speicherplatzes     */
/*            int vh                          */
/*  0=>Speicher vorne, 1=>Speicher hinten     */
/* R�ckgabe:  void *                          */
/*  typenloser Zeiger, der auf den angeforder-*/
/*  ten Speicherblock zeigt, oder Anzahl der  */
/*  freien Bytes oder NULL falls Fehler       */
/*  aufgetreten ist (z. B. Speichermangel)    */
void *mallocn(int vh, long groesse)
{ void *adr=NULL;

  if(groesse==-1) return( (void *)check() );    
  if(groesse<= 0) return(NULL);

  /* Nur gerade Speicherbereichsgr��en        */
  groesse=GERADE(groesse+1);

  if(vh!=0) 
  { if(groesse<check() && groesse>0)
    { ha++;
      if(ha<=1)
        mempa[MAXMEMP-ha]=
                    mempa[0]+gamem[0]-groesse;
      else
        mempa[MAXMEMP-ha]=
               mempa[MAXMEMP-(ha-1)]-groesse;
      gamem[MAXMEMP-ha]=groesse;
      adr=mempa[MAXMEMP-ha];
    }
  }else
  { if(groesse<check() && groesse>0)
    { va++;
      if(va<=1)
        mempa[va]=mempa[va-1];
      else
        mempa[va]=mempa[va-1]+gamem[va-1];
      gamem[va]=groesse;
      adr=mempa[va];
    }
  }
  return(adr);
}

/* Routine:   check (malloc(-1))              */
/* ------------------------------------------ */
/* Funktion: ermittelt gr��tm�gl. Speicherbl. */
/* Funktionsweise: vom Hauptspeicher wird der */
/*  belegte Speicherplatz vorne und hinten    */
/*  abgezogen.                                */
/* �bergabe:  nichts                          */
/* R�ckgabe:  long                            */
/*  Gr��e des verbleibenden Speicherblockes   */
long check( void )
{ long ret;
  
  ret=gamem[0];
  if(va>0)
    ret-=mempa[va]+gamem[va]-mempa[0];
  if(ha>0)
    ret-=mempa[0]+gamem[0]-mempa[MAXMEMP-ha];
  return(ret);
}

/* Routine:   freen (free)                    */
/* ------------------------------------------ */
/* Funktion:  gibt belegten Speicherblock frei*/
/* Funktionsweise:  setzt die Speichergr��e,  */
/*  den Zeiger auf den Speicherplatz auf      */
/*  Null und subrahiert den Speicheranzahl-   */
/*  zeiger um Eins                            */
/* �bergabe:  int vh                          */
/*  0 (1) Speicher vorne (hinten) freigeben   */ 
/*            void *oldadr                    */
/*  NULL dann irrelevant, sonst Zeiger auf    */
/*  Speicheradresse                           */
/* R�ckgabe:  0=OK, -1=Fehler                 */
int freen(int vh, void *oldadr)
{ /* Speicher wurde vorr�bergehend alloziert  */
  if(vh!=0)
  { if(ha>0)
    { if(oldadr!=NULL && 
                      mempa[MAXMEMP-ha]!=oldadr)
        return(-1);
      mempa[MAXMEMP-ha]=NULL;
      gamem[MAXMEMP-ha]=0;    ha--;
    }
  }else 
    if(va)
    { if(oldadr!=NULL && mempa[va]!=oldadr)
          return(-1);
      mempa[va]=NULL;
      gamem[va]=0;            va--;
    };
  return(0);
}

/* Routine:   reallocn  (realloc)             */
/* ------------------------------------------ */
/* Funktion:  erweitert und grenzt den vor-   */
/*            handenden Speicherblock ein     */
/* Funktionsweise:  Wird der Speicherbereich  */
/*  hinten gew�hlt, so wird der Speicher zu-  */
/*  s�tzlich an eine neue Adresse verschoben. */
/* �bergabe:  void *uvh_oldadress             */
/*  Adresse des zuletzt angeforderten Spbl.   */
/*            long groesse                    */
/*  neue absolute Groesse                     */
/*            int vh                          */
/*  0=>Speicher vorne, 1=>Speicher hinten     */
/* R�ckgabe:  void *                          */
/*  wenn alles klappte, wird die neue Adresse */
/*  des Spbls zur�ckgegeben. Sie kann (wenn   */
/*  hinten) anders als die vorher �bergebene  */
/*  sein! Speicher wurde dann verschoben.     */
/*  NULL, wenn ein Fehler vorlag.             */
void *reallocn(int vh,void *oldadr,size_t great)
{ void *adr=NULL;
  
  great=GERADE(great+1);
  if(vh!=0)
  { /* Ist die Adresse auch korrekt?          */
    if(mempa[MAXMEMP-ha]!=oldadr)
      return(NULL);
      
    if(great<=gamem[MAXMEMP-ha]
                               && great>0)
    { /* Alte Adresse sichern                 */
      adr=mempa[MAXMEMP-ha];
      /* Neuen Pointer errechnen und -setzen  */
      mempa[MAXMEMP-ha]+=gamem[MAXMEMP-ha]-great;
      /* Speicher vom alten Bereich an den    */
      /*                neuen herankopieren   */
      memmove((char *)mempa[MAXMEMP-ha],
                     (char *)adr,(size_t)great);
      /* Groesse neusetzen                    */
      gamem[MAXMEMP-ha]=great;
      adr=mempa[MAXMEMP-ha];
    }else
    { /* Noch genung Speicher da?             */
      if(great-gamem[MAXMEMP-ha]> check() &&
                                       great<=0)
        return(NULL);
              
      /* Alte Adresse sichern                 */
      adr=mempa[MAXMEMP-ha];
      /* Neuen Pointer errechnen und -setzen  */
      mempa[MAXMEMP-ha]-=great-gamem[MAXMEMP-ha];
      /* Speicher vom alten Bereich an den    */
      /*              neuen herankopieren     */
      memmove((char *)mempa[MAXMEMP-ha],
         (char *)adr,(size_t)gamem[MAXMEMP-ha]);
      /* Groesse neusetzen                    */
      gamem[MAXMEMP-ha]=great;
      adr=mempa[MAXMEMP-ha];
    }
  }else
  { /* Ist die Adresse auch korrekt           */
    if(mempa[va]!=oldadr)
          return(NULL);

    if(great<=gamem[va] && great>0)
    { gamem[va]=great;
      adr=oldadr;
    }else if(great-gamem[va]<check()&& great>0)
    { gamem[va]=great;
      adr=oldadr;
    };
  }
  return(adr);
}

/* Routine: Mshrinkn  (Mshrink)               */
/* ------------------------------------------ */
/* Funktion:  verkleinert Speicherblock       */
/* Funktionsweise:  ruft reallocn mit den     */
/*  entsprechenden Werten auf und liefert     */
/*  0 zur�ck, falls alles OK war              */
/* �bergabe:  int vh                          */
/*  0 (1) Speicherblock vorne (hinten) belegen*/
/*            int zero                        */
/*  Standardm��ig auf Null (0)                */
/*            void *block                     */
/*  Zeiger auf den entsprechenden Speichblock */
/*            long newsize                    */
/*  neue Gr��e des Speicherblocks             */
int Mshrinkn(int vh, int zero, void *block, 
                                   long newsize)
{ void *spbl;

  spbl=reallocn(vh, block, (size_t)newsize);
  if(spbl==NULL)  return(-1);
  
  block=spbl;
  zero=0; /* Damit entsteht kein Warning    */
  return(zero);
}

/* Routine:   callocn  (calloc)               */
/* ------------------------------------------ */
/* Funktion:  reserviert Speicher, der auf    */
/*             \x00 gesetzt worden ist        */
/* Funktionsweise:  reserviert Speicher       */
/*  mittels mallocn und l�scht ihn            */
/* �bergabe:  long nitems                     */
/*              Anzahl der Speicherschritte   */
/*            long size                       */
/*              Gr��e der Speicherschritte    */
/*            int vh                          */
/*            0 (1) Speicher vorne (hinten)   */ 
/* R�ckgabe:  void *                          */
/*              Zeiger auf geforderten Spei.  */
/*              NULL bei FEHLER               */
void *callocn( int vh, long nitems,  long size)
{ void *adr;
  
  long ll_size1=GERADE((nitems*size)+1);
  adr=mallocn(vh, (long)(nitems*size));
  if(adr!=NULL)    memset(adr,0,ll_size1);
  return(adr);
}
