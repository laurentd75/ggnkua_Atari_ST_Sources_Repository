 GfABASIC          $  �  �  �  �  �  �  �  N  N  N  �  ,    *  <  �  �  �  �      *  Z  Z  Z  ZLINESSTATUS NAME
BIG.STRINGFIND ADDRBLAH
BIG.SCREENFILE.LENGTHLENGTH	FILE.OFFSUUSCREEN.BYTE.1SCREEN.BYTE.2SCREEN.BYTE.3SCREEN.BYTE.4SCREEN.BYTE.5SCREEN.BYTE.6SCREEN.BYTE.7SCREEN.BYTE.8BSCHUNKLOOKWHATSTART.XSTART.YX.CHANGEY.CHANGESSSCHAR.YCHARSSYMBSX.POSY.POSLAST.XFIRST.XN2N1OFFSLIMIT.1LIMIT.2LINE.OFFSETHORFACTIVALUESTART.INDEXX1Y1X2Y2
LAST.CHUNKFLAGPRPRT SOURCEDESTCHUNKCLIPSYMBOLS TOPSTART
LOOK.AGAINRETRY ER.PROCQUITDISPLAYGET.A.CHUNK	FIND.LINE
DRAW.LINESSET.CLIPPRINT	FORCE.VALINITIALIZE.PRGET.SYMBOL.COORDPRINT.IMAGE�X� F,*� �      !��      !��      !�� F� ��X� � |  F �X� � |  F � E��   !�� F �N� �|  F � E��   !�� |   F0   Print "Allocated memory begins at: ";Addr% ��Fi   Print Addr%a*)�!�Can't allocate memory.!�!� OK !�FA�X� � |  �   FmqF F  ��F ()�!� Not enough memory! !�!�Sorry!�FqF F  v�L� FoH�E� �|  F  so we have 600K for the .PRT file and 600K for screen   set up bit blitting arrays:0 � � E�Fi  addressg� � E�pp   
Fd	  widthr� � E�HH   Fd
  height"� � E�pp   Fd
  width in words� �     E�F  always 0"� �     E�F  # of bit-planes 
�� E�� F�� E�     	F �� E�HH   F �� E�     F ��     E�F��     E�F ��     E�F  replace mode � |F �)�!�_  Do you want to convert a  |  printer file or print a|  previously converted bit-|  map image?!�!�Convert| Load | Quit !�F  �&��FoM�F�F  ����Fo   convertf�\*.*!� !� Fc ��� �  <�  �\F7�i!M�!� F
�EsM� F �E�F 8M�F�� !� F ��FF-� FFF F   ����F�  display/printtf�D:\*.*!�ihope!� F ��� �  <�  �\Fp7�i!M�!� F� EsM� �p   F\ �V'�  F ()�!�    Invalid file!   !�!� OK !�Fn8M�F-� F F 8M�F �� !�FM���!�!�!��  	!�H    F"M���    !�!�!��  	!�H    FM�F-� F� ��FF-� FFF F  j�!�Fj�!�!�	!�
!�!�!�!�F �E��j`  !� F
�Ez� F�E�j`  FF� E�FM�F`2�E�Z�FF  string right before graphics data  �|F"Y�`   !�0    "��######!�F  8graphics data for screen lines 1,4,7,10,13,16,19,22:i JM�Fh  get starting address of each line of graphics data (File.offs%) M��� F lines 2,5,8,11,14,17,20,23: M�FsM���p    F lines 3,6,9,12,15,18,21,24: M�FsM���p    F 0�!�4   F,-�F4 +�F44�F4�|F4�ED�@�@� F, �X��F
 �&� FFM���!�!�!��  	!�H    F"M���    !�!�!��  	!�H    FM�F� �TF M�FF�E�F     Add Chunk%,30000-�F F F 6 File.offs%=Chunk%+Instr(Look%,Big.string$,Find$)+3�E���F ����FM�F�F , Print At(1,20);"Address of next line: ";, Print At(23,20);Using "#####",File.offs%( Print At(40,20);Using "#####",Chunk% Stop.F  +�Fp: Print At(1,23);"Getting a chunk!  Length is ";Length%t Pause 406 Print At(1,23);"                                 "0�!�j`  F3 ���j`  F �� �!�!�j`  F 1�!�j`  F  �@F`�� �!�!�F� E�F   Print "Last chunk!!!" F .F  +�Fr ��  !� !� F F 
 �l�� F�Ea� F$ ����`   F�   "p" for printM�F�F   ����G   F    clr/homerM���!�!�!��  	!�H    FF $ �:��w   F�  Cntrl/clr-home*M���!�    
!� �HH   !�o�  
!� � F F " ����M   FH  right arrow
$         @Set.clip(0,0,0,639,400)F   ����K   Fp left arrow4$         @Set.clip(0,0,0,639,400)F  ���H   Fp  up arrow$         @Set.clip(0,0,0,639,400)F   �Z��P   Fp  down arrow$         @Set.clip(0,0,0,639,400)F ��  !� !� FF 
 ��R�F�EPF�EQF�F 
 ��R�F2�E�PF move mouse right, change is negative 
�E�QF 
0�� !�F
0�� !�F
0�� !�F
0�� !�F  keep inside big screen:t M���� �!�!�!� �  	 F&M���� �     
!�!�    
!�o�  
 FM���� �!�!�!� G�   F*M���� � �H   !�!� �HH   !� � Fv��  !� !� F��FF �F 
 �ZR�FJ     Print At(2,2);Chunk%(0);",";Chunk%(1);",";Chunk%(2);",";Chunk%(3);�hFP 2   Alert 1," save image? ",1," Yes | No ",Blah%   If Blah%=16   Bsave "D:\image6",Big.screen%,Uu%+480+5041+Hor%k
 Endife *)�!�  Do what?  !�!�Quit|New|Cancel!�F ����F M�FiF  ����FhM�F�F F)�!�(  Your current file will be  |  trashed!!�!�Do it!|Wait...!�F  �X��F M�F�F .F  +�Fi*)�!�Ready to print?!�!� Yes |Cancel!�F �"��Ft�|F��E�F�E��    !� F
 � �F6)�!�  Printer not responding!  !�!�Retry|Abort!�F% ���Ft-�F�F  �*F�E�FF  
 ��FF (;B�@    "Fe   clear printer buffere 8 ��E�G�4   H�   Fe  down the page vertically  1st pass (upper 12 rows) $M�	F   set Prt!,First.x%,Last.x%  �\�E�G�FM�
���@� !��!�� F$ �R��� X    ���   F �Ev�!� F�Eu�!� F�E�FF 
	���F  �6�F   let's print:�E%#��@    �      F # of cols. of dots to print � E#�� @    #�    � F  6M���!�0   !�   !�     F  print 1st 12 rowsr;B�X    �3B�(    "F ;F   �ZF ;B�X    �3B�@    "F ;F F   2nd pass (lower 24 rows) M�	F  ���E�G�FM�
���@� !��!�� F$ �����     ���X   Ft�Ev�!� F�Eu�!� F�E�FF 
	���F 
 ���F :�E%#��@    �      F # of cols. of dots to print � E#�� @    #�    � F <M���@   !�8   !�(   !�     F  print next 24 rows ��F ;B�X    �3B� "F�;F F   advance to next space: ;B�X    �3B�    "F;F  
	���F  �F  F F .F  +�F��E��   !��  F �z��F!()�!�    Mfree Error!!    !�!� OK !�FF �X� � |  �   F qF .F  +���!�!!�"!�# F
 ���F!���! E�"F���! E�#FF .F  +� F!$ ���   FF  file not foundv�L� F�� FF �ZF2)�!�Error #A� �.  Ending...!�!�Too Bad!!�FtM�FEF .F  
+���$ F  ���%E�G�o   F �&E�     F  ���'E�G�`   F  setting individual pixels �(E2� ��'#�%�       F� ��( �    F 0�!�&FF  � �( �    F 0�!�&FF  �>�( �    F 0�	!�&FF  �\�( �    F 0�
!�&FF  �z�( �    F 0�!�&FF  ���( �    F 0�!�&FF  ���( �F 0�!�&FF  ���( �F 0�!�&FF  3�&!�FF
	���'FF "now we have eight screen bytes� ���$��%!�Fe���$�4   	�%!�Fs���$�4   
�%!�	Fs���$�   �%!�
Fs���$�4   �%!�Fs���$�a   �%!�Fs���$�   �%!�Fs���$��  �%!�Fs j�!�!�	!�
!�!�!�!�F
	���%F!.F  +���)!�*!�+!�,!�- F! ��)� E�*F  source rectangle��)� E�+F��)� E�,F��)� E�-F.F �                                                                                                                                                                                                                                                             �� �^���� �� �0 �N �F ����b�� �p���            