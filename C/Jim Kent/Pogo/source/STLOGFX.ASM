
	public _cscreen



	; zero_screen(s)
	public _zero_screen
_zero_screen:
	move.l	4(sp),a0
	movem.l D2/D3/D4/D5/D6/D7/A2/A3/A4,-(A7) ; save the world
	move.w #200-1,D0
	move.l	#0,d1
	move.l	d1,d2
	move.l	d2,d3
	move.l	d3,d4
	move.l	d4,d5
	move.l	d5,d6
	move.l	d6,d7
	move.l	d7,a2
	move.l	a2,a3
	move.l	a3,a4
	adda	#32000,a0
cl_lp:  
	movem.l D1/D2/D3/D4/D5/D6/D7/A2/A3/A4,-(A0)
	movem.l D1/D2/D3/D4/D5/D6/D7/A2/A3/A4,-(A0)
	movem.l D1/D2/D3/D4/D5/D6/D7/A2/A3/A4,-(A0)
	movem.l D1/D2/D3/D4/D5/D6/D7/A2/A3/A4,-(A0)
	dbf	D0,cl_lp
	movem.l (A7)+,D2/D3/D4/D5/D6/D7/A2/A3/A4
	rts


	public _copy_lines
_copy_lines
	move.w	12(sp),d0
	bra		cplines

	; copy_screen(source, dest)  32000-byte block copy 
	public _copy_screen
_copy_screen:
	move.w #200,D0
cplines
	move.l	4(sp),a0
	move.l	8(sp),a1
	movem.l D2/D3/D4/D5/D6/D7/A2/A3/A4,-(A7) ; save the world
	bra zcp_lp
cp_lp:  
	movem.l (A0)+,D1/D2/D3/D4/D5/D6/D7/A2/A3/A4
	movem.l D1/D2/D3/D4/D5/D6/D7/A2/A3/A4,(A1)
	movem.l (A0)+,D1/D2/D3/D4/D5/D6/D7/A2/A3/A4
	movem.l D1/D2/D3/D4/D5/D6/D7/A2/A3/A4,40(A1)
	movem.l (A0)+,D1/D2/D3/D4/D5/D6/D7/A2/A3/A4
	movem.l D1/D2/D3/D4/D5/D6/D7/A2/A3/A4,80(A1)
	movem.l (A0)+,D1/D2/D3/D4/D5/D6/D7/A2/A3/A4
	movem.l D1/D2/D3/D4/D5/D6/D7/A2/A3/A4,120(A1)
	adda	#160,A1
zcp_lp	dbf	D0,cp_lp
	movem.l (A7)+,D2/D3/D4/D5/D6/D7/A2/A3/A4
	rts

	; exchange_screen(s1, s2)  32000-byte array swap
	public _exchange_screen
_exchange_screen
	move.l	4(sp),a0
	move.l	8(sp),a1
	move.l D2,-(A7) ; save the world
	move.w #8000-1,D0
ex_lp:  move.l (A0),D1
	move.l (A1),D2
	move.l D2,(A0)+
	move.l D1,(A1)+
	dbf	D0,ex_lp
	move.l (A7)+,D2
	rts

	public _copy_bytes
_copy_bytes
	move.l 4(sp),a0
	move.l 8(sp),a1
	move.w 12(sp),d0
	bra zcp
cpl move.b (a0)+,(a1)+
zcp dbra d0,cpl
	rts


	public _copy_words
_copy_words
	move.l 4(sp),a0
	move.l 8(sp),a1
	move.w 12(sp),d0
	bra zcpw
cplw move.w (a0)+,(a1)+
zcpw dbra d0,cplw
	rts

