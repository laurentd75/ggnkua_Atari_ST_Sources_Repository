/*
 * GNPA.H
 * Auteurs: Lehmer (algorithme), Billy T. (codage en C), PSY (optimisation).
 * DerniŠre r‚vision: 2 mai 1994
 * But: G‚narateur de Nombres Pseudo-Al‚atoires.
 */

#ifndef __GNPA_H
#define __GNPA_H

#include <stdio.h>
#include <time.h>  //time

#define MULTIPLICATEUR 16807L
#define         MODULE 2147483647L
#define       QUOTIENT 127773L
#define          RESTE 2836L

#define      MINRANDOM 0

#define Randomize() Ran(-1L)

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
float Ran(long semence)
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	{
	static long z;

	if(semence<0L)
		z=(unsigned long)(time(&semence)%(MODULE-1)+1);
	else if(semence>0L)
		z=semence;
	if((z=MULTIPLICATEUR*(z%QUOTIENT) - RESTE*(long)(z/QUOTIENT)) <= 0L)
		z+=MODULE;
	return((float)z / (float)MODULE);
	}

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
int Random(int MAXRANDOM)
/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	{
	return( (int)( MINRANDOM + Ran(0L) * (MAXRANDOM-MINRANDOM+1) ) );
	}

#endif