        TEXT 

        PEA       do_it
        MOVE.W    #$26,-(A7)  ;SUPEXEC
        TRAP      #$E 
        ADDQ.L    #6,A7 
        CLR.W     -(A7)       ;PTERMO
        TRAP      #1
        ILLEGAL
      
do_it:  MOVE.B    #$95,$FFFFFC00.W
        RTS 

