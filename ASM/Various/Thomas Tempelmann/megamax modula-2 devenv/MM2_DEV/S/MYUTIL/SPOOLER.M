MODULE Spooler;
(*$Q-*)

(* ---------------------------------------------------------- *)
(* Copyright (c) 1985, 1986, 1987.Modula-2 Software Ltd.  UK  *)
(*                           and  TDI Software, Inc.      USA *)
(* ---------------------------------------------------------- *)

(* Spooler desk accessory.

   Original Author : PLC, Modula-2 Software Ltd,. UK

   Version         : 0.00b  24-Apr-86  PLC, Modula-2 Software Ltd.
                       Fixed Alloc bug.
                     0.00a  13-Mar-86  PLC, Modula-2 Software Ltd.
                       Original.

*)

(* Spooler information.

   This is a small spooler desk accessory to show how limited multitasking
   can be accomplished under GEM and how a desk accessory can be programmed.
   The 512 byte stack allocated by the runtime support is ample for this
   accessory. After linking, rename SPOOLER.PRG to SPOOLER.ACC using the
   file menu "Show Info" option. Copy SPOOLER.ACC to a boot disk and reboot
   the system. The Spooler should install itself in the Desk menu.
*)


FROM SYSTEM IMPORT ADR, ADDRESS;
FROM GEMEnv IMPORT SelectFile, InitGem, DeviceHandle, RC, ApplicationID;
FROM AESMenus IMPORT RegisterAcc;
FROM GEMGlobals IMPORT MButtonSet, MouseButton, GemChar, SpecialKeySet;
FROM GrafBase IMPORT Rect, Pnt, Rectangle, Point;
FROM AESEvents IMPORT MultiEvent, EventSet, RectEnterMode, Event,
                accOpen, MessageBuffer;
FROM AESForms IMPORT FormAlert;
FROM GEMDOS IMPORT Alloc, Free, Open, Close, Read, Seek, PrnOS, PrnOut,
  beginning, end;

(*$Q+*)

CONST
  MaxPrinterSpeed = 200;  (* 80 cps. Could handle higher rates *)

CONST
  (* number of milliseconds to wait for next character output *)
  SensePeriod = 1000 DIV MaxPrinterSpeed;

CONST
  Title = "  Spooler";

VAR
  applID: CARDINAL;  (* desk application ID *)
  menuID: INTEGER;  (* menu ID *)
  Msg: MessageBuffer;
  handle: INTEGER;
  events: EventSet;
  i, place: CARDINAL;
  path: ARRAY [0..39] OF CHAR;
  file: ARRAY [0..19] OF CHAR;
  printing: BOOLEAN;  (* TRUE if currently printfile a file *)
  adr: ADDRESS;  (* base address of file memory buffer *)
  prnadr: POINTER TO CHAR;
  length: LONGINT;  (* length of file, and of memory block *)

PROCEDURE DoSpool(VAR x: ARRAY OF CHAR): BOOLEAN;
VAR res: CARDINAL;
  li: LONGINT; lc: LONGCARD;
BEGIN
  (* open file *)
  Open(x,0,handle);
  IF handle <= 0 THEN
    FormAlert(1,"[2][File not found][ OK ]",res);
    RETURN FALSE
  END;

  (* get file length *)
  Seek(0,handle,end,length);
  Seek(0,handle,beginning,li);

  (* grab some memory for the file buffer *)
  Alloc(length,adr);
  IF adr = 0L THEN                                               (*0.00b*)
    (* not enough memory... *)
    IF Close(handle) THEN END;
    FormAlert(1,"[1][Not enough memory][ OK ]",res);
    RETURN FALSE
  END;

  (* read file into buffer *)
  lc := length;
  Read(handle,lc,adr);
  IF Close(handle) THEN END;

  (* take care of read errors *)
  IF lc # LONGCARD (length) THEN
    FormAlert(1,"[2][Read error][ OK ]",res);
    RETURN FALSE
  END;

  (* set print start address in memory, return "good spool request" *)
  prnadr := adr;
  RETURN TRUE
END DoSpool;


VAR ok: BOOLEAN; gem: DeviceHandle; titel: ARRAY [0..20] OF CHAR;
    x: CARDINAL;
    point: Point; mbset: MButtonSet; skset: SpecialKeySet; gemch: GemChar;
    evset: EventSet;

BEGIN
  (* initialise application & install desk accessory *)
  InitGem (RC, gem, ok);
  titel:= Title;
  RegisterAcc (ADR (titel), applID, ok);

  printing := FALSE;
  LOOP
    (* set event flags according to print status. This stops the
       accessory from soaking up processor time waiting for a tick
       when it isn't printing. *)
    IF printing THEN events := EventSet{message, timer};
    ELSE events := EventSet{message}
    END;
    MultiEvent (events, 0, MButtonSet{}, MButtonSet{},
                lookForEntry, Rect (0,0,0,0),
                lookForEntry, Rect (0,0,0,0),
                Msg,
                SensePeriod,
                point, mbset, skset, gemch,
                x, evset);
    IF message IN evset THEN
      (* got a message *)
      IF (Msg.msgType = accOpen) THEN
        IF printing THEN
          FormAlert(2,"[3][Already spooling][ STOP | OK ]",x) ;
          IF x = 1 THEN (* STOP *)
            printing := FALSE;
            (* free memory allocated to file buffer *)
            IF Free(adr) THEN END
          END
        ELSE
          path := "A:\*.*";
          file[0] := 0C;

          (* open up file selector *)
          SelectFile (path,file,ok);

          IF ok THEN
            (* OK and no error, strip off ambiguous file specification *)
            i := 0;
            place := 0;
            WHILE path[i] # 0C DO
              IF path[i] = "\" THEN place := i END;
              INC(i)
            END;

            (* put filename onto end of path to get full specification *)
            i := 0;
            WHILE file[i] # 0C DO
              path[place] := file[i];
              INC(place); INC(i)
            END;
            path[place]:= 0C;

            (* see if we can spool it *)
            printing := DoSpool(path)
          END
        END
      END
    ELSIF timer IN evset THEN
      (* timer event occured *)
      IF PrnOS() THEN
        (* printer waiting for character *)
        IF LONGCARD(prnadr)-LONGCARD(adr) = LONGCARD (length) THEN
          (* come to end of buffer, stop printing *)
          printing := FALSE;
          (* free memory allocated to file buffer *)
          IF Free(adr) THEN END
        ELSE
          PrnOut(prnadr^);  (* print buffer character *)
          INC(prnadr)       (* advance to next buffer position *)
        END
      END
    END
  END
END Spooler.
 
(* $00000EFD$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$000015AD$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4$FFF8CAF4�$0000146BT.......T.......T.......T.......T.......T.......T.......T.......T.......T.......$FFF6D7DC$0000059E$000015A1$0000146B$00001077$000014FF$FFF6D7DC$FFF6D7DC$00000F95$00000F76$00000F83$0000109F$000010B4$FFF6D7DC$0000109F$000005A0���*)
