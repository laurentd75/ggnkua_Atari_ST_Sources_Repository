***************************************************************************
* Q u a s t  V I - programowanie w assemblerze							  *
***************************************************************************
* program  		 - Track II - odtwarzanie modulu na STe z czest. 12.5 Mhz *
* autor    		 - MCS             						      			  *
* typ Atari		 - STe												      *
***************************************************************************

	MOVE.L	4(SP),A0
	MOVE.L	$C(A0),D0
	ADD.L	$14(A0),D0
	ADD.L	$1C(A0),D0
	AND.L	#-2,D0
	LEA		STACK(PC),A7
	MOVE.L	D0,-(SP)
	MOVE.L	A0,-(SP)
	CLR		-(SP)
	MOVE	#$4A,-(SP)
	TRAP	#1
	LEA		12(SP),SP
	TST.L	D0
	BNE		GO_OUT

	CLR.L	-(SP)
	MOVE	#$20,-(SP)
	TRAP	#1
	LEA		6(SP),SP
	LEA		SAVE_STACK(PC),A0
	MOVE.L	D0,(A0)

	JSR		SAVE_INTERRUPTS(PC)
	JSR		MAIN(PC)
EXIT
	JSR		REINSTALL_INTERRUPTS(PC)

	MOVE.L	SAVE_STACK(PC),-(SP)
	MOVE	#$20,-(SP)
	TRAP	#1
	LEA		6(SP),SP

GO_OUT
	CLR		-(SP)
	TRAP	#1

SAVE_INTERRUPTS
	LEA		SAVE_INT(PC),A1
	LEA		$FFFF8200.W,A0
	MOVEP	$1(A0),D0
	MOVE	D0,4(A1)
	MOVE.L		$70,SVBL
	RTS

REINSTALL_INTERRUPTS
	MOVE.L		SVBL,$70
	MOVE.W 	#0,$FF8900
	RTS

MAIN

	JSR		INIT_MUZEXX(PC)
	JSR		PLAY_MUZEXX(PC)
	JSR		REINSTALL_INTERRUPTS(PC)
	CLR.L -(SP)
	TRAP #1

INIT_MUZEXX
	LEA		SEQ(PC),A0
	LEA		PAT(PC),A1
	LEA		NBR_INS(PC),A2
	LEA		MUZEXX(PC),A3
	MOVE	#$1D8,(A0)
	MOVE	#$258,(A1)
	MOVE	#15,(A2)
	CMP.L	#'M.K.',$438(A3)
	BNE		REAL_DOCs_MODULE
	MOVE	#$3B8,(A0)
	MOVE	#$43C,(A1)
	MOVE	#31,(A2)
REAL_DOCs_MODULE

	LEA		MUZEXX(PC),A0
	ADD		SEQ(PC),A0
	MOVE.L	#$80,D0
	MOVEQ	#0,D1
INIT_MUZEXX1
	MOVE.L	D1,D2
	SUBQ	#1,D0
INIT_MUZEXX2
	MOVE.B	(A0)+,D1
	CMP.B	D2,D1
	BGT.S	INIT_MUZEXX1
	DBF		D0,INIT_MUZEXX2
	ADDQ.B	#1,D2
	SWAP	D2
	LSR.L	#6,D2
	LEA		MUZEXX(PC),A0
	ADD		PAT,A0
	ADD.L	D2,A0
	LEA		20+MUZEXX(PC),A1
	LEA		16+INS(PC),A2
	MOVE	NBR_INS(PC),D0
	SUBQ	#1,D0
INIT_MUZEXX3
	MOVE.L	A0,4(A2)
	MOVEQ	#0,D1
	MOVE	22(A1),D1
	LSL.L	#1,D1
	MOVE.L	D1,(A2)
	ADD.L	D1,A0
	MOVEQ	#0,D1
	MOVE	24(A1),D1
	BEQ		INIT_MUZEXX4
	SUBQ	#1,D1
INIT_MUZEXX4
	MOVE	D1,12(A2)
	MOVEQ	#0,D1
	MOVE	28(A1),D1
	LSL.L	#1,D1
	CMP.L	#2,D1
	BNE		INIT_MUZEXX5
	MOVEQ	#0,D1
INIT_MUZEXX5
	SWAP	D1
	MOVE.L	D1,8(A2)
	LEA		30(A1),A1
	LEA		16(A2),A2
	DBRA	D0,INIT_MUZEXX3

	LEA		16+INS(PC),A0
	MOVEQ	#0,D0
	MOVE	4+SAVE_INT(PC),D0
	LSL.L	#8,D0
	SUB.L	#$8000,D0
	MOVE.L	D0,A2
	MOVE	NBR_INS(PC),D0
	SUBQ	#1,D0
REVERSE
	MOVE.L	(A0),D1
	BEQ		END_REVERSE_THIS_INS
	SUBQ.L	#1,D1
	MOVE.L	D1,D2
	MOVE.L	4(A0),A3
REV_1
	MOVE.B	(A3)+,D5
	ADD.B		#$80,d5
	LSR.W		#1,d5
	MOVE.B		D5,(A2)+
	DBRA	D1,REV_1
	MOVE.L	4(A0),A3
REV_2
	MOVE.B	-(A2),(A3)+
	DBRA	D2,REV_2
END_REVERSE_THIS_INS
	LEA		16(A0),A0
	DBRA	D0,REVERSE

	LEA 		MU,A0
	MOVE.W		#2520,D0
CCLR	MOVE.L 	#0,(A0)+
	DBF		D0,CCLR
 	
	MOVE.W	#1,$FF8920   ;sound-mode
				;00 6250hz
				;1  12517hz
				;2  25033hz
				;3  50066hz
				; mono +128 

	LEA		MUSIQUE_END,A0	
	MOVE.L		A0,D0
	MOVE.W		D0,$FF8912
	ROR.L		#8,D0
	MOVE.W		D0,$FF8910
	ROR.L		#8,D0
	MOVE.W		D0,$FF890E

	LEA		MU,A0
	MOVE.L		A0,D0
	MOVE.W		D0,$FF8906
	ROR.L		#8,D0
	MOVE.W		D0,$FF8904
	ROR.L		#8,D0
	MOVE.W		D0,$FF8902
	MOVE.L		#$33fc0003,rt
	MOVE.L		#$00ff8900,rt+4	
	;MOVE.W 	#3,$FF8900
	; control : 0:off
	;           1:one play
	;	     2: loop				
	RTS


PLAY_MUZEXX
ON	
	MOVE	#6,SPD+2
	MOVE.B	#6,SPEED
	MOVE.B	#1,POS
	LEA		MUZEXX(PC),A0
	ADD		SEQ(PC),A0
	LEA		-2(A0),A0
	MOVE.B	(A0)+,TRK
	MOVE.L	A0,MUS+2
	LEA		OFF(PC),A0
	LEA		OFF(PC),A1
	LEA		OFF(PC),A2
	LEA		OFF(PC),A3
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVEQ	#0,D2
	MOVEQ	#0,D3
	CLR.L	V0+2
	CLR.L	V1+2
	CLR.L	V2+2
	CLR.L	V3+2
	CLR.L	F0+2
	CLR.L	F1+2
	CLR.L	F2+2
	CLR.L	F3+2

	MOVE.L	#VBL,$70.W
PROGRAM			

	CMP.B	#$39,$FFFFFC02
	BEQ		END_OF_MUZEXX
	BRA		PROGRAM



MUSC		DC.L	MU,MU+504,MU+1008,MU+1512,MU+2016,MU+2520,MU+3024
		DC.L	MU+3528,MU+4032,MU+4536,MU+5040,MU+5544,MU+6046
		DC.L	MU+6550,MU+7054,MU+7558,MU+8062,MU+8566,MU+9070
		DC.L	MU+9574

AMIGA	
	MOVE.B		MUSI,D7
	ADDQ.B		#4,D7
	CMP.B		#80,D7
	BNE.S		AM3
	MOVEQ.B	#0,D7
AM3
	MOVE.B		D7,MUSI
	MOVE.L		MUSC(PC,D7.W),A4
AMM
	MOVEQ		#0,D7
	MOVE.W		#252,D6
AM2
	SWAP		D0					;2 DOUBLE CYCLES	
	SWAP		D1					;2
	SWAP		D2					;2
	SWAP		D3					;2
V0	SUB.L		#0,D0					;8
	BMI.S		L0					;4
V1	SUB.L		#0,D1					;8
	BMI.S		L1					;4
V2	SUB.L		#0,D2					;8
	BMI.S		L2					;4
V3	SUB.L		#0,D3					;8
	BMI.S		L3					;4
OUT	SWAP		D0					;2
	SWAP		D1					;2
	SWAP		D2					;2
	SWAP		D3					;2
	MOVE.B		0(A0,D0),D4				;7
	MOVE.B		0(A1,D1),D5				;7
	ADD.B		0(A2,D2),D4				;7
	ADD.B		0(A3,D3),D5				;7	
	SUB.B		#$80,D5				;2
	SUB.B		#$80,D4				;2
	MOVE.B		D4,(A4)+			
	MOVE.B		D5,(A4)+
	DBF D6,AM2						;5
rt	MOVE.W 	#3,$FF8900
	MOVE.W		#$4E75,rt
	RTS	
	
L0	MOVE.L		#0,D0
F0	MOVE.L		#0,V0+2
	BRA		V1
L1	MOVE.L		#0,D1
F1	MOVE.L		#0,V1+2
	BRA		V2
L2	MOVE.L		#0,D2
F2	MOVE.L		#0,V2+2
	BRA		V3
L3	MOVE.L		#0,D3
F3	MOVE.L		#0,V3+2
	BRA		OUT

VBL	MOVEM.L	D0-D7/A0-A6,-(A7)
	MOVEM.L	REGIS,D0-D6/A0-A6
	MOVE.W		#$700,$FF8240
	JSR		AMIGA
	MOVE.W		#7,$FF8240
	SUBQ.B	#1,SPEED
	BEQ.S	PLAY
	MOVE.W		#5,$FF8240
	JSR		EFFECT
END_VBL
	MOVE.W		#$777,$FF8240
	MOVEM.L	D0-D6/A0-A6,REGIS
	MOVEM.L	(A7)+,D0-D7/A0-A6
	RTE

PLAY
NO_KEYBOARD1
	MOVEM.L	D0-D1/A0-A5,-(SP)
SPD	MOVE.B	#6,SPEED
	SUBQ.B	#1,POS
	BNE		NO_NEW_PATTERN
	MOVE.B	#64,POS
	ADDQ.L	#1,MUS+2
	SUBQ.B	#1,TRK
	BMI		RESTART
	MOVEQ	#0,D0
MUS	MOVE.B	$0,D0
	SWAP	D0
	LSR.L	#6,D0
	LEA		MUZEXX(PC),A0
	ADD		PAT(PC),A0
	ADD.L	D0,A0
	MOVE.L	A0,ADD_IN_PAT
NO_NEW_PATTERN
	MOVE.L	ADD_IN_PAT(PC),A0
	LEA		FRQ(PC),A1
	LEA		INS(PC),A2
	LEA		COMMAND(PC),A3
	LEA		VOICE0(PC),A4
	BSR		LOAD_VOICE
	LEA		VOICE1(PC),A4
	BSR		LOAD_VOICE
	LEA		VOICE2(PC),A4
	BSR		LOAD_VOICE
	LEA		VOICE3(PC),A4
	BSR		LOAD_VOICE
	MOVE.L	A0,ADD_IN_PAT
	MOVEM.L	(SP)+,D0-D1/A0-A5
* ADDRESS ALL 4 VOICES
	MOVEM.L	D4/A5,-(SP)
	LEA		VOICE0(PC),A5
	TST.B	20(A5)
	BEQ.S	CONT0
	MOVE.L	(A5),D0
	MOVE.L	4(A5),A0
	MOVE.L	8(A5),D4
	MOVE.L	D4,L0+2
	MOVE.L	12(A5),D4
	MOVE.L	D4,V0+2
	MOVE.L	16(A5),D4
	MOVE.L	D4,F0+2
CONT0
	CLR.B	20(A5)
	LEA		VOICE1(PC),A5
	TST.B	20(A5)
	BEQ.S	CONT1
	MOVE.L	(A5),D1
	MOVE.L	4(A5),A1
	MOVE.L	8(A5),D4
	MOVE.L	D4,L1+2
	MOVE.L	12(A5),D4
	MOVE.L	D4,V1+2
	MOVE.L	16(A5),D4
	MOVE.L	D4,F1+2
CONT1
	CLR.B	20(A5)
	LEA		VOICE2(PC),A5
	TST.B	20(A5)
	BEQ.S	CONT2
	MOVE.L	(A5),D2
	MOVE.L	4(A5),A2
	MOVE.L	8(A5),D4
	MOVE.L	D4,L2+2
	MOVE.L	12(A5),D4
	MOVE.L	D4,V2+2
	MOVE.L	16(A5),D4
	MOVE.L	D4,F2+2
CONT2
	CLR.B	20(A5)
	LEA		VOICE3(PC),A5
	TST.B	20(A5)
	BEQ.S	CONT3
	MOVE.L	(A5),D3
	MOVE.L	4(A5),A3
	MOVE.L	8(A5),D4
	MOVE.L	D4,L3+2
	MOVE.L	12(A5),D4
	MOVE.L	D4,V3+2
	MOVE.L	16(A5),D4
	MOVE.L	D4,F3+2
CONT3
	CLR.B	20(A5)
	MOVEM.L	(SP)+,D4/A5

	BRA		END_VBL

LOAD_VOICE
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVE	D0,30(A4)
	MOVE	(A0)+,D0
	BEQ.S	COMMAND?
	BTST	#12,D0
	BEQ.S	CONT_FRQ
	AND		#$FFF,D0
	MOVE	#$100,D1
CONT_FRQ
	MOVE.B	#1,20(A4)
	MOVE	D0,24(A4)
	ADD		D0,D0
	ADD		D0,D0
	MOVE.L	(A1,D0.W),D0
	MOVE.L	D0,12(A4)
	TST.L	16(A4)
	BEQ.S	CONT_LOAD_FRQ
	MOVE.L	D0,16(A4)
CONT_LOAD_FRQ
	OR.B	(A0),D1
	AND		#$FF0,D1
	BEQ.S	COMMAND?
	MOVE.L	12(A4),16(A4)
	MOVE.L	0(A2,D1.W),(A4)
	MOVE.L	4(A2,D1.W),4(A4)
	MOVE.L	8(A2,D1.W),8(A4)
	BNE.S	REPEAT
	CLR.L	16(A4)
REPEAT
COMMAND?
	MOVE	(A0)+,D0
	MOVE.B	D0,D1
	AND		#$F00,D0
	LSR		#6,D0
	MOVE.L	(A3,D0.W),A5
	JMP		(A5)

NO_COMMAND
	RTS

ARPEGGIO
	TST.B	D1
	BEQ.S	NO_ARPEGGIO
	MOVE.B	#0,22(A4)
	MOVE.B	D1,23(A4)
	MOVE.B	#1,21(A4)		*ARPEGGIO COUNTER
	MOVE	#1,30(A4)
NO_ARPEGGIO
	RTS

PORTAMENTO_UP
	MOVE.B	#1,22(A4)
	MOVE.B	D1,23(A4)
	MOVE	#1,30(A4)
	RTS

PORTAMENTO_DOWN
	MOVE.B	#2,22(A4)
	MOVE.B	D1,23(A4)
	MOVE	#1,30(A4)
	RTS

POSITION_JUMP
	LEA		MUZEXX(PC),A5
	ADD		SEQ(PC),A5
	LEA		-1(A5),A5
	MOVE.B	#1,POS
	MOVE.L	A5,D0
	ADD.L	D1,D0
	MOVE.L	D0,MUS+2
	MOVE.B	-1(A5),D0
	SUB		D1,D0
	MOVE.B	D0,TRK
	RTS

SET_VOLUME
	TST.B	D1
	BNE.S	NO_CHANGE			*NO REAL TIME VOLUME VARIATION
	CLR.L	12(A4)				*IN THIS VERSION! MAYBE
	MOVE.B	#1,20(A4)			*SOME OTHER DAY...
NO_CHANGE
	RTS

PATTERN_BREAK
	MOVE.B	#1,POS
	RTS

SET_FILTER
	RTS

SET_SPEED
	MOVE.B	D1,SPD+3
	MOVE.B	D1,SPEED
	RTS

COMMAND		DC.L	ARPEGGIO,PORTAMENTO_UP,PORTAMENTO_DOWN,NO_COMMAND
			DC.L	NO_COMMAND,NO_COMMAND,NO_COMMAND,NO_COMMAND
			DC.L	NO_COMMAND,NO_COMMAND,NO_COMMAND,POSITION_JUMP
			DC.L	SET_VOLUME,PATTERN_BREAK,SET_FILTER,SET_SPEED

EFFECT
	MOVEM.L	D4-D6/A4-A6,-(SP)
	LEA		FRQ(PC),A5
	LEA		VOICE0(PC),A6
	TST		30(A6)
	BEQ.S	CONT_EFFECT1
	BSR		DO_EFFECT
	MOVE.L	26(A6),V0+2
	TST.L	F0+2
	BEQ.S	CONT_EFFECT1
	MOVE.L	26(A6),F0+2
CONT_EFFECT1
	LEA		VOICE1(PC),A6
	TST		30(A6)
	BEQ.S	CONT_EFFECT2
	BSR		DO_EFFECT
	MOVE.L	26(A6),V1+2
	TST.L	F1+2
	BEQ.S	CONT_EFFECT2
	MOVE.L	26(A6),F1+2
CONT_EFFECT2
	LEA		VOICE2(PC),A6
	TST		30(A6)
	BEQ.S	CONT_EFFECT3
	BSR		DO_EFFECT
	MOVE.L	26(A6),V2+2
	TST.L	F2+2
	BEQ.S	CONT_EFFECT3
	MOVE.L	26(A6),F2+2
CONT_EFFECT3
	LEA		VOICE3(PC),A6
	TST		30(A6)
	BEQ.S	CONT_EFFECT4
	BSR		DO_EFFECT
	MOVE.L	26(A6),V3+2
	TST.L	F3+2
	BEQ.S	CONT_EFFECT4
	MOVE.L	26(A6),F3+2
CONT_EFFECT4
	MOVEM.L	(SP)+,D4-D6/A4-A6
	RTS

DO_EFFECT
	MOVE.B	22(A6),D4
	BEQ.S	ARPEGGIO_ROUT
	CMP.B	#1,D4
	BEQ.S	PORTUP
	CMP.B	#2,D4
	BEQ.S	PORTDOWN
	RTS

PORTUP
	MOVEQ	#0,D4
	MOVE.B	23(A6),D4
	MOVE	24(A6),D5
	SUB		D4,D5
	CMP		#$71,D5
	BPL.S	OK_PORTUP
	MOVEQ	#$71,D5
OK_PORTUP
	MOVE	D5,24(A6)
	ADD		D5,D5
	ADD		D5,D5
	MOVE.L	(A5,D5),26(A6)
	RTS

PORTDOWN
	MOVEQ	#0,D4
	MOVE.B	23(A6),D4
	MOVE	24(A6),D5
	ADD		D4,D5
	CMP		#$358,D5
	BMI.S	OK_PORTDOWN
	MOVE	#$358,D5
OK_PORTDOWN
	MOVE	D5,24(A6)
	ADD		D5,D5
	ADD		D5,D5
	MOVE.L	(A5,D5),26(A6)
	RTS

ARPEGGIO_ROUT
	MOVE.B	21(A6),D4
	CMP.B	#1,D4
	BEQ.S	ARP_ROUT1
	CMP.B	#2,D4
	BEQ.S	ARP_ROUT2
	CMP.B	#3,D4
	BEQ.S	ARP_ROUT3
	CMP.B	#4,D4
	BEQ.S	ARP_ROUT1
	CMP.B	#5,D4
	BEQ.S	ARP_ROUT2
	RTS

ARP_ROUT1
	MOVEQ	#0,D4
	MOVE.B	23(A6),D4
	LSR.B	#4,D4
	BRA.S	ARP_ROUT
ARP_ROUT2
	MOVEQ	#0,D4
	MOVE.B	23(A6),D4
	AND.B	#$0F,D4
	BRA.S	ARP_ROUT
ARP_ROUT3
	MOVE	24(A6),D6
	BRA.S	END_ARP_ROUT2
ARP_ROUT
	ADD		D4,D4
	MOVE	24(A6),D5
	LEA		ARPEGGIO_DATA(PC),A4
ARP_LOOP
	CMP		(A4),D5
	BEQ.S	END_ARP_ROUT1
	LEA		2(A4),A4
	BRA.S	ARP_LOOP
END_ARP_ROUT1
	MOVE	(A4,D4),D6
END_ARP_ROUT2
	ADD		D6,D6
	ADD		D6,D6
	MOVE.L	(A5,D6),26(A6)
	ADDQ.B	#1,21(A6)
	RTS

RESTART
	MOVEM.L	(SP)+,D0-D1/A0-A5
	MOVE	#6,SPD+2 
	MOVE.B	#6,SPEED
	MOVE.B	#1,POS
	LEA		MUZEXX,A0
	ADD		SEQ,A0
	LEA		-2(A0),A0
	MOVE.B	(A0)+,TRK
	MOVE.L	A0,MUS+2
	LEA		OFF,A0
	LEA		OFF,A1
	LEA		OFF,A2
	LEA		OFF,A3
	MOVEQ	#0,D0
	MOVEQ	#0,D1
	MOVEQ	#0,D2
	MOVEQ	#0,D3
	CLR.L	V0+2
	CLR.L	V1+2
	CLR.L	V2+2
	CLR.L	V3+2
	CLR.L	F0+2
	CLR.L	F1+2
	CLR.L	F2+2
	CLR.L	F3+2
	BRA		PLAY

END_OF_MUZEXX
	RTS


			DS.B	40
OFF			DC.L	0
SPEED		DC.B	0
POS			DC.B	0
TRK			DC.B	0
SEQ			DS.W	1
PAT			DS.W	1
NBR_INS		DS.W	1
FRQ			incbin a:\asembler.s\dane.dat\12_5khz.frq
ARPEGGIO_DATA	DC.W	$0358,$0328,$02FA,$02D0,$02A6,$0280,$025C
				DC.W	$023A,$021A,$01FC,$01E0,$01C5,$01AC,$0194,$017D
				DC.W	$0168,$0153,$0140,$012E,$011D,$010D,$00FE,$00F0
				DC.W	$00E2,$00D6,$00CA,$00BE,$00B4,$00AA,$00A0,$0097
				DC.W	$008F,$0087,$007F,$0078,$0071,$0000,$0000,$0000


SAVE_INT	DS.L	17
SVBL		DS.L	0
TIMERA		DS.L	1
SAVE_STACK	DS.L	1
			DS.L	128
STACK
SWITCH		DS.W	1
KEY_PRESS	DS.W	1
VOICE0		DS.L	8
VOICE1		DS.L	8
VOICE2		DS.L	8
VOICE3		DS.L	8
ADD_IN_PAT	DS.L	1
REGIS		DS.L	14
MU			DS.W 		5040
MUSIQUE_END		DS.L		0
MUSI			DS.L		0
INS			DS.L	32*4
MUZEXX
	INCBIN a:\asembler.s\dane.dat\boot.mod

