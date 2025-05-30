/* SND Headerfile zur SND Konvertierung      */
/* Modulname:  SND.H                         */
/* (c) MAXON Computer 1994                   */
/* Autoren:    H. Sch�nfeld, B. Spellenberg  */

typedef struct
{
   long magic;        /* Headerkennung       */
   long datalocation; /* Sampledaten Beginn  */
   long datasize;     /* Datenl�nge in Bytes */
   long dataformat;   /* Datenformat s.u.    */
   long samplingrate; /* Frequenz            */
   long channelcount; /* Kanalanzahl         */
   char info[4];      /* optionale Info      */
} SNDHEAD;

/* M�gliche Datenformate f�r VLUN            */
# define SND_FORMAT_MULAW_8   1
# define SND_FORMAT_LINEAR_8  2
# define SND_FORMAT_LINEAR_16 3

