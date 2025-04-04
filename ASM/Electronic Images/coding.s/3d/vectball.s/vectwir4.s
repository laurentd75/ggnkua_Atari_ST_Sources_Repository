;-----------------------------------------------------------------------;
;									;
;                       Vector-Atomix Thingy				;
;									;
; (C) November 1991 Martin Griffiths. (Griff of The Inner Circle).	;
; This routine uses 'intelligent' sprite routines so that a minimum	;
; amount of masking is done and unused lines are NOT drawn to screen!	;
;									;
;-----------------------------------------------------------------------;

		OPT c+,O+,OW-

max_points	EQU 500				; max verts
spheight	EQU 16
BALLOBJ		EQU 0*4
LINEOBJ		EQU 1*4
POLYOBJ		EQU 2*4

letsgo		CLR -(SP)
		PEA -1.W
		PEA -1.W
		MOVE #5,-(SP)
		TRAP #14			; low res
		LEA 12(SP),SP
		CLR.L -(SP)
		MOVE #$20,-(SP)
		TRAP #1				; super visor
		ADDQ.L #6,SP

		MOVE #$2700,SR
		LEA stack,SP
		LEA $FFFF8240.W,A0
		MOVEM.L (A0),D0-D7
		MOVEM.L D0-D7,old_cols
		MOVEQ #0,D0
		MOVE.L D0,(A0)+
		MOVE.L D0,(A0)+
		MOVE.L D0,(A0)+
		MOVE.L D0,(A0)+
		MOVE.L D0,(A0)+
		MOVE.L D0,(A0)+
		MOVE.L D0,(A0)+
		MOVE.L D0,(A0)+
		LEA myseq(PC),A0
		MOVE.L A0,A1
		BSR Init_Seq	
		BSR Initballfield
		BSR Initscreens
		BSR set_ints
		MOVE.B #$12,$FFFFFC02.W
		MOVEM.L ballpal1(PC),D0-D7
		MOVEM.L D0-D7,$FFFF8240.W
		MOVE #$2300,SR

* This is the main program loop

Star_frame	BSR Swap_Screens
		MOVE.W #$200,$FFFF8240.W
		BSR Wait_Vbl
		MOVE.W #$000,$FFFF8240.W
;		BSR clear_balls
;		BSR clearmyscreen
		BSR clearall4
		BSR Draw_object

 		CMP.B #$39+$80,$FFFFFC02.W	; space to exit...
		BNE Star_frame		

Exit		MOVE #$2700,SR
		BSR rest_ints
		MOVE.B #$8,$FFFFFC02.W
		MOVEM.L old_cols(PC),D0-D7
		MOVEM.L D0-D7,$FFFF8240.W
		MOVE #$2300,SR
		CLR -(SP)			; bye for now...
		TRAP #1			
; Crap clear

clearmyscreen	MOVE.L log_base,A0
		ADDQ.W #6,A0
		MOVE #199,D0
		CLR D1
i		SET 0
.lp		
		REPT 20
		MOVE.W D1,i(A0)
i		SET i+8
		ENDR
		LEA 160(A0),A0
		DBF D0,.lp
		RTS

clearall4	MOVE.L log_base,A6
		LEA 32000(A6),A6
		MOVEQ #0,D0
		MOVEQ #0,D1
		MOVEQ #0,D2
		MOVEQ #0,D3
		MOVEQ #0,D4
		MOVEQ #0,D5
		MOVEQ #0,D6
		MOVE.L D0,A0
		MOVE.L D0,A1
		MOVE.L D0,A2
		MOVE.L D0,A3
		MOVE.L D0,A4
		MOVE #199,D7
.lp		MOVEM.L D0-D6/A0-A4,-(A6) ; 48
		MOVEM.L D0-D6/A0-A4,-(A6) ; 48
		MOVEM.L D0-D6/A0-A4,-(A6) ; 48
		MOVEM.L D0-D3,-(A6) 	  ; 16
		DBF D7,.lp
		RTS

; Swap screens - swaps logical/physical screen pointers

Swap_Screens	LEA log_base(PC),A0
		MOVE.L (A0)+,D0
		MOVE.L (A0)+,D1
		NOT.W (A0)			; switch screens
		MOVE.L D0,-(A0)
		MOVE.L D1,-(A0)
		LSR #8,D0
		MOVE.L D0,$FFFF8200.W		; set hardware...
		RTS

; Wait for the next vbl.

Wait_Vbl	MOVE vbl_timer(PC),D0
wait_vbl	CMP vbl_timer(PC),D0		; wait vbl
		BEQ.S wait_vbl
		RTS

;-----------------------------------------------------------------------;
;-----------------------------------------------------------------------;
;-----------------------------------------------------------------------;
;									;
;									;
;                            Object stuff.				;
;									;
;									;
;-----------------------------------------------------------------------;
;-----------------------------------------------------------------------;
;-----------------------------------------------------------------------;;

; Draw object 

Draw_object	LEA bold_pos1+2(PC),A3		; assume case 1
		TST switch
		BNE.S .case_1
.case_2		LEA bold_pos2+2(PC),A3		; no its case 2!
.case_1		MOVE.L A3,bold_ptr

		LEA root(PC),A0
		CLR.L (A0)
		MOVE.L #sort_table,insert_ptr
		BSR Matrix_make
		MOVE.L obj_ptr(PC),A5		; co-ords
		MOVE.L (A5)+,D0
		BEQ.S .norout
		MOVE.L D0,A0
		JSR (A0)			; call rout
.norout		BSR Translate
		BSR Insert_balls
		BSR Insert_lines
		BSR Draw_it
		RTS


; Calculate a translation matrix (and do rotation sequence!)
; D0-D7/A0-A6 smashed. (which basically means all of them!)

Matrix_make	LEA ballseqdata(PC),A3
		SUBQ #1,seq_timer(A3)
		BNE.S .nonew
		MOVE.L seq_ptr(A3),A1
		TST (A1)
		BPL.S .notendseq
		MOVE.L restart_ptr(A3),A1 
.notendseq	MOVE.W (A1)+,seq_timer(A3)
		MOVE.W (A1)+,addangx(A3)
		MOVE.W (A1)+,addangy(A3)
		MOVE.W (A1)+,addangz(A3)	; store new incs..
		MOVE.L A1,seq_ptr(A3)
.nonew		LEA angles(pc),a5
		LEA trig_tab,A0			; sine table
		LEA 512(A0),A2			; cosine table
		MOVEM.W (A5),D5-D7    		; get current x,y,z ang	
		ADD addangx(A3),D5
		ADD addangy(A3),D6		; add increments
		ADD addangz(A3),D7
		AND #$7FE,D5
		AND #$7FE,D6
		AND #$7FE,D7
		MOVEM.W D5-D7,(A5)   	
		MOVE (A0,D5),D0			sin(xd)
		MOVE (A2,D5),D1			cos(xd)
		MOVE (A0,D6),D2			sin(yd)
		MOVE (A2,D6),D3			cos(yd)
		MOVE (A0,D7),D4			sin(zd)
		MOVE (A2,D7),D5			cos(zd)
		LEA M11+2(PC),A1
* sinz*sinx(used twice) - A3
		MOVE D0,D6			sinx
		MULS D4,D6			sinz*sinx
		ADD.L D6,D6
		SWAP D6
		MOVE D6,A3
* sinz*cosx(used twice) - A4
		MOVE D1,D6			cosx
		MULS D4,D6			sinz*cosx
		ADD.L D6,D6
		SWAP D6
		MOVE D6,A4
* Matrix(1,1) cosy*cosx-siny*sinz*sinx
		MOVE D3,D6			cosy
		MULS D1,D6			cosy*cosx
		MOVE A3,D7			sinz*sinx
		MULS D2,D7			siny*sinz*sinx					
		SUB.L D7,D6
		ADD.L D6,D6
		SWAP D6			
		MOVE D6,(A1)
* Matrix(2,1) siny*cosx+cosy*sinz*sinx 
		MOVE D2,D6
		MULS D1,D6			siny*cosx
		MOVE A3,D7			sinz*sinx
		MULS D3,D7			cosy*sinz*sinx			
		ADD.L D7,D6
		ADD.L D6,D6
		SWAP D6			
		MOVE D6,M21-M11(A1)
* Matrix(3,1) -cosz*sinx
		MOVE D5,D6			cosz
		MULS D0,D6			cosz*sinx
		ADD.L D6,D6
		SWAP D6
		NEG D6				-cosz*sinx
		MOVE D6,M31-M11(A1)
* Matrix(1,2) -siny*cosz
		MOVE D2,D6			siny
		MULS D5,D6			siny*cosz
		ADD.L D6,D6
		SWAP D6
		NEG D6				-siny*cosz
		MOVE D6,M12-M11(A1)
* Matrix(2,2) cosy*cosz		
		MOVE D3,D6			cosy
		MULS D5,D6			cosy*cosz
		ADD.L D6,D6
		SWAP D6
		MOVE D6,M22-M11(A1)
* Matrix(3,2) sinz 
		MOVE D4,M32-M11(A1)
* Matrix(1,3) cosy*sinx+siny*sinz*cosx
		MOVE D3,D6			cosy
		MULS D0,D6			cosy*sinx
		MOVE A4,D7			sinz*cosx
		MULS D2,D7
		ADD.L D7,D6
		ADD.L D6,D6
		SWAP D6				siny*(sinz*cosx)
		MOVE D6,M13-M11(A1)
* Matrix(2,3) siny*sinx-cosy*sinz*cosx
		MULS D0,D2			siny*sinx
		MOVE A4,D7
		MULS D3,D7
		SUB.L D7,D2 
		ADD.L D2,D2
		SWAP D2
		MOVE D2,M23-M11(A1)
* Matrix(3,3) cosz*cosx
		MULS D1,D5 
		ADD.L D5,D5
		SWAP D5				cosz*cosx
		MOVE D5,M33-M11(A1)
		RTS				

; Sequence data 
		
		RSRESET

seq_timer	RS.W 1
seq_ptr		RS.L 1
addangx		RS.W 1
addangy		RS.W 1
addangz		RS.W 1
restart_ptr	RS.L 1

ballseqdata	DC.W 1
		DC.L ballsequence 
		DS.W 3
		DC.L restart

ballsequence	
restart		
		
		;DC.W 500,0,0,0

		DC.W 50,10,8,12
		DC.W 50,12,8,6
		DC.W 50,12,6,4
		DC.W 50,10,8,6
		DC.W 50,12,10,8
		DC.W 50,14,12,10
		DC.W 50,14,10,6
		DC.W 50,12,8,8
		DC.W 50,12,6,10
		DC.W 50,12,8,12
		DC.W 50,10,8,10
		DC.W -1

; Rout to translate my lovely balls!! A5-> no. balls

Translate	LEA translated(PC),A1
		MOVE.W #160,A3			; x centre
		MOVE.W #116,A4			; y centre
		LEA perstab,A6
		MOVE (A5)+,D7			; no. of stars
		SUBQ #1,D7
		BMI notrans
star_lp		MOVEM.W (A5)+,D0-D2		; get x,y,z
		MOVE D0,D3			
		MOVE D1,D4			; dup
		MOVE D2,D5
; Calculate x co-ordinate		
M11		MULS #0,D0			
M21		MULS #0,D4			; mat mult
M31		MULS #0,D5
		ADD.L D4,D0
		ADD.L D5,D0			; x
		MOVE D3,D6
		MOVE D1,D4
		MOVE D2,D5
; Calculate y co-ordinate		
M12		MULS #0,D3
M22		MULS #0,D1			; mat mult
M32		MULS #0,D5
		ADD.L D3,D1
		ADD.L D5,D1			; y
; Calculate z co-ordinate
M13		MULS #0,D6
M23		MULS #0,D4			; mat mult
M33		MULS #0,D2
		ADD.L D6,D2
		ADD.L D4,D2			; z
		ADD.L D0,D0
		ADD.L D1,D1
		ADD.L D2,D2
		SWAP D0
		SWAP D1
		SWAP D2
		ADD #0,D0
		ADD #0,D1
		ADD #1000,D2
		ADD.W D2,D2
		MOVE.W (A6,D2),D3
		MULS D3,D0
		MULS D3,D1
		SWAP D0
		SWAP D1
		ADD A3,D0			; x+xcentre
		ADD A4,D1			; y+ycentre
		MOVE.W D0,(A1)+
		MOVE.W D1,(A1)+
		MOVE.W D2,(A1)+
		DBF D7,star_lp			
notrans		RTS

; The 3D Sequencer!
; commands 0 - Set new object, initial offset X,Y,Z .Ws 
;	       View angles ptr.L Offsets ptr.L(in object to sequence!)
;          1 - Set X,Y and Z Rotation speeds and X,Y,Z offset adds.
; 	       TIMER (.W) X,Y,Z rot vals (.W) X,Y,Z offset (.W)
;          2 = Sets a Waveform to be added to X,Y,Z centres each update.
;	       Waveform size .W (in bytes),Initial offset .W
;              Waveform ptr.L
;          3 = Stop Waveform - no parameters
;          4 - Restart Sequence

SetNewObj	EQU 0*4
SetXYZstuff	EQU 1*4
SetWaveformON	EQU 2*4
SetWaveformOFF	EQU 3*4
SetRestart	EQU 4*4

		RSRESET
Seq_ptr		RS.L 1			; Ptr to Sequence!
Restart_ptr	RS.L 1			; Ptr to Place to Restart Seq.
Seq_Timer	RS.W 1			; Sequence Timer
Object_ptrA	RS.L 1			; Ptr to Object (angles)
Object_ptrO	RS.L 1			; Ptr to Object (offsets)
OffsetXYZ	RS.W 0
OffsetX		RS.W 1			; Offset X
OffsetY		RS.W 1			;    "   Y
OffsetZ		RS.W 1			;    "   Z
XYZang		RS.W 0
Xang		RS.W 1			;
Yang		RS.W 1			; Current View Angles (X,Y,Z)
Zang		RS.W 1			;
XYZadd		RS.W 0
Xadd		RS.W 1			; X rotation addition 
Yadd		RS.W 1			; Y rotation    "
Zadd		RS.W 1                  ; Z rotation    "
XYZaddOffset	RS.W 0
XaddOffset	RS.W 1			; X offset addition
YaddOffset	RS.W 1			; Y offset addition
ZaddOffset	RS.W 1			; Z offset addition
Waveform_flag	RS.W 1			; Waveform Flag(0=no wave <>0 wave)
Waveform_ptr	RS.L 1			; Waveform base PTR
Waveform_offptr	RS.W 1			; offset in Waveform
Waveform_Size	RS.W 1                  ; Size(in bytes) of waveform

SeqStrucSize	RS.B 1			; size of struc

; Initialise Sequence... A0-> Sequence Data A1-> Restart Data.

Init_Seq	LEA SeqStructure(PC),A5
		MOVE.L A0,Seq_ptr(A5)
		MOVE.L A1,Restart_ptr(A5)
		RTS

; This is the sequencer - Call once every object update.

Do_Sequence	LEA SeqStructure(PC),A5
		SUBQ #1,Seq_Timer(A5)
		BGT.S seqdone
		MOVE.L Seq_ptr(A5),A0	; get seq ptr
morethisframe	MOVE.W (A0)+,D0		; get next command in sequence
		JMP .SeqCommandList(PC,D0.W)
.SeqCommandList	BRA.W SetNewObject	; init new object.
		BRA.W SetXYZ_addStuff	; set movement vals(rot+offset)
		BRA.W SetWaveform_ON
		BRA.W SetWaveform_OFF
		BRA.W Restart_Seq	; restart sequence
endthisframe:	MOVE.L A0,Seq_ptr(A5)	; store seq ptr.
seqdone		MOVEM XYZaddOffset(A5),D0-D2
		ADD.W D0,OffsetX(A5)
		ADD.W D1,OffsetY(A5)	; update offsets!
		ADD.W D2,OffsetZ(A5)
		MOVEM XYZadd(A5),D0-D2
		ADD.W D0,Xang(A5)
		ADD.W D1,Yang(A5)	; update view angles!
		ADD.W D2,Zang(A5)
		MOVE.L Object_ptrA(A5),A1  
		MOVEM XYZang(A5),D0-D2
		MOVEM D0-D2,(A1)	; store view angs in object
		MOVEM OffsetXYZ(A5),D0-D2
		TST.B Waveform_flag(A5)
		BEQ.S .noaddwaveform
		MOVE.L Waveform_ptr(A5),A1
		MOVE.W Waveform_offptr(A5),D3
		MOVEM.W (A1,D3),D4-D6
		ADD.W D4,D0
		ADD.W D5,D1		; update offsets!
		ADD.W D6,D2
		ADDQ #6,D3
		CMP.W Waveform_Size(A5),D3
		BNE.S .nowrapwaveform
		CLR D3
.nowrapwaveform	MOVE.W D3,Waveform_offptr(A5)
.noaddwaveform	MOVE.L Object_ptrO(A5),A1  
		MOVEM D0-D2,(A1)	; store view offsets in object 
		RTS

; Set New Object initial X,Y,Z offsets, X,Y,Z angles,Obj Angle/offset ptrs.

SetNewObject	MOVE.W (A0)+,OffsetX(A5)
		MOVE.W (A0)+,OffsetY(A5)
		MOVE.W (A0)+,OffsetZ(A5)
		MOVE.W (A0)+,Xang(A5)
		MOVE.W (A0)+,Yang(A5)
		MOVE.W (A0)+,Zang(A5)
		MOVE.L (A0)+,Object_ptrA(A5)
		MOVE.L (A0)+,Object_ptrO(A5)
		BRA.W morethisframe	

; Set X,Y,Z rotation speed and offset movement speeds.

SetXYZ_addStuff	MOVE.W (A0)+,Seq_Timer(A5)
		MOVE.W (A0)+,Xadd(A5)
		MOVE.W (A0)+,Yadd(A5)
		MOVE.W (A0)+,Zadd(A5)
		MOVE.W (A0)+,XaddOffset(A5)
		MOVE.W (A0)+,YaddOffset(A5)
		MOVE.W (A0)+,ZaddOffset(A5)
		BRA.W endthisframe		

; Set a waveform on e.g values to be added each update to X,Y,Z.

SetWaveform_ON	MOVE.W (A0)+,Waveform_Size(A5)
		MOVE.W (A0)+,Waveform_offptr(A5)
		MOVE.L (A0)+,Waveform_ptr(A5)
		ST Waveform_flag(A5)
		BRA.W morethisframe	

; Set a waveform off...

SetWaveform_OFF	SF Waveform_flag(A5)
		BRA.W morethisframe	

; Restart the Sequence

Restart_Seq	MOVE.L Restart_ptr(A5),A0
		BRA.W endthisframe		

SeqStructure	DS.B SeqStrucSize

		MOVEM.W (A5)+,D5-D7    	
		AND #$7FE,D5
		AND #$7FE,D6
		AND #$7FE,D7
offz		DC.W 0

; The Sequence 

myseq		DC.W SetNewObj,0,0,$3B30,0,0,0
		;DC.L grid7by7,grid7by7+6
		DC.W SetXYZstuff,40,0,0,0,0,0,-254
		DC.W SetXYZstuff,1,0,0,0,0,0,-238
		DC.W SetXYZstuff,480,0,0,0,0,0,0
		DC.W SetXYZstuff,64,0,0,8,0,0,0
		DC.W SetXYZstuff,126,0,0,0,0,0,0
		DC.W SetXYZstuff,64,0,8,0,0,0,0
		DC.W SetXYZstuff,218,0,0,0,0,0,0
		DC.W SetXYZstuff,200,-20,-16,18,0,0,0
		DC.W SetXYZstuff,200,-18,-16,20,0,0,0
		DC.W SetXYZstuff,200,-16,-18,18,0,0,0
		DC.W SetXYZstuff,228,-14,-22,20,0,0,0
		;DC.W SetWaveformON,360,0
		;DC.L phen_twirl
		DC.W SetXYZstuff,180,-18,-20,22,0,0,0
		DC.W SetXYZstuff,180,-22,-22,24,0,0,0
		DC.W SetXYZstuff,90,-22,-22,24,0,0,0
		;DC.W SetWaveformOFF
		DC.W SetRestart

; Treesort object defination.

		rsreset

depth		rs.w 1
def_ptr		rs.l 1
lptr		rs.l 1
rptr		rs.l 1
obsize		rs.b 1

root		dc.l 0

;--------------------------------------------------------------------------
; insert node into the binary tree
;
; d2 = distance away for this object
; a1 = pointer to object structure
; a5 = pointer to defination for object (i.e BALL/LINE etc).
; root = pointer to the root of the binary tree
;--------------------------------------------------------------------------

insert		macro
		move.w d2,(a1)
		move.l a5,def_ptr(a1)
		moveq	#0,d1
		move.l	d1,lptr(a1)
		move.l	d1,rptr(a1)		;terminal node
		move.l	(a6),d1			;root
		beq.s	.empty\@		;test for empty tree
.nextnode\@	move.l	d1,a2
		cmp.w	(a2),d2
		bgt.s	.try_right\@
		move.l	lptr(a2),d1		;empty left node?
		bne.s	.nextnode\@
		move.l	a1,lptr(a2)
		bra.s .done\@
.empty\@	move.l	a1,(a6) 		;root=object is first entry
		bra.s .done\@
.try_right\@	move.l	rptr(a2),d1		;empty right node?
		bne.s	.nextnode\@
		move.l	a1,rptr(a2)
.done\@		
		endm

insert_ptr	DC.L 0
bold_ptr	DC.L 0

; Insert balls into TREE.

Insert_balls	MOVE.L insert_ptr(PC),A1
		LEA translated(PC),A3
		LEA root(PC),A6
		MOVE.W (A5)+,D7
		SUBQ #1,D7
		BMI.S .noballs
.insert_ball_lp	MOVE.W 2(A5),D2		; offset in translation
		MOVEM.W 4(A3,D2),D2	; get z (depth)
		insert			; insert it
		LEA obsize(A1),A1
		LEA 6(A5),A5		; onto next ball
		DBF D7,.insert_ball_lp
		MOVE.L A1,insert_ptr
.noballs	RTS

; Insert lines into TREE.

Insert_lines	MOVE.L insert_ptr(PC),A1
		LEA translated(PC),A3
		LEA root(PC),A6
		MOVE.W (A5)+,D7
		SUBQ #1,D7
		BMI.S .nolines
.insert_line_lp	MOVEM.W 2(A5),D2-D3	; offsets for vertex pairs
		MOVE.W 4(A3,D2),D2	; get z (depth) vert 1
		MOVE.W 4(A3,D3),D3	; get z (depth) vert 2 
		ADD D3,D2
		ASR #1,D2
		ADD #70,D2
		;CMP.W D3,D2
		;BLE.S .ok
		;MOVE.W D3,D2
.ok		insert			; insert it
		LEA obsize(A1),A1
		LEA 6(A5),A5		; onto next ball
		DBF D7,.insert_line_lp
		MOVE.L A1,insert_ptr
.nolines	RTS

;		PEA (A3)
;		BSR treesort			; draw them
;		MOVE.L (SP)+,A0
;		SUB.L A0,A3
;		MOVE.W A3,D0
;		LSR #2,D0
;		MOVE.W D0,-2(A0)		; store no. of sprites
;		RTS

;		Plot a ball

plotball	LEA translated(PC),A1
		MOVE.W (A5)+,D0
		MOVEM.W (A1,D0),D0-D2
		MOVE.L log_base(PC),A2		; screen base in A2
		SUBQ #8,D0
		SUBQ #8,D1
		CMP #215,D1			; clip y
		BCC .noplot
		CMP #319-16,D0			; clip x
		BCC .noplot
		ADD D0,D0
		ADD D0,D0			; x*4
		LEA ballxlookup(PC),A3
		MOVE.L (A3,D0),D0
		ADD D1,D1			
		LEA blmul_160+32(PC),A3
		ADD.W (A3,D1),D0		; add screen line
		ADD.W D0,A2
		;MOVE.L bold_ptr(PC),A3
		;MOVE.W D0,(A3)+
		SWAP D0
		;MOVE (A5)+,D2
		;MOVE.W D2,(A3)+
		ADD.W (A5),D0			; add z buf ptr.(sprite size) 
		LEA routs,A0
		MOVE.L (A0,D0),A0
		JSR (A0)
.noplot		RTS	

;--------------------------------------------------------------------------
; treesort
; perform an inorder traversal on the binary
; tree constructed by the above procedure
; root = pointer to the root of the binary tree
;--------------------------------------------------------------------------
; Plot the balls to the screen (in Z order).

Draw_it		lea .goright(pc),A6
		move.l	root(pc),d0
		beq.s	.empty			;empty tree
.goright	move.l	d0,a1
		pea (a1)			;save pointer to this node
		move.l	rptr(a1),d0
		beq.s	.noright
		jsr (a6)			;recursive descent
		move.l	(sp),a1
.noright	move.l def_ptr(a1),a5
		move.w (a5)+,d0
		jsr .jmptab(pc,d0)
		move.l	(sp)+,a1		;pointer to current
		move.l	lptr(a1),d0		;node
		bne.s	.goright
.empty		rts
.jmptab		bra.w plotball
		bra.w DrawLine

DrawLine	LEA translated(PC),A4
		MOVEM.W (A5),D0/D2
		MOVEM.W (A4,D0),D0-D1
		MOVEM.W (A4,D2),D2-D3

;-----------------------------------------------------------------------;
; Routine to draw a 1 plane line,the line is clipped if necessary.	;
; D0-D3 holds x1,y1/x2,y2       D0-D6/A0 smashed.       		;
;-----------------------------------------------------------------------;

xmax		EQU 319
ymax		EQU 215

Draw_line	LEA bit_offs(PC),A2
		LEA blmul_160+32(PC),A3
		MOVE.L log_base(PC),A0
clipony		CMP.W D1,D3			; y2>=y1?(Griff superclip)!
		BGE.S y2big
		EXG D1,D3			; re-order
		EXG D0,D2
y2big		TST D3				; CLIP ON Y
		BLT nodraw			; totally below window? <ymin
		CMP.W #ymax,D1
		BGT nodraw			; totally above window? >ymax
		CMP.W #ymax,D3			; CLIP ON YMAX
		BLE.S okmaxy			; check that y2<=ymax 
		MOVE #ymax,D5
		SUB.W D3,D5			; ymax-y
		MOVE.W D2,D4
		SUB.W D0,D4			; dx=x2-x1
		MULS D5,D4			; (ymax-y)*(x2-x1)
		MOVE.W D3,D5
		SUB.W D1,D5			; dy
		DIVS D5,D4			; (ymax-y)*(x2-x1)/(y2-y1)
		ADD.W D4,D2
		MOVE #ymax,D3			; y1=0
okmaxy		TST.W D1			; CLIP TO YMIN
		BGE.S cliponx
		MOVEQ #0,D5
		SUB.W D1,D5			; ymin-y
		MOVE.W D2,D4
		SUB.W D0,D4			; dx=x2-x1
		MULS D5,D4			; (ymin-y1)*(x2-x1)
		MOVE.W D3,D5
		SUB.W D1,D5			; dy
		DIVS D5,D4			; (ymin-y)*(x2-x1)/(y2-y1)
		ADD.W D4,D0
		MOVEQ #0,D1			; y1=0
cliponx		CMP.W D0,D2			; CLIP ON X				
		BGE.S x2big
		EXG D0,D2			; reorder
		EXG D1,D3
x2big		TST.W D2			; totally outside <xmim
		BLT nodraw
		CMP.W #xmax,D0			; totally outside >xmax
		BGT nodraw
		CMP.W #xmax,D2			; CLIP ON XMAX
		BLE.S okmaxx	
		MOVE.W #xmax,D5
		SUB.W D2,D5			; xmax-x2
		MOVE.W D3,D4
		SUB.W D1,D4			; y2-y1
		MULS D5,D4			; (xmax-x1)*(y2-y1)
		MOVE.W D2,D5
		SUB.W D0,D5			; x2-x1
		DIVS D5,D4			; (xmax-x1)*(y2-y1)/(x2-x1)
		ADD.W D4,D3
		MOVE.W #xmax,D2
okmaxx		TST.W D0
		BGE.S .gofordraw
		MOVEQ #0,D5			; CLIP ON XMIN
		SUB.W D0,D5			; xmin-x
		MOVE.W D3,D4
		SUB.W D1,D4			; y2-y1
		MULS D5,D4			; (xmin-x)*(y2-y1)
		MOVE.W D2,D5
		SUB.W D0,D5			; x2-x1
		DIVS D5,D4			; (xmin-x)*(y2-y1)/(x2-x1)
		ADD.W D4,D1
		MOVEQ #0,D0			; x=xmin

.gofordraw	MOVE.W D2,D4
		SUB.W D0,D4			; dx
		MOVE.W D3,D5
		SUB.W D1,D5			; dy
		ADD D2,D2
		ADD D2,D2
		MOVE.L (A2,D2),D6		; mask/chunk offset
		ADD D3,D3
		ADD (A3,D3),D6			; add scr line
		ADDA.W D6,A0			; a0 -> first chunk of line
		SWAP D6				; get mask
		MOVE.W #-160,D3
		TST.W D5			; draw from top to bottom?
		BGE.S bottotop
		NEG.W D5			; no so negate vals
		NEG.W D3
bottotop	CMP.W D4,D5			; dy>dx?
		BLT.S dxbiggerdy

; DY>DX Line drawing case

dybiggerdx	MOVE.W D5,D1			; yes!
		BEQ nodraw			; dy=0 nothing to draw(!)
		ASR.W #1,D1			; e=dy/2
		MOVE.W D5,D2
		SUBQ.W #1,D2			; lines to draw-1(dbf)
.lp		OR.W D6,(A0)
		ADDA.W D3,A0
		SUB.W D4,D1
		BGT.S .nostep
		ADD.W D5,D1
		ADD.W D6,D6
		DBCS D2,.lp
		BCC.S .drawn
		SUBQ.W #8,A0
		MOVEQ #1,D6
.nostep		DBF D2,.lp
.drawn		OR.W D6,(A0)
nodraw		RTS

; DX>DY Line drawing case

dxbiggerdy	CLR.W D2
		MOVE.W D4,D1
		ASR.W #1,D1			; e=dx/2
		MOVE.W D4,D0
		SUBQ.W #1,D0
.lp		OR.W D6,D2
		SUB.W D5,D1
		BGE.S .nostep
		OR.W D2,(A0)
		ADDA.W D3,A0
		ADD.W D4,D1
		CLR.W D2
.nostep		ADD.W D6,D6
		DBCS D0,.lp
		BCC.S .drawn
.wrchnk		OR.W D2,(A0)
		SUBQ.W #8,A0
		CLR.W D2
		MOVEQ #1,D6
		DBF D0,.lp
.drawn		OR.W D6,D2
		OR.W D2,(A0)
		RTS

i		SET 6
bit_offs	
		REPT 20
		DC.W $8000,i
		DC.W $4000,i
		DC.W $2000,i
		DC.W $1000,i
		DC.W $0800,i
		DC.W $0400,i
		DC.W $0200,i
		DC.W $0100,i
		DC.W $0080,i
		DC.W $0040,i
		DC.W $0020,i
		DC.W $0010,i
		DC.W $0008,i
		DC.W $0004,i
		DC.W $0002,i
		DC.W $0001,i
i		SET i+8
		ENDR


; My little vbl interrupt.

my_vbl		ADDQ #1,vbl_timer
		RTE

; Rout to clear the balls/ stars whatever...

clear_balls	MOVE.L log_base(PC),A0
		LEA bold_pos1(PC),A2		; assume case 1
		TST switch
		BNE.S .case_1
.case_2		LEA bold_pos2(PC),A2		; no its case 2!
.case_1		MOVE.W (A2)+,D7			; no of sprites to clear!
		SUBQ #1,D7
		BMI .out 
		MOVEQ #0,D0
		MOVEQ #0,D1
		MOVEQ #0,D2
		MOVEQ #0,D3
.starclear	MOVE.L A0,A1
		ADD.W (A2)+,A1
		MOVE.W (A2)+,D4
		ADD.W D4,D4
		JMP .jmpclear(PC,D4)
.jmpclear	MOVEM.L D0-D3,(A1)
		MOVEM.L D0-D3,160(A1)
		MOVEM.L D0-D3,320(A1)
		MOVEM.L D0-D3,480(A1)
		MOVEM.L D0-D3,640(A1)
		MOVEM.L D0-D3,800(A1)
		MOVEM.L D0-D3,960(A1)
		MOVEM.L D0-D3,1120(A1)
		MOVEM.L D0-D3,1280(A1)
		MOVEM.L D0-D3,1440(A1)
		MOVEM.L D0-D3,1600(A1)
		MOVEM.L D0-D3,1760(A1)
		MOVEM.L D0-D3,1920(A1)
		MOVEM.L D0-D3,2080(A1)
		MOVEM.L D0-D3,2240(A1)
		MOVEM.L D0-D3,2400(A1)
		DBF D7,.starclear
		RTS
		DS.W 64-(3*15)-2-3

		MOVEM.L D0-D3,160(A1)
		MOVEM.L D0-D3,320(A1)
		MOVEM.L D0-D3,480(A1)
		MOVEM.L D0-D3,640(A1)
		MOVEM.L D0-D3,800(A1)
		MOVEM.L D0-D3,960(A1)
		MOVEM.L D0-D3,1120(A1)
		MOVEM.L D0-D3,1280(A1)
		MOVEM.L D0-D3,1440(A1)
		MOVEM.L D0-D3,1600(A1)
		MOVEM.L D0-D3,1760(A1)
		MOVEM.L D0-D3,1920(A1)
		MOVEM.L D0-D3,2080(A1)
		MOVEM.L D0-D3,2240(A1)
		DBF D7,.starclear
		RTS
		DS.W 64-(3*14)-3

		MOVEM.L D0-D3,320(A1)
		MOVEM.L D0-D3,480(A1)
		MOVEM.L D0-D3,640(A1)
		MOVEM.L D0-D3,800(A1)
		MOVEM.L D0-D3,960(A1)
		MOVEM.L D0-D3,1120(A1)
		MOVEM.L D0-D3,1280(A1)
		MOVEM.L D0-D3,1440(A1)
		MOVEM.L D0-D3,1600(A1)
		MOVEM.L D0-D3,1760(A1)
		MOVEM.L D0-D3,1920(A1)
		MOVEM.L D0-D3,2080(A1)
		DBF D7,.starclear
		RTS
		DS.W 64-(3*12)-3

		MOVEM.L D0-D3,480(A1)
		MOVEM.L D0-D3,640(A1)
		MOVEM.L D0-D3,800(A1)
		MOVEM.L D0-D3,960(A1)
		MOVEM.L D0-D3,1120(A1)
		MOVEM.L D0-D3,1280(A1)
		MOVEM.L D0-D3,1440(A1)
		MOVEM.L D0-D3,1600(A1)
		MOVEM.L D0-D3,1760(A1)
		MOVEM.L D0-D3,1920(A1)
		DBF D7,.starclear
		RTS
		DS.W 64-(3*10)-3

		MOVEM.L D0-D3,640(A1)
		MOVEM.L D0-D3,800(A1)
		MOVEM.L D0-D3,960(A1)
		MOVEM.L D0-D3,1120(A1)
		MOVEM.L D0-D3,1280(A1)
		MOVEM.L D0-D3,1440(A1)
		MOVEM.L D0-D3,1600(A1)
		MOVEM.L D0-D3,1760(A1)
		DBF D7,.starclear
		RTS
		DS.W 64-(3*8)-3

		MOVEM.L D0-D3,800(A1)
		MOVEM.L D0-D3,960(A1)
		MOVEM.L D0-D3,1120(A1)
		MOVEM.L D0-D3,1280(A1)
		MOVEM.L D0-D3,1440(A1)
		MOVEM.L D0-D3,1600(A1)
		DBF D7,.starclear
		RTS
		DS.W 64-(3*6)-3

		MOVEM.L D0-D3,960(A1)
		MOVEM.L D0-D3,1120(A1)
		MOVEM.L D0-D3,1280(A1)
		MOVEM.L D0-D3,1440(A1)
		DBF D7,.starclear
		RTS
		DS.W 64-(3*4)-3

		MOVEM.L D0-D3,1120(A1)
		MOVEM.L D0-D3,1280(A1)
		DBF D7,.starclear
.out		RTS


; Initialisation and restore interrupt routs.

set_ints	move #$2700,sr
		lea old_stuff(pc),a0
		move.l $70.w,(a0)+
		lea my_vbl(pc),a1
		move.l a1,$70.w
		lea $fffffa00.w,a1
		movep.w 7(a1),d0
		move.w d0,(a0)+
		movep.w 13(a1),d0
		move.w d0,(a0)+
		moveq #0,d0
		movep.w d0,7(a1)
		movep.w d0,13(a1)
		move #$2300,sr
		bsr flush
		rts

rest_ints	move #$2700,sr
		lea old_stuff(pc),a0
		move.l (a0)+,$70.w
		lea $fffffa00.w,a1
		move.w (a0)+,d0
		movep.w d0,7(a1)
		move.w (a0)+,d0
		movep.w d0,13(a1)
		bsr flush
		move #$2300,sr
		rts

; Flush keyboard Buffer

flush		BTST.B #0,$FFFFFC00.W
		BEQ.S .flok
		MOVE.B $FFFFFC02.W,D0
		BRA.S flush
.flok		RTS

old_stuff	ds.l 10
old_cols	ds.w 16

; Allocate space for screens and clear them + make standard *160 table.

Initscreens	lea log_base(pc),a1
		move.l #screens+256,d0
		clr.b d0
		move.l d0,(a1)+
		add.l #42240,d0
		move.l d0,(a1)+
		move.l log_base(pc),a0
		bsr clear_screen
		move.l phy_base(pc),a0
		bsr clear_screen
		move.l log_base(pc),d0
		lsr #8,d0
		move.l d0,$ffff8200.w
		rts

; Clear screen ->A0

clear_screen	moveq #0,d0
		move #1999,d1
.cls		move.l d0,(a0)+
		move.l d0,(a0)+
		move.l d0,(a0)+
		move.l d0,(a0)+
		dbf d1,.cls
		rts

; Initialise Balls

Initballfield	BSR makeperstab
		BSR Makeballrouts
		BSR make160table
		BSR makexlookup
		RTS

; Rout to create the sprite routines (calls below rout)

makeperstab	LEA perstab,A0
		MOVEQ #0,D0
		MOVE.L #32767*350,D7
.mplp		MOVE.W D0,D1
		MOVE.L D7,D6
		ADD #350,D1
		DIVS D1,D6
		MOVE.W D6,(A0)+
		ADDQ #1,D0
		CMP #$1000,D0
		BNE.S .mplp
		RTS

; Create x lookup e.g for each 320 pixels (x and 15)*4 .W / chunk offset.

makexlookup	LEA ballxlookup,A0
		MOVEQ #0,D1
		MOVEQ #19,D0
.mkexlp1	MOVEQ #0,D3
		MOVEQ #15,D2
.mkexlp2	MOVE.W D3,(A0)+
		MOVE.W D1,(A0)+
		ADDQ #4,D3
		DBF D2,.mkexlp2
		ADDQ #8,D1
		DBF D0,.mkexlp1
		RTS

make160table	lea blmul_160(pc),a0		; create *160 lookup
		move #-32*160,d0
		move #231,d1
.lp		move.w d0,(a0)+
		add #160,d0
		dbf d1,.lp
		rts

; Rout to create the sprite routines (calls below rout)

Makeballrouts	LEA ball16,A0
		LEA shiftedball,A1
		LEA routs(PC),A6
		MOVEQ #7,D0
.lp		MOVE.L A0,Sprite_addr
		MOVEM.L D0/A0,-(SP)
		BSR Shift_sprite
		MOVEM.L (SP)+,D0/A0
		LEA 8*16(A0),A0
		DBF D0,.lp
		RTS

; Routine to shift a 4 plane sprite A1 -> to buffer for shifted sprite.
; Creates routine which is intelligently constructed.
; I reckon the code this now produces is about as optimum as possible!! 

Shift_sprite	MOVEA.L	Sprite_addr(PC),A2
		LEA data_buf(PC),A0
		MOVEQ #0,D0
		MOVEQ #spheight-1,D1
.moveto		MOVE.L (A2)+,(A0)+ 
		MOVE.L (A2)+,(A0)+ 
		MOVE.L D0,(A0)+
		MOVE.L D0,(A0)+
		DBF D1,.moveto
		MOVEQ #15,D0
Spr_Shift_lp	MOVE.W D0,-(SP)
		LEA data_buf(PC),A2
		MOVE.L A1,(A6)+
		MOVEQ #spheight-1,D6
		CLR D0
init_mask	MOVEQ #1,D7
.lp		MOVEM.L	(A2)+,D1-D2
		MOVE.L D1,D3		
		OR.L D2,D3			; 1+3/2+4
		MOVE.W D3,D5
		SWAP D3
		OR.W D3,D5 			; d5 has mask
		BNE.S .tisdata			; if not 0 we have sprite data
		ADDQ #8,D0			; otherwise skip chunk
		BRA .nextline
.tisdata	TST D0				; we have sprite data
		BEQ.S .noskip 					
		CMP #8,D0
		BNE.S .notquicky
		MOVE.W daddq8(PC),(A1)+
		BRA.S .reset
.notquicky	MOVE.W dlea(PC),(A1)+		; so if need be advance 
		MOVE.W D0,(A1)+			; scr ptr from previous
.reset		CLR D0				; misses and reset
.noskip		NOT.W D5
		BNE.S .needsmask		; zero mask do with 'moves'
		MOVE.W dmove2(PC),(A1)+
		MOVE.L D1,(A1)+
		MOVE.W dmove2(PC),(A1)+
		MOVE.L D2,(A1)+
		BRA .nextline
; Needs to be masksed
.needsmask	MOVE.W dmove1(PC),(A1)+ ;MOVE.L #$12345678,D0
		MOVE.W D5,(A1)+
		MOVE.W D5,(A1)+
.planes12	TST.L D1
		BNE.S .yespl12
		MOVE.W dand2(PC),(A1)+  ;AND.L D0,(A2)+
		BRA.S .planes34
.yespl12	CMP.L #127,D1
		BPL.S .norm12
		CMP.L #-128,D1
		BMI.S .norm12
		AND #$00FF,D1
		OR #$7200,D1		;MOVEQ #XX,D1
		MOVE.W dand1(PC),(A1)+  ;AND.L D0,(A2)
		MOVE.W D1,(A1)+
		MOVE.W dor1(PC),(A1)+
		BRA.S .planes34
.norm12		MOVE.W dand1(PC),(A1)+  ;AND.L D0,(A2)
		MOVE.W dor(PC),(A1)+	;OR.L #$12345678,(A2)+
		MOVE.L D1,(A1)+
.planes34	TST.L D2
		BNE.S .yespl34
		MOVE.W dand2(PC),(A1)+  ;AND.L D0,(A2)+
		BRA.S .nextline
.yespl34	CMP.L #127,D2
		BPL.S .norm34
		CMP.L #-128,D2
		BMI.S .norm34
		AND #$00FF,D2
		OR #$7200,D2		;MOVEQ #XX,D1
		MOVE.W dand1(PC),(A1)+  ;AND.L D0,(A2)
		MOVE.W D2,(A1)+
		MOVE.W dor1(PC),(A1)+
		BRA.S .nextline
.norm34		MOVE.W dand1(PC),(A1)+  ;AND.L D0,(A2)
		MOVE.W dor(PC),(A1)+	;OR.L #$12345678,(A2)+
		MOVE.L D2,(A1)+
.nextline	DBF D7,.lp
		ADD #160-16,D0
		DBF D6,init_mask
		MOVE drts(PC),(A1)+
		LEA data_buf(PC),A0
		MOVEQ #spheight-1,D1
shiftit		
		REPT 4
		LSR (A0)+
		ROXR 6(A0)
		ENDR
		LEA 8(A0),A0
		DBF D1,shiftit
		MOVE.W (SP)+,D0
		DBF D0,Spr_Shift_lp
		RTS

dmove1		MOVE.L #$12345678,D0
dmove2		MOVE.L #$12345678,(A2)+
dand1		AND.L D0,(A2)
dand2		AND.L D0,(A2)+
dor		OR.L #$12345678,(A2)+
dor1		OR.L D1,(A2)+
dlea		LEA 4(A2),A2
daddq4		ADDQ.W #4,A2
daddq8		ADDQ.W #8,A2
drts		RTS

Sprite_addr	DC.L 0
data_buf	DS.B spheight*16

waveptr1	dc.w 0
waveptr2	dc.w 0
waveptr3	dc.w 0


log_base 	DC.L 0
phy_base 	DC.L 0
switch		DS.W 1
vbl_timer	DS.W 1
angles		DS.W 3

ballpal1	dc.w	$000,$100,$200,$310,$420,$531,$642,$764
		dc.w	$700,$700,$700,$700,$700,$700,$700,$700

;
; Lookup tables for balls e.g screen offsets and preshift offsets.
;

routs		ds.l 16*8         ; (x and 15) rout ptrs for 8 sized balls
ballxlookup	ds.l 320	  ; x lookup 
blmul_160	ds.w 232	  ; *160 table + extra for clip.

; Standard Tables...

trig_tab	dc.w	$0000,$00C9,$0192,$025B,$0324,$03ED,$04B6,$057E 
		dc.w	$0647,$0710,$07D9,$08A1,$096A,$0A32,$0AFB,$0BC3 
		dc.w	$0C8B,$0D53,$0E1B,$0EE3,$0FAB,$1072,$1139,$1200 
		dc.w	$12C7,$138E,$1455,$151B,$15E1,$16A7,$176D,$1833 
		dc.w	$18F8,$19BD,$1A82,$1B46,$1C0B,$1CCF,$1D93,$1E56 
		dc.w	$1F19,$1FDC,$209F,$2161,$2223,$22E4,$23A6,$2467 
		dc.w	$2527,$25E7,$26A7,$2767,$2826,$28E5,$29A3,$2A61 
		dc.w	$2B1E,$2BDB,$2C98,$2D54,$2E10,$2ECC,$2F86,$3041 
		dc.w	$30FB,$31B4,$326D,$3326,$33DE,$3496,$354D,$3603 
		dc.w	$36B9,$376F,$3824,$38D8,$398C,$3A3F,$3AF2,$3BA4 
		dc.w	$3C56,$3D07,$3DB7,$3E67,$3F16,$3FC5,$4073,$4120 
		dc.w	$41CD,$4279,$4325,$43D0,$447A,$4523,$45CC,$4674 
		dc.w	$471C,$47C3,$4869,$490E,$49B3,$4A57,$4AFA,$4B9D 
		dc.w	$4C3F,$4CE0,$4D80,$4E20,$4EBF,$4F5D,$4FFA,$5097 
		dc.w	$5133,$51CE,$5268,$5301,$539A,$5432,$54C9,$555F 
		dc.w	$55F4,$5689,$571D,$57B0,$5842,$58D3,$5963,$59F3 
		dc.w	$5A81,$5B0F,$5B9C,$5C28,$5CB3,$5D3D,$5DC6,$5E4F 
		dc.w	$5ED6,$5F5D,$5FE2,$6067,$60EB,$616E,$61F0,$6271 
		dc.w	$62F1,$6370,$63EE,$646B,$64E7,$6562,$65DD,$6656 
		dc.w	$66CE,$6745,$67BC,$6831,$68A5,$6919,$698B,$69FC 
		dc.w	$6A6C,$6ADB,$6B4A,$6BB7,$6C23,$6C8E,$6CF8,$6D61 
		dc.w	$6DC9,$6E30,$6E95,$6EFA,$6F5E,$6FC0,$7022,$7082 
		dc.w	$70E1,$7140,$719D,$71F9,$7254,$72AE,$7306,$735E 
		dc.w	$73B5,$740A,$745E,$74B1,$7503,$7554,$75A4,$75F3 
		dc.w	$7640,$768D,$76D8,$7722,$776B,$77B3,$77F9,$783F 
		dc.w	$7883,$78C6,$7908,$7949,$7989,$79C7,$7A04,$7A41 
		dc.w	$7A7C,$7AB5,$7AEE,$7B25,$7B5C,$7B91,$7BC4,$7BF7 
		dc.w	$7C29,$7C59,$7C88,$7CB6,$7CE2,$7D0E,$7D38,$7D61 
		dc.w	$7D89,$7DB0,$7DD5,$7DF9,$7E1C,$7E3E,$7E5E,$7E7E 
		dc.w	$7E9C,$7EB9,$7ED4,$7EEF,$7F08,$7F20,$7F37,$7F4C 
		dc.w	$7F61,$7F74,$7F86,$7F96,$7FA6,$7FB4,$7FC1,$7FCD 
		dc.w	$7FD7,$7FE0,$7FE8,$7FEF,$7FF5,$7FF9,$7FFC,$7FFE 
		dc.w	$7FFF,$7FFE,$7FFC,$7FF9,$7FF5,$7FEF,$7FE8,$7FE0 
		dc.w	$7FD7,$7FCD,$7FC1,$7FB4,$7FA6,$7F96,$7F86,$7F74 
		dc.w	$7F61,$7F4C,$7F37,$7F20,$7F08,$7EEF,$7ED4,$7EB9 
		dc.w	$7E9C,$7E7E,$7E5E,$7E3E,$7E1C,$7DF9,$7DD5,$7DB0 
		dc.w	$7D89,$7D61,$7D38,$7D0E,$7CE2,$7CB6,$7C88,$7C59 
		dc.w	$7C29,$7BF7,$7BC4,$7B91,$7B5C,$7B25,$7AEE,$7AB5 
		dc.w	$7A7C,$7A41,$7A04,$79C7,$7989,$7949,$7908,$78C6 
		dc.w	$7883,$783F,$77F9,$77B3,$776B,$7722,$76D8,$768D 
		dc.w	$7640,$75F3,$75A4,$7554,$7503,$74B1,$745E,$740A 
		dc.w	$73B5,$735E,$7306,$72AE,$7254,$71F9,$719D,$7140 
		dc.w	$70E1,$7082,$7022,$6FC0,$6F5E,$6EFA,$6E95,$6E30 
		dc.w	$6DC9,$6D61,$6CF8,$6C8E,$6C23,$6BB7,$6B4A,$6ADB 
		dc.w	$6A6C,$69FC,$698B,$6919,$68A5,$6831,$67BC,$6745 
		dc.w	$66CE,$6656,$65DD,$6562,$64E7,$646B,$63EE,$6370 
		dc.w	$62F1,$6271,$61F0,$616E,$60EB,$6067,$5FE2,$5F5D 
		dc.w	$5ED6,$5E4F,$5DC6,$5D3D,$5CB3,$5C28,$5B9C,$5B0F 
		dc.w	$5A81,$59F3,$5963,$58D3,$5842,$57B0,$571D,$5689 
		dc.w	$55F4,$555F,$54C9,$5432,$539A,$5301,$5268,$51CE 
		dc.w	$5133,$5097,$4FFA,$4F5D,$4EBF,$4E20,$4D80,$4CE0 
		dc.w	$4C3F,$4B9D,$4AFA,$4A57,$49B3,$490E,$4869,$47C3 
		dc.w	$471C,$4674,$45CC,$4523,$447A,$43D0,$4325,$4279 
		dc.w	$41CD,$4120,$4073,$3FC5,$3F16,$3E67,$3DB7,$3D07 
		dc.w	$3C56,$3BA4,$3AF2,$3A3F,$398C,$38D8,$3824,$376F 
		dc.w	$36B9,$3603,$354D,$3496,$33DE,$3326,$326D,$31B4 
		dc.w	$30FB,$3041,$2F86,$2ECC,$2E10,$2D54,$2C98,$2BDB 
		dc.w	$2B1E,$2A61,$29A3,$28E5,$2826,$2767,$26A7,$25E7 
		dc.w	$2527,$2467,$23A6,$22E4,$2223,$2161,$209F,$1FDC 
		dc.w	$1F19,$1E56,$1D93,$1CCF,$1C0B,$1B46,$1A82,$19BD 
		dc.w	$18F8,$1833,$176D,$16A7,$15E1,$151B,$1455,$138E 
		dc.w	$12C7,$1200,$1139,$1072,$0FAB,$0EE3,$0E1B,$0D53 
		dc.w	$0C8B,$0BC3,$0AFB,$0A32,$096A,$08A1,$07D9,$0710 
		dc.w	$0647,$057E,$04B6,$03ED,$0324,$025B,$0192,$00C9 
		dc.w	$0000,$FF37,$FE6E,$FDA5,$FCDC,$FC13,$FB4A,$FA82 
		dc.w	$F9B9,$F8F0,$F827,$F75F,$F696,$F5CE,$F505,$F43D 
		dc.w	$F375,$F2AD,$F1E5,$F11D,$F055,$EF8E,$EEC7,$EE00 
		dc.w	$ED39,$EC72,$EBAB,$EAE5,$EA1F,$E959,$E893,$E7CD 
		dc.w	$E708,$E643,$E57E,$E4BA,$E3F5,$E331,$E26D,$E1AA 
		dc.w	$E0E7,$E024,$DF61,$DE9F,$DDDD,$DD1C,$DC5A,$DB99 
		dc.w	$DAD9,$DA19,$D959,$D899,$D7DA,$D71B,$D65D,$D59F 
		dc.w	$D4E2,$D425,$D368,$D2AC,$D1F0,$D134,$D07A,$CFBF 
		dc.w	$CF05,$CE4C,$CD93,$CCDA,$CC22,$CB6A,$CAB3,$C9FD 
		dc.w	$C947,$C891,$C7DC,$C728,$C674,$C5C1,$C50E,$C45C 
		dc.w	$C3AA,$C2F9,$C249,$C199,$C0EA,$C03B,$BF8D,$BEE0 
		dc.w	$BE33,$BD87,$BCDB,$BC30,$BB86,$BADD,$BA34,$B98C 
		dc.w	$B8E4,$B83D,$B797,$B6F2,$B64D,$B5A9,$B506,$B463 
		dc.w	$B3C1,$B320,$B280,$B1E0,$B141,$B0A3,$B006,$AF69 
		dc.w	$AECD,$AE32,$AD98,$ACFF,$AC66,$ABCE,$AB37,$AAA1 
		dc.w	$AA0C,$A977,$A8E3,$A850,$A7BE,$A72D,$A69D,$A60D 
		dc.w	$A57F,$A4F1,$A464,$A3D8,$A34D,$A2C3,$A23A,$A1B1 
		dc.w	$A12A,$A0A3,$A01E,$9F99,$9F15,$9E92,$9E10,$9D8F 
		dc.w	$9D0F,$9C90,$9C12,$9B95,$9B19,$9A9E,$9A23,$99AA 
		dc.w	$9932,$98BB,$9844,$97CF,$975B,$96E7,$9675,$9604 
		dc.w	$9594,$9525,$94B6,$9449,$93DD,$9372,$9308,$929F 
		dc.w	$9237,$91D0,$916B,$9106,$90A2,$9040,$8FDE,$8F7E 
		dc.w	$8F1F,$8EC0,$8E63,$8E07,$8DAC,$8D52,$8CFA,$8CA2 
		dc.w	$8C4B,$8BF6,$8BA2,$8B4F,$8AFD,$8AAC,$8A5C,$8A0D 
		dc.w	$89C0,$8973,$8928,$88DE,$8895,$884D,$8807,$87C1 
		dc.w	$877D,$873A,$86F8,$86B7,$8677,$8639,$85FC,$85BF 
		dc.w	$8584,$854B,$8512,$84DB,$84A4,$846F,$843C,$8409 
		dc.w	$83D7,$83A7,$8378,$834A,$831E,$82F2,$82C8,$829F 
		dc.w	$8277,$8250,$822B,$8207,$81E4,$81C2,$81A2,$8182 
		dc.w	$8164,$8147,$812C,$8111,$80F8,$80E0,$80C9,$80B4 
		dc.w	$809F,$808C,$807A,$806A,$805A,$804C,$803F,$8033 
		dc.w	$8029,$8020,$8018,$8011,$800B,$8007,$8004,$8002 
		dc.w	$8001,$8002,$8004,$8007,$800B,$8011,$8018,$8020 
		dc.w	$8029,$8033,$803F,$804C,$805A,$806A,$807A,$808C 
		dc.w	$809F,$80B4,$80C9,$80E0,$80F8,$8111,$812C,$8147 
		dc.w	$8164,$8182,$81A2,$81C2,$81E4,$8207,$822B,$8250 
		dc.w	$8277,$829F,$82C8,$82F2,$831E,$834A,$8378,$83A7 
		dc.w	$83D7,$8409,$843C,$846F,$84A4,$84DB,$8512,$854B 
		dc.w	$8584,$85BF,$85FC,$8639,$8677,$86B7,$86F8,$873A 
		dc.w	$877D,$87C1,$8807,$884D,$8895,$88DE,$8928,$8973 
		dc.w	$89C0,$8A0D,$8A5C,$8AAC,$8AFD,$8B4F,$8BA2,$8BF6 
		dc.w	$8C4B,$8CA2,$8CFA,$8D52,$8DAC,$8E07,$8E63,$8EC0 
		dc.w	$8F1F,$8F7E,$8FDE,$9040,$90A2,$9106,$916B,$91D0 
		dc.w	$9237,$929F,$9308,$9372,$93DD,$9449,$94B6,$9525 
		dc.w	$9594,$9604,$9675,$96E7,$975B,$97CF,$9844,$98BB 
		dc.w	$9932,$99AA,$9A23,$9A9E,$9B19,$9B95,$9C12,$9C90 
		dc.w	$9D0F,$9D8F,$9E10,$9E92,$9F15,$9F99,$A01E,$A0A3 
		dc.w	$A12A,$A1B1,$A23A,$A2C3,$A34D,$A3D8,$A464,$A4F1 
		dc.w	$A57F,$A60D,$A69D,$A72D,$A7BE,$A850,$A8E3,$A977 
		dc.w	$AA0C,$AAA1,$AB37,$ABCE,$AC66,$ACFF,$AD98,$AE32 
		dc.w	$AECD,$AF69,$B006,$B0A3,$B141,$B1E0,$B280,$B320 
		dc.w	$B3C1,$B463,$B506,$B5A9,$B64D,$B6F2,$B797,$B83D 
		dc.w	$B8E4,$B98C,$BA34,$BADD,$BB86,$BC30,$BCDB,$BD87 
		dc.w	$BE33,$BEE0,$BF8D,$C03B,$C0EA,$C199,$C249,$C2F9 
		dc.w	$C3AA,$C45C,$C50E,$C5C1,$C674,$C728,$C7DC,$C891 
		dc.w	$C947,$C9FD,$CAB3,$CB6A,$CC22,$CCDA,$CD93,$CE4C 
		dc.w	$CF05,$CFBF,$D07A,$D134,$D1F0,$D2AC,$D368,$D425 
		dc.w	$D4E2,$D59F,$D65D,$D71B,$D7DA,$D899,$D959,$DA19 
		dc.w	$DAD9,$DB99,$DC5A,$DD1C,$DDDD,$DE9F,$DF61,$E024 
		dc.w	$E0E7,$E1AA,$E26D,$E331,$E3F5,$E4BA,$E57E,$E643 
		dc.w	$E708,$E7CD,$E893,$E959,$EA1F,$EAE5,$EBAB,$EC72 
		dc.w	$ED39,$EE00,$EEC7,$EF8E,$F055,$F11D,$F1E5,$F2AD 
		dc.w	$F375,$F43D,$F505,$F5CE,$F696,$F75F,$F827,$F8F0 
		dc.w	$F9B9,$FA82,$FB4A,$FC13,$FCDC,$FDA5,$FE6E,$FF37 
		dc.w	$0000,$00C9,$0192,$025B,$0324,$03ED,$04B6,$057E 
		dc.w	$0647,$0710,$07D9,$08A1,$096A,$0A32,$0AFB,$0BC3 
		dc.w	$0C8B,$0D53,$0E1B,$0EE3,$0FAB,$1072,$1139,$1200 
		dc.w	$12C7,$138E,$1455,$151B,$15E1,$16A7,$176D,$1833 
		dc.w	$18F8,$19BD,$1A82,$1B46,$1C0B,$1CCF,$1D93,$1E56 
		dc.w	$1F19,$1FDC,$209F,$2161,$2223,$22E4,$23A6,$2467 
		dc.w	$2527,$25E7,$26A7,$2767,$2826,$28E5,$29A3,$2A61 
		dc.w	$2B1E,$2BDB,$2C98,$2D54,$2E10,$2ECC,$2F86,$3041 
		dc.w	$30FB,$31B4,$326D,$3326,$33DE,$3496,$354D,$3603 
		dc.w	$36B9,$376F,$3824,$38D8,$398C,$3A3F,$3AF2,$3BA4 
		dc.w	$3C56,$3D07,$3DB7,$3E67,$3F16,$3FC5,$4073,$4120 
		dc.w	$41CD,$4279,$4325,$43D0,$447A,$4523,$45CC,$4674 
		dc.w	$471C,$47C3,$4869,$490E,$49B3,$4A57,$4AFA,$4B9D 
		dc.w	$4C3F,$4CE0,$4D80,$4E20,$4EBF,$4F5D,$4FFA,$5097 
		dc.w	$5133,$51CE,$5268,$5301,$539A,$5432,$54C9,$555F 
		dc.w	$55F4,$5689,$571D,$57B0,$5842,$58D3,$5963,$59F3 
		dc.w	$5A81,$5B0F,$5B9C,$5C28,$5CB3,$5D3D,$5DC6,$5E4F 
		dc.w	$5ED6,$5F5D,$5FE2,$6067,$60EB,$616E,$61F0,$6271 
		dc.w	$62F1,$6370,$63EE,$646B,$64E7,$6562,$65DD,$6656 
		dc.w	$66CE,$6745,$67BC,$6831,$68A5,$6919,$698B,$69FC 
		dc.w	$6A6C,$6ADB,$6B4A,$6BB7,$6C23,$6C8E,$6CF8,$6D61 
		dc.w	$6DC9,$6E30,$6E95,$6EFA,$6F5E,$6FC0,$7022,$7082 
		dc.w	$70E1,$7140,$719D,$71F9,$7254,$72AE,$7306,$735E 
		dc.w	$73B5,$740A,$745E,$74B1,$7503,$7554,$75A4,$75F3 
		dc.w	$7640,$768D,$76D8,$7722,$776B,$77B3,$77F9,$783F 
		dc.w	$7883,$78C6,$7908,$7949,$7989,$79C7,$7A04,$7A41 
		dc.w	$7A7C,$7AB5,$7AEE,$7B25,$7B5C,$7B91,$7BC4,$7BF7 
		dc.w	$7C29,$7C59,$7C88,$7CB6,$7CE2,$7D0E,$7D38,$7D61 
		dc.w	$7D89,$7DB0,$7DD5,$7DF9,$7E1C,$7E3E,$7E5E,$7E7E 
		dc.w	$7E9C,$7EB9,$7ED4,$7EEF,$7F08,$7F20,$7F37,$7F4C 
		dc.w	$7F61,$7F74,$7F86,$7F96,$7FA6,$7FB4,$7FC1,$7FCD 
		dc.w	$7FD7,$7FE0,$7FE8,$7FEF,$7FF5,$7FF9,$7FFC,$7FFE 

ball16		incbin vect.inc\balls16.spr

;------------------------------------------------------------------------;

obj_ptr		dc.l WaveyGrid

		include vect.inc\wavegrid.s  ; WaveyGrid,WaveyGrid2
		;include d:\3d.S\vectball.s\vect.inc\boxs.s     ; box,box2
		;include d:\3d.S\vectball.s\vect.inc\grid7by7.s ; grid7by7
		;include d:\3d.S\vectball.s\vect.inc\cube5.s     ; Cube5
		;include g:\3d.S\vectball.s\vect.inc\coolship.s     ; coolship

		SECTION BSS
sort_table	DS.B max_points*obsize
bold_pos1	DS.L max_points
bold_pos2	DS.L max_points
translated	DS.W max_points*3
		DS.L 299
stack		DS.L 2
		DS.B 17*160
screens		DS.B 256
		DS.B 42240
		DS.B 42240
		DS.B 256
		DS.B 17*160
perstab		DS.W $1001
shiftedball	
