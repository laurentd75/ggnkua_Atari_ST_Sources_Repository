;--------------------------------------
;      Bootsektor-Pictureleser
;      Colorversion
;      Version 0.5color
;      (c)1989 by Martin M�ller
;                 Klopstockweg 23
;                 4440 Rheine
;--------------------------------------
; Liest Bild PICTURE.PI1 von Disk A:
; Bild liegt im Screenformat vor
;--------------------------------------
       move.w #$00,$482   ; kein Command.Prg laden
       move.w #$04,-(sp)  ; Getrez()
       trap #14           ; do it!
       addq.l #2,sp
       cmp.w #$0,D0       ; Low-Resolution
       bne error          ; Nein, dann Ende
       move.w #2,-(sp)    ; read/write
       pea fname          ; A:\PICTURE.PI1
       move.w #$3D,-(sp)  ; Fopen
       trap #1
       addq.l #8,sp
       tst.w D0
       bmi error
       move.w d0,d7       ; Handle nach D7
       pea adr            ; def. Block
       move.l #34,-(sp)   ; 34 Byte
       move.w d7,-(sp)    ; Handle
       move.w #$3F,-(sp)  ; Fread
       trap #1
       add.l #12,sp
       pea color          ; Colorblock
       move.w #$06,-(sp)  ; Setpalette
       trap #14
       addq.l #6,sp
       move.w #$02,-(sp)  ; Physbase
       trap #14
       addq.l #2,sp
       move.l D0,-(sp)    ; Physbase
       move.l #32000,-(sp) ; Bilddaten
       move.w d7,-(sp)    ; Handle
       move.w #$3f,-(sp)  ; Fread
       trap #1
       add.l #12,sp
       move.w d7,-(sp)    ; Handle
       move.w #$3E,-(sp)  ; Fclose
       trap #1
       addq.l #4,sp
       move.w #$02,-(sp)  ; 'con:'
       move.w #$02,-(sp)  ; Bconin
       trap #13
       addq.l #$04,sp
error: clr.l D0           ; all right!
       rts                ; return if you want!
txt:   dc.b "Hallo, hier bin ich!",$00,$00
       align.w
hndl:  dc.w $0000
fname: dc.b "A:\PICTURE.PI1",$00
       align.w
adr:   dc.b $00,$00
color: dc.w $000,$001,$002,$003,$004,$005,$006,$007
       dc.w $008,$009,$010,$011,$012,$013,$014,$015
       end

 