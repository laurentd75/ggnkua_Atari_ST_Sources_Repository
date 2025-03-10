super_on	macro
sup		set	0	;Turn Macro supervisory flag on		
		clr.l	-(sp)
		move.w	#32,-(sp)
		trap	#1
		addq.l	#6,sp
		move.l	d0,supsav
		bra.s	nex\@
supsav		ds.l	1	;trouble with more than one super_on..
nex\@		
		endm
;########################
super_off	macro	
sup		set	1	;Turn Macro supervisory flag on		
		move.l	supsav,-(sp)
		move.w	#32,-(sp)
		trap	#1
		addq.l	#6,sp
		endm
;#########################
exit		macro
		clr.w	-(sp)
		trap	#1
		endm		
;#########################
set_pal		macro   
		ifne	sup	
		pea	pal
		move.w	#6,-(sp)
		trap	#14
		addq.l	#6,sp 
		elseif 
		move.l	pal,$ff8240
		move.l  4+pal,$ff8244
		move.l	8+pal,$ff8248
		move.l	12+pal,$ff824c
		move.l	16+pal,$ff8250
		move.l	20+pal,$ff8254
		move.l	24+pal,$ff8258
		move.l	28+pal,$ff825c
		endc
		endm
;#########################
vsync		macro
		ifne	sup
		move.w	#37,-(sp)
		trap	#14
		addq.l	#2,sp
		elseif
		error
		endc
		endm
;#########################
low_rez		macro
		ifne	sup
		clr.w	-(sp)
		move.l	#-1,-(sp)
		move.l	#-1,-(sp)
		trap	#14
		lea	12(sp),sp
		elseif
		move.b	#0,$ffff8260.w
		endc
		endm		
;#########################
med_rez		macro
		ifne	sup
		move.w	#1,-(sp)
		move.l	#-1,-(sp)
		move.l	#-1,-(sp)
		trap	#14
		lea	12(sp),sp
		elseif
		move.b	#1,$ffff8260.w
		endc
		endm		
;#########################
flush		macro
		ifeq	sup
fl1\@	btst.b	#0,$fffffc00.w
	beq.s	fl2\@
	move.b	$fffffc02.w,d0
	bra.s	fl1\@
fl2\@
		endc
		endm
;#########################
testall		macro
		super_on
		set_pal
		low_rez
		super_off
		set_pal
		exit
		endm			
;########################
;		testall
;		even
;pal		dc.w	$000,$400,$600,$047
;		ds.w	12		