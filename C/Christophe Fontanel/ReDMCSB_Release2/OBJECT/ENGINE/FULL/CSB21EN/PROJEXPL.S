CODE SEG "init!"
	MOVE.L	#-200,G361_l_Las(A4)
BSS SEG "bss"
G361_l_Las:/* global */
	.WORD	#4
G362_l_Las:/* global */
	.WORD	#4
G363_i_Sec:/* global */
	.WORD	#2
G364_i_Cre:/* global */
	.WORD	#2
G365_B_Cre:/* global */
	.WORD	#2
G366_i_Pro:/* global */
	.WORD	#2
G367_i_Pro:/* global */
	.WORD	#2
CODE SEG "init!"
	LEA	G368_apc_C(A4),A1
	LEA	G585_ac_Co(A4),A0
	MOVE.L	A0,(A1)+
	LEA	G344_ac_Co(A4),A0
	MOVE.L	A0,(A1)+
	LEA	G533_ac_Co(A4),A0
	MOVE.L	A0,(A1)+
	LEA	G408_ac_Co(A4),A0
	MOVE.L	A0,(A1)+
	LEA	G393_ac_Co(A4),A0
	MOVE.L	A0,(A1)+
	LEA	G427_ac_Co(A4),A0
	MOVE.L	A0,(A1)+
BSS SEG "bss"
G368_apc_C:/* global */
	.WORD	#24
CODE SEG "timeline"
F212_mzzz_:/* global */
	LINK	A6,L$0
	MOVEM.L	A3/D7-D6,-(A7)
	MOVE	8(A6),D7
	MOVE	#14,-(A7)
	JSR	F166_szzz_(PC)
	ADDQ.L	#2,A7
	MOVE	D0,D6
	CMPI	#-1,D0
	BNE.S	L2
	MOVE	D7,D0
	AND	#15360,D0
	LSR	#2,D0
	LSR	#8,D0
	CMPI	#15,D0
	BEQ.S	L3
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	CLR	-(A7)
	MOVE	#-1,-(A7)
	MOVE	D7,D0
	AND	#16383,D0
	MOVE	14(A6),D1
	ASL	#6,D1
	ASL	#8,D1
	OR	D1,D0
	MOVE	D0,-(A7)
	JSR	F267_dzzz_(PC)
	ADDA	#10,A7
L3:
	BRA	L1(PC)
L2:
	MOVE	D6,D0
	AND	#16383,D0
	MOVE	14(A6),D1
	ASL	#6,D1
	ASL	#8,D1
	OR	D1,D0
	MOVE	D0,D6
	MOVE	D6,-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,A3
	MOVE	D7,2(A3)
	MOVE	#255,-(A7)
	MOVE.B	19(A6),D0
	AND	#255,D0
	MOVE	D0,-(A7)
	JSR	F024_aatz_(PC)
	ADDQ.L	#4,A7
	MOVE.B	D0,4(A3)
	MOVE.B	21(A6),5(A3)
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	CLR	-(A7)
	MOVE	D6,-(A7)
	JSR	F163_amzz_(PC)
	ADDQ.L	#8,A7
	MOVE.L	G313_ul_Ga(A4),D0
	ADDQ.L	#1,D0
	MOVE	G272_i_Cur(A4),D1
	EXT.L	D1
	MOVE.L	#24,D3
	ASL.L	D3,D1
	OR.L	D1,D0
	MOVE.L	D0,-10(A6)
	MOVE	G365_B_Cre(A4),D0
	BEQ.S	L4
	MOVE.B	#49,-6(A6)
	BRA.S	L5
L4:
	MOVE.B	#48,-6(A6)
L5:
	CLR.B	-5(A6)
	MOVE	D6,-4(A6)
	MOVE	10(A6),D0
	AND	#31,D0
	MOVE	D0,D3
	ANDI	#-32,-2(A6)
	OR	D3,-2(A6)
	MOVE	12(A6),D0
	AND	#31,D0
	MOVE	D0,D3
	ASL	#5,D3
	ANDI	#-993,-2(A6)
	OR	D3,-2(A6)
	MOVE.B	23(A6),D0
	AND	#255,D0
	AND	#15,D0
	MOVE	D0,D3
	ASL	#4,D3
	ASL	#8,D3
	ANDI	#4095,-2(A6)
	OR	D3,-2(A6)
	MOVE	16(A6),D0
	AND	#3,D0
	MOVE	D0,D3
	ASL	#2,D3
	ASL	#8,D3
	ANDI	#-3073,-2(A6)
	OR	D3,-2(A6)
	PEA	-10(A6)
	JSR	F238_pzzz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,6(A3)
L1:
	MOVEM.L	(A7)+,D6-D7/A3
	UNLK	A6
	RTS
L$0:	.EQU	#-10
F213_hzzz_:/* global */
	LINK	A6,L$6
	MOVEM.L	A3-A2/D7-D4,-(A7)
	MOVE	10(A6),D7
	MOVE	12(A6),D6
	MOVE	14(A6),D5
	MOVE	#15,-(A7)
	JSR	F166_szzz_(PC)
	ADDQ.L	#2,A7
	MOVE	D0,-6(A6)
	CMPI	#-1,D0
	BNE.S	L8
	BRA	L7(PC)
L8:
	MOVE	-6(A6),D0
	AND	#1023,D0
	MOVE.L	G284_apuc_+60(A4),D1
	ASL.L	#2,D0
	MOVE.L	D1,A0
	ADDA	D0,A0
	LEA	(A0),A0
	MOVE.L	A0,A3
	CMPI	#255,D6
	BHI.S	L9
	MOVE	D6,-8(A6)
	MOVE	D5,-10(A6)
	BRA.S	L10
L9:
	MOVE	D6,D0
	AND	#255,D0
	MOVE	D0,-8(A6)
	MOVE	D5,D0
	AND	#255,D0
	MOVE	D0,-10(A6)
	MOVE	D6,D0
	LSR	#8,D0
	MOVE	D0,D6
	SUBQ	#1,D6
	MOVE	D5,D0
	LSR	#8,D0
	MOVE	D0,D5
L10:
	CMPI	#255,16(A6)
	BNE.S	L11
	MOVE	#1,D0
	AND	#1,D0
	MOVE	D0,D3
	ASL	#7,D3
	ANDI	#-129,2(A3)
	OR	D3,2(A3)
	BRA.S	L12
L11:
	MOVE	#0,D0
	AND	#1,D0
	MOVE	D0,D3
	ASL	#7,D3
	ANDI	#-129,2(A3)
	OR	D3,2(A3)
	MOVE	-6(A6),D0
	AND	#16383,D0
	MOVE	16(A6),D1
	ASL	#6,D1
	ASL	#8,D1
	OR	D1,D0
	MOVE	D0,-6(A6)
L12:
	MOVE	8(A6),D0
	SUB	#-128,D0
	AND	#127,D0
	MOVE	D0,D3
	ANDI	#-128,2(A3)
	OR	D3,2(A3)
	MOVE	D7,D0
	AND	#255,D0
	MOVE	D0,D3
	ASL	#8,D3
	ANDI	#255,2(A3)
	OR	D3,2(A3)
	CMPI	#-125,8(A6)
	BCC.S	L13
	MOVE	#1,-(A7)
	MOVE	D5,-(A7)
	MOVE	D6,-(A7)
	CMPI	#80,D7
	BLS.S	L14
	MOVE	#5,D0
	BRA.S	L15
L14:
	MOVE	#20,D0
L15:
	MOVE	D0,-(A7)
	JSR	F064_aadz_(PC)
	ADDQ.L	#8,A7
	BRA.S	L16
L13:
	CMPI	#-88,8(A6)
	BEQ.S	L17
	MOVE	#1,-(A7)
	MOVE	D5,-(A7)
	MOVE	D6,-(A7)
	MOVE	#13,-(A7)
	JSR	F064_aadz_(PC)
	ADDQ.L	#8,A7
L17:
L16:
	MOVE	D5,-(A7)
	MOVE	D6,-(A7)
	CLR	-(A7)
	MOVE	-6(A6),-(A7)
	JSR	F163_amzz_(PC)
	ADDQ.L	#8,A7
	MOVE.L	G313_ul_Ga(A4),D0
	CMPI	#-28,8(A6)
	BNE.S	L18
	MOVE	#5,D1
	BRA.S	L19
L18:
	MOVE	#1,D1
L19:
	AND.L	#65535,D1
	ADD.L	D1,D0
	MOVE	G272_i_Cur(A4),D1
	EXT.L	D1
	MOVE.L	#24,D3
	ASL.L	D3,D1
	OR.L	D1,D0
	MOVE.L	D0,-20(A6)
	MOVE.B	#25,-16(A6)
	CLR.B	-15(A6)
	MOVE	-6(A6),-12(A6)
	MOVE	D6,D0
	MOVE.B	D0,-14(A6)
	MOVE	D5,D0
	MOVE.B	D0,-13(A6)
	PEA	-20(A6)
	JSR	F238_pzzz_(PC)
	ADDQ.L	#4,A7
	CMPI	#-126,8(A6)
	BEQ.S	L21
	CMPI	#-128,8(A6)
	BNE	L20(PC)
L21:
	MOVE	-8(A6),D6
	MOVE	-10(A6),D5
	MOVE	D7,D0
	LSR	#1,D0
	ADDQ	#1,D0
	MOVE	D0,D7
	JSR	F027_AA59_(PC)
	AND.L	#65535,D0
	DIVU	D7,D0
	SWAP	D0
	ADDQ	#1,D0
	ADD	D0,D7
	CMPI	#-128,8(A6)
	BEQ.S	L23
	MOVE	D7,D0
	LSR	#1,D0
	MOVE	D0,D7
	BEQ	L22(PC)
L23:
	MOVE	G272_i_Cur(A4),D0
	CMP	G309_i_Par(A4),D0
	BNE.S	L24
	MOVE	D6,D0
	MOVE	G306_i_Par(A4),D1
	CMP	D1,D0
	BNE.S	L24
	MOVE	D5,D0
	MOVE	G307_i_Par(A4),D1
	CMP	D1,D0
	BNE.S	L24
	MOVE	#1,-(A7)
	MOVE	#63,-(A7)
	MOVE	D7,-(A7)
	JSR	F324_aezz_(PC)
	ADDQ.L	#6,A7
	BRA	L7(PC)
L24:
	MOVE	D5,-(A7)
	MOVE	D6,-(A7)
	JSR	F175_gzzz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,-6(A6)
	CMPI	#-2,D0
	BEQ	L25(PC)
	MOVE	-6(A6),-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,-4(A6)
	MOVE.L	-4(A6),A0
	MOVE.B	4(A0),D0
	AND	#255,D0
	MULS	#26,D0
	LEA	G243_as_Gr(A4),A0
	ADDA	D0,A0
	LEA	(A0),A0
	MOVE.L	A0,A2
	MOVE	18(A2),D0
	LSR	#4,D0
	AND	#15,D0
	MOVE	D0,D4
	CMPI	#15,D0
	BEQ.S	L26
	MOVE	2(A2),D0
	AND	#64,D0
	BEQ.S	L27
	MOVE	D7,D0
	LSR	#2,D0
	MOVE	D0,D7
L27:
	JSR	F027_AA59_(PC)
	MOVE.L	D0,D1
	MOVE	D4,D0
	ASL	#1,D0
	ADDQ	#1,D0
	AND.L	#65535,D1
	DIVU	D0,D1
	SWAP	D1
	MOVE	D7,D0
	SUB	D1,D0
	MOVE	D0,D7
	CMPI	#0,D0
	BLS.S	L28
	MOVE	#1,-(A7)
	MOVE	D7,-(A7)
	MOVE	D5,-(A7)
	MOVE	D6,-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	F191_aayz_(PC)
	ADDA	#12,A7
	MOVE	D0,G364_i_Cre(A4)
L28:
L26:
L25:
L22:
L20:
L7:
	MOVEM.L	(A7)+,D4-D7/A2-A3
	UNLK	A6
	RTS
L$6:	.EQU	#-20
F214_pzzz_:/* global */
	LINK	A6,L$29
	MOVE	8(A6),-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,-4(A6)
	MOVE.L	-4(A6),A0
	MOVE	6(A0),-(A7)
	JSR	F237_rzzz_(PC)
	ADDQ.L	#2,A7
L30:
	UNLK	A6
	RTS
L$29:	.EQU	#-4
F215_lzzz_:/* global */
	LINK	A6,L$31
	MOVEM.L	A3/D7-D6,-(A7)
	MOVE	8(A6),-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,A3
	MOVE	2(A3),D0
	MOVE	D0,D6
	AND	#15360,D0
	LSR	#2,D0
	LSR	#8,D0
	CMPI	#15,D0
	BEQ.S	L33
	CMPI.L	#0,10(A6)
	BEQ.S	L34
	MOVE.L	10(A6),A0
	MOVE	(A0),D0
	MOVE	D0,D7
	CMPI	#-2,D0
	BNE.S	L35
	MOVE	D6,-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,-4(A6)
	MOVE.L	-4(A6),A0
	MOVE	#-2,(A0)
	MOVE.L	10(A6),A0
	MOVE	D6,(A0)
	BRA.S	L36
L35:
	CLR	-(A7)
	MOVE	#-1,-(A7)
	MOVE	D7,-(A7)
	MOVE	D6,-(A7)
	JSR	F163_amzz_(PC)
	ADDQ.L	#8,A7
L36:
	BRA.S	L37
L34:
	MOVE	16(A6),-(A7)
	MOVE	14(A6),-(A7)
	CLR	-(A7)
	MOVE	#-2,-(A7)
	MOVE	D6,D0
	AND	#16383,D0
	MOVE	8(A6),D1
	AND	#-16384,D1
	OR	D1,D0
	MOVE	D0,-(A7)
	JSR	F267_dzzz_(PC)
	ADDA	#10,A7
L37:
L33:
	MOVE	#-1,(A3)
L32:
	MOVEM.L	(A7)+,D6-D7/A3
	UNLK	A6
	RTS
L$31:	.EQU	#-14
F216_xxxx_:/* global */
	LINK	A6,L$38
	MOVEM.L	A3-A2/D7-D5,-(A7)
	MOVE.L	8(A6),A3
	MOVE	12(A6),D7
	CLR	G366_i_Pro(A4)
	MOVE	#3,G367_i_Pro(A4)
	MOVE.B	4(A3),D5
	AND	#255,D5
	MOVE	D7,D0
	AND	#15360,D0
	LSR	#2,D0
	LSR	#8,D0
	MOVE	D0,D6
	CMPI	#15,D0
	BEQ.S	L40
	CMPI	#5,D6
	BNE.S	L41
	MOVE	D7,-(A7)
	JSR	F158_ayzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,A2
	MOVE.B	3(A2),D6
	AND	#255,D6
	MOVE	#3,G367_i_Pro(A4)
	BRA.S	L42
L41:
	JSR	F029_AA19_(PC)
	MOVE	D0,D6
L42:
	MOVE	D7,-(A7)
	JSR	F140_yzzz_(PC)
	ADDQ.L	#2,A7
	LSR	#1,D0
	ADD	D0,D6
	BRA	L43(PC)
L40:
	CMPI	#-127,D7
	BNE.S	L44
	JSR	F027_AA59_(PC)
	AND	#15,D0
	MOVE	D0,D6
	MOVE	D6,D0
	ADD	#10,D0
	MOVE	D0,G366_i_Pro(A4)
	JSR	F027_AA59_(PC)
	AND	#31,D0
	ADD	D0,D6
	BRA.S	L45
L44:
	CMPI	#-125,D7
	BCS.S	L46
	MOVE	#5,G367_i_Pro(A4)
	CMPI	#-122,D7
	BNE.S	L47
	MOVE	D5,G366_i_Pro(A4)
	MOVE	#1,D0
	BRA	L39(PC)
L47:
	MOVE	#0,D0
	BRA	L39(PC)
L46:
	MOVE	#1,G367_i_Pro(A4)
	JSR	F027_AA59_(PC)
	AND	#15,D0
	MOVE.L	D0,-(A7)
	JSR	F027_AA59_(PC)
	MOVE.L	D0,D1
	MOVE.L	(A7)+,D0
	AND	#15,D1
	ADD	D1,D0
	ADD	#10,D0
	MOVE	D0,D6
	CMPI	#-126,D7
	BNE.S	L48
	MOVE	#7,G367_i_Pro(A4)
	MOVE	D6,D0
	MULU	#5,D0
	MOVE	D0,D6
L48:
L45:
L43:
	MOVE	D6,D0
	ADD	D5,D0
	LSR	#4,D0
	ADDQ	#1,D0
	MOVE	D0,D6
	JSR	F027_AA59_(PC)
	MOVE	D6,D1
	LSR	#1,D1
	ADDQ	#1,D1
	AND.L	#65535,D0
	DIVU	D1,D0
	SWAP	D0
	MOVE.L	D0,-(A7)
	JSR	F029_AA19_(PC)
	MOVE.L	D0,D1
	MOVE.L	(A7)+,D0
	ADD	D1,D0
	ADD	D0,D6
	MOVE	#32,D1
	MOVE.B	5(A3),D0
	AND	#255,D0
	ASR	#3,D0
	SUB	D0,D1
	MOVE	D6,D0
	SUB	D1,D0
	MOVE	D0,-(A7)
	MOVE	D6,D0
	LSR	#1,D0
	MOVE	D0,-(A7)
	JSR	F025_aatz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,D6
	MOVE	D6,D0
L39:
	MOVEM.L	(A7)+,D5-D7/A2-A3
	UNLK	A6
	RTS
L$38:	.EQU	#0
F217_xxxx_:/* global */
	LINK	A6,L$49
	MOVEM.L	A3-A2/D7-D4,-(A7)
	MOVE	16(A6),-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,A3
	MOVE	10(A6),-32(A6)
	MOVE	12(A6),-34(A6)
	CLR	-56(A6)
	CLR	G364_i_Cre(A4)
	MOVE	2(A3),D0
	MOVE	D0,D7
	AND	#15360,D0
	LSR	#2,D0
	LSR	#8,D0
	MOVE	D0,-58(A6)
	CMPI	#8,D0
	BNE.S	L51
	MOVE	D7,-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,A2
	MOVE.L	A2,D0
	MOVE.L	D0,A0
	MOVE	2(A0),D0
	AND	#32512,D0
	LSR	#8,D0
L52:
	CMP	#3,D0
	BEQ.S	L53
	BRA.S	L55
L53:
	MOVE	#-121,-26(A6)
	BRA.S	L5T217_004
	BRA.S	L56
L55:
	CMP	#19,D0
	BEQ.S	L56
	BRA.S	L57
L56:
	MOVE	#-128,-26(A6)
L5T217_004:
	MOVE	#1,-56(A6)
	MOVE.L	A2,D0
	MOVE.L	D0,A0
	MOVE	2(A0),D0
	AND	#255,D0
	MOVE	D0,-54(A6)
	MOVE.L	A2,D0
	MOVE.L	D0,-4(A6)
L57:
L58:
L54:
L51:
	CMPI	#15,-58(A6)
	SEQ	D0
	TST.B	D0
	BEQ.S	L60
	CMPI	#-127,D7
	SNE	D0
	TST.B	D0
L60:
	TST.B	D0
	BEQ.S	L59
	CMPI	#-122,D7
	SNE	D0
	TST.B	D0
L59:
	AND	#1,D0
	MOVE	D0,-48(A6)
	CLR.L	-24(A6)
	CLR	D4
	CMPI	#255,10(A6)
	BGT.S	L61
	MOVE	10(A6),-28(A6)
	MOVE	12(A6),-30(A6)
	BRA.S	L62
L61:
	MOVE	10(A6),D0
	ASR	#8,D0
	SUBQ	#1,D0
	MOVE	D0,-28(A6)
	MOVE	12(A6),D0
	ASR	#8,D0
	MOVE	D0,-30(A6)
	ANDI	#255,10(A6)
	ANDI	#255,12(A6)
L62:
	MOVE	8(A6),D0
L63:
	CMP	#4,D0
	BEQ.S	L64
	BRA	L66(PC)
L64:
	MOVE	10(A6),D6
	ASL.L	#2,D6
	MOVE.L	G271_ppuc_(A4),A0
	ADDA	D6,A0
	MOVE.L	(A0),A0
	ADDA	12(A6),A0
	MOVE.B	(A0),D6
	AND	#255,D6
	MOVE.B	D6,-35(A6)
	AND	#255,D6
	AND	#7,D6
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	JSR	F157_rzzz_(PC)
	ADDQ.L	#4,A7
	MOVE.L	D0,-12(A6)
	CMPI	#5,D6
	BEQ.S	L68
	CMPI	#-124,D7
	BNE.S	L68
	MOVE.L	-12(A6),A0
	MOVE	2(A0),D0
	AND	#64,D0
	LSR	#6,D0
	BEQ.S	L69
	MOVE.L	G313_ul_Ga(A4),D0
	ADDQ.L	#1,D0
	MOVE.L	D0,-(A7)
	MOVE	#2,-(A7)
	CLR	-(A7)
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	MOVE	#10,-(A7)
	JSR	F268_fzzz_(PC)
	ADDA	#14,A7
L69:
	BRA	L65(PC)
L68:
	CMPI	#5,D6
	BEQ	L71(PC)
	CMPI	#1,D6
	BLE	L71(PC)
	MOVE.L	-12(A6),A0
	MOVE	2(A0),D0
	AND	#1,D0
	ASL.L	#1,D0
	LEA	G275_as_Cu(A4),A0
	ADDA	D0,A0
	MOVE.B	(A0),D0
	AND	#255,D0
	AND	#2,D0
	BEQ	L70(PC)
	CMPI	#15,-58(A6)
	BNE.S	L72
	CMPI	#-125,D7
	SCC	D0
	AND	#1,D0
	BRA.S	L73
L72:
	JSR	F027_AA59_(PC)
	AND	#127,D0
	MOVE	D0,-72(A6)
	MOVE.B	5(A3),D0
	AND	#255,D0
	CMP	-72(A6),D0
	SHI	D0
	TST.B	D0
	BEQ.S	L75
	MOVE	D7,-(A7)
	JSR	F141_anzz_(PC)
	ADDQ.L	#2,A7
	MULS	#6,D0
	LEA	G237_as_Gr+4(A4),A0
	ADDA	D0,A0
	MOVE	(A0),D0
	AND	#256,D0
L75:
	SNE	D0
	TST.B	D0
	BEQ.S	L74
	CMPI	#10,-58(A6)
	SNE	D0
	TST.B	D0
	BNE.S	L77
	MOVE	D7,-(A7)
	JSR	F033_aaaz_(PC)
	ADDQ.L	#2,A7
	MOVE	D0,D6
	CMPI	#0,D0
	SLT	D0
	TST.B	D0
L77:
	TST.B	D0
	BNE.S	L76
	CMPI	#176,D6
	SGE	D0
	TST.B	D0
	BEQ.S	L78
	CMPI	#191,D6
	SLE	D0
	TST.B	D0
L78:
	TST.B	D0
	SEQ	D0
	TST.B	D0
L76:
	TST.B	D0
L74:
	AND	#1,D0
L73:
	BEQ.S	L70
L71:
	MOVE	#0,D0
	BRA	L50(PC)
L70:
	MOVE	D7,-(A7)
	MOVE.L	A3,-(A7)
	JSR	F216_xxxx_(PC)
	ADDQ.L	#6,A7
	ADDQ	#1,D0
	MOVE	D0,D5
	CLR	-(A7)
	CLR	-(A7)
	JSR	F027_AA59_(PC)
	MOVE.L	D0,D1
	AND.L	#65535,D1
	DIVU	D5,D1
	SWAP	D1
	MOVE	D5,D0
	ADD	D1,D0
	MOVE	D0,-(A7)
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	JSR	F232_dzzz_(PC)
	ADDA	#10,A7
	BRA	L65(PC)
	BRA.S	L67
L66:
	CMP	#-2,D0
	BEQ.S	L67
	BRA.S	L79
L67:
	MOVE	14(A6),-(A7)
	JSR	F285_szzz_(PC)
	ADDQ.L	#2,A7
	MOVE	D0,14(A6)
	CMPI	#0,D0
	BGE.S	L81
	MOVE	#0,D0
	BRA	L50(PC)
L81:
	MOVE	D7,-(A7)
	MOVE.L	A3,-(A7)
	JSR	F216_xxxx_(PC)
	ADDQ.L	#6,A7
	MOVE	D0,D5
	MOVE	D0,D4
	BRA	L65(PC)
	BRA.S	L80
L79:
	CMP	#-1,D0
	BEQ.S	L80
	BRA	L82(PC)
L80:
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	JSR	F175_gzzz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,A2
	MOVE	14(A6),-(A7)
	MOVE.L	A2,-(A7)
	JSR	F176_avzz_(PC)
	ADDQ.L	#6,A7
	MOVE	D0,-62(A6)
	BNE.S	L84
	MOVE	#0,D0
	BRA	L50(PC)
L84:
	SUBQ	#1,-62(A6)
	MOVE.B	4(A2),D0
	AND	#255,D0
	MOVE	D0,-60(A6)
	MULS	#26,D0
	LEA	G243_as_Gr(A4),A0
	ADDA	D0,A0
	LEA	(A0),A0
	MOVE.L	A0,-8(A6)
	CMPI	#-128,D7
	BNE.S	L85
	CMPI	#11,-60(A6)
	BNE.S	L85
	MOVE	-62(A6),D0
	ASL.L	#1,D0
	LEA	6(A2),A0
	ADDA	D0,A0
	LEA	(A0),A0
	MOVE.L	A0,-20(A6)
	MOVE	D7,-(A7)
	MOVE.L	A3,-(A7)
	JSR	F216_xxxx_(PC)
	ADDQ.L	#6,A7
	MOVE.L	D0,D1
	MOVE.L	-20(A6),A0
	MOVE	(A0),D0
	ADD	D1,D0
	MOVE	D0,-(A7)
	MOVE	#1000,-(A7)
	JSR	F024_aatz_(PC)
	ADDQ.L	#4,A7
	MOVE.L	-20(A6),A0
	MOVE	D0,(A0)
	BRA	L5T217_044(PC)
L85:
	MOVE.L	-8(A6),A0
	MOVE	2(A0),D0
	AND	#64,D0
	BEQ.S	L86
	CMPI	#-125,D7
	BEQ.S	L86
	MOVE	#0,D0
	BRA	L50(PC)
L86:
	MOVE	D7,-(A7)
	MOVE.L	A3,-(A7)
	JSR	F216_xxxx_(PC)
	ADDQ.L	#6,A7
	AND.L	#65535,D0
	ASL.L	#6,D0
	MOVE.L	-8(A6),A0
	MOVE.B	8(A0),D1
	AND	#255,D1
	AND.L	#65535,D0
	DIVU	D1,D0
	MOVE	D0,D5
	BEQ	L87(PC)
	MOVE	#1,-(A7)
	MOVE	G366_i_Pro(A4),-(A7)
	MOVE	-60(A6),-(A7)
	JSR	F192_ayzz_(PC)
	ADDQ.L	#4,A7
	MOVE.L	D0,D1
	MOVE	D5,D0
	ADD	D1,D0
	MOVE	D0,-(A7)
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	MOVE	-62(A6),-(A7)
	MOVE.L	A2,-(A7)
	JSR	F190_zzzz_(PC)
	ADDA	#14,A7
	MOVE	D0,D6
	CMPI	#2,D0
	BEQ.S	L88
	CLR	-(A7)
	MOVE	#-2,-(A7)
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	JSR	F209_xzzz_(PC)
	ADDQ.L	#8,A7
L88:
	MOVE	D6,G364_i_Cre(A4)
	MOVE	-48(A6),D0
	BNE.S	L89
	CMPI	#0,D6
	BNE.S	L89
	CMPI	#5,-58(A6)
	BNE.S	L89
	MOVE.L	-8(A6),A0
	MOVE	2(A0),D0
	AND	#1024,D0
	BEQ.S	L89
	MOVE	D7,-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,-16(A6)
	MOVE.L	-16(A6),A0
	MOVE	2(A0),D6
	AND	#127,D6
	CMPI	#8,D6
	BEQ.S	L91
	CMPI	#27,D6
	BEQ.S	L91
	CMPI	#28,D6
	BEQ.S	L91
	CMPI	#31,D6
	BEQ.S	L91
	CMPI	#32,D6
	BNE.S	L90
L91:
	LEA	2(A2),A0
	MOVE.L	A0,-24(A6)
L90:
L89:
L87:
L82:
L83:
L65:
	MOVE	D4,D0
	BEQ.S	L92
	MOVE	G367_i_Pro(A4),-(A7)
	MOVE	#12,-(A7)
	MOVE	D5,-(A7)
	MOVE	14(A6),-(A7)
	JSR	F321_AA29_(PC)
	ADDQ.L	#8,A7
	TST	D0
	BEQ.S	L92
	MOVE	G366_i_Pro(A4),D0
	BEQ.S	L92
	JSR	F028_a000_(PC)
	TST	D0
	BEQ.S	L92
	MOVE	G366_i_Pro(A4),-(A7)
	MOVE	14(A6),-(A7)
	JSR	F322_lzzz_(PC)
	ADDQ.L	#4,A7
L92:
	MOVE	-48(A6),D0
	BNE.S	L94
	MOVE	-56(A6),D0
	BEQ.S	L93
L94:
	MOVE	-56(A6),D0
	BEQ.S	L95
	MOVE	-26(A6),D7
	MOVE	-54(A6),-52(A6)
	BRA.S	L96
L95:
	MOVE.B	4(A3),D0
	AND	#255,D0
	MOVE	D0,-52(A6)
L96:
	CMPI	#-126,D7
	BNE.S	L97
	MOVE	-52(A6),D0
	LSR	#1,D0
	MOVE	D0,-52(A6)
	BNE.S	L97
	BRA.S	L5T217_044
L97:
	CMPI	#-121,D7
	BNE.S	L98
	MOVE	#255,D0
	BRA.S	L99
L98:
	MOVE	14(A6),D0
L99:
	MOVE	D0,-(A7)
	MOVE	-34(A6),-(A7)
	MOVE	-32(A6),-(A7)
	MOVE	-52(A6),-(A7)
	MOVE	D7,-(A7)
	JSR	F213_hzzz_(PC)
	ADDA	#10,A7
	BRA.S	L100
L93:
	MOVE	D7,D0
	AND	#15360,D0
	LSR	#2,D0
	LSR	#8,D0
	CMPI	#5,D0
	BNE.S	L101
	CLR	-52(A6)
	BRA.S	L102
L101:
	CMPI	#-122,D7
	BNE.S	L103
	MOVE	#13,-52(A6)
	BRA.S	L104
L103:
	MOVE	#4,-52(A6)
L104:
L102:
	MOVE	#1,-(A7)
	MOVE	-30(A6),-(A7)
	MOVE	-28(A6),-(A7)
	MOVE	-52(A6),-(A7)
	JSR	F064_aadz_(PC)
	ADDQ.L	#8,A7
L100:
L5T217_044:
	MOVE	-56(A6),D0
	BEQ.S	L105
	MOVE.L	-4(A6),A0
	MOVE	#-1,(A0)
	MOVE	-26(A6),2(A3)
L105:
	MOVE	-30(A6),-(A7)
	MOVE	-28(A6),-(A7)
	CLR	-(A7)
	MOVE	16(A6),-(A7)
	JSR	F164_dzzz_(PC)
	ADDQ.L	#8,A7
	MOVE	-30(A6),-(A7)
	MOVE	-28(A6),-(A7)
	MOVE.L	-24(A6),-(A7)
	MOVE	16(A6),-(A7)
	JSR	F215_lzzz_(PC)
	ADDA	#10,A7
	MOVE	#1,D0
L50:
	MOVEM.L	(A7)+,D4-D7/A2-A3
	UNLK	A6
	RTS
L$49:	.EQU	#-72
F218_ezzz_:/* global */
	LINK	A6,L$106
	MOVEM.L	D7-D5,-(A7)
	MOVE	14(A6),D7
	CLR	D5
	CLR	G364_i_Cre(A4)
L6T218_001:
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	JSR	F161_szzz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,D6
	BRA.S	L108
L109:
	MOVE	D6,D0
	AND	#15360,D0
	LSR	#2,D0
	LSR	#8,D0
	CMPI	#14,D0
	BNE.S	L112
	MOVE	D6,D0
	LSR	#6,D0
	LSR	#8,D0
	MOVE	D7,D1
	CMP	D1,D0
	BNE.S	L112
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	MOVE	12(A6),-(A7)
	MOVE	10(A6),-(A7)
	MOVE	8(A6),-(A7)
	JSR	F217_xxxx_(PC)
	ADDA	#10,A7
	TST	D0
	BEQ.S	L112
	MOVE	D6,-(A7)
	JSR	F214_pzzz_(PC)
	ADDQ.L	#2,A7
	ADDQ	#1,D5
	CMPI	#-1,8(A6)
	BNE.S	L113
	CMPI	#2,G364_i_Cre(A4)
	BNE.S	L113
	BRA.S	L111
L113:
	BRA.S	L6T218_001
L112:
L110:
	MOVE	D6,-(A7)
	JSR	F159_rzzz_(PC)
	ADDQ.L	#2,A7
	MOVE	D0,D6
L108:
	CMPI	#-2,D6
	BNE.S	L109
L111:
	MOVE	D5,D0
L107:
	MOVEM.L	(A7)+,D5-D7
	UNLK	A6
	RTS
L$106:	.EQU	#0
F219_xxxx_:/* global */
	LINK	A6,L$114
	MOVEM.L	A3-A2/D7-D4,-(A7)
	MOVE.L	8(A6),A0
	LEA	(A0),A1
	LEA	-22(A6),A0
	MOVEQ	#4,D0
	JSR	_blockmv(PC)
	LEA	-22(A6),A0
	MOVE.L	A0,A3
	MOVE	6(A3),D0
	MOVE	D0,D7
	MOVE	D0,-2(A6)
	MOVE	D0,-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,A2
	MOVE	8(A3),D0
	AND	#31,D0
	MOVE	D0,-6(A6)
	MOVE	8(A3),D0
	AND	#992,D0
	LSR	#5,D0
	MOVE	D0,-8(A6)
	MOVE.B	4(A3),D0
	AND	#255,D0
	CMP	#48,D0
	BNE.S	L116
	MOVE.B	#49,4(A3)
	BRA	L117(PC)
L116:
	MOVE	D7,D4
	LSR	#6,D4
	LSR	#8,D4
	MOVE	G272_i_Cur(A4),D0
	CMP	G309_i_Par(A4),D0
	BNE.S	L118
	MOVE	-6(A6),D0
	CMP	G306_i_Par(A4),D0
	BNE.S	L118
	MOVE	-8(A6),D0
	CMP	G307_i_Par(A4),D0
	BNE.S	L118
	MOVE	D7,-(A7)
	MOVE	D4,-(A7)
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	MOVE	#-2,-(A7)
	JSR	F217_xxxx_(PC)
	ADDA	#10,A7
	TST	D0
	BEQ.S	L118
	BRA	L115(PC)
L118:
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	JSR	F175_gzzz_(PC)
	ADDQ.L	#4,A7
	CMPI	#-2,D0
	BEQ.S	L119
	MOVE	-2(A6),-(A7)
	MOVE	D4,-(A7)
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	MOVE	#-1,-(A7)
	JSR	F217_xxxx_(PC)
	ADDA	#10,A7
	TST	D0
	BEQ.S	L119
	BRA	L115(PC)
L119:
	MOVE.B	4(A2),D0
	MOVE	8(A3),D1
	AND	#-4096,D1
	LSR	#4,D1
	LSR	#8,D1
	MOVE	D1,D6
	AND	#255,D0
	CMP	D1,D0
	BHI.S	L120
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	CLR	-(A7)
	MOVE	-2(A6),D0
	MOVE	D0,D7
	MOVE	D0,-(A7)
	JSR	F164_dzzz_(PC)
	ADDQ.L	#8,A7
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	CLR.L	-(A7)
	MOVE	D7,-(A7)
	JSR	F215_lzzz_(PC)
	ADDA	#10,A7
	BRA	L115(PC)
L120:
	MOVE	D6,D0
	SUB.B	D0,4(A2)
	MOVE.B	5(A2),D0
	AND	#255,D0
	CMP	D6,D0
	BCC.S	L121
	CLR.B	5(A2)
	BRA.S	L122
L121:
	MOVE	D6,D0
	SUB.B	D0,5(A2)
L122:
L117:
	MOVE	8(A3),D0
	AND	#3072,D0
	LSR	#2,D0
	LSR	#8,D0
	MOVE	D0,D5
	MOVE	6(A3),D1
	MOVE	D1,D7
	LSR	#6,D1
	LSR	#8,D1
	MOVE	D1,D4
	CMP	D1,D0
	SEQ	D0
	TST.B	D0
	BNE.S	L124
	MOVE	D5,D0
	ADDQ	#1,D0
	AND	#3,D0
	MOVE	D4,D1
	CMP	D1,D0
	SEQ	D0
	TST.B	D0
L124:
	AND	#1,D0
	MOVE	D0,-4(A6)
	BEQ	L123(PC)
	MOVE	-6(A6),-10(A6)
	MOVE	-8(A6),-12(A6)
	MOVE	D5,D1
	ASL.L	#1,D1
	LEA	G233_ai_Gr(A4),A0
	ADDA	D1,A0
	MOVE	(A0),D1
	MOVE	-6(A6),D0
	ADD	D1,D0
	MOVE	D0,-6(A6)
	MOVE	D5,D1
	ASL.L	#1,D1
	LEA	G234_ai_Gr(A4),A0
	ADDA	D1,A0
	MOVE	(A0),D1
	MOVE	-8(A6),D0
	ADD	D1,D0
	MOVE	D0,-8(A6)
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	JSR	F151_rzzz_(PC)
	ADDQ.L	#4,A7
	AND	#255,D0
	MOVE	D0,D6
	LSR	#5,D0
	CMPI	#0,D0
	BEQ.S	L126
	MOVE	D6,D0
	LSR	#5,D0
	CMPI	#6,D0
	BNE.S	L127
	MOVE	D6,D0
	AND	#5,D0
	BEQ.S	L126
L127:
	MOVE	D6,D0
	LSR	#5,D0
	CMPI	#3,D0
	BNE.S	L125
	MOVE	-10(A6),D0
	ASL.L	#2,D0
	MOVE.L	G271_ppuc_(A4),A0
	ADDA	D0,A0
	MOVE.L	(A0),A0
	ADDA	-12(A6),A0
	MOVE.B	(A0),D0
	AND	#255,D0
	ASR	#5,D0
	CMPI	#3,D0
	BNE.S	L125
L126:
	MOVE	D7,-(A7)
	MOVE	D4,-(A7)
	MOVE	-12(A6),-(A7)
	MOVE	-10(A6),-(A7)
	MOVE	D6,D0
	LSR	#5,D0
	MOVE	D0,-(A7)
	JSR	F217_xxxx_(PC)
	ADDA	#10,A7
	TST	D0
	BEQ.S	L128
	BRA	L115(PC)
L128:
L125:
L123:
	MOVE	D5,D0
	AND	#1,D0
	MOVE	D4,D1
	AND	#1,D1
	CMP	D1,D0
	BNE.S	L129
	SUBQ	#1,D4
	BRA.S	L130
L129:
	ADDQ	#1,D4
L130:
	MOVE	D4,D1
	AND	#3,D1
	MOVE	D1,D4
	ASL	#6,D1
	ASL	#8,D1
	MOVE	D7,D0
	AND	#16383,D0
	OR	D1,D0
	MOVE	D0,D7
	MOVE	-4(A6),D0
	BEQ	L131(PC)
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	MOVE	-12(A6),-(A7)
	MOVE	-10(A6),-(A7)
	MOVE	D7,-(A7)
	JSR	F267_dzzz_(PC)
	ADDA	#10,A7
	MOVE	G397_i_Mov(A4),D0
	AND	#31,D0
	MOVE	D0,D3
	ANDI	#-32,8(A3)
	OR	D3,8(A3)
	MOVE	G398_i_Mov(A4),D0
	AND	#31,D0
	MOVE	D0,D3
	ASL	#5,D3
	ANDI	#-993,8(A3)
	OR	D3,8(A3)
	MOVE	G400_i_Mov(A4),D0
	AND	#3,D0
	MOVE	D0,D3
	ASL	#2,D3
	ASL	#8,D3
	ANDI	#-3073,8(A3)
	OR	D3,8(A3)
	MOVE	D7,D0
	AND	#16383,D0
	MOVE	G401_ui_Mo(A4),D1
	ASL	#6,D1
	ASL	#8,D1
	OR	D1,D0
	MOVE	D0,D7
	MOVE.L	(A3),D0
	AND.L	#16777215,D0
	MOVE	G399_ui_Mo(A4),D1
	AND.L	#65535,D1
	MOVE.L	#24,D3
	ASL.L	D3,D1
	OR.L	D1,D0
	MOVE.L	D0,(A3)
	BRA.S	L132
L131:
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	JSR	F151_rzzz_(PC)
	ADDQ.L	#4,A7
	AND	#255,D0
	ASR	#5,D0
	CMPI	#4,D0
	BNE.S	L133
	MOVE	-2(A6),-(A7)
	MOVE	D4,-(A7)
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	MOVE	#4,-(A7)
	JSR	F217_xxxx_(PC)
	ADDA	#10,A7
	TST	D0
	BEQ.S	L133
	BRA.S	L115
L133:
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	CLR	-(A7)
	MOVE	D7,-(A7)
	JSR	F164_dzzz_(PC)
	ADDQ.L	#8,A7
	MOVE	-8(A6),-(A7)
	MOVE	-6(A6),-(A7)
	CLR	-(A7)
	MOVE	D7,-(A7)
	JSR	F163_amzz_(PC)
	ADDQ.L	#8,A7
L132:
	ADDQ.L	#1,(A3)
	MOVE	D7,6(A3)
	MOVE.L	A3,-(A7)
	JSR	F238_pzzz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,6(A2)
L115:
	MOVEM.L	(A7)+,D4-D7/A2-A3
	UNLK	A6
	RTS
L$114:	.EQU	#-22
F220_xxxx_:/* global */
	LINK	A6,L$134
	MOVEM.L	A3-A2/D7-D4,-(A7)
	MOVE.L	8(A6),A3
	MOVE.B	6(A3),D7
	AND	#255,D7
	MOVE.B	7(A3),D6
	AND	#255,D6
	MOVE	8(A3),D0
	AND	#1023,D0
	MOVE.L	G284_apuc_+60(A4),D1
	ASL.L	#2,D0
	MOVE.L	D1,A0
	ADDA	D0,A0
	LEA	(A0),A0
	MOVE.L	A0,A2
	MOVE	D6,D4
	MOVE	D7,D1
	ASL.L	#2,D1
	MOVE.L	G271_ppuc_(A4),A0
	ADDA	D1,A0
	MOVE.L	(A0),A0
	ADDA	D4,A0
	MOVE.B	(A0),D4
	AND	#255,D4
	ASR	#5,D4
	MOVE	G272_i_Cur(A4),D0
	CMP	G309_i_Par(A4),D0
	SEQ	D0
	TST.B	D0
	BEQ.S	L137
	MOVE	D7,D0
	MOVE	G306_i_Par(A4),D1
	CMP	D1,D0
	SEQ	D0
	TST.B	D0
L137:
	TST.B	D0
	BEQ.S	L136
	MOVE	D6,D0
	MOVE	G307_i_Par(A4),D1
	CMP	D1,D0
	SEQ	D0
	TST.B	D0
L136:
	AND	#1,D0
	MOVE	D0,-16(A6)
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	JSR	F175_gzzz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,-10(A6)
	CMPI	#-2,D0
	BEQ.S	L138
	MOVE	-10(A6),-(A7)
	JSR	F156_afzz_(PC)
	ADDQ.L	#2,A7
	MOVE.L	D0,-4(A6)
	MOVE.L	-4(A6),A0
	MOVE.B	4(A0),D0
	AND	#255,D0
	MOVE	D0,-14(A6)
	MULS	#26,D0
	LEA	G243_as_Gr(A4),A0
	ADDA	D0,A0
	LEA	(A0),A0
	MOVE.L	A0,-8(A6)
L138:
	MOVE	#-128,D0
	MOVE	2(A2),D1
	AND	#127,D1
	ADD	D1,D0
	MOVE	D0,-12(A6)
	CMPI	#-121,D0
	BNE.S	L139
	MOVE	#4,-(A7)
	MOVE	2(A2),D0
	AND	#-256,D0
	LSR	#8,D0
	LSR	#5,D0
	MOVE	D0,-(A7)
	JSR	F024_aatz_(PC)
	ADDQ.L	#4,A7
	MOVE.L	D0,-(A7)
	JSR	F028_a000_(PC)
	MOVE.L	D0,D1
	MOVE.L	(A7)+,D0
	ADD	D1,D0
	MOVE	D0,-(A7)
	MOVE	#1,-(A7)
	JSR	F025_aatz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,D5
	BRA.S	L140
L139:
	MOVE	2(A2),D5
	AND	#-256,D5
	LSR	#8,D5
	LSR	#1,D5
	ADDQ	#1,D5
	JSR	F027_AA59_(PC)
	AND.L	#65535,D0
	DIVU	D5,D0
	SWAP	D0
	ADDQ	#1,D0
	ADD	D0,D5
L140:
	MOVE	-12(A6),D0
L141:
	CMP	#-126,D0
	BEQ.S	L142
	BRA.S	L144
L142:
	MOVE	D5,D0
	ASR	#1,D0
	MOVE	D0,D5
	BNE.S	L146
	BRA	L143(PC)
L146:
	BRA.S	L145
L144:
	CMP	#-128,D0
	BEQ.S	L145
	BRA.S	L147
L145:
	CMPI	#4,D4
	BNE.S	L149
	CLR	-(A7)
	MOVE	#1,-(A7)
	MOVE	D5,-(A7)
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	JSR	F232_dzzz_(PC)
	ADDA	#10,A7
L149:
	BRA	L143(PC)
	BRA.S	L148
L147:
	CMP	#-125,D0
	BEQ.S	L148
	BRA	L150(PC)
L148:
	CMPI	#-2,-10(A6)
	BEQ	L152(PC)
	MOVE.L	-8(A6),A0
	MOVE	2(A0),D0
	AND	#64,D0
	BEQ	L152(PC)
	CMPI	#19,-14(A6)
	BNE	L153(PC)
	MOVE	G272_i_Cur(A4),D0
	CMP	G309_i_Par(A4),D0
	BNE	L153(PC)
	MOVE	D5,D0
	ASR	#3,D0
	MOVE	D0,-14(A6)
	SUB	D0,D5
	MOVE	-14(A6),D0
	ASL	#1,D0
	MOVE	D0,-14(A6)
	ADDQ	#1,-14(A6)
	MOVE.L	-4(A6),A0
	MOVE	14(A0),D4
	AND	#96,D4
	LSR	#5,D4
L154:
	MOVE.L	-4(A6),A0
	MOVE.B	5(A0),D0
	AND	#255,D0
	MULS	#16,D0
	MOVE.L	G375_ps_Ac(A4),A0
	ADDA	D0,A0
	LEA	12(A0),A0
	ADDA	D4,A0
	MOVE.B	(A0),D0
	AND	#255,D0
	AND	#128,D0
	BEQ.S	L157
	MOVE	#1,-(A7)
	JSR	F027_AA59_(PC)
	AND.L	#65535,D0
	DIVU	-14(A6),D0
	SWAP	D0
	MOVE	D0,-36(A6)
	MOVE	D5,D0
	ADD	-36(A6),D0
	MOVE.L	D0,-(A7)
	JSR	F029_AA19_(PC)
	MOVE.L	D0,D1
	MOVE.L	(A7)+,D0
	ADD	D1,D0
	MOVE	D0,-(A7)
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	MOVE	D4,-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	F190_zzzz_(PC)
	ADDA	#14,A7
L157:
L155:
	SUBQ	#1,D4
	MOVE	D4,D0
	CMPI	#0,D0
	BGE.S	L154
L156:
	BRA.S	L158
L153:
	MOVE	#1,-(A7)
	MOVE	D5,-(A7)
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	F191_aayz_(PC)
	ADDA	#12,A7
L158:
L152:
	BRA	L143(PC)
	BRA.S	L151
L150:
	CMP	#-28,D0
	BEQ.S	L151
	BRA.S	L159
L151:
	MOVE	2(A2),D0
	AND	#127,D0
	ADDQ	#1,D0
	AND	#127,D0
	MOVE	D0,D3
	ANDI	#-128,2(A2)
	OR	D3,2(A2)
	MOVE	#1,-(A7)
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	MOVE	#5,-(A7)
	JSR	F064_aadz_(PC)
	ADDQ.L	#8,A7
	BRA	L8T220_026(PC)
	BRA.S	L160
L159:
	CMP	#-88,D0
	BEQ.S	L160
	BRA.S	L161
L160:
	MOVE	2(A2),D0
	AND	#-256,D0
	LSR	#8,D0
	CMPI	#55,D0
	BLS.S	L163
	MOVE	2(A2),D0
	AND	#-256,D0
	LSR	#8,D0
	SUB	#40,D0
	AND	#255,D0
	MOVE	D0,D3
	ASL	#8,D3
	ANDI	#255,2(A2)
	OR	D3,2(A2)
	BRA	L8T220_026(PC)
L163:
	BRA	L143(PC)
	BRA.S	L162
L161:
	CMP	#-121,D0
	BEQ.S	L162
	BRA	L164(PC)
L162:
	MOVE	-16(A6),D0
	BEQ.S	L166
	CLR	-(A7)
	CLR	-(A7)
	MOVE	D5,-(A7)
	JSR	F324_aezz_(PC)
	ADDQ.L	#6,A7
	BRA.S	L167
L166:
	CMPI	#-2,-10(A6)
	BEQ.S	L168
	MOVE	D5,-(A7)
	MOVE	-14(A6),-(A7)
	JSR	F192_ayzz_(PC)
	ADDQ.L	#4,A7
	MOVE	D0,D5
	BEQ.S	L168
	MOVE	#1,-(A7)
	MOVE	D5,-(A7)
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	MOVE.L	-4(A6),-(A7)
	JSR	F191_aayz_(PC)
	ADDA	#12,A7
	CMPI	#2,D0
	BEQ.S	L168
	CMPI	#2,D5
	BLE.S	L168
	CLR	-(A7)
	MOVE	#-3,-(A7)
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	JSR	F209_xzzz_(PC)
	ADDQ.L	#8,A7
L168:
L167:
	MOVE	2(A2),D0
	AND	#-256,D0
	LSR	#8,D0
	CMPI	#6,D0
	BCS.S	L169
	MOVE	2(A2),D0
	AND	#-256,D0
	LSR	#8,D0
	SUBQ	#3,D0
	AND	#255,D0
	MOVE	D0,D3
	ASL	#8,D3
	ANDI	#255,2(A2)
	OR	D3,2(A2)
L8T220_026:
	LEA	(A3),A1
	LEA	-26(A6),A0
	MOVEQ	#4,D0
	JSR	_blockmv(PC)
	ADDQ.L	#1,-26(A6)
	PEA	-26(A6)
	JSR	F238_pzzz_(PC)
	ADDQ.L	#4,A7
	BRA.S	L135
L169:
L164:
L165:
L143:
	MOVE	D6,-(A7)
	MOVE	D7,-(A7)
	CLR	-(A7)
	MOVE	8(A3),-(A7)
	JSR	F164_dzzz_(PC)
	ADDQ.L	#8,A7
	MOVE	#-1,(A2)
L135:
	MOVEM.L	(A7)+,D4-D7/A2-A3
	UNLK	A6
	RTS
L$134:	.EQU	#-36
