/********************************************************************/
/* Grundger�st zur Verwendung der MEM_MNGE-Speicherverwaltung. Der	*/
/* wesentliche Unterschied zur gewohnten Verwendung ist die Anfangs */
/* erforderlich Beschaffung eines zu verwaltenden Bereiches und die */
/* Initialisierung des Memory-Managers damit. Zum Programmende wird */
/* der anfangs allokierte Speicher wieder dem Betriebssystem �ber-	*/
/* geben.															*/
/*						   Hans-J�rgen Richstein, August '90		*/
/********************************************************************/
#include "MEM_MNGE.H"
#include <stdlib.h>
#include <stddef.h>
#include <tos.h>	/* F�r 'Malloc' und 'Mfree', unter ANSI-C	 */
					/* auch als 'malloc', 'coreleft' und 'free'  */
					/* in <stdlib.h> zu finden...				 */
void main()
{
	char *mein_puffer;
	long puffer_groesse;
	
	char *testpuffer,*temp; /*			Zu			 */
	long *langwort_array;	/* Demonstrationszwecken */
	
	mein_puffer = NULL;
	
	puffer_groesse = (long) Malloc(-1L) - 50000L; 
			/* Malloc(-1L) liefert gr��ten freien Speicherbereich */
			/* und entspricht 'coreleft()' unter ANSI-C. Dem Rest */
			/* der Welt lassen wir 50000 Bytes. 				  */ 
	
	if (puffer_groesse > 0)
		mein_puffer = (char *) Malloc(puffer_groesse);
		
	if ((mein_puffer != NULL) &&
		(init_memory_manager(mein_puffer,puffer_groesse) == 0L))
	{
		/* Alles Paletti, jetzt kann's los gehen. Die Speicherver-
		   waltung wird nun genauso benutzt, wie die des Betriebs-
		   systems oder von Turbo-C. Z.B.:						   */ 
						
		testpuffer = (char *) hjr_malloc(20);
		/*				.
						.										   */
		langwort_array = (long *) hjr_calloc(30,sizeof(long));
											/* Feld f�r 30 'Longs' */
		/*				.
						.										   */
		temp = hjr_realloc(testpuffer,50);
										 /* Um 30 Bytes vergr��ern */
		if (temp != NULL)
			testpuffer = temp;	 /* K�nnte ja nicht geklappt haben */
		/*				.
						.										   */
		hjr_free(testpuffer);
		/*				.
						.										   */
	}

	Mfree(mein_puffer); /* Am Schlu� wird der gesamte Speicher an  */
						/* das Betriebssystem zur�ckgegeben 	   */
}

