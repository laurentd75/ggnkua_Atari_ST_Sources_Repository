 ; Program Name: PRG_6CP.S
 ;      Version: 1.002

 ; Assembly Instructions:

 ;     Assemble in PC-relative mode and save with a TOS extension.

 ; Execution Instructions:

 ;     Execute from the desktop or from SPAWN.TTP.  This program uses traps
 ; installed by CUSTOM.PRG.

 ; Program Function:

 ;     Prints the content of register A7 during various stages of execution
 ; while the state of the processor is varied from user mode to supervisor
 ; mode, from supervisor mode back to user mode, from user mode to supervisor
 ; mode a second time and from supervisor mode back to user mode a second time.

 ;     In this program, GEMDOS function $20 is used to toggle the state of the
 ; processor.  Refer to pages 117 and 118 of the Internals book, under the
 ; $20 SUPER heading.  Aside from the fundamental methodology of function
 ; invocation, two important items of information are discussed there.

 ;     1. GEMDOS $20 transfers the address of the user stack to the supervisor
 ; stack pointer (SSP).  This means that while the processor is in the
 ; supervisor state, if that state was forced by invocation of GEMDOS $20,
 ; then the user stack is active and the supervisor stack is inactive.  This
 ; means that the user stack must be large enough to accomodate supervisor
 ; state activity.  Among other things, this activity includes the storage of
 ; the program counter and status register during exception processing.

 ;     2. Invocation of GEMDOS $20 can corrupt, and usually does as far as I can
 ; determine, registers A1 and D1.  Information in that section of the Internals
 ; book indicates that only this GEMDOS function can alter the values in those
 ; registers.

calculate_program_size:
 lea        -$102(pc), a1       ; Fetch basepage start address.
 lea        program_end, a0     ; Fetch program end address.
 trap       #6                  ; Return unused memory to op system.

print_heading:
 lea        heading, a0
 bsr        print_string

 ; NOTE: During this section of the program, no user stack has yet been
 ;       assigned, therefore, the user stack address is that of the default
 ;       user stack assigned by the system when execution commences.

print_address_of_default_user_stack:
 lea        header_1, a0
 bsr        print_string
 move.l     a7, d1              ; Convert address to ASCII hexadecimal.         
 trap       #5
 bsr        print_string
 bsr        print_newline

invoke_gemdos_super_mode_function:
 move.l     #0, -(sp)           ; The zero turns on supervisor mode.
 move.w     #$20, -(sp)         ; Function = super = GEMDOS $20.
 trap       #1                  ; Supervisor stack pointer (SSP) returned in D0.
 addq.l     #6, sp              ; SSP = address of supervisor stack.
 movea.l    d0, a5              ; Save SSP in scratch register.

print_SSP_returned_by_GEMDOS_20:
 lea        header_6, a0
 bsr        print_string
 move.l     a5, d1              ; Convert to ASCII hexadecimal.
 trap       #5
 bsr        print_string
 bsr        print_newline

print_current_SSP:              ; Did GEMDOS $20 alter the address in the
 lea        header_2, a0        ; supervisor stack pointer?
 bsr        print_string
 move.l     a7, d1              ; Convert to ASCII hexadecimal.
 trap       #5
 bsr.s      print_string
 bsr        print_newline
 bsr        print_newline

enter_user_mode:
 pea        (a5)                ; Restore supervisor stack pointer.
 move.w     #$20, -(sp)         ; Function = super = GEMDOS $20.
 trap       #1
 addq.l     #6, sp

 ; NOTE: During this section of the program, a user stack is assigned.  The
 ;       user stack address is that of the label "stack".

print_address_of_assigned_user_stack:
 lea        header_3, a0
 bsr.s      print_string
 lea        stack, a7
 move.l     a7, d1              ; Convert to ASCII hexadecimal.
 trap       #5
 bsr.s      print_string
 bsr.s      print_newline

invoke_gemdos_function_again:
 move.l     #0, -(sp)           ; The zero turns on supervisor mode.
 move.w     #$20, -(sp)         ; Function = super = GEMDOS $20.
 trap       #1                  ; Supervisor stack pointer (SSP) returned in D0.
 addq.l     #6, sp
 movea.l    d0, a5              ; Save SSP in scratch register.

print_SSP_returned_by_GEMDOS_20_again:
 lea        header_7, a0
 bsr        print_string
 move.l     a5, d1
 trap       #5
 bsr        print_string
 bsr        print_newline

print_current_SSP_again:
 lea        header_4, a0
 bsr.s      print_string
 move.l     a7, d1              ; Convert to ASCII hexadecimal.
 trap       #5
 bsr.s      print_string
 bsr.s      print_newline

enter_user_mode_again:
 pea        (a5)                ; Restore supervisor stack pointer.
 move.w     #$20, -(sp)         ; Function = super = GEMDOS $20.
 trap       #1
 addq.l     #6, sp

print_address_of_assigned_user_stack_again:
 lea        header_5, a0
 bsr.s      print_string
 move.l     a7, d1              ; Convert to ASCII hexadecimal.
 trap       #5
 bsr.s      print_string
 bsr.s      print_newline

terminate:
 trap       #8

 ;
 ; SUBROUTINES
 ;

print_string:         
 pea        (a0)
 move.w     #9, -(sp) 
 trap       #1        
 addq.l     #6, sp    
 rts

print_newline:
 lea        newline, a0
 bsr.s      print_string
 rts

 data
newline:   dc.b $D,$A,0
heading:   dc.b 'PRG_6CP Execution Results => Content of A7:',$D,$A,$D,$A,0
header_1:  dc.b   '  NO USER STACK ASSIGNED',$D,$A
           dc.b   '    Start of program:             ',0
header_2:  dc.b   '    After GEMDOS $20 invocation:  ',0
header_6:  dc.b   '    SSP returned by GEMDOS $20:    ',0
header_3:  dc.b   '  USER STACK ASSIGNED',$D,$A
           dc.b   '    After force to user mode:     ',0
header_4:  dc.b   '    After GEMDOS $20 invocation:  ',0
header_7:  dc.b   '    SSP returned by GEMDOS $20:    ',0
header_5:  dc.b   '    After force to user mode:     ',0
 bss
 align
               ds.l   96
stack:         ds.l    0
program_end:   ds.l    0
 end
 