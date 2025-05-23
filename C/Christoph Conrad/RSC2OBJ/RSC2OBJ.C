/**************************************************************************
 * RSC2OBJ.TTP - geschrieben in Turbo-C 1.0
 *               Mai 1990 Christoph Conrad
 *
 * KOMMANDOZEILE: infile outfile labelname [-r]
 *
 * FUNKTION: Konvertiert die Datei infile in eine Objectdatei namens
 *           outfile im Digital Research Objectformat. Das komplette
 *           infile wird dabei als DATA-Segment deklariert und kann
 *           �ber die Adresse der Public-Definition (des externen Labels)
 *           labelname referenziert werden.
 *
 *           Ist der optionale Parameter -r angegeben, muss es sich beim
 *           infile um eine Resourcedatei handeln. Dann werden zus�tzlich
 *           alle ob_spec-Zeiger auf TEDINFO/ICONBLK/BITBLK-Strukturen
 *           als zu relozierend vermerkt, die Zeiger innerhalb dieser
 *           Strukturen, die Indize der Objectbaumtabelle, der
 *           Freestringtabelle, der Freeimagestabelle sowie die bi_pdata-
 *           Zeiger der Freeimages.
 *           Dies bewirkt, das beim Laden des Programmes durch den
 *           GEMDOS-Loader diese Referenzen automatisch auf die absoluten
 *           Speicheradressen angepasst werden. Als einzige Arbeit bleibt
 *           die Umrechnung von Zeichen- in Pixelkoordinaten mittels
 *           rsrc_obfix(...).
 *           Der labelname wird immer auf 8 Zeichen begrenzt und in
 *           Grossbuchstaben konvertiert.
 *
 * Ben�tigte Bibliotheken: TOS- und Standardlib.
 */

#include <tos.h>
#include <aes.h>

typedef unsigned long size_t;

extern void exit(int status);
extern char *strupr(char *s);
extern int  toupper(int c);
extern int  atexit(void (*func)());

typedef enum{false, true} bool;

/* Vor der R�ckkehr des Programmes zum Desktop
 * wird auf einen Tastendruck gewartet, damit
 * alle Meldungen gelesen werden k�nnen.
 */
void holdScreen(void) {Cconws("\r\n<Press any key>"); Crawcin();}

/* Ausgabe von count Nullbytes auf die Datei FILE* file */
bool fputNull(int count, int file)
{   int byte;

    for(byte = 0; byte < count; ++byte)
        if(Fwrite(file, 1L, "") != 1L)
            return false;
    return true;
}

int main
    (int    argc,       /* Anzahl �bergebener Parameter + 1 */
     char   *argv[])    /* Einzelne Parameter (ab argv[1]) als String */
{
    int  in, out;           /* Ein/Ausgabedatei - Filedeskriptoren */
    bool rscReloc = false;  /* RSC-Dateikonvertierung ? */
    long length;            /* L�nge der Eingabedatei */
    char *inbuf;            /* Zeiger auf Einlesebuffer f�r Eingabedatei */
    int  *outbuf;           /* Zeiger auf Buffer f�r Fixup-table */
  /* Allgemeiner Schleifenindex, long wegen L�schen des outbuf (s.u.) */
    long i;


  /* Bei Programmabschluss soll der Ausgabebildschirm bis zu
   * einem Tastendruck erhalten bleiben.
   */
    atexit(holdScreen);

  /* Anzahl der �bergabeparameter checken */
    if(!(4 <=argc && argc <= 5)) goto Usage;

  /* �ffnen der Eingabedatei */
    if((in = Fopen(argv[1], 0)) < 0) goto InfileOpen;

  /* �bergabeparameter "-r": Relocation einer RSC-Datei an */
    if(argv[4] && argv[4][0] == '-' && toupper(argv[4][1]) == 'R')
        rscReloc = true;

  /* Dateil�nge der Eingabedatei ermitteln */
    if((length = Fseek(0L, in, 2)) <= 0 || Fseek(0L, in, 0) != 0)
        goto InfileLen;

  /* Buffer f�r Eingabedatei allokieren... */
    if(!(inbuf = (char*) Malloc(length))) goto Malloc;

  /* ...und Datei einlesen */
    if(Fread(in, length, inbuf) != length) goto InfileRead;

  /* Test, ob (bei Angabe des Flags -r, Resourcedatei konvertieren)
   * die im RSC-Dateiheader abgelegte Dateil�nge mit
   * der tats�chlichen L�nge �bereinstimmt.
   */
    if(rscReloc && ((int*)inbuf)[17] != length) goto NoRSCFile;

  /* �ffnen der Ausgabedatei */
    if((out = Fcreate(argv[2], 0)) < 0) goto OutfileCreate;

  /* Objectdatei-Magic setzen */
    if(Fwrite(out, 2, "\x60\x1A") != 2) goto Write;

  /* CODE-L�nge == 0 */
    if(!fputNull(4, out)) goto Write;

  /* DATAl�nge = Gr�sse der Eingabedatei */
    if(Fwrite(out, sizeof(long), &length) != sizeof(long))
        goto Write;

  /* 4 Nullbytes f�r BSSl�nge
   * 3 Nullbytes + 14 (L�nge der Symboltabelle als Long, ein Eintrag
   * in der Symboltabelle = 14 Bytes)
   */
    if(!fputNull(7, out)) goto Write;
    if(Fwrite(out, 1L, "\016") != 1L) goto Write;

  /* Zehn reservierte Bytes (Null) */
    if(!fputNull(10, out)) goto Write;

  /* DATA == Eingabedatei schreiben */
    if(Fwrite(out, length, inbuf) != length) goto Write;

  /* Der Desktop wandelt ihm �bergebene Kommandozeilen bei
   * TTP-Programmen immer in Grossbuchstaben!! strupr hier,
   * damit auch bei Kommandozeileninterpretern, die dies evt.
   * nicht machen, das gleiche Programmverhalten auftritt.
   */
    strupr(argv[3]);

  /* Eintrag in der Symboltabelle
   * Labelname (8 Bytes) + (0xA400 == Defined global in DATA-Segment)
   */
    for(i = 0; argv[3][i] && i < 8; ++i)
        if(Fwrite(out, 1L, &argv[3][i]) != 1L) goto Write;
    for(; i < 8; ++i)
        if(Fwrite(out, 1L, "") != 1L) goto Write;

  /* 0xA400 == defined global symbol in DATA-Segment */
    if(Fwrite(out, 1L, "\xA4") != 1L) goto Write;
  /* Ein Nullbyte von 0xA400, vier Nullbytes Symbolwert */
    if(!fputNull(5, out)) goto Write;

    if(!(outbuf = (int*) Malloc(length)))
    {   Fdelete(argv[2]);    /* Ausgabedatei l�schen */
        goto Malloc;
    }
    for(i = 0; i < length; ++i) ((char*)outbuf)[i] = 0;

    if(rscReloc)
      /* Resourcedatei, Fixuptabelle aufbereiten */
    { /* Zeiger auf Resourcedateiheader */
        RSHDR *rsc = (RSHDR*) inbuf;
      /* Zeiger auf erstes Object */
        OBJECT *obj = (OBJECT*) (rsc->rsh_object + (long) rsc);
      /* Gesamtzahl der Objecte */
        int nrObj = rsc->rsh_nobs;
      /* Gesamtzahl der Objektb�ume */
        int nrObjTrees = rsc->rsh_ntree;
      /* Gesamtzahl der Freestrings */
        int nrFreeStr = rsc->rsh_nstring;
      /* Gesamtzahl der Freeimages */
        int nrFreeImg = rsc->rsh_nimages;
      /* Abstand eines zu relozierenden Wertes vom Resourcedateistart
       * in sizeof(int) (sizeof(int), da int *outbuf)
       */
        int dist;

      /* Das Fixup-Info sieht HIER immer gleich aus: Die Tabelle
       * enth�lt f�r jedes Long des DATA-Segments (== RSC-Datei)
       * einen Wert, wobei ein 0L (wegen dem calloc) vorgegeben ist
       * und "keine Relokation" bedeutet.
       * F�r alle zu relozierenden Longs wird eine 0x00050001 eingetragen,
       * wobei das Highword f�r 'relocatable', das Lowword f�r 'in DATA-
       * Segment' steht.
       */

      /* Objektbaumtabelleneintr�ge */
        dist = rsc->rsh_trindex / 2;
        for(i = 0; i < nrObjTrees; ++i)
        {   outbuf[dist++] = 5;
            outbuf[dist++] = 1;
        }

      /* Freestringtabelleneintr�ge */
        dist = rsc->rsh_frstr / 2;
        for(i = 0; i < nrFreeStr; ++i)
        {   outbuf[dist++] = 5;
            outbuf[dist++] = 1;
        }

      /* Freeimagestabelleneintr�ge + zugeh�rige BITBLK's */
        dist = rsc->rsh_frimg / 2;
        for(i = 0; i < nrFreeImg; ++i)
        {   int bi_pdataDist =
                ( (long*) (rsc->rsh_frimg + (long) rsc) )[i] / 2;

          /* bi_pdata-Zeiger in BITBLK's */
            outbuf[bi_pdataDist++] = 5;
            outbuf[bi_pdataDist] =   1;

          /* Tabelleneintr�ge */
            outbuf[dist++] = 5;
            outbuf[dist++] = 1;
        }

      /* Alle Objekte durchgehen */
        for(i = 0; i < nrObj; ++i)
        { /* Bei ob_type extended-Flags (Bits 8..15) ausblenden */
            int ob_type = obj[i].ob_type &0xFF;
            int j;  /* Lokaler Schleifenindex */

          /* Anpassung der ob_spec-Zeiger */
            switch(ob_type)
            {
            case 21: case 22: case 23: case 26: case 28:
            case 29: case 30: case 31: case 32:
                dist = ((long) &obj[i].ob_spec - (long) rsc) / 2;
                outbuf[dist++] = 5;
                outbuf[dist]   = 1;
            }

          /* Anpassung der Zeiger in TEDINFO/ICONBLK/BITBLK-Strukturen */
            switch(ob_type)
            {
            case 21: case 22: case 29: case 30: case 31:
              /* TEDINFO/ICONBLK */
                dist = (long) obj[i].ob_spec / 2;
                for(j = 0; j < 3; j++)
                {   outbuf[dist++] = 5;
                    outbuf[dist++] = 1;
                }
                break;
            case 23:
              /* BITBLK */
                dist = (long) obj[i].ob_spec / 2;
                outbuf[dist++] = 5;
                outbuf[dist]   = 1;
            }
        }
    }

 /* Fixup-Tabelle schreiben */
    if(Fwrite(out, length, outbuf) != length) goto Write;

    Fclose(in);
    Fclose(out);

    Cconws("Alles paletti!");
    return false;

    Usage:
    Cconws("Falsche Anzahl Parameter!\r\n");
    Cconws("RSC2OBJ infile outfile labelname [-r]");
    exit(1);

    InfileOpen:
    Cconws(argv[1]); Cconws(" konnte nicht ge�ffnet werden!");
    exit(2);

    InfileLen:
    Cconws(argv[1]); Cconws(": Fehler beim Ermitteln der Dateil�nge!");
    exit(3);

    Malloc:
    Cconws("Zuwenig Speicher!");
    exit(4);

    InfileRead:
    Cconws(argv[1]); Cconws(": Fehler beim Einlesen!");
    exit(5);

    NoRSCFile:
    Cconws(argv[1]); Cconws(": Keine RSC-Datei oder fehlerhaft!");
    exit(6);

    OutfileCreate:
    Cconws(argv[2]); Cconws(" konnte nicht ge�ffnet werden!");
    exit(7);

    Write:
    Cconws("Fehler beim Schreiben!");
    Fdelete(argv[2]);
    exit(8);
}
