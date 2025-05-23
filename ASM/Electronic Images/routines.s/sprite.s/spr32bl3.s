; BLITTER Sprite Rout. (with mouse movement to test it)
; by Martin Griffiths (C) 1991
; (7 32*32 sprites with clearing takes about 50% or 44% without)
; (notice also how much little variation there is in time taken!)

demo		EQU 0

; Blitter Equates 

halftone	EQU 0
src_xinc	EQU $20
src_yinc	EQU $22
src_addr	EQU $24
endmask1	EQU $28
endmask2	EQU $2A
endmask3	EQU $2C
dst_xinc	EQU $2E
dst_yinc	EQU $30
dst_addr	EQU $32
x_count		EQU $36
y_count		EQU $38
HOP		EQU $3A
OP		EQU $3B
line_num	EQU $3C
skew		EQU $3D

wait_blit	MACRO
.waitblit\@	BTST.B #7,line_num(A5)
		BNE.S .waitblit\@
		ENDM

		IFEQ demo
		MOVE.W #-1,-(SP)
		MOVE.W #$58,-(SP)
		TRAP #14
		ADDQ.L #4,SP
		MOVE.W D0,oldvideo
		MOVE.W #2,-(SP)
		TRAP #14		
		ADDQ.L #2,SP	
		MOVE.L D0,oldbase

		CLR -(SP)
		PEA -1.W
		PEA -1.W
		MOVE #5,-(SP)
		TRAP #14			; low res
		LEA 12(SP),SP
		CLR.L -(SP)
		MOVE #$20,-(SP)
		TRAP #1				; supervisor mode
		ADDQ.L #6,SP
		ENDC

mans_start	LEA stack(PC),SP
		MOVE.L log_base(PC),A0
		BSR cls
		MOVE.L phy_base(PC),A0
		BSR cls
		MOVEM.L pal(PC),D0-D7
		MOVEM.L D0-D7,$FFFF8240.W
		MOVE #$15,D0
		BSR write_ikbd
		MOVE #9,D0
		BSR write_ikbd
		MOVE #1,D0
		BSR write_ikbd
		MOVE #$3F,D0
		BSR write_ikbd
		MOVE #$1,D0		; y max = 
		BSR write_ikbd
		MOVE #$3f,D0		; 320!
		BSR write_ikbd
set_mouse	MOVEQ #$E,D0
		BSR write_ikbd
		MOVE #0,D0
		BSR write_ikbd
		MOVE #0,D0
		BSR write_ikbd
		MOVE #160,D0
		BSR write_ikbd
		MOVE #0,D0
		BSR write_ikbd
		MOVE #100,D0
		BSR write_ikbd
		BSR init_sprite

		MOVE #$13,D0
		BSR write_ikbd
		MOVE #$2700,SR
		MOVE.L $70.W,old_vbl
		MOVE.L $118.W,old_key
		MOVE.L #vbl,$70.W
		MOVE.L #key_rout,$118.W
		LEA old_mfp(PC),A0
		MOVE.B $FFFFFA07.W,(A0)+
		MOVE.B $FFFFFA09.W,(A0)+
		MOVE.B $FFFFFA13.W,(A0)+
		MOVE.B $FFFFFA15.W,(A0)+
		MOVE.B #$00,$FFFFFA07.W
		MOVE.B #$40,$FFFFFA09.W
		MOVE.B #$00,$FFFFFA13.W
		MOVE.B #$40,$FFFFFA15.W
		MOVE #$2300,SR
		MOVE #$11,D0
		BSR write_ikbd
		MOVE #$D,D0
		BSR write_ikbd

; Main program vbl loop starts here.

vbl_lp		BSR Swap_Screens
		MOVE.W #$220,$FFFF8240.W
		BSR Wait_Vbl
		MOVE.W #$000,$FFFF8240.W
		BSR Clear_Old
		BSR Draw_Sprites

		CMP.B #$39,key
		BNE vbl_lp

restore		MOVE #$13,D0
		BSR write_ikbd
		MOVE #$2700,SR
		MOVEQ #$8,D0
		BSR write_ikbd
		LEA old_mfp(PC),A0
		MOVE.B (A0)+,$FFFFFA07.W
		MOVE.B (A0)+,$FFFFFA09.W
		MOVE.B (A0)+,$FFFFFA13.W
		MOVE.B (A0)+,$FFFFFA15.W
		MOVE.L old_vbl(PC),$70.W
		MOVE.L old_key(PC),$118.W
		MOVE.L #$07770000,$FFFF8240.W
		MOVE.L #$00000000,$FFFF8244.W
		MOVE.W #$2300,sr
		MOVE #$11,D0
		BSR write_ikbd
		
		MOVE.W oldvideo(PC),-(SP)
		MOVE.W #$58,-(SP)
		TRAP #14
		ADDQ.L #4,SP
		MOVE.W #37,-(SP)
		TRAP #14
		ADDQ.L #2,SP
		MOVE.W #-1,-(SP)
		MOVE.L oldbase(PC),-(SP)
		MOVE.L oldbase(PC),-(SP)
		MOVE.W #5,-(SP)
		TRAP #14
		LEA 12(SP),SP

		CLR -(SP)
		TRAP #1
oldvideo	dc.w	0
oldbase		ds.l	1

; Clear Screen -> A0

cls		MOVE #1999,D0
		MOVEQ #0,D1
cls_lp		MOVE.L D1,(A0)+
		MOVE.L D1,(A0)+
		MOVE.L D1,(A0)+
		MOVE.L D1,(A0)+
		DBF D0,cls_lp
		RTS
	
; Swap those screens!

Swap_Screens	LEA log_base(PC),A0
		MOVE.L (A0)+,D0
		MOVE.L (A0)+,D1
		NOT.W (A0)
		MOVE.L D0,-(A0)
		MOVE.L D1,-(A0)
		LSR #8,D0
		MOVE.L D0,$FFFF8200.W
		RTS

; Wait for 1 Vbl.

Wait_Vbl	MOVE vbl_timer(PC),D0
.wait_vbl	CMP vbl_timer(PC),D0
		BEQ.S .wait_vbl
		RTS

; Clear Old Sprites.

Clear_Old	LEA old_xys1(PC),A1
		TST switch
		BEQ.S clr_old
		LEA old_xys2(PC),A1
clr_old		MOVE.L log_base(PC),A0
		MOVEQ #7-1,D7
		MOVEQ #0,D0
		MOVEQ #0,D1
		MOVEQ #0,D2
		MOVEQ #0,D3
		MOVEQ #0,D4
		MOVEQ #0,D5
clr_lp		MOVE.L A0,A2
		ADD (A1)+,A2
i		SET 0
		REPT 16
		MOVEM.L D0-D5,i(A2)
		MOVEM.L D0-D5,i+160(A2)
i		SET i+320
		ENDR
		DBF D7,clr_lp
		RTS

; Draw new Sprites
		
Draw_Sprites	LEA xymodbuf(PC),A3
		MOVEM.L $78(A3),D0-D7/A0-A2
		MOVEM.L D0-D7/A0-A2,$7C(A3)
		MOVEM.L $50(A3),D0-D7/A0-A2
		MOVEM.L D0-D7/A0-A2,$54(A3)
		MOVEM.L $28(A3),D0-D7/A0-A1
		MOVEM.L D0-D7/A0-A1,$2C(A3)
		MOVEM.L (A3),D0-D7/A0-A1
		MOVEM.L D0-D7/A0-A1,4(A3)
		MOVE mousex(PC),D0
		MOVE mousey(PC),D1
.which_clear	LEA old_xys1(PC),A6
		TST switch
		BEQ.S .cse2
		LEA old_xys2(PC),A6
.cse2		MOVE D0,(A3)
		MOVE D1,2(A3)
		MOVEQ #2,D2
		MOVEQ #32,D3
		BSR draw

		MOVE 24(A3),D0
		MOVE 26(A3),D1
		MOVEQ #2,D2
		MOVEQ #32,D3
		BSR draw
		MOVE 48(A3),D0
		MOVE 50(A3),D1
		MOVEQ #2,D2
		MOVEQ #32,D3
		BSR draw
		MOVE 72(A3),D0
		MOVE 74(A3),D1
		MOVEQ #2,D2
		MOVEQ #32,D3
		BSR draw
		MOVE 96(A3),D0
		MOVE 98(A3),D1
		MOVEQ #2,D2
		MOVEQ #32,D3
		BSR draw
		MOVE 120(A3),D0
		MOVE 122(A3),D1
		MOVEQ #2,D2
		MOVEQ #32,D3
		BSR draw
		MOVE 144(A3),D0
		MOVE 146(A3),D1
		MOVEQ #2,D2
		MOVEQ #32,D3
		BSR draw
		RTS

; General Blitter sprite rout.
; d0 = x d1 = y
; d2 = width in chunks d3 = height in pixels

draw		LEA sprite1(PC),A0
		MOVE.L log_base(PC),A1	; screen base
		LEA mul160_look(PC),A2	; *160 table
		LEA $FFFF8A00.W,A5
		;SUB #35,d0
		;sub #35,d1

.bot_top_clip				; clip top and bottom...
.top_clip	TST D1			; y>=0
		BGE.S .bot_clip		; yes then no top clip
		ADD.W D1,D3		; y<0 so height = (height+y)
		BLE .done		; totally above screen?
		NEG D1
		ADD.W D1,D1
		ADD.W D1,D1
		ADD.W D1,A0		; -> new sprite line
		MOVEQ #0,D1		; and set y = 0
.bot_clip	MOVE.W #200,D6
		SUB.W D3,D6		; 200-height
		CMP.W D6,D1		; y<=200-height
		BLE.S .nobot		; yes then no bottom clip
		MOVE.W #200,D3
		SUB.W D1,D3
		BLE .done		; totally below window?
.nobot

.leftright_clip	LSL #4,D2		; pixel width(chunks*16)
		MOVEQ #15,D7
		AND.W D0,D7		; x and 15
		MOVEQ #-1,D4
		;LSR.W D7,D4		; LEFT MASK
		MOVE.W D4,D5
		NOT.W D5		; RIGHT MASK

.left_clip	TST.W D0
		BGE.S .right_clip
		MOVEQ #-1,D4
		ADD.W D0,D2		; new width
		BLE .done		; totally left.
		CMP.W #16,D2
		BGE.S .ok
		MOVE.W D5,D4		; less then 16< then startmask=endmask
.ok		NEG D0
		ADD.W #15,D0
		LSR.W #3,D0
		AND.W #$FFFE,D0
		ADD.W D0,A0
		MOVEQ #0,D0		; and x=0
.right_clip	MOVE.W #320,D6		
		SUB.W D2,d6		; 320-width
		CMP.W D6,D0		; x<=320-width ? 
		BLE.S .noright		; yes then no right clip
		MOVEQ #-1,D5
		MOVE.W #319,D2
		SUB.W D0,D2
		BLT .done		; totally to the right?
.noright
		LSR #1,D0		
		AND.W #$FFF8,D0		; x chunk offset
		ADD.W D1,D1		; y*2
		ADD.W (A2,D1),D0	; add line offset to row offy
		MOVE D0,(A6)+		; save offset(for delete)
		ADDA D0,A1		; screen addr
		MOVE.W D4,endmask1(A5)
		MOVE.W #-1,endmask2(A5)	; set blitter masks
		MOVE.W D5,endmask3(A5)
		move.b	#12,d7
		OR.B #128,D7
		MOVE.B D7,skew(A5)	; set the shift amount

		LSR.W #4,D2
		ADDQ #1,D2
		subq #2,d2
		move.w	#1,d2

		MOVE.W D2,D5
		ADD.W D5,D5
		NEG D5
		ADDQ.W #4,D5		; chn
		MOVE.W D5,src_yinc(A5)
		MOVE.W D2,D5
		LSL #3,D5
		NEG D5
		ADD.W #168,D5
		MOVE.W D5,dst_yinc(A5)
		MOVE.W D2,x_count(A5)
		MOVE.W #8,dst_xinc(A5)
		MOVE.W #2,src_xinc(A5)
		MOVE.B #2,HOP(A5)
		MOVE.B #%11000000,d4

		SUBQ.L #2,A0

.maskit		MOVE.B #1,OP(A5)
		REPT 4
		MOVE.L A0,src_addr(A5)
		MOVE.L A1,dst_addr(A5)
		MOVE.W D3,y_count(A5)
		MOVE.B d4,line_num(A5)
		LEA 2(A1),A1
		ENDR
		MOVE.B #7,OP(A5)
		LEA 128(A0),A0
		LEA -8(A1),A1
.orit		
		REPT 4
		MOVE.L A0,src_addr(A5)
		MOVE.L A1,dst_addr(A5)
		MOVE.W D3,y_count(A5)
		MOVE.B d4,line_num(A5)
		LEA 2(A1),A1
		LEA 128(A0),A0
		ENDR
.done		RTS

; Keyboard/Mouse handler interrupt routine...

key_rout	MOVE #$2500,SR
		MOVE D0,-(SP)
		MOVE.B $FFFFFC00.W,D0
		BTST #7,D0
		BEQ.S end
		BTST #0,D0
		BEQ.S end
key_read	MOVE.B $FFFFFC02.W,D0
		CMP.B #$F7,D0
		BEQ.S start_mouse
		MOVE.B D0,key
end		MOVE (SP)+,D0
endi		BCLR #6,$FFFFFA11.W
		RTE

start_mouse	MOVE.L #mouseb1,$118.W
		BRA.S end
mouseb1		MOVE.L #mouseb2,$118.W
		MOVE.B $FFFFFC02.W,mousex-1
		BRA.S endi
mouseb2		MOVE.L #mouseb3,$118.W
		MOVE.B $FFFFFC02.W,mousex
		BRA.S endi
mouseb3		MOVE.L #mouseb4,$118.W
		MOVE.B $FFFFFC02.W,mousex+1
		BRA.S endi
mouseb4		MOVE.L #mouseb5,$118.W
		MOVE.B $FFFFFC02.W,mousex+2
		BRA.S endi
mouseb5		MOVE.L #key_rout,$118.W
		MOVE.B $FFFFFC02.W,mousex+3
		BRA.S endi

*************************************

write_ikbd	BTST.B #1,$FFFFFC00.W
		BEQ.S write_ikbd
		MOVE.B D0,$FFFFFC02.W
		RTS

flush		BTST.B #0,$FFFFFC00.W
		BEQ.S flok
		MOVE.B $FFFFFC02.W,D0
		BRA.S flush
flok		RTS

; The vbl sends command to the ikbd to make it report the mouse xy.

vbl		MOVE D0,-(SP)
		ADDQ #1,vbl_timer
		MOVE #$D,D0
		BSR write_ikbd
		MOVE (SP)+,D0
		RTE

; Initialise the sprite data. (the sprite has 16 pixels extra each line)

init_sprite	LEA sprite(PC),A0
		LEA sprite1(PC),A1
		LEA 128*1(A1),A2
		LEA 128*2(A1),A3
		LEA 128*3(A1),A4
		LEA 128*4(A1),A5
		MOVEQ #31,D7
.inilp		MOVEM.W (A0)+,D1-D4
		SWAP D1
		SWAP D2
		SWAP D3
		SWAP D4
		MOVE.W (A0)+,D1
		MOVE.W (A0)+,D2
		MOVE.W (A0)+,D3
		MOVE.W (A0)+,D4
		MOVE.L D1,D0
		OR.L D2,D0
		OR.L D3,D0
		OR.L D4,D0
		NOT.L D0
		MOVE.L D0,(A1)+
		MOVE.L D1,(A2)+
		MOVE.L D2,(A3)+
		MOVE.L D3,(A4)+
		MOVE.L D4,(A5)+
		LEA 8(A0),A0		; skip last chunk
		DBF D7,.inilp 
		RTS

i		SET 0
mul160_look	
		REPT 50
		DC.W i,i+160,i+320,i+480
i		SET i+640
		ENDR


pal		dc.w	$0000,$0101,$0323,$0212,$0101,$0434,$0545,$0312 
		dc.w	$0423,$0534,$0201,$0656,$0767,$0756,$0645,$0745 
		dc.l	$FFFFFFFF
sprite		dc.l	$00060007,$00080000,$E000E000,$10000000,$00000000 
		dc.l	$00000000,$0007007D,$00020000,$F600FE00,$00000000 
		dc.l	$00000000,$00000000,$00F1010F,$00FC0000,$F780FF80 
		dc.l	$00000000,$00000000,$00000000,$027801F7,$03880070 
		dc.l	$75C0C5C0,$3A000000,$00000000,$00000000,$050E0379 
		dc.l	$06F60188,$6AA0AAE0,$55000000,$00000000,$00000000 
		dc.l	$0C470476,$0BB907CF,$A5C06640,$DBB08000,$00000000 
		dc.l	$00000000,$01061809,$0FFF07F0,$6C00EA00,$97F84000 
		dc.l	$00000000,$00000000,$33CF2971,$1FBE07C1,$F2787C78 
		dc.l	$8F84C000,$00000000,$00000000,$314F2871,$1FBE07C1 
		dc.l	$F278FC78,$8F84C000,$00000000,$00000000,$150B2D77 
		dc.l	$5AFD0783,$870078CA,$FF34800A,$00000000,$00000000 
		dc.l	$51AF6BBA,$1E5705EE,$A4546576,$9B8C0002,$00000000 
		dc.l	$00000000,$4CDC7BE3,$173408D8,$6B80EAB8,$15440002 
		dc.l	$00000000,$00000000,$45B13B4F,$F6700180,$BA02F5F2 
		dc.l	$0E03000C,$00000000,$00000000,$73C75F3F,$A5E80300 
		dc.l	$A602D9F7,$3E0A0005,$00000000,$00000000,$BF3CACF3 
		dc.l	$534F0600,$18D3E8FF,$F702000C,$00000000,$00000000 
		dc.l	$EFF4DA27,$37D90FE0,$0083FCCF,$E303003C,$00000000 
		dc.l	$00000000,$43C8BD3B,$66F50340,$30ABD2F9,$ED290016 
		dc.l	$00000000,$00000000,$70C697BF,$68710040,$612793FD 
		dc.l	$EC25001A,$00000000,$00000000,$8C07ED7E,$12B90000 
		dc.l	$E04611DF,$EE060039,$00000000,$00000000,$400F7EF4 
		dc.l	$81390002,$86E66EE7,$82E61919,$00000000,$00000000 
		dc.l	$45FE6601,$19FE0000,$05CED4FA,$04CA2B34,$00000000 
		dc.l	$00000000,$13F0500F,$2FF00001,$031440F2,$80107FEE 
		dc.l	$00000000,$00000000,$600077E8,$08130004,$020880EA 
		dc.l	$4008BFF6,$00000000,$00000000,$140038C8,$07370000 
		dc.l	$0FD4C014,$0014FFE8,$00000000,$00000000,$140038CB 
		dc.l	$07340003,$0FD4C014,$0014FFE8,$00000000,$00000000 
		dc.l	$108114FB,$0B01001E,$FF70C300,$C3003CF8,$00000000 
		dc.l	$00000000,$0071085B,$07B1000E,$E1909D80,$9D807E70 
		dc.l	$00000000,$00000000,$00BF009D,$075D0022,$E1A09D80 
		dc.l	$9D807E60,$00000000,$00000000,$006A0068,$03880017 
		dc.l	$51401200,$1200EFC0,$00000000,$00000000,$004501D0 
		dc.l	$000001AF,$FA807880,$78808700,$00000000,$00000000 
		dc.l	$00530070,$0050000F,$E6006600,$66009800,$00000000 
		dc.l	$00000000,$000E000E,$000E0001,$10001000,$1000E000 
		dc.l	$00000000,$00000000 

sprite1		DS.L 5*32
old_vbl		DC.L 0
old_key		DC.L 0
old_mfp		DC.L 0
log_base	DC.L $2F0300		
phy_base	DC.L $2F8000		
switch		DC.W 0
vbl_timer	DC.W 0
old_xys1	DS.W 50
old_xys2	DS.W 50
key		DC.W 0
mousexy		DC.W 0
mousex		DC.W 160
mousey		DC.W 100  
xymodbuf	
		REPT 30
		DC.W 160,100,160,100
		ENDR
		SECTION BSS
		DS.L 199
stack		DS.L 2
		