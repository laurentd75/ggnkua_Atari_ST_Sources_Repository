/**********************************************************************
 *
 * Dieses kleine Beispielprogramm zeigt, wie die speziellen
 * OverScan-Xbios-Funktionen zu benutzen sind. Es l�uft auch 
 * unter dem Normalmodus, aber NICHT auf Gro�bildschirmen, da 
 * dort die Funktion 'Setscreen' nicht zur Verf�gung steht.
 *
 *   WICHTIG
 *  ---------
 * Dieses Beispiel ist nur f�r Programmierer gedacht, die speziell
 * an OverScan angepa�te Zeichenprogramme schreiben wollen und somit
 * in der Lage sein m��en, die Aufl�sung und den Bildschirmspeicher
 * zu wechseln.
 *
 * Wie man ansonsten 'aufl�sungsunabh�ngig' programmiert, erf�hrt man
 * im Anhang A des OverScan-Handbuchs.
 *
 * K.Isakovic   Berlin 27.09.89
 *
 * TurboC 1.1 
 */

#include <stdlib.h>
#include <tos.h>
#include "overscan.h"

void main(void)
{
long OldPhy,NewPhy;	/* Man mu� unter OverScan Logbase und */
long OldLog,NewLog;	/* Physbase getrennt behandeln.	      */
int  OldRes,NewRes;
long block;
int  AltCol;

  OldRes = Getrez();		/* Aufl�sung feststellen      */
  if (OldRes == 2)		/* Damit der Bildschirm nicht */
      NewRes = OldRes = -1; 	/* gel�scht wird  -1 angeben. */
  else				/* Beim Farbbildschirm die    */
    NewRes = OldRes^1;		/* Aufl�sung wechseln.	      */       
  
  OscanLogPhy(&OldLog,&OldPhy);	/* Physbase und Logbase holen */
  if (OverscanScreen(&block,&NewLog,&NewPhy,NewRes) )
    {               		/* 2.Bildschirmschirm anlegen */
    Oscanscr(0);		/* Setscreen erlauben  */
    Oscanvb(0);                 /* VB-Tests auschalten */
    Cconws("\n\rMini-Demo f�r Programmierung unter");
    Cconws("\n\r dem OVERCAN-Modus.\n\r");
    Cconws("\n\rEs wird ein 2.Bildschirmspeicher");  
    Cconws("\n\r angelegt und angezeigt. Beim Farb-");  
    Cconws("\n\r Monitor wird auf dem 2.Schirm eine");  
    Cconws("\n\r andere Aufl�sung benutzt.\n\r");  
    Cconws("\n\rWeiter durch Tastendruck...");
    Cnecin();
    
    Setscreen((void *)NewLog,(void *)NewPhy,NewRes);
    AltCol = Setcolor(0,0);   /* Die Farbpalette stimmt nicht, wenn */
			      /* die Aufl�sung umgeschaltet wurde   */
    Cconws("\n\rDies ist nun der 2.Bildschirm.");
    Cconws("\n\rDas Programm l�uft auch ohne");
    Cconws("\n\r den OverScan-Modus, aber nicht");  
    Cconws("\n\r auf Gro�bildschirmen :^)\n\r");  
    Cconws("\n\r Ende durch Tastendruck..."); 
    Cnecin();
    
    Setcolor(0,AltCol);
    Setscreen((void *)OldLog,(void *)OldPhy,OldRes);
    
    Mfree((void *)block);	/* Speicher wieder freigeben 	*/
    Oscanscr(1);		/* Setscreen wieder aus      	*/
    Oscanvb(1);			/* VB-Tests wieder einschalten	*/
    exit(0);
    }
  else
    {
    Cconws("\n\rNicht genug Speicher.\n\r");
    Cconws("   Return dr�cken..\n\r");
    Cnecin();
    exit(-1);
    }
}
