; OBJECT.O
; Unterprogramm f�r GFA-Bas-sembler 
; mit GFA-Assembler 1.5
; K.-D. Litteck  Juni 1991

 
; Labels als global deklarieren
  .GLOBL write
  .GLOBL read


  .TEXT 


;Unterroutine write 
write:         

; Testwert vom Stack holen
  move.l   4(sp),d0  
; Anzahl der Longwords vom Stack
  move.l   8(sp),d1 
; Startadresse vom Stack
  movea.l  12(sp),a0  


long_t: 
; Testwert in Speicher
  move.l  d0,(a0)+
; Z�hler dekrementieren
  subq.l  #1,d1
; Ist Z�hler 0 ?
  bne.s   long_t

; R�cksprung zum Basic-Programm
  rts        



; Unterroutine read 


read:          

;adresse von fehler%
  movea.l 4(sp),a1 
  move.l  8(sp),d0  ;testwert%
  move.l  12(sp),d1 ;anz%
  movea.l 16(sp),a0 ;adr%

; d5 als Fehlerz�hler l�schen
  moveq.l #0,d5   

long:
  cmp.l   (a0)+,d0  ; Vergleich
; Bei Fehler kein Sprung
  beq.s   weiter

  addq.l  #1,d5     ; Fehler erh�hen

weiter:
  subq.l  #1,d1     ; Z�hler dekrement
  bne.s   long      ; Z�hler 0 ?
  

; Wert des Fehlerz�hlers zur�ck
; in die Basic-Variable fehler%
  move.l  d5,(a1)


  rts        

; Falls im GFA-Basic Programm noch
; mehr Assembler-Routinen verwendet
; werden, so m��en diese hier folgen,
; da der GFA-Basic Linker nur eine
; Objectdatei verarbeiten kann.


  .END 

