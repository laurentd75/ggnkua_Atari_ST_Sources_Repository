; PLAY MUSIC MAD MAX
; CODE RIC/NAOS
;
; ZORRO II
; 10/08/2001
;
; DEVPAC v2
; STOP.INC

MAIN:
; Recuperation des parametres en GFA dans la pile

; vecteur%
	MOVE.L	4(SP),A4

; MODE SUPERVISEUR
	CLR.L	-(SP)
	MOVE.W	#$20,-(SP)
	TRAP	#1
	ADDQ.L	#6,SP
	MOVE.L	D0,-(SP)

; REACTIVE CLICK DU CLAVIER
	OR.B	#1,$484.W	; ==> MOVE.B	#15,$484.w

; ARRET DE LA MUSIQUE

Arret:
	CLR.L	(A4)
	MOVE.L	#$08000000,$FFFF8800.W	; VOIE A
	MOVE.L	#$09000000,$FFFF8800.W	; VOIE B
	MOVE.L	#$0A000000,$FFFF8800.W	; VOIE C

; RETOUR AU GFA

Exit:
	MOVE.W	#$20,-(SP)
	TRAP	#1
	ADDQ.L	#6,SP
	RTS

