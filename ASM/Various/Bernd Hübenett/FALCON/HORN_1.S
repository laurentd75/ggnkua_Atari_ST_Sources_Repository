; ------------------------------------------
; ------ C I R C L E  ( DC-MODE) -----------
; ------------------------------------------
; Parameter:
;            D0.L = X-Koordinate
;            D1.L = Y-Koordinate
;            D2.L = Radius
; ------------------------------------------


circle:         movem.l D0-A1,-(SP)

                movea.l buffscr,A1
                move.l  D2,D3           ; x& = r&        Zeile 30
                move.l  #0,D4           ; y& = 0         Zeile 28

; F�r die Oktanten 1,3,5,7

                move.w  D3,D6
                lsl.w   #1,D6
                sub.w   D6,D2           ; Zeile 34

Zeile35:        move.w  D3,D6
                add.w   D0,D6
                move.w  D4,D7
                add.w   D1,D7
                movea.l A1,A0
                lsl.l   #1,D6
                mulu    #640,D7
                add.l   D6,D7
                adda.l  D7,A0
                move.w  #$FFFF,(A0)     ; Zeile 39

                move.w  D0,D6
                sub.w   D4,D6
                move.w  D1,D7
                add.w   D3,D7
                movea.l A1,A0
                lsl.l   #1,D6
                mulu    #640,D7
                add.l   D6,D7
                adda.l  D7,A0
                move.w  #$FFFF,(A0)     ; Zeile 39

                move.w  D0,D6
                sub.w   D3,D6
                move.w  D1,D7
                sub.w   D4,D7
                movea.l A1,A0
                lsl.l   #1,D6
                mulu    #640,D7
                add.l   D6,D7
                adda.l  D7,A0
                move.w  #$FFFF,(A0)     ; Zeile 39

                move.w  D0,D6
                add.w   D4,D6
                move.w  D1,D7
                sub.w   D3,D7
                movea.l A1,A0
                lsl.l   #1,D6
                mulu    #640,D7
                add.l   D6,D7
                adda.l  D7,A0
                move.w  #$FFFF,(A0)     ; Zeile 39

                move.w  D4,D6
                lsl.w   #1,D6
                addq.w  #1,D6
                add.w   D6,D2           ; Zeile 49

                addq.w  #1,D4           ; Zeile 50

                cmp.w   #0,D2
                ble.s   Zeile54

                move.w  D3,D6
                lsl.w   #1,D6
                sub.w   #2,D6
                sub.w   D6,D2           ; Zeile 52

                subq.w  #1,D3           ; Zeile 53

Zeile54:        cmp.w   D3,D4
                blt     Zeile35

; Oktanten 2,4,6,8

                move.w  D3,D6
                lsl.w   #1,D6
                add.w   D6,D2           ; Zeile 57

Zeile58:        move.w  D4,D6
                lsl.w   #1,D6
                subq.w  #1,D6
                sub.w   D6,D2           ; Zeile 59

                subq.w  #1,D4           ; Zeile 60

                cmp.w   #0,D2
                bgt.s   Zeile64

                move.w  D3,D6
                lsl.w   #1,D6
                add.w   #2,D6
                add.w   D6,D2           ; Zeile 62

                addq.w  #1,D3           ; Zeile 63

Zeile64:        cmp.w   D3,D4
                beq     Zeile79

                move.w  D4,D6
                add.w   D0,D6
                move.w  D3,D7
                add.w   D1,D7
                movea.l A1,A0
                lsl.l   #1,D6
                mulu    #640,D7
                add.l   D6,D7
                adda.l  D7,A0
                move.w  #$FFFF,(A0)     ; Zeile 69

                move.w  D0,D6
                sub.w   D3,D6
                move.w  D1,D7
                add.w   D4,D7
                movea.l A1,A0
                lsl.l   #1,D6
                mulu    #640,D7
                add.l   D6,D7
                adda.l  D7,A0
                move.w  #$FFFF,(A0)     ; Zeile 39

                move.w  D0,D6
                sub.w   D4,D6
                move.w  D1,D7
                sub.w   D3,D7
                movea.l A1,A0
                lsl.l   #1,D6
                mulu    #640,D7
                add.l   D6,D7
                adda.l  D7,A0
                move.w  #$FFFF,(A0)     ; Zeile 39

                move.w  D0,D6
                add.w   D3,D6
                move.w  D1,D7
                sub.w   D4,D7
                movea.l A1,A0
                lsl.l   #1,D6
                mulu    #640,D7
                add.l   D6,D7
                adda.l  D7,A0
                move.w  #$FFFF,(A0)     ; Zeile 39

Zeile79:        cmp.w   #0,D4
                bgt     Zeile58

circle_end:     movem.l (SP)+,D0-A1
                rts
