/*	Lempel - Ziv - Welsch - Komprimierung
 *
 *	Header-Datei mit f�r Komprimierung und Dekomprimierung
 *	gemeinsam geltenden Definitionen
 *
 *	Autoren: Gabi Keller und Manuel Chakravarty f�r die ST-Computer
 *	System : LaserC von Application Systems Heidelberg
 */ 

#include <stdio.h>
#include <osbind.h>

#define	BITS_PER_CHAR	8
#define	TRUE		(-1)
#define	FALSE		0 
#define NO_PREFIX	((unsigned) -1)	/*  Alle Bits auf 1  */        
#define TABLESIZE 	1024
#define HASHSIZE	2509  /*  Sollte prim sein  */
#define HASHSTEP	23    /*  Sollte prim sein  */
#define STRSIZE  	80
#define INCREASE_WIDTH  256   /*  Spezialcode um dem Decodierer mitzu-
		               *  teilen, da� ab dem n�chsten Codewort
		               *  die Bitbreite um eins vergr��ert wird */
#define NEW_TABLE       257   /*  ..., da� er seine Tabelle l�schen soll */
#define FIRST_FREE      258   /*  Erster Code fuer neue Eintr�ge        */

typedef	int	bool;
typedef char    string[STRSIZE];
