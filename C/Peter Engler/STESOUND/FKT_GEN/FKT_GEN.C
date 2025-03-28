/* ------------------------------------------------------------------- */
/* --- FKT_GEN.C:  Funktionsgenerator f�r den STE                  --- */
/* ---                                                             --- */
/* --- In Turbo-C 2.0 implementiert von Peter Engler               --- */
/* ------------------------------------------------------------------- */



#include <stdio.h>
#include <stdlib.h>
#include <ext.h>
#include <tos.h>
#include <vdi.h>
#include <aes.h>
#include <math.h>

#include "sout.h"



#define MAX_FREQ 	16000	/* --- Maximale Frequenz: 16000 Hz --- */
#define MIN_FREQ	16		/* --- Minimale Frequenz: 16 Hz --- */
#define MAX_LAUT	0		/* --- Maximale Lautst�rke: 0 dB --- */
#define MIN_LAUT    -80		/* --- Minimale Lautst�rke: -80 dB --- */


/* --- Typdeklaration --- */

typedef struct 
{
	int wellenform;		/* --- Wellenform (Sinus, S�gezahn, ... ) --- */
    int freq, sw_freq;  /* --- Frequenz, zug. Schrittweite --- */
    int laut, sw_laut;  /* --- Lautst�rke, zug. Schrittweite --- */
    int start;			
    
} EINSTELLUNG;



/* --- Prototypen der im Modul verwendeten Funktionen --- */

int snd_alloc( SOUND *, unsigned long );
void snd_free( SOUND * );
void saegezahn( SOUND * );
void sinus( SOUND * );
void dreieck( SOUND * );
void rechteck( SOUND * );
void bildschirm_ausgabe( int, EINSTELLUNG * );
void frequenz_ausgabe( int, EINSTELLUNG * );
void lautstaerke_ausgabe( int, EINSTELLUNG * );
int  eingabe_bearbeiten( int, EINSTELLUNG *, SOUND * );
int main( void );



/* --- Anlegen des Arrays f�r die zu wandelnden Bytes --- */

int snd_alloc( SOUND *snd, unsigned long anz )
{
	/* --- Speicherplatz belegen --- */
	snd -> s_ptr = (char *)  malloc( anz ); 

	/* --- Fehler aufgetreten --- */
	if (! snd -> s_ptr)
	{
		snd -> anz_bytes = 0L;
		return( -1 );
	}
	
	/* --- Anzahl Bytes des reservierten Bereichs --- */
	snd -> anz_bytes = anz;
	
	/* --- Anzahl Bytes, die pro Sekunde gewandelt werden --- */	
	switch( snd -> mode_reg & 0x000F )
	{
	
		case MOD_FR50K : snd -> bytes_pro_sekunde = 50066L;
						 break;
		case MOD_FR25K : snd -> bytes_pro_sekunde = 25033L;
						 break;
		case MOD_FR12K : snd -> bytes_pro_sekunde = 12517L;
						 break;
		case MOD_FR6K  : snd -> bytes_pro_sekunde = 6258L;
						 break;
		default 	   : snd -> bytes_pro_sekunde = 0L;
						 break;		
		
	}
	
	
	return( 0 );
}



/* --- Freigeben des Arrays der SOUND-Struktur --- */

void snd_free( SOUND *snd )
{
	free( snd -> s_ptr );
}



/* --- Generieren der Werte f�r einen Sinus --- */

void sinus( SOUND *snd )
{
    unsigned long bytes_pro_periode, index;
    char *h_ptr;
    
    h_ptr = snd -> s_ptr;

    /* --- Berechnen der Bytes, die pro Periode ausgegeben werden --- */    
    bytes_pro_periode = snd -> bytes_pro_sekunde / snd -> frequenz;
    
    if ((bytes_pro_periode % 2) == 1)  bytes_pro_periode++; 
    
    snd -> anz_bytes = bytes_pro_periode;
    
   	/* --- Eintragen der Werte f�r den Sinus in die SOUND-Struktur --- */
   	for (index = 0; index < bytes_pro_periode; index++)
   	{
       	*h_ptr++ = 
       		(char) (127 * sin( 2.0 * M_PI * ((double) index) / (double) bytes_pro_periode) - 1); 
   	}
    
}



/* --- Generieren der Werte f�r einen S�gezahn --- */

void saegezahn( SOUND *snd )
{
    unsigned long bytes_pro_periode, index;
    char *h_ptr;
    
    h_ptr = snd -> s_ptr;
    
    /* --- Berechnen der Bytes, die pro Periode ausgegeben werden --- */
    bytes_pro_periode = snd -> bytes_pro_sekunde / snd -> frequenz;
    
    if ((bytes_pro_periode % 2) == 1)  bytes_pro_periode++; 
    
    
    snd -> anz_bytes = bytes_pro_periode;
    
    /* --- Eintragen der Werte f�r den S�gezahn in die SOUND-Struktur --- */    
    for (index = 0; index < bytes_pro_periode; index++)
    {
        *h_ptr++ = 
           (char) ( 255 * ((double) index) / ((double) bytes_pro_periode ) - 128);
    }
    
}



/* --- Generieren der Werte f�r ein Dreieck --- */

void dreieck( SOUND *snd )
{
    unsigned long bytes_pro_halbperiode, index;
    char *h_ptr;
    
    h_ptr = snd -> s_ptr;
    
    /* --- Berechnen der Bytes, die pro Halbperiode ausgegeben werden --- */
    bytes_pro_halbperiode = (snd -> bytes_pro_sekunde / snd -> frequenz) / 2L;
    
    if ((bytes_pro_halbperiode % 2) == 1)  bytes_pro_halbperiode++; 

    
    snd -> anz_bytes = bytes_pro_halbperiode * 2L;
    
    /* --- Eintragen der Werte f�r das Dreieck in die SOUND-Struktur --- */ 
    for (index = 0; index < bytes_pro_halbperiode; index++)
    {
        *h_ptr++ = 
           (char) ( 255 * ((double) index) / ((double) bytes_pro_halbperiode ) - 128);
    }
    
    for (index = bytes_pro_halbperiode ; index > 0 ; index--)
    {
        *h_ptr++ = 
           (char) ( 255 * ((double) index) / ((double) bytes_pro_halbperiode ) - 128);
    }
    
}



/* --- Generieren der Werte f�r ein Rechteck --- */

void rechteck( SOUND *snd )
{
    unsigned long bytes_pro_halbperiode, index;
    char *h_ptr;
    
    h_ptr = snd -> s_ptr;
    
    /* --- Berechnen der Bytes, die pro Halbperiode ausgegeben werden --- */
    bytes_pro_halbperiode = (snd -> bytes_pro_sekunde / snd -> frequenz) / 2L;
    
    if ((bytes_pro_halbperiode % 2) == 1)  bytes_pro_halbperiode++; 
    
    
    snd -> anz_bytes = bytes_pro_halbperiode * 2L;

    /* --- Eintragen der Werte f�r das Rechteck in die SOUND-Struktur --- */    
    for (index = 0; index < bytes_pro_halbperiode; index++)
    {
        *h_ptr++ = (char) 127;
    }
    
    for (index = bytes_pro_halbperiode ; index > 0 ; index--)
    {
        *h_ptr++ = (char) -128;
    }
    
}



int eingabe_bearbeiten( int handle, EINSTELLUNG *einst, SOUND *snd )
{
/* --- Definition der Scancodes der verwendeten Tasten --- */
#define SINUS       31
#define DREIECK     32
#define SAEGEZAHN   21
#define RECHTECK    19
#define FR_EING     33
#define FR_MINUS    75
#define FR_PLUS     77
#define SCHR_WEITE  17
#define LT_EING     38
#define LT_MINUS    80
#define LT_PLUS     72
#define QUIT        16
#define F1			59
#define F10			68


    int scan_code;
    int ret_code;
    
    ret_code = 0;
    
    /* --- Auf Zeichen von Tastatur warten --- */
    while (! Cconis( ));
        
    /* --- Zeichen einlesen (nur Scancode ber�cksichtigen) --- */
    scan_code = ( Crawcin( ) >> 16 );

	switch( scan_code )
	{
		case QUIT      : ret_code = -1;
					     break;
					     
		case F1		   : einst -> start = 1;
						 break;
						 
		case F10	   : snd_stop( );
						 einst -> start = 0;
						 break;
					     
		case SINUS     : einst -> wellenform = SINUS;
					     break;
					     
		case DREIECK   : einst -> wellenform = DREIECK;
					     break;
					     
		case SAEGEZAHN : einst -> wellenform = SAEGEZAHN;
					     break;
					     
		case RECHTECK  : einst -> wellenform = RECHTECK;
					     break;
					     
		case FR_EING   : 
						{	
							vs_curaddress( handle, 10, 18 );
							v_eeol( handle ); /* --- Zeile ab Cursor l�schen --- */
							scanf( "%d", &(einst -> freq ));
							
							frequenz_ausgabe( handle, einst );
						}
						 break;							
						 
		case FR_MINUS   :  einst -> freq -= einst -> sw_freq;
						  frequenz_ausgabe( handle, einst );
						  break;		
						 
		case FR_PLUS    : einst -> freq += einst -> sw_freq;
						  frequenz_ausgabe( handle, einst );
						  break;
						 
		case SCHR_WEITE : /* --- Bei Schrittweite mu� noch ein weiteres
							     Zeichen eingelesen werden --- */
						{
							int sc;
							
    						/* --- Auf Zeichen von Tastatur warten --- */
    						while (! Cconis( ));
        
    						/* --- Zeichen einlesen (nur Scancode ber�cksichtigen) --- */
    						sc = ( Crawcin( ) >> 16 );
							
							if (sc == FR_EING)
							{
								vs_curaddress( handle, 13, 39 );
								v_eeol( handle ); /* --- Zeile ab Cursor l�schen --- */
								scanf( "%d", &(einst -> sw_freq ) );
							
								frequenz_ausgabe( handle, einst );							
							}
							else
							if (sc == LT_EING)
							{
								vs_curaddress( handle, 20, 39 );
								v_eeol( handle ); /* --- Zeile ab Cursor l�schen --- */
								scanf( "%d", &(einst -> sw_laut ) );
							
								lautstaerke_ausgabe( handle, einst );							
							}
							else 
								fputc (7, stdout);
						}
						break;
		case LT_EING   : 
						{	
							vs_curaddress( handle, 17, 18 );
							v_eeol( handle ); /* --- Zeile ab Cursor l�schen --- */
							scanf( "%d", &(einst -> laut ) );
							
							lautstaerke_ausgabe( handle, einst );
						}
						 break;							
						 
		case LT_MINUS   : einst -> laut -= einst -> sw_laut;
						  lautstaerke_ausgabe( handle, einst );
						  break;		
						 
		case LT_PLUS    : einst -> laut += einst -> sw_laut;
						  lautstaerke_ausgabe( handle, einst );
						  break;
						 
		default			: fputc( 7, stdout );
						  break;
	}    
	
	/* --- Wurde nicht Q gedr�ckt, werden jetzt die Werte in die 
		   SOUND-Struktur geschrieben und ggf. ausgegeben --- */
		   
	if ( ! ret_code	)
	{
		/* --- Frequenz in SOUND-Struktur --- */
		snd -> frequenz = einst -> freq;
		
		/* --- Abh�ngig von der gew�nschten Wellenform werden jetzt
			   die Werte berechnet --- */
		switch( einst -> wellenform )
		{
			case SINUS     : sinus( snd );
						     break;
			case SAEGEZAHN : saegezahn( snd );
							 break;
			case DREIECK   : dreieck( snd );
							 break;
			case RECHTECK  : rechteck( snd );
							 break;
			default		   : snd_stop( );
							 einst -> start = 0;
							 break;
							
		}
		
		/* --- Soll Ton ausgegeben werden ? --- */
		if ( einst -> start )
		{
			snd_laut( einst -> laut ); /* --- Lautst�rke einst. --- */
			snd_play( snd );		   /* --- Ton ausgeben --- */	
		}
	}
    
    return( ret_code );
    
}



/* --- Anzeige der Frequenz auf dem Auswahlbildschirm --- */

void frequenz_ausgabe( int handle, EINSTELLUNG *einst )
{
    char str[20];
    
    /* --- G�ltigkeit der Werte in einst pr�fen --- */
    if (einst -> freq > MAX_FREQ)  einst -> freq = MAX_FREQ;
       else
		if (einst -> freq < MIN_FREQ)  einst -> freq = MIN_FREQ;
		
	vs_curaddress( handle, 10, 18 );   /* --- Cursor setzen --- */
	v_eeol( handle );   /* --- Zeile ab Cursor l�schen --- */
	
    sprintf( str, "%d Hz", einst -> freq);  /* --- Frequenz in str --- */
    v_curtext( handle, str );
}



/* --- Anzeige der Lautst�rke auf dem Auswahlbildschirm --- */

void lautstaerke_ausgabe( int handle, EINSTELLUNG *einst )
{
    char str[20];
    
    /* --- G�ltigkeit der Werte in einst pr�fen --- */
    if (einst -> laut > MAX_LAUT)  einst -> laut = MAX_LAUT;
       else
		if (einst -> laut < MIN_LAUT)  einst -> laut = MIN_LAUT;   
		
	vs_curaddress( handle, 17, 18 );   /* --- Cursor setzen --- */    
	v_eeol( handle );   /* --- Zeile ab Cursor l�schen --- */
	
    sprintf( str, "%d dB", einst -> laut);  /* --- Lautst�rke in str --- */
    v_curtext( handle, str );
}



/* --- Anzeige des Auswahlbildschirms --- */

void bildschirm_ausgabe( int handle, EINSTELLUNG *einst )
{
    char str[20];
    
    /* --- �berschrift --- */
    v_curhome( handle );    /* --- Cursor nach links oben --- */
    v_rvon( handle );       /* --- Text invers --- */
    v_curtext( handle, "                  Funktionsgenerator mit dem DMA-Soundchip                      " );
    
    /* --- verf�gbare Wellenformen --- */
    v_rvon( handle );	/* --- Text invers --- */
    vs_curaddress( handle, 5, 2 );   /* --- Cursor setzen --- */
    v_curtext( handle, " Wellenformen :" );
    v_rvoff( handle );
    v_curtext( handle, " S = Sinus, D = Dreieck, Z = S�gezahn, R = Rechteck" );
    
    
    /* --- Frequenzauswahl --- */
    v_rvon( handle );	/* --- Text invers --- */    
    vs_curaddress( handle, 10, 2 );   /* --- Cursor setzen --- */
    v_curtext( handle, " Frequenz ....:" );
    v_rvoff( handle );      /* --- Text normal --- */
    frequenz_ausgabe( handle, einst );

    vs_curaddress( handle, 11, 18 );   /* --- Cursor setzen --- */
    v_curtext( handle, "F   = Eingabe" );
    vs_curaddress( handle, 12, 18 );   /* --- Cursor setzen --- */
    v_curtext( handle, "Cursor left, right = schrittweise �nderung" );
    vs_curaddress( handle, 13, 18 );   /* --- Cursor setzen --- */
    v_curtext( handle, "WF  = ");
    v_rvon( handle );	/* --- Text invers --- */
    v_curtext( handle, "Schrittweite :" );
    v_rvoff( handle );
    sprintf( str, " %d Hz", einst -> sw_freq);  /* --- Schrittweite in str --- */
    v_curtext( handle, str );
    
    
    /* --- Lautst�rkewahl --- */
    v_rvon( handle );	/* --- Text invers --- */
    vs_curaddress( handle, 17, 2 );   /* --- Cursor setzen --- */
    v_curtext( handle, " Laust�rke ...:" );
    v_rvoff( handle );      /* --- Text normal --- */
    lautstaerke_ausgabe( handle, einst );

    vs_curaddress( handle, 18, 18 );   /* --- Cursor setzen --- */
    v_curtext( handle, "L   = Eingabe" );
    vs_curaddress( handle, 19, 18 );   /* --- Cursor setzen --- */
    v_curtext( handle, "Cursor up, down = schrittweise �nderung" );
    vs_curaddress( handle, 20, 18 );   /* --- Cursor setzen --- */
    v_curtext( handle, "WL  = ");
    v_rvon( handle );	/* --- Text invers --- */
    v_curtext( handle, "Schrittweite :" );
    v_rvoff( handle );
    sprintf( str, " %d dB", einst -> sw_laut);  /* --- Schrittweite in str --- */
    v_curtext( handle, str );
    
    vs_curaddress( handle, 24, 3 );   /* --- Cursor setzen --- */
    v_rvon( handle );    
    v_curtext( handle, " F1 = Start, F10 = Stop " );
    
    vs_curaddress( handle, 24, 69 );   /* --- Cursor setzen --- */
    v_curtext( handle, " Q = Quit " );
    v_rvoff( handle );
     
}



int main( )
{
    SOUND snd;
    EINSTELLUNG einst = { SINUS, 440, 110, 0, 6, 0 };
    int handle, dummy;
    
    /* --- VDI-Handle holen und Bildschirm l�schen --- */
    handle = graf_handle( &dummy, &dummy, &dummy, &dummy );
    v_clrwk( handle );
    /* --- Textmodus einschalten --- */
    v_enter_cur( handle );  
    

	/* --- 'mode_reg' immer vor 1. Aufruf von 'snd_alloc' setzen !! --- */
	snd.mode_reg = MOD_FR50K | MOD_MONO;
	snd.control_reg = SND_IMMER;
	snd.frequenz = einst.freq;    /* --- in Hz --- */
	
	/* --- Array f�r den Frame anlegen --- */
	if (snd_alloc( &snd, 65536L))  return(-1);
	
	snd_init( );
	
    do
    {
        bildschirm_ausgabe( handle, &einst );
        
    } while (! eingabe_bearbeiten( handle, &einst, &snd ) );
    
    
    snd_stop(  );
    v_exit_cur( handle );
    snd_free( &snd );
    
    return( 0 );

}
