* This is a good DSP module player! It can also work from the vbl
; interrupt, but we only found out about that after we finished
; this demo!

;DSP MOD replay routine written by bITmASTER of BSW
;This is source code for Devpack 3
;Additional code by Dusan

;TEST				;< uncomment to test this code by itself

                opt D+


iera            equ $fffffa07           ;Interrupt-Enable-Register A
ierb            equ $fffffa09           ;                                                               B
imra            equ $fffffa13
isra            equ $fffffa0f
isrb            equ $fffffa11
tacr            equ $fffffa19
tbcr            equ $fffffa1b
tadr            equ $fffffa1f
tbdr            equ $fffffa21
tccr            equ $fffffa1d
tcdr            equ $fffffa23
aer             equ $fffffa03
STColor         equ $ffff8240
FColor          equ $ffff9800
vbl             equ $70
timer_int       equ $0120
timer_c_int     equ $0114

ym_select       equ $ffff8800
ym_write        equ $ffff8802
ym_read         equ $ffff8800

vbaselow        equ $ffff820d
vbasemid        equ $ffff8203
vbasehigh       equ $ffff8201
vcountlow       equ $ffff8209
vcountmid       equ $ffff8207
vcounthigh      equ $ffff8205
linewid         equ $ffff820f
hscroll         equ $ffff8265

keyctl          equ $fffffc00
keybd           equ $fffffc02

DspHost         equ $ffffa200
HostIntVec      equ $03fc

PCookies        equ $05a0

	IFD	TEST
	lea	module,a6
	pea	muson
	move	#38,-(sp)
	trap	#14
	addq.l	#6,sp
	move	#1,-(sp)
	trap	#1
	addq.l	#2,sp
	pea	musoff
	move	#38,-(sp)
	trap	#14
	addq.l	#6,sp
	clr	-(sp)
	trap	#1
	ENDC

muson	lea     mod_player,a0
        bsr     .reloziere
        moveq   #1,d0
        move.l	a6,a0
        bsr     mod_player+28       ;ein
	bsr	.setints
	rts

.reloziere	move.l  2(a0),d0        ;Relozieren
                add.l   6(a0),d0
                add.l   14(a0),d0
                adda.l  #$1c,a0
                move.l  a0,d1
                movea.l a0,a1
                movea.l a1,a2
                adda.l  d0,a1
                move.l  (a1)+,d0
                adda.l  d0,a2
                add.l   d1,(a2)
                clr.l   d0
.L000A		move.b  (a1)+,d0
                beq     .L000C
                cmp.b   #1,d0
                beq     .L000B
                adda.l  d0,a2
                add.l   d1,(a2)
                bra     .L000A
.L000B		adda.l  #$fe,a2
                bra     .L000A
.L000C		rts

.setints	lea     SaveArea,a0
                move.l  timer_int.w,(a0)+
                move.b  tbcr.w,(a0)+
                move.b  tbdr.w,(a0)+
                move.b  #246,tbdr.w
                move.b  #7,tbcr.w
                move.l  #.timer_b,timer_int.w
                bset    #0,imra.w
                bset    #0,iera.w
		bclr	#3,$fffffa17.w
                rts

.timer_b:
		IFD	TEST
		neg	$ffff8240.w
		ENDC
	        movem.l d0-a6,-(sp)
                bsr     mod_player+28+8
                movem.l (sp)+,d0-a6
;                bclr    #0,$fffffa0f.w
		IFD	TEST
		neg	$ffff8240.w
		ENDC
                rte

musoff	bsr	.retints
        bsr     mod_player+28+4     ;aus
	rts

.retints	bclr    #0,iera.w
                bclr    #0,imra.w
		bset	#3,$fffffa17.w
                lea     SaveArea,a0
                move.l  (a0)+,timer_int.w
                move.b  (a0)+,tbcr.w
                move.b  (a0)+,tbdr.w
                rts

SaveArea:       ds.b 6

mod_player	incbin	h:\demos\jag_demo\sound\dsp_mod.bsw

	IFD	TEST
module	incbin	adrenal2a.mod
	ENDC