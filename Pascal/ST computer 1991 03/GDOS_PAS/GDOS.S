; Assemblerroutine zur �berpr�fung der
; GDOS-Installation
; Erstellt mit MAS-68K von Borland

                .xdef VQ_GDOS
VQ_GDOS:        move.l (a7)+,a0  
                    ; R�cksprungadresse merken
                move.w #-2,d0
                trap   #2
                cmp.w  #-2,d0
                sne    d0
                ext.w  d0
                move.l d0,(sp)
                jmp    (a0) 
                    ; zur�ck zum Hauptprogramm
                .end

