; STE 8-way hardware scrolling demo
; Written by Terry King for Kevin Preece c/o ICTARI 2/2/95
;
; The video address counters that are used on lines 143-145
; are equivalent to the following video address registers:
;
;	$ff8205 -> $ff8201	high video byte
;	$ff8207 -> $ff8203	medium video byte
;	$ff8209 -> $ff820d	low video byte
;
; NB: Using the video address registers would of caused flicker unless
; the interrupt has placed on a high priority.

	SECTION TEXT

ste_scroll
	bsr	super_mode
	move.w	#320,screen_width	; set virtual screen to 2
					; screens width (640 pixels)
	move.l	#buffer,screen_address

	bsr	setup_screen
	bsr	hardware_scroll_on
	lea	sin_table(pc),a6
	moveq	#0,d7
	
loop	move.w	#37,-(a7)
	trap	#14			; wait for vertical blank
	addq.l	#2,a7
	addq.w	#2,d7
	and.w	#$ff,d7
	moveq	#0,d0
	moveq	#0,d1
	move.b	(a6,d7),d0		; sin from table
	move.b	64(a6,d7),d1		; cos from table (sin+90 degrees)
	ext.w	d0			; extend to word
	ext.w	d1
	add.w	#80,d0			; center screen
	add.w	#80,d1
	move.w	d0,x
	move.w	d1,y
	
	move.w	#255,-(a7)
	move.w	#6,-(a7)
	trap	#1			; get keypress
	addq.l	#4,a7
	cmp.b	#" ",d0			; repeat until space is pressed

	not.w	$ffff8240.w
	not.w	$ffff8240.w

	bne.s	loop
		
	bsr	hardware_scroll_off
	bsr	reset_screen
	bsr	user_mode
	clr.w	-(a7)
	trap	#1

setup_screen
	move.w	#4,-(a7)
	trap	#14
	addq.l	#2,a7
	move.w	d0,old_res
	clr.w	-(a7)
	move.l	#-1,-(a7)
	move.l	#-1,-(a7)
	move.w	#5,-(a7)
	trap	#14
	add.l	#12,a7

	lea	picture(pc),a0
	lea	buffer,a1
	addq	#2,a0
	movem.l	$ffff8240.w,d0-7
	movem.l	d0-7,old_palette
	movem.l	(a0)+,d0-7
	movem.l	d0-7,$ffff8240.w
	
	move.l	a1,a2		
	add.l	#64000,a2
	move.w	#200-1,d0
nextline
	move.w	#40-1,d1
expandline
	move.l	(a0),(a1)		; make one screen into
	move.l	(a0),160(a1)		; a screen four times the
	move.l	(a0),(a2)		; size
	move.l	(a0),160(a2)
	addq.l	#4,a0
	addq.l	#4,a1
	addq.l	#4,a2
	dbf	d1,expandline
	lea	160(a1),a1
	lea	160(a2),a2
	dbf	d0,nextline
	rts
	
reset_screen
	clr.b	$ffff8265.w
	clr.b	$ffff820f.w
	movem.l	old_palette,d0-7
	movem.l	d0-7,$ffff8240.w
	move.w	old_res,-(a7)
	move.l	#-1,-(a7)
	move.l	#-1,-(a7)
	move.w	#5,-(a7)
	trap	#14
	add.l	#12,a7
	rts
	
hardware_scroll_on
	move.w	#$2700,sr		; turn off interrupts
	move.l	$4ce.w,$4ea.w		; mouse control to last vbl entry
	move.l	#vbl,$4ce.w		; install vbl interrupt
	move.w	#$2300,sr		; turn on interrupts
	rts

hardware_scroll_off
	move.w	#$2700,sr
	move.l	$4ea.w,$4ce.w		; return priority mouse control
	clr.l	$4ea.w
	move.w	#$2300,sr
	rts
	
; The vbl routine calculates the hardware registers every 1/50 of a
; second using the x and y coordinates.

vbl	movem.l	d0-3/a0,-(a7)
	move.w	x,d0			; x position
	move.w	y,d1			; y position
	move.w	screen_width,d2		; screen width
	move.l	screen_address,a0	; screen address
	mulu	d2,d1			; calculate y offset
	sub.w	#160,d2			; subtract normal screen width
	lsr.w	#1,d2			; divide by 2 (convert to words)
	move.w	d0,d3
	and.w	#$f,d0			; d0=hardware HSCROLL skew 0-15
	beq.s	no_extra_fetch
	subq.w	#4,d2			; subtract four words
no_extra_fetch
	lsr.w	#1,d3
	and.w	#$fff8,d3
	add.w	d3,a0			; add x offset to screen
	add.l	d1,a0			; add y offset to screen
	move.b	d0,$ffff8265.w		; HSCROLL
	move.b	d2,$ffff820f.w		; LINEWID
	move.l	a0,-(a7)
	move.b	1(a7),$ffff8205.w	; video registers hi byte
	move.b	2(a7),$ffff8207.w	; mid byte
	move.b	3(a7),$ffff8209.w	; lo byte
	addq.l	#4,a7
	movem.l	(a7)+,d0-3/a0
	rts

super_mode
	clr.l	-(a7)
	move.w	#$20,-(a7)
	trap	#1			; supervisor mode
	addq.l	#6,a7
	move.l	d0,old_sp
	rts	

user_mode
	move.l	old_sp,-(a7)
	move.w	#$20,-(a7)
	trap	#1			; back to user mode
	addq.l	#6,a7
	rts

	SECTION DATA
sin_table
	dc.b 0,1,3,5,7,9,11,13
	dc.b 15,17,19,21,23,25,26,28
	dc.b 30,32,34,35,37,39,41,42
	dc.b 44,46,47,49,50,52,53,55
	dc.b 56,57,59,60,61,63,64,65
	dc.b 66,67,68,69,70,71,72,73
	dc.b 73,74,75,75,76,77,77,78
	dc.b 78,78,79,79,79,79,79,79
	dc.b 80,79,79,79,79,79,79,78
	dc.b 78,78,77,77,76,75,75,74
	dc.b 73,73,72,71,70,69,68,67
	dc.b 66,65,64,63,61,60,59,57
	dc.b 56,55,53,52,50,49,47,46
	dc.b 44,42,41,39,37,35,34,32
	dc.b 30,28,26,25,23,21,19,17
	dc.b 15,13,11,9,7,5,3,1
	dc.b 0,-1,-3,-5,-7,-9,-11,-13
	dc.b -15,-17,-19,-21,-23,-25,-26,-28
	dc.b -30,-32,-34,-35,-37,-39,-41,-42
	dc.b -44,-46,-47,-49,-50,-52,-53,-55
	dc.b -56,-57,-59,-60,-61,-63,-64,-65
	dc.b -66,-67,-68,-69,-70,-71,-72,-73
	dc.b -73,-74,-75,-75,-76,-77,-77,-78
	dc.b -78,-78,-79,-79,-79,-79,-79,-79
	dc.b -80,-79,-79,-79,-79,-79,-79,-78
	dc.b -78,-78,-77,-77,-76,-75,-75,-74
	dc.b -73,-73,-72,-71,-70,-69,-68,-67
	dc.b -66,-65,-64,-63,-61,-60,-59,-57
	dc.b -56,-55,-53,-52,-50,-49,-47,-46
	dc.b -44,-42,-41,-39,-37,-35,-34,-32
	dc.b -30,-28,-26,-25,-23,-21,-19,-17
	dc.b -15,-13,-11,-9,-7,-5,-3,-1
	dc.b 0,1,3,5,7,9,11,13
	dc.b 15,17,19,21,23,25,26,28
	dc.b 30,32,34,35,37,39,41,42
	dc.b 44,46,47,49,50,52,53,55
	dc.b 56,57,59,60,61,63,64,65
	dc.b 66,67,68,69,70,71,72,73
	dc.b 73,74,75,75,76,77,77,78
	dc.b 78,78,79,79,79,79,79,79

picture	incbin tiles.pi1

	SECTION BSS	
x		ds.w 1
y		ds.w 1
screen_width	ds.w 1
screen_address	ds.l 1
old_res		ds.w 1
old_palette	ds.w 16
old_sp		ds.l 1

buffer		ds.b 320*400