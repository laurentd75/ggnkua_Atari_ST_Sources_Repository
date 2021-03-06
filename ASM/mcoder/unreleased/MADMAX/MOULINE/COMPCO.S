MUS=1
BASE=$40000
NOTIME=1	;0=PAS D'ATTENTE VBL
DOUBLE=0	;0=PAS REPLAY TFMX
SOURCE=BASE+$8D8
DEST=$50000
INITMUS2=BASE
PLAYMUS2=BASE+8
PSGREG2=BASE+$7AA

	BRA	CODE
CPT:	DC.W	$4C41
X:
	MOVEQ	#MUS,D0
	JSR	INITMUS2

;REPL:	JSR	PLAYMUS2
;	SUBQ	#1,CPT
;	BNE.S	REPL

BCL:
	MOVE	#37,-(SP)
	TRAP	#14
	ADDQ	#2,SP

	JSR	PLAYMUS2

	MOVE	#$FF,-(SP)
	MOVE	#6,-(SP)
	TRAP	#1
	ADDQ	#4,SP

	TST	D0
	BEQ.S	BCL
	ILLEGAL
CODE:
;
;
; transformeur de fichiers TFMX en COSO
;
	lea	SOURCE,A5
	LEA	DEST,A6

	move.l	#'COSO',(a6)+
	moveq	#7-1,d0
clrcos:	clr.l	(a6)+
	dbra	d0,clrcos

	moveq	#8-1,d0
copcos:	move.l	(a5)+,(a6)+
	dbra	d0,copcos

	move.l	a6,d0
	sub.l	#dest,d0
	move.l	d0,dest+4

	move	dest+$24,d7
	move	d7,d0
	addq	#1,d0
	add	d0,d0
	move.l	a6,a4
	add	d0,a6

	bsr	comp1

	move.l	a6,d0
	sub.l	#dest,d0
	move.l	d0,dest+8

	move	dest+$26,d7
	MOVE	D7,D0
	addq	#1,d0
	add	d0,d0
	move.l	a6,a4
	add	d0,a6

	bsr	comp1

	move.l	a6,d0
	sub.l	#dest,d0
	move.l	d0,dest+12

	MOVE	dest+$28,d7

	move	d7,d0
	addq	#1,d0
	add	d0,d0
	move.l	a6,a4
	add	d0,a6
copx1:
	subq	#1,testbug
	bne.s	notestbug
;	move.l	A6,TSTBUG
;	illegal
	bra.s	notestbug
TSTBUG:	DC.L	0
testbug:dc.w	$27
sava5:	dc.l	0
notestbug:
	move.l	a6,d0
	sub.l	#dest,d0
	move	d0,(a4)+

	move	dest+$2c,d6
	MOVE.L	A5,A3
	ADD	D6,A3
	MOVE.L	A5,sava5	;POUR DEBUGGAGE

	MOVEQ	#-1,D5
reppat:
	cmp.l	a3,a5
	bhs.s	finpat
	TST.b	(a5)
	beq	pat0

	move.l	A5,A1
	moveq	#-1,d0
cppat:
	addq	#1,d0
	addq	#2,a5
	cmp.l	a3,a5
	bhs.s	cpp1
	TST.b	(A5)
	beq.s	cppat
cpp1:
	CMP	D5,D0
	BEQ.S	SAME1
	MOVE	D0,D5
	MOVE.B	#$FE,(A6)+
	move.b	d0,(a6)+
SAME1:
	move.b	(a1)+,(a6)+
	move.b	(a1)+,d0
	move.b	d0,(a6)+
	and	#$e0,d0
	beq.s	REPPAT

	subq	#2,a1
	cmp.l	sava5,a1
	bne.s	except1
	move.l	a3,a1
except1:
	move.b	-(a1),(a6)+
	BRA.s	REPPAT

pat0:
	move.b	#$fd,(a6)+
	MOVEQ	#-1,d0
pat00:
	addq	#1,d0
	addq	#2,a5
	cmp.l	a3,a5
	bhs.s	pat01
	tst.b	(a5)
	beq.s	pat00
pat01:
	MOVE	D0,D5
	move.b	d0,(a6)+
	bra.s	reppat

finpat:
	CMP.L	A3,A5
	BEQ.S	GOODPAT
	MOVEQ	#-1,D0
	ILLEGAL
	MOVE.L	A3,A5
GOODPAT:
	move.b	#$ff,(a6)+

	dbra	d7,copx1

	move	a6,d0
	lsr	#1,d0
	bcc.s	pair2
	clr.b	(a6)+
pair2:

	move.l	a6,d0
	sub.l	#dest,d0
	move.l	d0,dest+16

	MOVE	dest+$2a,d7

allpat:	move.l	(a5)+,(a6)+
	move.l	(a5)+,(a6)+
	move.l	(a5)+,(a6)+
	dbra	d7,allpat

	MOVE.L	A6,SAVA6
	move.l	a6,d0
	sub.l	#dest,d0
	move.l	d0,dest+20

	moveq	#8-1,d0

;	ADDQ	#2,A5		;SKIPPE NB MUSICS

all2:
	MOVE.L	(A5),D1
	OR	4(A5),D1
	TST.L	D1
	BEQ.S	FINISHED
	move	(a5)+,(a6)+
	move	(a5)+,(a6)+
	move	(a5)+,(a6)+
	dbra	d0,all2
FINISHED:

	LEA	DEST,A0
	MOVE.L	A6,A1
	MOVE.L	SAVA6,A2

	illegal
SAVA6:	DC.L	0
rep0:
	cmp	d4,d5
	beq.s	good
	TST	D5
	BEQ.S	ZEROX
	tst	d3
	beq.s	nothing
	move.b	#$fe,(a6)+
	bra.s	deja
nothing:
	move.b	#$fd,(a6)+
deja:
	SUBQ.B	#1,D5
	move.b	d5,(a6)+
	ADDQ.B	#1,D5
ZEROX:
	move	d5,d4
good:	clr	d5
	rts

comp1:
	move.l	a5,a0
	move.l	a6,d0
	sub.l	#DEST,d0
	move	d0,(a4)+
	lea	64(a5),a5
copy1:
	cmp.l	a5,a0
	beq.s	fincp1
	move.b	(a0)+,d0
	move.b	d0,(a6)+
	cmp.b	#$e1,d0
	beq.s	fincp1
	cmp.b	#$e0,d0
	bne.s	copy1
	move.b	(a0)+,(a6)+
fincp1:
	dbra	d7,comp1

	move	a6,d0
	lsr	#1,d0
	bcc.s	pair
	clr.b	(a6)+
pair:
	rts
O:
LA2E=$50000
;	opt	o+
;	opt	ow-
;
; replay COSO
;
; ce qu'il faut rajouter :
;	compteur de notes (permet de calculer la longueur des musiques)
;	cf count
;	calculer fin des musiques � sauver (cf L930)
;	cf endvoice
;	TFMX->COSO
;
; �diteur :
;	MadMax n'utilise pas les fonctions de vibrato de Whittaker
;	 ni sa batterie !!!
;
; optimisations en minuscules
; � faire :
;
; a2->a1
;
; exemple :
;
	MOVE	SR,D0
	AND	#$2000,D0
	BNE.S	SUPER
	CLR.L	-(SP)
	MOVE	#$20,-(SP)
	TRAP	#1
	ADDQ	#6,SP
SUPER:
	LEA	LA2E,A0
	moveq	#MUS,d0
	bsr	initmus

	IF	DOUBLE
	moveq	#MUS,d0
	JSR	INITMUS2
	ENDIF

	move	#$d60-1-$40+$2f00,d0
	moveq	#0-1,d0
	bmi.s	nodec
decont:	move	d0,-(sp)
	MOVE	#$700,$FFFF8240.W
	bsr	playmus
	CLR	$FFFF8240.W

	IF	DOUBLE
	MOVE	#$700,$FFFF8240.W
	JSR	playmus2
	CLR	$FFFF8240.W
	ENDIF

	move	(sp)+,d0
	dbra	d0,decont
nodec:

BOUCLE:
	IF	NOTIME
	MOVE	#37,-(SP)
	TRAP	#14
	ADDQ	#2,SP
	ENDIF

	IF	DOUBLE

	MOVE	#1000,D0
WAIT:	DBRA	D0,WAIT

	MOVE	#$700,$FFFF8240.W
	JSR	PLAYMUS2
	CLR	$FFFF8240.W

	ENDIF

	IF	NOTIME
	MOVE	#5000,D0
WAIT2:	DBRA	D0,WAIT2
	ENDIF

	addq.l	#1,count
	MOVE	#$700,$FFFF8240.W
	BSR	PLAYMUS
	CLR	$FFFF8240.W

	IF	DOUBLE
	LEA	PSGREG,A0
	LEA	PSGREG2,A1
	MOVEQ	#11-1,D1
TSTMUS:	MOVE.B	2(A0),D0
	CMP.B	2(A1),D0
	bra.s	nobug
	BEQ.S	NOBUG
	MOVE.L	COUNT,D0
	ILLEGAL
NOBUG:	ADDQ	#4,A0
	ADDQ	#4,A1
	DBRA	D1,TSTMUS
	ENDIF

	cmp	#3,voicefin
	beq.s	finito

	MOVE	#$FF,-(SP)
	MOVE	#6,-(SP)
	TRAP	#1
	ADDQ	#4,SP
	TST	D0
	BEQ.S	BOUCLE
finito:
	lea	LA2E,a0
	move.l	endvoice,a1
	addq	#6,a1
	move.l	count,d0
	add.l	d0,d0		;en centi�mes

	illegal
voicefin:dc.w	0
count:	dc.l	0
endvoice:dc.l	0
;	rsreset

off22=0	;rs.l	1	;ptr courant dans pattern
off0=4	;rs.l	1	;ptr base patterns
off34=8	;rs.l	1	;ptr fin musique

off4=12	;rs.w	1	;ptr patterns (.W au lieu de .L)
offa=14	;rs.l	1	;ptr base modulation volume
offe=18	;rs.w	1	;ptr modulation volume (.W au lieu de .L)
off12=20	;rs.l	1	;ptr base modulation fr�quence
off30=24	;rs.w	1	;ptr modulation fr�quence (.W au lieu de .L)

off38=26	;rs.l	1	;incr�ment pour crescendo

off8=30	;rs.b	1
off9=31	;rs.b	1

off16=32	;rs.b	1
off17=33	;rs.b	1
off18=34	;rs.b	1
off19=35	;rs.b	1
off1a=36	;rs.b	1
off1b=37	;rs.b	1
off1c=38	;rs.b	1
off1d=39	;rs.b	1
off1e=40	;rs.b	1
off1f=41	;rs.b	1
off21=42	;rs.b	1

off26=43	;rs.b	1
off27=44	;rs.b	1
off28=45	;rs.b	1	;15-volume sonore de la voix
off2a=46	;rs.b	1	;0,1 ou 2=type de son
off2b=47	;rs.b	1
off2c=48	;rs.b	1
off2d=49	;rs.b	1	;volume sonore calcul�
off2e=50	;rs.b	1
off3c=52	;equ	(__RS+1)&-2
;
; init musique
;
; entr�e :
;	A0=pointe sur le texte 'COSO'
;	D0=num�ro de la musique � jouer
;
initmus:
	TST	D0		;musique=0 -> cut mus
	BEQ	LCA
	subq	#1,d0

	LEA	PSGREG(PC),A6
	MOVE.L	A0,L934-PSGREG(A6)
	MOVE.L	4(A0),A1
	ADD.L	A0,A1
	MOVE.L	A1,L938-PSGREG(A6)
	MOVE.L	8(A0),A1
	ADD.L	A0,A1
	MOVE.L	A1,L93C-PSGREG(A6)
	MOVE.L	$C(A0),A1
	ADD.L	A0,A1
	MOVE.L	A1,L91A-PSGREG(A6)
	MOVE.L	$10(A0),A1
	ADD.L	A0,A1
	MOVE.L	A1,L916-PSGREG(A6)
	MOVE.L	$14(A0),A1
	ADD.L	A0,A1
	move.l	a1,endvoice
	ADD	D0,D0
	MOVE	D0,D1
	ADD	D0,D0
	ADD	D1,D0
	ADD	D0,A1
	MOVEQ	#$C,D7
	MULU	(A1)+,D7	;PREMIER PATTERN
	MOVE	(A1)+,D6
	ADDQ	#1,D6
	MULU	#$C,D6		;DERNIER PATTERN

	MOVE	(A1)+,D0
	MOVE.B	D0,L810-PSGREG(A6)

	MOVEQ	#0,D0
	LEA	voice0(PC),A0
	LEA	L7C6(PC),A1
L658:	MOVE.L	A1,offa(a0)
	clr	offe(a0)
	CLR.B	off2d(A0)
	CLR.B	off8(a0)
	CLR.B	off9(a0)
	MOVE.L	A1,off12(A0)
	clr	off30(a0)
	MOVE.B	#1,off17(A0)
	MOVE.B	#1,off18(A0)
	CLR.B	off19(A0)
	clr.b	off1a(a0)
	clr.b	off1b(a0)
	clr.b	off1c(a0)
	clr.b	off1d(a0)
	clr.b	off1e(A0)
	clr.b	off1f(a0)
	move.l	d0,d3
	MOVE.B	d3,off21(A0)
	ADD	D3,D3
	ADD	D3,D3
	MOVE.L	L916(PC),d1
	add.l	D7,d1
	add.l	D3,d1
	move.l	d1,off0(A0)
	move.l	d1,a3
	MOVE.L	L916(PC),d1
	add.l	d6,d1
	add.l	d3,d1
	move.l	d1,off34(A0)
	move	#$C,off4(a0)
	moveq	#0,d1
	move.b	(A3)+,D1
	ADD	D1,D1
	MOVE.L	L91A(PC),A4
	MOVE	(A4,D1.W),A4
	ADD.L	L934(PC),A4
	MOVE.L	A4,off22(A0)
	clr.b	off26(A0)
	clr.b	off27(A0)
	MOVE.B	#2,off2a(A0)
	move.b	(A3)+,off2c(A0)
	CLR.B	off2b(A0)
	move.b	(A3)+,off16(A0)
	moveq	#$10,d1
	add.B	(A3),D1
	bcs.s	L712
	moveq	#0,d1
L712:
	MOVE.B	D1,off28(A0)
	CLR.L	off38(A0)
	lea	off3c(a0),A0
	addq	#1,d0
	cmp	#3,d0
	blo	L658
	MOVE.B	#1,L80E-PSGREG(A6)
	CLR	L812-PSGREG(A6)

	clr.B	$22(A6)
	clr.B	$26(A6)
	clr.B	$2A(A6)
	MOVEM.L	$1C(A6),D0-D3
	MOVEM.L	D0-D3,$FFFF8800.W
	RTS
LCA:	LEA	L812(PC),A0
	ST	(A0)
	BRA	L12C
PLAYMUS:
L12C:
	LEA	PSGREG(PC),A6
	TST.B	L812-PSGREG(A6)
	BEQ.S	L160
	TAS	L813-PSGREG(A6)
	BNE.S	L15E
	clr.B	$22(A6)
	clr.B	$26(A6)
	clr.B	$2A(A6)
	MOVEM.L	$1C(A6),D0-D3
	MOVEM.L	D0-D3,$FFFF8800.W
L15E:	RTS
L160:	SUBQ.B	#1,L80E-PSGREG(A6)
	BNE.S	L180
	MOVE.B	L810-PSGREG(A6),L80E-PSGREG(A6)
	MOVEQ	#0,D5
	LEA	voice0(PC),A0
	MOVE	#$007,$FFFF8240.W
	BSR.s	L25C
	LEA	voice1(PC),A0
	BSR.s	L25C
	LEA	voice2(PC),A0
	BSR.s	L25C
L180:	move.b	#$C0,$1E(A6)
	LEA	voice0(PC),A0
	BSR	L39A
	move	d0,6(A6)
	MOVE.B	D0,2(A6)
	MOVE.B	D1,$22(A6)
	LEA	voice1(PC),A0
	BSR	L39A
	move	d0,$E(A6)
	MOVE.B	D0,$A(A6)
	MOVE.B	D1,$26(A6)
	LEA	voice2(PC),A0
	BSR	L39A
	move	d0,$16(A6)
	MOVE.B	D0,$12(A6)
	MOVE.B	D1,$2A(A6)

	MOVEM.L	(A6),D0-D7/A0-A2
	MOVEM.L	D0-D7/A0-A2,$FFFF8800.W
L25A:	RTS
;
; calcule nouvelle note
;
L25C:	SUBQ.B	#1,off26(A0)
	BPL.S	L25A
	MOVE.B	off27(A0),off26(A0)
	MOVE.L	off22(A0),A1
L26C:
	CMP.L	TSTBUG,A1
	BNE.S	notst
	CLR	$FFFF8240.W
	ILLEGAL
notst:
	MOVE.B	(A1)+,D0
	CMP.B	#$FF,D0
	BNE.S	L2E2
	MOVE.L	off0(a0),a1
	add	off4(a0),a1
	cmp.l	off34(a0),a1
	blo.S	L288
	addq	#1,voicefin
	move	d5,off4(a0)
	MOVE.L	off0(a0),a1
L288:	MOVEQ	#0,D1
	move.b	(a1)+,D1
	move.b	(a1)+,off2c(A0)
	move.b	(a1)+,off16(A0)
	moveq	#$10,d0
	add.b	(a1)+,D0
	bcc.s	L2B4
	move.b	d0,off28(A0)		;F0-FF=volume � soustraire
	BRA.S	L2C4
L2B4:	add.b	#$10,d0
	bcc.S	L2C4
	move.B	d0,L810-PSGREG(A6)	;E0-EF=vitesse
L2C4:	ADD	D1,D1
	MOVE.L	L91A(PC),A1
	MOVE	(A1,D1.W),A1
	ADD.L	L934(PC),A1
	MOVE.L	A1,off22(A0)
	add	#$C,off4(a0)
	BRA.s	L26C
L2E2:	CMP.B	#$FE,D0
	BNE.S	L2F4
	MOVE.B	(A1)+,d0
	move.b	d0,off27(A0)
	MOVE.B	d0,off26(A0)
	BRA.s	L26C
L2F4:	CMP.B	#$FD,D0
	BNE.S	L308
	MOVE.B	(A1)+,d0
	move.b	d0,off27(A0)
	MOVE.B	d0,off26(A0)
	MOVE.L	A1,off22(A0)
	RTS
L308:	MOVE.B	D0,off8(a0)
	MOVE.B	(A1)+,D1
	MOVE.B	D1,off9(a0)
	AND	#$e0,D1			;d1=off9&$E0
	BEQ.S	L31C
	MOVE.B	(A1)+,off1f(A0)
L31C:	MOVE.L	A1,off22(A0)
	MOVE.L	D5,off38(A0)
	TST.B	D0
	BMI.S	L398
	MOVE.B	off9(a0),D0
	eor.b	d0,d1			;d1=off9&$1F
	ADD.B	off16(A0),D1

	MOVE.L	L93C(PC),a1
	ADD	D1,D1
	MOVE	(a1,D1.W),a1
	ADD.L	L934(PC),a1
	move	d5,offe(A0)
	MOVE.B	(a1)+,d1
	move.b	d1,off17(A0)
	MOVE.B	d1,off18(A0)
	MOVEQ	#0,D1
	MOVE.B	(a1)+,D1
	MOVE.B	(a1)+,off1b(A0)
;	MOVE.B	#$40,off2e(A0)
	clr.b	off2e(a0)
	MOVE.B	(a1)+,D2
	MOVE.B	D2,off1c(A0)
	MOVE.B	D2,off1d(A0)
	MOVE.B	(a1)+,off1e(A0)
	MOVE.L	a1,offa(A0)
	add.b	d0,d0			;test bit 6
	bpl.s	L37A
	MOVE.B	off1f(A0),D1
L37A:	MOVE.L	L938(PC),a1
	ADD	D1,D1
	MOVE	(a1,D1.W),a1
	ADD.L	L934(PC),a1
	MOVE.L	a1,off12(A0)
	move	d5,off30(A0)
	MOVE.B	D5,off1a(A0)
	MOVE.B	D5,off19(A0)
L398:	RTS
;
; calcul de la note � jouer
;
L39A:	MOVEQ	#0,D7
	MOVE	off30(a0),d6
L3A0:	TST.B	off1a(A0)
	BEQ.S	L3AE
	SUBQ.B	#1,off1a(A0)
	BRA	L4C01
L3AE:	MOVE.L	off12(A0),A1
	add	d6,a1
L3B6:	move.b	(a1)+,d0
	cmp.b	#$E1,d0
	BEQ	L4C01
	cmp.b	#$E0,d0
	BNE.S	L3D8
	moveq	#$3f,d6
	and.B	(A1),D6
	MOVE.L	off12(A0),A1
	add	d6,A1
	move.b	(a1)+,d0
L3D8:	cmp.b	#$E2,d0
	BNE.S	L3EE
	clr	offe(a0)
	MOVE.B	#1,off17(A0)
	addq	#1,d6
	bra.s	L3B6
L3EE:	cmp.b	#$E9,d0
	BNE.s	L422
	MOVE.B	#$B,$FFFF8800.W
	move.b	(A1)+,$FFFF8802.W
	move.l	#$0C0C0000,$FFFF8800.W
	move.l	#$0D0D0A0A,$FFFF8800.W
	addq	#2,d6
	bra.s	L3B6
L422:	cmp.b	#$E7,d0
	BNE.S	L44A
	clr	d0
	move.b	(A1),D0
	ADD	D0,D0
	MOVE.L	L938(PC),A1
	MOVE	(A1,D0.W),A1
	ADD.L	L934(PC),A1
	MOVE.L	A1,off12(A0)
	clr	d6
	BRA.s	L3B6
L44A:	cmp.b	#$E8,d0
	BNE.S	L45E
	move.b	(A1)+,off1a(A0)
	addq	#2,d6
	BRA	L3A0
L45E:	cmp.b	#$E4,d0
	BNE.S	L474
	clr.b	off2a(A0)
	MOVE.B	(A1)+,d7
	addq	#2,d6
	BRA.S	L4AE
L474:	cmp.b	#$E5,d0
	BNE.S	L488
	MOVE.B	#1,off2a(A0)
	addq	#1,d6
	BRA	L3B6
L488:	cmp.b	#$E6,d0
	BNE.S	L49A
	MOVE.B	#2,off2a(A0)
	addq	#1,d6
	BRA.S	L4AE
L49A:	cmp.b	#$E3,d0
	BNE.S	L4B0
	addq	#3,d6
	move.b	(A1)+,off1b(A0)
	move.b	(A1)+,off1c(A0)
L4AE:	move.b	(a1)+,d0
L4B0:
	MOVE.B	d0,off2b(A0)
	addq	#1,d6
L4C01:	move	d6,off30(a0)
;
; modulation volume
;
	move	offe(a0),d6
L4C0:	TST.B	off19(A0)
	BEQ.S	L4CC
	SUBQ.B	#1,off19(A0)
	BRA.S	L51A
L4CC:	SUBQ.B	#1,off17(A0)
	BNE.S	L51A
	MOVE.B	off18(A0),off17(A0)

	MOVE.L	offa(A0),A1
	add	d6,a1
	move.b	(A1)+,D0
	CMP.B	#$E0,D0
	BNE.S	L512
	moveq	#$3f,d6
	and.b	(A1),D6
	subq	#5,D6
	move.l	offa(a0),a1
	add	d6,a1
	move.b	(a1)+,d0
L512:
	CMP.B	#$E8,D0
	BNE.S	L4F4
	addq	#2,d6
	move.b	(A1)+,off19(A0)
	BRA.S	L4C0
L4F4:	CMP.B	#$E1,D0
	BEQ.S	L51A
	MOVE.B	d0,off2d(A0)
	addq	#1,d6
L51A:	move	d6,offe(a0)

	clr	d5
	MOVE.B	off2b(A0),D5
	BMI.S	L528
	ADD.B	off8(a0),D5
	ADD.B	off2c(A0),D5
L528:
	LEA	L94E(PC),A1
	add.b	D5,D5
	MOVE	(A1,d5.w),D0

	move.b	off2a(A0),D2	;0,1 ou 2
	beq.S	L57E

	MOVE.B	off21(A0),D3
	ADDQ	#3,D3

	subq.b	#1,D2
	BNE.S	L578
	subq	#3,d3
	MOVE.B	off2b(A0),D7
	bclr	#7,d7
	bne.s	L578
	add.b	off8(a0),d7
L578:	BSET	D3,$1E(A6)
L57E:
	tst.b	d7
	BEQ.S	L594
	not.b	d7
	and.b	#$1F,D7
	MOVE.B	D7,$1A(A6)
L594:
	MOVE.B	off2e(A0),d6
	TST.B	off1e(A0)
	BEQ.S	L5A4
	SUBQ.B	#1,off1e(A0)
	BRA.S	L5FA
L5A4:
	clr	d4
	MOVE.B	off1c(A0),D4
	clr	d1
	MOVE.B	off1d(A0),D1
	tst.b	d6
	bmi.S	L5CE
	SUB.B	off1b(A0),D1
	BCC.S	L5DC
	tas	d6
	MOVEQ	#0,D1
	BRA.S	L5DC
L5CE:	ADD.B	off1b(A0),D1
	ADD.B	D4,D4
	CMP.B	D4,D1
	BCS.S	L5DA
	bclr	#7,d6
	MOVE.B	D4,D1
L5DA:	lsr.b	#1,d4
L5DC:	MOVE.B	D1,off1d(A0)
L5E0:
	sub	D4,D1

	ADD.B	#$A0,D5
	BCS.S	L5F8
	moveq	#$18,d4

	add	d1,d1
	add.b	d4,d5
	bcs.s	L5F8
	add	d1,d1
	add.b	d4,d5
	bcs.s	L5F8
	add	d1,d1
	add.b	d4,d5
	bcs.s	L5F8
	add	d1,d1
L5F8:	ADD	D1,D0
L5FA:	EOR.B	#1,d6
	MOVE.B	d6,off2e(A0)
	BTST	#5,off9(a0)
	BEQ.s	L628
	moveq	#0,D1
	MOVE.B	off1f(A0),D1
	EXT	D1
	swap	d1
	lsr.l	#4,d1		;asr.l #4,d1 corrige bug ???
	add.l	d1,off38(a0)
	SUB	off38(a0),D0
L628:	MOVE.B	off2d(A0),D1
	SUB.B	off28(A0),D1
	BPL.S	L634
	MOVEQ	#0,D1
L634:
	RTS

L94E:	DC.W	$EEE,$E17,$D4D,$C8E
	DC.W	$BD9,$B2F,$A8E,$9F7
	DC.W	$967,$8E0,$861,$7E8
	DC.W	$777,$70B,$6A6,$647
	DC.W	$5EC,$597,$547,$4FB
	DC.W	$4B3,$470,$430,$3F4
	DC.W	$3BB,$385,$353,$323
	DC.W	$2F6,$2CB,$2A3,$27D
	DC.W	$259,$238,$218,$1FA
	DC.W	$1DD,$1C2,$1A9,$191
	DC.W	$17B,$165,$151,$13E
	DC.W	$12C,$11C,$10C,$FD
	DC.W	$EE,$E1,$D4,$C8
	DC.W	$BD,$B2,$A8,$9F
	DC.W	$96,$8E,$86,$7E
	DC.W	$77,$70,$6A,$64
	DC.W	$5E,$59,$54,$4F
	DC.W	$4B,$47,$43,$3F
	DC.W	$3B,$38,$35,$32
	DC.W	$2F,$2C,$2A,$27
	DC.W	$25,$23,$21,$1F
	DC.W	$1D,$1C,$1A,$19
	DC.W	$17,$16,$15,$13
	DC.W	$12,$11,$10,$F
L7C6:	DC.B	1,0,0,0,0,0,0,$E1
PSGREG:	DC.W	0,0,$101,0
	DC.W	$202,0,$303,0
	DC.W	$404,0,$505,0
	DC.W	$606,0,$707,$FFFF
	DC.W	$808,0,$909,0
	DC.W	$A0A,0

L80E:	DC.B	4
L810:	DC.B	4
L812:	DC.B	-1
L813:	DC.B	0

voice0:	blk.B	off3c
voice1:	blk.B	off3c
voice2:	blk.B	off3c
L916:	DC.L	0
L91A:	DC.L	0
L934:	DC.L	0
L938:	DC.L	0
L93C:	DC.L	0
