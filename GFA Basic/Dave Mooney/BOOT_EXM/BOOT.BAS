 GfABASIC              .   .   2   2   2   2   2   N   Z   Z  :    
`  
`  
r  
�  
�  
�  
�  
�  
�  
�  
�  
�  
�  
�BOOTADFREE DRERRORSECTTRKSIDENOPLACEFN GT_BOOTDETAILGT_OKGT_KEYBYTEBYTES   2 PROGRAM TO LOAD AND ANALYSE A DISC BOOTSECTORM  DAVE MOONEY - AUGUST 1990  F   �E�F,� E��    
 F  Use maximum possible sizee,�E��     F  Holds bytes free on drive�  M�F M�F  ��F  � �� E7?� @�@�  F $��� E�� �� �� ��� �    F� +�F  �.��F  YF  2Y�!�     "� ANY KEY TO READ DISC IN DRIVE A:F  M�FF M� F  ��F  .F  +�F YF   �x���� �F �ST DISC FORMATFI �Fb& ���� �� �    ���� �kk�4 FF�IBM DISC FORMATF �F "�POSSIBLE BRANCH TO BOOT CODE!F"�BEWARE, CHECK DISC FOR VIRUSFFF F  F @�DISC SERIAL NUMBER   : "�� ��    � �  ����     F *�BYTES PER SECTOR     : "����@@    F *�SECTORS PER CLUSTER  : "�� ��``    F *�RESERVED SECTORS     : "����pp    F *�COPIES OF FAT        : "�� ��    F P�DIRECTORY ENTRIES    : "����    !�- "����    �     "� SECTORSF ��TOTAL SECTORS        : "����      !�- "����X    "�	 SIDES * "����      ����XX    ����HH    "�
 TRACKS * "����H    "� SECTORSF | Print Tab(34);(Fn Bytes(20)-Fn Byte(15)-Fn Byte(17)*Fn Bytes(23)-Fn Bytes(18))*Fn Bytes(12);" BYTES  AVAILABLE FOR DATA"  8  NOTE THAT THE FOLLOWING SIX LINES ARE DERIVED FROMM:  A GEMDOS ROUTINE AND ARE NOT DIRECTLY AVAILABLE FROM�  THE BOOT SECTOR  �TOTAL SPACE FOR DATA :"Ff��     "�- "h?�@�     @�      "� TOTAL CLUSTERS / "h?�@�    @�      �    
"� BYTESF�SPACE USED BY DATA   :"F���     "�- "h?�@�     @�      h?�@�@�       "� USED SECTORS / "#h?�@�     @�      h?�@�@�        �     
"� BYTESF�FREE SPACE FOR DATA  :"FZ��     "�- "h?�@�@�       "� FREE CLUSTERS / "h?�@�@�       �    
"� BYTESF  ,  WHAT FOLLOWS COMES FROM THE BOOT SECTOR  D�MEDIA DESCRIPTOR     : "�� ��00    !�- NOT IMPLEMENTED ON STF *�SECTORS PER FAT      : "����88    F *�SECTORS PER TRACK    : "����HH    F *�SIDES ON DISC        : "����XX    F D�HIDDEN SECTORS       : "����hh    !�- NOT IMPLEMENTED ON STF F F F �ANY KEY TO RETURN.F. M�FF .F  +�FF �RS� F �>F  �jS� F �VF.F +� FF � E�F Drive A:=0��E�F 1st Sector��E�F 1st Track�E�F Side 1c�E�F Read 1 sector &�E��    !�z�  !��!� !�!�!�!� F ���X   !�z� !�  Fb  �z��FIF F .�)NO DISC IN DRIVE.....ANY KEY TO CONTINUE.FM�FD �E�F F  .F � ��        ��                                  �t �@ �� �> �| ��