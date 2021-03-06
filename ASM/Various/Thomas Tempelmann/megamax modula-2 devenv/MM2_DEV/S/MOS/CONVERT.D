DEFINITION MODULE Convert;

(*
 * Grundmodul zur Umwandlung von CARDINAL/INTEGER/REAL-Werten in
 * die Textdarstellung und umgekehrt.
 *)

(*$H+  >> erlaubt auch lokale Prozeduren als 'GetProc' *)

FROM SYSTEM IMPORT ADDRESS, LONGWORD, WORD;


TYPE GetInfo = RECORD
                 ch     : CHAR;     (* Hier geh�rt das Zeichen hin *)
                 userPtr: ADDRESS;  (* F�r eigene Verwendung *)
               END;
     
     GetProc = PROCEDURE ( VAR GetInfo );


PROCEDURE ConvToLCard ( get: GetProc; VAR info: GetInfo;
                        VAR valid : BOOLEAN ): LONGCARD;

PROCEDURE ConvToCard  ( get: GetProc; VAR info: GetInfo;
                        VAR valid: BOOLEAN ): CARDINAL;

PROCEDURE ConvToLInt  ( get: GetProc; VAR info: GetInfo;
                        VAR valid: BOOLEAN ): LONGINT;

PROCEDURE ConvToInt   ( get: GetProc; VAR info: GetInfo;
                        VAR valid: BOOLEAN ): INTEGER;

  (*
     'get' bestimmt eine Zeichenhol-Funktion, die jeweils ein Zeichen
     in 'info.ch' ablegt. Wenn keine Zeichen mehr vorhanden sind, sollte
     das Zeichen 0C darin abgelegt werden. 'info.userPtr' wird von den
     'ConvTo...'-Funktionen nicht ben�tigt, sie kann zum Datenaustausch
     zw. dem Aufrufer und der Funktion 'get' dienen. Das 'info'-Record
     wird nicht ver�ndert.
     
     Wenn 'valid' nach dem Aufruf FALSE ist, bedeutet das, da� der
     erwartete Wert nicht ermittelt werden konnte.
     
     F�r die vier ConvTo...-Funktionen gilt:
     
     - f�hrende Blanks und TABs werden ignoriert, innerhalb der Zahl
       d�rfen dann keine Leerzeichen mehr vorkommen.
     - ein eventuell vorangestelltes '+' wird ignoriert.
     - Pr�fixe steuern die Interpretation der folgenden Zeichen:
       '$' f�r Hexadezimal, '%' f�r Bin�r, kein Pr�fix bedeutet
       dezimal.
     - Bei ConvToInt bzw. ConvToLInt mu� das '-' zuerst stehen, erst
       dann darf der Pr�fix folgen
       
     Beispiele: ConvToCard ('  123 12') = 123
                ConvToLInt ('-$80') = -128L
  *)


PROCEDURE ConvToLNum (     get   : GetProc;
                       VAR info  : GetInfo;
                           base  : CARDINAL; (* [2..36] *)
                       VAR valid : BOOLEAN ): LONGCARD;

PROCEDURE ConvToNum (    get   : GetProc;
                     VAR info  : GetInfo;
                         base  : CARDINAL; (* [2..36] *)
                     VAR valid : BOOLEAN ): CARDINAL;
  (*
     Diese beiden Funktionen werten eine Zahl zur Basis 'base' aus.
     Dabei mu� 'base' zwischen einschlie�lich 2 und 36 liegen (sonst
     liefert valid FALSE).
     Die Ziffern 10 bis 36 m�ssen dabei durch die Buchstaben 'A' bis 'Z'
     dargestellt sein. Die Buchstaben d�rfen gro� und klein sein.
     Die Zahlen d�rfen kein Vorzeichen und keinen Pr�fix ('$' oder '%')
     haben.
     F�hrende Blanks und TABs werden ignoriert.
  *)

PROCEDURE ConvToReal ( get: GetProc; VAR info: GetInfo;
                       VAR valid: BOOLEAN ): LONGREAL;

  (*
    ConvToReal liefert den Wert einer reellen Zahl. Dabei darf entweder der
    Nachkommateil (einschlie�lich '.') oder der Vorkommateil fehlen. Ebenfalls
    braucht kein Exponent angegeben werden. Ein eventueller Skalierungsfaktor
    wird durch ein vorangestelltes 'E' erkannt und darf im Bereich von -1232
    bis +1232 liegen.
    
    Es gilt:
    
    - f�hrende Blanks und TABs werden ignoriert, innerhalb der Zahl d�rfen
      dann keine Leerzeichen mehr vorkommen.
    - ein eventuell vorangestelltes '+' wird ignoriert.
    
    z.B. : ConvToReal ('123E12') = 1.23 E14
           ConvToReal ('.012E-23') = 1.2 E-25
  *)



(* ======================================================================= *
 * Es folgen Funktionen zur Umwandlung von Zahlen in Strings. Dabei gilt   *
 * allgemein:                                                              *
 * - 'spc' bestimmt die Mindestl�nge des resultierenden Strings 'str'.     *
 * - Wenn das Ergebnis (mit Ber�cksichtigung von 'spc' !) nicht in den     *
 *   String pa�t, tritt ein Laufzeitfehler ein ('string overflow').        *
 * ======================================================================= *)


PROCEDURE ConvCard ( v: LONGCARD; spc: CARDINAL; VAR str: ARRAY OF CHAR);
PROCEDURE ConvInt  ( v: LONGINT;  spc: CARDINAL; VAR str: ARRAY OF CHAR);

  (*
    Die Conv...-Funktionen wandeln eine Zahl in einen String um. Dabei steht
    ein eventuelles Minuszeichen direkt vor der ersten Ziffer. Falls die Zahl
    weniger Stellen (inklusive Vorzeichen) als in 'spc' angegeben haben sollte,
    so werden entsprechend viele Leerzeichen vorangestellt.
    Die H�chstl�ngen der Ergebnisse sind, sofern 'spc' nicht gr��er angegeben
    wird: 5 bei 'CardToStr', 6 bei 'IntToStr', 10 bei 'LCardToStr', 11 bei
    'LIntToStr'.
    
    z.B. : ConvCard (123,10) = '       123'
           ConvInt (-2345,2) = '-2345'
  *)

PROCEDURE ConvLHex ( v: LONGWORD; spc: CARDINAL; VAR str: ARRAY OF CHAR);
PROCEDURE ConvHex  ( v: WORD;     spc: CARDINAL; VAR str: ARRAY OF CHAR);
PROCEDURE ConvLBin ( v: LONGWORD; spc: CARDINAL; VAR str: ARRAY OF CHAR);
PROCEDURE ConvBin  ( v: WORD;     spc: CARDINAL; VAR str: ARRAY OF CHAR);

  (*
    Die Hex- und Bin-Funktionen erzeugen, wie der Name sagt, Strings in
    hexadezimaler bzw. bin�rer Repr�sentation. Es werden nur positive Zahlen
    erzeugt. Zu Beachten ist, da� den Zahlen dabei ein '$' bzw. '%' vorange-
    stellt wird und dieses Zeichen auch mit zur Mindestl�ngenangabe 'spc' z�hlt.
    Ggf. ist das vorangestellte Zeichen mit der Funktion 'Strings.Delete' zu
    entfernen. F�hrende Nullen werden nicht unterdr�ckt. Die H�chstl�ngen der
    Ergebnisse sind, sofern 'spc' nicht gr��er angegeben wird: 5 bei 'HexToStr',
    9 bei 'LHexToStr', 17 bei 'BinToStr', 33 bei 'LBinToStr'.
    
    z.B.: ConvHex (128,4)  = '$080'
          ConvHex (128,0)  = '$80'
          ConvLHex (-1L,0) = '$FFFFFFFF' (8 Ziffern)
          ConvBin (100,9)  = '%01100100'
          ConvLBin (-1L,1) = '%11111111111111111111111111111111' (32 Ziffern)
  *)

PROCEDURE ConvLNum (    lnum : LONGWORD;
                        base : CARDINAL; (* [2..36] *)
                        space: CARDINAL;
                        fill : CHAR;
                    VAR str  : ARRAY OF CHAR);

PROCEDURE ConvNum  (    num  : WORD;
                        base : CARDINAL; (* [2..36] *)
                        space: CARDINAL;
                        fill : CHAR;
                    VAR str  : ARRAY OF CHAR);
  (*
     Diese beiden Funktionen erzeugen eine Zahl zur Basis 'base'.
     Wenn 'base' < 2 oder > 36, dann tritt ein Laufzeitfehler auf
     (Range Error).
     'fill' bestimmt das Zeichen, mit dem vorn aufgef�llt wird, wenn
     'space' gr��er als die eigentliche Zahl ist.
  *)


PROCEDURE ConvFloat ( v: LONGREAL; spc, n:CARDINAL; VAR str: ARRAY OF CHAR);

  (*
    Durch diese Funktion wird die Zahl 'v' in wissenschaftlicher Notation dar-
    gestellt. Es wird eine Vorkommastelle und 'n' Nachkommastellen, gefolgt von
    'E', dem Vorzeichen des Skalierungsfaktors und dem vierstelligen Wert.
    Ggf. wird der String links mit Leerzeichen bis zur L�nge 'spc' aufgef�llt.
    
    z.B. : RealFloatToStr (0.0123,12,1) = '   1.2E-0002'
           RealFloatToStr (9.9,0,10) = '9.9000000000E+0000'
  *)

PROCEDURE ConvFix ( v: LONGREAL; spc, n:CARDINAL; VAR str: ARRAY OF CHAR);

  (*
    Diese Funktion stellt 'v' in Festpunktnotation dar, wobei entsprechend viele
    Vorkommastellen, jedoch nur genau 'n' Nachkommastellen gebracht werden.
    Wenn der String k�rzer als 'spc' sein sollte, so werden entsprechend viele
    Leerzeichen vorangestellt.
    
    z.B. : RealFixToStr (0.0123,12,1) = '         0.0'
           RealFixToStr (9.9,0,10) = '9.9000000000'
  *)

PROCEDURE ConvReal ( v: LONGREAL; spc, n: CARDINAL; VAR str: ARRAY OF CHAR);

  (*
    Diese Prozedur verwendet je nach Lage des Wertes 'v' innerhalb der Werte von
    FixToFloatMin und FixToFloatMax das Festkomma- oder Flie�komma-Format zur
    Darstellung von 'v'.
  *)
  
PROCEDURE ConvEng ( v: LONGREAL; spc, n:CARDINAL; VAR str: ARRAY OF CHAR);

  (*
    Durch diese Funktion wird die Zahl 'v' in Ingenieur-Notation dargestellt.
    Es werden bis zu drei Vorkommastellen und 'n' Nachkommastellen, gefolgt
    von 'E', dem Vorzeichen des Skalierungsfaktors und dem vierstelligen Wert,
    der immer ein Vielfaches von Drei ist. Ggf. wird der String links mit Leer-
    zeichen bis zur L�nge 'spc' aufgef�llt.
    
    z.B. : RealEngToStr (0.0123,12,1) = '  12.3E-0003'
           RealEngToStr (9.9,0,10) = '9.9000000000E+0000'
  *)

END Convert.
