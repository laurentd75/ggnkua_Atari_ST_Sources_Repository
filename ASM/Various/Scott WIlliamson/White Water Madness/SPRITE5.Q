;
; FILE - SPRITE5.ASM
; DEFINE SECTIONS FOR STLINK
;
;*******START OF TEXT AREA
;
     TEXT

;------------------------------------------------------------------------------
;                DRAW SPRITE
;    IN    D0 LONGWORD = SPRITE #
;------------------------------------------------------------------------------
;
DRAWSP:
    LEA     SHIPFLG,A0
    ADDA.L  D0,A0
    CMPI.B   #0,(A0)
    BEQ     DRAWSPOUT
;
    LSL.W    #4,D0            ;*32
    LEA    SPPARM,A0
    ADDA.L    D0,A0
;
    MOVE.L   A1,-(SP)
    CLR.L    D0
    MOVE.W    YCORD(A0),D0        ;GET YCORD
    ADD      #(VBUF*16),D0   ;ACCOUNT FOR VERT BORDER
    MOVE     WINDY,D1
    AND      #$FFF0,D1
    SUB      D1,D0
    MULU     #((WINDW+1+(HBUF*2))*8),D0     ;LINE LEN
;VERT CLIPPING
    CMP      #(((WINDW+1+(HBUF*2))*128)*(WINDH+1+VBUF)),D0
                              ;ONLY ALLOW THE RANGE FROM
    BHI      NODRAWSP         ;0 TO THE BOTTOM
    ADDA.L   D0,A1
;
    MOVE.W    XCORD(A0),D0        ;GET XCORD
    ADD       #(HBUF*16),D0       ;ACCOUNT FOR BORDER
    MOVE      WINDX,D1
    AND      #$FFF0,D1
    SUB      D1,D0
    AND.L    #$FFF0,D0        ;AND OFF THE OFFSET
    LSR.W    #1,D0            ;DIVIDE BY 16 * 8 BYTES (EFFECTS /2)
; HORIZ CLIPPING
    CMP      #((WINDW+1+HBUF)*8),D0
                              ;ONLY ALLOW THE RANGE FROM 0 TO THE
    BHI      NODRAWSP         ;RIGHT SIDE

    ADD.L    D0,A1            ;A1 = SCREEN ADR
;
    CLR.L    D0
    MOVE.L   SPADR(A0),A2        ;GET ADR OF SPRITE DATA
    MOVE.B   ANIMSEQ(A0),D0       ;CURRENT ANIMATION SEQUENCE #
    MULU     SPSIZE(A0),D0        ; * TOTAL BYTE SIZE OF SPRITE
    ADDA.L    D0,A2            ;ADD OFFSET TO SPRITE DATA ADR
;
    CLR.L    D3
    MOVE.W   SPLENGTH(A0),D3        ;GET SPRITE Y SIZE (LENGTH -1)
;
    MOVE.W   XCORD(A0),D2        ;ANY X OFFSET?
    AND.L    #$0F,D2
    BNE      SPH4            ;YES. SHIFTING REQUIRED
;
;        HERE IF SPRITE ON EVEN WORD BOUNDRY
;
SPH1:
    MOVE.L    A1,A4            ;GET SCREEN PTR
    MOVE.W    SPWIDTH(A0),D0            ;GET SPRITE WIDTH (WORD SIZE)
    SUBQ.B    #1,D0            ;LESS 1 FOR MINUS LOOP
SPH2:
    MOVE.W    (A2),D6
    OR.W     2(A2),D6
    OR.W     4(A2),D6
    OR.W     6(A2),D6
    NOT    D6
    MOVEQ    #4-1,D1            ;4 PLANES
SPH3:
    MOVE.W    (A4),D2
    AND.W    D6,D2
    OR.W    (A2)+,D2
    MOVE.W    D2,(A4)+
    DBF    D1,SPH3            ;COUNT OFF 4 PLANES
    DBF    D0,SPH2            ;NEXT SPRITE IMAGE WORD
    ADDA.L    #((WINDW+1+(HBUF*2))*8),A1     ;ADD FOR NEXT SCAN LINE
    DBF    D3,SPH1            ;COUNT OFF SPRITE LENGTH
NODRAWSP:
    MOVE.L    (SP)+,A1        ;RECOVER A1
DRAWSPOUT:
    RTS                       ;DONE
;
;        HERE IF DATA NEEDS TO BE SHIFTED
;
SPH4:
    MOVE.L    A1,A4            ;GET SCREEN PTR
    MOVE.W    SPWIDTH(A0),D0        ;GET SPRITE WIDTH
    SUBQ    #1,D0            ;LESS 1 FOR MINUS LOOP COUNT
;
SPH6:
    CLR.L    D6
    MOVE.W    (A2),D6            ;MAKE SPRITE MASK
    OR.W    2(A2),D6
    OR.W    4(A2),D6
    OR.W    6(A2),D6
    SWAP    D6
    LSR.L    D2,D6            ;SHIFT IT
    NOT.L    D6
    MOVE.W    D6,D7
    SWAP    D6
;
    MOVEQ    #4-1,D1            ;4 PLANES
SPH7:
    CLR.L    D4
    MOVE.W    (A2)+,D4
    SWAP    D4
    LSR.L    D2,D4            ;SHIFT SPRITE DATA
    MOVE.W    D4,D5
    SWAP    D4
    AND.W    D6,(A4)            ;AND MASK WITH SCREEN DATA
    OR.W    D4,(A4)+        ;OR IN 1ST PART OF SPRITE
    AND.W    D7,6(A4)        ;AND MASK WITH SCREEN DATA
    OR.W    D5,6(A4)        ;OR IN 2ND PART OF SPRITE
    DBF    D1,SPH7
    DBF    D0,SPH6
;
    ADDA.L    #((WINDW+1+(HBUF*2))*8),A1     ;ADD FOR NEXT SCAN LINE
    DBF    D3,SPH4
    MOVE.L   (SP)+,A1       ;RECOVER SCREENBASE
    RTS                ;DONE


;------------------------------------------------------------------------------
;                GET SPRITE PARAMETER TABLE
;    IN    D0=SPRITE NUMBER
;    OUT    A0 POINTS TO SPRITE PARMAMETER TABLE
;------------------------------------------------------------------------------
;
GETSPARM:
    LSL.W    #4,D0        ;*32
    LEA    SPPARM,A0
    ADDA.L    D0,A0
    RTS
    END
 