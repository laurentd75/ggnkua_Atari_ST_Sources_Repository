`  W�                      N�  W�       W�  W�           ` V�    /9  �#�  ��� �H�`�?< ?< NMX�L��� �#�  �Nu/9  �#�  ��� �H�`�?< ?< NMX�L��� �#�  �Nu                          p Nu�   �9  ��`g  � z����0,��H: �H�E�l�"z�����h  Ph  �h  �h @h �h �h 0h �h	 �h
  h ph �h h `h �JAg^
 �
) � P
) � �
) � �
) �@
) ��
) ��
) �0
) ��
) ��
) � 
) �p
) ��
) �
) �`
) ��Nu z����0,��H: �H�E8,�:D���L�DE �E"z�����h  �h @h �h �h  h �h `JAg.
 �
) � �
) �@
) ��
) ��
) � 
) ��
) �`Nu?,�0,ܰl�e9_�Nur p a �lRl�`�Bl�Bl�/ z�F0<?B�Q��� _Nua�?,�?,�Bl�Rl�0,ڰl�da�`�9_�9_�Nu z�
"H�� 4<� � � � � � � � � � � � � � � � �Q���Nu z����} "H�� 4<�!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Q���NuRl�0,ڰl�e0,�S@9@�a �z?,�Bl�a �9_�NuSl�d�Bl�a�`�0,ܰl�e �LBl�`�Rl�0,ܰl�c �6Bl�`�Sl�d �(9l��Sl�`�a�r r ` �2B��a�Jl�fa �r�a �9| �NuB��Jl�g? a � r a ��0Bl�NuBl�Nua� fB@  d<@ g�@ 
g �"@ g�@ g �b@ g �8@ g �n@ g �~@ g�Nu? a �*0r a ��` �0H���a �\L�?NuH���a �lL�?NuR���   �cJl�g�`�Nu@ �@�H���J,�fa �\,�@ � g   dp.Jl�gF   d  g  f4@�A��//<   ?,�?< @NA�� J�k, �f
< 
`�a BL�?Nua  p!` �z� f  pa �lpa �fp
` �`pa �Zp` �Tp ` �Na�Q���NufNua �<`�H@a`H@aH@? �Ha0 �a     0  9c^ ` �
	 �@g�	 �@f�Nu@�F�' H��C� �� 	 �z�0fa�0:�*� :�$  � ��`L�F�Nu@�F�' H��C� �� 	 �z��g�a�A���0�� ��`9  ��`f�   ��`0:��� `� --- SPACE-Taste druecken ---               Funktionsuebersicht TEMPLEMON /Version 1.8/ 23.06.87              ----------------------------------------------------                     Copyright (C) 1986, Thomas Tempelmann    Thomas Tempelmann, E.-L.-Kirchner Str. 25, D-2900 Oldenburg, West Germany ------------------------------------------------------------------------------- Die Versionen 1.x dieses Monitors sind frei kopierbar. Allerdings nur in der Originalversion, das schliesst ein, dass dieser Text incl. der Urheberrechts- angabe nicht geloescht werden darf und dass immer der ganze Ordner, in dem sich dieser Monitor befindet, kopiert wird (mit den Dateien READ.ME, TRACE.C, TRACE.TOS und TEMPLMON.PRG) ! Bitte haben Sie Verstaendnis dafuer, denn nur auf diese Weise kann dieses Konzept der "public domain"-Programme hier in Europa die gleiche Selbstverstaendlichkeit erlangen, wie es das in Nordamerika schon seit mehreren Jahren hat.   Vielen Dank fuer Ihre Ruecksicht und : GOOD HUNTING !    "!" zeigt Eingabebereitschaft des Monitors an.  Alle Werte sind hexadezimal angegeben/anzugeben !  Dezimale Werte koennen mit vorangestelltem "&" eingegeben werden.  <f> steht fuer die Anfangsadresse, <e> fuer die erste ausgeschlossene Adr. !  Anstatt <e> kann auch X<n> ( Anzahl in Bytes ) angegeben werden, in manchen  Faellen kann auch Z<n> ( Anzahl der anzuzeigenden Zeilen ) verwandt werden.  Bei den Funktionen "M", "D" und "I" kann statt der Endadr. auch ein Punkt  eingeben werden, um eine unendliche Auflistung zu erreichen.  Als Adresse kann auch ein Registerinhalt ( mit "R<registername>") eingegeben  werden. Beispiel: "D R PC." disassembliert ab aktueller PC-Adr.    Alle Auflistungen koennen mit der /SPACE/-Taste angehalten oder mit einer  anderen Taste abgebrochen werden.  Einer Adresse kann die Offset-Variable O vorangestellt werden (s.u.).  Die Tasten /F1/ und /F2/ schalten die Anzeige (!) des Monitor- bzw. des Origi-  nal-Bildschirms um. Zur Beachtung: Verlassen wird TEMPLEMON mit 'G' oder 'Q' !   M <f> <e>               Memory dump. Zeigt Speicher byteweise an. : <f> <w1> <w2>...      Speichert Bytes <w..> ab Adresse <f>. D <f> <e>               Disassembliert Speicherbereich. O <offs>                Setzt die Variable "O" auf den Wert <offs>. C <f> <e> <d>           Kopiert Bytes von <f>..<e>-1 nach <d>..<d>+(<e>-<f>) V <f> <e> <d>           Verify. Vergleicht Bytes und zeigt Unterschiede an. H <f> <e> <b1> <b2>...  Hunt. Sucht nach Bytes (? als Joker). H <f> <e> '<string>           Sucht nach Zeichenkette (? als Joker). F <f> <e> <b1> <b2>...  Fuellt Speicher mit Bytes (? als Joker). F <f> <e> '<string>     Fuellt Speicher mit Zeichenkette (? als Joker). I <f> <e>               ASCII dump. ' <f> <string>          Speichert ASCII-Zeichenkette in den Speicher. B                       Zeigt alle Breakpoints (BP) an (Adresse,Zaehler,Stand) B<n> <a> <c> <c0>       Setzt BP Nr. <n> auf Adresse <a>. B-                      Loescht alle BPs.   Breakpoints werden beim Verlassen des Monitors gesetzt, sofern das Tracebit   im SR nicht gesetzt ist (sonst kann die Traceroutine die BPs testen).   G <f>                   Go. Verlaesst Monitor und faehrt auf Adr. <f> fort. GS <f>                  Ruft Unterprogramm auf, das mit RTS abschliessen                            muss, um wieder in den Monitor zurueckzugelangen. T+ ( T- )               Tracekontrollmodus einschalten ( bzw. ausschalten ).   Wenn der Tracemodus eingeschaltet ist und "G" ausgefuehrt wurde, loesen   folgende Tasten eine Funktion aus :     /SPACE/ fuehrt die angezeigte Instruktion aus.     /ESC/   verlaesst Tracekontrollprogramm, um normale Monitorfunktionen               auszufuehren. Rueckkehr mit "G".     /O/     schaltet Anzeige und Tastenabfrage ab und fuehrt Programm weiter               aus. Dabei muss dafuer gesorgt werden, dass das Programm wieder               in die Monitoreingabe zurueckkehrt, z.B. ueber einen BP !     /A/     wie /O/, jedoch werden alle Instruktionen getraced, also auch               Trap-Routinen usw., da das Trace-Bit im SR immer wieder gesetzt               wird. Nur, wenn ein Diskzugriff stattfindet, oder vom Programm               die Interruptmaske auf 7 gesetzt wurde, wird das Tracebit nicht               vor Ausfuehrung der naechsten Instruktion gesetzt.     /R/     schaltet Ein-/Ausgabe bis zur Rueckkehr aus dem augenblicklichen               Unterprogramm ab. Ist das T-Flag Null, wird einfach eine Rueck-               sprungadresse in den Monitor auf den Stack geladen. Natuerlich               muss dann A7 so stehen, dass beim RTS die Adresse auch vom Stack               geholt wird. Ist das T-Flag gesetzt, merkt sich der Monitor das               A7-Register und wartet auf ein RTS, RTE oder RTR, sofern A7 nicht               kleiner als das gemerkte A7 ist, und schaltet dann die Anzeige               wieder ein.     ...     jede Menge neue Funktionen seit Version 1.4 !     Fuer die folgenden Register-Operationen koennen die Register <reg> mit den   ueblichen Abkuerzungen (D0,A7,SR,PC,SSP,USP,usw.) angegeben werden.   Ausserdem steht F fuer SR, jedoch werden dann die Flags einzeln angezeigt.   A7 repraesentiert, abhaengig vom augenblicklichen Stand des S-Bits im SR,   den jeweiligen Stackpointer (SSP bzw. USP). R                       Zeigt die mit "R:" ausgewaehlten Register an. R <reg> = <l>           Setzt Wert <l> in Register. R: <reg1> <reg2>...     Waehlt Register-Default-Anzeige aus (z.B. f. Trace). R F<SR-Flag> = <v>      Setzt SR-Flag auf <v> (z.B. "R FC=1" setzt Carry-Flag)   P                       loescht Bildschirm. Q                       Quit ( GEMDOS(0) ). Achtung: Wenn vom Desktop in den                         Monitor gelangt wurde, niemals "Q" ausloesen, sondern                         nur "G" eingeben ! "Q" dient zum Abbrechen des gerade                         aktiv gewesenen Programms, "G" fuehrt es weiter aus !   Erweiterungen seit V1.3: S <dateiname>, <f> <e>  Speichert Bereich v. <f> bis <e>-1 in eine Datei. P <dateiname>           Oeffnet Protokolldatei. Alle Ausgaben gehen dann sowohl                         auf den Bildschirm als auch auf die Datei. Beispiel:                         "P PRN:" protokolliert alle Ausgaben auf dem Drucker. PC                      Schliesst Protokolldatei.   Erweiterungen und Fehlerkorrekturen seit V1.4:  Wird nicht verraten. Dazu muessen Sie sich schon die Anleitung bei mir holen.  Nur soviel: Vor Allem der Tracemodus ist noch um einige wertvolle Funktionen  erweitert worden.   Neuheiten in V1.5: L <dateiname>           Laedt Datei, Speicher wird automatisch mit 'Malloc' an-                         gelegt, sofern kein Fehler auftrat. Achtung: Eignet sich                         nicht zum Laden von Programmen, da nicht reloziert wird!                         Es empfiehlt sich, immer Zettel und Stift bereit zu hal-                         ten, um sich die Anfangs-/Endadressen zu notieren. L- <f>                  Gibt Speicher, der beim Laden angefordert wurde, wieder                         frei. <f> muss dabei die Adresse sein, die beim Laden                         als Anfangsadresse ausgegeben wurde. L <dateiname>, <f>      Laedt Datei an die Adresse <f>.   Es ist nun bei Adressangaben moeglich, Ausdruecke mit "+" und "-" zu verwenden.   So ist z.B. nach einem Monitoreinsprung der Bereich vor der Unfalladresse mit   "D RPC-20." leicht zu disassemblieren.   Direkt nach dem Dateinamen bei Load kann mit einem vorgestellten "@" die Posi-   tion in der Datei bestimmt werden, ab der gelesen werden soll. Beispiel:   "L TERMINA.TOR, @100, 50000x20" laedt aus der Datei "TERMINA.TOR" ab dem 256.   Byte 32 Bytes an die Adresse ab $50000. Auf die gleiche Weise kann ein bes-   timmter Bereich einer Datei ueberschrieben werden. Z.B. ueberschreibt "S A:   B.TXT,@&12,0.2" die Daten der Datei B.TXT in den 12. und 13. Bytes mit den   Werten aus den Adressen 0 und 1.   Die Protokollausgaberoutinen sind verbessert worden.   In Version 1.6 wurden 2 Fehler behoben: - Breakpoints, die im ROM-Bereich gesetzt wurden, konnten bisher oft nicht er-   kannt werden. Die Wahrscheinlichkeit, dass dies immer noch passiert, ist nun   verringert worden. - Bei der Funktion mit dem Hochkomma (') koennen nun wieder Kleinbuchstaben ein-   gegeben werden.   Version 1.7: - Bei Protokollausgaben werden nun wirklich keine Ctrl-Zeichen mehr ausgegeben. - "VI" reinitialisiert auch Bus-/Address-Error Vektoren. - "GS" und "R" funktionieren wieder bei FT=0 richtig.            *---------------------------------------------------------*          * >>>>>>>> ! ! ! S O N D E R A N G E B O T ! ! ! <<<<<<<< *          *---------------------------------------------------------*   Eine ausfuehrlichere Anleitung mit hilfreichen Tips zur Fehlersuche erhalten Sie ab jetzt fuer nur noch DM 20.- ! Ausserdem koennen Sie mir dadurch gleich Ihre Anerkennung zu meinem Programm bekunden.       Mit freundlichen Gruessen       Thomas Tempelmann   Unbekannte Funktion. Gebe '?' fuer Funktionsuebersicht ein ! Zahl erwartet Zahl zu gross Anfangsadr. ist groesser als Endadr. Ueberfluessige Zeichen in Eingabe Ungerade Adresse SPACE erwartet Falsche Registerbezeichnung G-Funktion mit PC=0 nicht erlaubt Leerstring nicht zulaessig String zu lang Fehlende Adresse / Parameter BUS ERROR ADDRESS ERROR Allg. Syntax Fehler Operator erwartet Unzulaessiges Register Zu viele Parameter Interner Fehler #1 (Breakpoint doppelt gesetzt)  Undefinierter Fehler MIVCDBGR;O:'HFTPSQ&?L` 	�` �` 
�` 
t` �` h` ` �` D` L` l` z` ~` F` �` �` f` �` ` �` nSR D0 D1 D2 D3 D4 D5 D6 D7 A0 A1 A2 A3 A4 A5 A6 A7 PC USPSSPBEVAEVTSIXNZVC  Stop durch User-Trace Routine Exception #  :  Fehler:  
Lade ab  
Speichere ab  , erste unbenutzte Adresse :  Rueckkehr von GS Illegale Instruktion Illegaler Interrupt Interrupt # Trap # TRAPV - Instruktion CHK - Instruktion BREAK - Instruktion Stop durch Breakpoint Division durch Null Privilegs-Verletzung Unterbrechung durch Tastatur Stop durch Breakpoint # Tracemodus  nicht aktiv aktiv  C:  R: BUS ERROR bei  ADDRESS ERROR bei   - SR:  / Super-SR:  / Instruktion: 
Protokolldatei ge oeffnet schlossen 
TOS-Error # Breakpoint gesetzt auf  Nicht ausgefuehrt. Breakpoint konnte nicht gesetzt werden auf  Keine Breakpoints gesetzt 
Kein genuegend grosser Speicherbereich frei 
OK. 
Bereich war unbelegt  a �|  f g
  f` .C��� 
g e cF  f gpFa Ր`P�� 1  a Ղ1 a �z1    ga �l��   f$p=a �\C� Ra 
��J 1    ga �`a �Nua ��, �gC���a ��0,�a ��C���a ��"l�a ��,  �g( ,�a ��C��a մ0,�a ��C��a դ0,�a մ, �g0,�a լNuC���a Ղ,   �gC���`C���` �la �ra �&pRa Ԣta ��ta ��ta ��a �:BBC���a �01  g"a �v1 H�0, T�h�1 a �FVB g�NuBl�B��  �g�  T)I�a�`  B��  �g�  Ta La pa �bO� a Ԕa  �B�S�a Pk�  !g�   g�C���4< A����gX�Q���`a &� N�` ��B�B�Jl�ga .`a �JC��Sa �vC��d`JgJf�Q���a �^` �f|�`�|`�|`�|`�|`�|`�|`�|`�|`�|	`�|
`�|`�a  (|`�a   |`�|`�|`�|` �~|` �x|` �r _<F "8:*_N�?,�Bl�a ��M�  *Na  �  g,  gZ2,�RA�l�d�  g  T   e��a ���b�`�&  g�R�� M�  9_�gP��  ga ��`�Q��M�  ` ҐA�  ��g�S�`���g�`�a �~J@g6a ΦH@  ;fa ��p   <fa ӈp   KfpNu  MfpNuH@J@Nua �*a �Ba�g�` �,a�g   fa�   Nu)y    �B, �)y    �B, �K���#�   K���#�   )y  �K��#�  Nu | Q� �#��  #� �   �    #� �   �    Nu  zb
  ae   NuR�a�  f� JGNu  0e   9c  Ae  Fb    0 < Nu< �Nu  Og  &g  Rga ��fa �� < Nu,<���`8,<���``,<���`p,<  �`h,<   ``a f�  Nua �,< ��B�?< `? a �Ra J_gӗ`��  +g�  -fp `�"JGNu  Ofa �&Q��aҬ�JGNuP��B�  &g0  RgPa �g
J,�g` ���b �鉂 a ��ka ��g�JGNua ��a ��f�  	b첆b ��H�H��/�ҟҀ`�H� �a  �a � f � f ��A� R�J"0  L�`�a  �k  �a ��f  va ��$A� JGk  za  �  .g.  Zgn  Xf.a  �kRa ��fLa ��Ҋdr� f�  `a  hk0a �df*a ��&A� ��b �<"�JG g Nu$i ` ��$Q&|����` ��&J` ��a  "jr`a �L&� ` ��a ��k   fa ��j�JGNua ��j ��Nu� a �`Q���NuC��� a �j ��|a ��p:a �> 
a � a ��BEa ��a �0
  fa ��RE f��d(Q��ܔ�ra Ϻp'a ��SEa ��a ��f
 g�S�f�)J�NuC��� a ��g �:a ��j �>Nu� a ��*A��c����R�R�#��d�Nuڵ�e�Nu� .  f  IfA�.)H �A�4)H �`  Xa ��*Aa ��a �z�
f��e�Nu"JS�a  $p-a �T"MS�a   gra ��a ��g�NuSf
a θa ��z 	a ��p:a �` ��a �Zka ��j �~#�  �a �~pBa ��pUa ��a Ξ 9  �` ήa �pC� �pB�Q���� Q�NuC� �a �<k  �  Ug�  -g�a �
f �  b � H�8�a ��k\   f �
a �p4@6@� a �L#�@ f4A6A`JGka ��a �$4Aj6A`
a ��a �6A3�@ 3�@"A� �pJ�V���V�a ʹpBa �0a �a ��8�L 1@ a ��a ��01@ a ��a ͸01@"` ��B�Jlg8�LJ�@ ga�R e�NuC���� ` ͔ka ��j �B)A�a �DpOa ��a �j ,�` �|C��Wa �4ta �ba �Rf4Jg0a � Q���/	?,�Bl�C��a �>a �2 a � 9_�"_  g�Nuk�� a ��a �k � /a �� a ��k ��a ��a ��j ��a ��p=a �2a ��  +g0 -g& *g> /g> EgV OgV Af ����` �Ȑ�`Ё@�a ̼C���a ̢0  ` ����` ̤JAg �t��/ a ̜C���a �| H@` ̌��` ̀��` �zk  r  -f  @a �*` �^�   SfpA� RC�J"�Q���Nu  Rf ��pC� RA�J"�Q���Nu  +g  :g 4.  g�� B�a (`x��`a ��(,F� J�j� BC� 	  f/ < ��Ȁ��fv� 
(4gX  fN� 	fpDC  f
X@ gp8�l�d0a �R 
g  frD` 	frAp;a ʶa ʰ`pRa ʨa ��JCf� 
fRC c�BC 
f�Nu f,  Tgt`tNu� �   FgN a ��k ��C��bA��BB�gV�RB��e�` ��a ���) f�)   g. a �Z�) f�a �ba�` �\a �Xk$   g� C��Pg �|�gV�`�) R�Nut � Nu� a �Tt  Dg
  Af �pt	xC� Ra �a �4ka �^a �,6�K#�0 RBQ���Nua �"a �b) � b ��H�H��h�iF@�l T�l T`Fa � g0a ��  =f&� f�a ��  fa �`a ��C� R�J#�  �J� f� g
�  � `�a ��j�Nu� a �`kX  -f"a �TjB�FNuB�a�F�  f� ǬFNu  +fa �,j)|����FNuB�FB�a�  g� F��FNu�  (,F` ��� a ��k"A)I�a�JGj�Nua �  Rf �Va �2�������Nuk8  -fa ��B, ��  T`"  +f ��a ��A��#�   $|  ��  Ta ��a �lC��Na ��� ` �J�a ��B� �C���` ��� ", �JGkV  Sfa �Fk �d� a �l  ,g� a ��k0  ,f �Pl 
d �a �/a ��a �  D"a � JGj�J�g �2 AJP)A �Jj,  TfC� �`C� �K��f Q!"�a �
P�a  �gRh , � f �B,DJj$Jy  >f, T  '  'f�  T`�  TJ, Tk g�  T`a �fF`
�  gC� �� 	 �z�Xfa �G �Q�a �� l �N`.l �/, �?, TL�� VNsBl�G !G �` �B@A� �$, ���g
R@@ f�Nu@ Nu0,
A�$, �`��W���NuHT(z�nP� �H�� V)_ �9_ T)_ �B, �)O �Nh)H �O� a �(J,ga �, �f<�  T` ��J�,  Tg
 l �X� �` l �X� �)P �B, ��  T, ��  g�  TK���� �g �� f R 9  �g*,  Tg)l � �`)l � �A� R"@N�J gC��3` �r� g� a �f� � g�  TC��J, �g �FJ,g,a ��g&Y�Sh "f1h   "9@�C��4| �` �� `� f �  g8,  TfA� �`A� � , ���b l �PNugPNwgPNsf� �  f ��� P��  Dfa V?B� g� (,F� a ��$l �a 	�,
&Ja �f>� a �a �pa �   g ��  0f�  T� a �&a �4`�  1f�  T`�  Ff�  T� ` �&  RfHJ, Tk ,  TfC� �`C� � QK��!"�` ��� ,  Tf)l � �`)l � �� ` ��  Og�   g ��  Af� `�  Dfp!a �p,a �,
a �a Č` �.  Sf)K �C��|a Ī` ��  Bf �"ag �C��Ha Ď a Ěa �P` ��0,
@ 	gA��H!�  Rl
Nu.E`4�2�J�QJ�f	�NuJ,g? HQC��%a �@ a �Fa �0tNu/9   A���#�   *Y�BBBDA� �E� �,g
#�   ` ��J�g"h��a�TJRD e�CBC0,
gBDA�E�0`
"Xa �nTJRDQ���9CB#�   JBga �<C��|a ìa ���<  g�< f�tNuB G� �E� ��g
"SQJ�f2�X�T�R   e�NuB,D6,Bg,BlB0,
BBC�E�0`g
 QPJ�f0�XITJRBQ���Bl
NuC��� a �.j ��a Ja �f f��e�`S�f�)J�Nua �k ��t�B�C��a ��g�  R�*N�gD  gFRB  g �  ?f� f�R�` g�  ` ��a �6a ��  a �Z` ��a �"j �JJBk �XNu� C��� a �g �Ja �pB�	f�@ R���d
RD�Bc�` ��Nu� C��� a �Lg �a �<a �a �(z
B�	f2@ �1@ gR���e�NuRD�c�A����g��g� 
a �SEfa ��z
`a ��a ��a ��g�Nuj �a �a �"a �&a �8 l �N`.l �lx� T l  TF� TBgNA y  �N�,<���B�a �Vj �V� p=a �� ` ��#�  �(z��P� �H�� V)y  � �&_a �n)O �Nh)H �O� )A�9F�9D�9E Tp��u  g
U@@��d�`��)M �B, �HSB H@�H9@�| �N�a�C��Ra �` � a �~C��Q`�#�  �(z�P� �H�� V)y  � �"_9_ T)_ �B, �)O �Nh)H �O� HQB 	H@�H9@�| �` ��a� l �PJ�gC���` �a �C�����g ��C�����g ��, �� a ��f �.a �g ��T� �C���` �Ra �^C��` �Ja �R0,�@ 9@�@ fF�# � �C��`�a �,0,�@  9@�� �C��y`�a �C��v`�a �C��`�a ��C��`�a ��C��`�,z�
.   �`�  �NuJ� �k�P�L�?�H�?� V(N)_ �9_ T)_ �B, �)O �Nh)H �O� a �Sy  �0, T@ @�A���@3�   RF�,  �gJl �ja ��, �� ` ��C��C` �L� a �xk)A�"A   f �R�  g�` ��NuC��� a �.j ��|?a ��p'a �\ 
a �a � :a ��a ��f gS�f�`��e�)J�Nup` �*JCgC��`a ��C��t` ��Nua �k�4 6,�ga ��a  �� a �<S�j Cg�Bg/a �*j�B��g �b. :��g?< <`
?< =?|  NAP�J�k@J@jD@? C���a �fC���a �^9_�Nu",�gB��? /?< INA\�02,�Bl�`2,�Bl�? a*4jC���a �0D@` �6` ��2,�Bl�`2,�Bl�A cH�?�??< >NAX�L��NuC��
a ��`�� a �k �/  ,ga �Nk   f�B��g �� B��B��Q��a �*a �Xk  2  @f"a �a �v)A�P��a �:k  ,f �Ha ��C��a �n"_Nu/
? ?,�/?< BNA�� 
$_J�k ��Nu  -f2a ��� a �Hj ��/?< INA\�� J�gC��v` �C��h` �a �0/
Bg/	?< =NAP�$_J@k ��9@�pr a�)@�p ",�a �z",��)A� f/
/?< HNA\�$_J�g ��k ��$@)@� f&J���C��~a �� 
a ��//
��/?,�?< ?NAP�$_&_J�k �B��a �\C��ea �d ` �pa ��g �*/
Jl�g?< /	?< =`Bg/	?< <NAP�$_J@k ��9@�p ",�a ��C��	a � 
a �$//
��/?,�?< @NAP�$_&_J�k ��a ��J@k ��C���a �� ` ��p�Nua ��p,a �H���"J`  T        ` �` �` �` �` �` ` ,` ,` 4` x` �` �` $` h` �` � I$I&I 	a �ra �T46<BD�K�K2A����00 SCj��AA�����N�a �,l (�k�a �La �Fa ���f�a �l C�k�     dp.a �D��f�` �T F HILSCCCSNEEQVCVSPLMIGELTGTLERASRk�X|� ���D�	�    +�`�'@�p� �@k�P 	aB k�PqO�$ qN k�Ps� k�Pp�@�� �B .( k�V��f �� k�V��� k�Pk�Pb\�����fZ s�  � �
      �&  �� �$  T� S`  � �  		�E  k�X�"m0	"mP	��@|� 
�E��D 
` 
`�+� 
mY0	mYP	�@� 
. 		�	 
� d� �� �� ` >` <` B` x` �` �` �` `  ` "` "` x` �` �` �` ` ` |` �` �` Z` l` �` �` �` �` 	` 	"` 	*p.a  pWa  a �&l �k�Nup)`p(` �dp#`�p$`�p,`��DA��<&0@ x�0@ g@ @a �:SDf����   �A��.��N� vp*a �Q���a ��U�`  x6�KƼ   C g �C faXC fa`C fp-a ��C ka �lpDC  gpAa ��0@ �| 0a ��C kC g,a �<C fp+a ��Nua �8a �l` �fa �(0` �\a �"pD2jpAa �p0�H�H@ �| 0a �^p.a �XpW gpLa �J` ��6C8Cg ��RD f&6�K�KC C g ��C g�CC f 4g L^D6�KC �C` L` � g g �� g <RD` ZTD6C�C �g �RDC �k �RDC k �RDC�k �RDC�g �RDC�k �RDC k �RDC g �RD6C�C@g �RDC�m �RDC�g �
C�g �RDC
 k �RDC�C
�g jRDC
�k \RDC k �RD6C�CPk ��RDBNpj�KC �C` ��XDBNxj6C �C` ��D 6C�C�g bRD` \6C �C �g �xRDC �C �g  �RD g �RD` �` �V g �N` ��6C�C�g  �RDC �g  �RD6C�C g �"6CA0CA fTD` �RD g  �` 6�< �eRD` ��C0C g  TD `  �6C�C �o  �C �C �g ��RD6C8Cg  "RD`  ,6�< �e�K�KC �C�< �d  �a  `J �d ��Nua ��F ?F :j
F 8F f(` ��a ��F ?F <g`�F ?F <j�F 8F g�` �BF 8F  g�`
F 8F g�<F ?F <j �TF e �LF 8F g�F (e �:`�F ?F e �,F :j �$`�a �Z6C f�a �NF 8F f �P`�F ?F :j ��`�F�F �o �ּ< �f ��` ��F0 F f<F�F @g
<F 8F g ��<F�F�f<F F j ��` �fNua �<8` ��BD g f�| �`�| @6C ?�Ca Za <D �6�KC 8�C` �la a ��8D a *`  ba �a ��8D ?` �D8a $a ��0�H�H@ fp�| 0a �.a ��` �a �a ��6Ƽ   �gC �j։`։��   `&	8H�քa ����a ���a ���` ��a �\a �pa �p0a ��a �jBDa r` ��8` �B�86C��< �f$pAa �� g� `� a V8�L�` �t ga (D �a :8` �\a 0a D �` �L8 g
D (a a �` �4a ��8�L�LD 6C �C Hf�| a �8D ` �a �� g8�L�LD a �8` ��a ��a ��0a ��a ��8` ��8D ��| <a �8 
fD ?D <f g $f 
` ��a �.8D ` ��pR gpLa ��8�< �ea �
` �v8a V�L�LD  ga �^`a � D fxD 00a �Pa ��8D ` �8�LNu�LNux@ gx�a 8 f�|  a �a �D ` �a �D a �8�|  ` ��8D GD @a �` ��8�| @a �:Y 
gba �8K���BGrDa  rAv0N�d>  g0@�f00a ��0a ��0@�f�  D  gp/a ��`
p-a ���  RCC 8f�Nu86C 8C  gK��"`K�� a�a ��8` �Fa ��8
D a a ��` ��a ��8D a ��D 
kp0R@�| 
D 
j�a  80�| 0`.p.a  *pLa  $8a �� f
D (a  �pUa  
pSa  pP` ��a ��a �x
D  ` ��a �@a  a �d8D ` ��a �*a ��a �NpSa ��pR`�a �a ��a �8pCa�a�`�a �8a  FpAa �z0�H� @ 0` �la ��a �` ��8
D a  $�L�L` �DD �6�K�KC �CNua �.` ��a` ��a  ` �p.a � pL f
pB gpWa �
` ��Ƽ   g �b�< gT�< j\C g �< f&6C �C �j։`։��   `&	0H�րa ��a �PpPa ��pCa ��  g �8` �"a �>0a �r` ��a �,a �,�Kg�< g ��a ��` ��0` �J6�KC B` k
Bb jC  A��00 a �J00` �B$IL�{�NuA���#�   A���#�   A��#�   $A���#�    A���#�   A��#�   A��#�   A���#�   A��@#�   `A��B#�   d#�   l#�   t#�   |A�   �M��F �P� � � � � � � � � � �P� �p @�����R@@ Pe�A��X#�  Nu        B�?<  NA\�A��� �*o A��� � - �   Э " ҍA��$ �(AQ� ��  "@��T�Ѝ�   @� A��p �" ��A��j0�м  � ��A��� �a ��A� �M��BX��e�B�  �p�� � )@F� X�E��$ Y$� LE�� Y$� L9| P�9| �a ��/:�>?<  NA\�Bg/:�,?< 1NA y  �N�NuN�    NuN�  W�   `  