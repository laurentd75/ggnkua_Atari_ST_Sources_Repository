 GfABASIC       4   V   �   �   �   �   �   �   �  v  v  v  r  *  �    X  �  �  �  �  �  �  �        jXOFFSETJUNKANUAPALAAASCRASYXBIOSZZEOFCCOLDATANAMEXASCRBFLAGCMDSAVANUAPALASCRAASDUMMYAZZZIPDDISPLAYSCRXBIOPAL COLSAVSCRSAPALZZMAINGET_NEO_FILEERARESTARTJUMP 
GET_COLORSGET_FILENAMEGET_FILE
PUT_COLORSGET_TYPEGET_NEO_FILEGET_DEGAS_FILE
SLIDE_SHOWRECOVERTITLE_SCREEN	GET_COLOR	PUTCOLORSMAINSCRIPTSCRIPT_FILERECOVERYv��F L *************************************************************************L ***                                                                   ***L ***   NEO/DEGAS Picture Displayer Using GFA Basic                     ***L ***                                                                   ***L ***   Written by: Richard Noe                                         ***L ***               EAFB, Alaska                                        ***L ***               5 January 1986                                      ***L ***               Version 5.2                                         ***L ***                                                                   ***L *************************************************************************        *� �pp   @� !��      F-� F�  D This procedure uses the VDI call to get the current screen colorsB It load them into an array so that when we exit the program orr2 between pics we can restore the default colors  e+� F  �4� E�G�p   FF�!� P   F���!�F�� @   !�FF�!� F ��!�FtF�� � @� E3�� F � � @� E3��      F� � @� E3�� @    F
	Ҵ� F�.F eeF This procedure uses the VDI call to restore the colors we had saved in the above procedure n+�F  �:� E�G�p   F��!� `   F ��!�F�� @   !�    F��!� F ��!� � @� F��     !� � @� F �� @   !� � @� F tF
	Ӿ� F.F nnD Get's the type of file that we want to display and set's certaine variable accordinglyea+�F\2)�!�  What type of File  !�!� NEO | DEGAS !�F  ����JF�E�NF �F�E�DFFE �,��NJF�E�	�*.NEOFi �@F:�E�	�*.pi1FiFE.FEae Procedure to get a neo filer+�F  ՞�E�G�p   F 6�!�!�!�Fp
	Ո�FF��!�� �    Fi�E�� �xx   Fi ��� E�G�p   F ��  E3� F
�E��FF
	��� FF �,� E�G�p   F �E��`   !� !��   F�
	�
� F{��z   F�YF .F +�	F ,� F`!�F ր� E�G�p   FB6� !�!�!�Fp
	�j� FF ���E�G�    FB(��`   !�!!� X   �F('�     #�� !�     #�� !�GFAF
	֔�F �F�E�G�    F (��`   !�!!� X   �F*'�     #�� !�pp   #�� !�BasicF
	���F ׶�E�G�    F (��`   !�!!� X   �F6'�     #�� !�HH   #�� !�Picture DisplayerF
	�Z�F �*�E�G�    F (��`   !�!!� @   F#<'� p   #�� !�   #�� !�Programming By Rich NoeF
	���F �^� E�G�    F 6� �@   !�!�!� �F
	�>� F,6� `   �    !�`   !�`   !�`   F {�    F#(!�F $6� p   !�`   !�`   !�`   F YF!$'� H   !�    !�Instruction'sF 6'� @   !�    !� This program will display eitherF8'� @   !�H   !�!NeoChrome or Degas Low ResolutionF 8'� @   !�p   !�"Picture's.The program also has theF*'� @   !�   !�following feature's:F,'� @   !�4   !�    Select Type of PicF6'� @   !�H   !�    Script Files or Display AllFD0'� @   !�\   !�    Choice of Drive to useF2'� @   !�p   !�    Adjustable Display TimeFA8'� @   !�   !�"Ensure Write Protect is OFF beforeF4'� @   !�   !�Picture Disk before ContinuingF6'� @   !�*   !� ( For More info see the Docs )Fr{� H   Fs2'� H   !�>   !�Click RT Button to ContinueFyF!
�`R�F�ERF.F!  +�F ��!�� �   F �E�� �     F* ��� E�G�p   F*��  E3� F
�E��FF
	ۺ� FF �� E�G�p   F*�E��`   !� !��   F*
	��� F{��z   F�YF .F E+�F�v�L�F 7�I!M�!�	�
Script.datFy:M�!�F�E�F 
 ܮ�F:M�!�F
�E�	�F ܜ��NEOJF,�FF ܦF,�F F�bF�     Era:8M�F�.F+�Fv�L�F V�G�	�Temp.datFe7�I!M�!�	�Temp.datF 
 �L�F:M�!�F
�E�	�F�F  �:��NJF,�FF �DF,�F F��F�8M�F�.F r+�FF �ʘ� L   JF,�FN@)�!�-No files of that|type exist in|this Directory!�!� OK !�Fv�L�F �� FFF  ��� P   JF8M�F ,�F���F F �`��    ��JF ,�F�>)�!�'No Script File|    Exists|On This Disk!!�!�Carry On!�Fv�L�F �� FNF  �Θ�   JF,�F�>)�!�&No files of that type|  On this Disk  !�!�Carry On!�F�8M�F v�L�F �� FNF  �,��P   JF,�FW4)�!�!Write Protected|remove protection!�!� OK !�Fv�L�F �� FWF .F� |F� ߀��     �JF .)�!�You must be in |  Low rez !�!�uh oh!�FF!F!,�	F YF	L)�!�5  This program is written  |  Completely in GFA Basic!�!�Carry on!�FF|J)�!�-  Select Delay Time  | For Pictures in Secs  !�!� 5 | 10 | 15 !�F8)�!�  Select Drive  |  To Display !�!� A | B | C !�F6)�!� What Type Of Display !�!�All Pics|Scripted!�F ���JFg�F
�	E�a:\FFE ����JFg�F
�	E�B:\FFE ����JFg�F
�	E�C:\FFE,� F� ���JF,�F�-�F�F,�F\�|F ,�Fu�F �|FF
6�!�!�!�F$6� p   !�`   !�`   !�`   FD ���JFD)�!�#No More Scripted|Files On This Disk!�!�Carry On|  Quit  !�F  ��FoB)�!�"  No More Files  |  On This Disk  !�!�Carry on|  QUIT  !�FF 
6�!�!�!�F$6� p   !�`   !�`   !�`   F ����JFv�L�F A�	�temp.datF,�F 
6�!�!�!�F ��
E�G�    F 2�
!�
!� �  �
!�GG   �
�     �H   F 
	�l�
F%�!�!�     F�!�!� �  !�G   F rF F ��F +�FFv�L�F ��F.FF�                                        |                               @                      ��              ��  ��        ��                             �         A                                  �J        �R              �6     �*     � Ҡ         Ӫ Ԭ �t ۂ �� �` �L             �0 ��    