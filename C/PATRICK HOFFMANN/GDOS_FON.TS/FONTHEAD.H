typedef struct fonthdr
{
    int id,                         /* Fontnummer                   */
        size;                       /* Fontgr��e in Punkten         */
    char facename[32];              /* Name                         */
    int ade_lo,                     /* kleinster ASCII-Wert         */
        ade_hi,                     /* gr��ter ASCII-Wert           */
        top_dist,                   /* Abstand Top <-> Baseline     */
        asc_dist,                   /* Abstand Ascent <-> Baseline  */
        hlf_dist,                   /* Abstand Half <-> Baseline    */
        des_dist,                   /* Abstand Descent <-> Baseline */
        bot_dist,                   /* Abstand Bottom <-> Baseline  */
        wchr_wdt,                   /* maximale Zeichenbreite       */
        wcel_wdt,                   /* maximale Zeichenzellenbreite */
        lft_ofst,                   /* Offset links                 */
        rgt_ofst,                   /* Offset rechts                */
        thckning,                   /* Verbreiterungsfaktor f�r Bold*/
        undrline,                   /* Dicke der Unterstreichung    */
        lghtng_m,                   /* Maske f�r Light              */
        skewng_m;                   /* Maske f�r Kursiv             */
    struct
    {
        unsigned             :12;   /* Frei                         */
        unsigned mono_spaced : 1;   /* Proportional/Monospaced      */
        unsigned f68000      : 1;   /* 8086-/68000 Format           */
        unsigned hot         : 1;   /* HOT verwenden                */
        unsigned system      : 1;   /* Default system font          */
    }   flags;
    char *hz_ofst;                  /* Horizontal Offset Table      */
    int *ch_ofst;                   /* Font-Offset-Tabelle          */
    void *fnt_dta;                  /* Zeichensatz-Image            */
    int frm_wdt,                    /* Breite des Font-Image        */
        frm_hgt;                    /* H�he des Fonts               */
    struct fonthdr *next;           /* N�chster Font                */
}   FONT_HDR;


