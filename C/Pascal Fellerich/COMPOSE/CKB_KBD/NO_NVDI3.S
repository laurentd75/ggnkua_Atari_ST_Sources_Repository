*******************************************************************************
*
* This is the assembler source for the standard compose table for CKBD
*   without the NVDI 3 specific extensions. If you don't use NVDI3, you
*   should install this table using the CPX module to avoid the generation
*   of 'bad' characters (e.g. uppercase accents IUEOA �ΐ�� ���ʶ)
*
*   This table does not reassign the keyboard layout.
*
* Assembler: TurboAss 1.7.x
*
* �2/1992, 3/1994, 1/1996 by P. Fellerich
*

               output 'NO_NVDI3.CKB'
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

ORDER          equ 1
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
name:          dc.b 'No NVDI 3.x',0 ; Name: exakt 12 Zeichen!!

*
* 3. The offsets to the keyboard mapping and compose tables. If a given table
*    is not present it's offset must be zero.
*
unshift_offset:dc.w 0
shift_offset:  dc.w 0
caps_offset:   dc.w 0
compose_offset:dc.w compose-id

               endpart
               >PART 'Compose Character Tabelle'
*
* COMPOSED CHARACTERS - TABELLE:
*   ST-Charset, without NVDI 3 extension from 192...222(DEC Multinational mode)
* Format is:
*   typedef struct {
*       char    primary;        /* first character plus... */
*       char    secondary;      /* ...second character */
*       char    composed;       /* becomes _composed_char_ ! */
*       char    flags;          /* reserved! (Flags) */
*   } comptab[];
*
               even
compose:
; combination, DEC-Ascii code, Null  ; TOS Ascii or description
               dc.b "++#",0   ;35
               dc.b "aa@",0   ;64
               dc.b "AA@",0
               dc.b "(([",0   ;91
               dc.b "//\",0   ;92
               dc.b "))]",0   ;93
               dc.b "(-{",0   ;123
               dc.b "/^|",0   ;124
               dc.b ")-}",0   ;125
               dc.b "DE",ORDER ;127 DELTA
               dc.b "De",ORDER
               dc.b "C,�",0   ;128
               dc.b 'u"�',0   ;129
               dc.b 'u��',0
               dc.b "e'�",0   ;130
               dc.b "a^�",0   ;131
               dc.b 'a"�',0   ;132
               dc.b 'a��',0
               dc.b "a`�",0   ;133
               dc.b "a.�",0   ;134
               dc.b "a��",0
               dc.b "c,�",0   ;135
               dc.b "e^�",0   ;136
               dc.b 'e"�',0   ;137
               dc.b 'e��',0
               dc.b "e`�",0   ;138
               dc.b 'i"�',0   ;139
               dc.b 'i��',0
               dc.b "i^�",0   ;140
               dc.b "i`�",0   ;141
               dc.b 'A"�',0   ;142
               dc.b 'A��',0
               dc.b "A.�",0   ;143
               dc.b "A��",0
               dc.b "E'�",0   ;144
               dc.b "ae�",ORDER ;145
               dc.b "AE�",ORDER ;146
               dc.b "Ae�",ORDER
               dc.b "o^�",0   ;147
               dc.b 'o"�',0   ;148
               dc.b 'o��',0
               dc.b "o`�",0   ;149
               dc.b "u^�",0   ;150
               dc.b "u`�",0   ;151
               dc.b 'y"�',0   ;152
               dc.b 'y��',0
               dc.b 'O"�',0   ;153
               dc.b 'O��',0
               dc.b 'U"�',0   ;154
               dc.b 'U��',0
               dc.b "c/�",0   ;155
               dc.b "C/�",0
               dc.b "c|�",0
               dc.b "C|�",0
               dc.b "L_�",0   ;156
               dc.b "L-�",0
               dc.b "l-�",0
               dc.b "l_�",0
               dc.b "Y-�",0   ;157 Yen
               dc.b "y-�",0
               dc.b "Y=�",0
               dc.b "y=�",0
               dc.b "ss�",0   ;158 German Eszet
               dc.b "f-�",0   ;159 Florin
               dc.b "a'�",0   ;160
               dc.b "i'�",0   ;161
               dc.b "o'�",0   ;162
               dc.b "u'�",0   ;163
               dc.b "n~�",0   ;164
               dc.b "N~�",0   ;165
               dc.b "a_�",0   ;166 a underscore (not NVDI)
               dc.b "a-�",0
               dc.b "o_�",0   ;167 o underscore (not NVDI)
               dc.b "o-�",0
               dc.b "??�",0   ;168
               dc.b "12�",ORDER ;171
               dc.b "14�",ORDER ;172
               dc.b "!!�",0   ;173
               dc.b "<<�",0   ;174
               dc.b ">>�",0   ;175
               dc.b "a~�",0   ;176
               dc.b "o~�",0   ;177
               dc.b "O/�",0   ;178
               dc.b "O|�",0
               dc.b "o/�",0   ;179
               dc.b "o|�",0
               dc.b "oe�",ORDER ;180
               dc.b "OE�",ORDER ;181
               dc.b "Oe�",ORDER
               dc.b "A`�",0   ;182
               dc.b "A~�",0   ;183
               dc.b "O~�",0   ;184
               dc.b '" �',0   ;185
               dc.b "` �",0   ;186
               dc.b "+ �",0   ;187
               dc.b "PP�",0   ;188
               dc.b "pp�",0
               dc.b "P|�",0
               dc.b "p|�",0
               dc.b "p/�",0
               dc.b "P/�",0
               dc.b "co�",0   ;189
               dc.b "CO�",0
               dc.b "ro�",0   ;190
               dc.b "RO�",0
               dc.b "tm�",0   ;191
               dc.b "TM�",0
               dc.b "ij�",ORDER ;ij ligature (not defined in NVDI 3 mapping)
               dc.b "IJ�",ORDER ;ij ligature (not defined in NVDI 3 mapping)
               dc.b "Ij�",ORDER
               dc.b "so�",ORDER ;221
               dc.b "SO�",ORDER
               dc.b "oo�",ORDER ;223
               dc.b "OO�",ORDER
               dc.b "al�",ORDER ;224 alpha
               dc.b "AL�",ORDER
               dc.b "be�",ORDER ;225 beta
               dc.b "BE�",ORDER
               dc.b "ga�",ORDER ;226 GAMMA
               dc.b "GA�",ORDER
               dc.b "pi�",ORDER ;227 pi
               dc.b "PI�",ORDER
               dc.b "SI�",ORDER ;228 SIGMA
               dc.b "SS�",ORDER
               dc.b "si�",ORDER ;229 sigma
               dc.b "u/�",0   ;230 my
               dc.b "u|�",0
               dc.b "my�",ORDER
               dc.b "MY�",ORDER
               dc.b "ta�",ORDER ;231 tau
               dc.b "TA�",ORDER
               dc.b "ph�",ORDER ;232 PHI
               dc.b "PH�",ORDER
               dc.b "O-�",0   ;233 THETA
               dc.b "TH�",ORDER
               dc.b "th�",ORDER
               dc.b "OM�",ORDER ;234 OMEGA
               dc.b "om�",ORDER
               dc.b "de�",ORDER ;235 delta
               dc.b "=-�",0   ;240
               dc.b "+-�",0   ;241
               dc.b ">-�",0   ;242
               dc.b ">_�",0
               dc.b ">=�",0
               dc.b "<-�",0   ;243
               dc.b "<_�",0
               dc.b "<=�",0
               dc.b ":-�",0   ;246
               dc.b "=~�",0   ;247
               dc.b "o �",0   ;248
               dc.b "* �",0   ;249
               dc.b ". �",0   ;250
               dc.b "v �",0   ;251
               dc.b "n �",0   ;252
               dc.b "2 �",0   ;253
               dc.b "3 �",0   ;254
               dc.b "_ �",0   ;255
               dc.l 0         ;total 157 Eintr�ge

COMPTABSIZE    equ (*-compose)/4-1

MAXTABSIZE     equ 256

               if COMPTABSIZE>MAXTABSIZE
               fail 'Compose table too long!!'
               endc

               endpart
               end
