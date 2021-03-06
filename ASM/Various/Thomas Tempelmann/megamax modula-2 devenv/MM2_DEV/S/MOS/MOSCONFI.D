DEFINITION MODULE MOSConfig;

(*
 * Enth�lt globale Konfigurationswerte f�r die MOS-Module.
 * Die Werte werden den meisten Variablen im Implementationsteil
 * zugewiesen, die standardm��ig eingesetzten Werte stehen in Klammern.
 * Restliche Variablen werden z.B. in 'GEMError' initialisiert, falls
 * dies mitgelinkt wird.
 *)

FROM SYSTEM     IMPORT ADDRESS;
FROM SysTypes   IMPORT CHARSET, ExcSet;
FROM MOSGlobals IMPORT SfxStr;

(* Loader: *)

VAR DftSfx: SfxStr; (* Default Suffix bei 'CallModule' ("MOD") *)

    ImpSfx: SfxStr; (* Suffix der importierten Module  ("IMP") *)

    MaxModExec: CARDINAL; (* Max. Anzahl gleichz. startbarer Module (100) *)

    LoaderMsg: POINTER TO ARRAY [0..24] OF ARRAY [0..49] OF CHAR;
      (* Texte f�r Loader-Fehlermeld., wird z.B. in 'GEMError' init. *)


(* Convert: *)

VAR RadixChar: CHAR;
  (*
   * Wird bei den REAL-Umwandlungen in Textform zur Trennung der
   * Nachkommastellen verwendet. (",")
   * US-Norm: RadixChar:='.' / Deutsch: RadixChar:=',';
   *)

VAR FixToFloatMax, FixToFloatMin: LONGREAL;
  (*
   * Diese Variablen w�hlen die Darstellungsform von REAL-Zahlen bei
   * Umwandlung mit 'ConvReal' oder Ausgabe mit 'WriteReal':
   * Festkomma, falls FixToFloatMin<=ABS(v) und ABS(v)<=FixToFloatMax,
   * sonst Flie�komma.
   *)


(* TimeConvert: *)

VAR StdDateExp: CARDINAL;               (* (1) *)

VAR StdDateMask: ARRAY [0..31] OF CHAR; (* ('DD.MM.YYYY') *)

VAR StdTimeExp: CARDINAL;               (* noch unbenutzt *)

VAR StdTimeMask: ARRAY [0..9] OF CHAR;  (* ('HH:MM:SS') *)

VAR NameOfMonth: ARRAY [1..12] OF ARRAY [0..9] OF CHAR;
  (*
   * Diese Monatsnamen werden verwendet, wenn die Datumsmaske
   * "#UUU..." enth�lt (s. TimeConvert.DateToText).
   *)


VAR Separators: CHARSET;
  (*
   * Trennzeichen f�r ReadToken und die Read-Funktionen aus NumberIO.
   * Beim Lesen werden f�hrende Trennzeichen ignoriert (ausgefiltert),
   * soda� ein mit ReadToken gelesener String nie ein Trennzeichen
   * enthalten kann.
   *
   * Standardwert:  CHARSET {0C..' '};
   *   (das sind alle Control-Zeichen sowie das Leerzeichen)
   *)


(* Exceptions, ErrBase, HdlError *)

VAR RuntimeErrMsg: ADDRESS;
  (*
   * Zeigt auf ein dynamisch gro�es Feld mit Texten f�r m�glichst alle
   * in 'MOSGlobals' definierten Laufzeitfehler.
   * Format siehe 'FileErrMsg'.
   *)


(* Files, Directories *)

VAR FileErrMsg: ADDRESS;   (* POINTER TO ARRAY [0..65535] OF RECORD
                                errNo: INTEGER;
                                errMsg: ARRAY [0..31] OF CHAR
                              END; *)
  (*
   * Zeigt auf ein dynamisch gro�es Feld mit Texten f�r m�glichst alle
   * in 'MOSGlobals' definierten Dateifehler.
   *
   * Format:
   * Die Anzahl der Feldelemente ist um Eins gr��er als die Anzahl benutzter
   * Meldungstexte, dabei m�ssen hintereinander alle Fehlernummern in belie-
   * biger Reihenfolge mit ihren zugeh�rigen Texten stehen, als Abschlu�
   * dann eine beliebige Fehlernummer mit einem Leertext. Wird ein Text f�r
   * eine nicht vorkommende Fehlernummer gesucht, wird, jenachdem, ob die
   * Fehlernummer positiv oder negativ ist, der Text f�r Fehlernummer
   * 32767 bzw. -32768 verwendet.
   * Wenn ein Text das Zeichen '@' enh�lt, wird daf�r die Fehlernummer ein-
   * gesetzt.
   * Ein Beispiel f�r ein solches Textfeld findet sich in dem Modulsource
   * 'GEMError.I'.
   *)


(* ErrBase: *)

VAR CaughtExceptions: ExcSet;
  (*
   * Bestimmt, welche Exceptions abgefangen werden sollen.
   * (TRAP #6, �berlauf, Bus-Fehler, Adre�-Fehler, Illegale Instruktion)
   *)

VAR IgnoreExceptions: ExcSet;
  (*
   * Bestimmt, welche von den abzufangenden Exceptions zeitweise nicht
   * behandelt werden sollen. Damit ist es m�glich, kurzzeitig von einem
   * zuvor installierten Monitor die Exception behandeln zu lassen.
   *)


(* Storage/StorBase: *)

VAR MaxBlSize: LONGINT;                         (* (0) *)
  (*
   * Mindestgr��e der bei StorBase (GEMDOS) angeforderten Bl�cke.
   * Beim Wert Null bestimmt Storage selbst den optimalen Wert
   * (Verf�gbarer Speicher DIV 40). Maximalwert: 7F00H.
   * Normalerweise nicht ver�ndern!
   *)

VAR ExtendedMemoryAccess: BOOLEAN;              (* (TRUE) *)
  (*
   * Bestimmt, ob StorBase in die Speicherverwaltung des GEMDOS eingreifen
   * darf. Mehr dazu im Modul StorBase.
   *)


(* Runtime/Coroutinen: *)

VAR CoroutineTrapNo: [0..15];                   (* (4) *)
  (*
   * Werden Coroutinen benutzt, mu� das Modula-System dazu einen TRAP-Vektor
   * belegen. Der gew�hlte TRAP-Vektor darf w�hrenddessen nicht von anderen
   * Programmen benutzt werden. Soll ein anderer TRAP als der voreingestellte
   * verwendet werden, mu� diese Variable lediglich vor dem ersten Aufruf
   * von NEWPROCESS entsprechend gesetzt werden. Beim ersten NEWPROCESS
   * wird der TRAP-Vektor dann belegt und wird erst bei Beenden des Programms
   * wieder freigegeben (der vorherige Wert wird restauriert). Werden Corou-
   * tinen in residenten Programmen oder Accessories verwendet, bleibt der
   * Vektor dauerhaft belegt. Sollen mehrere Megamax-Programme mit Coroutinen
   * gleichzeitig im Speicher sein (z.B. als ACCs), d�rfen sie ruhig alle
   * den selben TRAP-Vektor benutzen.
   * Protos benutzt beispielsweise auch den TRAP Nr. 4 mit der selben
   * Funktion. So gibt es mit diesem residenten Programm keine Probleme.
   *
   * Bei Installation des TRAP-Vektors wird die XBRA-Kennung "MM2C" verwendet.
   *)

END MOSConfig.
