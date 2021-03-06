
; demonstrates the use of MSHRINK
; when a prg is loaded, it graps ALL avail. memory. this is
; appaling!
;
; How to fix?   Calc size of program code and then return unused
; portion to sys using mshrink
;
; THIS PROGRAM IS A SHELL FOR YOU TO USE!

calc_prog_size:
 lea       program_end,a0        ; get addr of last stmt in prg
 movea.l   4(a7),a1              ; get addr of basepage
 suba.l    a1,a0                 ; get size of prog, place in a0
 lea       stack ,a7             ; point a7 to this prgs stack

return_memory:
 pea      (a0)                      ; put addr that holds total size on stack
 pea      (a1)                      ; put addr that holds basepage addr
 move.l   #$4a0000,-(sp)           ; GEMDOS funct. m_shrink
 ; Note the above instr is a faster way of writing
 ; move.w d0,-(sp)     d0 holds dummy word var.
 ; move.w $#4a,-(sp)    function mshrink
 trap     #1
 lea      $c(sp),sp    ; reset stack, same as doing addq.l  #$c,sp






message:
 pea    header
 move.w   #9,-(sp)
 trap     #1
 addq.l   #6,sp






enter_supervisor:
 move.l   #0,-(sp)
 move.w   #$20,-(sp)
 trap     #1
 addq.l   #6,sp
 movea.l  d0,a5             ; save stack

install_routine:
 lea      $502,a0              ; fetch addr.Its addr that holds addr to
                               ; goto when ALT-HELP is pressed
 move.l   #code,(a0)           ; install


enter_user_mode:
 pea      (a5)
 move.w   #$20,-(sp)
 trap     #1
 addq.l   #6,sp

 move.w    #0,-(sp)             ; terminate and stay resident!
 move.l    a3,-(sp)
 move.w    #$31,-(sp)
 trap      #1

mainline:


code:


 clr.l    -(sp)       ; enter supervisor
 move.w   #$20,-(sp)
 trap     #1
 clr.l    $420        ; set _memvalid to false
 move.l   #4,a0       ; place address $4 in a0
 jmp      (a0)        ; jump to it!











 ;<your code goes here>


 ; end it with rts

;
; subroutines
;



 data
  ;<strings  dc.b etc >
            dc.l code
header:     dc.b $d,$a,'Cold_Boot! Installed v1.002  Jeff Bilger.'
            dc.b $d,$a,'Alt-Help to use',$d,$a,0
 bss
  ; block started by segment, all uninitalized data goes here
 align        ; but make sure its on word boundary!!

             ds.l         16       ; stack = 16 longwords!
stack:       ds.l         0        ; address of stack
program_end: ds.l         0
 end



 end

 