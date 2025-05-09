;
;
; MagiC Device Driver Development Kit
; ===================================
;
; Assembler-Include-Datei f�r Fehlercodes
;
; (C) Andreas Kromke, 1994
;
;

E_OK           EQU    0       ;   0     kein Fehler
ERROR          EQU   -1       ;  -1     allgemeiner Fehler
EDRVNR         EQU   -2       ;  -2     Laufwerk nicht bereit
EUNCMD         EQU   -3       ;  -3     unbekanntes Kommando
E_CRC          EQU   -4       ;  -4     Pr�fsummenfehler
EBADRQ         EQU   -5       ;  -5     Kommando nicht m�glich
E_SEEK         EQU   -6       ;  -6     Spur nicht gefunden
EMEDIA         EQU   -7       ;  -7     unbekanntes Medium
ESECNF         EQU   -8       ;  -8     Sektor nicht gefunden
EPAPER         EQU   -9       ;  -9     kein Papier mehr
EWRITF         EQU  -10       ; -$A     Schreibfehler
EREADF         EQU  -11       ; -$B     Lesefehler
EGENRL         EQU  -12       ; -$C     genereller Fehler (ab TOS 3.06)
EWRPRO         EQU  -13       ; -$D     Schreibschutz
E_CHNG         EQU  -14       ; -$E     unerlaubter Diskwechsel
EUNDEV         EQU  -15       ; -$F     unbekanntes Ger�t
EBADSF         EQU  -16       ; -$10    Verify- Fehler
EOTHER         EQU  -17       ; -$11    Disk wechseln (A<->B)

EINVFN         EQU  -32       ; -$20    ung�ltige Funktionsnummer
EFILNF         EQU  -33       ; -$21    Datei nicht gefunden
EPTHNF         EQU  -34       ; -$22    Pfad nicht gefunden
ENHNDL         EQU  -35       ; -$23    keine Handles mehr
EACCDN         EQU  -36       ; -$24    Zugriff nicht m�glich
EIHNDL         EQU  -37       ; -$25    ung�ltiges Handle
ENSMEM         EQU  -39       ; -$27    zuwenig Speicher
EIMBA          EQU  -40       ; -$28    ung�ltiger Speicherblock
EDRIVE         EQU  -46       ; -$2E    ung�ltiges Laufwerk
ENSAME         EQU  -48       ; -$30    nicht dasselbe Laufwerk
ENMFIL         EQU  -49       ; -$31    keine weiteren Dateien
ELOCKED        EQU  -58       ;          MiNT: Ger�t blockiert
ENSLOCK        EQU  -59       ;          MiNT: Unlock- Fehler
ERANGE         EQU  -64       ; -$40    ung. Dateizeiger- Bereich
EINTRN         EQU  -65       ; -$41    interner Fehler
EPLFMT         EQU  -66       ; -$42    Ung�ltiges Programmformat
EGSBF          EQU  -67       ; -$43    Speicherblock vergr��ert
EBREAK         EQU  -68       ; -$44    KAOS: mit CTRL-C abgebrochen
EXCPT          EQU  -69       ; -$45    KAOS: 68000- Exception

* MiNT- Fehler:

EMOUNT         EQU  -200      ;         liefert path2DD bei root/..

* Mag!X- Fehler

ELINK          EQU  -300      ;         Datei ist symbolischer Link

