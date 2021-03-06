DEFINITION MODULE Text;

(*
 * Dieses Modul stellt die Funktionen zum textuellen Bearbeiten von Dateien
 * zur Verf�gung.
 *)


FROM Files IMPORT File;


PROCEDURE Write (f: File; ch: CHAR);
  (* Schreibt ein Zeichen in die Datei. *)

PROCEDURE WriteString (f: File; REF str: ARRAY OF CHAR);
  (* Schreibt den String in die Datei. *)

PROCEDURE WriteLn (f: File);
  (* Schreibt ein CR (15C) und ein LF (12C) in die Datei. *)

PROCEDURE WritePg (f: File);
  (* Bildschirml�schen bzw. Seitenvorschub (FF, 14C) *)



PROCEDURE EOL (f: File): BOOLEAN;
  (* Liefert TRUE, wenn ein Zeilenende (CR oder LF) beim Lesen aus der
   * Datei mittels 'Read...' erreicht wurde oder die Funktion 'EOF'
   * TRUE liefert.
   *)


PROCEDURE Read (f: File; VAR ch: CHAR);
  (* Holt ein Zeichen aus der Datei. Wenn die Datei nicht auf Disk o.�.
   * er�ffnet ist, wird solange gewartet, bis ein Zeichen zur Verf�gung steht.
   * Wenn die Datei auf 'CON:' er�ffnet ist, werden die eingegebenen Zeichen,
   * sofern sie keine Controlzeichen sind, auf dem Bildschirm ausgegeben.
   *)

PROCEDURE ReadFromLine (f: File; VAR str: ARRAY OF CHAR);
  (* Es wird zeichenweise aus der Datei gelesen, bis der String voll ist
   * oder das Zeilenende erreicht wird. Mit dem Backspace-Zeichen kann
   * das zuletzt eingegebene Zeichen wieder gel�scht werden.
   * Liefert die Funktion 'EOL' danach TRUE, wurde die Eingabe mit <Return>
   * (LF oder CR) beendet, ansonsten war der String vollst�ndig gef�llt.
   * Bei Eingabe von Tastatur werden eingegebene Controlzeichen nicht
   * ausgegeben; nur bei der Return-Taste oder Ctrl-J wird CR/LF ausgegeben.
   *)

PROCEDURE ReadToken (f: File; VAR str: ARRAY OF CHAR);
  (* Es wird zeichenweise aus der Datei gelesen, bis der String voll ist,
   * das Zeilenende erreicht oder ein Trennzeichen eingelesen wird.
   * F�hrende Trennzeichen vor einem Wort ('Token') werden zudem �berlesen
   * und nicht in den String aufgenommen.
   * Diese Trennzeichen sind in MOSConfig.Separators definiert und
   * sind normalerweise alle Control- und das Space- (Leertaste) Zeichen.
   * Mit 'TermCH' kann das Trennzeichen ermittelt werden. Ist dieses
   * Zeichen kein 'Separator', wurde die Eingabe beendet, weil der
   * String vollgelesen war.
   *)

PROCEDURE TermCH (f: File): CHAR;
  (* Liefert das Trennzeichen, das die letzte Eingabe beendete. *)

PROCEDURE UndoRead (f: File);
  (* Die Funktion stellt das zuletzt gelesene Zeichen wieder zur�ck, soda�
   * es beim n�chsten Lesezugriff nochmal erhalten wird.
   * Keinesfalls darf die Funktion zweimal hintereinander aufgerufen werden,
   * ohne da� das zur�ckgestellte Zeichen zwischendurch gelesen wurde. In
   * diesem Fall wird eine sofortige Fehlermeldung ausgel�st.
   *)

PROCEDURE ReadLn (f: File);
  (* �berliest alle Zeichen bis zum Zeilenende (einschlie�lich), h�chstens
   * bis zum Dateiende.
   * Nach dem Aufruf liefert, sofern kein Fehler auftrat, die Funktion 'EOL'
   * FALSE. Erst ein folgender Aufruf von 'Read' oder 'ReadString' erkennt
   * einen evtl. direkt folgenden Zeilenbegrenzer.
   *)


PROCEDURE ReadBin (f: File; VAR ch: CHAR);
  (* Holt ein Zeichen aus der Datei. Entgegen 'Read' wird auch jedes erhal-
   * tene Controlzeichen zur�ckgeliefert, es werden also z.B. keine CR- und
   * LF-Zeichen unterdr�ckt.
   * Wenn die Datei auf 'CON:' er�ffnet ist, werden die eingegebenen Zeichen,
   * sofern sie keine Controlzeichen sind, auf dem Bildschirm ausgegeben.
   *)


PROCEDURE ReadString (f: File; VAR str: ARRAY OF CHAR);
  (* Dies ist eine (ehemalige) mi�lungene Mischung aus ReadFromLine
   * und ReadToken:
   * Sie liest alle Zeichen in den String ein, bis er voll ist oder
   * ein Control-Zeichen gelesen wird.
   * Im Gegensatz zu ReadToken werden also Leerzeichen mit in den
   * String aufgenommen.
   * Wir empfehlen, diese Funktion nicht mehr zu verwenden und stattdessen
   * entweder 'ReadFromLine' oder 'ReadToken' - je nach Bedarf, zu verwenden.
   *)

END Text.
