; ***********************************************
; *                                             *
; *                 T O S . Q                   *
; *                                             *
; *   Makros f�r die wichtigsten BIOS-, XBIOS-  *
; *   und GEMDOS-Funktionen                     *
; *   (c) 1992 MAXON Computer                   *
; ***********************************************

DOTRAP        macro   %\trap, %\fct
            ; %\trap: Nr. des Trap
            ; %\fct: <2-stellig: Fkt>
            ;        <2-stellig: #Bytes f�r
            ;         Stack-Korrektur nach trap>
              move.w  #(\fct/$100),-(sp)
              trap    #\trap
stk@          =\fct-$100*(\fct/$100)
              IFNE    0,stk@
              IFHI    8,stk@
              lea     stk@(sp),sp
              ELSE
              addq.l  #stk@,sp
              ENDIF
              ENDIF
              endm

ERR_BRA       macro   $\label
              tst.w   d0
              blt     \label
              endm
              
TSTL_ERR_BRA  macro   $\label
              tst.l   d0
              blt     \label
              endm
              
Rwabs         equ     DOTRAP 13,$040e
Setexc        equ     DOTRAP 13,$0508
Getbpb        equ     DOTRAP 13,$0704
Bcostat       equ     DOTRAP 13,$0804
Mediach       equ     DOTRAP 13,$0904
Kbshift       equ     DOTRAP 13,$0b04

Floprd        equ     DOTRAP 14,$0814
Flopwr        equ     DOTRAP 14,$0914
Flopfmt       equ     DOTRAP 14,$0a1a
Mfpint        equ     DOTRAP 14,$0d08
Protobt       equ     DOTRAP 14,$120e
Flopver       equ     DOTRAP 14,$1314
Cursconf      equ     DOTRAP 14,$1506
Settime       equ     DOTRAP 14,$1606
Gettime       equ     DOTRAP 14,$1702
Kbdvbase      equ     DOTRAP 14,$2202
Supexec       equ     DOTRAP 14,$2606
Floprate      equ     DOTRAP 14,$2906

Pterm0        equ     DOTRAP 1,$0000
Cconin        equ     DOTRAP 1,$0102
Cconout       equ     DOTRAP 1,$0204
Cprnout       equ     DOTRAP 1,$0504
Crawcin       equ     DOTRAP 1,$0702
Cconws        equ     DOTRAP 1,$0906
Cconrs        equ     DOTRAP 1,$0a06
Cprnos        equ     DOTRAP 1,$1102
Dgetdrv       equ     DOTRAP 1,$1902
Fsetdta       equ     DOTRAP 1,$1a06
Super         equ     DOTRAP 1,$2006
Tgetdate      equ     DOTRAP 1,$2a02
Tsetdate      equ     DOTRAP 1,$2b04
Tgettime      equ     DOTRAP 1,$2c02
Tsettime      equ     DOTRAP 1,$2d04
Fgetdta       equ     DOTRAP 1,$2f02
Ptermres      equ     DOTRAP 1,$3100
Dcreate       equ     DOTRAP 1,$3906
Ddelete       equ     DOTRAP 1,$3a06
Dsetpath      equ     DOTRAP 1,$3b06
Fcreate       equ     DOTRAP 1,$3c08
Fopen         equ     DOTRAP 1,$3d08
Fclose        equ     DOTRAP 1,$3e04
Fread         equ     DOTRAP 1,$3f0c
Fwrite        equ     DOTRAP 1,$400c
Fdelete       equ     DOTRAP 1,$4106
Fseek         equ     DOTRAP 1,$420a
Fattrib       equ     DOTRAP 1,$430a
Fdup          equ     DOTRAP 1,$4504
Fforce        equ     DOTRAP 1,$4606
Dgetpath      equ     DOTRAP 1,$4708
Malloc        equ     DOTRAP 1,$4806
Mfree         equ     DOTRAP 1,$4906
Mshrink       equ     DOTRAP 1,$4a0c
Pexec         equ     DOTRAP 1,$4b10
Pterm         equ     DOTRAP 1,$4c00
Fsfirst       equ     DOTRAP 1,$4e08
Fsnext        equ     DOTRAP 1,$4f02
Frename       equ     DOTRAP 1,$560c
Fdatime       equ     DOTRAP 1,$570a

              END
 
