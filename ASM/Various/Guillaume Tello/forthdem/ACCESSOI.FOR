 -  \ 42 0 reserve            \ reserve 2 Ko, �a suffit    >comp   P16 allot constant BUF      \ buffer pour evnt_mesag (qui g�re les �v�nements)   010 string ACCESS           \ cr�e une chaine  <"   M�moire" ACCESS $!     \ y met le nom de l'accessoire   >comp   Jappl_init                  \ coucou � l'AES, renvoit un ID dans intout  Lintout w@ ACCESS menu_register \ utilise cet ID pour s'inscrire comme ACC <intout w@ constant ID      \ ID d�finitif de l'accessoire   J1 v_show_c            \ remettre la souris avant la boucle car le FORTH ,\ l'efface automatiquement au d�marrage!    >comp   begin *BUF evnt_mesag   \ attend un �v�nement  <BUF w@           \ n� de l'�v�nement (premier mot de BUF) (40 =             \ 40= Accessory Open 8BUF 8 + w@       \ ID de l'accessoire (5� mot de BUF) FID = and         \ est-ce le mien? (le 'and' groupe les deux tests) if  4
1             \ bouton 1 par d�faut dans l'alerte $
start         \ d�marre la chaine 
" [1][ M�moire libre |" &
pushs         \ ajoute cette chaine  
-1 malloc     \ taille libre  &
pushv         \ ajoute cette valeur 
"  octets.][Confirmer]" &
pushs         \ ajoute cette chaine ,
getfmt        \ r�cup�re la chaine totale "
form_alert    \ boite d'alerte  then  Fagain               \ retour � begin, attend l'�v�nement suivant...            