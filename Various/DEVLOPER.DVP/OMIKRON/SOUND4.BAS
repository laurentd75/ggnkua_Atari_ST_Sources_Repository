 '
 ' Musique � interruptions par Dosound (XBIOS, no 32)
 ' OMIKRON-BASIC          SOUND4.BAS
 '
 S$=""'      Former la cha�ne de commande
 '
 WHILE 1'   Boucle sans fin
   READ Commande%L
   IF Commande%L=-1 THEN EXIT
   S$=S$+ CHR$(Commande%L)
 WEND
 '
 Strptr%L= LPEEK( VARPTR(S$))+ LPEEK( SEGPTR +28)
 XBIOS (,32, HIGH(Strptr%L), LOW(Strptr%L))
 '
 END
 '
 '
 ' Data de la musique:
 '
 ' Tous les g�n�rateurs de sons � 0:
 '
 DATA 0,0,1,0,2,0,3,0,4,0,5,0
 '
 ' Volume: A et B sont command�s par l'enveloppe, C 0
 '
 DATA 8,16,9,16,10,0
 '
 ' Enveloppe: lin�aire descendante, p�riode: 8000
 '
 DATA 13,1,11,64,12,31
 '
 ' Activer les g�n�rateurs A et B:
 '
 DATA 7,252
 '
 ' Et voici les sons:
 '
 DATA 0,222,1,1,255,16
 DATA 0,170,13,1,255,16
 DATA 0,123,2,222,3,1,13,1,255,32
 DATA 13,1,255,46
 DATA 0,102,2,170,13,1,255,16
 DATA 0,28,2,123,13,1,255,24
 DATA 0,63,13,1,255,8
 DATA 13,1,255,32
 DATA 0,123,2,222,13,1,255,16
 DATA 0,63,2,123,13,1,255,16
 DATA 2,170,13,1,255,24
 DATA 0,102,13,1,255,8
 DATA 13,1,255,32
 DATA 0,63,2,250,13,1,255,16
 DATA 0,102,2,0,3,0,13,1,255,16
 DATA 0,123,2,222,3,1,13,1,255,64
 '
 '
 '
 ' Fin: tout remettre � 0/normal:
 '
 DATA 0,0,1,0,2,0,3,0,4,0,5,0,7,255,8,15,9,15,10,15
 '
 ' Interrompre le traitement:
 '
 DATA 255,0
 '
 DATA -1
 '
