
; alloca() reserviert Platz auf dem Stack    
; Die aufrufende Funktion darf keine Regist- 
; ervariablen verwenden !                      
; Autor: Roman Hodek
; (c) 1992 MAXON Computer

alloca:  move.l  (a7)+,a0  ; R�cksprungadr.
         
         move.w  (a7),d0
         suba.l  d0,a7
         
         move.l  a7,d0
         addq.l  #2,d0
         
         jmp     (a0)
         
         

