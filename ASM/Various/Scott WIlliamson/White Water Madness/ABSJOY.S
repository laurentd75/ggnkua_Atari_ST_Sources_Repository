; WWM JOYSTICK HANDLER                                  7/25

        DATA
;                       ***** JOY HANDLER KBD COMMANDS *****
        ALIGN
accel:      ; ACCELERATION TABLE
  dc.w -2,-2,-2,-1
  dc.w 0,1,2,2,2,2,2,1,0,-1,-2,-2,-2,-2,-2,-1
;JOY  1      DIR    0
;    5 9          14 2
;   4   8        12   4
;    6 10         10 6
;     2             8
DIRTAB:                          ; DIRECTION TABLE
        DC.W 0,0,8,0,12,14,10,0,4,2,6,0,0,0,0,0

        TEXT
;       ***** JOYSTIC HANDLER (MAINLINE) *****
ABSJOY:
        MOVE.B  JOY1,D0         ; GET JOY VAL
        AND     #$F,D0          ; MASK OFF UNWANTED INFO
        BEQ     NOJOY           ; JOY IS STILL - SKIP MOVEMENT
        LSL     #1,D0           ; MULT FOR WORD BOUNDRY
        LEA     DIRTAB,A0       ; LOOKUP DIRECTION
        MOVE    0(A0,D0.W),D0   ;
        SUB     SHIPDIR,D0      ; (JOY-DIRECTION)&$F
        AND     #$F,D0
        BEQ     AFTERCCW        ; 0 SAME DIRECTION
        CMP     #8,D0
        BLT     CW              ; <8 CLOCKWISE
CCW:    SUBQ    #1,SHIPDIR      ; >=8 COUNTERCLOCKWISE
        BRA     AFTERCCW
CW:     ADDQ    #1,SHIPDIR
AFTERCCW:
        AND     #$F,SHIPDIR     ; MASK OF UNWANTED SH*T
  lea accel,a0          ; accel table
  move SHIPDIR,d0     ; get direction
  lsl #1,d0             ; ofset for word lookup
  move (a0,d0.w),d1     ; get y accel
  move d1,SHIPvy             ; and adjust velocity
  move 8(a0,d0.w),d1    ; get x accel
  move d1,SHIPvx
                        ; boundry check velocity
maxvel = 2              ; maximum velocity
  cmp #maxvel,SHIPvy        ; going up too fast?
  ble notfastup
  move #maxvel,SHIPvy
  bra chkxvel
notfastup:
  cmp #-maxvel,SHIPvy       ; going down too fast?
  bge notfastdown
  move #-maxvel,SHIPvy
notfastdown:
chkxvel:
  cmp #maxvel,SHIPvx        ; going right too fast?
  ble notfastright
  move #maxvel,SHIPvx
  bra velchkd
notfastright:
  cmp #-maxvel,SHIPvx       ; going left too fast?
  bge notfastleft
  move #-maxvel,SHIPvx
notfastleft:
velchkd:
  bra endfric
NOJOY:                  ; end processing of joystick

  tst.w SHIPvx              ; account for horiz friction
  beq vertfric          ; no movement no friction
  bmi leftfric          ; check direction
  sub #1,SHIPvx
  bra vertfric
leftfric:
  add #1,SHIPvx
vertfric:
  tst.w SHIPvy              ; account for vert friction
  beq endfric           ; no movement no friction
  bmi upfric            ; check direction
  sub #1,SHIPvy
  bra endfric
upfric:
  add #1,SHIPvy
endfric:

  move SHIPvx,d0
  add d0,SHIPx              ; actually move ship
  move SHIPvy,d0
  add d0,SHIPy

        MOVE    WINDY,D0        ; OFF TOP OF SCREEN?
        CMP     SHIPY,D0
        BLE     CHKSHPBOT
        MOVE    D0,SHIPY
        BRA     DONECHKSHPY
CHKSHPBOT:
        ADD     #(WINDH-1)*16,D0    ; OFF BOTTOM?
        CMP     SHIPY,D0
        BGE     DONECHKSHPY
        MOVE    D0,SHIPY
DONECHKSHPY:

        RTS
        END
 