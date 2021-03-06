;********************************************* Unpackroutine von FIRE-PACK
; Eingabe: a0 = Adresse gepackter Daten
; Ausgabe: a1 = Adresse entpackter Daten
; a2 und a3 sind w�hrend der Packroutine unbelegt
fire_decrunch:  movem.l D0-A6,-(SP)
                bsr.s   .getinfo        ; Kenn-Langwort holen
                cmp.l   #'FIRE',D0      ; Kennung gefunden?
                bne.s   .not_packed     ; nein: nicht gepackt
                bsr.s   .getinfo        ; Kenn-Langwort holen
                lea     -8(A0,D0.l),A5  ; a5 = Ende aller Daten
                bsr.s   .getinfo        ; L�nge holen
                move.l  D0,(SP)         ; Originall�nge: sp�ter nach d0
                movea.l A1,A4
                movea.l A1,A6
                adda.l  D0,A6           ; a6 = neues Ende
; a5 = Ende von Byte-Daten
                move.b  -(A5),D7        ; erstes Informationslangwort
                lea     .tabellen(PC),A3 ; a3 = Zeiger auf Datenbereich
                moveq   #1,D6
                swap    D6              ; d6 = $10000
                moveq   #0,D5           ; d5 = 0 (oberes Wort: immer 0!)
.normal_bytes:  bsr.s   .get_1_bit
                bcc.s   .test_if_end    ; Bit %0: keine Daten
                moveq   #0,D1           ; falls zu .copy_direkt
                bsr.s   .get_1_bit
                bcc.s   .copy_direkt    ; Bitfolge: %10: 1 Byte direkt kop.
                movea.l A3,A0
                moveq   #3,D3
.nextgb:        move.l  -(A0),D0        ; d0.w Bytes lesen
                bsr.s   .get_d0_bits
                swap    D0
                cmp.w   D0,D1           ; alle gelesenen Bits gesetzt?
                dbne    D3,.nextgb      ; ja: dann weiter Bits lesen
.no_more:       add.l   16(A0),D1       ; Anzahl der zu �bertragenen Bytes
.copy_direkt:   move.b  -(A5),-(A6)     ; Daten direkt kopieren
                dbra    D1,.copy_direkt ; noch ein Byte
.test_if_end:   cmpa.l  A4,A6           ; Fertig?
                bgt.s   .strings        ; Weiter wenn Ende nicht erreicht
.not_packed:    movem.l (SP)+,D0-A6
                rts
.getinfo:       moveq   #3,D1
.glw:           rol.l   #8,D0
                move.b  (A0)+,D0
                dbra    D1,.glw
                rts
.get_1_bit:     add.b   D7,D7           ; hole ein Bit
                beq.s   .no_bit_found
                rts
.no_bit_found:  move.b  -(A5),D7
                addx.b  D7,D7
                rts
.get_d0_bits:   moveq   #0,D1           ; Ergebnisfeld vorbereiten
.hole_bit_loop: add.b   D7,D7           ; hole ein Bit
                beq.s   .not_found      ; quellfeld leer
.on_d0:         addx.w  D1,D1           ; und �bernimm es
                dbra    D0,.hole_bit_loop ; bis alle Bits geholt wurden
                rts
.not_found:     move.b  -(A5),D7        ; hole sonst ein weiteres Longword
                addx.b  D7,D7           ; hole ein Bit
                bra.s   .on_d0
.strings:       moveq   #1,D0           ; 2 Bits lesen
                bsr.s   .get_d0_bits
                subq.w  #1,D1
                bmi.s   .gleich_morestring ; %00
                beq.s   .length_2       ; %01
                subq.w  #1,D1
                beq.s   .length_3       ; %10
                bsr.s   .get_1_bit
                bcc.s   .bitset         ; %110
                bsr.s   .get_1_bit
                bcc.s   .length_4       ; %1110
                bra.s   .length_5       ; %1111
.get_short_offset:moveq #1,D0
                bsr.s   .get_d0_bits    ; d1:  0,  1,  2,  3
                subq.w  #1,D1
                bpl.s   .contoffs
                moveq   #0,D0           ; Sonderfall
                rts
.get_long_offset:moveq  #1,D0           ; 2 Bits lesen
                bsr.s   .get_d0_bits    ; d1:  0,  1,  2,  3
.contoffs:      add.w   D1,D1           ; d1:  0,  2,  4,  6
                add.w   D1,D1           ; d1:  0,  4,  8, 12
                movem.w .offset_table-.tabellen(A3,D1.w),D0/D5
                bsr.s   .get_d0_bits    ; 4, 8, 12 oder 16 Bits lesen
                add.l   D5,D1
                rts
.gleich_morestring:                     ; %00
                moveq   #1,D0           ; 2 Bits lesen
                bsr.s   .get_d0_bits    ; d1:  0,  1,  2,  3
                subq.w  #1,D1
                bmi.s   .gleich_string  ; %0000
                add.w   D1,D1           ; d1:    0,  2,  4
                add.w   D1,D1           ; d1:    0,  4,  8
                movem.w .more_table-.tabellen(A3,D1.w),D0/D2
                bsr.s   .get_d0_bits
                add.w   D1,D2           ; d2 = Stringl�nge
                bsr.s   .get_long_offset
                move.w  D2,D0           ; d0 = Stringl�nge
                bra.s   .copy_longstring
.bitset:        moveq   #2,D0           ; %110
                bsr.s   .get_d0_bits
                moveq   #0,D0
                bset    D1,D0
                bra.s   .put_d0
.length_2:      moveq   #7,D0           ; %01
                bsr.s   .get_d0_bits
                moveq   #2-2,D0
                bra.s   .copy_string
.length_3:      bsr.s   .get_short_offset ; %10
                tst.w   D0
                beq.s   .put_d0         ; 0 ablegen
                moveq   #3-2,D0
                bra.s   .copy_string
.length_4:      bsr.s   .get_short_offset ; %1110
                tst.w   D0
                beq.s   .vorg�nger_kopieren
                moveq   #4-2,D0
                bra.s   .copy_string
.length_5:      bsr.s   .get_short_offset ; %1111
                tst.w   D0
                beq.s   .put_ff
                moveq   #5-2,D0
                bra.s   .copy_string
.put_ff:        moveq   #-1,D0
                bra.s   .put_d0
.vorg�nger_kopieren:move.b (A6),D0
.put_d0:        move.b  D0,-(A6)
                bra.s   .backmain
.gleich_string: bsr.s   .get_long_offset ; Anzahl gleicher Bytes lesen
                beq.s   .backmain       ; 0: zur�ck
                move.b  (A6),D0
.copy_gl:       move.b  D0,-(A6)
                dbra    D1,.copy_gl
                sub.l   D6,D1
                bmi.s   .backmain
                bra.s   .copy_gl
.copy_longstring:subq.w #2,D0           ; Stringl�nge - 2 (wegen dbf)
.copy_string:                           ; d1 = Offset, d0 = Anzahl Bytes -2
                lea     2(A6,D1.l),A0   ; Hier stehen die Originaldaten
                adda.w  D0,A0           ; dazu die Stringl�nge-2
                move.b  -(A0),-(A6)     ; ein Byte auf jeden Fall kopieren
.dep_b:         move.b  -(A0),-(A6)     ; mehr Bytes kopieren
                dbra    D0,.dep_b       ; und noch ein Mal
.backmain:      bra     .normal_bytes   ; Jetzt kommen wieder normale Bytes
.direkt_tab:    DC.L $03FF0009,$070002,$030001,$030001 ; Anzahl 1-Bits
.tabellen:      DC.L 15-1,8-1,5-1,2-1 ; Anz. Bytes
.offset_table:  DC.W 3,0
                DC.W 7,16+0
                DC.W 11,256+16+0
                DC.W 15,4096+256+16+0
.more_table:    DC.W 3,5
                DC.W 5,16+5
                DC.W 7,64+16+5
                END
