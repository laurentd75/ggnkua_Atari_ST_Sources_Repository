IMPLEMENTATION MODULE ScsiDisk;
(****************************************************************************
 *
 *
 * $Source: /dev/e/hm2/lib/se\RCS\SCSIDISK.M,v $
 *
 * $Revision: 1.3 $
 *
 * $Author: Steffen_Engel $
 *
 * $Date: 1996/02/14 00:00:26 $
 *
 * $State: Exp $
 *
 *****************************************************************************
 * History:
 *
 * $Log: SCSIDISK.M,v $
 * Revision 1.3  1996/02/14  00:00:26  Steffen_Engel
 * Korrektur: cMaxBlockAdr mu� 1FFFFF sein!
 *
 * Revision 1.2  1996/02/03  19:34:02  S_Engel
 * Kleine Anpassungen
 *
 * Revision 1.1  1995/11/13  23:36:28  S_Engel
 * Initial revision
 *
 *
 *
 ****************************************************************************)


(* Systemabh�ngiges *)
(* IMPLEMENTATION F�R  >>> H�nisch-Modula-2 <<< *)
(*                                              *)
(* Durchgef�hrt von Steffen Engel               *)
(*                                              *)
(*$S-   Stack-Checks                            *)
(*$I-   keine Variablen-Initialisierung         *)
(*$V-   keine arithmetischen Kontrollen         *)
(*$T-   kein Bereichstest                       *)
(*$Y-   keine Laufzeittests auf RETURN und CASE *)
(*                                              *)
(*----------------------------------------------*)



IMPORT SYSTEM, System;
FROM SYSTEM   (* Type  *) IMPORT BYTE, ADDRESS,
              (* Proc  *) ADR, TSIZE;

FROM Portab IMPORT UChar, Char;

(* Standard HM2-Libs *)

(* Eigene Libs *)

(* Projektlibs *)
IMPORT Scsi, ScsiIO;
FROM Scsi IMPORT Cmd6, Cmd10, Cmd12, SetCmd6, SetCmd10, SetCmd12, SetCmd, BlockLen, MaxDmaLen;




PROCEDURE Read6(BlockAdr : LONGCARD;























PROCEDURE Read10(BlockAdr : LONGCARD;

















PROCEDURE Write6(BlockAdr : LONGCARD;






















PROCEDURE Write10(BlockAdr : LONGCARD;


















CONST
    cMaxBlockAdr     =  001FFFFFH; (* Max. Blocknummer bei Read(6)/Write(6)  *)

PROCEDURE Read(BlockAdr : LONGCARD;
               TransferLen : SHORTCARD; Adr : ADDRESS) : BOOLEAN;

BEGIN
  IF (BlockAdr > cMaxBlockAdr)
    THEN
      RETURN Read10(BlockAdr, TransferLen, Adr);
    ELSE
      RETURN Read6(BlockAdr, TransferLen, Adr);
    END;
END Read;

PROCEDURE Write(BlockAdr : LONGCARD;











PROCEDURE StartStop(LoadEject, StartFlag : BOOLEAN) : BOOLEAN;














PROCEDURE Seek6(BlockAdr : LONGCARD) : BOOLEAN;






PROCEDURE Seek10(BlockAdr : LONGCARD) : BOOLEAN;






PROCEDURE Seek(BlockAdr : LONGCARD) : BOOLEAN;










PROCEDURE Format() : BOOLEAN;









PROCEDURE ReadCapacity(PMI : BOOLEAN; VAR BlockAdr, BlockLen : LONGCARD) : BOOLEAN;


























END ScsiDisk.