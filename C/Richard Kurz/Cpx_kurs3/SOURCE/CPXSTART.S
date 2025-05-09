; cpxstart.s
; Bei der Erzeugung von CPX-Modulen mu� dieser Code anstelle
; von PCSTART.O verwendet werden.
;
; aus: Wir basteln uns ein CPX
;      CPX-Kurs Teil 1
;      TOS Magazin
;
; (c)1992 by Richard Kurz
; Vogelherdbogen 62
; 7992 Tettnang
;
; Erstellt mit Pure Assembler
;

; Wir geben bekannt.....
.globl cpxstart,cpx_init
.globl shslide,svslide,spopup,errno
    
.text

cpxstart:
    jmp cpx_init    ; Dieser Sprung ist lebenswichtig!
                    ; er mu� am Anfang des Textsegments
                    ; stehen, da XControl dort den Anfang
                    ; des CPX-Moduls vermutet.
.data
; Die Funktion CPX_Save speichert die Werte am Anfang des
; Datensegments. ACHTUNG, es mu� gen�gend Platz sein!!!!

shslide:    dc.w 16 ; Speicher f�r hslide
svslide:    dc.w 10 ; Speicher f�r vslide
spopup:     dc.w 1  ; Speicher f�r popup

errno:      dc.w 0  ; Diese Variable wird von Pure C Funktionen
                    ; ben�tigt.
.end        
