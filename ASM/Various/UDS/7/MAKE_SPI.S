BPPFIL	EQU	0		0 on, 1 off
CNFFIL	EQU	0


	clr.l	-(sp)
	move.w	#$20,-(sp)
	trap	#1
	addq.l	#6,sp
	move.l	d0,ustk

;-------- Init sprite --------

	lea	init_sprite_config,a2
	move.w	(a2)+,d7			; antal

init_spr	move.w	(a2)+,d0			; bredd
	move.w	(a2)+,d1			; h�jd
	move.l	(a2)+,a0			; gfx adr
	move.l	(a2)+,a1			; BPP-adr
	movem.l	d7/a2,-(sp)
	jsr	make_byte_per_pixel_4
	movem.l	(sp)+,d7/a2
	dbf	d7,init_spr

;-------- Spara och avsluta --------

	IFEQ	BPPFIL

	move.w	#0,-(sp)
	move.l	#name,-(sp)
	move.w	#60,-(sp)
	trap	#1
	addq.l	#8,sp
	move.w	d0,num

	move.l	#sprdata,-(sp)
	move.l	len,-(sp)		; l�ngd
	move.w	num,-(sp)
	move.w	#64,-(sp)
	trap	#1
	add.l	#12,sp

	ENDC
	IFEQ	CNFFIL

	move.w	#0,-(sp)
	move.l	#name2,-(sp)
	move.w	#60,-(sp)
	trap	#1
	addq.l	#8,sp
	move.w	d0,num

	move.l	#spritedata,-(sp)
	move.l	len2,-(sp)	; l�ngd
	move.w	num,-(sp)
	move.w	#64,-(sp)
	trap	#1
	add.l	#12,sp

	ENDC

	move.l	ustk,-(sp)
	move.w	#$20,-(sp)
	trap	#1
	addq.l	#6,sp

	clr.w	-(sp)
	trap	#1

;-------- Make BPP --------

make_byte_per_pixel_4
	movem.l   d0-a6,-(sp)

	move.w	d0,(a1)+
	move.w	d1,(a1)+
	move.w	d0,d2
	mulu	d1,d2
	addq.w	#1,d2
	and.w	#$fffe,d2
	move.w	d2,(a1)+
	lea	(a1,d2),a2
	move.w	d1,.height	a4
.new_row
	move.w	d0,.width	a2
	move.l	a0,a3	

.next_word
	move.w	(a3)+,d4		 get bpl 1
	move.w	(a3)+,d5		 get bpl 2
	move.w	(a3)+,d6		 get bpl 3
	move.w	(a3)+,d7		 get bpl 4

	moveq.l #15,d2
.next_pixel
	moveq.l #0,d3
	add.w	d7,d7
	roxl.w	d3
	add.w	d6,d6
	roxl.w	d3
	add.w	d5,d5
	roxl.w	d3
	add.w	d4,d4
	roxl.w	d3
	add.w	d3,d3
	add.w	d3,d3	get pixel nr and multply with four
	move.b	d3,(a1)+	save byte per pixel
	subq.w	#1,.width	a2
	beq.s	.cont
	dbra	d2,.next_pixel
	bra.s	.next_word

.cont	lea	160(a0),a0	next line
	subq.w	#1,.height	a4
	bne.s	.new_row
	move.l	a2,a1
	movem.l (sp)+,d0-a6
	rts

.width	ds.w	1
.height 	ds.w	1

;---------------------------------------------------------------------------
; Section data och n�gra andra sm� djur...
;---------------------------------------------------------------------------
	section	data

name			dc.b	'e:\fiende\spider\spider.bpp',0
			even
name2			dc.b	'e:\fiende\spider\spider.cnf',0
			even
object			incbin	'e:\fiende\spider\spider.pi1'


init_sprite_config		dc.w	11-1
			dc.w	18,14			; bredd,h�jd
			dc.l	object+34+8*0,spr_m_fram1		; gfx-adr, BPP-adr
			dc.w	15,14				; bredd,h�jd
			dc.l	object+34+8*2,spr_m_fram2		; gfx-adr, BPP-adr
			dc.w	21,15				; bredd,h�jd
			dc.l	object+34+8*4,spr_m_sid1		; gfx-adr, BPP-adr
			dc.w	21,15				; bredd,h�jd
			dc.l	object+34+8*6,spr_m_sid2		; gfx-adr, BPP-adr
			dc.w	17,15				; bredd,h�jd
			dc.l	object+34+8*8,spr_m_bak1		; gfx-adr, BPP-adr
			dc.w	16,15				; bredd,h�jd
			dc.l	object+34+8*10,spr_m_bak2		; gfx-adr, BPP-adr
			dc.w	26,13				; bredd,h�jd
			dc.l	object+34+8*12,spr_m_skott		; gfx-adr, BPP-adr
			dc.w	26,14				; bredd,h�jd
			dc.l	object+34+8*14,spr_m_traff		; gfx-adr, BPP-adr
			dc.w	26,13				; bredd,h�jd
			dc.l	object+34+8*16,spr_m_dod1		; gfx-adr, BPP-adr
			dc.w	26,12				; bredd,h�jd
			dc.l	object+34+8*18,spr_m_dod2		; gfx-adr, BPP-adr
			dc.w	26,12				; bredd,h�jd
			dc.l	object+34+8*0+160*39,spr_m_dod3	; gfx-adr, BPP-adr
spritedata
		dc.w	34		; monster fram 1
		dc.l	spr_m_fram1-sprdata
		dc.b	0,0
		dc.w	34		; monster fram 2
		dc.l	spr_m_fram2-sprdata
		dc.b	0,0
		dc.w	34		; monster v�nster 1
		dc.l	spr_m_sid1-sprdata
		dc.b	0,1
		dc.w	34		; monster v�nster 2
		dc.l	spr_m_sid2-sprdata
		dc.b	0,1
		dc.w	34		; monster bak 1
		dc.l	spr_m_bak1-sprdata
		dc.b	0,0
		dc.w	34		; monster bak 2
		dc.l	spr_m_bak2-sprdata
		dc.b	0,0
		dc.w	34		; monster h�ger 1
		dc.l	spr_m_sid1-sprdata
		dc.b	0,0
		dc.w	34		; monster h�ger 2
		dc.l	spr_m_sid2-sprdata
		dc.b	0,0
		dc.w	34		; monster skjut
		dc.l	spr_m_skott-sprdata
		dc.b	0,0
		dc.w	34		; monster tr�ffad
		dc.l	spr_m_traff-sprdata
		dc.b	0,0
		dc.w	34		; monster d�d1
		dc.l	spr_m_dod1-sprdata
		dc.b	0,0
		dc.w	34		; monster d�d2
		dc.l	spr_m_dod2-sprdata
		dc.b	0,0
		dc.w	34		; monster d�d3
		dc.l	spr_m_dod3-sprdata
		dc.b	0,0
		dc.w	34		; monster flyg skott
		dc.l	spr_m_dod3-sprdata
		dc.b	0,0
sprdata
spr_m_fram1	ds.b	18*14+16
spr_m_fram2	ds.b	15*14+16
spr_m_sid1	ds.b	21*15+16+1
spr_m_sid2	ds.b	21*15+16+1
spr_m_bak1	ds.b	17*15+16+1
spr_m_bak2	ds.b	16*15+16
spr_m_skott	ds.b	26*13+16
spr_m_traff	ds.b	26*14+16
spr_m_dod1	ds.b	26*13+16
spr_m_dod2	ds.b	26*12+16
spr_m_dod3	ds.b	26*12+16 
end_block

len			dc.l	end_block-sprdata
len2			dc.l	sprdata-spritedata
ustk			ds.l	1
num			ds.w	1
