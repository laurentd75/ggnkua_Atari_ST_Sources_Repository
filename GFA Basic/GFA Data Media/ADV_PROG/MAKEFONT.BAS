 GfABASIC             Z   Z   Z   Z   b   b   b   �   �   �  �  
&  
(  
4  
R  
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
�XAFATFILEA_FONTIATIBMHSS36EPSHSS36SIZEADRADR.L_A_I_CHRLINKCHRLINK0F ASDPSCHALT	LOAD_FONTUNLOAD_FONT	UNRESERVEGET_CHRLINKGET_CHRLINK0
KILL_FONTS
WRITE_FONTMALLOCMFREEMSHRINK makefontFa(To create a font from the System fontby using DEFTEXT ,,,26h
Result:         GROSS.FNT<with the TEXT-command about five times faster than normale&*��      !��      !��      F*� �@   F� Ez� �  FF� !�`   F�� �!�    F4�E�	M�ll FontF a��E�    G�   FH� �!7>�@�  F
	a��F�$ a��E� �    G� �   H�F5Q�F��!�F
	a��F 20,255,26,23,17,4,4,28,32,2,14,2,2,&5555,&5555,8� �   !�F � �   !� �00   F"� �   !� �00   �    	F5&� �    !�    �    �    FT� �$   !�    F � �(   !�F  b��E�G�   F  � �0   ��!��     F5
	b��F
�� E�� F�� E�     	F�� E�HH   F�� E�� �    F��     E�F�� E� �0   �    	F �� E�     �    F�� E�     F��� E�� �    F��     E�F�� E�F�� E�F�� E�pp   F �� E�xx   Fk��     E�F��     E�F��@    E� p   F ��`    E� x   FH��     E�F(!!!�P   F 2 e�E�G�   FnHere we declare all the text:'�!� P   !B� Fthat is then copied to the right place�� !� !� F	using BITBLT.e0��      !�     Fm0��@@    !�     Fm
	dp�FF�E9F (!!!!�FOnly for demonstartion eV�E�G�H   F '�!� H   !�F
	e<�F#9� �H   "�	 s NormalFn�E9F:The following program section should never be aborted.6Since this would lead to a system crash because the2the text pointer would be pointing to nothing!!M�F_��(   !� F(!!!!� `   F (!�!!� P   F  f��E�G�H   F '�     !�H   !�F
	fn�F!#9� �H   "�
 s SpecialF��(   !�F,(!!!!�FWrite the fontsoM���	GROSS.FNT!�  Fu+�F
M�F
�E�F g:4��((    F�E4�� (    FgF.F  +�FFh�!�
F2�Ecܿ��� b��   FA000  move.l a1,d0  rtss
�
Ez� F*�E44��
� �      � (    Fsee Text.FEE+��� !� F�E�4��    � F
�Ez� F���!�!6� F� h>4��    F��   !4��    �F ��   !�F�F ��   !4��    �F ��   !�F���   !4��    �F ��   !�F� h��E�G�6� �H�F�!2� �     2�� F
	h��F�7�o!M�!� F
M�!�"F (�M�!�6� !3��     3��$$    F8M�F�.F�ccBBy the way: at VDIBASE+72 is a copy of the actual Text-Header! @ This is why I used the above data so that the font will look orderly.u�                                                                                                                                               f� gH    �g�            