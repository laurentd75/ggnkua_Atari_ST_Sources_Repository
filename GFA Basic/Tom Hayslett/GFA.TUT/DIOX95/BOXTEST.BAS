 GfABASIC      �  z  z  z  z  z  z  z  �  	T  	T  	T  	T  6  x  �  j  j  j  j  j  j  j  ~  f  f  f  f
POSTSELECTXMYM	STAT_EXITDEFAULTVOIDNEW_STATSELECTEDX_MOUSEY_MOUSEBUTTON_SELECTEDX_TEXTY_TEXTSTYLE
CHAR_COLOR	CHAR_SIZEHBORDERVBORDERTHICKINVERSEOFFSETWIDTHHIEGHTFATNESSTOGGLEA_STATTOGGLEB_STATTOGGLEC_STATTOGGLED_STATTOGGLEE_STAT
EXIT1_STAT
EXIT2_STAT
EXIT3_STAT
EXIT4_STAT
EXIT5_STAT
EXIT6_STAT
EXIT7_STATQROUNDSEETHRU
XHOT_UPPER
YHOT_UPPER
XHOT_LOWER
YHOT_LOWERRADIO4_STATMENUSTRIPOFFSETSTRIP$SAVE_OPTIONS_AUTORESTORE_BUTTON_STATSAVE_OPTIONS_CANCEL_STAT 	PRESELECTTEMPBUTTON
RADIO1_OLD
RADIO2_OLD
RADIO3_OLD
RADIO4_OLD
RADIO5_OLD
RADIO1_NEW
RADIO2_NEW
RADIO3_NEW
RADIO4_NEW
RADIO5_NEWRBUTTONOLD_STAT
CHARACTERSATOGGLEA_STATTOGGLEB_STATTOGGLEC_STATTOGGLED_STATTOGGLEE_STAT
EXIT1_STAT
EXIT2_STAT
EXIT3_STAT
EXIT4_STAT
EXIT5_STAT
EXIT6_STAT
EXIT7_STATPRE_SETPOST_SETRADIO4_STATSCREEN$SAVE_OPTIONS_AUTORESTORE_BUTTON_STATSAVE_OPTIONS_CANCEL_STATFOUND_BUTTON_BIGFOUND_BUTTON_BIGBOX	BUTTONENDFOUND_BUTTON_TESTITFOUND_BUTTON_SAVE_MENUBIGDRAWSHAPES_BIGRADIOA1RADIOA2RADIOA3RADIOB1RADIOB2RADIOB3RADIOE1RADIOE2RADIOE3
CANCELDATA	ENTERDATAFIND_BUTTON_BIG
RADIO1_BIG
RADIO2_BIG
RADIO5_BIGDRAW_TEXT_IN_BOXRADIOC1RADIOC2RADIOC3RADIOC4RADIOC5RADIOC6RADIOC7RADIOC8RADIOC9RADIOC0RADIOA0RADIOA4RADIOA5RADIOA6RADIOA7RADIOA8RADIOA9RADIOB0RADIOB4RADIOB5RADIOB6RADIOB7RADIOB8RADIOB9RADIOE0RADIOE4RADIOE5RADIOE6RADIOE7RADIOE8RADIOE9RADIOD0RADIOD1RADIOD2RADIOD3RADIOD4RADIOD5RADIOD6RADIOD7RADIOD8RADIOD9
RADIO3_BIG
RADIO4_BIGBIGBOXDRAWSHAPES_BIGBOXTOGGLEATOGGLEBTOGGLECTOGGLEDTOGGLEEEXIT1EXIT2EXIT3EXIT4EXIT5EXIT6EXIT7FIND_BUTTON_BIGBOXRADIO1_BIGBOXRADIO2_BIGBOXRADIO3_BIGBOXRADIO4_BIGBOXRADIO5_BIGBOXYOURBOXTESTITDRAWSHAPES_TESTITRADIO1RADIO2RADIO3RADIOARADIOBRADIOCRADIO4ENTERITCANCELITFIND_BUTTON_TESTITRADIO1_TESTITRADIO5_TESTITTEXTIT	SAVE_MENUDRAWSHAPES_SAVE_MENUSAVE_OPTIONS_TITLESAVE_OPTIONS_DELAY_TITLESAVE_OPTIONS_AUTORESTORESAVE_OPTIONS_AUTORESTORE1SAVE_OPTIONS_DATASAVE_OPTIONS_GENERATESAVE_OPTIONS_DELAY_1SAVE_OPTIONS_DELAY_2SAVE_OPTIONS_DELAY_3SAVE_OPTIONS_DELAY_4SAVE_OPTIONS_DELAY_5SAVE_OPTIONS_DELAY_6SAVE_OPTIONS_DELAY_7SAVE_OPTIONS_DELAY_8SAVE_OPTIONS_DELAY_9SAVE_OPTIONS_DELAY_0SAVE_OPTIONS_DATA_GENERATESAVE_OPTIONS_AUTORESTORE_BUTTONSAVE_OPTIONS_CANCELSAVE_OPTIONS_ENTERFIND_BUTTON_SAVE_MENURADIO1_SAVE_MENURADIO2_SAVE_MENU F ^�F0                               NOTE !! ->M�Q��!�� F YOUR dialog boxes' name instead of 'Yourbox'&                            �����FF'$� Hit any key when ready . . . .F8�E�F  We simply 'echo back' the buttons' settings.BF
 q�ZS� FqrFSppF!N---------------------------------------------------------------------------D           MERGE YOUR DIALOG BOX .LST ROUTINE INTO THIS PROGRAM! N 1st, place cursor on this line. Then select merge. Select YOUR boxes name.6 Then, when your .LST file has been loaded, RUN it!N---------------------------------------------------------------------------(__P_____________________________________________________________________________>THIS IS THE PROCEDURE THAT IS THE HEART OF DIOXs' DRAWING!_BAllow me to introduce you to the 'Draw_text_in_box' procedure._PAll DIOX dialog boxes MUST call this routine! Merge it into your program andFthen forget about it. Well, if you MUST know more about it . . . .oN -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -dJ ALL VARIABLES ARE IN-GOING. None are return variables or pointers etc.: Characters$ : Text that will be printed in the button.L X_text      : X-coordinates of the button, in pixels.( - if rounded box)N Y_text      : Y-coordinates of the button, in pixels.( - if see thru box)dF Style       : Text style. See GFA manual, Deftext, for more info.rJ Char_color  : Color of the text. See GFA manual, Color, for more info.L Char_size   : Size of the text. See GFA manual, Deftext, for more info.)N Hborder     : Horizontal border space of button, in pixels (button width).N Vborder     : Vertical border space of button, in pixels (button hieght).4 Thick       : Border line thickness, in pixels.n: Inverse     : If true (-1), reveres insides of button.I$+���!�!�!�!�!�!�!�!�!� F$h�!�!�!�!�%!�&!�'!�(!�)!�*!�Fo�E� F� Seethru=False� x6��Fa�%E�F x@F�%E�FFE xZ��Fa�&E�F xdF�&E�FFE
�E(� Fa
�E(� Fa x���     � ��F(�E�@@   F x�F  xЈ�     � ��F(�E�PP   FFEFE y��    F�E�     F �E�     F �E�     F  y�F  yT��P   F�E�     F �E�     F �E�F y�F  y���@   F�E�     F �E�     F �E�F y�F  y���    F�E�``   F �E�@@   F �E�FFEFEFEFEE y���     �F�-E#� F zFF�-E#�      FF,�'E����F�(E������    �-F�)E�6� ����F�*E�����   �-FEE(�!�!�!�F�!�FF |���FF
 z��FF%�!�!F z�FF%�!�!�FF!#�FF
 {h�%FF
 { �&FF<#�� �!#���� �!#�6� �� �!#��� �Fh {`F<#�� �!#���� �!#�6� �� �!#��� �FhF� {�F
 {��&F�<#�� �!#���� �!#�6� �� �!#��� �Fh {�F<#�� �!#���� �!#�6� �� �!#��� �FhF�F�� |��E�G�F 
 |b�%FG@#�� �!#���� �!#�6� �� �!#��� �F  |�F@#�� �!#���� �!#�6� �� �!#��� �F F��
	|�F� F  
 }�&F�!�F'�!�!�F�
 }�FF��'!�(!�)!�*!�F��'!�(!�!�@   F�F'-�F(F }6� ��F!�F }tF }X� ��F!�     F }pF  }l#� F!�FFFFFFF'�!�!�F�|F!�F.F|�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Ԥ}�                �����̀���d��������H�����������,                �w���Ҁ���j�������N�������2��~��̀���f��������J�������0��|��Ȁ���`��������F�����ހ�*��v�����\�������@�����؀�$��p���        �}� �P����V��������<�����Ҁ���f��������D����������<������                                                                                                                                                                    