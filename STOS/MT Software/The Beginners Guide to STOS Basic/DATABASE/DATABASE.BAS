Lionpoulos  �  �                                                              
� ADDRESS BOOK   * � PROGRAM = A:\DATABASE\DATABASE.BAS    :   (� SET SCREEN    2�ͦ:��   :�ަ:���     <���     ,�  w,�   w,�  B   L F� ��BLACK��     :���WHITE��    :���BLUE��   :���BROWN��        P:   Z� INITIALISE VARIABLES    d� ��TRECS��        � n���   NAME$(�    �),� �   ADR1$(�    �),� �   ADR2$(�    �),� �   ADR3$(�    �),� �   ADR4$(�    �),� �   ADR5$(�    �),� �   TEL$(�   �),� �   INFO$(�    �)   x:   �� DISPLAY MAIN SCREEN   �����BLACK:����BLUE   & ����    ,�    ,�    ,�   ,�       ����    	 OPTIONS    �����WHITE   ��   ���   	 O = Open   ȡ�   
 C = Close    ҡ   ܡ�   
 F = First    ��   	 L = Last   ��   	 N = Next   ���   	 P = Prev  �  ��    A = Add   ��   	 E = Edit  "��    D = Delete  ,��    S = Search  6�  @��    H = Hardcopy  J�  T��   	 Q = Quit  ^����BLUE   &h���    ,�   ,�    ,�   <,�      r���     ADDRESS BOOK    |:  &�� WAIT FOR USER TO SELECT OPTION   �� ���OPT$�(�    )  �� ���OPT$�(� ���OPT$)  (������OPT$��   A�   �     �   0   (������OPT$��   C�   �     �   f   (������OPT$��   O�   � K�   �   (¢����OPT$��   F�   � M��   �   (̢����OPT$��   L�   � NB�   �   (֢����OPT$��   N�   � N��      (�����OPT$��   P�   � O�   ,   (�����OPT$��   D�   �     �   T   (������OPT$��   S�   �     �   l   (������OPT$��   E�   �     �   H   (�����OPT$��   H�   �     �   	j   "�����OPT$��   Q�Z��   
   �  B��   �   &:  0� ADD A NEW RECORD   :��   D��   TRECS  N��   WHITE  *X��   ADD INFORMATION TO ADDRESS BOOK  b�  2l���    Enter Name: ;��   NAME$(�    TRECS)   v�  8����    Enter Address 1: ;� �   ADR1$(�    TRECS)   8����    Enter Address 2: ;� �   ADR2$(�    TRECS)   8����    Enter Address 3: ;� �   ADR3$(�    TRECS)   8����    Enter Address 4: ;� �   ADR4$(�    TRECS)   8����    Enter Address 5: ;� �   ADR5$(�    TRECS)   ��  8����    Enter Telephone No: ;��   TEL$(�   TRECS)   ơ  2Р��    Enter Note: ;��   INFO$(�    TRECS)   ګ�   BROWN  �  (��   Ok to store information (Y/N)  ��        � �   A$�(�    )  � �   A$�(� �   A$)  $���   A$��   Y�� �   A$��   N  0 ���   A$��   Y�    ��   INFORMATION SAVED  <*���   A$��   N�    ��   OPERATION ABORTED:��   TRECS  $4��   Press any key to continue  >�w   H��   R�  \:   f� CLOSE - SAVE DATA TO DISK  p��   z��   WHITE  ���   CLOSE ADDRESS BOOK   ��  .���   "Press any key to save data to disk   ��w   ��  ���   SAVING INFORMATION   *���#�   ,�   a:\database\address.dat  &ʝ     �    CREC��   ��   TRECS  $ԡ#�    ,��   NAME$(�    CREC)  $ޡ#�    ,��   ADR1$(�    CREC)  $�#�    ,��   ADR2$(�    CREC)  $�#�    ,��   ADR3$(�    CREC)  $��#�    ,��   ADR4$(�    CREC)  $�#�    ,��   ADR5$(�    CREC)  "�#�    ,��   TEL$(�   CREC)  $�#�    ,��   INFO$(�    CREC)  $��   CREC   .��#�      8��   
FILE SAVED   B�    CREC��       L�  $V��   Press any key to continue  `�w   j��   t�  ~:  "�� OPEN - LOAD DATA FROM DISK   ���   �����WHITE  "���   OPEN ADDRESS BOOK FILE   ��  &���   press any key to load file   Ġw   Ρ�   LOADING FILE   �� ��TRECS��        *��#�   ,�   a:\database\address.dat  �  MT   �����TRECS  & ��#�   ,����NAME$(� ��TRECS)   &
��#�   ,����ADR1$(� ��TRECS)   &��#�   ,����ADR2$(� ��TRECS)   &��#�   ,����ADR3$(� ��TRECS)   &(��#�   ,����ADR4$(� ��TRECS)   &2��#�   ,����ADR5$(� ��TRECS)   $<��#�   ,����TEL$(���TRECS)   &F��#�   ,���INFO$(� ��TRECS)   P���(�    )  Z��#�      d��   FILE LOADED  n� ��CREC��       x�  $���   Press any key to continue  ��w   ���   ��  �:  �� DISPLAY FIRST RECORD   :�����TRECS��     �     � ��CREC��   :�\
�   
�   ȋ  �:  ܊ DISPLAY LAST RECORD  @����TRECS��     �     � ��CREC����TRECS:� \
�   
�   ��  �:  � DISPLAY NEXT RECORD  6����CREC����TRECS�   ����CREC:�\
�   
�   �  ":  ,� DISPLAY PREVIOUS RECORD  26����CREC��   �     ����CREC:�\
�   
�   @�  J:  T� DELETE A RECORD  "^��   CREC��    �     �   X   h��   WHITE  r�  .|��   "Ok to delete the above entry (Y/N)   ��        �� �   A$�(�    )  �� �   A$�(� �   A$)  $����   A$��   Y�� �   A$��   N  >����   A$��   N�    ��   OPERATION ABORTED:�     �   0   ���   TRECS  (     �    A��    CREC��   TRECS  4�� �   NAME$(�    A)���   NAME$(�    A��    )  4�� �   ADR1$(�    A)���   ADR1$(�    A��    )  4�� �   ADR2$(�    A)���   ADR2$(�    A��    )  4�� �   ADR3$(�    A)���   ADR3$(�    A��    )  4�� �   ADR4$(�    A)���   ADR4$(�    A��    )  4�� �   ADR5$(�    A)���   ADR5$(�    A��    )  0� �   TEL$(�   A)���   TEL$(�   A��    )  4� �   INFO$(�    A)���   INFO$(�    A��    )  ��   A  &��   ENTRY DELETED  0�    CREC��       $:��   press any key to continue  D�w   N��   X�  b:  l� SEARCH FOR A RECORD  v��   ���   WHITE  ���   SEARCH FOR A RECORD  ��  0����    Enter name to search for: ;��   S$   �� �   S$�(� �   S$)  ��  $���   SEARCHING FOR: ;� �   S$   ��    L��(� �   S$)  $Н     �    A��    ��   TRECS  ,�� �   L$��(��   NAME$(�    A),�   L)   �� �   L$�(� �   L$)  F���   L$���   S$�     �    CREC��   A:�     �   
�:�    �   4   ���   A  ��   NO MATCH FOUND   �    CREC��       $��   Press any key to continue   �w   *��   4�  >:  H� EDIT A RECORD  "R��   CREC��    �     �   	V   \��   NEW DETAILS  $f���    Name: ;��   TEMP_NAME$   *p���    Address 1: ;� �   TEMP_ADR1$   *z���    Address 2: ;� �   TEMP_ADR2$   *����    Address 3: ;� �   TEMP_ADR3$   *����    Address 4: ;� �   TEMP_ADR4$   *����    Address 5: ;� �   TEMP_ADR5$   *����    Telephone No: ;��   TEMP_TEL$  $����    Note: ;��   TEMP_INFO$   ���   BROWN  (���   Ok to update the entry (Y/N);  ʟ        �� �   A$�(�    )  �� �   A$�(� �   A$)  $���   A$��   Y�� �   A$��   N   ���   A$��   N�    �   	L   .�� �   NAME$(�    CREC)�� �   TEMP_NAME$   .	� �   ADR1$(�    CREC)�� �   TEMP_ADR1$   .	� �   ADR2$(�    CREC)�� �   TEMP_ADR2$   .	� �   ADR3$(�    CREC)�� �   TEMP_ADR3$   .	$� �   ADR4$(�    CREC)�� �   TEMP_ADR4$   .	.� �   ADR5$(�    CREC)�� �   TEMP_ADR5$   *	8� �   TEL$(�   CREC)�� �   TEMP_TEL$  .	B� �   INFO$(�    CREC)�� �   TEMP_INFO$   	L�     �   
�   	V�  	`:  	j� PRINT ADDRESS LABEL  "	t��   CREC��    �     �   

   	~��   WHITE  *	���   Ok to print address label (Y/N)  	��        	�� �   A$�(�    )  	�� �   A$�(� �   A$)  $	����   A$��   Y�� �   A$��   N  >	����   A$��   N�    ��   LABEL NOT PRINTED:�     �   

   	Ġ�� �   NAME$(�    CREC)  	Π�� �   ADR1$(�    CREC)  	ؠ�� �   ADR2$(�    CREC)  	��� �   ADR3$(�    CREC)  	��� �   ADR4$(�    CREC)  	���� �   ADR5$(�    CREC)  
 ��   LABEL PRINTED  

�  
:  "
� LEAVE ADDRESS BOOK AND END   
(��   
2����WHITE  
<��   LEAVE ADDRESS BOOK   8
F��   -Remember to close address book before leaving  
P�  &
Z��   Do you wish to leave (Y/N)   
d�  [�   
n� ���A$�(�    )  
x� ���A$�(� ���A$)  $
������A$��   Y�� ���A$��   N  (
������A$��   N�   ��:�    �   �   
����       
����       
���   
�:  
�� DISPLAY RECORD   
Ƞ�   
ҫ���WHITE  
ܡ�   DISPLAY RECORD   
����BROWN  
�  :
���   
    Name: ;:����WHITE:�����NAME$(� ��CREC)  �  L����BROWN:��       Address 1: ;:�� ��WHITE:�����ADR1$(� ��CREC)  L����BROWN:��       Address 2: ;:�� ��WHITE:�����ADR2$(� ��CREC)  L"����BROWN:��       Address 3: ;:�� ��WHITE:�����ADR3$(� ��CREC)  L,����BROWN:��       Address 4: ;:�� ��WHITE:�����ADR4$(� ��CREC)  L6����BROWN:��       Address 5: ;:�� ��WHITE:�����ADR5$(� ��CREC)  @�  LJ����BROWN:��       Telephone No: ;:����WHITE:�����TEL$(���CREC)  T�  F^����BROWN:��   
    Note: ;:����WHITE:����INFO$(� ��CREC)  h�   