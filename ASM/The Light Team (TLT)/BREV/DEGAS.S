; ***************************************************************
; *     DEGAS .PI1 DISPLAY ROUTINE, CODED BY TDB/TLT 890208     *
; *     SPECIALLY DEDICATED TO FRESH/TLT, HOPE YA ENJOY IT!     *
; ***************************************************************

 MOVE.W #4,-(SP)
 TRAP #14
 ADDQ.L #2,SP
 MOVE.W D0,REZ

 MOVE.W #0,-(SP)
 MOVE.L #-1,-(SP)
 MOVE.L #-1,-(SP)
 MOVE.W #5,-(SP)
 TRAP #14
 ADD.L #12,SP

 MOVE.W #2,-(SP)
 TRAP #14
 ADDQ.L #2,SP
 MOVE.L D0,SCREEN

 CLR.L -(SP)
 MOVE.W #$20,-(SP)
 TRAP #1
 ADDQ.L #6,SP
 MOVE.L D0,SUPER

 MOVEM.L $FF8240,D0-D7
 MOVEM.L D0-D7,SAVECOL
 
 MOVE.L #$FF8240,A0
 MOVE.L #7,D7
BLACKOUT:
 CLR.W (A0)+
 DBRA D7,BLACKOUT

 MOVE.L #GRAFBUF,A0
 ADD.L #34,A0			; 128 for .NEO pictures!
 MOVE.L SCREEN,A1
 MOVE.W #7999,D7
COPY:
 MOVE.L (A0)+,(A1)+
 DBRA D7,COPY

 MOVEM.L GRAFBUF+2,D0-D7 	; GRAFBUF+4 for .NEO pictures!
 MOVEM.L D0-D7,$FF8240

 MOVE.W #7,-(SP)
 TRAP #1
 ADDQ.L #2,SP

 MOVE.L #$FF8240,A0
 MOVE.L #7,D7
BLACKOUT2:
 CLR.W (A0)+
 DBRA D7,BLACKOUT2

 MOVE.L SCREEN,A0
 MOVE.L #7999,D7
CLEAR:
 CLR.L (A0)+
 DBRA D7,CLEAR

 MOVEM.L SAVECOL,D0-D7
 MOVEM.L D0-D7,$FF8240

 MOVE.L SUPER,-(SP)
 MOVE.W #$20,-(SP)
 TRAP #1
 ADDQ.L #6,SP

 MOVE.W REZ,-(SP)
 MOVE.L #-1,-(SP)
 MOVE.L #-1,-(SP)
 MOVE.W #5,-(SP)
 TRAP #14
 ADD.L #12,SP

 CLR.W -(SP)
 TRAP #1


GRAFBUF: 		INCBIN PICTURE.PI1
SCREEN:			DC.L 0
HANDLE:			DC.W 0
SUPER:			DC.L 0
REZ:			DC.W 0
SAVECOL:		DS.W 16
 END
