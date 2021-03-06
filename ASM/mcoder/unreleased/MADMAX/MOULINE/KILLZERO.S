LOAD=$40000
LONG=32000

PRINT:	MACRO
	PEA	?1
	MOVE	#9,-(SP)
	TRAP	#1
	ADDQ	#6,SP
	ENDM

	MOVE	#$2F,-(SP)
	TRAP	#1
	ADDQ	#2,SP
	MOVE.L	D0,DTA

	LEA	DIRECTORY,A6

	CLR	-(SP)
	PEA	FILE(PC)
	MOVE	#$4E,-(SP)
	TRAP	#1
	ADDQ	#8,SP
	TST	D0
	BNE	ERREUR
PUSHDIR:
	MOVE.L	DTA,A0
	LEA	30(A0),A0
COPYDIR:MOVE.B	(A0)+,(A6)+
	BNE.S	COPYDIR

	MOVE	#$4F,-(SP)
	TRAP	#1
	ADDQ	#2,SP
	TST	D0
	BEQ.S	PUSHDIR
	ST	(A6)

	LEA	DIR,A6
LOADER:
	MOVEQ	#0,D0
	TST.B	(A6)
	BMI	ERREUR

	PRINT	CR0(PC)
	PRINT	(A6)
	PRINT	CR1(PC)

	LEA	LOAD,A0
	MOVE	#LONG/4-1,D0
	MOVEQ	#0,D1
CLEARE:	MOVE.L	D1,(A0)+
	DBRA	D0,CLEARE

	CLR	-(SP)
	PEA	(A6)
	MOVE	#$3D,-(SP)
	TRAP	#1
	ADDQ	#8,SP
	MOVE.L	D0,D7
	BMI	ERREUR

	PEA	LOAD
	PEA	LONG
	MOVE	D7,-(SP)
	MOVE	#$3F,-(SP)
	TRAP	#1
	LEA	12(SP),SP
	TST.L	D0
	BMI.L	ERREUR
	MOVE.L	D0,NBBYTES

	MOVE	D7,-(SP)
	MOVE	#$3E,-(SP)
	TRAP	#1
	ADDQ	#4,SP

	CLR.B	CHANGE
REFAIT:
	LEA	LOAD,A5
	ADD.L	$14(A5),A5
	MOVEQ	#0,D7
COUNT:
	MOVE	(A5),D0
	OR	2(A5),D0
	OR	4(A5),D0
	BEQ.S	FINCNT
	CMP	(A5),D7
	BNE	KILL0
CONT:
	MOVE	2(A5),D7
	ADDQ	#1,D7
	ADDQ	#6,A5
	BRA.S	COUNT
KILL0:
	BSR	KILLIT
	BRA	REFAIT

FINCNT:
	MOVE	D7,D0
	SUBQ	#1,D0
	CMP	LOAD+$2A,D0
	BEQ	LOOP
	BSR	KILLIT
	BRA	FINCNT

LOOP:
	TST.B	CHANGE
	BNE	ERREUR0

LOOP1:	TST.B	(A6)+
	BNE.S	LOOP1
	BRA	LOADER

ERREUR1:
	PRINT	MESS1(PC)
	BRA	LOOP
ERREUR0:
	LEA	LOAD,A0
	LEA	LOAD,A1
	ADD.L	NBBYTES,A1
	MOVE.L	A0,A2
	ADD.L	$14(A2),A2
	ILLEGAL
ERREUR:
	MOVEQ	#-1,D1
	illegal
KILLIT:
	BHS	ERREUR1

HEXA:	MACRO
	ADD	#'0',D0
	CMP	#$3A,D0
	BLO.S	L?0
	ADDQ	#7,D0
L?0:
	ENDM

	MOVE	D7,D0
	LSR	#4,D0
	HEXA
	MOVE.B	D0,HEX
	MOVEQ	#$F,D0
	AND	D7,D0
	HEXA
	MOVE.B	D0,HEX+1
	PRINT	MESS2(PC)
;
; D7=NUMERO DU PATTERN A ENLEVER
;
	MOVE	D7,D0
	MULU	#12,D0
	LEA	LOAD,A0
	ADD.L	$10(A0),A0
	ADD.L	D0,A0

	MOVE.L	(A0),D0
	OR.L	4(A0),D0
	OR.L	8(A0),D0
	BEQ.S	VIDE

	MOVEM.L	D0-D7/A0-A6,-(SP)
	PRINT	MESS3(PC)
	MOVEM.L	(SP)+,D0-D7/A0-A6


;	BRA	LOOP

	MOVE.L	A0,A2
	LEA	LOAD,A0
	MOVE.L	A0,A1
	ADD.L	NBBYTES,A1

	ILLEGAL
VIDE:
	LEA	LOAD,A1
	ADD.L	$14(A1),A1
	CMP.L	A1,A0
	BHS	ERREUR
MOVEL:
	MOVE.L	12(A0),(A0)+
	MOVE.L	12(A0),(A0)+
	MOVE.L	12(A0),(A0)+
	CMP.L	A1,A0
	BLO.S	MOVEL
	BNE	ERREUR

	SUBQ	#1,LOAD+$2A
	SUB.L	#12,LOAD+$14
	CLR.L	-(A0)
	CLR.L	-(A0)
	CLR.L	-(A0)
	CMP.L	#'DIGI',LOAD
	BEQ	COPYMUS

;	CMP.L	#'MMME',LOAD+32
;	BEQ.S	SUB6
;	CMP.L	#'TFMX',LOAD+32
;	BNE.S	COPYMUS
;SUB6:
	SUB.L	#12,NBBYTES

COPYMUS:
	MOVE	(A1),D0
	OR	2(A1),D0
	OR	4(A1),D0
	BEQ	FINMUS
	MOVE	(A1)+,(A0)+
	MOVE	(A1)+,(A0)+
	MOVE	(A1)+,(A0)+
	BRA.S	COPYMUS
FINMUS:
	CLR.L	(A0)+
	CLR.L	(A0)+
	CLR.L	(A0)+
	LEA	LOAD,A0
	ADD.L	$14(A0),A0

RENUM:
	MOVE	(A0),D0
	OR	2(A0),D0
	OR	4(A0),D0
	BEQ.S	FINRENUM

	MOVE	(A0)+,D0
	CMP	D7,D0
	BEQ	ERREUR
	BLO.S	NO1
	SUBQ	#1,-2(A0)
NO1:
	MOVE	(A0)+,D0
	CMP	D7,D0
	BEQ	ERREUR
	BLO.S	NO2
	SUBQ	#1,-2(A0)
NO2:
	ADDQ	#2,A0
	BRA	RENUM

FINRENUM:
;	LEA	LOAD,A0
;	LEA	LOAD,A1
;	ADD.L	NBBYTES,A1
;	MOVE.L	A0,A2
;	ADD.L	$14(A2),A2

	ST	CHANGE
	RTS

NBBYTES:DC.L	0
DTA:	DC.L	0
CHANGE:	DC.B	0
CR:	DC.B	13,10,0
CR0:	DC.B	13,0
CR1:	DC.B	27,'K',0
FILE:	DC.B	'*.MUS',0
MESS1:	DC.B	9,"ERREUR INTERNE",13,10,0
MESS2:	DC.B	9,"$"
HEX:	DC.B	"00 PATTERN A DEGAGER",13,10,0
MESS3:	DC.B	"PATTERN NON VIDE !!!",13,10,0
	EVEN
DIRECTORY:
DIR:
	BLK.B	1000
