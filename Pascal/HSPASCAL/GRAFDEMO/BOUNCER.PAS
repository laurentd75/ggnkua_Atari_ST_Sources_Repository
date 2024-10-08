Program Bouncer;

Uses EasyGraf;

{ Filename: Bouncer.pas       }
{ Coder   : Jacob V. Pedersen }
{ Coded   : 4-8-1990          }
{ Purpose : Example           }

{ The mouse is not shown if you enter .TOS in the OPTIONS/Linker dialog }

{ Runtime commands are:

        [+] Increaces the size of the tail.
        [-] Decreaces the size of the tail.
        [C] Clears the screen.
        [F] Freezes the program.
        [ ] Set cleanup of tail to On/Off               }

Const
        AbsMax  = 200;                      { Max. number of lines. }
Var
        Brain   : Array[1..AbsMax, 1..4] OF Integer;
        Maxs,
        Coors   : Array[1..4] OF Integer;
        Direcs  : Array[1..4] OF Boolean;
        Cur_Max : Integer;                  { Current max. lines. }
        Drawn   : Integer;                  { Number of drawn lines. }
        CleanUp : Boolean;



Procedure DelargeTail;
Begin
  If (Cur_Max > 1) AND (CleanUp) THEN
    Begin
      LineColor(0);
      Line(Brain[1,1],Brain[1,2],Brain[1,3],Brain[1,4]);
      Dec(Drawn);
      Dec(Cur_Max);
      Move(Brain[2],Brain[1],8*Drawn);
    End;
End; { DelargeTail }


Procedure EnlargeTail;
Begin
  If (Cur_Max < AbsMax) THEN
    Inc(Cur_Max);
End; { EnlargeTail }


Procedure CheckTail;
Begin
  If (Drawn > Cur_Max) THEN
    Begin
      If (CleanUp) THEN
        Begin
          LineColor(0);
          Line(Brain[1,1],Brain[1,2],Brain[1,3],Brain[1,4]);
          Move(Brain[2],Brain[1],8*Cur_Max);
        End;
      Dec(Drawn);
    End;
End; { CheckTail }


Procedure CalculateCoors;
Var
        X : Byte;

Function CheckMax : Boolean;
Begin
  If (Coors[x] = Maxs[x]) and (Direcs[x]) then
   Begin
     Direcs[x] := False;
     CheckMax := True;
   End
 ELSE
   CheckMax := False;
End; { CheckMax }


Procedure MakeMin;
Begin
  If (Coors[x] = 0) and Not Direcs[x] then
    Direcs[x] := True;
End; { MakeMin }


Procedure Adjust;
Begin
  If (X = 1) then
    Begin
      If (Direcs[x]�t1�6���t%;Gt�7��N�t;Ot�N�t�O
�� @t���Ë�PPVW������� &����3���_^�� ���v�v�v
��?� ���u+��X�>  uV��A� ���>  uWV+�P�f��؉^��? u-�~ t'WV� P�M��؉^��? uW�6���A� P+�P�2��F��F���� �v�H��t�^�_�w�v
�v�v�rA� �+������^&�w&�w&�w
+�P�B��F��t�؃? t+���^&�w
�lB� = s�^&�O@�^&� @t0&�w&�w��?� P�^&�w
��A� P� P���F��t�؃? u��@ P�^&�G$ P��e� ���t��v�v�D
P� P�i8��t"�t ��?� �D�tK+��D"�D �D�T�F��V��tQ�^�&�? u
+��D�D�>�@ PS�$^� @P��e� ���u�t�+A� V��g� ��W�v��v��T^� �ǉD�\�DNK�t��A� �D����6�� ����v
�v�v+�P�����t�< u+���� u�V�;�� ��s��~ u���F�v�v
�v+�P���F��t�؋�F��u2�v�v
��?� P�v��A� P� P�2��F��t�؋�F��u+��2�F�
 P�v�v� P�i8��^�F&�G
�F
�V&�G&�W� �����v�|�E
 tV�{z��D�u+���E
@t�} u+�P�{z��E�t� ����v�F� �F�  �F�  V�C��u+��m�F�F�F�F�F�F��F�F܋F% �= @u�t��v"�v �v
� P�v ��F��t��؋�F��t��FP����@ P�^��G> P��e� ���FP����t���w��E�F��E�F�V�
          ' ' : Begin
                  If (CleanUp = False) THEN
                    ClearDevice;
                  CleanUp := NOT(CleanUp);
                End;
          'C' : ClearDevice;
          'F' : Dummy := ReadKey;
          ELSE Exit;
        END;
      Until (Not(KeyPressed));
    Move( Coors, Brain[Drawn], 8 );
  Until False;
End; { Lets_Bounce }


BEGIN { main }
  Randomize;
  InitGraphics;
  ClearDevice;
  Lets_Bounce;
  DeInitGraphics
END.
