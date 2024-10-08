;       FADERS - WHITEINS, WHITEOUTS, FADEINS, & FADEOUTS FOR WWM
FADER:  ; GIVEN THE ORIGINAL PALETTE ADR IN A0, THE NEW ONE IN A1
        ; AND A VALUE FROM 0-15 IN D0 FADER WILL FILL THE NEW PALETTE
        ; 0 BEING NORMAL & 15 BEING BLACK
        MOVE    #16-1,D1        ; 16 COLOR REGS
NEXTCOLOR:
        MOVE    (A0)+,D2        ; GET COLOR
        MOVE    #3-1,D6         ; 3 BEAMS
        CLR     D5              ; WORK REG
        CLR     D4              ; ROT REG
NEXTBEAM:
        MOVE.B  D2,D3           ; GET BYTE
        AND.B   #$F,D3          ; MASK OFF OTHER COL
        LSL.B   #1,D3           ; ACCOUNT FOR SCREWED UP COLOUR BIT
        BTST    #4,D3
        BEQ     NOLOWCOLBIT1
        BSET    #0,D3
NOLOWCOLBIT1:
        AND     #$F,D3
        SUB.B   D0,D3           ; SUBTRACT D0
        BGE     NOTNEG
        CLR.B   D3              ; IF NEGATIVE MAKE 0
NOTNEG:
        MOVE    #0,CCR          ; FIX FOR SCREWED UP COLOR REG
        LSR.B   #1,D3
        BCC     NOLOWCOLBIT2
        BSET    #3,D3
NOLOWCOLBIT2:
        LSL     D4,D3           ; PUT BACK INTO POSITION
        OR      D3,D5           ; OR INTO DESTINATION WORD
        LSR     #4,D2           ; NEXT BEAM
        ADD     #4,D4           ; NEXT ROT POSITION
        DBRA    D6,NEXTBEAM
        MOVE    D5,(A1)+
        DBRA    D1,NEXTCOLOR
        RTS

FADEIN:         ; SOURCE,DEST  PALETTE ADR ON STACK
        MOVE    #15,BRIGHTNESS
FI:
        MOVE.L  8(SP),A0        ; SOURCE
        MOVE.L  4(SP),A1        ; DEST
        MOVE    BRIGHTNESS,D0
        JSR     FADER           ; FADE

        MOVE.L  #2-1,D7         ; WAIT 2 VBL'S
        JSR     DELAY

        SUBQ    #1,BRIGHTNESS
        BGE     FI
        RTS

FADEOUT:         ; SOURCE,DEST PALETTE ADR ON STACK
        MOVE    #0,BRIGHTNESS
FO:
        MOVE.L  8(SP),A0        ; SOURCE
        MOVE.L  4(SP),A1        ; DEST
        MOVE    BRIGHTNESS,D0
        JSR     FADER           ; FADE

        MOVE.L  #2-1,D7         ; WAIT 2 VBL'S
        JSR     DELAY

        ADDQ    #1,BRIGHTNESS
        CMP     #16,BRIGHTNESS
        BNE     FO
        RTS

WHITER: ; GIVEN THE ORIGINAL PALETTE ADR IN A0, THE NEW ONE IN A1
        ; AND A VALUE FROM 0-15 IN D0 WHITER WILL FILL THE NEW PALETTE
        ; 0 BEING NORMAL & 15 BEING WHITE
        MOVE    #16-1,D1        ; 16 COLOR REGS
NEXTCOLOR1:
        TST.B   WARPFLAG        ; WHITE COLOR 5 ?
        BEQ     NOWARP
        CMP     #15-1,D1
        BNE     NOWARP
        SUBQ    #1,D1
        ADDQ.L  #2,A0
        ADDQ.L  #2,A1
        BRA     ENDWHITER
NOWARP:
        MOVE    (A0)+,D2        ; GET COLOR
        MOVE    #3-1,D6         ; 3 BEAMS
        CLR     D5              ; WORK REG
        CLR     D4              ; ROT REG
NEXTBEAM1:
        MOVE.B  D2,D3           ; GET BYTE
        AND.B   #$F,D3          ; MASK OFF OTHER COL
        LSL.B   #1,D3           ; ACCOUNT FOR SCREWED UP COLOUR BIT
        BTST    #4,D3
        BEQ     NOLOWCOLBIT3
        BSET    #0,D3
NOLOWCOLBIT3:
        AND     #$F,D3
        ADD.B   D0,D3           ; SUBTRACT D0
        CMP     #$F,D3
        BLE     NOTOVER
        MOVE.B  #$F,D3          ; IF NEGATIVE MAKE 0
NOTOVER:
        MOVE    #0,CCR          ; FIX FOR SCREWED UP COLOR REG
        LSR.B   #1,D3
        BCC     NOLOWCOLBIT4
        BSET    #3,D3
NOLOWCOLBIT4:
        LSL     D4,D3           ; PUT BACK INTO POSITION
        OR      D3,D5           ; OR INTO DESTINATION WORD
        LSR     #4,D2           ; NEXT BEAM
        ADD     #4,D4           ; NEXT ROT POSITION
        DBRA    D6,NEXTBEAM1
        MOVE    D5,(A1)+
ENDWHITER:
        DBRA    D1,NEXTCOLOR1
        RTS

WHITEIN:         ; SOURCE,DEST PALETTE ADR ON STACK
        MOVE    #15,BRIGHTNESS
WI:
        MOVE.L  8(SP),A0
        MOVE.L  4(SP),A1
        MOVE    BRIGHTNESS,D0
        JSR     WHITER           ; FADE

        MOVE.L  #2-1,D7         ; WAIT 2 VBL'S
        JSR     DELAY

        SUBQ    #1,BRIGHTNESS
        BGE     WI
        RTS

WHITEOUT:         ; SOURCE,DEST PALETTE ADR ON STACK
        MOVE    #0,BRIGHTNESS
WO:
        MOVE.L  8(SP),A0        ; SOURCE
        MOVE.L  4(SP),A1        ; DEST
        MOVE    BRIGHTNESS,D0
        JSR     WHITER           ; FADE

        MOVE.L  #2-1,D7
        JSR     DELAY

        ADDQ    #1,BRIGHTNESS
        CMP     #16,BRIGHTNESS
        BNE     WO
        RTS
        END
 