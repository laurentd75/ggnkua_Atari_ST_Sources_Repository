; GRAZEY of The P.H.F. From Kingston Upon Hull 

; Brings you The Ultimate Music Hack for your Atari ST.

; ALL the music from the Best In the Galaxy Demo By The Exceptions!


; Music Composition........................Rob Hubbard ( From Hull,hehe )

; Music Conversion.........................Jochen Hippel ( Of TEX )

; Music Hacking............................Grazey ( Of The PHF )

; Hacking ( 1 1/4 hours ) Finished 14th May 1992.

; Released post UMD Volume 2.

; If you use any of these musics, then credit me for the ripping and
; Rob Hubbard/Joch Hippel for the composing OR ELSE!

* To play a tune simply note the corresponding offset and change line 104
* of this code. To change the tune number alter line 118.


;tabs 8


; Title                 Offset		Tunes
; -----                 ------          -----

; Ace 2			10590
; Aufweidersehen Monty	bde0		0-12
; Balloon Challenge	1e2d0		0-1
; Battle Of Britain	96d0
; Bump Set and Spike	12a70		0-1
; Chain Reaction	19460
; Chimera		7f20		0-1
; Clumsy Colin Action B	4300		0-2
; Commando		5800		0-2
; Confuzion		16450
; Crazy Comets		8a50		0-1
; Delta			10ff0		0-9
; Delta Preview		11fb0
; Education		154f0
; Flash Gordon		e1c0
; Formula 1		4f30
; Geoff Capes Strongman	1ecf0		0-5
; Gerry The Germ	0		0-6
; Gremlin Music Demo	ed60		0-6
; Human Race		a450		0-4
; Hunter Patrol		6380
; I-Ball		18890
; IK			15f0
; IK+			1bc00
; Lightforce		21e80
; Locomotion		14e30
; Make Love Not W.A.R.	20b50
; Master Of Magic	1b190		0-2
; Monty On The Run	6f30		0-2
; Nemesis The Warlock	1cc70	
; One Man and His Droid	b310
; Phantom Of T Asteroid	17ad0		0-1
; Saboteur 2 		201b0
; Sam Fox Strip Poker	2440		0-5
; Sanxion Loader	137e0
; Sanxion Title		14370
; Small Title		15d60
; Spellbound		1f570
; Starpaws		d8b0		0-3
; Thanatos		22800
; The Last V8		cf30
; Thing On A Spring	1a6a0
; Thrust		3850
; Warhawk		2fb0
; Wiz			1d6f0		0-2
; Zoids			19d40


grazey	opt x+
	clr.l -(sp)				
	move.w #$20,-(sp)			
	trap #1					
	lea 6(sp),sp				
	move.l d0,oldstk			


	bclr #0,$484.w				
	movem.l	$ffff8240.w,d0-d7
	movem.l	d0-d7,oldcols
	clr.w	$ffff8240.w
	dc.w	$a00a


	jsr bars(pc)		;Remove this line for no bars

	pea	text
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp

	lea	zakdat(pc),a0
	jsr	unpack


	lea zakdat(pc),a0
	lea workspc(pc),a1
	move.l	#2499,d0


***************************************************************

	add.l	#$19460,a0		;Alter Offset Here!!!!

***************************************************************

.loop	move.l	(a0)+,(a1)+
	dbra	d0,.loop

	bsr	relo+$1c
	bsr	hubrelo
	

***************************************************************

	moveq.l	#0,d0		;Alter tune number here!!
	jsr	music+$19be
        
***************************************************************
        bsr.s on

	move.w #7,-(sp)				
	trap #1					
	lea 2(sp),sp				

	bsr.s off
	movem.l	oldcols,d0-d7
	movem.l	d0-d7,$ffff8240.w
	dc.w	$a009

	move.l oldstk,-(sp)			
	move.w #$20,-(sp)			
	trap #1					
	lea 6(sp),sp  				
	clr.w -(sp)				
	trap #1					

vbl	movem.l d0-a6,-(sp)			
	clr.w	$ffff8240.w
	jsr	bars+186		;Remove this line for no bars
	jsr	bars+298		;Remove this line for no bars
	jsr	music+$36(pc)
	movem.l (sp)+,d0-a6			
	move.l oldint,-(sp)			
	rts					

on	move.l $70.w,oldint			
	move.l #vbl,$70.w			
	rts

off	move.l oldint,$70.w			
	move.w	#1,-(sp)
	move.l	#-1,-(sp)
	move.l	#-1,-(sp)
	move.w	#5,-(sp)
	trap	#14
	lea	12(a7),a7
	move.l #$08080000,$ffff8800.w
	move.l #$09090000,$ffff8800.w
	move.l #$0a0a0000,$ffff8800.w
	rts

* UNPACK source for SPACKERv3	(C)THE FIREHAWKS'92
* -------------------------------------------------
* in	a0: even address start packed block
* out	d0: original length or 0 if not SPv3 packed
* =================================================
* Use AUTO_SP3.PRG for multiblk packed files

unpack:	moveq	#0,d0
	movem.l	d0-a6,-(sp)
	lea	sp3_53(pc),a6
	movea.l	a0,a1
	cmpi.l	#'SPv3',(a1)+
	bne.s	sp3_02
	tst.w	(a1)
	bne.s	sp3_02
	move.l	(a1)+,d5
	move.l	(a1)+,d0
	move.l	(a1)+,(sp)
	movea.l	a0,a2
	adda.l	d0,a0
	move.l	-(a0),-(a1)
	move.l	-(a0),-(a1)
	move.l	-(a0),-(a1)
	move.l	-(a0),-(a1)
	adda.l	(sp),a1
	lea	sp3_58-sp3_53(a6),a3
	moveq	#128-1,d0
sp3_01:	move.l	(a2)+,(a3)+
	dbf	d0,sp3_01
	suba.l	a2,a3
	move.l	a3,-(sp)
	bsr.s	sp3_03
	bsr	sp3_21
	move.b	-(a0),d0
	adda.l	(sp)+,a0
	move.b	d0,(a0)+
	lea	sp3_58-sp3_53(a6),a2
	bsr	sp3_22
	bsr	sp3_15
sp3_02:	movem.l	(sp)+,d0-a6
	rts
sp3_03:	move.w	SR,d1
	andi.w	#$2000,d1
	beq.s	sp3_04
	move.w	$FFFF8240.W,2(a6)
	btst	#1,$FFFF8260.W
	bne.s	sp3_04
	swap	d5
sp3_04:	clr.w	d5
	move.w	-(a0),d6
	lea	sp3_54-sp3_53(a6),a3
	move.b	d6,(a3)+
	moveq	#1,d3
	moveq	#6,d4
sp3_05:	cmp.b	d6,d3
	bne.s	sp3_06
	addq.w	#2,d3
sp3_06:	move.b	d3,(a3)+
	addq.w	#2,d3
	dbf	d4,sp3_05
	moveq	#$10,d4
	move.b	-(a0),(a3)+
	move.b	d4,(a3)+
	move.b	-(a0),(a3)+
	move.b	d4,(a3)+
	move.b	-(a0),d4
	move.w	d4,(a6)
	lea	sp3_57-sp3_53(a6),a5
	move.b	-(a0),d4
	lea	1(a5,d4.w),a3
sp3_07:	move.b	-(a0),-(a3)
	dbf	d4,sp3_07
	move.b	-(a0),-(a3)
	beq.s	sp3_08
	suba.w	d4,a0
sp3_08:	moveq	#0,d2
	move.b	-(a0),d2
	move.w	d2,d3
	move.b	-(a0),d7
sp3_09:	bsr.s	sp3_10
	bsr.s	sp3_10
	dbf	d2,sp3_09
	rts
sp3_10:	not.w	d4
	add.b	d7,d7
	bne.s	sp3_11
	move.b	-(a0),d7
	addx.b	d7,d7
sp3_11:	bcs.s	sp3_12
	move.w	d2,d0
	subq.w	#1,d3
	sub.w	d3,d0
	add.w	d0,d0
	add.w	d4,d0
	add.w	d0,d0
	neg.w	d0
	move.w	d0,-(a3)
	rts
sp3_12:	moveq	#2,d1
	bsr	sp3_44
	add.w	d0,d0
	beq.s	sp3_13
	move.b	d0,-(a3)
	moveq	#2,d1
	bsr	sp3_44
	add.w	d0,d0
	move.b	d0,-(a3)
	rts
sp3_13:	moveq	#2,d1
	bsr	sp3_44
	move.w	sp3_55-sp3_53(a6),d1
	add.w	d0,d0
	beq.s	sp3_14
	move.w	sp3_55+2-sp3_53(a6),d1
sp3_14:	or.w	d1,d0
	move.w	d0,-(a3)
	rts
sp3_15:	move.w	SR,d1
	andi.w	#$2000,d1
	beq.s	sp3_16
	move.w	2(a6),$FFFF8240.W
sp3_16:	tst.w	d6
	bpl.s	sp3_20
	movea.l	a1,a2
	movea.l	a1,a3
	adda.l	4(sp),a3
sp3_17:	moveq	#3,d6
sp3_18:	move.w	(a2)+,d0
	moveq	#3,d5
sp3_19:	add.w	d0,d0
	addx.w	d1,d1
	add.w	d0,d0
	addx.w	d2,d2
	add.w	d0,d0
	addx.w	d3,d3
	add.w	d0,d0
	addx.w	d4,d4
	dbf	d5,sp3_19
	dbf	d6,sp3_18
	cmpa.l	a2,a3
	blt.s	sp3_20
	movem.w	d1-d4,-8(a2)
	cmpa.l	a2,a3
	bne.s	sp3_17
sp3_20:	rts
sp3_21:	move.b	-(a0),-(a1)
sp3_22:	swap	d5
	beq.s	sp3_23
	move.w	d5,$FFFF8240.W
sp3_23:	lea	sp3_56+2-sp3_53(a6),a3
	cmpa.l	a0,a2
	blt.s	sp3_25
	rts
sp3_24:	adda.w	d3,a3
sp3_25:	add.b	d7,d7
	bcc.s	sp3_28
	beq.s	sp3_27
sp3_26:	move.w	(a3),d3
	bmi.s	sp3_24
	bra.s	sp3_29
sp3_27:	move.b	-(a0),d7
	addx.b	d7,d7
	bcs.s	sp3_26
sp3_28:	move.w	-(a3),d3
	bmi.s	sp3_24
sp3_29:	ext.w	d3
	jmp	sp3_30(pc,d3.w)
sp3_30:	bra.s	sp3_30
	bra.s	sp3_41
	bra.s	sp3_41
	bra.s	sp3_41
	bra.s	sp3_41
	bra.s	sp3_41
	bra.s	sp3_37
	bra.s	sp3_36
	bra.s	sp3_32
	bra.s	sp3_33
	bra.s	sp3_31
	bra.s	sp3_34
	bra.s	sp3_21
sp3_31:	move.b	(a5),-(a1)
	bra.s	sp3_22
sp3_32:	bsr.s	sp3_43
	move.b	1(a5,d0.w),-(a1)
	bra.s	sp3_22
sp3_33:	bsr.s	sp3_43
	add.w	(a6),d0
	move.b	1(a5,d0.w),-(a1)
	bra.s	sp3_22
sp3_34:	moveq	#3,d1
	bsr.s	sp3_44
	lsr.w	#1,d0
	bcc.s	sp3_35
	not.w	d0
sp3_35:	move.b	(a1),d1
	add.w	d0,d1
	move.b	d1,-(a1)
	bra.s	sp3_22
sp3_36:	lea	sp3_52-2-sp3_53(a6),a4
	bsr.s	sp3_48
	addi.w	#16,d0
	lea	1(a1,d0.w),a3
	move.b	-(a3),-(a1)
	move.b	-(a3),-(a1)
	bra	sp3_22
sp3_37:	moveq	#3,d1
	bsr.s	sp3_44
	tst.w	d0
	beq.s	sp3_38
	addq.w	#5,d0
	bra.s	sp3_40
sp3_38:	move.b	-(a0),d0
	beq.s	sp3_39
	addi.w	#20,d0
	bra.s	sp3_40
sp3_39:	moveq	#13,d1
	bsr.s	sp3_44
	addi.w	#276,d0
sp3_40:	move.w	d0,d3
	add.w	d3,d3
sp3_41:	lea	sp3_52-sp3_53(a6),a4
	bsr.s	sp3_48
	lsr.w	#1,d3
	lea	1(a1,d0.w),a3
	move.b	-(a3),-(a1)
sp3_42:	move.b	-(a3),-(a1)
	dbf	d3,sp3_42
	bra	sp3_22
sp3_43:	moveq	#0,d1
	move.b	(a3),d1
sp3_44:	moveq	#0,d0
	cmpi.w	#7,d1
	bpl.s	sp3_47
sp3_45:	add.b	d7,d7
	beq.s	sp3_46
	addx.w	d0,d0
	dbf	d1,sp3_45
	rts
sp3_46:	move.b	-(a0),d7
	addx.b	d7,d7
	addx.w	d0,d0
	dbf	d1,sp3_45
	rts
sp3_47:	move.b	-(a0),d0
	subq.w	#8,d1
	bpl.s	sp3_45
	rts
sp3_48:	moveq	#0,d1
	move.b	(a3),d1
	adda.w	d1,a4
	move.w	(a4),d1
	bsr.s	sp3_44
	tst.b	d6
	beq.s	sp3_51
	move.w	d0,d4
	andi.w	#$FFF0,d4
	andi.w	#$000F,d0
	beq.s	sp3_50
	lsr.w	#1,d0
	beq.s	sp3_49
	roxr.b	#1,d7
	bcc.s	sp3_50
	move.b	d7,(a0)+
	moveq	#-128,d7
	bra.s	sp3_50
sp3_49:	moveq	#2,d1
	bsr.s	sp3_44
	add.w	d0,d0
	or.w	d4,d0
	bra.s	sp3_51
sp3_50:	lea	sp3_54-sp3_53(a6),a3
	or.b	(a3,d0.w),d4
	move.w	d4,d0
sp3_51:	add.w	18(a4),d0
	rts

	DC.W	3
sp3_52:	DC.W	4,5,7,8,9,10,11,12
	DC.W	-16
	DC.W	0,32,96,352,864,1888,3936,8032

sp3_53:	DS.L	1
sp3_54:	DS.B	8
sp3_55:	DS.W	2*64
sp3_56:	DS.W	2
	DS.B	1
sp3_57:	DS.B	1
	DS.B	2*64
sp3_58:	DS.B	512




bars	incbin	"bars.bin"		;Bar Code, optimised unlike UNT 12!
	even

oldstk	dc.l 0
oldint	dc.l 0
oldcols	ds.l 16
screen	dc.l 0

hubrelo	include	"hubmods.phf"			;Hubbard Relo Code
relo	incbin	"gsrv3.phf"			;GSR V3 Code
	dc.l	$4e69a
music	incbin "bigdemo.drv"			;Music Driver
workspc	ds.b	10000
	dc.b	"PHF!"
zakdat	incbin "bigdemo.tex"			;Music Data
	even
text	dc.b	27,"Y",27,"E"
	dc.b	27,"Y",32+16,32,"THE PHF OF KINGSTON-UPON-HULL PRESENT:",13,10
	dc.b	"THE B.I.G. DEMO MUSIC HACK",13,10
	dc.b	">> PACKED BY TRONIC OF TRONIC P.D.L. <<",13,10,10
	DC.B	"CREDS : ALL MUSICS BY ROB HUBBARD",13,10
	DC.B	"        CONVERSIONS BY JOCH HIPPEL",13,10
	DC.B	"        HACKING BY GRAZEY",13,10
	DC.B	"        BAR CODING BY GRAZEY",0
