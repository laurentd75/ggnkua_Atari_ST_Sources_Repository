;       WWM EYE MANIPULATION ROUTINES
BLINK:
        JSR     DRAWEYES        ; CLOSE EYES
        MOVE.L  #4-1,D7         ; WAIT 4/60THS OF A SECOND
        JSR     DELAY
        JSR     DRAWEYES        ; OPEN EYES
        MOVE.L  #20-1,D7        ; WAIT 1/3 OF A SECOND
        JSR     DELAY
        RTS

;       DRAWEYES        TOGLES EYES
DRAWEYES:
        LEA     EOREYES,A1
        LEA     SCREEN1BASE+(44*160)+(5*8),a0
        move    #71-44-1,d1       ; COPY & DISPLAY EYES
copy1:
        move    #((14-5)*2)-1,d0
copy:
        MOVE.L  (A1)+,D3
        EOR.L   D3,(A0)+
        dbra    d0,copy
        add.l   #(160-((14-5)*8)),a0
        dbra    d1,copy1
        RTS
        END
 