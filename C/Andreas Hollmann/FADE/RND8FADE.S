;******************************************************************************
;*        RND8FADE - Byte wise fading between two screens                     *
;*        with Pseudo-random numbers                by Andreas Hollmann       *
;*    (c) 1992 MAXON Computer GmbH                                            *
;******************************************************************************
GLOBL  rnd8fade;

rnd8fade:   movea.l   4(sp),a0        ;fetch src_adr 
            movea.l   8(sp),a1        ;fetch dst_adr 

            move.w    #31999,d7       ;How many Bytes will be copied
            moveq     #1,d0           ;Load Sliding-Register with Start value of 1
;------------------------------------------------------------------------------
;Production of Pseudo-random numbers with a return linked Sliding register:
;
calc_rnd:   btst      #0,d0           ;1st  handle out (Bit 0)
            beq.s     bits0x          ;falls Bit=0 ->

bits1x:     btst      #1,d0           ;2nd  handle out (Bit 1)
            beq.s     bits10
bits11:     lsr.l     #1,d0           ;no Bit set, because 1 eor 1 = 0 
            bra.s     chk_rnd
bits10:     lsr.l     #1,d0
            bset      #14,d0          ;while 1 eor 0 = 1 
            bra.s     chk_rnd

bits0x:     btst      #1,d0           ;2nd handle out (Bit 1)
            beq.s     bits00
bits01:     lsr.l     #1,d0
            bset      #14,d0          ;while 0 eor 1 = 1 
            bra.s     chk_rnd
bits00:     lsr.l     #1,d0           ;no Bit set, while 0 eor 0 = 0
;------------------------------------------------------------------------------
chk_rnd:    cmpi.w    #31999,d0       ;Random number only from 0-31999 !
            bhi.s     calc_rnd        ;otherwise new random number...

            move.w    #20,d6          ;delaying value
delay:      dbra      d6,delay        ;delaying-loop

            move.b    0(a0,d0.w),0(a1,d0.w) ;copy 1 Byte 
            dbra      d7,calc_rnd
;------------------------------------------------------------------------------
prg_end:    rts
            END
