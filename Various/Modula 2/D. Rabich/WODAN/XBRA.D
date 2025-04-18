DEFINITION MODULE XBRA;

(*
 * Universelle XBRA-Funktionen                        Version 1.1  vom  18.6.89
 *
 * Erstellt von Thomas Tempelmann.
 *
 * Die vorliegende Version ist unter dem Megamax Modula-2-System compilierbar,
 * f�r H�nisch- und SPC-Modula sind nur wenige Anpassungen n�tig.
 *
 * Die vorhandenen Funktionen bieten alles, um auf einfache Weise installierte
 * Vektoren zu erkunden (wahlweise alle oder einen spezifischen) und sie
 * korrekt ein-, bzw. wieder auszutragen.
 *
 * Wurde eine Funktion installiert, kann durch die Funktion 'PreviousEntry' die
 * vorher installierte Routine ermittelt werden. Damit ist es dann m�glich,
 * den Vorg�nger in der Funktion selbst aufzurufen, falls dies n�tig w�re.
 * Die zum Aufrufen notwendigen Funktionen sind jedoch nicht Bestandteil
 * dieser XBRA-Library, da sie erstens Compiler-spezifisch und zweitens
 * sie je nach Anwendung sehr unterschiedlich implementiert werden m�ssen.
 *
 * Die Funktionen sind so ausgelegt, da� sie normalerweise im User-Mode
 * aufgerufen werden und selbst beim Zugriff �ber die Vektoren in den Super-
 * visor-Mode wechseln (das Programm darf sich aber auch bereits im Supervi-
 * sor-Mode befinden). Dies erleichtert dem Programmierer die Anwendung der
 * Funktionen. Da die Anwendungen beim Installieren von Vektoren in der Regel
 * nicht zeitkritisch ausgelegt sein brauchen, sollte man diese Komfortabilit�t
 * dem leichten Zeitverlust durch - meist - zwei statt nur einem Wechsel vom
 * User- in den Supervisor-Mode vorziehen.
 *
 *
 * Hier noch eine allgemeine Beschreibung zur Anwendung der Funktionen:
 *
 * Folgenderma�en sieht eine XBRA-Installation aus:
 *
 *   vector:= 400H; (* z.B. der 'etv_timer'-Vektor *)
 *   IF NOT Installed ('Test', vector, at) THEN
 *     Create (carrier, 'Test', ADDRESS (TestProzedur), entry);
 *     Install (entry, at)
 *   END;
 *
 * 'Installed' pr�ft, ob die Funktion schon mit XBRA-Kennung installiert
 * ist. Wenn nicht, wird mit 'Create' ein XBRA-Header erzeugt, der neben
 * der XBRA-Informationen auch eine Sprunganweisung enth�lt. Der so
 * erzeugte Header wird dann mit 'Install' als erster neuer Vektor
 * eingetragen und die XBRA-Verkettung erzeugt.
 *
 * Da je nach Implementation verschiedene Prozeduren mit beliebigen
 * Parametern verwendet werden k�nnten, und der XBRA-Header nur einfach
 * dazwischengesetzt wird, ist die Prozeduradresse 'call' als ADDRESS
 * deklariert. F�r die korrekte Parameter�bergabe haben nicht die XBRA-
 * Funktionen zu sorgen, sondern schon die Routine, die zu installierende
 * Funktion �ber den Vektor aufruft.
 *
 * Zum Vergleich obige Installation ohne XBRA:
 *   vector:= 400H;  (* VAR vector: POINTER TO ADDRESS *)
 *   vector^:= ADDRESS (TestProzedur);
 * Falls es Probleme gibt, sollte erst das Programm ohne XBRA zum Laufen
 * gebracht werden, und dann erst die XBRA-Installation eingef�gt werden.
 * Z.B. ist beim Megamax-System zu beachten, da� normalerweise Installationen
 * �ber externe Vektoren �ber die Funktionen aus dem Modul 'Calls' vorgenommen
 * werden sollten. Dies bleibt auch so, wenn dann die XBRA-Funktionen zuhilfe
 * genommen werden!
 *
 * Soll die Funktion sp�ter wieder aus der Vektor-Kette ausgeh�ngt werden,
 * geht das so:
 *
 *   IF Installed ('Test', vector, at) THEN
 *     Remove (at)
 *   END
 *
 * Bei 'PreviousEntry' (s.o.) wird der bei 'Create' erhaltene 'entry'-Wert
 * wieder �bergeben, um z.B. in 'TestProzedur' den Vorg�nger zu
 * ermitteln und dann ggf. aufzurufen.
 *
 * 'Query' dient dazu, alle installierten XBRA-Kennungen einer Vektor-
 * Kette zu ermitteln. Dabei k�nnen auch z.B. mit folgender Routine alle
 * installierten XBRA-Vektoren ausgeh�ngt werden:
 *
 *   PROCEDURE step (at: ADDRESS; name: ID): BOOLEAN;
 *     BEGIN
 *       (*
 *        * Hier k�nnten der jeweilige Vorg�nger mit
 *        *  'PreviousEntry ( Entry (at) )'
 *        * oder die Adr. der aufgerufenen Prozedur mit
 *        *  'Called (at)'  ermittelt und angezeigt werden.
 *        *)
 *       IF prev # NIL THEN (* ist dies ein XBRA-Eintrag? *)
 *         Remove (at)      (* -> nur dann kann er entfernt werden *)
 *       END;
 *       RETURN TRUE        (* weitermachen, solange die Kette weitergeht *)
 *     END step;
 *
 *   PROCEDURE RemoveAll (vector: ADDRESS);
 *     BEGIN Query (vector, step) END RemoveAll;
 *
 *)

FROM SYSTEM IMPORT ADDRESS;

TYPE

  ID = ARRAY [0..3] OF CHAR;            (* String zur Aufnahme der Kennung *)

  JmpCarrier = RECORD                   (* Interne Datenstruktur!     *)
                 jmpInstr: CARDINAL;    (*  - nicht darauf zugreifen! *)
                 operand: ADDRESS
               END;

  Carrier = RECORD      (* Interne Datenstruktur - nicht darauf zugreifen! *)
              magic: ID;                (* CONST 'XBRA' *)
              name : ID;                (* individuelle Kennung *)
              prev : ADDRESS;           (* voriger Vektor *)
              entry: JmpCarrier;
            END;

  QueryProc = PROCEDURE ( (* at  : *) ADDRESS,
                          (* name: *) ID      ): (* continue: *) BOOLEAN;


(*
 * Funktionen f�r die XBRA-Installation
 * ------------------------------------
 *)

PROCEDURE Create (VAR use: Carrier; name: ID; call: ADDRESS;
                  VAR entry: ADDRESS);
  (*
   * Erzeugt einen XBRA-Header mit einer Sprunganweisung zur Prozedur 'call'.
   * Achtung: die Carrier-Variable mu� global (statisch) deklariert sein -
   *   sie mu� so lange erhalten bleiben, wie die XBRA-Einbindung besteht!
   * Der erhaltene 'entry'-Wert kann daraufhin mittels der Prozedur 'Install'
   * in den gew�nschten Vektor eingetragen werden.
   *)

PROCEDURE Installed (name: ID; vector: ADDRESS; VAR at: ADDRESS): BOOLEAN;
  (*
   * Wird 'name' in Kette ab 'vector' gefunden, enth�lt 'at' die Adresse
   * des Vektors auf den Funktionseinsprung (welcher Teil von 'Carrier' ist).
   * Wird 'name' nicht gefunden, ist 'at'=vector
   *)

PROCEDURE Install (entry: ADDRESS; at: ADDRESS);
  (*
   * F�gt einen XBRA-Header 'entry' im Vektor 'at' ein. Der alte Vektorinhalt
   * wird im XBRA-Header gesichert und kann mittels 'PreviousEntry' abgefragt
   * werden.
   *)

PROCEDURE Remove (at: ADDRESS);
  (*
   * F�gt den XBRA-Header, auf den der Vektor bei 'at' zeigt, aus.
   * In den Vektor wird wieder der Vorg�nger eingetragen.
   *)

(*
 * Funktionen zum Abfragen XBRA-Informationen
 * ------------------------------------------
 *)

PROCEDURE Query (vector: ADDRESS; with: QueryProc);
  (*
   * Ruft 'with' f�r alle im Vektor 'vector' installierten Funktionen auf,
   * solange sie durch XBRA-Strukturen verbunden sind.
   * Die 'with'-Funktion kann 'FALSE' zur�ckgeben, um die Aufrufe vorzeitig
   * zu beenden.
   *)

PROCEDURE Entry (at: ADDRESS): ADDRESS;
  (*
   * Liefert die Adresse, auf die der Vektor 'at' zeigt.
   * Dies ist der "Entry", vor dem ggf. die XBRA-Struktur steht.
   * Das Ergebnis dieser Funktion kann z.B. f�r die 'PreviousEntry'-Funktion
   * verwendet werden, sollte jedoch nicht zur rein informativen Ermitttelung
   * der in 'at' installierten Funktion verwendet werden - daf�r ist 'Called'
   * (s.u.) vorgesehen!
   *)

PROCEDURE PreviousEntry (entry: ADDRESS): ADDRESS;
  (*
   * Liefert den "Entry", der vor dem angegebenen "Entry" installiert ist.
   * Diese Funktion kann z.B. in der eigenen installierten Funktion dazu
   * benutzt werden, den Vorg�nger aufzurufen (hier sollte aus Effizienz-
   * gr�nden nicht 'Called' verwendet werden), um eine Aufrufkette zu reali-
   * sieren (ist z.B. beim 200Hz-Vektor sinnvoll, da hier mehrere Routinen
   * hintereinander installiert werden, die alle sich nacheinander aufrufen).
   * Zu diesem Zweck mu� dann der bei 'Create' erhaltene 'entry'-Wert �ber-
   * geben werden. Achtung: Da damit gerechnet werden mu�, da� w�hrend der
   * Lebzeit des Programms im Speicher die XBRA-Verkettung jederzeit ver-
   * �ndert werden kann, darf nicht einmalig fest die Vorg�ngeradr. abgefragt
   * und dann �ber eine Programmlokale Variable adressiert werden, sondern
   * mu� immer genau dann, wenn sie ben�tigt wird, mit dieser Funktion ab-
   * gefragt werden. Es sind dabei keine nennenswerten Zeitverluste zu be-
   * f�rchten.
   * Wenn 'entry'=NIL, oder kein Vorg�nger ermittelt werden kann (keine XBRA-
   * Struktur vorhanden), wird NIL geliefert.
   *)

PROCEDURE Called (at: ADDRESS): ADDRESS;
  (*
   * Liefert die korrekte Programmeinsprungstelle, die �ber den Vektor 'at'
   * erreicht wird. Dies w�re normalerweise identisch mit dem Ergebnis der
   * 'Entry'-Funktion, jedoch wird hier erkannt, wenn diese "Entry"-Stelle
   * nur die von diesem Modul erzeugte Sprunganweisung in die eigentliche
   * Funktion ist, die bei der 'Install'-Funktion angegeben wurde. Dann
   * wird jene Funktionsadresse geliefert.
   *)

END XBRA.
