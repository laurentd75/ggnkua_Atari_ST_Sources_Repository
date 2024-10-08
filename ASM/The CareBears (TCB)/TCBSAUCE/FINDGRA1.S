          BRA       MAIN




LOADFIL:  CLR.W     -(SP)
          MOVE.L    D0,-(SP)
          MOVE.W    #$3D,-(SP)
          TRAP      #1
          ADDQ.L    #8,SP
          MOVE.W    D0,HANDLE
          MOVE.L    D1,-(SP)
          MOVE.L    D2,-(SP)
          MOVE.W    HANDLE,-(SP)
          MOVE.W    #$3F,-(SP)
          TRAP      #1
          ADD.L     #12,SP
          MOVE.W    HANDLE,-(SP)
          MOVE.W    #$3E,-(SP)
          TRAP      #1
          ADDQ.L    #4,SP
          RTS

LOADFILS: MOVE.L    #FILENAME,D0
          MOVE.L    #BUFFER,D1
          MOVE.L    #$7FFFFFFF,D2
          BSR       LOADFIL
          RTS








INITVARS: 
          MOVE.W    #4,-(SP)
          TRAP      #14
          ADDQ.L    #2,SP
          MOVE.W    D0,OLDRES
          MOVE.W    #2,-(SP)
          TRAP      #14
          ADDQ.L    #2,SP
          MOVE.L    D0,PHYSADDR

          CLR.L     -(SP)
          MOVE.W    #$20,-(SP)
          TRAP      #1
          ADDQ.L    #6,SP
          MOVE.L    D0,SAVESTCK
          CLR.W     -(SP)
          MOVE.L    PHYSADDR,-(SP)
          MOVE.L    PHYSADDR,-(SP)
          MOVE.W    #5,-(SP)
          TRAP      #14
          ADDA.L    #12,SP

          MOVEA.L   #SPALETTE,A0
          MOVEM.L   $FF8240,D0-D7
          MOVEM.L   D0-D7,(A0)
          MOVEA.L   #PALETTE,A1
          MOVEM.L   (A1),D0-D7
          MOVEM.L   D0-D7,$FF8240

          BSR       LOADFILS

          RTS
            
ENDP:     
      

          MOVE.W    OLDRES,-(SP)
          MOVE.L    PHYSADDR,-(SP)
          MOVE.L    PHYSADDR,-(SP)
          MOVE.W    #5,-(SP)
          TRAP      #14
          ADD.L     #12,SP

          MOVE.L    #$FF8240,A0
          MOVE.L    #SPALETTE,A2
          MOVEM.L   (A2),D0-D7
          MOVEM.L   D0-D7,(A0)
            
            
            
          MOVE.L    SAVESTCK,-(SP)
          MOVE.W    #$20,-(SP)
          TRAP      #1
          ADDQ.L    #6,SP
            

          RTS

            
            
MAIN:     
          BSR       INITVARS


          MOVEA.L   #BUFFER,A0
          ADDA.L    #16000,A0
          MOVEA.L   PHYSADDR,A1
          MOVEQ.L   #19,D1
OMM1:     MOVE.L    A1,-(SP)
          MOVE.L    #199,D0
OMM2:     MOVE.L    (A0)+,(A1)
          MOVE.L    (A0)+,4(A1)
          ADDA.L    #160,A1
          DBRA      D0,OMM2
          MOVE.L    (SP)+,A1
          ADDQ.L    #8,A1
          DBRA      D1,OMM1
OMM3:     CMP.B     #185,$FFFC02
          BNE       OMM3

  
UTM1:     BSR       ENDP
            
          RTS


           
            







            
            


PHYSADDR: DS.L      1

FILENAME: DC.B      '\STARRAY.DEM\STATUS2.SQU',0,0


BUFFER:   DS.L      10000

SPALETTE: DS.L      8
PALETTE:  DC.W      0,$730,$700,$730,$700,$730,$700,$730
          DC.W      $700,$730,$700,$730,$700,$730,$700,$730

HANDLE:   DS.L      1

OLDPHYS:  DS.L      1
OLDRES:   DS.W      1
SAVESTCK: DS.L      1
          END
 