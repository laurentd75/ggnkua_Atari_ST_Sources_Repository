
;      PROGRAM IV.....Print a single hexadecimal digit held in D0

       MOVE.B #5,D0

DIGIT  AND.L  #15,D0     ;Force number into range 0 to 15
       CMP    #9,D0      ;Compare D0 with 9
       BLE    NUMBER     ;If D0<=9 then goto number
       ADD    #7,D0      ;Increment digits >9 to characters A-F
NUMBER ADD    #48,D0     ;Add ASCII value of character '0' to number
       MOVE.W D0,-(A7)   ;Place this character onto the stack
       MOVE.W #2,-(A7)   ;Call GEMDOS routine CONOUT to print digit
       TRAP   #1
       ADD.L  #4,A7      ;Correct Stack

;      RTS               ;Use this if called from another program

       MOVE.W #0,-(A7)
       TRAP #1           ;Back to Desktop

       END

 