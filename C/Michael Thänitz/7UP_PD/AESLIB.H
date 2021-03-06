/*
 * AES-Lib  V0.07
 *
 * started    : 17.02.92 (wb)
 * last change: 06.03.92 (wb)
 *
 * Versionen
 *---------------------------------------
 * 0.03  vom 23.02.92
 * 0.04  vom 27.02.92
 *       -  EvntMulti() erg�nzt
 * 0.05  vom 03.03.92
 *       -  Stackoffsetfehler in evnt_multi() entfernt
 *       -  verdrehte Objektreihenfolge bei form_keybd()
 *          ber�cksichtigt
 * 0.06  vom 04.03.92
 *       -  "�ffentlichen" AES-Handler _crystal() hinzugef�gt
 * 0.07  vom 06.03.92
 *       -  variable Parameteranzahl des TC/PC-Bindings bei
 *          wind_get() ber�cksichtigt (Abweichung von DR-Binding!)
 */

/****** AESparams *******************************************************/

/* Die AES-Arrays */
typedef struct
{
    int    contrl[5];
    int    global[12];
    int    intin[16];
    int    intout[8];
    void   *addrin[4];
    void   *addrout[1];
} GEMPARBLK;

extern  GEMPARBLK _GemParBlk;
extern  int       _app;

/* Der AES-Parameterblock  */
typedef struct
{
   int   *contrl;
   int   *global;
   int   *intin;
   int   *intout;
   int   *addrin;
   int   *addrout;
} AESPB;

/********* zus�tzliche Funktionen ***************************************/

/*
 * �berpr�fe, ob AES vorhanden ist
 *
 * R�ckgabewerte: d0 = ap_id, wenn AES vorhanden
 *                d0 = -1, wenn AES nicht vorhanden
 */
int   vq_aes( void );

/*
 * AES-Handler
 */
void _crystal( AESPB *aespb );

/************************************************************************/

