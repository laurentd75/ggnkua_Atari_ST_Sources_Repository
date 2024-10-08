IMPLEMENTATION MODULE WindTool;

(*
Window Tools.

UK __DATE__ __TIME__
*)

(*IMP_SWITCHES*)

FROM PORTAB   IMPORT UNSIGNEDWORD,SIGNEDWORD;
FROM RcMgr    IMPORT GRect,RcIntersect;
FROM GrafTool IMPORT HideMouse,ShowMouse;

IMPORT WindMgr,WindGet;

PROCEDURE BeginUpdate;

VAR D: BOOLEAN;

BEGIN
  D:= WindMgr.WindUpdate(WindMgr.BegUpdate);
END BeginUpdate;

PROCEDURE EndUpdate;

VAR D: BOOLEAN;

BEGIN
  D:= WindMgr.WindUpdate(WindMgr.EndUpdate);
END EndUpdate;

PROCEDURE ChkUpdate(): BOOLEAN;
BEGIN
  RETURN WindMgr.WindUpdate(WindMgr.ChkUpdate);
END ChkUpdate;

PROCEDURE BeginMouseControl;

VAR D: BOOLEAN;

BEGIN
  D:= WindMgr.WindUpdate(WindMgr.BegMCtrl);
END BeginMouseControl;

PROCEDURE EndMouseControl;

VAR D: BOOLEAN;

BEGIN
  D:= WindMgr.WindUpdate(WindMgr.EndMCtrl);
END EndMouseControl;

PROCEDURE ChkMCtrl(): BOOLEAN;
BEGIN
  RETURN WindMgr.WindUpdate(WindMgr.ChkMCtrl);
END ChkMCtrl;

PROCEDURE BeginEmergency;

VAR D: BOOLEAN;

BEGIN
  D:= WindMgr.WindUpdate(WindMgr.BegEmerg);
END BeginEmergency;

PROCEDURE EndEmergency;

VAR D: BOOLEAN;

BEGIN
  D:= WindMgr.WindUpdate(WindMgr.EndEmerg);
END EndEmergency;

PROCEDURE RedrawWindow(    Window: SIGNEDWORD;
                       VAR Clip  : GRect;
                           Draw  : DrawProc);

VAR Rect: GRect;

BEGIN
  BeginUpdate;
  HideMouse;

  WindGet.FirstXYWH(Window,Rect);
  WITH Rect DO
    WHILE (GW # 0) AND (GH # 0) DO
      IF RcIntersect(Clip,Rect) THEN
        Draw(Window,Rect);
      END;
      WindGet.NextXYWH(Window,Rect);
    END;
  END;

  ShowMouse;
  EndUpdate;
END RedrawWindow;

END WindTool.