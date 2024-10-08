***********************************************************************
* Main program for link file basic1.o , runs only in connection with  *
* this link file .     U.B. 11.85                                     *
* Draws random line in coordinate area 0-255. The value area          *
* is valid for both axis                                              *
***********************************************************************
          .globl    main
          .text


***********************************************************************
*  Entry point from the linkfile                                      *
***********************************************************************

main:     jsr       apinit         * Announce application
          jsr       grafhand       * 
          jsr       openwork       * Open screen work station 
          jsr       mouse_off      * Hide the Mouse
          jsr       clwork         * Clear Display

loop1:    jsr       clwork
          move.l    #text1,a0      * Address of text after A0
          jsr       printf         * Write text 
          move.l    loopc,d7

loop2:    jsr       random         * Generate random number 
          and.w     border,d0      * bring to area 0-255 
          move.w    d0,x0          * through masking out of the upper 
          jsr       random         * 8 Bits of the lower word in D0
          and.w     border,d0
          move.w    d0,y0
          jsr       random
          and.w     border,d0

          move.w    d0,x1
          jsr       random
          and.w     border,d0
          move.w    d0,y1

          move.w    x0,d2         * transfer the two points to the
          move.w    x1,a2         * "right" registers
          move.w    y0,d3
          move.w    y1,a3
          jsr       drawl         * Draw line from X0,Y0 to X1,Y1 sketch
          dbra      d7,loop2      * Repeat loopc

          jsr       inkey         * Sense keyboard, do not wait for key
          swap      d0            * activation, scancode in D0
          cmp.w     #$44,d0       * compare with code in F10
          bne       loop1         * If not : loop again
          rts                     * otherwise terminate program



***********************************************************************
*  Call the operating system function for creation of a 4-byte integer*
*  random number, the number is returned to D0.                       *
***********************************************************************

random:   move.w    #17,-(a7)     * generate a 4-Byte Integer-
          trap      #14           * Random Number in D0. Use only
          addq.l    #2,a7         * the lower 2-Bytes
          rts

          .data
          .even
**********************************************************************
*                      Variables for the Main program                *
*                                                                    *
**********************************************************************

**********************************************************************
* Text for the printf function, 27 Y 34 96 positions the cursor      *
* Sequence is column, line, both with an offset of 32                *
**********************************************************************


text1:    .dc.b     27,'Y',40,42,' Random lines ',0

loopc:    .dc.l     60         * Number of lines

border:   .dc.w     $ff        * 255 as display limit, with the high-
*                              * resolution B-W monitor the $ff
*                              * can be replaced with $1ff = 511
**********************************************************************

          .bss
          .even

x0:       .ds.w     1          * Temporary storage for the two
y0:       .ds.w     1          * Points, the program runs with small
x1:       .ds.w     1          * changes even without the intermediate
y1:       .ds.w     1          * storage; what changes ?

          .end


    