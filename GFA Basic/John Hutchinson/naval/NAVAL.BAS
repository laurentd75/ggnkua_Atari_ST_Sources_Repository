 GfABASIC       �  |  �  �    6  6  6  �  �  �  �  �  �  k�  l�  n�  n�  n�  o4  oX  oX  oX  o�  pd  pd  pd  pdSNDLPLAYXYZRNUM
TIME_LIMITTIMEAUTOC_HITP_HITSHOTWINNERLPSTURNOKGXGYHPVPGOODFXFYSHIPDBOX_XSUNKHTOUCHY1QAF1F2FBFFBBBUFPHENOMESPEECHBPAGEPRGRESBUTTONMP_BTNV_BTNQ_BTNOPTON1OFF2OFF1ON2ONOFFE_OFFC_ONA_OFFE_ONC_OFFA_ONEMPTYGAME_BOX	SCORE_BOX	P1_SCREEN	P2_SCREENTALKTIME_BOXSCORERED_BOXATPIXPOSVERT_ON	HORIZ_OFFVERT_OFFHORIZ_ONSPHSVSBLUE_BOXOK_BOXPIX1PIX2RANKHALLGREY_BOXQBPHENOMESPEECHRESPALLINSCANDELOWDEMEDOLDPALFBUFPMSGOPTIONS_BOXPOSITION_BOXPLAY_BTN	VISIT_BTNQUIT_BTN	ENSIGN_ON
ENSIGN_OFF
CAPTAIN_ONCAPTAIN_OFF
ADMIRAL_ONADMIRAL_OFFITSHIPKSPEECHPHENOMESCANDELOWDEMEDOLDSZXBXPRESCAN_TALKMUTEHIPGCGPSCSTSAPXPYLPSLSP_HITC_HITSUNKSCOREPPALHI_SCORETEMPPLOT NAMEHPIXVPIXHITMISSSHIP INITMAINAI_1SHOOT	START_AI1UPDATEAI_2	PICK_SHOTAI_3V_CHECKH_CHECKPICK_P_SHOTFINISHNO_WAYSELECT_COORDSPLACE_SHIPSPIX_DATASPRITE_DATASPEECH_DATASORRYHEIDI 
GET_COLORSINIT_SPRITESSETUP_SCREENINIT_SPEECHDO_MSGTALKDO_QUITFAME_BOX	AUTO_PLOTMANUAL_PLOTDO_OKPLAYEREVALUATECOMPUTERDO_NEWCOORDSLOG_TO_PHYSBOOM
ON_HIT_BOXSCORESPLASH	BLANK_MSGDO_PAUSEBELLHANDLE_SOUNDPHYS_TO_LOGRESTORE_COLORS	CATCH_BUGPLOT_EM	CHECK_FIT	TRAP_DISK
READ_DEGASLOWMEDHIGH	GET_DEGASGET_LOWGET_HIGHDUMMYHANDLE_PAUSEHANDLE_QUIT
HANDLE_NEW	HANDLE_OKREAD_PIXHIT_BOXSORRY_NO_SPEECH8  * NAVAL BATTLE ST *  by John L. <Hutch> Hutchinson $  Copyright 1988 Antic Publishing F  Note:  Remove all desk accessories if running on 1/2 Mb machines! &*� � !�� !�� F   High score datat,*��      !��      F  Ship graphicsN*��   @�    !��   @�    F  Pg=Player Grid; Cg=Computer GridP*��   @�    !��   @�    F  Ps=Player Shots; Cs=Computer Shots.*��      !��pp   @� F  Color palettes**�	�      !�
�      F  Ship lengths6*��      !��      !�� F   Hit/sunk counters 6*��   @�    !��      F  Temporary arrays6*��      !��      F  Computer 1st hit record0*��@@    !��@@    F  Hit/miss graphicsa*��      F  Ship namesM� Fp ň� E�G�    F Q��  !�
�  F
	�p� F�B  PT BOAT,2, SUBMARINE,3, DESTROYER,3,BATTLESHIP,4,  CARRIER,5 M�F   Initialize sprites� E�F#�F!  Red line color Ƅ��NAVLBATL.DAT FE7�I!M�!�NAVLBATL.DATF �z�E�G�FL0:M�!� � !�� F  Read high scores from disk
	�@�F!8M�F F M�F  Setup playfieldh�F  ��X� � *�  F �E�F ��FM�E�FF-M�FO� E�WELCOME TO NAVAL BATTLEFM�FW@M���WELCOME TO NAIVAL BATTLE! F  Use phonetics if necessary{�     FO
 �X�FYM�-F�F-� E�  WANT TO PLAY A GAME? FM�F M���WUNT TO PLAY A GAME? F!{� p   F }�F  Pointing fingerL�F �E�F&F "  Get choices from intro screenU"�!�!�F 
 ���FF0 ����Y   � ���  � ��$   �F �R��@   �F�E�FF > Ȣ��s   � ���  � ��-   � ��;   �FM�(F}�F�F F " ����~   � ��   �FM�F�F F F 
���F~j�=!�>!�?F� &� |F
#  Loop back here for new games"J� !�F  Fill arrays with zerosJ� !�FJ� !�FJ� !�FJ� !�FJ� !�F
J� !�FF
J� !�FFJ� !�FJ� !�F�E�F�E�F�E�F$j�	!�
!�!�!�!�F  Set to zeroP�E�     F!�E�F6 �� E�G�    Fr  Set Largest Player Ship array �	�  E�
�  F
	�� F 6�� S   �!�$$   �!�;F   Show the Options box� E�  SELECT YOUR OPTIONSFM�F $M���PLEAZE SELECT YOUR OHPTIONS F}�F�F (F "  Get the player's option choicesGF "�!�!�FS����FS" ����   � ��1   �F* ���   �F  Number of players  ˊ��   �F�E�F��    �!�``   �!�F��� �  �!�``   �!�F�F  ����  �F�E�F��    �!�``   �!�F��� �  �!�``   �!�F��� 
�  �!�hh   �!�	F �
E�FF F " ����
   � ��   �F, ����   � ��:   �F  Sound  ̒� �F � E�F�� 
�  �!�   �!�
F� ̺F � E�F�� 
�  �!�   �!�	F�F {� `   F�F 0 �L��<   � ��d   �F  Time Limit�E�F ͒��F �� 
�  �!�>>   �!�	F��� �  �!�   �!�AF �� �  �!�   �!�BF �� �  �!�''   �!�EF �E�F �<F �� 
�  �!�>>   �!�
F�2� �  �!�   �!��  �!�   �F�� �  �!�   �!�BF 2� �  �!�''   �!��  �!�11   �F�E�FF {� `   F�F 6 ����d   � ��   � ��F�  Auto-Plot  κ�
�F �
E�F�� 
�  �!�hh   �!�
F� ��F �
E�F�� 
�  �!�hh   �!�	F�F {� `   F�F F  ����FR ����   � ���  � ��2   � ��   �F  Difficulty Level ����   �F�E�F�� �  �!�   �!�@FT�� �  �!�   �!�CF �� �  �!�''   �!�EF F " �R��   � ��(   �F�E�F�� �  �!�   �!�AF �� �  �!�   �!�BF �� �  �!�''   �!�EF F  ����(   �F�E�F�� �  �!�   �!�AF �� �  �!�   �!�CF �� �  �!�''   �!�DF F F F F B��� �� c   � ��   � ��8   � ��E   �F0��    �!�     �!�Fs  Erase the grid�E�FM�F 
I� !� F�E�FF "  Plot the ships��    �!�     �!�F 
 ��
F�� S   �!�$$   �!�F � E�COMPUTER PLOTTING SHIPSFM�FC M���NOW PLOHTING THE- SHIPS FM�F{�     FP �(F M�	FFF  ҄��FL� E�IS THIS ARRANGEMENT OK?FM�FI"M���ISSS THIS ARANGEMENT OK? FM�*FF 
 ҜZ��F�z��FH� E� LET THE BATTLE BEGIN!F M�F "M���SO LET THE BATTLE BEGIN! F{� H   FE
I� !� F0�� S   �!�$$   �!�Fu  Show game boxb Ӗ��F($� \   !�$   !��  !�x   F�:�� \   !�(   !�F  IF color, show custom score boxF ��F�  Save player 1 screen��    �!�     �!�F (��F  Save computer/player 2 screen �E�F  �|F#  Where the action is...F M�F M�F 
 �hZ��F �\��F!M�F�M�F�F �(��F!M�)F Ԅ��F!M�(FF  +�F��	E�F*�E�F   Change to computer/player 2 turn26� `   !�!�!�`   Fs  Set grid color to blue��F�  Show player 1's grid� E�    COMPUTER'S TURNFM�F M���IT'S MY TURRN F{�     F  �|F , ۪��F  If no "working hits" yet...e$ ����F  If ENSIGN, play dumbF M�F�4ծ��@� �F  Don't shoot at a square twicey-�F�F < �^�� #��     U������ F  If ADMIRAL,play smartaF M�F��2��@� � ��@� �F-�F�F F M�F�D�b��@� � #�� �%#�� � Fw  Maintain "checkerboard"f�E�F�E�F ,�|F�  Check Horiz and Vert possible fits�E�F�E�F ג� E�G��F& �|�� �F  Prevent array errort, �n��� @� �F  Check Horiz fit left4�F��E�F �xF�E�FF F 
גZ��F
	�� F� �� E�G��F ��� �    F. ����� @� �F  Check Horiz fit righth4�F��E�F �F�E�FF F 
�Z��F
	ע� F� �Z��F$�E�F  First possible Horiz fit�E�F�F  ��� E�G��F ���� �F* ض��@��  �F  Check Vert fit upn4�F��E�F ��F�E�FF F 
��Z��F
	�j� F� �d� E�G��F �N�� �    F, �@��@��  �F  Check Vert fit downo4�F��E�F �JF�E�FF F 
�dZ��F
	��� F� ٠��F$�E�F�  First possible Vert fitp�E�F�F 8 ���� ��F  If largest ship fits both ways...-�F  Go shoot at it!iF  $�|F�  Get next square in pattern �B��    F
�E��F  ��F��E�F �h��   F4�F� �rF�E�FF H ��##�� � #%#�� �  F  Maintain checkerboard search pattern4�F#F F 0 ���@� �Ft  Skip if already shot heree-�F� ۦF8 �~�� ��F  If entire grid has been checked...�E�F��E�F�(-�F�  Go shoot at first possible fit ۢF� -�F  Otherwise keep lookingF F F  �|FF, ���Fe  Computer has 1 "working hit"
�E�� F�
�E�� F��E��@� FF�E�F�E�F, ܶ� E�G�
� �Fp  Check Horiz fit left ܠ�� �F6 ܒ#��� @� �  #��� @� ���� @� � F4�F#�E�F ܜF��E�FF F 
ܶZ��F
	�:� F�. �h� E�G�
� �F   Check Horiz fit right �R�� �    F�6 �D#��� @� �  #��� @� ���� @� � F4�F#�E�F �NF��E�FF F 
�hZ��F
	��� F�, �� E�G�
� �F   Check Vert fit above ���� �F6 ��#��@��  �  #��@��  ���@��  � F4�F#�E�F ��F��E�FF F 
�Z��F
	ݔ� F�, ��� E�G�
� �Fr  Check Vert fit below ު�� �    F�6 ޜ#��@��  �  #��@��  ���@��  � F4�F#�E�F ަF��E�FF F 
��Z��F
	�<� F� �|F�,�EV�     F  Pick random shot direction�E�F( ����
�  ��F  Ship fits horiz �E�F� �v�� ��F �r���@� �F�E��F   Shoot left�E�FF F  ����    ��F �����@� �F��E��F�  Shoot righti�E�FF F F & ����
�  ��F  Ship fits vert�E�F� �B�� ��F �>��@�� �F��E��F   Shoot up�E�FF F  ����    ��F ����@�� �F��E��Fr  Shoot down�E�FF F F  ���F-�F� �F-�FFF F  �|FF. ���Ft  Computer has 2+ "working hits"�E��� @��  F� �,�� �� F
�E�� F�-�	F�F  �
|F�  Horiz checks
�E�� F� ��� �F 6 ���� �@� � #��� �@� ���� �@� � F�E�� �F�-�F�F F  ��� �   F#6 ���� �@� � #��� �@� ���� �@� � F�E�� �F�-�F�F F  �p�� �F@6 �l��� �@� � #��� �@� ���� �@� � F�E�� �F�-�F�F F  ���� �   F#6 ����� �@� � #��� �@� ���� �@� � F�E�� �F�-�F�F F  �2�� �F@6 �.��� �@� � #��� �@� ���� �@� � F�E�� �F�-�F�F F  ��� �   F#6 ���� �@� � #��� �@� ���� �@� � F�E�� �F�-�F�F F  ���      �FJ ����      �@� � #���     �@� ����      �@� � F�E��      �F-�F�F F  ���      �    F J ����      �@� � #���     �@� ����      �@� � F�E��      �F-�F�F F  �	|F  Vert checks ��� �F 6 ���@�� � � #��@�� � ���@�� � � F�E�� �F�-�F�F F  �v�� �   F#6 �r��@�� � � #��@�� � ���@�� � � F�E�� �F�-�F�F F  ���� �F 6 ����@�� � � #��@�� � ���@�� � � F�E�� �F�-�F�F F  �8�� �   F#6 �4��@�� � � #��@�� � ���@�� � � F�E�� �F�-�F�F F  ��� �F 6 ���@�� � � #��@�� � ���@�� � � F�E�� �F�-�F�F F  ���� �   F#6 ����@�� � � #��@�� � ���@�� � � F�E�� �F�-�F�F F  �x��      �FJ �t��@��     � � #��@��     � ���@��      � � F �E��      �F-�F�F F  ����      �    F#J ����@��     � � #��@��     � ���@��      � � F �E��      �F-�F�F F F  �|F�M�F��E��@� FF& �>��Fo  Computer scored a hittM�F���@� E�FF4�F�
M�,�� F� ��
� �F 
�� E�F
�� E�F  �F   Computer sunk a ship�E�F4�� F
�	� E�F.�Ev�	� !�	� !�	� !�	�      !�	�       F�
�E�� F�E�F
J� !�F 
J� !�F F M�F �F"  Computer missedsM�FF��@� E�F	� E�     I MISSED YOU!F!�E�I MISSED YOU!FF M�FI
M��� FS{� p   FSM�F ��F .F  +�F �E#�� �Fu  Change turni$ �.��FF  If 2 player game...t"� E�    PLAYER A� �'S TURNF �E� F  �hF � E� IT'S YOUR TURN, HUMANFR�E� IT'S YOUR TURRNFUF  ���FY.6� `   !�!�    !�Fg  Set grid to greeni��F 4�F  ��F ,6� `   !�!�!�`   Fg  Set grid to blue��F F M�F 
M��� F�{�     F�* �l� F   Speed things up if no sounde� E�    FIRE WHEN READYFM�F 
M���  FI{�     FIF  �|F "}� `   F�  Hollow cross shape�F " ���  �F  Create timer soundy�!�     !�!�    !�Fsz�!�!� @   !�Z�  �!�FF F " �(S� FF  Check the keyboardM�'FF "�!�!�F!�F " �$�FF  Increment the timer>�    �!�   ��	�!��  �!�   ��	�F8 ��� ��F  Kludge for monochrome ADMIRAL timer 4�    	!�   �	��!��  	!�   �	��FF 0�	!#�LL������ F	�F F @�����	� ,   F   Until a button pushed or out of time�F z�!�F ���	�,   F M�F�� E�  YOU RAN OUT OF TIME!FRM�F �E� FO-�FFF > ���X   � ��   � ��$   � ��B   �F2 �6��   � ��4   �F  QUIT buttonM�(FF 2 �r��   � ��2   �F  SOUND buttonM�F�F 2 ���   � ��2   �F  PAUSE buttonM�'FF 0 ����   � ��4   �F  NEW buttonM�)FF M�F�}� `   F -�F F ,M�F�  Convert physical to logical coords@ �z����    ����   F  If out of bounds...-�F�F ,M�F�  Convert logical to physical coords* �J#�� ��@� � #�� ��@� � F"�|F  If shot there before...cM�F#� E�YOU CAN'T SHOOT THERE!FRM�FYM���	TRY AGAIN F{� H   FAM�F -�F F " �T��Fl  If human player #1* ���@� �Fr  Player scored a hitd,�E��@� Fr  What kind of ship was it?*��@� E�FW  Modify player shot array&4�� F  Increment ship hit counter*M�,���  F  Light up the hit indicatorM�F�( ��� �
� F  Player sunk a ship�E�F4�� F
�E�� F
�� E�F
F M�FE �*F   Player missede��@� E�F M�F� ����FF� E� YOU MISSED ME, HUMAN!FR �FY� E�       YOU MISSED!F F �E�
YOU MISSEDFEF M�FY-�FY ��F"  If human player #2 ����@� �F �E��@� F ��@� E�F 4�� FM�,���  FM�F� ���� �
� F�E�F4�� F
�E�� F
�� E�F
F M�FE �"F���@� E�F M�F�� E�    YOU MISSED!F�E�
YOU MISSEDFEF M�FY �|FY
M��� FI{� H   FIM�F 6�� �  �!�     �!�Fe  Reset timer graphics ���F$��F�  Get the new player screens ��F ��F F F �	E�F.F  +�F L�� E�� %##� @   � �H   #� J   � � #�� #�H   �	  F
�E�� F* �r��    F   Adjust odd phenomesm�E�	BATTLSHIPFF  ����FH�E�
SUBMUHREENF F  ����FR�E�P T BOATFFF 
 ���FB� E�   �� � SUNK!FF�E�F�E�� SUNK!F �$F�� E�    �� � HIT!FF�E�� HIT!F�F �EA��  Ff� �  ��88   #�� !�<<   �!�   ��     #�� !�TT   �F  Erase old score !�F@'� �  ��88   #�� !�TT   �!�F  Post new score!�F.F  $+�,�� FF  Light up hit indicator6�#�O   �    � �!#�$   �    � �!�F .F  +�F  Ring the belli ��� E�G�F E�!� `   F {�     F
	�n� FF.F  +�F  Hit sound/graphics
 �4� FF z� `   !�`   !�!�@  !�F  �0�E�G�    F� �&� E�G�    F���!��!��  F{�F
	�� F�
	���F�F ��!��!��@@    F.F  +�F  Miss sound/graphicsi
 ��� F� z�     !�`   !�!�@  !�F  ���E�G�    F� ��� E�G�    F���!��!��  F{�F
	��� F�
	���F�F ��!��!��@@    F.F  +�F  Erase old messages2�    �!�88   �!�11   �!�BB   �F.F  +�F  Scroll a message�F j�F M�F !�F� E��`   #��  � F(!!!�    ##�� �    F" �^� E�G�   �H�     �F"'#�4   ��  !� ?   �!�F!{� �F"'#�4   ��  !� ?   �!�F! �E;� @%� #�    #��    F 
	��� F '�    �!�??   �!� F !�F(!!!�@   ##�� �`    F.F   +�'F  Handle a pause requestz�!�F  Turn off soundL��     �!�pp   �!�DD   �!�//   �!�Fe
  Save current grid M�F   Show Hall of Fame� E�      GAME PAUSEDFM�F !�F,(!!!�    ##�� �    F  Small textF 4'�    �T   #�� !�??   �!�GAME PAUSEDF"�!�!�F {�     F ��S� ��F!�F2��     �!�pp   �!�F   Restore the gridj�F .(!!!�@   ##�� �`    F  Normal textg ���  �F,y�!�     !�!�    !�F   Restore soundtz�!�!� @   !�Z�  �!�FF �F .F  $+�)F  Handle a new game requeste� E�   BEGIN A NEW GAME?FFM�F 
M���  FGM�*F �d��FI6� `   !�!�!�`   FM��    �!�     �!�F�� F F .F  (+�F  Handle a sound on/off requestu
 ��� F� E�       SOUND OFFFE� E�F ��F � E�       SOUND ONF� E�FF M�F {� H   F .F   +�(F  Handle a quit request� E�  REALLY WANT TO QUIT?F M�F 
M���  FLM�*F ����FL� E�   THANKS FOR PLAYINGFM�F *M���!THAENKS FOR PLAYING NAIVUL BATTLE F{� H   FNM�F `FEF M�F .F  +�F v�L�F   Avoid array errorsJ� !�F ��E�    G�H�F�EV� F  Pick Horiz or Vert$�EUF  Pick touching ships vector �|FF�E�F  Reset the flagM�FF  ���Fe  Horiz checks0 ��#��
�  �    Fy  Won't fit in gridi-�F#F  �(� E�G�
� �F, ���� @� �F  Already a ship there�E�FF 
	��� F �N��F -�F#  Go try againF 2 ���� �� L�����Fy  Skip if touching is OK-�F�F < ��#���@� � #���
� @� � F  Check L & R ends-�F#F   6� E�G�
� �F�>  ,#��� @�� � #��� @�� � F  Check T & B ends�E�FF 
	��� F  `��F�-�FF  Go try again  jF-�FFF  �F    Vert checks  �#��
� � �   F -�F#F   �� E�G�
� �F   ���@��  �F�E�FF 
	 �� F@  ���F-�F�F  �� �� L�����F-�F�F ( N#��@�� � #��@��
�  � F-�F#F  �� E�G�
� �F�* �#���@��  � #���@��  � F�E�FF 
	b� F ���F�-�F�F F  �|F�  <��Fl  Plot Horiz ships
�E�� F  � E�G#��
� � F��� @� E�F�
	� F� |F!   Plot Vert shipsp
�E�� F x� E�G#��
� � F���@�  E�F�
	`� F�F  ��� ��FM�F�&��!�!�F   Show the ships on gridF 
	��FFv�F.F   +�	F   Player plots own ships�� T   �!�$$   �!�<Fn@� V   �!�%%   ���!�   ���!�E   ���F!� E�PLEASE PLOT YOUR SHIPSF M�FP M���PLEAZE PLOHT YOUR SHIPS FJ� !�FJ� !�F�F F F "�!�!�FPB�� �� 
   � ��   � ��|   � ��    �FF�E%##�(   �� #�(   �#�� �  ������ F  Which ship? "�E�((   �#�� (   � F& ���   �F"  Wants it Vert��    �!�!�F��    �!#��� !�F �E�F F(  Wants it Horiz��    �!�!� F��    �!#��� !�!F �E�FF F  "�!�!�Ft  Avoid dbl-clicks��F#M�F�B���  ��  ��  ��      ��      F  Wait til all donei.F  +�F��F 
 ��F �"E�#F   Use Horiz sprite �F �"E�$F   Use Vert spriteF   ��� F  Erase old plots  ~�E�G�   F� t�E�G�   F� j��@� �F��@� E�FM�F���!�!�%F�F 
	6�FF
	"�FFF 8 These algorithms provide an x,y offset to the mousea4 and insure ships cannot be plotted off the grid.F F "�!�!�F�N�E(��##�� C    #��CC     �##��P    #��PP     � F�N�E(��##��     #��     �##��p    #��pp     � F�$0�!##�� �   #�
� �  �F$0�!##�� �    #�
� �  �F(1�!#�#� P   �  #�P   �� F(1�!#�#� p   �  #�p   �� FM�F�M�F��F 6~�"!��     �!��    �F  Show the spritee���F ~�"F  Erase the spriteM�F�
��FF
�� E�FF
 	$�F $��!�!�� F  Plot a Horiz ship  	� E�G#��
� � F�� @� E�FF
		� F� 	|F "��!�!�� F  Plot a Vert ship 	x� E�G#��
� � F��@�  E�FF
		`� F�F �E�F{� p   F�F .F  *+�F  Insure ship fits before plotting�E�F
 
D�FF 	�#��
�  �    F�E�F 
<F� 
8� E�G�
� �F 
.��� @� �F�E�FF 
	
� FF  
�F  
l#��
�  �    F�E�F 
�F� 
�� E�G�
� �F 
���@��  �F�E�FF 
	
�� F@F F  
���FM�F�F .F   +�F  Get random coordinates�EV�     F�EV�     F.F  ,+�F  Convert logical to physical coords�E#��    �     �F�E#��     �p    �F.F  ,+�F  Convert physical to logical coords$�E%#��    � #�   �  F$�E%#��p   � #�     �  F.F  +�F  Prevent nasty errorsv�L�F��F.F   +�*F  The OK/CANCEL buttonsg6�� V   �!�##   �!��  �!�EE   �!�F�� V   �!�##   �!�&F }�F�F �E�FF "�!�!�F�& h� �� 0   � ��<   �F" $��_   � ��r   �F�E�F  OK selectedLF " d��~   � ��   �F�E�F  CANCEL selectedtF F 
��F~�� V   �!�##   �!�F�j�F F "�!�!�F�
��F{�     F�.F  +�F�> �� �    #�� �� �      F  A human player won *�� �    F�E�F 4F�E�FF � E�   CONGRATULATIONS!!FFM�F M���CONGRATULETIONS F{�     FR ���FA� E�    YOU WON, HUMAN!F �F  � E�     PLAYER A� � WON!FF M�F 
M���  FP{� H   FP* �� �� F  Update Hall of FameeM�F�%�!!FR� <   �!#�4   �0   #��  �!� 7   �!#�   �0   #��  �F%�!!F*'� >   �!#�H   �0   � �!�F � E�PLEASE ENTER YOUR NAMEFM�FP
M���  FE$Y�P   �#�� !��    � "F�`�0   !� � F F F * ��� �� �     F   Computer won�E�F� E�  A GOOD TRY, HUMAN...FM�F 
M���  FO{�     FO� E�      BUT I WON!      FM�F 
M���  F {� H   F  ��� �� F � � E�ATARI STFF F  L�� �� �� F �� E�� F�7�O!M�!�NAVLBATL.DATF D�E�G�FLuM�!� � !�� F 
	(�F!8F F .F  ,+�F  Load picture files and save clipsAYF �E��     F ���Fd   Monochrome�'E�NB1MONO.PC3F�(E�NB2MONO.PC3F xFB ,��FO�E�F  Low res colorm�'E�NB1COLOR.PC1FO�(E�NB2COLOR.PC1FO tFB@)�!�,|   Please switch to|LOW or HIGH resolution|!�!� OK !� F0`FEF F 4 �� E�G�p   Fr  Black out screen during load6� !�!�!�Fp
	�� FF  #��(  #��'  FM�F ,)�!�Can't find picture file.!�!�Abort!�.F`FEF!M�+��( F   Go get pix2e6�� S   �!�$$   �!��  �!�GG   �!�;Fe>�� R   �!�$$   �!�PP   �!�""   ��#�� !�<F:�� V   �!�$$   �!�PP   ���!�F   �!�&FF.���!�4   �!�``   �!�..   �!�)F6�� p   �!�     �!�;;   �!�   �!�*F&6�� 
�  �!�   �!��  �!�88   �!�	F&6�� 
�  �!�hh   �!��  �!�   �!�
F&6�� �  �!�   �!��  �!�##   �!�BFe6�� h   �!�((   �!�LL   �!�PP   �!�@Fe6�� h   �!�   �!�LL   �!�     �!�DFe6�� �  �!�   �!��  �!�   �!�AFe6�� h   �!�``   �!�LL   �!�   �!�CFe6�� �  �!�''   �!��  �!�11   �!�EFe6�� $   �!�   �!�88   �!�   �!�F&6��    �!�   �!�>>   �!�   �!�!F&6�� +   �!�||   �!�55   �!�   �!� F&6�� =   �!�   �!�MM   �!�   �!�F&6��    �!�**   �!�<<   �!�BB   �!�F&6��    �!�JJ   �!�<<   �!�bb   �!�F&6��    �!�``   �!�   �!�   �!�F&6�� �  �!�``   �!��  �!�   �!�F&.���!�    �!�RR   �!�     �!�=Fa6�� X   �!�     �!�RR   �!�     �!�>Fe6�� v   �!�     �!�   �!�     �!�?Fe M�+��' F   Go get pix1e6�� Y   �!�     �!�bb   �!�   �!�F&6�� Y   �!�((   �!�bb   �!�88   �!�+F&�� Y   �!�     �!�+F 6�� S   �!�$$   �!�   �!�FF   �!�F&6�� �  �!�     �!��  �!�   �!�F&�E�F 2 � E�G�@   Fi  Get the hit/miss graphicsa�E�   F M�F,��!��!��   �!��    �!��  F�E�     F�M�F ,��!��!��   �!��    �!��  F�E� F!
	�� F�R�F�. �� E�G�    F   Get the ship graphicsiQ�!�!�"!�#FM�F2��!�!��   �"�!��     �#�!��  FFQ�!�!�"!�#FM�F2��!�!��   �"�!��     �#�!��  FF
	R� F�|F�R4,4,2,1,4,5,1,2,3,3,3,1,3,4,1,3,2,2,3,1,2,3,1,3,0,0,4,1,0,1,1,4,1,1,5,1,1,2,1,5 �E�   F,�E�   F,M�F(��!�!��   �!��    �!�%F,6��    �!�   �!�xx   �!�   �!�F, $�E�G�   F �E�G�   FM�F���!�!�%F   Erase the grid
	��FF
	��FF6��    �!�     �!�CC   �!�..   �!�F, H� V   �!�xx   �!�   �!�FF   �F
  Draw intro screenr�� V   �!�   �!�=F �� V   �!�xx   �!�>F �� p   �!�**   �!�?F %(�� �@   !!FF� V   �!�     �#�� !�C   �#�� !�.   �#�� F,%�!!F!�F N� E�G�    F (!!!#� @   #�� �``    F�E�F�E#� � �F#M�F ��!�!��  F"'� `   �!��    �!��  F(!!!#�     #�� � F(�,EA�z   #� � �HH    � pointsF '� z   �!��   �!�,Fi
	x� F!�F (!!!#� @   #�� �``    F$���@   !�z�1  F
  Restore colorsj�9!�0!�8!�2!�3!�4!�1!�+F.F  +�F   Draw Hall of Famee%�!!F2�     �!�pp   �!�DD   �!�//   �F��     �!�   �!�*F ��    �!�     �!�)F  �� E�G�F� �� �  � F ,'� >   �!#�    �0   �  �!� �  F,'� >   �!#�H   �0   �  �!��  FF 
	V� F%�!!F.F  +� F  Save desktop colorsr  �� E�G�p   F �!� P   F ��!�F�� @   !�F �!� F ��!�FtF �� @� E3�� F�� @� E3��      F�� @� E3�� @    F
	 � F�.F   +�F  Restore desktop colors !D� E�G�p   FF�!� `   F ��!�F�� @   !�    FF�!� F ��!�� @� F��     !�� @� Fi�� @   !�� @� FitF 
	 �� F.F  +�F�R�F� �#Eb� b�``    b� b� b� F �$Eb�``    b� b� b� b� F "� E�G�    F�Q�$!�%!�&!�'F"�#E�#b�% b�$ F	  Horiz sprite"�$E�$b�' b�& F  Vert sprite
	!�� F'�|F��0,0,256,0,0,0,896,0,0,0,1984,0,0,0,3424,0,6168,0,6448,0,12300,0,256,0,24582,0,256,0,65535,0,256,0,24582,0,256,0,12300,0,256,0,6168,0,256,0,0,0,6448,0,0,0,3424,0,0,0,1984,0,0,0,896,0,0,0,256,0.F  +��� F   Talk to me...p #t�  �F �-E�F, #\�7�.  �7�* F�(�!6� F�E�B� F �z� !�(�!6� F|�)F!|�*F!F {�     F!j�!�-FF .F   +�F9  Thanx to Dave Morrisonh� !�!�!�F
 %��F $��STSPEECH.TOS FM�F ,)�!�Can't find STSPEECH.TOS.!�!�Abort!�.F`FEF!&�X� � b�  FC  Reserve some space.�+E��!�STSPEECH.TOS!� !�  F  Load ML file�,E�+�    F.�,�`   !�   F �,�p   !�j   F �,�X   !�   F �,�Z   !�j   F �(E�,�]�  F �(!�~   F �E�,�H   F �E�,�   F R�F %B� E�G�@   F Q�F��.E�.B� F�/E�/B� F
	%� F �.E�.c� F�/E�/c� F %�� E�G�@   F Q�F��.E�.B� F�/E�/B� F
	%n� F 
�)Ez�. FF
�*Ez�/ FFF .F �|F/>&h48,&he7,&hff,&hfe,&h4e,&hb9,&h4c,&hdf,&h7f,&hff,&h4e,&h75 +�-F R�F FQ� F 
 &:Z� �ENDFM�FZ{�     F&
F .F �|FF4"  SORRY, YOUR COMPUTER","  DOESN'T HAVE ENOUGH ""  MEMORY FOR SPEECH.",END U*+�+��9 F   Load compressed picture file$ '"#��scan.o  #��delow.o  FAM�F ,)�!�Can't find object files.!�!�Abort!�.F`FEF!�0E�� F�1E��     F�2E��     F�3E��;�  	 F�4E��   	 F
�Ez�3 F
�Ez�4 F��scan.o!�F��delow.o!�F 7�i!M�!�9F�M�!z�0 !�F�M�!z�1 !�     F��
EsM� tM� F
�8E��
 F�
�Ez�8 F��M�!�!�
FF8M�F��9E��z    F
�Ez�9 F (`� E�G�H   FF�E�����!�z�2 !��     Fw�L�$!�%F 0�!�    FF
	( � F��9F�.F  +�$F������z�2 !�� F .F  +�%F��z�2 !�!�     F .F �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       � �$�Z����۴������F�v�2���`��" %� &D     � !R � #� �|�"�     � �� �     � � Ԏ     
� > ��     �� �p �(     �` �� �  �  � 	�                         (t (�     �� � �� P�&���� & 