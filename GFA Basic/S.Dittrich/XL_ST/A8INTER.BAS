 GfABASIC       T   v   �   �   �   �      F  �  �  �  �  P  V  V�  W
  W�  W�  W�  W�  W�  W�  X  X�  Y   Y   ��STBDUMMYISUMS1OPDPUSHDISKWD1D2JAFDF1DF2WICOLENSUREC0SSIZ APPUDFNULLA1RBSUMFFX DBSSECIJKDISKLENALS1MCPPUSHSNLESUMCLSIZDUMMYOSECOLDFILCLOLDSUREFRNULL COMPPDDFLENSU MEDASTR PDPPSECPUDFSULENCOMSTATGOPSTATDSTATGO1DSTAT2DSTAT1MPROGGO2DOSUMGETSTATGETSERPUTSERGOMENUEDIREKTINFODIRINITSAVLOASETPUFFERSHOWSETPSETDPRPUFDODUMSETD1SETD2SAPUFINIT1DIR1DIR2SHPUFCLPUFFILEPINFOLISTD1STD2STSTD1STD2DSTSTDXGETFNSEARCHFNGETFILESET128SET256SUREINITALLDINFODINFO2SETMPSHOWNRSUMCLWFINDFREEFINDFRE2FMTSDFMTDDXFMTDDFMTSURE CLSEC :*** ATARI ST-ATARI 800-Interface  1/87  S.Dittrich ****YF� E#��H    �     Fs�E�    ��HH   Fs$(�      !�      !�      !�    F @*��      !� �pp    !��@�@  
 !�� !�� !��@�@  
 F7� !M�      !�AUX:F*�E��    !� FF�llstrings vorbereiten �E��    !�    F.�E�     F Sektorl�nge 128 Bytes vorgeben M�+F Disketten initialisierenRF  ���E�G�p   F Q� � FMen� einlesenl
��Z� � �***F 
	���F
� � E� F� ��       E� F BDesk , ATARI 800 Interface,---------------------,1,2,3,4,5,6,""\Disk 1 ,  Directory,  Save Disk,  Load Disk,  Format SD,  Format DD,------------,  Set,""\Disk 2 ,  Directory,  Save Disk,  Load Disk,  Format SD,  Format DD,------------,  Set,""BPrinter ,  Direkt,  Puffer,  List,  Print Puffer,  Show Puffer 8  Clear Puffer,  Save Puffer,---------------,  Set,""TCopy , Disk 1 to ST , Disk 2 to ST,--------------, ST to Disk 1, ST to Disk 2,"" BSettings ,  128 BpS,  256 BpS,  show Sector# ,-----------------H  Clearw Disk 1,  Clearw Printer ,  Clearw Disk 2,  Clearw Status,"" Ende, * Quit * ,***��  FMen� einschalten[�      F "\�!�Disk 1FiWindow 1 = Disk 1t]�      !�-F [�     F "\�!�DruckerFWindow 2 = Printer]�     !�-F [� @   F "\�!�Disk 2FFWindow 3 = Disk 2]� @   !�-F [�     F .\�     !�StatusFWindow 4 = Statusanzeige ���E�     G�    F ^�F Fenster �ffnenYFund l�schenf
	���F (v�L�F Men�prozeduren initialisierennLB� E��p   !�!�!�!�!�!� FBaudrate auf 19200 Baud einstellen�� E�FDisk 1: aktiv�E�       F &�� P   !�F Disk 2: 'Set' abhaken�E�      F &��    !�F Printer: 'Set' abhaken�E�      F  �� x   !�F Printer: 'List'h0�� <   !�F und Settings: '128 BpS' abhaken0 M�F Printer-Status anzeigentM�-FDisk-Status anzeigen*M�.FMaschinen-Programm initialisieren- �|F��F" ��!� �Fs** Puffer leeren�Ea�      F��F��F u�|F �F ** Maus einschaltenu. � ��!� �Fuwarten auf seriellen Empfang��F��F��F ** Maus ausschaltenuu�|F��Ea� Fserielles Byte holen> ��#��     ��  #�7�1 �� �  #�7�2 �� � Fn-�F nicht f�r mich...oF�E�F� �Z�E�     G�@   F��Ea� F
Kommandoblock holen�� E�Fund retten
�E��F2�E#� �     %��      FPr�fsumme bilden
	���F �Ea� FPr�fsumme holenl ����Fwenn falsch:"^�     FFStatusfenster �ffnen� Invalid Command-Frame !F%-�F wieder zum AnfangrF  Š�7�1 �7�2 F:******************  Disk-Routinen  ******************* .� E�7�0 �F 
gew�hlte Diskette ermittelnl$E�!7�A FACKNOWLEDGE (ACK) senden0�E�� �� �     FnSektornummer errechnenE ����       7�R F&**********  Read Sektor  **********E�!7�A F
ACK senden, ���FAnzeige des Sektors gew�nscht ?h ^� ��F
dann Fenster �ffneng2Y�!� "�Sending Sector $"n� "� ("�"�)     F�F >M�!�� @� B�� @�  �CFnSektorinhalt und Summe sendenl-�Fdas war's�F * ��       7�P ��       7�W F,**********  Put/ Write Sektor ********** E�!7�A FACK senden" ����    Febei Sektor 1-3*�� @� E_�    !M� Fo128 Bytes holent ��Fsonst .�� @� E_�!M� Fvielleicht auch 256 BytesnF �Ea� FPr�fsumme holen1E�!7�A FACK senden  ���Fggf. Sektor anzeigen
^� ��F02Y�!� "�Getting Sector $"n� "� ("�"�)     F�F�M� �� FgPr�fsumme bilden �J��Fstimmt's ?(^�     FFsonst Statusfenster �ffnen:� PUT: Checksum-Error in $"n� "� : $"n� "�<>$"n� FE�!7�E Fund ERROR senden-�FweiterwartenF(E�!7�C Fandernfalls COMPLETE senden-�Ffertig! F*! ����       7�S F&**********  Disk-Status  ********** ^� ��FDisk-Fenster �ffnen ( �@��    Fsje nach Sektorl�nge(R�F�DATA-Zeiger auf OK-Status setzen �JFR�FFF$ à�E�G�@   FD
6 Statusbytes:Q�F�Daten lesenfE�!�Faund senden
	�n�F -�F�fertig! �|FF67,16,0,1,0,17 �|FF67,48,0,1,0,49 F . �@��       7�! ��       �    F!2**********  Format Disk SD oder DD  ***********E�!7�A FACK senden:��  E�� �     FS
Disk-Zustand auf SD bzw. DD setzenM�,FEund anzeigen� Formatierung..FM�	FoDiskette l�schen0M�!���!�    F 'alle Sektoren OK' sendennE�!7�C FCOMPLETE sendeno-�Fauf WRITE wartenF* $^�     FWunbekanntes Kommando !.�Unknown Command : "n��  W�("B��  "�)F-�F�F|  ����    F:*****************  Printer-Routinen  ****************** ����       7�S F***********  Printer-Status  ***********,R�F DATA-Zeiger auf Status-Daten setzenb, ƺ�E�G�`   F7ACK und 6 Status-BytesQ�F�lesen E�!�Feund senden
	Ǝ�F �|F 65,67,128,78,5,0,211 F   ����       7�W F(**********  Printer-Write  **********E�!7�A FACK senden"�E_�    !M� Fe
40 Bytes lesen�Ea� FPr�fsumme leseneE�!7�A FACK senden
�Ez�
 Fh*�E����z� !�      FPr�fsumme bilden �t��Fstimmt's ?*^�     FFsonst Status-Fenster �ffnen2� Printer: Checksum-Error : $"n� "�<>$"n� F$E�!7�N F
NO ACK (NACK)eE�!7�E F
und ERROR senden-�F� ��F"4�EC�@B�     FCandernfalls CRLF ($9B) suchens
 ���F<�E;�@�� B�     B�P    Fund in LF und CR �ndernnFE �8�F'List' gew�hlt ?^�     F �"Fja: Text ausgeben FE" �|�F Puffer eingeschaltet ?�E��Fja: Text in PufferFE& ɺ�FDirekt-Ausgabe gew�nscht ?;�"Fdann druckenFE�!7�C FCOMPLETE sendeneF FF -�Ffertig !!4*****************  Prozeduren  ******************+�F � E�#�� �    F
w�� L�F $w�� �     L�!�
!�!�4!�6!�$!�F$w�� �    L�!�
!�!�4!�6!�$!�F*w�� � `   L�!�!�!�!�!�!�!�$!�Fw�� �    L�"!�"!�$!�#!�#F(w�� � 8   L�(!�)!�/!�$!�1!�1!�1!�1Fm��F$ �Ҧ� � d   FREnde-Option ?f�F ��F
Menu ausschalten(�!�!�!� P   F * Ende * rF Programmstop mit Abfrage��  F	falls doch weiter:$(�      !�      !�      !�    F v�L�FuF .F� +�F�Programm-Info ausgebenX)�!�E  ATARI 800-Interface  |  1/87 S.Dittrich f�r |     Happy-Computer   !�!� OK !�F.F  &+�1F�Clear Window, Fenster l�schen^�� � H   F YF�.F� *+�.FMaschinen-Programm initialisieren-R�Ff�
E� F  �
�E�G�@   F2Q� F��
E�
B5�&H�   F
	���F�|F
J2a,6f,00,04,42,85,52,45,3a,2f,00,08,42,80,12,1d,d1,01,51,cd,ff,fa,4e,75.F.1***********  Disk-Prozeduren  **********1"+�(F128 Byte pro Sektor setzen ζ��    FIM�*FSicherheits-Abfrager β��Fr
OK6�E��    !� FNull$ in die richtige L�nge bringen  �� <   !�F 	128 BpS abhaken "�� @   !�F 	256 BpS Haken wegi�E�     F 
L�nge setzen*M�+F 
Disketten initialisieren + l�schenF F .FE"+�)F256 Byte pro Sektor setzen Ϭ��    FnM�*F
Sicherheits-Abfragee Ϩ��Fe�E��    !� F"�� <   !�FN	128 BpS Haken weg  �� @   !�FN	256 BpS abhakeng�E�     FN
L�nge setzen M�+F 
Disketten initialisierenF F .FE+�*F 
Sicherheits-AbfrageiF)�!�, Gr��enver�nderung l�scht|     alle Daten !|!�!� Stop | OK !�F �\��Fn&J� !�FDisketten beide leer meldencM�-F�und anzeigenF.F  $+�/FSektornummer-Anzeige ein/aus ���Fswenn eingeschaltet�E�Fdann ausschalten ��F �E�Fsonst einschalteneF  �� D   !�FZustand anzeigen.F  +� �� FaSektorsumme setzen  �v��    FmSektoren 1-3$�
E�     F immer 128 Bytes lang іF �
E�F sonst volle L�ngetFE
�Ez�
 F&�E����z�� @�  !�
 Faufsummieren�� @� E�F Summe retten.FE  +�F�** Directory anzeigen **^�� �F

Fenster �ffnenYFund l�schenr�� "Fd	Cursor setzene�E�F	Spaltenflag: links $ լ��  �F
 *  Single Density *. ���E�4�  G�8   FDirectory-Sektoren* Բ�E�G�b   H�    Frdurchsucheno�E� F8
ԲZ?�� @� @��     @� B� FEnde des Directory2 Ԩ?�� @� @�@� B�     FFile gel�scht ?e>�E?�� @� @��    @�0    Fnein: Filenamen ermittelnl.;�@�      "�."=�@� WWW"F und ausgeben@7?�� @� @��@�  �     7?�� @� @��@�  "FFile-L�nge�E�FSpaltenflag toggeln �p�Frwenn linke Spaltee$FECursor an Zeilenanfang setzen� ԤFA0��P    "�| "Fsonst Trennzeichen ausgeben�F F 
	���F <
��Z��dd    ?�� @� @��     @� B� Fggf. Ende�
	���FFZ�E#7?�� @�44    @�     @�  �    7?�� @� 4    @�     @�   Ffreie Sektoren4�W�
Sektoren =W�#�� W�
Bytes freiF?ausgeben �`F * Double Density *s. װ�E�    G�@   FnDirectory-Sektoren@ �p�E�#��     �     G�b   H�    F durchsuchen �E� F0
�pZ?�� @� @��@� B� F�Directory-Ende ?2 �f?�� @� @�@� B�     FFile gel�scht ?8�E?�� @� @��@�0    Fnein: Filenamen ermittelnhF;�@�      "�."=�@� WWW7?�� @� @��@   @�  "Fund ausgeben�E�F
 �0�F F Cursor setzen  �bF#.��P    "�| "Foder Trennzeichen ausgebenF F 
	��F 6
װZ��dd    ?�� @� @��@� B� Fggf. Ende 
	���FF j�F ��E�G�    F < �?�� @� @    @�@� B�~    Ffreie Cluster z�hlen4�F?F
	���F >�W�Blocks =W��    �W�
Bytes freiF.Anzahl ausgebenaF F .F 4+�+Fbeide Disketten initialisieren bzw. l�schen  ؾ� E�G�F M�	Fr
	خ� FG.F	,+�	FDiskette initialisieren bzw. l�schen �X�E�     G�@   F2�� @� E��    !� FSektor 1-3 immer 128 Bytes�� @� E�       F 
	��F� ���E�    G�@  
F6�� @� E��!� FFsonst volle L�nge mit 0 auff�llen &�� @� E�FSumme nicht vergessen !m
	�r�F�$^� ��F�Disketten-Fenster �ffnenYFund l�schent.F
&+�
F�* ganze Diskette abspeichern * �@��  FM�FaFile-Selects �<�� F}�FMaus=Biene: Busy ���E�@  
I�     F 8
��Z�� @� ��!� FlEnde beim ersten leeren Sektor
	ژ�F *7�R!M�!�!��Fe	Random-Datei er�ffnen "PM�!�l� !�l�	FFeld definierenf4�EA� �DA��   �LA� Ferst alle Parameteri�	E� FN� E�F�M�!�F abspeichern�" ���E�G�F	dann alle SektorenN� E�� @� Fmit Inhalt �	EB�� @�  FIund Pr�fsummee�M�!��F
abspeichern�
	ۢ�F!8M�F�Datei schlie�en�}�FMaus wieder normalFFfertig !F .FF +�FM* ganze Diskette laden *�E�      FL* ����  F	wenn Diskette schon belegt:PL)�      !�# Laden l�scht den |   alten Inhalt|!�     !� OK | Cancel !�FF  ����     F M�FFile-Selectt ߴ�� F}�FMaus=Biene: Busy M�	FaDiskette initialisieren$7�I!M�!�FRandom-Datei er�ffnenl$� E_�   !M� FtParameter ladenf&�E5�  F�Sektor-Anzahl feststellen8>��  E5?� @C� @�D �@�      FnDiskettenformat ermittelna< �N�5?� @C� @�L �@�      Festimmt die BpS-Zahl ?n ގ��    F	ja4� E_�    !M� Fjggf. restlichen 128 Bytes lesen-FE ���E�G�F �� @� E_�!M� FSektorinhalt&�� @� E7_�!M�  Ftund Summe laden8
	ޜ�F_ �F�E�     G�@   F)6�� @� E;�� @� @�      FSektor 1-3 ggf. k�rzen
	��F; �~F,)�!� Falsche Sektor-L�nge |!�!� Stop !�FF 8M�F@Datei schlie�en M�,FDisk-Info anzeigenF }�FMaus wieder normalM�FaDirectory ausgebenFfertig !.F+�FeFile-Selector ausgebenf�\*.dsk!� !�F  �XC�@�. �       �� F!�E��.dskFFE.F
  +�FDiskettenzustand toggeln�E�� �Fk^�FDisk-Fenster �ffneng �4��  Fwenn gesetzt��  E�Fsdesaktivierena.��    �   � !�Fund Haken entfernen."]�!� InaktivFZustand anzeigen �F ��  E�Fksonst setzen&��    �   � !�Fund abhakentM�,F und Zustand anzeigenF .FE $+�4F
* Diskette formatieren: SD *2M�7F
Sicherheits-Abfrage und ggf. Disk l�schenr �d��FrP��� @�4    !�!�      EB� B�C    B� B�C    B� F707 freie Sektoren&��� @�4    !� 0   !� EB�p    FL��� @�4    !� @   !�2    E��2   !�    Ffreie Sektoren in VTOC@��� @�4    !� `   !� EB� B�~    FDir-Sektoren belegen8�� @� 4    E� `   FEPr�fsumme VTOC-Sector setzen��  E�F Diskstatus: SDM�,FEanzeigenF .F7$+�6F* Diskette formatieren: DD *0M�7FSicherheitsabfrage und ggf. Disk l�schen ����FrN��� @�     !� p   !� EB�|    B�%    FDirectory-Sektor vorbereiten,�� @�      E�    Fn
und Summe setzen ��E�G�    F ,��� @�@    !� EB�~    FVTOC f�llen
	�V�F 8�� @� @    E� ~   Fu	Pr�fsumme VTOC-Sektor setzen��  E�F Diskstatus: DDM�,FEanzeigenF .F70+�7F
Sicherheitsabfrage und ggf. Disk l�schen(� E�#�� �    Fwelche Diskette ? �E�F$ ���  Fwenn schon formatiert:8)�!� Formatieren l�scht alles ! |!�!� OK | Stop !�FSF * �
��Fwenn Formatierung gew�nscht�(M�	F�Disk initialisieren bzw. l�schenF .F7 (+�-FStatus beider Disketten anzeigen �X� E�G�F M�,Fr
	�H� F .F "+�,FDisketten-Status anzeigenl ���  �       F]� ��!� InaktivF �bF  ����  �       F "]�� �!� Aktiv : unformatiertF  �^F  �2��  �      F�$]� ��!� Aktiv : Single densityF �ZF $]� ��!� Aktiv : Double DensityFFF F.F  .**********  Printer-Prozeduren  **********e	&+�F*Direktausgabe ein-/ausschalten ����     F�� h   !�FT�E�       F  �F �� h   !�FT�E�      F FEM�FStatus ausgebenn.FE  +�FPuffer ein-/ausschaltenh^�     F YF   ����Fs
wenn eingeschaltet�� p   !�FwHaken wegh�E�FFlag l�schen�E� Fl
Puffer l�schen �F �� p   !�Fesonst abhakene�E�Fund Flag setzenhFEM�FStatus ausgebenc.FE +�FPufferinhalt ausdrucken* ���� Fwenn �berhaupt was drin ist*L)�      !�# Puffer drucken | Drucker fertig ?|!�    !� OK | Nein ! !�F ����     Fr;�F�ausdrucken wenn OKF F.F +�FPufferinhalt abspeichern ��� Fwenn nicht leerrf�\*.*!� !�F� ��� F7�O!M�!�FDatei �ffnenM�!�FPuffer schreiben8M�F�Datei schlie�eneF F�.F�+�FPufferinhalt ausgebenr^�     F�F .F+�FPuffer l�schen�E� F.FE +�FDrucker ein-/ausschalten" ����Fewenn eingeschaltet:r��    !�FwHaken wegh ��E�h   G�x   F(��!�FMen�punkte unw�hlbar schaltent
	�x�F�E�       F  �8F ��    !�Fpsonst abhaken  �&�E�h   G�x   F$��!�FMen�punkte w�hlbar machent
	���F�E�      F FEM�FFDruckerstatus anzeigen.FE&+�FdList-Funktion ein-/ausschalten ����     F�� x   !�Fuentweder aus-s�E�       F  ��F  �� x   !�Fuoder einschalten�E�      F FEM�F und Status anzeigenl.F+�FDruckerstatus anzeigen� E� F�
 �j�F � E� Direkt-Druck F FE
 ��F� E� � Puffer FFE
 ���F� E� � List FFE ����      F� E� InaktivFnFE]�     !� F.F ****  Copy-Prozeduren  **** +�"F*** Disk to ST Copy ***m&� E�� �     F welche Diskette ?t( ����  F wenn �berhaupt formatiert:^�� �F Fenster �ffnen4:�Welches File kopieren :"�FtFilenamen eingeben8:�$9B => 10,13 (j,n) "�F�
CRLF in LF und CR �ndern ?
�E� F $�EC�@�. F3Extender vorhanden ?* ��F.#wenn ja, Filenamen formatierenB� E;�@��      ��   � =�@6� � ��@   #6� �  F ��F�4� E��� 0   6�  Fmsonst nur Blanks anh�ngenrFEE � ��  �      F�** Single Density **�E�       F . �R�E�4�  G�8�  FtDirectory-Sektoren< �>�E�G�b   H�    Frnach dem Filenamen durchsuchenB �?�� @� @��    @�0    �  ?�� @� @�@�       �CFN�E7?�� @� @��@@   @�       7?�� @� @��    @�       �    F F "
�>Z�FAbbruch, wenn gefunden
	�~�F 

�RZ�F
	�B�F " ���Fbwenn File nicht da:@)�      !� Datei nicht vorhanden ! |!�      !� Na gut !�F F  ��FFsonst � E� FFPuffer l�schenFE6� E� ;�� @� @7=�� @� @�   FeSektoren in PufferT�E#7?�� @� @� |   @�        �@    �     7?�� @� @�~~   @�       F ����      F*> �;� @� �JFu
Konvertierung CRLF in LF,CR gew�nscht ?$�E� B�     FPuffer kopierene� E� F�E�      F " ��E�G6� Fund durchsuchens. �?�@�@� B�    Fwenn CRLF gefunden>� E� ?�@�@�� B�      B�P    FLF und CR anh�ngen�E��     F�FE
	��FF 4f�\*.*!� !�FFilenamen zum Abspeichern erfragen ��� F"��!z�  !6�  F und abspeicherneF F  ��F ** Double Density **�E�       F . ���E�    G�@   FcDirectory-Sektoren@ ���E�#��     �     G�b   H�    FdurchsuchenoH �b?�� @� @��     @�0    �  ?�� @� @�@�       B�     F �E7?�� @� @��PP   @�  F�B�E7?�� @� @��``   @�  �    7?�� @� @��p   @�  F F "
��Z�FAbbruch, wenn gefunden
	���F 

��Z�F
	�t�F  ����Fbwenn nicht da:2)�!� Datei nicht vorhanden ! |!�!� Na gut !�F�F  ���F} sonst@� E� F�Puffer l�schenFE.�E�HH   ��     F Cluster => Sektor  ���E�G�`   F,� E� ;�� @�� @� F 8 Sektoren/Cluster
	�d�FG0�E7?�� @�@    @��@�  Fnn�chster CLuster �"��}   F@bis $FD=EndeE* �l�6�  Fwenn ganzes File gefundenL$f�\*.*!� !�FFFilenamen erfragen ��!z�  !�F
und abspeicherna ��F  sonst:6)�!�   Dateifehler:  | Datei zu kurz|!�!� Pech !�FpF F!F Fz.F +�#F *** ST to Disk Copy *** $� E�� �,,   Fuwelche DisketteC$ �Z��  �Fist sie formatiert ?0)�!� Diskette unformatiert !|!�!� Stimmt !�F �FD^�� �F ja: Fenster �ffnenf�\*.*!� !�FeFile w�hlen v�� F ��;�@� �\Fz,�E=�@6� � FFilenamen ggf. korrigierenFE$7�I!M�!�FFile zum Lesen �ffnenr�EsM� FL�nge ermitteln  ����@  Fmzu gro� ?f8M�F ja: File schlie�en8)�!�  File zu gro� | f�r den ATARI|!�!�	 Abbruch !�F hFFj� F&�EC�@�. F-Filenamen formatierend
 ��F.B� E;�@��      ��   � =�@6� � ��@   #6� �  F �VF�6� E��� 0   6�  F 
in A$: formatierter FilenameFEE ����  �F** Single Density **tV ��#�� #7?�� @� 4    @�     @�  �    7?�� @� 4    @�     @�   F:)�!�"  File zu gro� | f�r die Diskette|!�!�	 Abbruch !�F ��Fj�!�F< ��E�4�  G�8�  Fe freien Directory-Eintrag suchen?" ���E�     G�b   H�    F 6
��Z?�� @� @�@� B�      ?�� @� @�@� B� F4�F
	�~�F 6
�Z?�� @� @�@� B�      ?�� @� @�@� B� F
	�\�F�M�2�� F%freien Sektor suchen��� @� !�!� E�BFcStatus2��� @� !��!� EB�#�� � }p��� FL�nge LO<��� @� !��!� EB#�#�� �}p��� �      FL�nge HI$��� @� !��!� EB� FSektor LO�4��� @� !��     !� EB��      FSektor HIF:��� @� !��     !�0    E� FoFilenamen einsetzenn M� �� F�'und Pr�fsumme setzen �8�E�G�#�� H#�� F*�� @� E_#�� !M� FSektoren einlesenn�E�FE*M�2�� F# n�chsten freien Sektor suchenn:�� @� E�� @� B��    �    � B� B#��  FM� �� Fn Pr�fsumme setzen
	�|�FG&�E�
#�� FRest in letzten Sektor6�� @� E_�!M� �#�� � B��      B� B� FM� �� F�%Pr�fsumme setzen** VTOC korrigieren ** �E�44   F�)VTOC-SektorD��� @� !�    !� EB7?�� @� @�     @�  #�#��   �    FF��� @� !�    !� EB7?�� @� @�     @�  %�#�� �       F "M� �� F%Pr�fsumme VTOC setzenkF SD File zu gro�V2 ,F** Double Density **tj�F�  6�E�G�    F <  ,?�� @� @    @�@� B�~    Ffreie Cluster z�hlen4�F?F
	���F "  ����     
Fzu gro� ? <)�!�#  File zu gro� | f�r die Diskette |!�!�	 Abbruch !�F  Fi�E�       F < ��E�    G�@   Frfreien Directory-Eintrag suchen8 ^�E�     #��     �     G�b   H�    FF6
^Z?�� @� @�@� B�      ?�� @� @�@� B� F
	�F 6
�Z?�� @� @�@� B�      ?�� @� @�@� B� F
	 ��F &M�3�� Fersten freien Cluster suchen0��� @� !�!� EB� @    F	Eintrag freigebent4��� @� !��!� 0    E� FaFilenamen eintragen 0��� @� !�� @   !� EB��     
�}p��� F8��� @� !�� P   !� EB� FaStartcluster eintragen4��� @� !�� `   !� EB� FrL�nge eintragen LO,��� @� !�� p   !� EB��      FHI
M� �� F�* ��E�G�H�     
FEDaten schreibenH�E��FSektor berechnen( �E�G��`   FtCluster f�llen ���F �� @� E_�!M� F	Sektor laden
�E��F �F$�� @� E_�!M� F	oder Rest ladenlF M� �� F�Pr�fsumme setzen
ZrM� F
	j�F_
�ZrM� F�E�FG4�F *M�3�� Fsn�chsten freien Cluster suchen<��� @�@    !��!� EB� FiZeiger auf n�chsten ClusterT
	(�FG:��� @�@    !��!� EB�}    FEnde des Files setzenn�E�@@   F "M� �� F VTOC-Pr�fsumme setzenF F DD File zu gro�|Fsingle/double Density M�F Directory ausgeben8M�F@F File zu gro� f�r ATARIF	no FilegFunformatiert.F  *+�2�� Fcn�chsten freien Sektor sucheneh�!�Fj�F?  &�E�0   ��     G�F4
&Z?�� @�4    @�@� B� Ffreies Byte suchen
	��F� |�E�`   I�F@8
|Z7?�� @� 4    @�@�  �	�Ffreies Bit suchenh
	:�F�B�E#�� 0    �     #� `   � F n�chster freier SektorF��� @�4    !�!� EB7?�� @�44    @�@�  �	� FoSektor belegen.F2 *+�3�� Fnn�chsten freien Cluster suchen ��E�G�     F�@
�Z?�� @�@    @��@� B�~    Ffreien Cluster sucheno
	L�F�.F �                                                                                                                                                                   
��                          �| �                         
��  �x                                      �                                                                                                                      
�                      =h                    =\  =t        
�      �� ��     �� �� ö� �D��                 �4 �� �� �
 �� �< �h     �X     �" �� �L             �             �� �� � �> �                 �& ��                 Ͳ �� �� ؠ �~ �: �� Ј     �~��� �     � �& �\ �x