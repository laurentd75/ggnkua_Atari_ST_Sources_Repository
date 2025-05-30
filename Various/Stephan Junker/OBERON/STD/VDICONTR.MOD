MODULE VDIControl;

(* VDIControl also contains a routine to check is GDOS is installed.
   If a task leaves opened workstations, they will be closed automatically *)

(* changes :
author     |date     |change
----------------------------------------------------------------------------
S. Junker  |30.1.93  |correction for Oberon
----------------------------------------------------------------------------
*)

IMPORT S:=SYSTEM,VDI,Task,DCL:=DoubleChainedList,Error;

TYPE workin*    = RECORD
                    Id*          : INTEGER; (* 1 = screen *)
                    LineType*    : INTEGER;
                    LineColor*   : INTEGER;
                    MarkType*    : INTEGER;
                    MarkColor*   : INTEGER;
                    Font*        : INTEGER;
                    TextColor*   : INTEGER;
                    FillStyle*   : INTEGER;
                    FillPat*     : INTEGER;
                    FillColor*   : INTEGER;
                    KoorType*    : INTEGER;
                  END(*RECORD*);
     workout*   = RECORD
                    MaxX*,MaxY*       : INTEGER;
                    Scaled*  : INTEGER;
                    PixelW*,PixelH*   : INTEGER;
                    CharSno* : INTEGER;
                    LineTno*,LineWno* : INTEGER;
                    MarkTno*,MarkSno* : INTEGER;
                    Fontsno* : INTEGER;
                    Patno*   : INTEGER;
                    HatchTno*: INTEGER;
                    Colorno* : INTEGER;
                    GDPno*   : INTEGER;
                    GDPs*,GDPattr* : ARRAY 10 OF INTEGER;
                    Color*,Turn*,Fill*,Cell* : INTEGER;
                    NumColor*  : INTEGER;
                    Scrctrlno* : INTEGER;
                    Inputdevno*: INTEGER;
                    Keydevno*  : INTEGER;
                    Textdevno* : INTEGER;
                    StationType* : INTEGER;
                    CharWmin*,CharHmin*,CharWmax*,CharHmax* : INTEGER;
                    LineWmin*,z1,LineWmax*,z2 : INTEGER;
                    MarkWmin*,MarkHmin*,MarkWmax*,MarkHmax* : INTEGER;
                  END(*RECORD*);

     wkptr     = POINTER TO openedwk;
     openedwk  = RECORD(DCL.elem)
                   Fonts   : BOOLEAN;
                 END(*RECORD*);

VAR OpenedWk,OpenedVwk : wkptr;

PROCEDURE New(VAR List : wkptr; Handle : INTEGER);
 (* install new descriptor in list *)
  VAR wkp : wkptr;
 BEGIN
  NEW(wkp); DCL.New(List,wkp,Handle); wkp.Fonts := FALSE;
 END New;

PROCEDURE FillWorkout(VAR Workout : workout);
 (* fill Workout with data from VDI.Intout and VDI.Ptsout *)
 BEGIN
  S.MOVE( S.ADR(VDI.Intout), S.ADR(Workout), 90 );
  S.MOVE( S.ADR(VDI.Ptsout), S.ADR(Workout.CharWmin), 24 );
 END FillWorkout;

PROCEDURE VOpnwk*(VAR Workin : workin; VAR Handle : INTEGER;
                  VAR Workout : workout);
 BEGIN
  VDI.ParmBlk.Intin := S.ADR(Workin); VDI.Call(1,0,Handle,00060B2DH);
  VDI.ParmBlk.Intin := S.ADR(VDI.Intin); Handle := VDI.Contrl.Station;
  FillWorkout(Workout); New(OpenedWk,Handle);
 END VOpnwk;

PROCEDURE VUpdwk*(Handle : INTEGER);
 BEGIN
  VDI.Call(4,0,Handle,0);
 END VUpdwk;

PROCEDURE VClrwk*(Handle : INTEGER);
 BEGIN
  VDI.Call(3,0,Handle,0);
 END VClrwk;

PROCEDURE VstLoadFonts*(Handle,Select : INTEGER) : INTEGER;
  VAR i : INTEGER; e : wkptr;
 BEGIN
  VDI.Intin[0] := Select; VDI.Call(119,0,Handle,00000101H);
  IF DCL.Find(OpenedVwk,Handle,e) THEN e.Fonts := TRUE END;
  RETURN VDI.Intout[0];
 END VstLoadFonts;

PROCEDURE VstUnloadFonts*(Handle,Select : INTEGER);
  VAR i : INTEGER; e : wkptr;
 BEGIN
  VDI.Intin[0] := Select; VDI.Call(120,0,Handle,00000100H);
  IF DCL.Find(OpenedVwk,Handle,e) THEN e.Fonts := FALSE END;
 END VstUnloadFonts;

PROCEDURE DeleteStored(VAR List : wkptr; Handle : INTEGER);
  VAR p : wkptr;
 BEGIN
  IF DCL.Delete(List,Handle,p) THEN
    IF p.Fonts THEN VstUnloadFonts(Handle,0) END;
  ELSE Error.NumOut(-100)
  END(*IF*);
 END DeleteStored;

PROCEDURE VClswk*(Handle : INTEGER);
 BEGIN
  DeleteStored(OpenedWk,Handle); VDI.Call(2,0,Handle,0);
 END VClswk;

PROCEDURE VOpnvwk*(VAR Workin : workin; VAR Handle : INTEGER;
                   VAR Workout : workout);
  VAR i : INTEGER;
      Ptr : POINTER TO VDI.intarr;
 BEGIN
  VDI.ParmBlk.Intin := S.ADR(Workin); VDI.Call(100,0,Handle,00060B2DH);
  VDI.ParmBlk.Intin := S.ADR(VDI.Intin); Handle := VDI.Contrl.Station;
  FillWorkout(Workout); New(OpenedVwk,Handle);
 END VOpnvwk;

PROCEDURE VClsvwk*(Handle : INTEGER);
 BEGIN
  DeleteStored(OpenedVwk,Handle); VDI.Call(101,0,Handle,0);
 END VClsvwk;

PROCEDURE VsClip*(Handle : INTEGER; ClipOn : BOOLEAN; x1,y1,x2,y2 : INTEGER);
 BEGIN
  VDI.Intin[0] := LONG(S.VAL(SHORTINT,ClipOn));
  VDI.Ptsin[0] := x1; VDI.Ptsin[1] := y1;
  VDI.Ptsin[2] := x2; VDI.Ptsin[3] := y2;
  VDI.Call(129,0,Handle,02000100H);
 END VsClip;

PROCEDURE GDOSinstalled*() : BOOLEAN;
 (* returns TRUE if GDOS is installed *)
  VAR r : INTEGER;
 BEGIN
  S.PUTREG(0,LONG(-2)); S.INLINE(4E42H); S.GETREG(0,r); RETURN r # -2
 END GDOSinstalled;

PROCEDURE* CloseWk(Elem : wkptr);
 BEGIN
  IF Elem.Fonts THEN VstUnloadFonts(Elem.Handle,0) END;
  VDI.Call(2,0,Elem.Handle,0);
 END CloseWk;

PROCEDURE* CloseVwk(Elem : wkptr);
 BEGIN
  IF Elem.Fonts THEN VstUnloadFonts(Elem.Handle,0) END;
  VDI.Call(101,0,Elem.Handle,0);
 END CloseVwk;

PROCEDURE* CloseAll;
 BEGIN
  DCL.DeleteTask(OpenedWk,Task.Current,CloseWk);
  DCL.DeleteTask(OpenedVwk,Task.Current,CloseVwk);
 END CloseAll;

BEGIN
  Task.StoreExit(CloseAll);
END VDIControl.
