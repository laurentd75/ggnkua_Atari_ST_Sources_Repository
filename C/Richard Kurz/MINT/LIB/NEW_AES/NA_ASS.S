; NA_ASS.S
;
; Libary f�r die neuen AES-Funktionen ab AES 4.0 
; 
; Oktober 1992 by Richard Kurz, Vogelherdbogen 62, 7992 Tettnang
; Fido 2:241/7232.5
; F�r's TOS-Magazin

export CallAes

CallAes:
    movem.l d0-a6,-(sp)
    move.l  #200,d0
    move.l  a0,d1
    trap #2
    movem.l (sp)+,d0-a6
    rts
