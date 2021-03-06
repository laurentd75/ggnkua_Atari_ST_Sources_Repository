POINTS  = 300   ; NUMBER OF POINTS

        BSS
        ALIGN
DIR     DS.W    1
X       DS.B    POINTS
Y       DS.B    POINTS
VX      DS.B    POINTS
VY      DS.B    POINTS
COL     DS.B    POINTS
OVX     DS.B    POINTS
OVY     DS.B    POINTS
WARPFLAG        DS.B    1
RND     DS.B    1

  text
  align
;                       ***** INIT WARPEXPLO (EVERY TIME) *****
WARP:
        MOVE.B  #1,WARPFLAG             ; WARP IS ACTIVE
L0001D:                                 ; INIT
        LEA     X,A6                    ; LOAD DATA BASE ADR INTO A6
        MOVE.W  #POINTS-1,D7
L00017:
        MOVE    #17,-(SP)               ; GET RANDOM #
        TRAP    #14
        ADDQ.L  #2,SP

        BTST    #4,D0
        BEQ     L0000A
        OR.B    #$F0,D0
        BRA     L0000C
L0000A:
        AND.B   #$F,D0
L0000C:
        MOVE.B  D0,(POINTS*2)(A6)       ; VX
        NEG.B   D0
        MOVE.B  D0,(POINTS*5)(A6)       ; OVX

        SWAP    D0                      ; GET OTHER HALF OF RANDOM #
        BTST    #4,D0
        BEQ     L00010
        OR.B    #$F0,D0
        BRA     L00011
L00010:
        AND.B   #$F,D0
L00011:
        MOVE.B  D0,(POINTS*3)(A6)       ; VY
        NEG.B   D0
        MOVE.B  D0,(POINTS*6)(A6)       ; OVY
        MOVE    SHIPY,D0
        SUB     WINDY,D0
        ADD     #8,D0
        MOVE.B  D0,(POINTS)(A6)         ; Y
        MOVE    SHIPX,D0
        SUB     WINDX,D0
        ADD     #((HBUF*16)),D0
        MOVE.B  D0,(A6)+                ; X
        DBRA    D7,L00017

        JSR     DRAWPOINTS      ; INITIAL DRAW

        MOVE.W  #16-1,D5
WARPEXPLO:
        JSR     UNDRAWPOINTS
        JSR     CALC            ; CALCULATE NEW POINTS
        JSR     DRAWPOINTS

        MOVE    D5,-(SP)
        MOVE    #15,D0
        SUB     D5,D0
        MOVE.L  #MAP_PALETTE,A0
        MOVE.L  #RIVERPAL,A1
        JSR     WHITER
        MOVE    (SP)+,D5

        DBRA    D5,WARPEXPLO

        MOVE    #120,D7
        JSR     DELAY
; **************************************************************** ;
;               WARPOUT IS DONE -
;               INIT MUSIC
;               DO ALL FILE I/O (MAP,CHRS,CODE,SAMPLES,MUSIC)
; **************************************************************** ;

        LEA     X,A6                    ; REVERSE DIRECRION
        MOVE.W  #(POINTS*2)-1,D7
WARPCOPY:                                   ; WARPCOPY OV? TO V?
        MOVE.B  (POINTS*5)(A6),(POINTS*2)(A6)
        ADDQ.L  #1,A6
        DBRA    D7,WARPCOPY

        MOVE.W  #16-1,D5
IMPLOSION:
        JSR     UNDRAWPOINTS
        JSR     CALC            ; CALCULATE NEW POINTS
        JSR     DRAWPOINTS

        MOVE    D5,-(SP)
        MOVE    D5,D0
        MOVE.L  #MAP_PALETTE,A0
        MOVE.L  #RIVERPAL,A1
        JSR     WHITER
        MOVE    (SP)+,D5

        DBRA    D5,IMPLOSION

        JSR     UNDRAWPOINTS

; **************************************************************** ;
;               WARPIN IS DONE -
; **************************************************************** ;

        ADD     #16,SHIPY

        CLR.B   WARPFLAG        ; WARP IS OVER
        RTS     ; THIS RTS WILL RETURN TO THE MAIN PROGRAM
                ; RIGHT AFTER THE    < JSR COLDETECT >

; **************************************************************** ;
;               SUBROUTINES
; **************************************************************** ;
DRAWPOINTS:
        MOVE.W  #POINTS-1,D7
        LEA     X,A6
DP1:
        CMPI.B  #199,POINTS(A6)         ; BOUNDRY CHECK Y
        BHI     DP2                     ; SKIP THIS POINT
        CLR     D0
        CLR     D1
        MOVE.B  (A6),D0                 ; LOAD X
        MOVE.B  POINTS(A6),D1           ; LOAD Y
        MOVE.L  SCREENA,A0
        JSR     GET                     ; GET POINT
        MOVE.B  D2,(POINTS*4)(A6)       ; STORE COLOR
        CLR     D0
        CLR     D1
        MOVE.B  (A6),D0                 ; LOAD X
        MOVE.B  POINTS(A6),D1           ; LOAD Y
        MOVE    #1,D2                   ; LOAD COLOR
        MOVE.L  SCREENA,A0
        JSR     PLOT                    ; PLOT
DP2:
        ADDQ.L  #1,A6
        DBRA    D7,DP1
        RTS

UNDRAWPOINTS:
        MOVE.W  #POINTS-1,D7
        LEA     X+POINTS-1,A6
UND1:
        CMPI.B  #199,POINTS(A6)         ; BOUNDRY CHECK Y
        BHI     UND2                    ; SKIP THIS POINT
        CLR     D0
        CLR     D1
        MOVE.B  (A6),D0                 ; LOAD X
        MOVE.B  POINTS(A6),D1           ; LOAD Y
        MOVE.B  (POINTS*4)(A6),D2       ; STORE COLOR
        MOVE.L  SCREENA,A0
        JSR     PLOT                    ; PLOT
UND2:
        SUBQ.L  #1,A6
        DBRA    D7,UND1
        RTS

CALC:
        LEA     X,A6
        MOVE    #POINTS-1,D7
CLC1:
        TST.B   (POINTS*2)(A6)          ; TEST VX
        BEQ     CLCX4                   ; 0 - LEAVE ALONE
        BPL     CLCX2                   ; OTHERWISE DECELERATE
        ADDQ.B  #1,(POINTS*2)(A6)
        BRA     CLCX3
CLCX2:
        SUBQ.B  #1,(POINTS*2)(A6)
CLCX3:
        MOVE.B  (POINTS*2)(A6),D0       ; X=X+VX
        ADD.B   D0,(A6)
CLCX4:

        TST.B   (POINTS*3)(A6)          ; TEST VY
        BEQ     CLCY3                   ; 0 LEAVE ALONE
        BPL     CLCY1                   ; OTHERWISE DECELERATE
        ADDQ.B  #1,(POINTS*3)(A6)
        BRA     CLCY2
CLCY1:
        SUBQ.B  #1,(POINTS*3)(A6)
CLCY2:
        MOVE.B  (POINTS*3)(A6),D0       ; Y=Y+VY
        ADD.B   D0,POINTS(A6)
CLCY3:
        ADDQ    #1,A6
        DBRA    D7,CLC1
        RTS

;               ***** PLOTING ROUTINES *****
        INCLUDE 'D:\ASSEMPRO\WWM\PLOT_GET.S'

RAND:
        MOVE.B  RND,D1
        MOVE.B  VCTRLO,D0
        CMP.B   VCTRLO,D0
        BEQ     RAND
        ROR.B   #1,D0
        EOR.B   D1,D0
        MOVE.B  VCTRMI,D1
        EOR.B   D1,D0
        EORI.B  #$B6,D0
        MOVE.B  D0,RND
        RTS
        END
 