#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <setjmp.h>
#include <ext.h>

#define BUSERROR 1
#define ADRERROR 2
#define ABBRUCH  3
#define TRUE     1

jmp_buf register_speicher; /* Speicher f�r 16 Register */
sigfunc_t old[3];          /* Feld mit Pointern auf alte
                              Fehlerroutinen */
/* Prototypen */

void init_signal(void);
void exit_signal(void);
void init_errorcheck(void);
void behandle_signal(int);

int wahl;

void main(void)        /* 3 Bomben legen */
  {
  int *a=NULL,*b=0x3;  /* Bus- und Adress-Error vorbereiten */

  init_signal();       /* Signalhandling initialisieren */

  wahl = BUSERROR;     /* Fangen wir mal dem Bus-Error an */
  init_errorcheck();
  if(wahl==BUSERROR)
    *a=10;             /* Bus-Error gewollt - na bitte! */
  else if(wahl==ADRERROR)
    *b=10;             /* Adress-Error gewollt - aber gern! */
  else
    {
    printf("\n Zum Abbrechen der"
           " Endlosschleife Control D dr�cken!");
    while(TRUE) ;     /* und die gef�rchtete Endlosschleife */
    }

  exit_signal(); /* Programm definiert verlassen */

  exit(0);       /* hier w�rde man sonst nie hinkommen */
  }

void behandle_signal(int sig)
  {
  longjmp(register_speicher,sig); 
  /* Umbesetzung aller Register 
     ->Sprung nach setjmp in main */
  }

void init_errorcheck(void)
  {
  int i,rueck,weiter;
  
  if((rueck = setjmp(register_speicher)) != 0) 
  /* R�cksprungadresse und Register merken */
    {
    switch(rueck)
      {
      case SIGSEGV:       

      /* Bus-Error behandeln */

        printf("\nBus-Error ist aufgetreten!\n"
               "R�ckgabewert von longjmp(): %d\n",rueck);
        printf("Weiter ?");
        wahl = ADRERROR;
        weiter=getch();
        break;
 
      case SIGADR:
 
      /* Adress-Error behandeln */

        printf("\nAdress-Error ist aufgetreten!\n"
               "R�ckgabewert von longjmp(): %d\n",rueck);
        printf("Weiter ?");
        weiter=getch();
        wahl = ABBRUCH;
        break;
      case SIGINT:

        printf("\nControl D wurde gedr�ckt -"
        	   "jetzt nur keine Tastendr�cke!\n"
               "R�ckgabewert von longjmp(): %d\n",rueck);

/* getch(); wird erst m�glich sein, wenn der 
 Fehler in Turbo C  behoben sein wird: statt 
 dessen einfache Schleife und raus */

        for(i=0;i<20000;i++) ;
        weiter = 'n';
        break;
      }
    if(weiter=='j' || weiter=='J')
      {
      init_errorcheck(); 
/* Alle Register neu retten, da sie durch 
 'longjmp()' zerst�rt werden k�nnten */
      return;
      }
    exit_signal();
    exit(rueck);
    }
  }

void init_signal(void)
  {
/* Signalverwaltung f�r SIGINT, SIGSEGV
 und SIGADR einh�ngen */

  old[0] = signal(SIGINT, (void (*)(int))behandle_signal);
  old[1] = signal(SIGSEGV,(void (*)(int))behandle_signal);
  old[2] = signal(SIGADR, (void (*)(int))behandle_signal);
  }

void exit_signal(void)
  {

/* Signalverwaltung f�r SIGINT, SIGSEGV 
und SIGADR wieder aush�ngen */

  signal(SIGINT, (void (*)(int))old[0]);
  signal(SIGSEGV,(void (*)(int))old[1]);
  signal(SIGADR, (void (*)(int))old[2]);
  }
