 GfABASIC       �    &  &  0  4  <  <  <  ~  ~  ~  �  �     �  R  ^  ^  j  p  v  v  v  �  �  �  ��XYCTX1X2X3X4AFBCOUNTDTOGCOLCOL1COL11COL12COL13COL14TOG11TOG12TOG13TOG14TOG134R
FIRST_LOOPLENGTHUPS_SCOUNTS_COUNTSTOGS_TOG LOGOAUTHORMAGAZINESPHERESPHERE_MASKG_SPRF_SPRA_SPRSCROLL_WINDOWGFA_DEMO_LOGOBAR1BAR2STFFA_DEMO_LOGOSAFILESC AAABPHYSADRXVALYVALSPCSCREEN COLORGET_SPRITESCOL2CALCULATE_COLORSRETURNSINIT
SPHERE_CAL @       The GFA Demo! Part 3 - Main Part - (C) ST Format 1991.2                     Written by James Beswick.T ** VERSION 1.6 ** NThe shimmering didn't look very good considering how much processor time itRused up - so now it's gone! I've introduced a bouncing ball routine at the topPof the screen, which I drew which the mouse, and saved the co-ordinates. DuepJto the presence of the animation of the sphere, I've had to include theLnon-flicker routine, so there are some new lines in the INIT procedure... M�F  "** THE DEMO CONTROL ROUTINE **  <6� 0   !�@   Fo Now set all the colours! Colour 11...$6� @   !�    Fo Colour 12...h(6� P   !�    Fo Colour 13 set...o"6� `   !�F  Colour 14 set...e2j�!�!�!�F Toggle variables are needed here.(�!�!�!� @   F�2F  Repeat the idented segment until key press.��F{M�F�0Y�!�@    ";�@�    F Display scroller.B�E=�@6� � ;�@� FF Calculate scrolling position - complex!�� � !�� !�!�    F�� � !�� !�!�@   FH� !�F���    !�� !��!� FF,�JS� F� Exit when a key is pressed... <6�!� n�  
F  Set the colours again for the editor, or we86� p   !�F  won't be able to see what we're doing!r*�F  Return straight back to the editor.  D** Long routines are pushed into procedures and put at the end ** 2+�F This routine GET's (some of) the sprites. �� B   !�!�^   !�p   !�F �� b   !�!�~   !�p   !�F ��    !�!�	   !�    !�F ��    !�!�   !�    !�F ��    !�!�   !�    !�F ��!� P   !��  !�3   !�	F ��!� 5   !��  !�=   !�
F ��!� ?   !��  !�G   !�F&��     !�    !�G   !�L   !�F.F  +�F� ��� �F 0�!�F ��F1�!�FF  ����x   F � E�FF  ����F � E�FF .F  +�F D** INITIALISATION PART (GET THE SPRITES, SET THE MOUSE, ETC.) ** P*� �{{�  �     !� �xx    !��xx    F These four lines are the basisp&� E�� F! for the non-flicker routineB�E#z� �  �      � �  Ft to smooth out the animation...a�E�� F > �j�E�G�x   F  Read in the positions for the sphere...Q� � !�� F
	�R�F� ��E��H    ��ST Format proudly present the GFA Demo! This small demonstration shows off what is indeed the best implementation of Basic on any microcomputer. This was written with the earliest version of GFA Basic, version 2, F��E�ޫwhich was given away FREE with the February (nineteenth) issue of ST Format. This program has been slowly built up over a number of issues, and finally, here it is!       Fi �F  Hide the mouse.Dl� �  
!2� �  
  �F Key click off. Another weird instruction!YF  CLear the Screen. ��gfademo.pi1!�� �    F @���@   !��� �      F These 2 lines load the demo screen. 6M�F  Go directly to the procedure with this name.mN                              ! The procedure, once executed, returns here.YF  Clear the screen.F  H�E�0   G�`   F  Loop the idented line three times, whilst26�!�F incrementing COL by 1 from 11, until it6	���F
 reaches 14. This clears the logo colours.8��!�!�	F

 Place the logo at the top of the screen and:��!� /   !�F Place two metallic bar sprites at these ��!� @   !�F positions...a*��F@ Now get the entire screen in SC$..F  B** 63 Data Lines Follow ** These are the sphere's positions **  3,60o5,58o7,55o10,5114,4718,4222,4027,4034,4437,4742,5345,5747,5947,6050,5856,5166,4575,4283,4289,4695,5497,5798,60
102,55t
107,48t
116,44t
125,40t
129,41t
138,46t
145,54t
146,55t
148,59t
153,52t
160,46t
164,43t
172,41t
177,40t
185,42t
189,47t
192,52t
192,57t
193,52t
195,50t
198,44t
203,42t
207,41t
214,39t
222,40t
228,47t
234,53t
234,58t
235,54t
235,52t
236,48t
239,44t
244,39t
249,38t
258,38t
263,40t
266,45t
272,51t
272,52t
274,57t�                                                                  |               p                                                                                                                               �~ ~ �� ~ �� V �H V �� V       �d/� ��� �� �f       �n�             �}    �  �  �  ��              �l                 � ��