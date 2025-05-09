***************************************************************************
*			     STANDARD SOURCECODE			  * 
***************************************************************************
	jsr	setsuper
	jsr	clear
	jsr	setupsprite
	jsr	rotate
	jsr	clear
	jsr	setscreen
	jsr	setpal
	jsr	setpic
	move.l	$70.w,oldvbi
	move.l	#newvbi,$70.w
***************************************************************************
mainloop:
	jsr	waitvbl
	move.w	#$400,$ff8240
	jsr	setsprites
	move.w	#$000,$ff8240
	jmp	mainloop
***************************************************************************
setsuper:
	clr.l	-(sp)			
	move.w	#$20,-(sp)
	trap	#1
	addq.l	#6,sp
	move.l	d0,savesuper
	rts
***************************************************************************
endsuper:
	move.l	savesuper,-(sp)
	move.w	#$20,-(sp)
	trap	#1
	addq.l	#6,sp
	rts
***************************************************************************
newvbi:
	move.w	#1,vbiflag
	rte
***************************************************************************
waitvbl:
	cmpi.w	#1,vbiflag
	bne	waitvbl
	move.w	#0,vbiflag
	rts 
***************************************************************************
setscreen:
	move.w	#0,-(sp)
	move.l	#$70000,-(sp)
	move.l	#$70000,-(sp)
	move.w	#$5,-(sp)
	trap	#14
	add.l	#12,sp
	rts
***************************************************************************
setpal:
	move.l	#palette,a0
	move.l	#$ff8240,a1
	rept 8
		move.l	(a0)+,(a1)+
	endr
	rts
***************************************************************************
setpic:
	move.l	#pic1+34,a0
	move.l	#pic2+34,a1
	move.l	#$70000,a2
	move.l	#$78000,a3
	move.w	#200*20,d0
	setpicloop:
		move.w	(a0),(a2)
		move.w	(a0),(a3)
		move.w	(a1),2(a2)	
		move.w	(a1),2(a3)
		addq.w	#8,a0	
		addq.w	#8,a1	
		addq.w	#8,a2	
		addq.w	#8,a3	
	dbf.w	d0,setpicloop
	rts
***************************************************************************
clear:
	move.l	#$ff8240,a0
	rept	8
		move.l	#0,(a0)+
	endr
	move.l	#$70000,a0
	move.l	#$78000,a1
	move.w	#7999,d0
	clearloop:
		move.l	#0,(a0)+
		move.l	#0,(a1)+
	dbf.w	d0,clearloop
	rts
***************************************************************************
screenswap:
	cmp.l	#$78000,$44e
	bne	logphys	
	physlog:
		move.l	#$78000,d0
		lsr.l	#8,d0
		move.b	d0,$ffff8203.w
		lsr.w	#8,d0
		move.b	d0,$ffff8201.w
		move.l	#$70000,$44e
		rts
	logphys:
		move.l	#$70000,d0
		lsr.l	#8,d0
		move.b	d0,$ffff8203.w
		lsr.w	#8,d0
		move.b	d0,$ffff8201.w
		move.l	#$78000,$44e
		rts
***************************************************************************
clearplane:
	move.l	$44e,a0
	move.w	#20*199,d0
	clearplaneloop:
		move.w	#0,(a0)
		addq.w	#8,a0
	dbf.w	d0,clearplaneloop
	rts
***************************************************************************
setupsprite:
	move.l	#balls,a0
	move.l	#$78000,a1
	move.w	#63,d0
	setupspriteloop:
		move.w	(a0)+,0(a1)
		move.w	(a0)+,8(a1)
		move.w	(a0)+,16(a1)
		move.w	(a0)+,24(a1)
		add.w	#160,a1
	dbf.w	d0,setupspriteloop
	rts
***************************************************************************
rotate:
	move.l	#sprite1,a1
	move.w	#15,d0
	rotateloop:
		jsr	rotatesave
		jsr	rotatescroll
	dbf.w	d0,rotateloop	
	rts
***************************************************************************
rotatescroll:
	move.l	#$78000,a0
	move.w	#63,d1
	rotatescrolloop:
		rept	14
		roxr.w	(a0)
		add.w	#8,a0
		endr
		sub.w	#8*14,a0
		rept	14
		roxr.w	2(a0)
		add.w	#8,a0
		endr
		sub.w	#8*14,a0
		rept	14
		roxr.w	4(a0)
		add.w	#8,a0
		endr
		sub.w	#8*14,a0
		rept	14
		roxr.w	6(a0)
		add.w	#8,a0
		endr
		add.w	#160-8*14,a0
	dbf.w	d1,rotatescrolloop	
	rts
***************************************************************************
rotatesave:
	move.l	#$78000,a0
	move.w	#63,d1
	rotatesaveloop:
		move.w	(a0),(a1)+
		move.w	8(a0),(a1)+
		move.w	16(a0),(a1)+
		move.w	24(a0),(a1)+
		move.w	32(a0),(a1)+
		add.w	#160,a0
	dbf.w	d1,rotatesaveloop
	rts
***************************************************************************
setsprites:
	jsr	incdeg1
	jsr	incdeg2
	move.w	deg3,adeg
	move.w	deg4,bdeg
	jsr	calculate
	jsr	delsprite
	move.w	deg7,adeg
	move.w	deg8,bdeg
	jsr	calculate
	jsr	delsprite
	move.w	deg1,adeg
	move.w	deg2,bdeg
	jsr	calculate
	jsr	setsprite
	move.w	deg5,adeg
	move.w	deg6,bdeg
	jsr	calculate
	jsr	setsprite
	rts
***************************************************************************
incdeg1:
	add.w	#1,deg1
	cmp.w	#360,deg1
	bne	nodeg1wrap
	move.w	#0,deg1
nodeg1wrap:
	add.w	#2,deg2
	cmp.w	#360,deg2
	bne	nodeg2wrap
	move.w	#0,deg2
nodeg2wrap:
	add.w	#1,deg3
	cmp.w	#360,deg3
	bne	nodeg3wrap
	move.w	#0,deg3
nodeg3wrap:
	add.w	#2,deg4
	cmp.w	#360,deg4
	bne	nodeg4wrap
	move.w	#0,deg4
nodeg4wrap:
	rts
***************************************************************************
incdeg2:
	add.w	#2,deg5
	cmp.w	#360,deg5
	bne	nodeg5wrap
	move.w	#0,deg5
nodeg5wrap:
	add.w	#1,deg6
	cmp.w	#360,deg6
	bne	nodeg6wrap
	move.w	#0,deg6
nodeg6wrap:
	add.w	#2,deg7
	cmp.w	#360,deg7
	bne	nodeg7wrap
	move.w	#0,deg7
nodeg7wrap:
	add.w	#1,deg8
	cmp.w	#360,deg8
	bne	nodeg8wrap
	move.w	#0,deg8
nodeg8wrap:
	rts
***************************************************************************
setsprite:
	move.w	d0,d2
	move.l	#sprite1,a0
	and.w	#$000f,d0
	muls	#64*10,d0
	add.w	d0,a0
	move.l	$44e,a2
	add.w	#4,a2
	and.w	#$fff0,d2
	divs	#2,d2
	muls	#160,d1
	add.w	d1,d2
	add.w	d2,a2	
	rept	63
	movem.w	(a0)+,d0-d4
	or.w	d0,0(a2)
	or.w	d1,8(a2)
	or.w	d2,16(a2)
	or.w	d3,24(a2)
	or.w	d4,32(a2)
	add.w	#160,a2
	endr
	rts
***************************************************************************
delsprite:
	move.w	d0,d2
	move.l	$44e,a2
	add.w	#4,a2
	and.w	#$fff0,d2
	divs	#2,d2
	muls	#160,d1
	add.w	d1,d2
	add.w	d2,a2	
	move.w	#0,d1
	rept	63
	move.w	d1,0(a2)
	move.w	d1,8(a2)
	move.w	d1,16(a2)
	move.w	d1,24(a2)
	move.w	d1,32(a2)
	add.w	#160,a2
	endr
	rts
***************************************************************************
calculate:
	clr.l	d0
	clr.l	d1
	clr.l	d2
	move.w	adeg,d0
	muls	#2,d0
	move.l	#sintab,a0
	add.w	d0,a0
	move.w	(a0),d0
	muls	#127,d0
	divs	#512,d0
	add.w	#127,d0
	move.w	d0,d7
	move.w	bdeg,d1
	muls	#2,d1
	move.l	#costab,a0
	add.w	d1,a0
	move.w	(a0),d1
	muls	#67,d1
	divs	#512,d1
	add.w	#67,d1
	rts
***************************************************************************
 section data
deg1:		dc.w	1
deg2:		dc.w	2
deg3:		dc.w	0
deg4:		dc.w	0
deg5:		dc.w	2
deg6:		dc.w	1
deg7:		dc.w	0
deg8:		dc.w	0
palette:	dc.w	$000,$777,$000,$777,$000,$000,$777,$777,$777,$777,$777,$777,$777,$777,$777,$777
balls:		incbin	a:\onecol.dat	
sintab:		incbin	a:\sintab.dat
		incbin	a:\sintab.dat
costab:		incbin	a:\costab.dat
		incbin	a:\costab.dat
pic1:		incbin	a:\zoompic1.pi1
pic2:		incbin	a:\zoompic2.pi1
 section bss
savesuper:	ds.l	1
vbiflag:	ds.w	1
oldvbi:		ds.l	1
adeg:		ds.w	1
bdeg:		ds.w	1
sprite1:	ds.b	16*10*63
