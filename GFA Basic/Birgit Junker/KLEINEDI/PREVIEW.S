; Eine schnelle Textpreview-Funktion soll entstehen
; Aufruf: ~C:preview%(L:V:text$,L:dest_adr%,W:LEN(text$))

          movea.l   4(sp),a0  ; Text
          movea.l   8(sp),a1  ; Screen
          move.w    12(sp),d0 ; Textl�nge

          tst.w     d0        ; Text l�nger als Null?
          beq.s     ABBRUCH   ; Nein

          subq.w    #1,d0     ; Wegen der Schleife bis -1
          cmpi.w    #79,d0    ; 80 Zeichen oder wieviel?
          ble.s     START
          moveq.l   #79,d0    ; Begrenzung der Zeichen

START:    moveq.l   #0,d1     ; da hinein das Zeichen, darum vorher s�ubern
          moveq.l   #0,d2     ; d2 sauber
          moveq.l   #15,d3    ; der Bit-Z�hler
          moveq.l   #14,d4    ; der Z�hler f�r die Musterausgabe

GETCHAR:  move.b    (a0)+,d1  ; Zeichen holen
          cmpi.w    #33,d1    ; ist es gr��er als Space?
          blt.s     SPACE     ; Nein, also nicht wichtig
          bset      d3,d2     ; Bit Nr.d3 in d2 setzen

SPACE:    subq.w    #3,d3     ; Bit-Z�hler herunter z�hlen
          tst.w     d3
          bge.s     NEXT

          move.w    d2,(a1)   ; hier kommt das Muster auf den Screen
          move.w    d2,80(a1) ; 80 Bytes verschoben
          move.w    d2,160(a1)          ; nochmal 80 Bytes
          addq.w    #2,a1     ; ein Word weiter rechts
          subq.w    #1,d4
          moveq.l   #0,d2     ; d2 sauber

          cmpi.w    #-2,d3    ; Verzweigung, Bedingung -3 f�hrt zu FILL_1
          beq.s     FILL_2
          cmpi.w    #-1,d3
          beq.s     FILL_3

FILL_1:   moveq.l   #13,d3    ; der Bit-Z�hler wird wieder aufgef�llt
          dbra      d0,GETCHAR
          rts       

FILL_2:   moveq.l   #14,d3    ; der Bit-Z�hler wird wieder aufgef�llt
          dbra      d0,GETCHAR
          rts       

FILL_3:   moveq.l   #15,d3    ; der Bit-Z�hler wird wieder aufgef�llt
NEXT:     dbra      d0,GETCHAR
          tst.w     d4        ; ist noch Platz f�r ein Muster?
          blt.s     ABBRUCH   ; Nein, Schlu�
          move.w    d2,(a1)   ; hier kommt das letzte Muster auf den Screen
          move.w    d2,80(a1)
          move.w    d2,160(a1)
ABBRUCH:  rts       
          .END 
