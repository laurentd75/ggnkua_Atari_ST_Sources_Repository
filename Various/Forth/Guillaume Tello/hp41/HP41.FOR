 �  � 1 >prgflags variable p  variable saut variable fin  variable rec  16 allot constant BUFFER  65536 allot constant ZONE   200 string FILEPATH 20 string FILENAME  20 14 array$ MENU 22 string TITRE " \*.TXT" FILEPATH $! $" HP-41 Serial Receiver" TITRE $!   >comp   $"  HP-41 "              0 MENU $! $"  File "               1 MENU $! $"  Buffer "             2 MENU $! $" "                     3 MENU $! $"  About... "           4 MENU $! $" "                     5 MENU $! $"  Save buffer as... "  6 MENU $! $" -------------------"  7 MENU $! $"  Quit "               8 MENU $! $" "                     9 MENU $! $"  Start recording "   10 MENU $! $"  Stop recording "    11 MENU $! $"  Clear buffer "      12 MENU $! $" "                    13 MENU $!   0 MENU menu constant ARBRE    >comp : on_off  (10 gemindex rec @ ARBRE menu_ienable  611 gemindex 1 rec @ - dup rec ! ARBRE menu_ienable  ;   : manage_menu BUFFER w@ case  10 of BUFFER 8 + w@ strindex  case  :4 of 1 " [1][ HP-41 receiver ][ Ok ]" form_alert endof  $6 of FILEPATH FILENAME fsel_input intout w@ intout 2+ w@ w* if  p @ ZONE -  FILEPATH FILENAME path  ZONE  
savebin cls . ."  bytes saved." cr  then  endof 8 of p @ ZONE <> if 21 " [1][ Buffer not empty ! ][ Quit | Cancel ]" form_alert  intout w@ 1 = else  1 then  fin ! endof 10 of on_off endof  11 of on_off endof  12 of ZONE p ! endof  
drop  
endcase &BUFFER 6 + w@ 1 ARBRE menu_tnormal  endof drop  
endcase ;   
: main  fastopen TITRE 2 wind_set cls 0 v_show_c  ZONE p !  0 saut !  
0 fin ! 
0 rec ! list  7 11  
dolist  "i gemindex 0 ARBRE menu_ienable lloop 1 ARBRE menu_bar  begin %b110000  0 0 0 0 0 0 0 0 0 0 0 0 0 10 BUFFER evnt_multi  intout w@ %b10000 and if  
manage_menu then  v_hide_c  
.b size 0 begin 
->  1+ dup 10 < 
and-> 1 bconstat  
->. while 
1 bconin  
rec @ if  dup p )+! 
then  
case  
13 of cr 1 saut ! endof 
10 of saut @  0= if cr then endof 
emit  
0 saut !  

endcase 
repeat  drop  0 v_show_c  fin @ until 0 ARBRE menu_bar  cls ;   >comp   main       