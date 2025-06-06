;  **********************************************************
;  *        LETHERNECK-MUSIC, COMPOSED BY DAVID.W           *
;  *    RIPPED BY THE DISK BUSTER OF THE MAGIC HACKERS      *
;  **********************************************************
;
 MOVE.L A7,A5
 MOVE.L 4(A5),A5
 MOVE.L $C(A5),D0
 ADD.L $14(A5),D0
 ADD.L $1C(A5),D0
 ADD.L #$1100,D0
 MOVE.L A5,D1
 ADD.L D0,D1
 AND.L #-2,D1
 MOVE.L D1,A7
 MOVE.L D0,-(SP)
 MOVE.L A5,-(SP)
 MOVE.W D0,-(SP)
 MOVE.W #$4A,-(SP) ; Setblock.
 TRAP #1
 ADD.L #12,SP
;
 CLR.L -(SP)       ; Enter supervisor mode.
 MOVE.W #$20,-(SP) ; Super.
 TRAP #1
 ADDQ.L #6,SP
 MOVE.L D0,SUPER   ; Save old status.
KEYREAD:
 MOVE.W #7,-(SP)
 TRAP #1
 ADDQ.L #2,SP
 CMP.B #$31,D0
 BEQ TUNE1
 CMP.B #$32,D0
 BEQ TUNE2
 CMP.B #$33,D0
 BEQ TUNE3
 BRA KEYREAD
TUNE1: MOVEQ #0,D0
 BRA START
TUNE2: MOVEQ #1,D0
 BRA START
TUNE3: MOVEQ #2,D0
START:
 JSR MUSIC
 MOVE.L #MUSIC+294,$4D2
 MOVE.L SUPER,-(SP)
 MOVE.W #$20,-(SP)
 TRAP #1
 ADDQ.L #6,SP
 MOVE.W #0,-(SP)
 MOVE.L #1024*6,-(SP)
 MOVE.W #$31,-(SP)
 TRAP #1
 ALIGN
MUSIC: IBYTES A:\MUSIX\L
 ALIGN
SUPER: DC.L 0
 END

 