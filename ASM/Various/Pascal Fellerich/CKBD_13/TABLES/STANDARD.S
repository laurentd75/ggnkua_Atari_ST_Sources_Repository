*******************************************************************************
*
* This is the assembler source for the standard compose table used by CKBD
*
*   This file contains no keyboard mapping tables!
*
* Assembler: TurboAss 1.7.x
*
* �3/1994 by P. Fellerich
*

               output 'Standard.CKB'
*
* default output mode is 'BASIC' which is simple binary without any header
*
               default 6

               >PART 'Defines'
*
* These defines are taken from CKBD.H
*
INQUIRE        equ -1
OFF            equ 0
ON             equ 1
SET            equ 2

DEC_MODE       equ 0
MULTICHAR      equ 2
ORDERINDIFF    equ 0
ORDERSENS      equ 4

               endpart
               >PART 'CKB_Header'
*
* This is the CKB file header
*
* 1. LONG magic:
id:            dc.b "CKBD"

*
* 2. The name of the table. Maximum 12 chars, must be padded with null bytes
*    to exactly 12 bytes.
*                   '123456789012'
name:          dc.b 'Standard GER' ; Name: exakt 12 Zeichen!!

*
* 3. The offsets to the keyboard mapping and compose tables. If a given table
*    is not present it's offset must be zero.
*
unshift_offset:dc.w 0			;unshift-id  if used
shift_offset:  dc.w 0			;shift-id    if used
caps_offset:   dc.w 0			;caps-id     if used
compose_offset:dc.w compose-id

*
* 4. Setup-Words. These words are only read out if the table is autoloaded by
*    CKBD. The magic $BAD0 in the first word is used to indicate that there are
*    more configuration words to follow.
*
compose_mode:  dc.w $0BAD|DEC_MODE|ORDERINDIFF|ON

*
* 5. more config words (not read by older versions of ckbd.prg).
*
;only if compose_mode && 0xFFF0 == 0xBAD0
               dc.w ON        		;ExtKey ON
               dc.w OFF       		;Alt-NNN OFF
               dc.w ON        		;Deadkeys ON
               dc.b "`'^""/,|~",0	;use these characters
               even

               endpart
               >PART 'keyboard mapping tables'

unshift:		;
shift:			; NOT USED; CKBD will substitute the system default!
caps:			;

               endpart
               >PART 'Compose Character Tabelle'
*
* COMPOSED CHARACTERS - TABELLE:
* Format is:
*   typedef struct {
*       char    primary;        /* first character plus... */
*       char    secondary;      /* ...second character */
*       char    composed;       /* becomes _composed_char_ ! */
*       char    flags;          /* reserved! (Flags) */
*   } comptab[];
*
compose:
	dc.b "O-�",0
	dc.b "++#",0
	dc.b "aa@",0
	dc.b "AA@",0
	dc.b "(([",0
	dc.b "//\",0
	dc.b "))]",0
	dc.b "(-{",0
	dc.b "/^|",0
	dc.b ")-}",0
	dc.b "C,�",0
	dc.b 'u"�',0
	dc.b 'u��',0
	dc.b "e'�",0
	dc.b "a^�",0
	dc.b 'a"�',0
	dc.b 'a��',0
	dc.b "a`�",0
	dc.b "a.�",0
	dc.b "a��",0
	dc.b "c,�",0
	dc.b "e^�",0
	dc.b 'e"�',0
	dc.b 'e��',0
	dc.b "e`�",0
	dc.b 'i"�',0
	dc.b 'i��',0
	dc.b "i^�",0
	dc.b "i`�",0
	dc.b 'A"�',0
	dc.b 'A��',0
	dc.b "A.�",0
	dc.b "A��",0
	dc.b "E'�",0
	dc.b "ae�",0
	dc.b "Ae�",0
	dc.b "AE�",0
	dc.b "o^�",0
	dc.b 'o"�',0
	dc.b 'o��',0
	dc.b "o`�",0
	dc.b "u^�",0
	dc.b "u`�",0
	dc.b 'y"�',0
	dc.b 'y��',0
	dc.b 'O"�',0
	dc.b 'O��',0
	dc.b 'U"�',0
	dc.b 'U��',0
	dc.b "c/�",0
	dc.b "C/�",0
	dc.b "c|�",0
	dc.b "C|�",0
	dc.b "l-�",0
	dc.b "L_�",0
	dc.b "l_�",0
	dc.b "L-�",0
	dc.b "y-�",0
	dc.b "y=�",0
	dc.b "Y-�",0
	dc.b "Y=�",0
	dc.b "Pt�",0
	dc.b "pt�",0
	dc.b "f-�",0
	dc.b "a'�",0
	dc.b "i'�",0
	dc.b "o'�",0
	dc.b "u'�",0
	dc.b "n~�",0
	dc.b "N~�",0
	dc.b "a-�",0
	dc.b "a_�",0
	dc.b "o-�",0
	dc.b "o_�",0
	dc.b "??�",0
	dc.b "12�",0
	dc.b "14�",0
	dc.b "!!�",0
	dc.b "<<�",0
	dc.b ">>�",0
	dc.b "a~�",0
	dc.b "o~�",0
	dc.b "O/�",0
	dc.b "o/�",0
	dc.b "O|�",0
	dc.b "o|�",0
	dc.b "oe�",0
	dc.b "Oe�",0
	dc.b "OE�",0
	dc.b "A`�",0
	dc.b "A~�",0
	dc.b "O~�",0
	dc.b ' "�',0
	dc.b " '�",0
	dc.b " +�",0
	dc.b "PP�",0
	dc.b "pp�",0
	dc.b "P|�",0
	dc.b "p|�",0
	dc.b "p/�",0
	dc.b "P/�",0
	dc.b "co�",0
	dc.b "CO�",0
	dc.b "ro�",0
	dc.b "RO�",0
	dc.b "tm�",0
	dc.b "TM�",0
	dc.b "ij�",0
	dc.b "IJ�",0
	dc.b "Ij�",0
	dc.b "so�",0
	dc.b "SO�",0
	dc.b " ^�",0
	dc.b "oo�",0
	dc.b "OO�",0
	dc.b "ss�",0
	dc.b "PI�",0
	dc.b "pi�",0
	dc.b "SS�",0
	dc.b "u/�",0
	dc.b "u|�",0
	dc.b "=-�",0
	dc.b "+-�",0
	dc.b ">-�",0
	dc.b "<-�",0
	dc.b ">_�",0
	dc.b "<_�",0
	dc.b ">=�",0
	dc.b "<=�",0
	dc.b ":-�",0
	dc.b "=~�",0
	dc.b "o �",0
	dc.b "* �",0
	dc.b ". �",0
	dc.b "v �",0
	dc.b "n �",0
	dc.b "2 �",0
	dc.b "3 �",0
	dc.b "_ �",0

	dc.l 0				; end of table!

COMPTABSIZE    equ (*-comptab)/4-1

	if (*-compose)>1024
	fail 'Compose table too long!!'
	endc
	endpart

