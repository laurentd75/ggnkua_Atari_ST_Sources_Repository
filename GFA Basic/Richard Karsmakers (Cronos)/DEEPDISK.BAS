 GfABASIC              4   4   4   4   6   6   >   D   D   D   D  P  	Z  	Z  	l  	�  	�  	�  	�  	�  	�  	�  	�  	�  	�  	�BOOTCHECKBUFFERDUMMYASECSPTSIDTPSSTCXPBLABEL1 CHECK"DDT - Deep Disk Tester Rev.1.0 DDProgram design, development and programming by Richard KarsmakersHIdea by Mr. I-forgot-his-name (in Veldhoven), but not mine anyway... Sunday, July 19th 1987sr<)�!�*Please insert disk|to be tested|in Drive A!�!�OK!� Fs!JRead bootsector of disk to analyse the number of sides, tracks, sectorse� E��    	 F'For bootsector �E��    	 F%For check-sector"*� �     	 F,Wrong byte arrays 8�E��    !�z�  !��!��!��!��!��!�� FRead bootsectors ^���F!0Error occured?0)�!�An error occured!|Test aborted!!�!�Oh!� F�F!F!!B�E7?� @�    @�  �    #7?� @�(   @�   FSectors on disk D�E7?� @�H   @�  �    #7?� @�P   @�   FSectors per track 8�E7?� @�X   @�  �    #7?� @�`   @�   FSidess"�E#�� �F #Tracks per side YF0�+The disk has the following characteristics:F$�Total number of sectors  : "�Fc$�Sectors per track        : "�Fc$�Number of sides          : "�Fc$�Nunber of tracks per side: "�Fc 0The actual reading/checking takes place hereth a(�E�G��F&Sidesk" a�E�G��F$Tracks per sidee" a�E�G�F$Sectors per tracke6�Testing side: "�"�	, track: "�"�
, sector: "�F"M� F�
	`��FG
	`��FG
	`��FG The check routineh+� FaRead in sector"*�E��    !�z� !��!��!��!��!��!�� Fa a���F!<�Read error on side: "�"�	, track: "�"�
, sector: "�Fr-� FaFBuffer contents�E�F Invert bits b<�	E�G6� F"��!�	!� EB7?�@�	@�  �     F
	b�	FEWrite sector back*�E��   !�z� !��!��!��!��!��!�� Fs b���F!<�Write error on side: "�"�	, track: "�"�
, sector: "�F-� FiF Read it again*�E��    !�z� !��!��!��!��!��!�� Fa cX��F!<�Read error on side: "�"�	, track: "�"�
, sector: "�Fr-� FaFInvert bits c��	E�G6� F"��!�	!� EB7?�@�	@�  �     F
	cv�	FE0Check if buffer$ is still equal to the sector�
E�FJ�  !�F d(�	E�G6� F d?�@�	@� ?�@�	@� F
� �
 E�	F4�
FEF

	c��	F�Faulty bits?e d��
�F <�Byte faulty on side: "�"�	, track: "�"�
, sector: "�F d��	E�G�
F"�Faulty byte #"�
�"�: "� �
 F
	d��	F -� F�F Write sector back*�E��   !�z� !��!��!��!��!��!�� F  eN��F!<�Write error on side: "�"�	, track: "�"�
, sector: "�FF � |F�.F �                                                                    eT aJ