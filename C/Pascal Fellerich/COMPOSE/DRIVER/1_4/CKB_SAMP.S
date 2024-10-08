*
* ASSEMBLER SOURCE einer Tastatur-umbelegungs-tabelle.
* (TurboAss!)
*
* �2/1992 by P. Fellerich
*
               output 'VIETNAM.CKB'

               default 6      ;'BASIC' == BIN�R!

               >PART 'Header'
id:            dc.b "CKBD"    ;Kennung

               dxset 12,0     ;der eigene Name hat 12 chars
name:          dx.b 'Vietnam!'

unshift_offset:dc.w unshift-id ;  Start der UNSHIFT-Tabelle oder 0 wenn nicht da
shift_offset:  dc.w shift-id  ;   Start der Shift-Tabelle
caps_offset:   dc.w caps-id   ;   id, CapsLock
compose_offset:dc.w compose-id ;  Start der Compose-Tabelle

compose_mode:  dc.w %111      ; ON, MULTICHAR MODE, ORDER SENSITIVE

               endpart
               >PART 'Unshift translation table'
unshift:       dc.b $00,$1B,$31,$32,$33,$34,$35,$36
               dc.b $37,$38,$39,$30,$3C,$27,$08,$09
               dc.b $71,$77,$65,$72,$74,$7A,$75,$69
               dc.b $6F,$70,$7D,$2B,$0D,$00,$61,$73
               dc.b $64,$66,$67,$68,$6A,$6B,$6C,$7C
               dc.b $7B,$40,$00,$05,$79,$78,$63,$76
               dc.b $62,$6E,$6D,$2C,$2E,$2D,$00,$00
               dc.b $00,$20,$00,$00,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$00
               dc.b $00,$00,$2D,$00,$00,$00,$2B,$00
               dc.b $00,$00,$00,$7F,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$00
               dc.b $60,$00,$00,$28,$29,$2F,$2A,$37
               dc.b $38,$39,$34,$35,$36,$31,$32,$33
               dc.b $30,$2E,$0D,$00,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$00
               endpart
               >PART 'Shift-translation table'
shift:         dc.b $00,$1B,$21,$22,$23,$24,$25,$26
               dc.b $2F,$28,$29,$3D,$3F,$3E,$08,$09
               dc.b $51,$57,$45,$52,$54,$5A,$55,$49
               dc.b $4F,$50,$5D,$2A,$0D,$00,$41,$53
               dc.b $44,$46,$47,$48,$4A,$4B,$4C,$5C
               dc.b $5B,$5E,$00,$0B,$59,$58,$43,$56
               dc.b $42,$4E,$4D,$3B,$3A,$5F,$00,$00
               dc.b $00,$20,$00,$00,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$37
               dc.b $38,$00,$2D,$34,$00,$36,$2B,$00
               dc.b $32,$00,$30,$7F,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$00
               dc.b $7E,$00,$00,$28,$29,$2F,$2A,$37
               dc.b $38,$39,$34,$35,$36,$31,$32,$33
               dc.b $30,$2E,$0D,$00,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$00
               endpart
               >PART 'Capslock translation table'
caps:          dc.b $00,$1B,$31,$32,$33,$34,$35,$36
               dc.b $37,$38,$39,$30,$3C,$27,$08,$09
               dc.b $51,$57,$45,$52,$54,$5A,$55,$49
               dc.b $4F,$50,$5D,$2B,$0D,$00,$41,$53
               dc.b $44,$46,$47,$48,$4A,$4B,$4C,$5C
               dc.b $5B,$5E,$00,$0B,$59,$58,$43,$56
               dc.b $42,$4E,$4D,$2C,$2E,$2D,$00,$00
               dc.b $00,$20,$00,$00,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$00
               dc.b $00,$00,$2D,$00,$00,$00,$2B,$00
               dc.b $00,$00,$00,$7F,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$00
               dc.b $60,$00,$00,$28,$29,$2F,$2A,$37
               dc.b $38,$39,$34,$35,$36,$31,$32,$33
               dc.b $30,$2E,$0D,$00,$00,$00,$00,$00
               dc.b $00,$00,$00,$00,$00,$00,$00,$00
               endpart
               >PART 'Compose Character Tabelle'
* COMPOSE-Tabelle f�r VIETCAL!
* ----------------------------
* erstellt 26.1.1992 @pf68030
*
compose:       dc.b "A1�",0
               dc.b "A2�",0
               dc.b "A3�",0
               dc.b "A4�",0
               dc.b "A5�",0
               dc.b "A6�",0
               dc.b "A7�",0
               dc.b "A8�",0
               dc.b "A9�",0
               dc.b "A0�",0
               dc.b "AA�",0
               dc.b "�1�",0
               dc.b "�2�",0
               dc.b "�3�",0
               dc.b "�4�",0
               dc.b "�5�",0
               dc.b "�6�",0
               dc.b "�7�",0
               dc.b "�8�",0
               dc.b "�9�",0
               dc.b "�0�",0
               dc.b "AS�",0
               dc.b "�1�",0
               dc.b "�2�",0
               dc.b "�3�",0
               dc.b "�4�",0
               dc.b "�5�",0
               dc.b "�6�",0
               dc.b "�7�",0
               dc.b "�8�",0
               dc.b "�9�",0
               dc.b "�0�",0
               dc.b "E1�",0
               dc.b "E2�",0
               dc.b "E3�",0
               dc.b "E4�",0
               dc.b "E5�",0
               dc.b "E6�",0
               dc.b "E7�",0
               dc.b "E8�",0
               dc.b "E9�",0
               dc.b "E0�",0
               dc.b "EE�",0
               dc.b "�1�",0
               dc.b "�2�",0
               dc.b "�3�",0
               dc.b "�4�",0
               dc.b "�5�",0
               dc.b "�6�",0
               dc.b "�7�",0
               dc.b "�8�",0
               dc.b "�9�",0
               dc.b "�0�",0
               dc.b "I1�",0
               dc.b "I2�",0
               dc.b "I3�",0
               dc.b "I4�",0
               dc.b "I5�",0
               dc.b "I6�",0
               dc.b "I7�",0
               dc.b "I8�",0
               dc.b "I9�",0
               dc.b "I0�",0
               dc.b "O1�",0
               dc.b "O2�",0
               dc.b "O3�",0
               dc.b "O4�",0
               dc.b "O5�",0
               dc.b "O6�",0
               dc.b "O7�",0
               dc.b "O8�",0
               dc.b "O9�",0
               dc.b "O0�",0
               dc.b "OO�",0
               dc.b "�1�",0
               dc.b "�2�",0
               dc.b "�3�",0
               dc.b "�4�",0
               dc.b "�5�",0
               dc.b "�6�",0
               dc.b "�7�",0
               dc.b "�8�",0
               dc.b "�9�",0
               dc.b "�0�",0
               dc.b "U1�",0
               dc.b "U2�",0
               dc.b "U3�",0
               dc.b "U4�",0
               dc.b "U5�",0
               dc.b "U6�",0
               dc.b "U7�",0
               dc.b "U8�",0
               dc.b "U9�",0
               dc.b "U0�",0
               dc.b "Y1�",0
               dc.b "Y2�",0
               dc.b "Y3�",0
               dc.b "Y4�",0
               dc.b "Y5�",0
               dc.b "Y6�",0
               dc.b "Y7�",0
               dc.b "Y8�",0
               dc.b "Y9�",0
               dc.b "Y0�",0
               dc.b "\1�",0
               dc.b "\2�",0
               dc.b "\3�",0
               dc.b "\4�",0
               dc.b "\5�",0
               dc.b "\6�",0
               dc.b "\7�",0
               dc.b "\8�",0
               dc.b "\9�",0
               dc.b "\0�",0
               dc.b "]1�",0
               dc.b "]2�",0
               dc.b "]3�",0
               dc.b "]4�",0
               dc.b "]5�",0
               dc.b "]6�",0
               dc.b "]7�",0
               dc.b "]8�",0
               dc.b "]9�",0
               dc.b "]0�",0
               dc.b "a1�",0
               dc.b "a2�",0
               dc.b "a3�",0
               dc.b "a4�",0
               dc.b "a5�",0
               dc.b "a6�",0
               dc.b "a7�",0
               dc.b "a8�",0
               dc.b "a9�",0
               dc.b "a0�",0
               dc.b "aa�",0
               dc.b "�1�",0
               dc.b "�2�",0
               dc.b "�3�",0
               dc.b "�4�",0
               dc.b "�5�",0
               dc.b "�6�",0
               dc.b "�7�",0
               dc.b "�8�",0
               dc.b "�9�",0
               dc.b "�0�",0
               dc.b "as�",0
               dc.b "�1�",0
               dc.b "�2�",0
               dc.b "�3�",0
               dc.b "�4�",0
               dc.b "�5�",0
               dc.b "�6�",0
               dc.b "�7�",0
               dc.b "�8�",0
               dc.b "�9�",0
               dc.b "�0�",0
               dc.b "e1�",0
               dc.b "e2�",0
               dc.b "e3�",0
               dc.b "e4�",0
               dc.b "e5�",0
               dc.b "e6�",0
               dc.b "e7�",0
               dc.b "e8�",0
               dc.b "e9�",0
               dc.b "e0�",0
               dc.b "ee�",0
               dc.b "�1�",0
               dc.b "�2�",0
               dc.b "�3�",0
               dc.b "�4�",0
               dc.b "�5�",0
               dc.b "�6�",0
               dc.b "�7�",0
               dc.b "�8�",0
               dc.b "�9�",0
               dc.b "�0�",0
               dc.b "i1�",0
               dc.b "i2�",0
               dc.b "i3�",0
               dc.b "i4�",0
               dc.b "i5�",0
               dc.b "i6�",0
               dc.b "i7�",0
               dc.b "i8�",0
               dc.b "i9�",0
               dc.b "i0�",0
               dc.b "o1�",0
               dc.b "o2�",0
               dc.b "o3�",0
               dc.b "o4�",0
               dc.b "o5�",0
               dc.b "o6�",0
               dc.b "o7�",0
               dc.b "o8�",0
               dc.b "o9�",0
               dc.b "o0�",0
               dc.b "oo�",0
               dc.b "�1�",0
               dc.b "�2�",0
               dc.b "�3�",0
               dc.b "�4�",0
               dc.b "�5�",0
               dc.b "�6�",0
               dc.b "�7�",0
               dc.b "�8�",0
               dc.b "�9�",0
               dc.b "�0�",0
               dc.b "u1�",0
               dc.b "u2�",0
               dc.b "u3�",0
               dc.b "u4�",0
               dc.b "u5�",0
               dc.b "u6�",0
               dc.b "u7�",0
               dc.b "u8�",0
               dc.b "u9�",0
               dc.b "u0�",0
               dc.b "y1�",0
               dc.b "y2�",0
               dc.b "y3�",0
               dc.b "y4�",0
               dc.b "y5�",0
               dc.b "y6�",0
               dc.b "y7�",0
               dc.b "y8�",0
               dc.b "y9�",0
               dc.b "y0�",0
               dc.b "|1�",0
               dc.b "|2�",0
               dc.b "|3�",0
               dc.b "|4�",0
               dc.b "|5�",0
               dc.b "|6�",0
               dc.b "|7�",0
               dc.b "|8�",0
               dc.b "|9�",0
               dc.b "|0�",0
               dc.b "}1�",0
               dc.b "}2�",0
               dc.b "}3�",0
               dc.b "}4�",0
               dc.b "}5�",0
               dc.b "}6�",0
               dc.b "}7�",0
               dc.b "}8�",0
               dc.b "}9�",0
               dc.b "}0�",0
               dc.l 0
;------------

               endpart
               end
