 TEXT 
Begin:
      BRA       L0001 
L0000:DC.B      'CARS.REL',0
      DC.B      0 
L0001:DC.B      '/',15,'?<',0 
      DC.B      ' NA ',0
      DC.B      ' ',10
      LEA       -$5FF.W,A0
      MOVEQ     #0,D0 
      MOVEP.L   D0,0(A0)
      MOVEP.L   D0,8(A0)
      MOVEP.L   D0,16(A0) 
      MOVE.B    #$48,22(A0) 
      LEA       $60000,A7 
      LEA       -$7DC0.W,A0 
      MOVE.W    #7,D0 
L0002:CLR.L     (A0)+ 
      DBF       D0,L0002
      BSR       L0003 
      JMP       $664A0
L0003:MOVE.L    #$70000,-(A7) 
      TRAP      #$D 
      ADDQ.W    #4,A7 
      TST.W     D0
      BEQ.S     L0003 
      MOVE.W    #2,-(A7)
      MOVE.L    #L0000,-(A7)
      MOVE.W    #$3D,-(A7)
      TRAP      #1
      ADDQ.W    #8,A7 
      MOVE.W    D0,L0004
      MOVE.L    #$664A0,-(A7) 
      MOVE.L    #$20000,-(A7) 
      MOVE.W    #0,-(A7)
L0004 EQU       *-2 
      MOVE.W    #$3F,-(A7)
      TRAP      #1
      ADDA.W    #$C,A7
      MOVE.W    L0004,-(A7) 
      MOVE.W    #$3E,-(A7)
      TRAP      #1
      ADDQ.W    #4,A7 
      RTS 
ZUEND: END
