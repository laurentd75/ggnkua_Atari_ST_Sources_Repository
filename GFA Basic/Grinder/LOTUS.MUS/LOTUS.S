* LOTUS MUSIC REPLAYER

                OPT D+

test            EQU 1

                IF test
                pea     super
                move.w  #$26,-(SP)
                trap    #14
                addq.l  #6,-(SP)

                clr.w   -(SP)
                trap    #1

super:          moveq   #0,D0
                bsr.s   music
                bsr.s   music+18
                move.l  #music+26,$04D2

m2:             move.w  #7,-(SP)
                trap    #1
                addq.l  #2,SP


                bsr.s   music+22
                clr.l   $04D2
                rts
                ENDC


music:          PATH 'A:\LOTUS.MUS'
                IBYTES 'LOTUS1.MUS'
                END
