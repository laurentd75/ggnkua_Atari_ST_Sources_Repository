
' [ACC_TBOX.BAS]
' This source document is apart of the ENhanCed Hisoft ApplicatioN toolkiT (ENCHANT)
' Developed by Matthew Bacon & Paul Jones, � 1997-1999 Matthew Bacon & Paul Jones

DECLARE FUNCTION HandleFormClicks(button,clicks,kstate,x,y)		' Can be found in FORMWIND.BAS
DECLARE SUB HandleKeyboardEvent (key_pressed,kstate)			' Can be found in FORMWIND.BAS
DECLARE SUB WindowMessage										' Can be found in WINDOW.BAS
DECLARE SUB LoadRSC (rscfile$)									' Can be found in TOOLBX_C.BAS
DECLARE SUB AbortProgram										' Can be found in TOOLBX_C.BAS
DECLARE SUB AccOpened											' This should be written by you!
DECLARE SUB HandleUserMessages									' This should be written by you!
DECLARE SUB HandleUserKeys (ASCII$,key_pressed,kstate)			' This should be written by you!
DECLARE SUB HandleUserClicks (clicks,kstate,mx,my)				' This should be written by you!
DECLARE SUB HandleUserHook										' This should be written by you!

DEFINT a-z
LIBRARY "bios","gemaes","gemdos","gemvdi","xbios"
'LIBRARY "falcon","modplay","oop","networld","speedo","waveplay"  ' Optional libraries

REM Global variables that should be reset whenever your program is executed.
DIM SHARED junk,junk$,tree&,menutree&,desktree&,MyProgram$,allchange,supress_byte_align
DIM SHARED resource_loaded,Finished_Flag,Finished_DFlag,CommonObj,CommonClose,err_advice$
DIM SHARED menu_exititem,clicks_enabled,keys_enabled,menus_enabled,reset_dialog,debug_enabled
DIM SHARED HowManyButtons,CommonButton,forms_enabled,hook_enabled,hook_timeout

MyProgram$="" : allchange=0 : supress_byte_align=0
resource_loaded=0 : Finished_Flag=0 : Finished_DFlag=1 : CommonObj=0 : CommonClose=0
err_advice$="" : menu_exititem=0 : clicks_enabled=0 : keys_enabled=0 : menus_enabled=0
reset_dialog=0 : debug_enabled=0 : HowManyButtons=1 : CommonButton=0 : forms_enabled=0
hook_enabled=0 : hook_timout=1000

GOTO RETURN_HANDLER
REM $include gemaes.bh
REM $include toolbx_b.bas
REM $include toolbx_c.bas
REM $include toolbx_d.bas
REM $include dialog.bas
REM $include xdialog.bas
REM $include xalert.bas
REM $include fselect.bas
REM $include newdesk.bas
REM $include exec.bas
REM $include window.bas
REM $include textwind.bas
REM $include object.bas
REM $include formwind.bas
REM $include popup.bas

ERROR_HANDLER:
ErrorString$=ReportError$ (ERR)
IF ErrorString$="" THEN ErrorString$="Unknown - Sorry!"
button=form_alert(1,"[1][  "+MyProgram$+": |  ERROR: "+ErrorString$+" |  Try to tolerate or abort |  program? ][ Tolerate | Abort ]")
MOUSE 0
SELECT CASE button
	CASE 1 : ON ERROR GOTO ERROR_HANDLER : CALL ENCHANT_ACCloop
	CASE 2 : DeskACCOpen=0 : WINDOW STOP : STOP -1
END SELECT

REM Used as a decoy to make sure none of the sub-routines are executed until required!
RETURN_HANDLER:
ON ERROR GOTO ERROR_HANDLER


SUB Init_Menu (treeno,exititem)
' This is a dummy routine and is not needed
' when writing a desk accessory
END SUB

FUNCTION CreateShortCut (key_pressed,kstate)
' This is a dummy routine and is not needed
' when writing a desk accessory
END FUNCTION


SUB	HandleUserMenu (cur_front,item,title)
' This is a dummy routine and is not needed
' when writing a desk accessory
END SUB


SUB Handle_ACCMessage
SHARED mess(),DeskACCOpen
STATIC button,cur_front,item,title,MessageType

MessageType=mess(0)
IF (MessageType>=WM_TOPPED) AND (MessageType<=WM_MOVED) THEN
	IF NOT IsMyWindow(mess(3)) THEN EXIT SUB
END IF

junk=wind_get(mess(3),WF_TOP,cur_front,junk,junk,junk)
SELECT CASE MessageType
CASE AC_OPEN : WINDOW SYSTEM : CALL AccOpened : DeskACCOpen=-1
CASE wm_redraw TO wm_toolbar
	IF MessageType=WM_CLOSED THEN
		CALL WindowMessage : DeskACCOpen=0 : WINDOW STOP
	ELSE
		CALL WindowMessage
	END IF
CASE ELSE : HandleUserMessages
END SELECT
END SUB


SUB StartAccessory(BYVAL daname$,BYVAL rscfile$,BYVAL icontreeno)
SHARED mess(1),WindX,WindY,WindW,WindH,itreeno
STATIC id

IF PEEKW(PEEKL(GB+4))<>0 THEN
	DIM mess(20) : id=PEEKW(PEEKL(GB+4)+4)
	junk=menu_register(id,"  "+daname$)
	IF rscfile$<>"" THEN
		CALL LoadRSC (rscfile$)
		junk=wind_get(0,WF_WORKXYWH,WindX,WindY,WindW,WindH)
		IF icontreeno THEN itreeno=icontreeno
	END IF
ELSE
	AbortProgram "This program does not run from the Auto folder! - Press any key..."
END IF
END SUB


SUB ENCHANT_ACCloop
SHARED mess()
STATIC mclicks,mmask,mstate,mx,my,kstate,key_pressed,clicks,event

REDIM PRESERVE mess(20) : Finished_Flag=0 : CommonClose=0
IF HowManyButtons=1 THEN
	mclicks=2 : mmask=1 : mstate=1
ELSE
	mclicks=258 : mmask=3 : mstate=0
END IF

DO
	event=evnt_multi(MU_MESAG+MU_KEYBD+MU_BUTTON+MU_TIMER,mclicks,mmask,mstate,0,0,0,0,0,0,0,0,0,0,_
		VARPTR(mess(0)),hook_timeout,mx,my,CommonButton,kstate,key_pressed,clicks)

	IF event AND MU_KEYBD THEN HandleKeyboardEvent key_pressed,kstate
	IF event AND MU_MESAG THEN CALL Handle_ACCMessage

	IF event AND MU_BUTTON THEN
		IF forms_enabled=-1	THEN
			IF NOT HandleFormClicks(CommonButton,clicks,kstate,mx,my) THEN
				IF clicks_enabled THEN HandleUserClicks clicks,kstate,mx,my
			END IF
		ELSE
			IF clicks_enabled THEN HandleUserClicks clicks,kstate,mx,my
		END IF
	END IF
	IF hook_enabled<>0 THEN CALL HandleUserHook
LOOP UNTIL Finished_Flag<>0
END SUB

'[*END OF FILE*]
