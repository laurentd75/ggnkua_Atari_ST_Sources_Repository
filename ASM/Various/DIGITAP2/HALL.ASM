; Echo (mit mehreren Reflektoren)
;
; Uebergabeparameter:
; in Klammern:  X/Y fuer X/Y Datenspeicherbereich
;               6/8 fuer Bitbreite der Speicheradresse
;
; QUELLE: Eingangswert                     (X-6)
; ZIEL:   Ausgangswert                     (X-6)
;
; ESIZE:  Groesse Ringbuffer - 1           max. 16 Bit gro�
; EZAHL:  Zahl der Reflektoren             max. 12 Bit gro�
; DELTAB: Reflektortabelle                 (Y-8)
; EPTR:   Zeiger auf Ringpuffer Eingang    (Y-6)
; FBACK:  Feedbackpegel                    (Y-6)
;
; Reflektortabelle (24 Bit DSP-W�rter):
;     Zeit  (Ringpuffergr��e - Verz�gerung)
;     Pegel (0 bis 2^23-1, Maximum: Verst�rkungsfaktor 1)
;     ...
;     ...
;
; Die Register M1,M5 m�ssen beim Aufruf $FFFF enthalten
; und werden nicht ver�ndert, daher gen�gt es, sie einmal
; beim Systeminitialisieren zu setzen.
;
; Ver�nderte Register:
;   X0,X1,Y0,Y1
;   B
;   R1,R5
;   N1

echo
; Register initialisieren:
; 
      clr   B   #<DELTAB,R5     ; Summe l�schen,
                                ; Zeiger auf Reflektortabelle
      move  #>ESIZE,M1          ; Ringpuffergr��e
      move  Y:(R5)+,N1          ; 1. Delay-Wert aus Tabelle
      move  Y:<EPTR,R1          ; Zeiger: n�chster Puffereintrag

; Schleife zum Aufsummieren der einzelnen Reflektoren
      do    #EZAHL,eloop        ; Anzahl der Reflektoren
      move  Y:(R5)+,X0          ; Reflektorgewichtung
      move  X:(R1+N1),X1        ; Wert aus Ringpuffer holen
      mac   X0,X1,B  Y:(R5)+,N1 ; Gewichten/Aufsummieren,
                                ; parallel: n�chstes Delay laden
eloop

; Aufsummierte reflektierte Werte ausgeben und
; mit Gewichtung in den Ringpuffer r�ckkoppeln
      move  X:<QUELLE,X1        ; Eingangsvariable
      move  Y:<FBACK,Y1         ; Feedback-Gewichtung
      move  B,Y0                ; Summe reflektierter Werte

      mpy   Y0,Y1,B   B,X:<ZIEL ; Summe gewichten,
                                ; parallel: Summe auf Zielvariable
      add   X1,B                ; Eingangswert plus Feedback
      move  B,X:(R1)+           ; in Ringpuffer eintragen
      move  R1,Y:<EPTR          ; neuen Ringbufferzeiger merken

      move  #$ffff,M1           ; M1 rekonstruieren

      rts

      end
