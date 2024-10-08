  data
fileprompt:             ; prompt for filename
  dc.b 'Please enter the filename (& pathname if needed) of the',10,13,0
picture:
  DC.B 'picture file to extract the score box from.',13,10,0
scorebox:
  dc.b 'file to output the score box to.',10,13,0
reading:
  dc.b 10,13,'Reading picture. ',10,13,10,0
saveing:
  dc.b 10,13,'Saving score box image. ',10,13,10,0

input:                  ; adress of input string
  dc.b 64,0
filespec:               ; actual string begins here
  ds.b 64

  bss
handle:                 ; space for file handle
  ds.w 1
BUFFER:
  DS.w 1                ; res value
pal:
  ds.w 16               ; palette
image:
        ds.b 160*160
scoreboximg:
        ds.b 32000-(160*160)

  text
  move.l #fileprompt,d0 ; prompt for filename input
  jsr prtline
  move.l #picture,d0
  jsr prtline

  move.l #input,-(sp)   ; input filename
  move #$a,-(sp)
  trap #1
  addq.l #6,sp

  lea filespec,a0
  move.b #0,(a0,d0.w)   ; null terminate the string

  move #2,-(sp)         ; open file
  move.l #filespec,-(sp)
  move #$3d,-(sp)
  trap #1
  addq.l #8,sp
  move d0,handle

  move.l #reading,d0    ; inform reading
  jsr prtline

  move.l #buffer,-(sp)  ; read
  move.l #32034,-(sp)
  move handle,-(sp)
  move #$3f,-(sp)
  trap #1
  add.l #12,sp

  move handle,-(sp)     ; close file
  move #$3e,-(sp)
  trap #1
  addq.l #6,sp

  move.l #fileprompt,d0 ; prompt for filename output
  jsr prtline
  move.l #scorebox,d0
  jsr prtline

  move.l #input,-(sp)   ; input filename
  move #$a,-(sp)
  trap #1
  addq.l #6,sp

  lea filespec,a0
  move.b #0,(a0,d0.w)   ; null terminate the string

  move #0,-(sp)         ; create file
  move.l #filespec,-(sp)
  move #$3c,-(sp)
  trap #1
  addq.l #8,sp
  move d0,handle

  move.l #saveing,d0    ; inform saveing
  jsr prtline

  move.l #scoreboximg,-(sp)  ; save
  move.l #32000-(160*160),-(sp)
  move handle,-(sp)
  move #$40,-(sp)
  trap #1
  add.l #12,sp

  move handle,-(sp)     ; close file
  move #$3e,-(sp)
  trap #1
  addq.l #6,sp

  clr -(sp)             ; term
  trap #1

; ***** subroutines *****

prtline:
  move.l d0,-(sp)
  move #$09,-(sp)
  trap #1
  addq.l #6,sp
  rts

  end
 