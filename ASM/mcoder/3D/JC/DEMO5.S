	opt	o+
DEBUG = 1		;0=debugger
ecran1 = $80000-32000
ecran0 = ecran1-32000
plans = 4		;nb plans � effacer
nbseg = 4		;3
nblig = 100
CLIPPING = 1		;0=clipping
;
; 07/06/90 fait en 30 minutes !!!
; 09/06/90 affichage d'un polygone rempli en 1 plan
;
;  attention, on doit OBLIGATOIREMENT calculer tous les points de chaque
;   segment parce que �a merderait quand �a clippe
;  en plus �a permet d'�viter d'avoir � effacer le tableau des Y !!!
;
; manquent :
;	- un clipping en Y
;	- on peut enlever les divisions en calculant les points de la mani�re
;	  suivante :
;			add.l	PENTE,x
;			swap	x
;			move	(a6)+,(a6)+
;			move	x,-4(a6)
;			swap	x
;	avec PENTE lu dans une table
;
;
; OPTIMISATIONS A EFFECTUER
;	- EFFACER LE MINIMUM D'ECRAN POUR CHAQUE OBJET
;		(GENERER ROUTINE D'EFFACEMENT MINIMALE)
;	- REPeTer les routines de calculs et d'affichage...
;
; POINT DE ROTATION : (0,0,100)
;
PLOT	MACRO
	move	(a6)+,(a6)+
	move	d0,-4(a6)
	ENDM
PLOT2	MACRO
	cmp	a5,d7
	bne.s	.\@
	move	(a6)+,(a6)+
	move	d0,-4(a6)
.\@
	ENDM
;
; remarques :
;	- au lieu de :
;			move	(a6)+,(a6)+
;			move	d0,-4(a6)
;	  on peut mettre :
;			move	2(a6),(a6)+
;			move	d0,(a6)+
;
; entr�e :
;	SEGMENTS contient les coordonn�es des points projet�s
; sortie :
;	d6 = Y minimum du polygone
;	d7 = Y maximum
;	CALCULES contient les coordonn�es X pour chaque Y
;

	move	sr,d0
	and	#$2000,d0
	bne.s	super
	clr.l	-(sp)
	move	#$20,-(sp)
	trap	#1
	addq	#6,sp
super:
	move	#$2700,sr
	moveq	#0,d0
	move.l	d0,a0
	movep.l	d0,$fffffa01(a0)
	movep.l	d0,$fffffa09(a0)
	movep.l	d0,$fffffa11(a0)
	movep.l	d0,$fffffa19(a0)

	ifeq	DEBUG
	jsr	debugger
	endc

	lea	ecran0,sp		;super stack

	move.l	#ecran0,d0
	move.l	d0,ecran
	lsr	#8,d0
	move.l	d0,$ffff8200.w

	lea	ecran0,a0
	move	#($80000-ecran0)/4-1,d0
	moveq	#0,d1
.cls
	move.l	d1,(a0)+
	dbra	d0,.cls

	BSR	PRECALCULE_Z

	move.l	#vbl,$70.w
	move	#$2300,sr
	clr	sync
.vbl1	tst	sync
	beq.s	.vbl1
	move.b	#0,$ffff8260.w
	move.b	#2,$ffff820a.w
	movem.l	palette(pc),d0-d7
	movem.l	d0-d7,$ffff8240.w

	ifeq	plans-1
;
; routine de Fastcls en code g�n�r�
;
	lea	fastcls,a0
	move	#$3080,(a0)+	;move d0,(a0)
	move.l	#$31400008,d0
setup:
	move.l	d0,(a0)+
	addq	#8,d0
	cmp	#32000,d0
	blo.s	setup
	move	#$4ed1,(a0)+	;jmp (a1)
	endc

	ifeq	plans-4
	move.l	#retr,$80.w
	endc
demo
	clr	sync
.vbl	tst	sync
	beq.s	.vbl

	ifeq	plans-4

	move	#$300,sr
	move.l	ecran,a7
	lea	32000(a7),a7

	moveq	#0,d0
	move.l	d0,d1
	move.l	d0,d2
	move.l	d0,d3
	move.l	d0,d4
	move.l	d0,d5
	move.l	d0,d6
	move.l	d0,d7
	move.l	d0,a0
	move.l	d0,a1
	move.l	d0,a2
	move.l	d0,a3
	move.l	d0,a4
	move.l	d0,a5
	move.l	d0,a6

x	set	0
	rept	32000/15/4
	movem.l	d0-d7/a0-a6,-(a7)
x	set	x+15*4
	endr
	movem.l	d0-d4,-(a7)
x	set	x+5*4

	trap	#0
	elseif
	moveq	#0,d0
	move.l	ecran,a0
;	move	d0,(a0)
	lea	.ret(pc),a1
	jmp	fastcls
.ret
	endc

	BSR	CALCOBJ
	bsr	polycalc

	move.l	ecran,d0
	lsr	#8,d0
	move.l	d0,$ffff8200.w
	eor.l	#ecran0^ecran1,ecran
	bra	demo
vit1	dc.w	1
vit2	dc.w	1
ecran:	dc.l	0
sync:	dc.w	0
vbl:	addq	#1,sync
	rte
retr:	rtr
palette:DC.W	$000,$070,$070,$070
	DC.W	$007,$007,$007,$007
	DC.W	$700,$700,$700,$700
	DC.W	$700,$700,$700,$700

DRAW	MACRO
	movem	segments+(\1-1)*4(pc),d0/d1
	movem	segments+(\2-1)*4(pc),d2/d3
	bsr	drawline
	ENDM
INITDRAW:MACRO
	move	#$777,$ffff8240.w
	move	#199,d6		;Y minimum
	moveq	#0,d7		;Y maximum
	ENDM
;
; d6=Ymin
; d7=Ymax
;
AFFPOLY:MACRO
	move	#$070,$ffff8240.w
	lea	calcules(PC),a6
	move	d6,d0
	move.l	ecran,a5
	asl	#5,d0
	add	d0,a5
	add	d0,d0
	add	d0,d0
	add	d0,a5
	IFNE	\1
	ADDQ	#2*\1,A5
	ENDC

	sub	d6,d7		;d7=nb lignes-1
	add	d6,d6
	add	d6,d6
	add	d6,a6		;ptr d�but
	bsr	draw_all
	clr	$ffff8240.w
	ENDM

polycalc
	INITDRAW
	DRAW	1,2
	DRAW	2,3
	DRAW	3,4
	DRAW	1,4
	AFFPOLY	0

	INITDRAW
	DRAW	5,6
	DRAW	6,7
	DRAW	7,8
	DRAW	5,8
	AFFPOLY	2

	INITDRAW
	DRAW	1,4
	DRAW	4,8
	DRAW	8,5
	DRAW	1,5
	AFFPOLY	3

	RTS
;
; entr�e :
;	d0=X0
;	d1=Y0
;	d2=X1
;	d3=Y1
;
; registres utilis�s :
;	d4,d5
;	d6=ymin
;	d7=ymax
;	a6,a0
;	a5=y bas
;
noline:	rts
drawline:
	cmp	d1,d3		;du haut vers le bas
	beq.s	noline		;pas 2 Y pareils !!!!
	bhs.s	1$
	exg	d0,d2
	exg	d1,d3
1$
	move	d3,a5

	cmp	d6,d1
	bhs.s	.notmin
	move	d1,d6		;nouveau Y minimum
.notmin
	cmp	d7,d3
	bls.s	.notmax
	move	d3,d7		;nouveau Y maximum
.notmax
	sub	d1,d3

	ifeq	1
;
; on peut aussi utiliser le code suivant (gain de 4 cycles � la fin)
;
;
; on se base sur le fait que chaque Y passe une fois par ici...
;
	cmp	d6,d1
	bhs.s	.notmin
	move	d1,d6		;nouveau Y minimum
.notmin
	cmp	d7,d1
	bls.s	.notmax
	move	d1,d7		;nouveau Y maximum
.notmax
	sub	d1,d3		;du haut vers le bas
	bhs.s	1$
	exg	d0,d2
	neg	d3
	add	d3,d1
1$
	endc
;
; ici d1=Y haut
;     d3=nb pixels verticalement=pente en Y
;
; calcul des pointeurs pour �criture donn�es
;
	add	d1,d1
	add	d1,d1		;Y*4
	lea	calcules(pc),a6
	add	d1,a6

	move	d3,d4
	lsr	#1,d4		;d4=cumul
	move	d3,d1
	subq	#1,d1		;d1=nb lignes-1

	sub	d0,d2
;
; d0=X d�part
; d2=delta X
; d3=delta Y
;
	bpl	pente_droite
pente_gauche
	neg	d2
	cmp	d2,d3
	bhs	dysupdx

DX3	MACRO
	PLOT
	sub	d2,d4
	bhs.s	\@
	add	d3,d4
	subq	#1,d0
\@
	sub	d5,d0
	ENDM
;dx>dy
	ext.l	d2		;bit 15=0->cleare poids fort
	divu	d3,d2		;d2.h=reste
	move	d2,d5
	swap	d2		;nouveau deltax

	lea	bdx3(pc),a0
	addq	#1,d1
	mulu	#(bdx3-bdx4)/(nblig-1),d1
	sub	d1,a0
	jmp	(a0)
bdx4
	rept	nblig-1
	DX3
	ENDR
bdx3
	PLOT2
	rts

DY3	MACRO
	PLOT
	sub	d2,d4
	bhs.s	\@
	add	d3,d4
	subq	#1,d0
\@
	ENDM

dysupdx
	lea	bdy3(pc),a0
	addq	#1,d1
	mulu	#(bdy3-bdy4)/(nblig-1),d1
	sub	d1,a0
	jmp	(a0)
bdy4
	rept	nblig-1
	DY3
	ENDR
bdy3
	PLOT2
	rts

DX1	MACRO
	PLOT
	sub	d2,d4
	bhs.s	\@
	add	d3,d4
	addq	#1,d0
\@
	add	d5,d0
	ENDM

pente_droite
	cmp	d2,d3
	bhs	dysupdx2
;dx>dy
	ext.l	d2		;clear poids fort
	divu	d3,d2
	move	d2,d5
	swap	d2

	lea	bdx1(pc),a0
	addq	#1,d1
	mulu	#(bdx1-bdx2)/(nblig-1),d1
	sub	d1,a0
	jmp	(a0)
bdx2
	rept	nblig-1
	DX1
	ENDR
bdx1
	PLOT2
	rts
dysupdx2

DY1	MACRO
	PLOT
	sub	d2,d4
	bhs.s	\@
	add	d3,d4
	addq	#1,d0
\@
	ENDM

	lea	bdy1(pc),a0
	addq	#1,d1
	mulu	#(bdy1-bdy2)/(nblig-1),d1
	sub	d1,a0
	jmp	(a0)
bdy2
	rept	nblig-1
	DY1
	ENDR
bdy1
	PLOT2
	rts
;
; affichage des lignes horizontales
;
; entr�e :
;	d7=nb lignes-1 � afficher
;	a5=ptr �cran 1�re ligne
;	a6=ptr coords 1�re ligne
;
	IFEQ	CLIPPING
clipgau
	cmp	d4,d1
	bls.s	1$
	move	d1,d2
	eor	d0,d2
	bpl.s	noaff
	cmp	d4,d1
	sge	d1
	ext	d1
	and	d4,d1
1$	cmp	d4,d0
	sge	d0
	ext	d0
	and	d4,d0
	bra.s	noclip
clipdro
	sge	d1
	ext	d1
	and	d4,d1
	bra.s	noclip

noaff:	lea	160(a5),a5
	dbra	d7,draw_all2
	rts
	ENDC
draw_all:
	lea	masques(pc),a1
	moveq	#-1,d5
	IFEQ	CLIPPING
	move	#319,d4
	ENDC
draw_all2
	movem	(a6)+,d0/d1
	IFEQ	CLIPPING
	cmp	d4,d0
	bhi.s	clipgau
	cmp	d4,d1
	bhi.s	clipdro
noclip
	ENDC
	cmp	d0,d1
	bhs.s	1$		;d0=Xgauche
	exg	d0,d1		;d1=Xdroite
1$
	moveq	#$f,d2
	and	d1,d2
	eor	d2,d1
	lsr	#1,d1
	move.l	a5,a0
	add	d1,a0
	ADD	D2,D2
	move	masque1-masques(a1,d2.w),d6	;masque droit
	add	d1,d1
	sub	d0,d1
	ble.s	.less16

	or	d6,(a0)
	moveq	#$f,d2
	and	d1,d2
	eor	d2,d1
	asr	#1,d1
	sub	d1,a0
	asr	#1,d1
	neg	d1
	jmp	.last(pc,d1.w)
	opt	o-
x	set	19
	rept	19
	move	d5,x*8-8(a0)
x	set	x-1
	endr
	opt	o+
.last
	add	d2,d2
	move	masque2-2-masques(a1,d2.w),d6
	or	d6,-8(a0)
	lea	160(a5),a5
	dbra	d7,draw_all2
	rts
.less16
	ADD	D1,D1
	and	masque2-masques+32-2(a1,d1.w),d6
	or	d6,(a0)
	lea	160(a5),a5
	dbra	d7,draw_all2
	rts
masques
	dc.w	0
masque2
	DC.W	$0001,$0003,$0007,$000F
	DC.W	$001F,$003F,$007F,$00FF
	DC.W	$01FF,$03FF,$07FF,$0FFF
	DC.W	$1FFF,$3FFF,$7FFF,$FFFF
masque1
	DC.W	$8000,$C000,$E000,$F000
	DC.W	$F800,$FC00,$FE00,$FF00
	DC.W	$FF80,$FFC0,$FFE0,$FFF0
	DC.W	$FFF8,$FFFC,$FFFE,$FFFF

	ifeq	DEBUG
debugger:incbin	debugger.bin
	endc

	section	data
PROJETES:
segments:
	ds.b	4*nbseg		;entr�e

coord1:	dc.w	200,0		;triangle d�mo
	dc.w	0
coord2:	dc.w	100

	ifeq	nbseg-3
	dc.w	319,199
	endc
	ifeq	nbseg-4
	dc.w	160,199
	dc.w	319,100
	endc

	section	bss
calcules:
	ds.l	200		;sortie

	section	bss
	ifeq	plans-1
fastcls:ds.b	16000
	endc
;
; PORTION DE CODE EFFECTUANT LES PROJECTIONS DES POINTS
;
ROTATEX = 2		;vitesse de rotation
ROTATEY = 1
ROTATEZ = 3
;
;
	SECTION	BSS
CUROBJ:	DS.L	1
NEW:	DS.W	9
	SECTION	TEXT

;
; ANGLES DE ROTATION, ETC...
;
ROTX	DC.B	$20
ROTY	DC.B	$20
ROTZ	DC.B	$20
	EVEN
CALCOBJ:
	LEA	PROJETES,A1
;
; CALCUL OPTIMISE DES POINTS PROJETES
;
NXTANG	MACRO
	ADD.B	\1(PC),D0
	MOVE.B	D0,\1
	ADD	D0,D0
	ADD	D0,D0
	MOVEM	(A0,D0.W),\2
	ENDM
;
; CALCUL DE LA MATRICE CONSTANTE DE PROJECTION
;
; CHANGE L'ANGLE DE ROTATION ET CALCULE LES SINUS ET COSINUS ASSOCIES
;
; SX=SIN/COS ANGLE X,SY=SIN/COS ANGLE Y,SZ=SIN/COS ANGLE Z
; L14=ANGLE ROT X,L16=ANGLE ROT Y,L3C=ANGLE ROT Z
; ROTX,ROTY,ROTZ=ANGLES COURANTS
;
SX	EQUR	D2
CX	EQUR	D3
SY	EQUR	D4
CY	EQUR	D5
SZ	EQUR	D6
CZ	EQUR	D7

;
; CHANGEMENT D'ANGLE DE ROTATION
;   (CONSTANTES POUR L'INSTANT)
;
	LEA	SINCOS(PC),A0
	MOVEQ	#ROTATEX,D0		;ROT X
	NXTANG	ROTX,SX/CX	;SX
	MOVEQ	#ROTATEY,D0		;ROT Y
	NXTANG	ROTY,SY/CY	;SY
	MOVEQ	#ROTATEZ,D0		;ROT Z
	NXTANG	ROTZ,SZ/CZ	;SZ
;
; CALCULE LA MATRICE DE PROJECTION
;
	LEA	NEW(PC),A0

	MOVE	CY,D0
	MULS	CZ,D0
	ADD.L	D0,D0
	SWAP	D0
	MOVE	D0,(A0)+

	MOVE	SY,(A0)+

	MOVE	CY,D0
	MULS	SZ,D0
	ADD.L	D0,D0
	SWAP	D0
	NEG	D0
	MOVE	D0,(A0)+

	MOVE	SX,D1
	MULS	SZ,D1
	MOVE	CX,D0
	MULS	SY,D0
	ADD.L	D0,D0
	SWAP	D0
	MULS	CZ,D0
	SUB.L	D0,D1
	ADD.L	D1,D1
	SWAP	D1
	MOVE	D1,(A0)+

	MOVE	CX,D0
	MULS	CY,D0
	ADD.L	D0,D0
	SWAP	D0
	MOVE	D0,(A0)+	;$10

	MOVE	SX,D1
	MULS	CZ,D1
	MOVE	CX,D0
	MULS	SY,D0
	ADD.L	D0,D0
	SWAP	D0
	MULS	SZ,D0
	ADD.L	D1,D0
	ADD.L	D0,D0
	SWAP	D0
	MOVE	D0,(A0)+	;$14

	MOVE	CX,D1
	MULS	SZ,D1
	MOVE	SX,D0
	MULS	SY,D0
	ADD.L	D0,D0
	SWAP	D0
	MULS	CZ,D0
	ADD.L	D1,D0
	ADD.L	D0,D0
	SWAP	D0
	MOVE	D0,(A0)+	;$18

	MOVE	SX,D0
	MULS	CY,D0
	ADD.L	D0,D0
	SWAP	D0
	NEG	D0
	MOVE	D0,(A0)+	;$1C

	MOVE	CX,D1
	MULS	CZ,D1
	MOVE	SX,D0
	MULS	SY,D0
	ADD.L	D0,D0
	SWAP	D0
	MULS	SZ,D0
	SUB.L	D0,D1
	ADD.L	D1,D1
	SWAP	D1
	MOVE	D1,(A0)+	;$20

	LEA	BIGOBJET,A2
	MOVE	(A2)+,-(SP)
	LEA	BUFFER_Z,A5
	LEA	NEW(PC),A6
;
; REGISTRES UTILISES :
;	A0-A6 SAUF A1
;	A2 PEUT ETRE LIBERE
;
; 	D1-D7 SAUF D4
;
; registres libres :
;
;	A1,D0,D4
;
FAST	MACRO
	MOVE	\1,\2
	MULS	(A4)+,\2
	ENDM

ADDFAST	MACRO
	MOVE	\1,\3
	MULS	(A4)+,\3
	ADD.L	\3,\2
	ENDM

BCPTS:
	MOVE.L	A6,A4
	MOVEM	(A2)+,D1/D2/D3

	FAST	D1,D6		;X
	ADDFAST	D2,D6,D0
	ADDFAST	D3,D6,D0

	FAST	D1,D7		;Y
	ADDFAST	D2,D7,D0
	ADDFAST	D3,D7,D0

	FAST	D1,D5		;Z
	ADDFAST	D2,D5,D0
	ADDFAST	D3,D5,D0

	ADD.L	D5,D5
	SWAP	D5

	ADD.L	D7,D7
	ADD.L	D6,D6
	SWAP	D6
	SWAP	D7

	IFEQ	1
	CMP	MIN,D5
	BGE.S	.NOTMIN
	MOVE	D5,MIN
.NOTMIN
	CMP	MAX,D5
	BLE.S	.NOTMAX
	MOVE	D5,MAX
.NOTMAX
	ENDC
;	SUB	#$190-100,D5
;	MULS	#$190,D6
;	MULS	#$190,D7
;	DIVS	D5,D6
;	DIVS	D5,D7

	ADD	D5,D5
	MOVE	(A5,D5.W),D5
	MULS	D5,D7
	MULS	D5,D6
	ADD.L	D7,D7
	ADD.L	D7,D7
	ADD.L	D6,D6
	ADD.L	D6,D6
	SWAP	D7
	SWAP	D6

	ADD	#360/2,D6
	ADD	#200/2,D7
	CMP	#320,D6
	BLO.S	.1
	SGE	D6
	EXT	D6
	AND	#320-1,D6
.1
	CMP	#200,D7
	BLO.S	.2
	SGE	D7
	EXT	D7
	AND	#200-1,D7
.2
	MOVE	D6,(A1)+
	MOVE	D7,(A1)+

	SUBQ	#1,(SP)
	BNE	BCPTS
	ADDQ	#2,SP
	RTS

;MIN:	DC.W	$7FFF
;MAX:	DC.W	$8000

SINCOS		;TABLE DE SINUS/COSINUS
	dc.w	$0,$7FFF,$324,$7FF5,$647,$7FD7,$96A,$7FA6
	dc.w	$C8B,$7F61,$FAB,$7F08,$12C7,$7E9C,$15E1,$7E1C
	dc.w	$18F8,$7D89,$1C0B,$7CE2,$1F19,$7C29,$2223,$7B5C
	dc.w	$2527,$7A7C,$2826,$7989,$2B1E,$7883,$2E10,$776B
	dc.w	$30FB,$7640,$33DE,$7503,$36B9,$73B5,$398C,$7254
	dc.w	$3C56,$70E1,$3F16,$6F5E,$41CD,$6DC9,$447A,$6C23
	dc.w	$471C,$6A6C,$49B3,$68A5,$4C3F,$66CE,$4EBF,$64E7
	dc.w	$5133,$62F1,$539A,$60EB,$55F4,$5ED6,$5842,$5CB3
	dc.w	$5A81,$5A81,$5CB3,$5842,$5ED6,$55F4,$60EB,$539A
	dc.w	$62F1,$5133,$64E7,$4EBF,$66CE,$4C3F,$68A5,$49B3
	dc.w	$6A6C,$471C,$6C23,$447A,$6DC9,$41CD,$6F5E,$3F16
	dc.w	$70E1,$3C56,$7254,$398C,$73B5,$36B9,$7503,$33DE
	dc.w	$7640,$30FB,$776B,$2E10,$7883,$2B1E,$7989,$2826
	dc.w	$7A7C,$2527,$7B5C,$2223,$7C29,$1F19,$7CE2,$1C0B
	dc.w	$7D89,$18F8,$7E1C,$15E1,$7E9C,$12C7,$7F08,$FAB
	dc.w	$7F61,$C8B,$7FA6,$96A,$7FD7,$647,$7FF5,$324
	dc.w	$7FFF,$0,$7FF5,$FCDB,$7FD7,$F9B8,$7FA6,$F695
	dc.w	$7F61,$F374,$7F08,$F054,$7E9C,$ED38,$7E1C,$EA1E
	dc.w	$7D89,$E707,$7CE2,$E3F4,$7C29,$E0E6,$7B5C,$DDDC
	dc.w	$7A7C,$DAD8,$7989,$D7D9,$7883,$D4E1,$776B,$D1EF
	dc.w	$7640,$CF04,$7503,$CC21,$73B5,$C946,$7254,$C673
	dc.w	$70E1,$C3A9,$6F5E,$C0E9,$6DC9,$BE32,$6C23,$BB85
	dc.w	$6A6C,$B8E3,$68A5,$B64C,$66CE,$B3C0,$64E7,$B140
	dc.w	$62F1,$AECC,$60EB,$AC65,$5ED6,$AA0B,$5CB3,$A7BD
	dc.w	$5A81,$A57E,$5842,$A34C,$55F4,$A129,$539A,$9F14
	dc.w	$5133,$9D0E,$4EBF,$9B18,$4C3F,$9931,$49B3,$975A
	dc.w	$471C,$9593,$447A,$93DC,$41CD,$9236,$3F16,$90A1
	dc.w	$3C56,$8F1E,$398C,$8DAB,$36B9,$8C4A,$33DE,$8AFC
	dc.w	$30FB,$89BF,$2E10,$8894,$2B1E,$877C,$2826,$8676
	dc.w	$2527,$8583,$2223,$84A3,$1F19,$83D6,$1C0B,$831D
	dc.w	$18F8,$8276,$15E1,$81E3,$12C7,$8163,$FAB,$80F7
	dc.w	$C8B,$809E,$96A,$8059,$647,$8028,$324,$800A
	dc.w	$0,$8001,$FCDB,$800A,$F9B8,$8028,$F695,$8059
	dc.w	$F374,$809E,$F054,$80F7,$ED38,$8163,$EA1E,$81E3
	dc.w	$E707,$8276,$E3F4,$831D,$E0E6,$83D6,$DDDC,$84A3
	dc.w	$DAD8,$8583,$D7D9,$8676,$D4E1,$877C,$D1EF,$8894
	dc.w	$CF04,$89BF,$CC21,$8AFC,$C946,$8C4A,$C673,$8DAB
	dc.w	$C3A9,$8F1E,$C0E9,$90A1,$BE32,$9236,$BB85,$93DC
	dc.w	$B8E3,$9593,$B64C,$975A,$B3C0,$9931,$B140,$9B18
	dc.w	$AECC,$9D0E,$AC65,$9F14,$AA0B,$A129,$A7BD,$A34C
	dc.w	$A57E,$A57E,$A34C,$A7BD,$A129,$AA0B,$9F14,$AC65
	dc.w	$9D0E,$AECC,$9B18,$B140,$9931,$B3C0,$975A,$B64C
	dc.w	$9593,$B8E3,$93DC,$BB85,$9236,$BE32,$90A1,$C0E9
	dc.w	$8F1E,$C3A9,$8DAB,$C673,$8C4A,$C946,$8AFC,$CC21
	dc.w	$89BF,$CF04,$8894,$D1EF,$877C,$D4E1,$8676,$D7D9
	dc.w	$8583,$DAD8,$84A3,$DDDC,$83D6,$E0E6,$831D,$E3F4
	dc.w	$8276,$E707,$81E3,$EA1E,$8163,$ED38,$80F7,$F054
	dc.w	$809E,$F374,$8059,$F695,$8028,$F9B8,$800A,$FCDB
	dc.w	$8001,$FFFF,$800A,$324,$8028,$647,$8059,$96A
	dc.w	$809E,$C8B,$80F7,$FAB,$8163,$12C7,$81E3,$15E1
	dc.w	$8276,$18F8,$831D,$1C0B,$83D6,$1F19,$84A3,$2223
	dc.w	$8583,$2527,$8676,$2826,$877C,$2B1E,$8894,$2E10
	dc.w	$89BF,$30FB,$8AFC,$33DE,$8C4A,$36B9,$8DAB,$398C
	dc.w	$8F1E,$3C56,$90A1,$3F16,$9236,$41CD,$93DC,$447A
	dc.w	$9593,$471C,$975A,$49B3,$9931,$4C3F,$9B18,$4EBF
	dc.w	$9D0E,$5133,$9F14,$539A,$A129,$55F4,$A34C,$5842
	dc.w	$A57E,$5A81,$A7BD,$5CB3,$AA0B,$5ED6,$AC65,$60EB
	dc.w	$AECC,$62F1,$B140,$64E7,$B3C0,$66CE,$B64C,$68A5
	dc.w	$B8E3,$6A6C,$BB85,$6C23,$BE32,$6DC9,$C0E9,$6F5E
	dc.w	$C3A9,$70E1,$C673,$7254,$C946,$73B5,$CC21,$7503
	dc.w	$CF04,$7640,$D1EF,$776B,$D4E1,$7883,$D7D9,$7989
	dc.w	$DAD8,$7A7C,$DDDC,$7B5C,$E0E6,$7C29,$E3F4,$7CE2
	dc.w	$E707,$7D89,$EA1E,$7E1C,$ED38,$7E9C,$F054,$7F08
	dc.w	$F374,$7F61,$F695,$7FA6,$F9B8,$7FD7,$FCDB,$7FF5

BIGOBJET:
	DC.W	8

	DC.W	-50,50,-50	;1
	DC.W	-50,-50,-50	;2
	DC.W	50,-50,-50	;3
	DC.W	50,50,-50	;4

	DC.W	-50,50,50	;5
	DC.W	-50,-50,50	;6
	DC.W	50,-50,50	;7
	DC.W	50,50,50	;8
;
; PRECALCUL DE TOUS LES Z POSSIBLES
;
PRECALCULE_Z
	LEA	BUFFER_Z-200,A0

	move	#-100,d5
1$
	MOVE	D5,D0
	ADD	#-$12C,D0
	MOVE.L	#32767/2*($190/2),D1
	DIVS	D0,D1
	BVS.S	ERREUR
	MOVE	D1,(A0)+

	ADDQ	#1,D5
	CMP	#100,D5
	BNE.S	1$
	RTS
ERREUR:
	ILLEGAL

	SECTION	BSS
	DS.W	100
BUFFER_Z:DS.W	100	;BUFFER CONTIENT LES DIFFERENTES PROFONDEURS
MUL160	DS.W	200
