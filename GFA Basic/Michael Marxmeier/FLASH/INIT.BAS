 GfABASIC       
               &   :   :   l   �   �   �   �  ~  &�  &�  &�  &�  &�  &�  &�  '   '   '  '   '   '   ' MN_CNTI TYPE CNTIBTATBMNOMIC OPADDR_MAADDR_MB TYPE_ATYPE_BOPCODESR_MODE_TYPE_AR_MODE_TYPE_BINIT_OPCODESMODE_TYPE_AMODE_TYPE_B N---------------------------------------------------------------------------DINIT68K.BAS - Erstelle Initialisierungs-Datei fr FLASH-AssemblerN$Programmierung Michael Marxmeiere(Nach einer Idee von Brian R.AndersongaVersion 18.06.87oeN--------------------------------------------------------------------------- Hinweise zum Programm-Ablauf:iLDa GFA-Basic keine Enumerierungs-Typen (Mengen) wie z.B. Pascal, Modula2-Bund C++ untersttzt, wurden Sie hier mit Konstanten simmuliert.nDEs werden 2 Mengen gebildet, in denen die Adressierungsarten desMHMC68000 gespeichert sind.  Die einzelnen Elemente werden als Potenzenvon 2 gespeichert. oN------------------------------------------------------------------------------- global declarations-@*� �      !��      F Zwischenspeicher fr Mengen A und B$*��pp    F Opcodes des MC68000*� �pp    F Opcode 8*��pp    !��pp    F Adressierungsarten A und B --- Init-H�BINIT68K - Erstellen der Initialisierungs-Datei fr FLASH-AssemblerF-FB�- Erstellen der TabellenFnM� FE --- Abspeichern-�- AbspeichernF7�o!M�!�	FLASH.datFaM�"� F    �E�G� �FM�"�� FM�"� � FM�"�� FM�"�� F
	    �FF8F  �- FertigFqFN---------------------------------------------------------------------------Init Operation codes-N------------------------------------------------------------------------------- init opcodes--+� FiR� Fi Lese Menge A-    �E�G�    F-Q� � F
	    �FG R�F� Lese Menge B-    �E�G�    F-Q�� F
	    �FG R�F� Lese Mnomics-� E�FFEQ��  F
    Z��  �$Fs Q� FZ Erstelle Opcode
    � Fs    �E�G� FQ�F�0� �  !�	�F 
	    �F�F  &Q� F� Erstelle Adressierungsarten A
    � Fs    �E�G� FQ� F�M�F�0��  !�	�F 
	    �F�F  &Q� F� Erstelle Adressierungsarten B
    � Fs    �E�G� FQ� F�M�F�0��  !�	�F 
	    �F�F 4� F�    F.F   --- Ermittle Wert in Menge Ar-+�FE�E�FFE
    Z�� �$F     � � � F -�F�F4�F�    F �	Mnomic = "��  FF� "�> ist nicht definiert in Adressierungsart A -- Bitte besttigenFF     S� F qF  �|FS.F||
Menge A
-------,RegMem3:  0 - 0 = Register, 1 = Speichers(Ry02   :  1 - Register Rx -- Bits 0-2*Rx911  :  2 - Register Ry -- Bits 9-11r.Data911:  3 - Immediate Daten -- Bits 9-11r6CntR911:  4 - Zhler-Register oder Immediate DatenB&Brnch  :  5 - Relative VersweigungI&DecBr  :  6 - Decrement and BranchI0Data03 :  7 - Wird nur fr Vektoren verwendetData07 :  8 - MOVEQOpM68D :  9 - DatenOpM68A : 10 - AdresseOpM68C : 11 - CompareOpM68X : 12 - XOR(OpM68S : 13 - Vorzeichen-Erweiterunge"OpM68R : 14 - Register/Speicher$OpM37  : 15 - Vertausche Registerp� |F7
RegMem3Ry02mRx911
Data911
CntR911BrnchDecBr
Data03
Data07
OpM68D
OpM68A
OpM68C
OpM68X
OpM68S
OpM68ROpM37$ --- Ermittle Wert in Menge Bs-+�FE�E�FFE
    Z�� �$F     �� � F -�F�F4�F�    F�	Mnomic = "��  FF� "�> ist nicht definiert in Adressierungsart B -- Bitte besttigenFF     S� F qF  �|FS.F||
Menge B
-------<Bit811   :  0 - BIT Operationen - Bits 8/11 als Schalterb6Size67   :  1 - 00 = Byte, 01 = Wort, 10 = Langwort*Size6    :  2 - 0 = Wort, 1 = Langwort06Size1213A:  3 - 01 = Byte, 11 = Wort, 10 = Langwort,Size1213 :  4 - 11 = Wort, 10 = Langwort=4Exten    :  5 - OpCode Erweiterungsteil notwendig,EA05a    :  6 - Effektive Adresse - ALLEoEA05b    :  7 - Ohne 1v EA05c    :  8 - Ohne 1 und 11$EA05d    :  9 - Ohne 9, 10 und 11(EA05e    : 10 - Ohne 1, 9, 10 und 11L&EA05f    : 11 - Ohne 0, 1, 3, 4, 11EA05x    : 12 - OR/AND EA05y    : 13 - ADD/SUBEA05z    : 14 - MOVEM*EA611    : 15 - nur fr MOVE verwendetEA�|F1
Bit811 
Size67 Size6Size1213ASize1213ExtenEA05aEA05bEA05cEA05dEA05eEA05fEA05xEA05yEA05zEA611$--- OpCode tabelle -1. Mnomic2. Anzahl der Bits, BitsO 3. Anzahl Adressierungsart Av 4. Anzahl Adressierungsart Bv.�|Fn
"ABCD"h3,15,14,83,Rx911,RegMem3,Ry02g0"ADD"3,15,14,12M1,OpM68D2
1,EA05y,
"ADDA"3,15,14,12M1,OpM68A2
1,EA05a,
"ADDI"
2,10,903,Size67,EA05e,Exteng,
"ADDQ"7
2,14,121,Data9112,Size67,EA05dE,
"ADDX"74,15,14,12,8d3,RegMem3,Rx911,Ry02g1,Size67,,"AND"
2,15,141,OpM68D,
1,EA05x,
"ANDI"1,903,EA05e,Size67,Exteng,"ASL"4,15,14,13,871,CntR9110"ASR"3,15,14,1381,CntR9110"BCC"3,14,13,108
1,Brnch0
"BCHG"1,603,EA05e,Exten,Bit811g,
"BCLR",1,703,EA05e,Exten,Bit811g,"BCS"4,14,13,10,8,
1,Brnch0"BEQ"5,14,13,10,9,8i
1,Brnch0"BGE"4,14,13,11,10
1,Brnch0"BGT"5,14,13,11,10,9
1,Brnch0"BHI"3,14,13,9
1,Brnch0"BLE"6,14,13,11,10,9,8
1,Brnch0"BLS"4,14,13,9,8
1,Brnch0"BLT"5,14,13,11,10,8
1,Brnch0"BMI"5,14,13,11,9,8
1,Brnch0"BNE"4,14,13,10,98
1,Brnch0"BPL"4,14,13,11,98
1,Brnch0"BRA"
2,14,13
1,Brnch0
"BSET"2,7,603,EA05e,Exten,Bit811g,"BSR"3,14,13,8
1,Brnch0
"BTST"003,EA05c,Exten,Bit811g,"BVC"3,14,13,11e
1,Brnch0"BVS"4,14,13,11,8,
1,Brnch0"CHK"3,14,8,71
1,Rx911
1,EA05b,"CLR"
2,14,902,Size67,EA05ei,"CMP"3,15,13,1201,OpM68C2
1,EA05a,
"CMPA"3,15,13,1201,OpM68A2
1,EA05a,
"CMPI"
2,11,1003,Size67,EA05e,Exteng,
"CMPM"75,15,13,12,8,3E2,Rx911,Ry0231,Size67y,
"DBCC"76,14,12,10,7,6,3t
1,DecBr0
"DBCS"7,14,12,10,8,7,6,3n
1,DecBr0
"DBEQ"8,14,12,10,9,8,7,6,3g
1,DecBr0"DBF"6,14,12,8,7,6,3
1,DecBr0
"DBGE"7,14,12,11,10,7,6,3
1,DecBr0
"DBGT"8,14,12,11,10,9,7,6,3
1,DecBr0
"DBHI"6,14,12,9,7,6,3
1,DecBr0
"DBLE"9,14,12,11,10,9,8,7,6,3
1,DecBr0
"DBLS"7,14,12,9,8,7,6,3
1,DecBr0
"DBLT"8,14,12,11,10,8,7,6,3
1,DecBr0
"DBMI"8,14,12,11,9,8,7,6,3
1,DecBr0
"DBNE"7,14,12,10,9,7,6,33
1,DecBr0
"DBPL"7,14,12,11,9,7,6,33
1,DecBr0
"DBRA"6,14,12,8,7,6,3
1,DecBr0"DBT"5,14,12,7,6,3
1,DecBr0
"DBVC"6,14,12,11,7,6,33
1,DecBr0
"DBVS"7,14,12,11,8,7,6,33
1,DecBr0
"DIVS"4,15,8,7,68
1,Rx911
1,EA05b,
"DIVU"3,15,7,66
1,Rx911
1,EA05b,"EOR"3,15,13,1281,OpM68X2
1,EA05e,
"EORI"
2,11,903,Size67,EA05e,Exten,"EXG"3,15,14,8
1,OpM370"EXT"
2,14,111,OpM68S0"ILLEGAL"9,14,11,9,7,6,5,4,3,200"JMP"6,14,11,10,9,7,6,0
1,EA05f,"JSR"5,14,11,10,9,760
1,EA05f,"LEA"4,14,8,7,69
1,Rx911
1,EA05f,
"LINK"6,14,11,10,9,6,4,
1,Ry02,
1,Exten,"LSL"6,15,14,13,9,8,3,1,CntR9110"LSR"6,15,14,13,9,8,3,1,CntR9110
"MOVE"1002,Size1213A,EA611,
"MOVEA"1,6
1,Rx9112,Size1213,EA05a,
"MOVEM"3,14,11,703,Size6,EA05z,Exten,
"MOVEP"1,31,OpM68RA
1,Exten,
"MOVEQ"3,14,13,1251,Data0720
"MULS"75,15,14,8,7,6
1,Rx911
1,EA05b,
"MULU"4,15,14,7,6
1,Rx911
1,EA05b,
"NBCD"
2,14,110
1,EA05e,"NEG"
2,14,1002,Size67,EA05ex,
"NEGX"71,14"02,Size67,EA05ex,"NOP"8,14,11,10,9,6,5,4,000"NOT"3,14,10,902,Size67,EA05e5,"OR"e1,15e1,OpM68DE
1,EA05x,"ORI"003,Size67,EA05e,Exten,"PEA"3,14,11,60
1,EA05f,
"RESET"7,14,11,10,9,6,5,4n00"ROL"8,15,14,13,10,9,8,4,31,CntR9110"ROR"7,15,14,13,10,9,4,31,CntR9110
"ROXL"16,15,14,13,10,8,41,CntR9110
"ROXR"15,15,14,13,10,41,CntR9110"RTE"9,14,11,10,9,6,5,4,1,000"RTR"10,14,11,10,9,6,5,4,2,1,000"RTS"9,14,11,10,9,6,5,4,2,0,00
"SBCD",
2,15,8,3,Rx911,RegMem3,Ry0200"SCC"5,14,12,10,7,6,0
1,EA05e,"SCS"6,14,12,10,8,7,6y0
1,EA05e,"SEQ"7,14,12,10,9,8,7,620
1,EA05e,"SF"55,14,12,8,7,60
1,EA05e,"SGE"6,14,12,11,10,7,60
1,EA05e,"SGT"7,14,12,11,10,9,7,60
1,EA05e,"SHI"5,14,12,9,7,60
1,EA05e,"SLE"8,14,12,11,10,9,8,7,60
1,EA05e,"SLS"6,14,12,9,8,7,60
1,EA05e,"SLT"7,14,12,11,10,8,7,60
1,EA05e,"SMI"7,14,12,11,9,8,7,60
1,EA05e,"SNE"6,14,12,10,9,7,660
1,EA05e,"SPL"6,14,12,11,9,7,660
1,EA05e,"ST"54,14,12,7,60
1,EA05e,
"STOP"8,14,11,10,9,6,5,4,10
1,Exten,"SUB"
2,15,121,OpM68D0
1,EA05y,
"SUBA"
2,15,121,OpM68A0
1,EA05a,
"SUBI"1,10"03,Size67,EA05e,Exten,
"SUBQ"73,14,12,81,Data9112,Size67,EA05dE,
"SUBX"73,15,12,83,Rx911,RegMem3,Ry021,Size67e,"SVC"5,14,12,11,7,6,0
1,EA05e,"SVS"6,14,12,11,8,7,6y0
1,EA05e,
"SWAP"3,14,11,6
1,Ry02,0"TAS"5,14,11,9,7,60
1,EA05e,
"TRAP"5,14,11,10,9,661,Data0300
"TRAPV"9,14,11,10,9,6,5,4,2,1,00"TST"3,14,11,902,Size67,EA05e5,
"UNLK"77,14,11,10,9,6,4,32
1,Ry02,0"$"
S "TST",3,14,11,902,Size67,EA05e4,
"UNLK"7�                                                                                                  