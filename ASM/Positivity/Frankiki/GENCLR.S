;**********************
;****    GENCLR    ****
;**********************
;IN   a0=@WhereToGenerateRoutine
;     a1=@Sprite, 2bpl (starting with SpriteWidth.w , SpriteHeight.w)
;     SpriteWidth must be a multiple of 16
;OUT  a0 points after generated routine
;     KILLS d0-d5/a0-a1
;Generated routine is called with a0=@drawing, a1=@return, d0=0

;Alain Brobecker - April 2010
GENCLR
  move.w      (a1)+,d0      ;d0=SpriteWidth (must be a multiple of 16)
  move.w      (a1)+,d1      ;d1=SpriteHeight
  moveq.l     #0,d5         ;d5=displacement to line
GENCLR_Line  
  move.l      d5,d2         ;d2=disp16
  move.w      d0,d6         ;d6=SpriteWidth
GENCLR_Word
  move.w      (a1)+,d3      ;d3.w=0 
  move.w      (a1)+,d4      ;d4.w=0
  tst.w       d3
  beq.s       GENCLR_bpl0_is_0
  tst.w       d4
  beq.s       GENCLR_bpl0_not_0_bpl1_is_0
;**** bpl0!=0 AND bpl1!=0 
  tst.w       d2            ;disp16=0?
  beq.s       GENCLR_bpl0_not_0_bpl1_not_0_disp16_is_0
  move.w      #$2140,(a0)+  ;16 "move.l d0,disp16(a0)" + disp16
  move.w      d2,(a0)+  
  bra.s       GENCLR_NextWord
  
GENCLR_bpl0_not_0_bpl1_not_0_disp16_is_0
  move.w      #$2080,(a0)+  ;12 "move.l d0,(a0)"
  bra.s       GENCLR_NextWord
  
;**** bpl0=0
GENCLR_bpl0_is_0
  tst.w       d4
  beq.s       GENCLR_NextWord
  move.w      #$3140,(a0)+  ;12 "move.w d0,disp16+2(a0)"
  move.w      d2,(a0)
  addq.w      #2,(a0)+
  bra.s       GENCLR_NextWord
    
;**** bpl0!=0 but bpl1=0
GENCLR_bpl0_not_0_bpl1_is_0
  tst.w       d2            ;disp16=0?
  beq.s       GENCLR_bpl0_not_0_bpl1_is_0_disp16_is_0
  move.w      #$3140,(a0)+  ;16 "move.w d0,disp16(a0)" + disp16
  move.w      d2,(a0)+  
  bra.s       GENCLR_NextWord

GENCLR_bpl0_not_0_bpl1_is_0_disp16_is_0
  move.w      #$3080,(a0)+  ; 8 "move.w d0,(a0)"
;  bra.s       GENCLR_NextWord

GENCLR_NextWord
  addq.w      #8,d2         ;disp16+=8
  sub.w       #16,d6        ;pixels left?
  bne.s       GENCLR_Word
  add.w       #160,d5       ;displacement to line+=160
  subq.w      #1,d1         ;Lines left?
  bne.s       GENCLR_Line
  
  move.w      #$4ed1,(a0)+ ;"jmp (a1)"
  rts
