		OPT O+

; *******************************
; *                             *
; *           24 x 24           * 
; *        PROPORTIONAL         *
; *    BORDER SCROLL ROUTINE    *
; *                             *
; *        AUTOMATION 89        *
; *                             *
; *  BY THE LAW: 24th DEC / 89  *
; *                             *
; *******************************



;
; RESERVE MEMORY FOR GEMDOS
;

	MOVE.L 4(A7),A5
	MOVE.L #$100,-(SP)
	MOVE.L A5,-(SP)
	MOVE.L #$4A0000,-(SP)
	TRAP #1
	ADD.W #12,SP

; CALL THE CODE

	PEA CALL_ALL
	MOVE.W #$26,-(SP)
	TRAP #14
	ADD.W #6,SP

; WHICH TERMINATE ROUTINE?

	MOVE.W #0,-(SP)
	MOVE.L OLD,-(SP)
	MOVE.L OLD,-(SP)
	MOVE.W #5,-(SP)
	TRAP #14
	ADD.W #12,SP

	BSR MED_RES

	CMP.L #'TERM',RD4
	BNE LOADIT

	MOVE.W #$4C,-(SP)
	TRAP #1

LOADIT	CLR.L -(SP)
	MOVE.L #CT,-(SP)
	MOVE.L RD4,-(SP)
	CLR.W -(SP)
	MOVE.W #$4B,-(SP)
	TRAP #1

	MOVE.W #$4C,-(SP)
	TRAP #1

MED_RES	CMP.L #'MED!',RESO
	BNE RET
	PEA SETREZ
	MOVE.W #9,-(SP)
	TRAP #1
	ADD.W #6,SP
RET	RTS


RD4	DC.L 0

*****************************


;
; ALL CODE HERE!!
;


CALL_ALL
	MOVE.L #FROM,A0
	MOVE.L #END,A1
	SUB.L A0,A1
	MOVE.L A1,D3
	
	LEA $40000,A1
	ADD.L D3,A1

	MOVE.L #END,A0
	
	MOVE.L #100000,D0
UI	MOVE.B -(A0),-(A1)
	SUBQ.L #1,D0
	BNE.S UI
	JMP $40000

FROM	MOVE.W #2,-(SP)
	TRAP #14
	ADD.W #2,SP
	MOVE.L D0,OLD

	LEA CHARSET+2(PC),A0
	LEA PAL2(PC),A1
	MOVEQ.W #15,D0
POI	MOVE.W (A0)+,(A1)+
	DBRA D0,POI

	MOVE.W #1,$1128
	MOVE.W #1,$1160
	MOVE.W #15,$1170

	LEA $FF8240,A0
	LEA COLBUFF(PC),A1
	MOVEQ.W #15,D0
SCOLS	MOVE.W (A0)+,(A1)+
	DBRA D0,SCOLS

	LEA KB(PC),A0
	MOVE.B $484,(A0)

	CLR.W -(SP)
	PEA $70000
	PEA $70000
	MOVE.W #5,-(SP)
	TRAP #14
	ADD.W #12,SP

;
; DISABLE MOUSE
;

	MOVE.B #$12,$FFFC02

;
; SET SCROLLTEXT POINTERS
;

	LEA TEXT(PC),A0
	MOVE.L A0,$1140
	LEA CHARSET+34(PC),A0
	MOVE.L A0,$1150

;
; SET VERTICAL INTERUPT ON
;

	LEA SCRLADD(PC),A6
	MOVE.L #$70000+(160*204)-2,(A6)

	LEA STORE(PC),A0
	MOVE.L $70,(A0)
	LEA VBL(PC),A0
	MOVE.L A0,$70

;
; INIT MUSIX
;
	LEA MUSIX,A0
	LEA $196CE,A1
	MOVE.L #28000,D0
MMUS	MOVE.B (A0)+,(A1)+
	DBRA D0,MMUS

; VALID TUNES
;
; 0-8 TUNES
; 9-A JINGLES
;   B INITIAL DRUMS (NO WRAP)
;

	MOVE.L #$1,D0
	JSR $1D6EC

;
; SET NEW KEYBOARD INTERUPT 
;

	LEA S118(PC),A0
	MOVE.L $118,(A0)
	LEA NEWKEY(PC),A0
	MOVE.L A0,$118

;
; SET MUSIC AND DRAW PICTURES
;

	LEA PIC+2,A0
	LEA $FF8240,A1
	MOVEQ.W #15,D0
CO	MOVE.W (A0)+,(A1)+
	DBRA D0,CO

	BSR DRAWPIC

;
; SET HORIZ-BLANK
;

	PEA HBL(PC)
	MOVE.W #1,-(SP)
	MOVE.W #%1000,-(SP)
	MOVE.W #1,-(SP)
	MOVE.W #31,-(SP)
	TRAP #14
	ADD.W #12,SP

	LEA $78000-(160*5),A0
	MOVE.W #10,D0
ERASE	CLR.L (A0)+
	DBRA D0,ERASE


;
; MEMORY ADDRESS OF SCROLL
;


	MOVE.W #5,-(SP)
	MOVE.W #26,-(SP)
	TRAP #14
 	ADD.W #4,SP

	
;
; WAIT FOR HOT-KEYS LOOP
;

WAIT	LEA TIMER(PC),A0
	MOVE.W (A0),D0
HANGIT	CMP.W (A0),D0
	BEQ.S HANGIT

;
; CALL MUSIC
;

	JSR $1D80C

;
; CHECK FOR KEYS
;

	LEA $1100,A0
	MOVE.B (A0),D0

; CHECK FOR '0' - 50/60 Hz

	CMP.B #$B,D0
	BEQ FLIPFREQ

	LEA $1100,A6

TEST1	CMP.B #02,(A6)
	BNE.S TEST2
	MOVE.L #'TERM',RD4
	BRA.S EXITA
TEST2	CMP.B #03,(A6)
	BNE.S WAIT
	MOVE.L #'TERM',RD4
	BRA EXITA

EXITA	
	MOVE.W #8,-(SP)
	MOVE.W #26,-(SP)
	TRAP #14
	ADD.W #4,SP

	LEA S118(PC),A0
	MOVE.L (A0),$118

	LEA STORE(PC),A0
	MOVE.L (A0),$70

	MOVE.W #5,-(SP)
	MOVE.W #27,-(SP)
	TRAP #14
	ADD.W #4,SP

;
; SWITCH OFF SOUND-CHIP
;

	BSR NOFX

;
; RESTORE KEYBOARD
;

	MOVE.B #$80,$FFFC02
	MOVE.W #$FFFF,D0
UYT	NOP
	DBRA D0,UYT
	MOVE.B #$1,$FFFC02

;
; RESTORE KEY-CLICK
;

	LEA KB(PC),A0
	MOVE.B (A0),$484

;
; SET FREQUENCY
;

	BSR SETFREQ

; RESTORE COLOURS

	LEA $FF8240,A1
	LEA COLBUFF(PC),A0
	MOVEQ.W #15,D0
RCOLS	MOVE.W (A0)+,(A1)+
	DBRA D0,RCOLS

	CLR.B $1100

; BACK TO THE BEGINING

	RTS

DELAY	LEA TIMER(PC),A5
	CLR.W (A5)
	RTS

VBL	MOVEM.L D0-D7/A0-A6,$1200

	CLR.W $1120

	LEA CHARSET+2(PC),A0
	ADD.L #32066,A0
	LEA $FF8240,A1
	MOVEQ.W #15,D0
RE	MOVE.W (A0)+,(A1)+
	DBRA D0,RE

	BSR SCROLL

	LEA $1170,A6
	ADDQ.W #1,(A6)
	CMP.W #25,(A6)
	BNE EXITFLA
	MOVE.W #24,(A6)

EXITFLA
	LEA TIMER(PC),A6
	ADDQ.W #1,(A6)

	MOVEM.L $1200,D0-D7/A0-A6

	RTE

NEWKEY	MOVE.B $FFFC02,$1100
	BCLR.B #6,$FFFFFA11
	RTE

NOFX	MOVE.L #$8080000,$ffff8800.W
	MOVE.L #$9090000,$ffff8800.W
	MOVE.L #$A0A0000,$ffff8800.W
	RTS

BACKO	LEA PAL2(PC),A4
	MOVE.L (A4),$FF8240
	MOVE.L 4(A4),$FF8244
	MOVE.L 8(A4),$FF8248
	CLR.L $FF825C
	MOVE.W #-1,$1108
	BRA HBL2

HBL	
	TST.W $1108
	BPL.S BACKO

HBL2	MOVE.L D0,-(SP)
	MOVE.B #%11111110,$FF820A
	ADD.W #1,$1120
_199	CMP.W #199,$1120
	BNE _200
	MOVE.B #%11111100,$FF820A
	BRA HBL_RET
_200	CMP.W #201,$1120
	BNE HBL_RET
	MOVE.W #1,$1108
HBL_RET	MOVE.L (SP)+,D0
	BCLR.B #0,$FFFA0F
	RTE


SCROLL	
	MOVE.W SPEED(PC),D5

	SUBQ.W #1,$1128
	TST.W $1128
	BNE GO_SCRL

GET2	MOVE.W #16,$1128
	MOVEQ.L #0,D1
	MOVE.L $1140,A0

BACK	MOVE.B (A0),D1

	MOVE.B D1,D3
	SUB.W #$20,D1

	CMP.B #$FF,D3

	BNE NEXT

WRAP	MOVE.W #1,$1130
	LEA TEXT(PC),A6
	MOVE.L A6,$1140
	BRA.S GET2

NEXT	TST.W $1130
	BEQ.S ON2
	CLR.W $1130
	LEA CHARSET+42+160(PC),A6
	MOVE.L A6,$1150
	ADDQ.L #1,$1140
	SUBQ.W #8,$1128
	BRA NEXT_CH 

ON2	MOVE.W #1,$1130
	LEA CHARSET+34+160(PC),A6
	MOVE.L A6,$1150

PROP1	CMP.B #$FF,D3
	BEQ.S WRAP
	CMP.B #"!",D3
	BNE PROP2
	ADDQ.L #1,$1140
	MOVE.W #8,$1128
	CLR.W $1130
	BRA NEXT_CH
PROP2	CMP.B #"'",D3
	BNE PROP3
	ADDQ.L #1,$1140
	MOVE.W #12,$1128
	CLR.W $1130
	BRA NEXT_CH
PROP3	CMP.B #",",D3
	BNE PROP4
	ADDQ.L #1,$1140
	MOVE.W #12,$1128
	CLR.W $1130
	BRA NEXT_CH
PROP4	CMP.B #".",D3
	BNE PROP5
	ADDQ.L #1,$1140
	MOVE.W #12,$1128
	CLR.W $1130
	BRA NEXT_CH
PROP5	CMP.B #"1",D3
	BNE PROP6
	ADDQ.L #1,$1140
	MOVE.W #14,$1128
	CLR.W $1130
	BRA NEXT_CH
PROP6	CMP.B #"I",D3
	BNE PROP7
	ADDQ.L #1,$1140
	MOVE.W #14,$1128
	CLR.W $1130
	BRA NEXT_CH
PROP7	CMP.B #"-",D3
	BNE PROP8
	ADDQ.L #1,$1140
	MOVE.W #12,$1128
	CLR.W $1130
	BRA NEXT_CH
PROP8	CMP.B #"(",D3
	BNE PROP9
	ADDQ.L #1,$1140
	MOVE.W #14,$1128
	CLR.W $1130
	BRA NEXT_CH
PROP9	CMP.B #")",D3
	BNE NEXT_CH
	ADDQ.L #1,$1140
	MOVE.W #14,$1128
	CLR.W $1130

NEXT_CH
	
_P	CMP.B #"R",D3
	BLT.S _AST
	ASL #4,D1
	ADD.L #(31*160)*5,D1
	BRA OUT
_AST	CMP.B #"H",D3
	BLT.S _4
	ASL #4,D1
	ADD.L #(31*160)*4,D1
	BRA OUT
_4	CMP.B #">",D3
	BLT.S _GT
	ASL #4,D1
	ADD.L #(31*160)*3,D1
	BRA OUT
_GT	CMP.B #"4",D3
	BLT.S _H
	ASL #4,D1
	ADD.L #(31*160)*2,D1
	BRA OUT
_H	CMP.B #"*",D3
	BLT.S _GO
	ASL #4,D1
	ADD.L #(31*160),D1
	BRA.S OUT
_GO	ASL #4,D1

OUT	MOVE.L $1150,A5
	ADD.L D1,A5
	LEA CHBUFF(PC),A4
	MOVEQ.L #22,D7
FILLBUF	MOVE.L (A5)+,(A4)+
	MOVE.L (A5),(A4)+
	ADD.L #156,A5
	DBRA D7,FILLBUF
	
	BRA.S GO_SCRL

FASTER	SUBQ.W #1,$1128

GO_SCRL	LEA CHBUFF(PC),A0
	MOVE.L SCRLADD(PC),A2
	MOVEQ.L #22,D2
	ADDQ.L #8,A2
ROWS	ADD.L #152,A2
	MOVEQ.W #3,D1
PLANES	LSL.W (A0)+
	ROXL.W $98(A2)
	ROXL.W $90(A2)
	ROXL.W $88(A2)
	ROXL.W $80(A2)
	ROXL.W $78(A2)
	ROXL.W $70(A2)
	ROXL.W $68(A2)
	ROXL.W $60(A2)
	ROXL.W $58(A2)
	ROXL.W $50(A2)
	ROXL.W $48(A2)
	ROXL.W $40(A2)
	ROXL.W $38(A2)
	ROXL.W $30(A2)
	ROXL.W $28(A2)
	ROXL.W $20(A2)
	ROXL.W $18(A2)
	ROXL.W $10(A2)
	ROXL.W $8(A2)
	ROXL.W (A2)+
	DBRA D1,PLANES
	DBRA D2,ROWS
	DBRA D5,FASTER

OUTG	
	RTS


REG2	DS.L 20

FLIPFREQ	
	CMP.W #12,$1170
	BLT WAIT
	NEG.W $1160
	CLR.W $1170	
	LEA PAL2(PC),A6
	EOR.W #$222,(A6)

RETURN	BRA WAIT

SETFREQ	TST.W $1160
	BPL _50HZ
	MOVE.B #%11111100,$FF820A
	RTS
_50HZ	MOVE.B #%11111110,$FF820A
	RTS

DRAWPIC	LEA CHARSET+34(PC),A0
	ADD.L #32066,A0
	LEA $70000,A1
	MOVE.L #32000/4,D0
TYU	MOVE.L (A0)+,(A1)+
	DBRA D0,TYU
	RTS


********************
* VARIABLES/LABELS *
********************


PTR		dc.l $70000+(180*160)
TIMER		DC.W 0
LINE		DC.W 0
STORE		DC.L 0
DDD		DC.W 1
SPEED		DC.W 1
SCRL		DC.W 1
TPNT		DC.L 0
CHBUFF		DS.L (4*32)
SCRLADD		DC.L 0
STCHAR		DC.L 0
NOW		DC.W -1
KB		DC.W 0
COLBUFF		DS.W 16
CT		DC.L 0
RESO		DC.L 0
REG		DS.L 50
SHIFTER		DC.W 0
OLD		DC.L 0

S118		DC.L 0
NOW2		DC.W 0
PAL2		DS.W 16
HREG		DC.L 8

TEXT
LAWTXT	
	DC.B " "
	DC.B "HELLO, GOOD EVENING, AND WELCOME TO AUTOMATION MENU 205  -  "
	DC.B "ALL CODING BY... THE LAW     "
	DC.B "NEWSFLASH...   AUTOMATION HAS SOME NEW MEMBERS...    WHO?   WELL, THEY "
	DC.B "ARE A FAIRLY NEW CREW THAT GO BY THE NAME OF.....        "
	DC.B "THE GUARDIANS OF LOGIK      "
	DC.B "LOOK OUT FOR SOME OF THEIR STUFF SOON.....     "
	DC.B "LOOK OUT FOR MY ABSENCE ON MENUS AS WELL....     "
	DC.B "MY GREETINGS THIS TIME ARE SENT TO:    "
	DC.B "THE GUARDIANS OF LOGIK, "
	DC.B "THE UNION, "
	DC.B "THE BLADERUNNERS, "
	DC.B "THE EMPIRE, "
	DC.B "THE ALLIANCE, "
	DC.B "THE MEDWAY BOYS, "
	DC.B "SEWER SOFTWARE (GREAT WORK GUYS!), "
	DC.B "MAL, BOB, COL, BRI, SIMON, IRS, DEAN, ALL AMBULANCE MEN EVERYWHERE (ESPECIALLY CHRIS), TYCHO AND ALL OTHERS THAT I KNOW, "
	DC.B "IF YOU CAN READ THIS IT MEANS THAT THE LAST FOUR HOURS WERE WORTH IT AS I HAVE BEEN TRYING TO GET THIS CODE TOTALY RELOCATABLE...     "
	DC.B "MUSIC RIPPED FROM ROCK 'N' ROLL BY THE LAW......       "
	DC.B "ANYWAY, JUST TIME TO SAY....    "
	DC.B $FF,$FF 

	EVEN
CHARSET	
	INCBIN "\MENU.205\PROP.PI1"
	EVEN
PIC
	INCBIN "\MENU.205\MENU1.PI1"
	EVEN
MUSIX
	INCBIN "\MENU.205\ROCKROLL.MUS"
	EVEN
SETREZ	DC.B 27,"EPlease run in Medium Res...",00
	EVEN

***************************
* END OF CODE............ *
***************************

END
