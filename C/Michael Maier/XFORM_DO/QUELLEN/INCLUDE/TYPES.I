* -------------------------------------------------- *
*
*               XFORMDO.LIB Version 1.2
*
*          geschrieben von Michael Maier 1991
*
* -------------------------------------------------- *

* -------------------------------------------------- *
* Headerdatei: TYPES.I
* Version: 1.0
* Datum: 14.9.1991
* -------------------------------------------------- *

TURBOC  EQU     1

*
* Schalter:
* TURBOC definieren, wenn TC-Version erw�nscht
* ASS    definieren, wenn ER-Version erw�nscht
* DR1    definieren, wenn DR-Version mit eigenen Feldern erw�nscht
* DR2    definieren, wenn DR-Version mit externen Feldern erw�nscht
* Nur EIN Schalter darf definiert werden!
*
        IFD     TURBOC
ASSTC   EQU     1               ER und TC mit Register�bergabe
TCDR1   EQU     1
CREGS   REG     D3-D7/A2-A6
        ENDIF

        IFD     ASS
ASSTC   EQU     1
CREGS   REG     D1-D7/A0-A6
        ENDIF

        IFD     DR1
DR      EQU     1               DR1 und DR2 �ber STACK
TCDR1   EQU     1
CREGS   REG     D1-D7/A0-A6
        ENDIF

        IFD     DR2
DR      EQU     1
CREGS   REG     D1-D7/A0-A6
        ENDIF

        OPT     K+
        OPT     D-,X-,B+,P+,S+,Q+,A+,C+,M+,T+,Z+,V+

TRUE    EQU     1
FALSE   EQU     0
FAIL    EQU     -1

GEMDOS  EQU     1
XBIOS   EQU     14
BIOS    EQU     13

