	section	text
	
	jmp	main
	
****************
* First init   *
****************
first_init
	clr.l	-(sp)
	move.w	#$20,-(sp)
	trap	#1
	addq.l	#6,sp
	move.l	d0,ustk

	move.w	#2,-(sp)
	trap	#14
	addq.l	#2,sp
	move.l	d0,oldphys
	
	move.w	#3,-(sp)
	trap	#14
	addq.l	#2,sp
	move.l	d0,oldlog
	
	move.w	#4,-(sp)
	trap	#14
	addq.l	#2,sp
	move.w	d0,oldrez
	
	movem.l	$ffff8240.w,d0-d7
	movem.l	d0-d7,savepal
	
	move.w	#0,-(sp)
	pea	-1
	pea	-1
	move.w	#5,-(sp)
	trap	#14
	lea	12(sp),sp
	
	rts

**************
* init y rot *
**************
init_y_rot
	lea	y_add,a0
	moveq	#0,d0
	move.w	#200-1,d1
.precy	move.w	d0,(a0)+
	add.w	#160,d0
	dbf	d1,.precy
	
	lea	x_add,a0
	moveq	#0,d0
	moveq	#0,d1
	move.w	#20-1,d6
.precx1	move.w	#16-1,d7
	moveq	#0,d1
.precx2	move.w	d0,(a0)+
	move.w	d1,(a0)+
	add.w	#2560,d1
	dbf	d7,.precx2
	add.w	#8,d0
	dbf	d6,.precx1

	lea	bredd_add1,a0
	lea	slutmasker3,a2
	moveq	#0,d4			; list add
	moveq	#0,d5
	move.w	#-1,d5			; first slutm

	move.w	#16-1,d7
.precb1	move.w	#320-1,d6
	moveq	#1,d0			; xc
	move.w	#160-(8*1)+8,d1		; yadd
	lea	slutmasker,a1
	add.l	d4,a1
	move.w	(a2)+,d5		; h�mta ettan
.precb2
	cmp.w	#1,d0
	bne	.hopp
	move.w	d5,d3
	and.w	(a1)+,d3
	move.w	d3,(a0)+
	move.w	#0,(a0)+	; helt on�dig nu n�r den inte ritas
	bra	.hopp2
.hopp:
	move.w	d5,(a0)+		; slutmask 1
	move.w	(a1)+,(a0)+	; slutmask 2
.hopp2:
	move.w	d0,(a0)+		; xcount
	move.w	d1,(a0)+		; yadd

	tst.w	(a1)
	bne.s	.go_on
	add.w	#1,d0		; ett mera p� xc
	sub.w	#8,d1		; ett mindre p� ya
	lea	slutmasker,a1
.go_on	dbf	d6,.precb2
	add.l	#2,d4
	dbf	d7,.precb1

	lea	bredd_add2,a0
	lea	slutmasker,a2
	moveq	#0,d4			; list add
	moveq	#0,d5
	move.w	#-1,d5			; first slutm

	move.w	#16-1,d7
.precb3	move.w	#320-1,d6
	moveq	#1,d0			; xc
	move.w	#160-(8*1)+8,d1		; yadd
	lea	slutmasker4+30,a1
	add.l	d4,a1
	move.w	(a2)+,d5		; h�mta ettan
.precb4
	cmp.w	#1,d0
	bne	.hopp3
	move.w	d5,d3
	and.w	(a1)+,d3
	move.w	d3,(a0)+
	move.w	#0,(a0)+	; slutmask 3 �r helt on�dig nu n�r den inte ritas
	bra	.hopp4
.hopp3:
	move.w	d5,(a0)+		; slutmask 1
	move.w	(a1)+,(a0)+	; slutmask 2
.hopp4:
	move.w	d0,(a0)+		; xcount
	move.w	d1,(a0)+		; yadd

	tst.w	(a1)
	bne.s	.go_on2
	add.w	#1,d0		; ett mera p� xc
	add.w	#8,d1		; ett mera p� ya
	lea	slutmasker4,a1
.go_on2	dbf	d6,.precb4
	sub.l	#2,d4
	dbf	d7,.precb3
	
	rts

**************
* init y bli *
**************
init_y_bli1
	move.w	#0,$ffff8a20.w
	move.w	#0,$ffff8a22.w
	move.l	#fyllt_word,$ffff8a24.w
	move.w	#-1,$ffff8a2a.w
	move.w	#8,$ffff8a2e.w
	
	move.w	#$0003,$ffff8a3a.w
	move.b	#0,$ffff8a3d.w

	rts

init_y_bli2
	move.w	#0,$ffff8a20.w
	move.w	#0,$ffff8a22.w
	move.l	#fyllt_word,$ffff8a24.w
	move.w	#-1,$ffff8a2a.w
	move.w	#-8,$ffff8a2e.w
	
	move.w	#$0003,$ffff8a3a.w
	move.b	#0,$ffff8a3d.w

	rts
	
*********************
* Main och mainloop *
*********************
main	jsr	first_init
	jsr	init_y_rot
	
	move.l	$70.w,svbi
	move.l	#vbi,$70.w
	
main_loop
	jsr	change_screen

	move.w	#1500,d0
.wait:	nop
	dbf.w	d0,.wait

	move.w	#$353,$ffff8240.w
	lea	koords,a0		; x1,y1,x2,y3
	jsr	do_yrot_poly
	move.w	#$0,$ffff8240.w
	jsr	vsync

	cmp.b	#59,$fffffc02.w
	bne.s	h
	add.w	#1,koords
	move.l	screen,a0
	move.w	#7999,d0
suddgg	move.l	#0,(a0)+
	dbf	d0,suddgg
h
	cmp.b	#57,$fffffc02.w
	bne	main_loop
	bra	end

****************
* Do yrot poly *
****************	
do_yrot_poly

	moveq	#0,d2
	move.w	(a0),d0		; x1
	move.w	2(a0),d1		; y1
	move.w	4(a0),d2		; x2
	move.w	6(a0),d3		; y2

	cmp.w	d0,d2
	blt	rita_bak

	jsr	init_y_bli1
	lea	x_add,a1
	lea	y_add,a2
	lea	$ffff8a00,a3
	lea	bredd_add1,a4

	add.w	d0,d0
	add.w	d0,d0
	add.w	d1,d1
	move.l	screen,d4		; screen adr
	add.w	(a1,d0.w),d4	; dest in
	add.w	(a2,d1.w),d4	; dest ner
	move.l	d4,$32(a3)	; s�tt dest
	moveq	#0,d4
	move.w	2(a1,d0.w),d4	; r�tt skew och allt
	add.l	d4,a4

	sub.w	(a0),d2
	moveq	#0,d0		; x1
	move.w	2(a0),d1		; y1
	move.w	d3,d4		; save y2
	sub.w	d1,d4		; y2-y1=ant scan
	subq.w	#1,d4		; -1 for the dbf

	moveq	#0,d6	
	sub.w	d1,d3		; y2-y1
	bne	.do_a_little_jump
	move.w	#1,d4
	asl.w	#6,d2
	move.w	d2,d6
	move.w	#0,d2
	move.l	a4,a5		; save
	bra	.tri_lp1
.do_a_little_jump:
	asl.w	#6,d2
	divs	d3,d2		; d3=k*64
	move.l	a4,a5		; save
.tri_lp1
	add.w	d2,d6		; x1+k
	move.w	d6,d0
	asr.w	#3,d0		; /64*8

	and.w	#%1111111111111000,d0
	move.l	a5,a4
	add.w	d0,a4
	move.w	(a4)+,$28(a3)	; slutmask1
	move.w	(a4)+,$2c(a3)	; slutmask3
	move.w	(a4)+,$36(a3)	; xcount
	move.w	#1,$38(a3)	; ycount
	move.w	(a4)+,$30(a3)	; yadd
	move.b	#$c0,$3c(a3)	; blitta
	dbf	d4,.tri_lp1	

*	Rita den raka delen av v�ggen

	move.w	#$300,$ff8240

	move.w	6(a0),d4
	neg.w	d4
	add.w	#99,d4

	tst.w	d4
	ble	.no_rak_draw	

	move.w	-8(a4),$28(a3)	; slutmask1
	move.w	-6(a4),$2c(a3)	; slutmask3
	move.w	-4(a4),$36(a3)	; xcount
	move.w	d4,$38(a3)	; ycount
	move.w	-2(a4),$30(a3)	; yadd
	move.b	#$c0,$3c(a3)	; blitta

.no_rak_draw:

	rts

************************************************ DRA MIG BAKL�NGES
rita_bak:

	jsr	init_y_bli2
	lea	x_add,a1
	lea	y_add,a2
	lea	$ffff8a00,a3
	lea	bredd_add2,a4

	add.w	d0,d0
	add.w	d0,d0
	add.w	d1,d1
	move.l	screen,d4		; screen adr
	add.w	(a1,d0.w),d4	; dest in
	add.w	(a2,d1.w),d4	; dest ner
	move.l	d4,$32(a3)	; s�tt dest
	moveq	#0,d4
	move.w	2(a1,d0.w),d4	; r�tt skew och allt
	add.l	d4,a4

	sub.w	(a0),d2
	neg.w	d2
	moveq	#0,d0		; x1
	move.w	2(a0),d1		; y1
	move.w	d3,d4		; save y2
	sub.w	d1,d4		; y2-y1=ant scan
	subq.w	#1,d4		; -1 for the dbf

	moveq	#0,d6	
	sub.w	d1,d3		; y2-y1
	bne	.do_a_little_jump
	move.w	#1,d4
	asl.w	#6,d2
	move.w	d2,d6
	move.w	#0,d2
	move.l	a4,a5		; save
	bra	.tri_lp1
.do_a_little_jump:
	asl.w	#6,d2
	divs	d3,d2		; d3=k*64
	move.l	a4,a5		; save
.tri_lp1
	add.w	d2,d6		; x1+k
	move.w	d6,d0
	asr.w	#3,d0		; /64*8

	and.w	#%1111111111111000,d0
	move.l	a5,a4
	add.w	d0,a4
	move.w	(a4)+,$28(a3)	; slutmask1
	move.w	(a4)+,$2c(a3)	; slutmask3
	move.w	(a4)+,$36(a3)	; xcount
	move.w	#1,$38(a3)	; ycount
	move.w	(a4)+,$30(a3)	; yadd
	move.b	#$c0,$3c(a3)	; blitta
	dbf	d4,.tri_lp1	

*	Rita den raka delen av v�ggen

	move.w	#$300,$ff8240

	move.w	6(a0),d4
	neg.w	d4
	add.w	#99,d4

	tst.w	d4
	ble	.no_rak_draw	

	move.w	-8(a4),$28(a3)	; slutmask1
	move.w	-6(a4),$2c(a3)	; slutmask3
	move.w	-4(a4),$36(a3)	; xcount
	move.w	d4,$38(a3)	; ycount
	move.w	-2(a4),$30(a3)	; yadd
	move.b	#$c0,$3c(a3)	; blitta

.no_rak_draw:

	rts

****************
* Endif        *
****************
end
	movem.l	savepal,d0-d7
	movem.l	d0-d7,$ffff8240.w
	
	move.l	svbi,$70.w
	
	move.w	oldrez,-(sp)
	move.l	oldphys,-(sp)
	move.l	oldlog,-(sp)
	move.w	#5,-(sp)
	trap	#14
	lea	12(sp),sp
	
	move.l	ustk,-(sp)
	move.w	#$20,-(sp)
	trap	#1
	addq.l	#6,sp
	
	clr.w	-(sp)
	trap	#1
	
*****************
* VBI och VSYNC *
*****************
vbi	add.w	#1,vflag
	rte
	
vsync	tst.w	vflag
	beq.s	vsync
	clr.w	vflag
	rts

vsync2	cmp.w	vflag,d0		; d0 = parameter f�r antal vbi
	bgt.s	vsync2
	clr.w	vflag
	rts
	
**********************
* olika screenseters * 
**********************
change_screen
	move.l	a0,-(sp)
	move.l	screen,a0
	move.l	screen,screen+4
	move.l	a0,screen
	move.l	(sp)+,a0
	
set_screen
	move.b	screen+1,$ffff8201.w
	move.b	screen+2,$ffff8203.w
	move.b	screen+3,$ffff820d.w
	rts

set_screen2
	move.b	screen+4+1,$ffff8201.w
	move.b	screen+4+2,$ffff8203.w
	move.b	screen+4+3,$ffff820d.w
	rts
	
***************************************************************************
	section	data
	
screen		dc.l	scrblk,scrblk+32000
y_normal		dc.w	99
koords		dc.w	50,20,150,57

slutmasker	dc.w	%1000000000000000
		dc.w	%1100000000000000
		dc.w	%1110000000000000
		dc.w	%1111000000000000
		dc.w	%1111100000000000
		dc.w	%1111110000000000
		dc.w	%1111111000000000
		dc.w	%1111111100000000
		dc.w	%1111111110000000
		dc.w	%1111111111000000
		dc.w	%1111111111100000
		dc.w	%1111111111110000
		dc.w	%1111111111111000
		dc.w	%1111111111111100
		dc.w	%1111111111111110
		dc.w	%1111111111111111
		dc.w	0			; endcode


slutmasker3	dc.w	%1111111111111111
		dc.w	%0111111111111111
		dc.w	%0011111111111111
		dc.w	%0001111111111111
		dc.w	%0000111111111111
		dc.w	%0000011111111111
		dc.w	%0000001111111111
		dc.w	%0000000111111111
		dc.w	%0000000011111111
		dc.w	%0000000001111111
		dc.w	%0000000000111111
		dc.w	%0000000000011111
		dc.w	%0000000000001111
		dc.w	%0000000000000111
		dc.w	%0000000000000011
		dc.w	%0000000000000001

slutmasker4
		dc.w	%0000000000000001
		dc.w	%0000000000000011
		dc.w	%0000000000000111
		dc.w	%0000000000001111
		dc.w	%0000000000011111
		dc.w	%0000000000111111
		dc.w	%0000000001111111
		dc.w	%0000000011111111
		dc.w	%0000000111111111
		dc.w	%0000001111111111
		dc.w	%0000011111111111
		dc.w	%0000111111111111
		dc.w	%0001111111111111
		dc.w	%0011111111111111
		dc.w	%0111111111111111
		dc.w	%1111111111111111
		dc.w	0			; endcode

fyllt_word	dc.w	$ffff

	section	bss
scrblk		ds.l	2*8000
ustk		ds.l	1
oldphys		ds.l	1
oldlog		ds.l	1
oldrez		ds.l	1
svbi		ds.l	1
y_add		ds.w	200
x_add		ds.w	640
bredd_add1	ds.w	20480
bredd_add2	ds.w	20480
savepal		ds.w	16
vflag		ds.w	1
	end
                                                                       