;nik logo for POV 31
	bra	skip
filename:	dc.b	"g:\pov31\mask2.dat",0	;destination name
	even
pic:	incbin	"g:\pov31\mask2.pi1"	;source picture
	even

skip:	move.l	sp,A5
	move.l	4(A5),A5
	move.l	$C(A5),D0
	add.l	$14(A5),D0
	add.l	$1C(A5),D0
	add.l	#$100,D0
	move.l	D0,-(sp)
	move.l	A5,-(sp)
	move.w	D0,-(sp)
	move.w	#$4A,-(sp)
	trap	#1
	add.l	#12,sp

	bsr	set_super
	dc.w	$a00a
	bsr	get_screen_base
	bsr	get_old_palette
	bsr	set_new_palette
	bsr	get_original_rez
	bsr	set_low_rez

	move.l	screen_base,a1
	lea	pic+34,a0
	move.w	#32000/4-1,d0
loop:	move.l	(a0)+,(a1)+
	dbf	d0,loop
	
	move.l	#-1,d1
	move.l	screen_base,a0
	lea	buffer,a1
	move.w	#22*8-1,d0
.loop:
	move.l	(a0),(a1)+
	move.l	d1,(a0)
	move.l	4(a0),(a1)+
	move.l	d1,4(a0)

	move.l	8(a0),(a1)+
	move.l	d1,8(a0)
	move.l	12(a0),(a1)+
	move.l	d1,12(a0)

	move.l	16(a0),(a1)+
	move.l	d1,16(a0)
	move.l	20(a0),(a1)+
	move.l	d1,20(a0)

	move.l	24(a0),(a1)+
	move.l	d1,24(a0)
	move.l	28(a0),(a1)+
	move.l	d1,28(a0)

	move.l	32(a0),(a1)+
	move.l	d1,32(a0)
	move.l	36(a0),(a1)+
	move.l	d1,36(a0)

	move.l	40(a0),(a1)+
	move.l	d1,40(a0)
	move.l	44(a0),(a1)+
	move.l	d1,44(a0)

	move.l	48(a0),(a1)+
	move.l	d1,48(a0)
	move.l	52(a0),(a1)+
	move.l	d1,52(a0)

	move.l	56(a0),(a1)+
	move.l	d1,56(a0)
	move.l	60(a0),(a1)+
	move.l	d1,60(a0)

	move.l	64(a0),(a1)+
	move.l	d1,64(a0)
	move.l	68(a0),(a1)+
	move.l	d1,68(a0)

	bsr	pause
	add.w	#160,a0
	dbf	d0,.loop

	move.l	a1,eob

;now save
	bsr	f_create
	bsr	f_write
	bsr	f_close

wait:	bsr	get_key

	CMP.B	#27,D0		;Wait for ESC.
	bne	wait

	bsr	set_old_palette
	bsr	set_med_rez
	dc.w	$a009
	bsr	set_user

	MOVE.W	#$0,-(SP)	; RETURN TO GEM DESKTOP.
	TRAP	#1
	RTS

***********************
* SUBROUTINES SECTION *
***********************

f_create:
	move.w	#0,-(sp)
	pea	filename
	move.w	#$3c,-(sp)
	trap	#1
	add.l	#8,sp
	move.w	d0,handle
	rts

f_write:
	move.l	#buffer,-(sp)
	lea	buffer,a0
	move.l	eob,a1
	sub.l	a0,a1
	move.l	a1,-(sp)
	move.w	handle,-(sp)
	move.w	#$40,-(sp)
	trap	#1
	add.l	#12,sp
	rts

f_close:
	move.w	handle,-(sp)
	move.w	#$3e,-(sp)
	trap	#1
	addq.l	#4,sp
	rts

pause:	move.w	d0,-(sp)
	move.w	#5000,d0
pau:	nop
	dbf	d0,pau
	move.w	(sp)+,d0
	rts

get_key:
	move.w	#7,-(sp)
	trap	#1
	addq.l	#2,sp
	rts

set_super:
	clr.l	-(sp)		;Set super stack equal
	move.w	#$20,-(sp)	; to user stack before call
	trap	#1
	addq.l	#6,sp		;correct stack
	move.l	d0,stack_save	;save old supervisor stack value
	rts
set_user:
	move.l	stack_save,-(sp)
	move.w	#$20,-(sp)
	trap	#1		;back to user
	addq.l	#6,sp		;correct stack
	rts

get_old_palette:
	move.w	#8-1,d0
	lea	$ff8240,a0
	lea	old_palette,a1
get_old:
	move.l	(a0)+,(a1)+
	dbf	D0,get_old
	rts

set_new_palette:
	lea	pic+2,a0
	bra	set_pal
set_old_palette:
	lea	old_palette,a0
set_pal:
	lea	$ff8240,a1
	move.w	#8-1,d0
set_p:	move.l	(a0)+,(a1)+
	dbf	d0,set_p
	rts

get_screen_base:
	move.w	#3,-(sp)
	trap	#14
	addq.l	#2,sp
	move.l	d0,screen_base
	rts

get_original_rez:
	move.w	#4,-(sp)
	trap	#14
	addq.l	#2,sp
	move.w	d0,original_rez
	rts

set_low_rez:
	clr.w	-(sp)
	bra	set_rez
set_med_rez:
	move.w	#1,-(sp)
set_rez:
	move.l	#-1,-(sp)
	move.l	#-1,-(sp)
	move.w	#5,-(sp)
	trap	#14
	add.l	#12,sp
	rts

****************
* DATA SECTION *
****************
stack_save:	dc.l	0
screen_base	dc.l	0
original_rez:	dc.w	0
handle:		dc.w	0
old_palette:	ds.w	16
eob:		dc.l	0
	even
buffer:	ds.b	10000
