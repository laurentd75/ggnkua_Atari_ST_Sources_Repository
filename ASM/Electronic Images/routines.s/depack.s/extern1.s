*
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                *
* Ett tips, g�r inte logot f�r brett, jag rekommenderar cirka 280 pixels
*

r_x:            bra     xyz

hel:            dc.b $49,$20,$68,$61,$74,$65,$20,$70,$69,$72,$61,$63,$79,$2c,$20,$72,$65,$6d,$65,$6d,$62,$65,$72,$20,$74,$68,$61,$74,$20,$21,$20,$57,$74,$50,$20,$21

emling:         pea     null
                pea     null

exec_name:      pea     no_exist
                move.l  #$4b0000,-(sp)
                trap    #1
                lea     16(sp),sp

                clr.l   -(sp)
                trap    #1

xyz:            movea.l 4(sp),a0
                lea     stack,sp

*                move.l  12(a0),d0
*                add.l   20(a0),d0
*                add.l   28(a0),d0
*                add.l   #$1100,d0

                move.l  #$1100+(xyz-r_x),d0

                move.l  d0,-(sp)
                move.l  a0,-(sp)
                move.l  #$4a0000,-(sp)
                trap    #1
                lea     12(sp),sp
                tst.l   d0
                beq