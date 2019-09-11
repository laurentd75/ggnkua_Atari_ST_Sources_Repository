**********************************************************************
*                                                                    *
*  INT�GRATEUR PAR SENGAN SHORT. (C) 1991 L'AUTEUR                   *
*    En aucun cas l'auteur serait responsable d'un quelconque domage *
*  du � l'utilisation ou l'incapacit� � utiliser ce programme. C'est *
*  � dire vous l'utilisez � vos risques et p�rils. Vous avez int�r�t *
*  � sauvegarder votre code source avant de d�marrer l'int�grateur.  *
*   L'int�grateur ne fonctionne que sur ATARI STF/STE standard avec  *
* un 68000 tournant � 8 MHz...                                       *
*                                                                    *
**********************************************************************

; Commentaires
; Les lignes annot�s de ;; comme commentaire indiquent le code source
; en exemple.
; Tout commentaire devent une dirrective � l'assembleur reconnue par
; l'int�grateur (REPT et ENDR dans ce cas) ne sera pas inclus dans le
; code source g�n�r�.
; REPT 0 marche pas: le r�sultat sera REPT 1

**********************************************************************

		OPT D+	; �tiquettes dans le d�buggeur
Startup_Seq_Flag:	; Variable Interne (d�claration m�moire Gem)
Save_Vex_Flag:		; Idem (Sauvegarde de l'�tat du syst�me)
Reset_Intercept:	; Idem (Retour � Genst sur RESET)
Z�ro	equ	%00100	; Bit z�ro du CCR

**********************************************************************
; D�clarations	diverses pour le Gem.

	bsr.s	Startup_Sequence	; Taille m�moire utilis�e
	bsr	Attente_Gem
	clr.l	-(a7)			; Passage en mode superviseur
	move.w	#$20,-(a7)
	trap	#1
	move.l	d0,2(a7)
	move.w	#$20,(a7)
	bsr.s	Code
	trap	#1
	addq.w	#4,a7
	clr.w	(a7)
	trap	#1

**********************************************************************

ERREUR	macro
	 pea	.Message(pc)
	 move.w	#9,-(a7)
	 trap	#1
	 addq	#6,a7
	endm

**********************************************************************

Code:
; Routine principale
	move	#$2700,sr
	bsr.s	Sauvegarde_�tat		; Sauvegarde �tat machine
	bsr	PR�PARER_LISTE		; Cr�er	Liste chain�e
	move.l	a7,Int�gration_Termin�e+2 ; Sauvegarde a7
	bsr	INT�GRER		; L'int�gration

Int�gration_Termin�e:
	movea.l	#0,a7
	move.l	a5,Code_Objet		; Fin Code Objet
	bsr	TEST_CODE		; Tester le code
	bsr	Restaurer_�tat		; Restaurer �tat machine
	move	#$2300,sr
	bsr	�CRIRE_SOURCE		; G�n�rer et sauver le code
Quit_Code
	rts				; source int�gr�

**********************************************************************
* GESTION DE L'�TAT DE LA MACHINE
**********************************************************************

	IFD  Startup_Seq_Flag
Startup_Sequence:			; D�claration M�moire
	movea.l	(a7)+,a6
	movea.l	a7,a5
	movea.l	4(a5),a5
	move.l	$0C(a5),d0
	add.l	$14(a5),d0
	add.l	$1C(a5),d0
	add.l	#$0200,d0
	move.l	d0,d1
	add.l	a5,d1
	and.l	#$FFFFFFFE,d1
	movea.l	d1,a7
	move.l	d0,-(a7)
	move.l	a5,-(a7)
	clr.w	-(a7)
	move.w	#$4A,-(a7)
	trap	#1
	lea	12(a7),a7
	jmp	(a6)
	ENDC

	IFD  Save_Vex_Flag
Attente_Gem:
	moveq	#20,d7
.loop	move.w	#$25,-(a7)
	trap	#14
	addq	#2,a7
	dbra	d7,.loop
	rts

Sauvegarde_�tat:
	lea	�tat(pc),a0
	ENDC

	IFD	Reset_Intercept
	move.l	a7,Save_Ssp-�tat(a0)
	move.l	usp,a1
	move.l	a1,Save_Usp-�tat(a0)
	move.l	$426.w,Previous_Reset_Validity-�tat(a0)
	move.l	$42A.w,Previous_Reset_Routine-�tat(a0)
	lea	Reset(pc),a1
	move.l	#$31415926,$426.w	; Reset_Valid.w
	move.l	a1,$42A.w		; Reset_Vector
	move.l	#$752019F3,$420.w	; Memvalid
	move.l	#$237698AA,$43A.w	; Memvalid
	move.l	#$5555AAAA,$51A.w	; Memvalid
	ENDC
				
	IFD  Save_Vex_Flag
	lea	$FFFF8200.w,a1
	lea	$24(a0),a0
	move.b	$0A(a1),d0		; 50/60 Hz
	and.b	#2,d0
	move.b	d0,-(a0)
	move.b	$60(a1),-(a0)		; R�solution
	movem.l	$40(a1),d0-d7		; Palette
	movem.l	d0-d7,-(a0)
	movep.w	$01(a1),d0		; Adresse �cran
	move.w	d0,-(a0)
	lea	$24(a0),a0
	moveq	#$0F,d0			; Puce sonore
.Save_Yamaha
	move.b	d0,$FFFF8800.w
	move.b	$FFFF8800.w,(a0)+
	dbra	d0,.Save_Yamaha
	lea	$FFFFFA00.w,a1		; MFP
	movep.l	$03(a1),d0
	move.l	d0,(a0)+
	movep.w	$13(a1),d0
	move.w	d0,(a0)+
	move.b	$17(a1),(a0)+
	move.b	$19(a1),(a0)+
	move.b	$1B(a1),(a0)+
	move.b	$1D(a1),(a0)+
	moveq	#$01,d3
	moveq	#$00,d4
	lea	$1F(a1),a3
	lea	$19(a1),a2
	bsr.s	.ReadMfpDataRegister
	lea	$1B(a1),a2
	bsr.s	.ReadMfpDataRegister
	moveq	#$10,d3
	lea	$1D(a1),a2
	bsr.s	.ReadMfpDataRegister
	moveq	#$01,d3
	bsr.s	.ReadMfpDataRegister
	move.b	$29(a1),(a0)+
	addq.w	#1,a0
	move.l	$08.w,(a0)+		; �tat
	move.l	$68.w,(a0)+
	move.l	$70.w,(a0)+
	move.l	$0120.w,(a0)+
	move.l	$0134.w,(a0)+
	rts

.ReadMfpDataRegister:		; Routine par Belz�bub
	move.b	d3,(a2)		; modifi�e par Alien.
	move.b	d4,(a2)
	cmpi.b	#$01,(a3)
	bne.s	.ReadMfpDataRegister
.ReadOffsetData:
	move.b	d3,(a2)
	move.b	d4,(a2)
	cmpi.b	#$01,(a3)
	beq.s	.ReadOffsetData
	move.b	(a3),(a0)+
	addq.l	#$02,a3
	rts
	ENDC

	IFD	Reset_Intercept
Reset	move	#$2700,sr		; Sur Reset, restaurer
	move.l	Save_Ssp(pc),a7		; les piles et pr�parer
	move.l	Save_Usp(pc),a0		; la sortie du programme
	move.l	a0,usp
	lea	Quit_Code(pc),a0
	move.l	a0,(a7)
	ENDC

	IFD  Save_Vex_Flag
Restaurer_�tat
	move	#$2700,sr
	ENDC
	IFD	Reset_Intercept
	move.l	Previous_Reset_Validity(pc),$426.w
	move.l	Previous_Reset_Routine(pc),$42A.w
	ENDC
	IFD  Save_Vex_Flag
	lea	.Rte(pc),a0
	move.l	a0,$70.w
	lea	�tat(pc),a0
	lea	$FFFF8200.w,a1
	clr.l	$fffffa06.w
	clr.l	$fffffa12.w
	stop	#$2300
	stop	#$2300
	reset
	move	#$2700,sr
	move.w	(a0)+,d0
	movep.w	d0,$01(a1)		; Adresse �cran
	movem.l	(a0)+,d0-d7		; Couleurs
	movem.l	d0-d7,$40(a1)
	stop	#$2300
	move	#$2700,sr
	move.b	(a0)+,$60(a1)		; R�solution
	move.b	(a0)+,$0A(a1)		; 50/60 Hz
	lea	$FFFFFC00.w,a1		; ATTENTION RESET CLAVIER
	move.b	#$97,(a1)		; NE MARCHE PAS	SUR MEGA ST
	move.b	#$93,$04(a1)		; LE 6301 N'�TANT PAS RELI� �
	moveq	#127,d0			; LA BROCHE RESET !
.Wait_6301_1				; Attente neccessaire pour
	dbra	d0,.Wait_6301_1		; �viter errur 6301
	move.b	#$96,(a1)		; (entr�e en mode 1)
	move.b	#$91,$04(a1)
	move.w	#$0180,d0
.Wait_6301_2
	btst	#1,(a1)
	beq.s	.Wait_6301_2
	move.b	d0,2(a1)
	lsr.w	#8,d0
	bne.s	.Wait_6301_2
.Wait_6301_3
	btst	#0,(a1)
	beq.s	.Wait_6301_3
	tst.b	$FFFFFC02.w
	beq	Restaurer_�tat		; crash 6301, r�essayer...
	moveq	#$0F,d0
.Restore_Yamaha
	move.b	d0,$FFFF8800.w		; Puce sonore
	move.b	(a0)+,$FFFF8802.w
	dbra	d0,.Restore_Yamaha
	lea	$FFFFFA00.w,a1		; Mfp
	move.l	(a0)+,d0
	movep.l	d0,$03(a1)
	move.w	(a0)+,d0
	movep.w	d0,$13(a1)
	clr.b	$19(a1)
	clr.b	$1B(a1)
	clr.b	$1D(a1)
	move.l	4(a0),d0
	movep.l	d0,$1F(a1)
	move.b	(a0)+,$17(a1)
	move.b	(a0)+,$19(a1)
	move.b	(a0)+,$1B(a1)
	move.b	(a0)+,$1D(a1)
	lea	6(a0),a0
	move.b	-2(a0),$29(a1)
	move.l	(a0)+,$08.w
	move.l	(a0)+,$68.w
	move.l	(a0)+,$70.w
	move.l	(a0)+,$0120.w
	move.l	(a0)+,$0134.w
	rts
.Rte	rte

�tat			DS.W	44
Save_Ssp		DS.L	1
Save_Usp		DS.L	1
Previous_Reset_Routine	DS.L	1
Previous_Reset_Validity	DS.L	1
	ENDC

**********************************************************************
* TEST DE LA ROUTINE INT�GR�E
**********************************************************************

TEST_CODE:
	movea.l	Code_Objet(pc),a0	; Fin Code Objet
	move.w	#$4EF9,(a0)+		; jmp $000000
	lea	END_VBL(pc),a1		; Retour apr�s le code
	move.l	a1,(a0)+		; objet
	clr.l	$FFFFFA06.w		; Interdit int�rruptions MFP

	move.l	$FFFF8200.w,d0		; Adresse �cran
	lsl.w	#8,d0			; Remplir l'�cran de couleur
	movea.l	d0,a0			; 15 pour voir que
	move.w	#32000/4-1,d1		; l'overscan est bien
.Cls	move.l	#-1,(a0)+		; d�clench�
	dbra	d1,.Cls

	lea	rte(pc),a0		; Int�rruptions	en attente.
	move.l	a0,$70.w
	stop	#$2300
	stop	#$2300
	lea	VBL(pc),a0		; Le Test.
	move.l	a0,$70.w

Attente	cmpi.b	#$81,$FFFFFC02.w	; Sortie en appuyant sur
	bne.s	Attente			; la touche 'Esc'

	move	#$2700,sr
	rts

VBL:	movem.l	d0-a6,-(a7)		; La Vbl de test.
	move	#$2700,sr
	bsr	SOURCE_REGISTERS
	lea	$FFFF8260.w,a0
	lea	$FFFF820A.w,a1

.sync	move.b	$FFFF8209.w,d0		; Se synchroniser
	cmp.b	#$60,d0			; par raport au compteur
	bmi.s	.sync			; video
	moveq	#0,d0
	sub.b	$FFFF8209.w,d0
	lsl.l	d0,d0
	moveq	#0,d0
	REPT	40
	nop
	ENDR

	bra	CODE_OBJET		; Tester Code int�gr�

END_VBL	move.w	#$0777,$FFFF8240.w	; Quitter.
	movem.l	(a7)+,d0-a6
rte:	rte

**********************************************************************
* INT�GRATION
**********************************************************************

; Structure de	chaque noeud de	la liste:

; longmot :	Adresse de d�but de la section
;		du code source (0 si fin source)
; mot :		Longueur de la section du code
;		source
; mot : 	Nombre de nops � int�grer avant
;		cette section du code source.
; longmot :	Adresse du prochain noeud

Tab		EQU $09
Fin_De_Ligne	EQU $0A

; Structure de liste chain�e permettant d'integrer le code au niveau
; source.
				rsreset
Adresse_Source			rs.l	1
Longueur_Source			rs.w	1
Nombre_Nops_Pr�c�dent		rs.w	1
Prochain_Noeud			rs.l	1
Longueur_�l�ment_Liste		rs.w	0

**********************************************************************

Nombre_De_Lignes	EQU	190	; Derni�re ligne avant attente
					; VBL
Nombre_Lignes_Overscan	EQU	118	; Nombre lignes	int�gr�s.
Instr_Addresse		EQU	2+2+4*5	; Position sur la pile du PC

INT�GRER:
; Initialisation des variables/hardware pour l'exception trace et
; d�marrage de l'int�gration...
	lea	Variables(pc),a6
	clr.b	$FFFF8260.w		; 320 cycles par ligne vid�o
	lea	Int�grer_Trace(pc),a0	; On se	sert de	l'exception
	move.l	a0,$24.w		; Trace.

	lea	CODE_SOURCE(pc),a0	; Adresse de l'intruction qui
	move.l	a0,Ancienne_Addresse-V(a6) ; vient d'�tre �ffectu�e
	move.w	#3*Nombre_Lignes_Overscan+1,Num�ro_De_Zone-V(a6)
	lea	CODE_OBJET(pc),a1	; Code que l'on g�n�rera et
	move.l	a1,Code_Objet-V(a6)	; que l'on testera

	pea	(a5)

	lea	$FFFF8200.w,a5		; V�rifier qu'on a encore
Attendre_VBL2				; assez de temps avant la VBL
	movep.l	3(a5),d1		; pour d�marrer une exception
	move.w	2(a5),d0		; trace
	lsl.w	#8,d0
	sub.w	d0,d1
	cmp.w	#Nombre_De_Lignes*160,d1
	bpl.s	Attendre_VBL2

	movea.l	(a7)+,a5
	bsr	SOURCE_REGISTERS	; Inits	registres pour Code
	move.w	d0,-(a7)

	pea	(a6)
	lea	Variables(pc),a6

.Sync1	move.b	$FFFF8209.w,d0
	cmp.b	$FFFF8209.w,d0		; Attente de la	fin d'une
	bne.s	.Sync1			; ligne
.Sync2	cmp.b	$FFFF8209.w,d0		; Attente d�but	d'une ligne
	beq.s	.Sync2

.Sync3	move.b	$FFFF8209.w,d0
	cmp.b	$FFFF8209.w,d0		; Attente de la	fin d'une
	bne.s	.Sync3			; ligne
	move.b	d0,Old_Raster-V(a6)
	movea.l	(a7)+,a6
.Sync4	cmp.b	$FFFF8209.w,d0		; Attente d�but	d'une ligne
	beq.s	.Sync4
	sub.b	$FFFF8209.w,d0
	add.w	#28-6,d0
	lsl.w	d0,d0
	move.w	(a7)+,d0
	bra	CODE_SOURCE-6

			*********************

; L'exception Trace:
; Registres: d0/d1/a3/a4 = Travail
;            a5 = Code Objet que nous g�n�rons
;            a6 = Pointeur sur Variables

Int�grer_Trace:
	move.w	d0,-(a7)
	move.b	$FFFF8209.w,d0		; D�terminer le	temps pris
	movem.l	d1/a3-a6,-(a7)		; par l'instruction
	lea	Variables(pc),a6
	sub.b	Old_Raster(pc),d0
	sub.b	#$4E,d0			; Temps	pris pour 0 cycles
	and.w	#$FE,d0
	ori.w	#$8700,Instr_Addresse-2(a7) ; SR
	movea.l	Code_Objet(pc),a5	; Code que l'on g�n�re

Tester_Temps:
	sub.w	d0,Nombre_Cycles_Restants-V(a6) ; A t'on le temps pour
	bpl.s	Pas_De_Fausse_Interruption ; rajouter une instruction?

Ajouter_Fausse_Interruption:		; Non: rajouter	la fausse
	movea.l	Espace_Libre(pc),a3	; interruption.	D�vier la
	movea.l	Current_Element(pc),a4	; liste cha�n�e pour y inclure
	move.l	Prochain_Noeud(a4),Prochain_Noeud(a3)
					; la fausse int�rruption
	move.l	a3,Prochain_Noeud(a4)	; d�clar�e en m�moire libre
	move.l	a3,Current_Element-V(a6)

	move.w	Nombre_Cycles_Restants(pc),d1	; Calcul du nombre
	add.w	d0,d1				; de nops � rajouter
	move.w	d1,Nombre_Nops_Pr�c�dent(a4)	; devant l'instruction

Cr�er_Attente:
	subq.w	#2,d1			; Rajouter les nops pour
	bmi.s	Fin_Cr�er_Attente	; faire perdre le temps
	move.w	#$4E71,(a5)+		; n�cessaire au programme
	bra.s	Cr�er_Attente		; objet.

Fin_Cr�er_Attente:			; On est � la ni�me fausse
	subq.w	#1,Num�ro_De_Zone-V(a6)	; interruption:	Est-ce la
	beq	Int�gration_Termin�e	; dern�re ?

	movea.l	Zone_Suivante(pc),a4	; Rajouter la fausse
	move.w	(a4)+,d1		; interruption
	move.w	(a4)+,Nombre_Cycles_Restants-V(a6)
	move.l	(a4)+,Zone_Suivante-V(a6)

Copie_FausseInt
	move.w	(a4)+,(a5)+	; Copie du code objet de la fausse
	dbra	d1,Copie_FausseInt ; interuption dans le code objet.

	move.l	(a4)+,Adresse_Source(a3)	; Copie de l'�l�ment
	move.w	(a4)+,Longueur_Source(a3)	; de la liste chain�e
	clr.w	Nombre_Nops_Pr�c�dent(a3)	; qui fait r�f�rence
	lea	Longueur_�l�ment_Liste(a3),a3	; au source de la
	move.l	a3,Espace_Libre-V(a6)	; fausse intrruption dans 1
	bra.s	Tester_Temps		; nouveau �l�ment de la liste

Pas_De_Fausse_Interruption
	; Passer au prochain �l�ment de la liste chain�e
	movea.l	Current_Element(pc),a3
	move.l	Prochain_Noeud(a3),Current_Element-V(a6)

	; Copie de l'instruction dont on vient de d�terminer la dur�e
	movea.l	Instr_Addresse(a7),a4	 ; Fin de l'instruction
	movea.l	Ancienne_Addresse(pc),a3 ; D�but de l'instruction

.Copier_Instruction:
	cmpa.l	a3,a4
	beq.s	.Fin_Copier_Instruction
	move.w	(a3)+,(a5)+
	bra.s	.Copier_Instruction

.Fin_Copier_Instruction:
	move.w	(a4),d0			; V�rifier si l'instruction
	move.w	d0,d1			; qui suit est la commande
	and.w	#$F000,d1		; d'int�gration de bloc.
	cmp.w	#$A000,d1
	bne.s	Pas_Int�gration_de_Bloc

	move.l	a4,Ancienne_Addresse-V(a6)
	eor.w	d1,d0			; Nombre de cycles restants
	sub.w	d0,Nombre_Cycles_Restants-V(a6) ; suffisant pour
	bmi	Ajouter_Fausse_Interruption ; l'int�gration ?

	addq.w	#2,a4			; Copie des instructions du
	move.w	(a4)+,d1		; bloc
Copier_Bloc:
	move.w	(a4)+,(a5)+
	dbra	d1,Copier_Bloc
	move.l	a4,Instr_Addresse(a7)

Pas_Int�gration_de_Bloc:
	move.l	a4,Ancienne_Addresse-V(a6)
	move.l	a5,Code_Objet-V(a6)

	lea	$FFFF8200.w,a5		; V�rifier s'il reste
Attendre_VBL:
	movep.l	3(a5),d1		; suffisament de temps
	move.w	2(a5),d0		; pour d�marrer une nouvelle
	lsl.w	#8,d0			; �tape d'int�gration
	sub.w	d0,d1			; (execution instruction
	cmp.w	#Nombre_De_Lignes*160,d1 ; + exception trace)
	bpl.s	Attendre_VBL

	movem.l	(a7)+,d1/a3-a5

.Sync1	move.b	$FFFF8209.w,d0
	cmp.b	$FFFF8209.w,d0		; Attente de la	fin d'une
	bne.s	.Sync1			; ligne
.Sync2	cmp.b	$FFFF8209.w,d0		; Attente d�but	d'une ligne
	beq.s	.Sync2

.Sync3	move.b	$FFFF8209.w,d0
	cmp.b	$FFFF8209.w,d0		; Attente de la	fin d'une
	bne.s	.Sync3			; ligne
	move.b	d0,Old_Raster-V(a6)
	movea.l	(a7)+,a6
.Sync4	cmp.b	$FFFF8209.w,d0		; Attente d�but	d'une ligne
	beq.s	.Sync4
	sub.b	$FFFF8209.w,d0

	add.w	#28,d0
	lsl.w	d0,d0
	move.w	(a7)+,d0
	rte

**********************************************************************
* PR�PARATION DU CODE SOURCE
**********************************************************************
; Cette partie cr�e la liste chain�e qui d�crit le code source.
; Registres: a0: Code Source
;            a1: Liste Chain�e
;            a2/a3: Registres de Travail
;            d0/d1: Idem

PR�PARER_LISTE
P	equ	PR�PARER_LISTE		; abbr�viation !
	movem.l	d0-d1/a0-a3,-(a7)
	lea	PR�PARER_LISTE(pc),a6
	lea	LISTE,a1
	lea	CODE_ASCII,a0
	clr.w	Compteur_REPT-P(a6)
	move.l	a0,Adresse_Source(a1)

; D'abord l'on traite les lignes de code qui ne comportent pas
; d'instructions assembleurs: lignes vides, de commentaires, ou de
; directives d'assemblage.

Analyse	cmpa.l	#FIN_CODE_ASCII,a0
	beq.s	Fin_Du_Source

	move.b	(a0)+,d0
	cmp.b	#';',d0		; symbole ';' en d�but de
	beq	Commentaire	; ligne: Commentaire
	cmp.b	#' ',d0		; Tab etc pris en charge
	ble.s	Analyse

	lsl.w	#8,d0		; Lit les 3 octets qui suivent
	move.b	(a0),d0		; pour former un long mot
	swap	d0
	movep.w	1(a0),d0
	move.b	2(a0),d0
	and.l	#$DFDFDFDF,d0

	cmp.l	#'REPT',d0
	beq.s	Rept
	cmp.l	#'ENDR',d0
	beq	Endr

	bsr.s	Trouver_Ligne_Suivante
	bne.s	Fin_Du_Source

; Il s'agit donc d'une ligne comportant ce qui est reconnu comme une
; instruction assembleur.

	move.l	a0,d0
	sub.l	Adresse_Source(a1),d0
	move.w	d0,Longueur_Source(a1)
	clr.w	Nombre_Nops_Pr�c�dent(a1)
	lea	Longueur_�l�ment_Liste(a1),a1
	move.l	a1,Prochain_Noeud-Longueur_�l�ment_Liste(a1)
	move.l	a0,Adresse_Source(a1)
	bra.s	Analyse

Fin_Du_Source:
; On finit l'insertion de la ligne source dans la liste chain�e et on
; termine cette liste chain�e en mettant la prochaine adresse de
; source � z�ro. On verifie aussi si tous les boucles rept ont �t�
; compl�t�s (v�rification essentielle puisque les informations pour le
; REPT sont sauvegard�es sur la pile.

	move.l	a0,d0
	sub.l	Adresse_Source(a1),d0
	move.w	d0,Longueur_Source(a1)
	clr.w	Nombre_Nops_Pr�c�dent(a1)
	lea	Longueur_�l�ment_Liste(a1),a1
	move.l	a1,Prochain_Noeud-Longueur_�l�ment_Liste(a1)
	clr.l	Adresse_Source(a1)	; Marqueur fin de liste
	lea	Longueur_�l�ment_Liste(a1),a1
	tst.w	Compteur_REPT-P(a6)
	bne	Erreur_Rept
	move.l	a1,Espace_Libre-P(a6)
	movem.l	(a7)+,d0-d1/a0-a3
	rts

Commentaire:
; Les commentaires sont consid�r�s comme des charact�res sans validit�
; (comme l'espace ou la tabulation) devant une instruction assembleur.
	bsr.s	Trouver_Ligne_Suivante
	bne.s	Fin_Du_Source
	bra	Analyse

Trouver_Ligne_Suivante:
; Cette routine positionne a0 au d�but de la ligne suivante.
; le bit Z du CCR est � 0 si la fin du source a �t� atteint.
	cmpa.l	#FIN_CODE_ASCII,a0
	beq.s	.Fin_Du_Source
	cmpi.b	#Fin_De_Ligne,(a0)+
	bne.s	Trouver_Ligne_Suivante
	or.b	#Z�ro,ccr
	rts
.Fin_Du_Source
	and.b	#~Z�ro,ccr
	rts

Rept:
; Le REPT est ignor�. C'est � dire qu'il n'est m�me pas inclus dans la
; liste chain�e. La routine sauve le noeud de la liste chain�e
;  correspondant au d�but du code � r�p�ter, ainsi que le nombre de
; fois qu'il doit �tre r�p�t�.
	lea	3(a0),a0	; On saute les letrres 'EPT'
	pea	Adresse_Source(a1)	; Sauver noeud de r�p�tition
	addq.w	#1,Compteur_REPT-P(a6)	; Un niveau de REPT de plus

	moveq	#0,d1
.Rept_Analyse1
	move.b	(a0)+,d1		; Analyse du premier chiffre
	cmp.b	#Fin_De_Ligne,d1	; sans lequel le REPT a �t�
	beq	Erreur_Parametre_Rept	; mal d�fini
	cmp.b	#' ',d1
	ble.s	.Rept_Analyse1
	cmp.b	#';',d1
	beq	Erreur_Parametre_Rept
	cmp.b	#'0',d1
	blt	Erreur_Parametre_Rept
	cmp.b	#'9',d1
	bgt	Erreur_Parametre_Rept

	sub.b	#'0',d1
	moveq	#0,d0

.Rept_Analyse2:
	move.b	(a0)+,d0		; Analyse des chiffres
	cmp.b	#'0',d0			; suivants, et conversion
	blt.s	.Fin_Rept_Analyse2	; d�cimal -> binaire
	cmp.b	#'9',d0
	bgt.s	.Fin_Rept_Analyse2
	mulu	#10,d1
	sub.b	#'0',d0
	add.l	d0,d1
	bra.s	.Rept_Analyse2

.Fin_Rept_Analyse2:
	move.l	d1,-(a7)		; Sauvegarde du nombre de
	bsr	Trouver_Ligne_Suivante	; fois qu'il faut r�p�ter.
	bne	Fin_Du_Source
	move.l	a0,Adresse_Source(a1)
	bra	Analyse

Endr:
; L'ENDR est aussi ignor�: non-inclus dans la liste chain�e. Par
; contre c'est ici qu'est �ffectu�e la r�petition de la partie de la
; liste chain�e correspondant au code � r�p�ter.
	subq.w	#1,Compteur_REPT-P(a6)
	bmi.s	Erreur_Rept
	move.l	(a7)+,d1
	movea.l	(a7)+,a2

.Copier_Rept1
	subq.l	#1,d1
	ble.s	.Fin_Copier_Rept
	movea.l	a1,a3
.Copier_Rept2
	cmpa.l	a2,a3
	beq.s	.Copier_Rept1
	move.l	Adresse_Source(a2),Adresse_Source(a1)
	move.w	Longueur_Source(a2),Longueur_Source(a1)
	move.w	Nombre_Nops_Pr�c�dent(a2),Nombre_Nops_Pr�c�dent(a1)
	lea	Longueur_�l�ment_Liste(a2),a2
	lea	Longueur_�l�ment_Liste(a1),a1
	move.l	a1,Prochain_Noeud-Longueur_�l�ment_Liste(a1)
	bra.s	.Copier_Rept2

.Fin_Copier_Rept
	bsr	Trouver_Ligne_Suivante
	bne	Fin_Du_Source
	move.l	a0,Adresse_Source(a1)	; Nouveau �l�ment de liste
	bra	Analyse

Erreur_Rept:	ERREUR
.ici		bra.s	.ici
.Message	dc.b	"Erreur: le nombre de REPT et de ENDR n'est "
		dc.b    "pas identique !",0
		even
Erreur_Parametre_Rept:
		ERREUR
.ici		bra.s	.ici
.Message	dc.b	"Erreur: REPT n'est pas suivit par un nombre "
		dc.b	" d�cimal !",0
		even

Compteur_REPT:	DS.W 1

**********************************************************************
* SAUVER LE SOURCE G�N�R�
**********************************************************************

; registres utilis�s
;            d0/a0 par le Gemdos
;            d4 = Travaux temporaires
;            d5 = Addresse de fin de la section de source
;            d6 = Longueur de la section de source trait�e
;            a4 = Travaux temporaires
;            a5 = Adresse du noeud de la liste chainee de source
;            a6 = Adresse de la section de source trait�e

�CRIRE_SOURCE:
	bsr	Initialiser_Liste_Des_�tiquettes
	bsr	Ouvrir_Fichier
	movea.l	LISTE2+Prochain_Noeud,a5

G�n�rer_Source:
	tst.l	Adresse_Source(a5)	; Marqueur de fin de la
	bne	.Continuer_�crire_Source ; liste chain�e ?
	bsr	Fermer_Fichier
	rts

.Continuer_�crire_Source:
	move.l	Adresse_Source(a5),a6
	moveq	#0,d6
	move.w	Longueur_Source(a5),d6
	move.l	d6,d5
	add.l	a6,d5

Trouver_�tiquette_Initiale:
; On v�rifie d'abord si une �tiquette initiale est d�clar�e (c'est �
; dire pr�sente au d�but de la ligne).
	cmp.l	a6,d5
	ble	Aucune_�tiquette_Op�rande

	cmpi.b	#' ',(a6)
	ble.s	Aucune_�tiquette_Initiale
	cmpi.b	#';',(a6)
	beq.s	Ligne_Commentaire

	st	�tiquette_�_D�clarer
	bsr	Traiter_�tiquette

Aucune_�tiquette_Initiale:
; Puis on verifie s'il y a une �tiquette dans les op�randes de
;  l'instruction assembleur trait�e.
	movea.l	a6,a4

Trouver_�tiquette_Op�rande:
	move.b	(a4)+,d4
	cmp.l	a4,d5
	ble.s	Aucune_�tiquette_Op�rande
	cmp.b	#Fin_De_Ligne,d4
	beq.s	Fin_de_Ligne
	cmp.b	#'�',d4
	bne.s	Trouver_�tiquette_Op�rande

	move.l	a4,d4		; Une �tiquette parmi les
	sub.l	a6,d4		; op�randes a �t� trouv�e:
	sub.l	d4,d6		; Il faut donc �crire
	subq.l	#1,d4		; l'instruction assembleur
	movem.l	d4/a6,-(a7)	; dans le fichier avant
	bsr	�crire_Fichier	; l'�tiquette
	movea.l	a4,a6		; Puis on traite l'�tiquette
	sf	�tiquette_�_D�clarer
	bsr	Traiter_�tiquette
	movea.l	a6,a4
	bra.s	Trouver_�tiquette_Op�rande

Fin_de_Ligne:
	move.l	a4,d4		; On copie ce qui se trouve apr�s
	sub.l	a6,d4		; les op�randes (comme les
	sub.l	d4,d6		; commentaires)
	movem.l	d4/a6,-(a7)
	bsr	�crire_Fichier
	movea.l	a4,a6
	bra.s	Trouver_�tiquette_Initiale

Ligne_Commentaire:
; On �crit la ligne commentaire dans le fichier source, puis on passe
; � la ligne suivante de la section source.
	pea	(a6)
.Boucle	cmp.l	a6,d5		; Trouve la ligne suivante
	ble.s	.Aucune_�tiquette_Op�rande
	cmpi.b	#Fin_De_Ligne,(a6)+
	bne.s	.Boucle
	move.l	(a7),-(a7)	; �crit la ligne commentaire
	move.l	a6,d4		; dans le fichier source
	sub.l	(a7),d4
	move.l	d4,(a7)
	bsr	�crire_Fichier
	move.l	d5,d6		; change la longueur de la section
	sub.l	a6,d6		; source qui ne contient plus le
	bra	Trouver_�tiquette_Initiale	; commentaire

.Aucune_�tiquette_Op�rande
	move.l	(a7)+,a6	; ligne commentaire seule

Aucune_�tiquette_Op�rande
; Il ne reste plus d'�tiquettes � traiter.
	movem.l	d6/a6,-(a7)
	bsr	�crire_Fichier

	move.w	Nombre_Nops_Pr�c�dent(a5),d6	; G�n�rer les nops
G�n�rer_Nops
	subq.w	#2,d6
	bmi.s	Ligne_Suivante
	pea	NOP(pc)				; On �crit un NOP
	move.l	#NOP_FIN-NOP,-(a7)		; dans le fichier
	bsr	�crire_Fichier
	bra.s	G�n�rer_Nops

Ligne_Suivante
	movea.l	Prochain_Noeud(a5),a5
	bra	G�n�rer_Source

			*********************

; La Base_�tiquette est construite apr�s l'Espace_Libre. C'est l� o�
; la table des �tiquettes sera construite. � chaque �tiquette
; correspondront les champs suivants:
; Mot Long: Adresse de l'�tiquette dans le code source (ou 0 si c'est
;           la derniere �tiquette de la table)
; Mot     : Longeur de l'�tiquette
; Mot     : Num�ro de l'�tiquette (pour l'�tiquette initiale)
; Mot     : Num�ro de l'�tiquette (pour l'�tiquette de l'op�rande
;           d'une commande assembleur.)

				rsreset
Adresse_�tiquette		rs.l	1
Longueur_�tiquette		rs.w	1
Num�ro_Extention_Initiale	rs.w	1
Num�ro_Extention_Op�rande	rs.w	1
Longueur_�lement_�tiquette	rs.w	0

Initialiser_Liste_Des_�tiquettes
	movea.l	Espace_Libre(pc),a6
	move.l	a6,Base_�tiquette
	clr.l	(a6)
	rts

			**********************

; Num�rotation des �tiquettes
; registres: d2/d3/a3/a5 travail
;            a4          Adresse de l'�l�ment de la table �tiquette
;                        trait�
; en entr�e: a6          Adresse de la section du code source trait�e
;            d6          Longueur de la section du code source trait�e
; et �tiquette_�_D�clarer = Vrai (-1) si on traite une �tiquette
;                        initiale

Traiter_�tiquette:
	movem.l	d2-d3/a3-a5,-(a7)
	movea.l	Base_�tiquette(pc),a4
	bra.s	.over

; On tente d'abord de trouver l'�tiquette dans la table d'�tiquettes.
; En m�me temps on v�rifie que l'on a pas d�pass� la fin de
; l'�tiquette � trouver avec la sous-routine Charact�re_D_�tiquette?.
.Mauvaise_�tiquette:
	lea	Longueur_�lement_�tiquette(a4),a4
.over	movea.l	a6,a5
	move.l	Adresse_�tiquette(a4),d2
	beq	Ajouter_�tiquette_�_La_Table
	movea.l	d2,a3
	move.w	Longueur_�tiquette(a4),d3
	subq.w	#1,d3
.Comparer_�tiquettes
	move.b	(a3)+,d2
	bsr	Charact�re_D_�tiquette?
	bne.s	.Mauvaise_�tiquette
	cmp.b	(a5)+,d2
	bne.s	.Mauvaise_�tiquette
	dbra	d3,.Comparer_�tiquettes
	move.b	(a3)+,d2
	bsr	Charact�re_D_�tiquette?
	beq.s	.Mauvaise_�tiquette
	bra.s	�tiquette_Trouv�e

Ajouter_�tiquette_�_La_Table:
; L'�tiquette n'ayant pas �t� trouv�e il faut la rajouter � la table.
	move.l	a5,Adresse_�tiquette(a4)
.D�terminer_Longueur_�tiquette:
	move.b	(a5)+,d2
	bsr	Charact�re_D_�tiquette?
	beq.s	.D�terminer_Longueur_�tiquette
	subq.w	#1,a5
	move.l	a5,d2
	sub.l	a6,d2
	move.w	d2,Longueur_�tiquette(a4)
	clr.w	Num�ro_Extention_Initiale(a4)
	clr.w	Num�ro_Extention_Op�rande(a4)
	clr.l	Longueur_�lement_�tiquette+Adresse_�tiquette(a4)

�tiquette_Trouv�e:
; D�sormais a4 contient la r�f�rence � l'�tiquette dans la table des
; �tiquettes. On �crit l'�tiquette dans le fichier de source g�n�r�.
	pea	(a6)
	move.l	a5,d3
	sub.l	a6,d3
	sub.l	d3,d6			; Corriger d6
	move.l	d3,-(a7)
	bsr	�crire_Fichier
	move.l	a5,a6

; Il ne reste plus qu'� �crire le num�ro de l'�tiquette. Il faut donc
; distinguer la d�claration initiale de l'�tiquette dans l'op�rande
; d'une instruction assembleur.
	tst.b	�tiquette_�_D�clarer
	bne.s	.�tiquette_Initiale
offset	set	Num�ro_Extention_Op�rande-Num�ro_Extention_Initiale
	lea	offset(a4),a3
	bra.s	.over
.�tiquette_Initiale
	movea.l	a4,a3

.over	moveq	#0,d3
	move.w	Num�ro_Extention_Initiale(a3),d3
	addq.w	#1,Num�ro_Extention_Initiale(a3)

Conversion_D�cimale:
; Routine de conversion en d�cimal (limit�e � des nombres de taille
; maximale $7FFF*10... ce qui devrait suffire pour la num�rotation des
; �tiquettes. La routine est fond�e sur le fait que divu met le reste
; dans le mot fort du r�sultat.
; NB: Attention on travaille avec la pile pour retourner le nombre
; g�n�r�, donc il faut �viter de quitter cette routine avant la fin !

	lea	Espace_Nombre(pc),a5	; Espace de travail pour
	movea.l	a5,a3			; les nombres cr��s.
	clr.b	-(a7)			; Pointeur de fin du nombre
					; convertit.
.prochain_chiffre
	tst.w	d3
	beq.s	.retourner_nombre
	divu	#10,d3
	swap	d3
	add.b	#'0',d3
	move.b	d3,-(a7)
	clr.w	d3
	swap	d3
	bra.s	.prochain_chiffre

.retourner_nombre:	
	move.b	(a7)+,(a5)+		; Remettre dans le bon ordre !
	bne.s	.retourner_nombre

	move.l	a5,d3			; V�rifier taille du nombre
	sub.l	a3,d3			; ainsi cr��.
	subq.l	#1,d3
	ble.s	.�tiquette_Non_Num�rot�e

	movem.l	d3/a3,-(a7)
	bsr	�crire_Fichier

.�tiquette_Non_Num�rot�e:
	movem.l	(a7)+,d2-d3/a3-a5
	rts

Charact�re_D_�tiquette?:
; Cette routine v�rifie si le charact�re en entr�e Char peut
; appartenir � une �tiquette. Si tel est le cas il revient avec le bit
; Z de CCR � 1. Il faut savoir que la liste des charact�res trait�es
; n'est pas exhaustive puisqu'elle d�pend de l'assembleur employ�.
	cmp.b	#'_',d2
	beq.s	.�tiquette_Char_Ok
	cmp.b	#'0',d2
	blt.s	.�tiquette_Char_Ko
	cmp.b	#'9',d2
	ble.s	.�tiquette_Char_Ok
	cmp.b	#'A',d2
	blt.s	.�tiquette_Char_Ko
	cmp.b	#'Z',d2
	ble.s	.�tiquette_Char_Ok
	cmp.b	#'a',d2
	blt.s	.�tiquette_Char_Ko
	cmp.b	#'z',d2
	ble.s	.�tiquette_Char_Ok
.�tiquette_Char_Ko
	;and.b #~Z�ro,ccr
	rts
.�tiquette_Char_Ok
	or.b #Z�ro,ccr
	rts

		even
�tiquette_�_D�clarer	ds.w	1
Base_�tiquette:		DS.L 1
Espace_Nombre:		DS.B 8
		even

**********************************************************************
; Routines de gestion de la sauvegarde du source par le GEMDOS.

GEMDOS	macro	\0,\1,\2
	move.w	#\1,-(a7)		; existe d�j�.
	trap	#1
	lea	\2(a7),a7
	tst.\0	d0
	endm

Ouvrir_Fichier
	move.w	#2,-(a7)
	pea	nom_fichier(pc)		; Fopen si le fichier
	GEMDOS.w $3D,8			; existe d�j�, on va le
	bmi.s	.Fichier_Inexistant	; d�truire de fa�on �
	move.w	d0,-(a7)		; ce si le fichier original
	GEMDOS.w $3E,4			; �tait plus long que celui
	bmi.s	Erreur_Gemdos		; que nous allons g�n�rer,
	pea	nom_fichier(pc)		; nous n'aurons pas de datas
	GEMDOS.w $41,6			; anciens � la fin du
	bmi.s	Erreur_Gemdos		; fichier final

.Fichier_Inexistant
	clr.w	-(a7)			; Fcreate
	pea	nom_fichier(pc)		; (sur certains tos,
	GEMDOS.w $3C,8			; si vous cr�ez	un fichier
	bmi.s	Erreur_Gemdos		; qui existe d�j�, vous	en
	move.w	d0,Identificateur_Fichier ; obtiendrez 2 avec le
	rts				; m�me nom !

�crire_Fichier
	move.l	8(a7),d0	; On prend les mots longs A B C
	move.l	(a7),8(a7)	; et on les met dans l'ordre
	move.l	4(a7),(a7)	; B C A (A correspondant �
	move.l	d0,4(a7)	; l'adresse de retour)
	move.w	Identificateur_Fichier(pc),-(a7)
	GEMDOS.l $40,12		; FWrite
	bmi.s	Erreur_Gemdos
	rts

Fermer_Fichier
	move.w	Identificateur_Fichier(pc),-(a7)
	GEMDOS.w $3E,4
	bmi.s	Erreur_Gemdos
	rts

Erreur_Gemdos
	ERREUR
	illegal
.Message	dc.b	"Erreur Gemdos lors de la sauvegarde du "
		dc.b	"fichier de source g�n�r� !",0
		even

Identificateur_Fichier	ds.w	1
nom_fichier:		DC.B	'f:\op.s',0
		even

**********************************************************************
* CODE SOURCE ASSEMBL�
**********************************************************************

SOURCE_REGISTERS:
; Ici on doit initialiser les registres dont le code source aura
;  besoin.
	move.l	$FFFF8200.w,d0	;;
	lsl.w	#8,d0		;;
	addq.w	#2,d0		;;
	movea.l	d0,a2		;; a2: position �cran des sprites
	lea	230*10(a2),a2	;; a3 pointe sur les graphismes
	move.l	$4.w,a3		;; pour ne pas avoir � en faire
	movea.l	d0,a4		;; on affiche la rom !
	lea	160+230(a4),a4	;; a4: position �cran du scroll
	lea	Carte(pc),a6	;; Carte pour le d�cor � imprimer
	moveq	#0,d1		;; en fond
	rts

Carte:		DS.W 14		;;
Offset:		DC.L 0		;;
Fond:				;;

	nop				; Ce code doit toujours
	move	#$A700,sr		; pr�c�der code	source
CODE_SOURCE:

; C'est ici qu'il faut mettre son source � int�grer.
;; L'exemple ci-dessous montre le code de base d'une d�mo telle que le
;; main menu de la Lightening Demo, par Pendragons: Il nous faut
;; afficher un sprite de 32*32 comme personnage � dirriger. Ensuite
;; nous avons un scroller horizontal non-optimis�, de 7 lignes de haut
;; et de 1 plan. Suit le code pour afficher le fond. Ici on a affaire
;; � 1 HARDSCROLL, et on a besoin d'avoir 1 �cran logique et 1 �cran
;; physique � cause des sprites Pendragons qui parcourrent l'image
;; enti�re. Donc il nous faut 3 images en m�moire, et il faut afficher
;; l'image en haut/bas de l'image 3 fois.
;; Comme vous voyez, m�me si l'efficacit� de l'int�gration est
;; m�diocre, le code pour cette d�mo s'int�gre en 118 lignes seulement
;; dont 72 pour les 9 sprites 'Pendragons'.


	REPT 32			;; Le sprite 32*32
	movem.l	(a2),d2-d7	;; (le petit bonhomme qui se
	and.l	(a3),d2		;; prom�ne sur le d�cor)
	and.l	(a3)+,d3	;;
	or.l	(a3)+,d2	;;
	or.l	(a3)+,d3	;;
	and.l	(a3),d4		;;
	and.l	(a3)+,d5	;;
	or.l	(a3)+,d4	;;
	or.l	(a3)+,d5	;;
	and.l	(a3),d6		;;
	and.l	(a3)+,d7	;;
	or.l	(a3)+,d6	;;
	or.l	(a3)+,d7	;;
	movem.l	d2-d7,(a2)	;;
	lea	230(a2),a2	;;
	ENDR			;;

Intern1	SET 27*8		;; Scroller du scrolltext 1 plan
	lsl.w	Intern1(a4)	;; (qui a 7 lignes)
	REPT 26			;;
Intern1	SET Intern1-8		;;
	roxl.w	Intern1(a4)	;;
	ENDR			;;
	roxl.w	(a4)		;;
	lea	230(a4),a4	;;

Intern2	SET 27*8		;;
	lsl.w	Intern2(a4)	;;
	REPT 26			;;
Intern2	SET Intern2-8		;;
	roxl.w	Intern2(a4)	;;
	ENDR			;;
	roxl.w	(a4)		;;
	lea	230(a4),a4	;;

Intern3	SET 27*8		;;
	lsl.w	Intern3(a4)	;;
	REPT 26			;;
Intern3	SET Intern3-8		;;
	roxl.w	Intern3(a4)	;;
	ENDR			;;
	roxl.w	(a4)		;;
	lea	230(a4),a4	;;

Intern4	SET 27*8		;;
	lsl.w	Intern4(a4)	;;
	REPT 26			;;
Intern4	SET Intern4-8		;;
	roxl.w	Intern4(a4)	;;
	ENDR			;;
	roxl.w	(a4)		;;
	lea	230(a4),a4	;;

Intern5	SET 27*8		;;
	lsl.w	Intern5(a4)	;;
	REPT 26			;;
Intern5	SET Intern5-8		;;
	roxl.w	Intern5(a4)	;;
	ENDR			;;
	roxl.w	(a4)		;;
	lea	230(a4),a4	;;

Intern6	SET 27*8		;;
	lsl.w	Intern6(a4)	;;
	REPT 26			;;
Intern6	SET Intern6-8		;;
	roxl.w	Intern6(a4)	;;
	ENDR			;;
	roxl.w	(a4)		;;
	lea	230(a4),a4	;;

Intern7	SET 27*8		;;
	lsl.w	Intern7(a4)	;;
	REPT 26			;;
Intern7	SET Intern7-8		;;
	roxl.w	Intern7(a4)	;;
	ENDR			;;
	roxl.w	(a4)		;;
	lea	230(a4),a4	;;

	REPT 144		;; 9 sprites 16*16
	movem.l	(a2),d2-d5	;; 'PENDRAGONS'
	and.l	(a3),d2		;;
	and.l	(a3)+,d3	;;
	or.l	(a3)+,d2	;;
	or.l	(a3)+,d3	;;
	and.l	(a3),d4		;;
	and.l	(a3)+,d5	;;
	or.l	(a3)+,d4	;;
	or.l	(a3)+,d5	;;
	movem.l	d2-d5,(a2)	;;
	lea	0(a2),a2	;;
	ENDR			;;

	adda.l	Offset,a4	;; Affichage du	fond
	movea.l	a4,a2		;; a2,a3,a4 servent
	movea.l	a4,a3		;; pour les 3 �crans
	adda.l	#0,a2		;; permettant le scroll
	adda.l	#0,a3		;; donc il faut mettre
	REPT 14			;; 1 fois et 2 fois la
	lea	Fond(pc),a5	;; longueur d'1 �cran
	adda.l	d1,a5		;; dans les op�randes
	adda.w	(a6)+,a5	;; imm�diates des deux
	movem.l	(a5)+,d2-d5	;; adds, respectivement
	movem.l	d2-d5,(a2)	;;
	movem.l	d2-d5,(a3)	;;
	movem.l	d2-d5,(a4)	;;
	lea	16(a2),a2	;;
	lea	16(a3),a3	;;
	lea	16(a4),a4	;;
	ENDR			;;

	DC.W $A000+500			; Ceci doit toujours suivre
	DC.W 0				; votre	code source.
	illegal

	move	#$2700,sr		; Code de fin, dans le cas
	illegal				; d'une erreur de
					; l'int�grateur

**********************************************************************
* TEMPS OVERSCAN
**********************************************************************
; Le programme	g�n�r� commence	par l'overscan gauche.

Variables
V		equ	Variables		; abbr�viation !
Current_Element	DC.L LISTE2
Zone_Suivante	DC.L Overscan_Gauche
Espace_Libre	DC.L 0

Overscan_Gauche
	DC.W Ov_Gauche_Longueur/2-1	; Longueur Code
	DC.W 89*2			; Temps	machine	en cycles/2
	DC.L Overscan_Droite		; Fausse Interruption suivante
Ov_Gauche1
	move.w	a0,(a0)			; Code Fausse Int�rruption
	nop				; Donn�es suivantes au m�me
	move.w	d0,(a0)			; format !
Ov_Gauche2
Ov_Gauche_Longueur EQU	Ov_Gauche2-Ov_Gauche1
	DC.L OV_GAUCHE_ASCII
	DC.W OV_GAUCHE_ASCII_FIN-OV_GAUCHE_ASCII

Overscan_Droite
	DC.W Ov_Droite_Longueur/2-1
	DC.W 13*2
	DC.L Overscan_Stabilisateur
Ov_Droite1
	move.w	d0,(a1)
	move.w	a0,(a1)
Ov_Droite2
Ov_Droite_Longueur EQU	Ov_Droite2-Ov_Droite1
	DC.L OV_DROITE_ASCII
	DC.W OV_DROITE_ASCII_FIN-OV_DROITE_ASCII

Overscan_Stabilisateur:
	DC.W Ov_Stabil_Longueur/2-1
	DC.W 12*2
	DC.L Overscan_Gauche
Ov_Stabil1
	move.w	a0,(a0)
	nop
	move.w	d0,(a0)
Ov_Stabil2
Ov_Stabil_Longueur EQU	Ov_Stabil2-Ov_Stabil1
	DC.L OV_STABIL_ASCII
	DC.W OV_STABIL_ASCII_FIN-OV_STABIL_ASCII

OV_GAUCHE_ASCII
	DC.B Tab,Tab,'move.w  a0,(a0)',$0D,$0A
	DC.B Tab,Tab,'nop',$0D,$0A
	DC.B Tab,Tab,'move.w  d0,(a0)',$0D,$0A
OV_GAUCHE_ASCII_FIN:

OV_DROITE_ASCII
	DC.B Tab,Tab,'move.w  d0,(a1)',$0D,$0A
	DC.B Tab,Tab,'move.w  a0,(a1)',$0D,$0A
OV_DROITE_ASCII_FIN

OV_STABIL_ASCII
	DC.B Tab,Tab,'move.w  a0,(a0)',$0D,$0A
	DC.B Tab,Tab,'nop',$0D,$0A
	DC.B Tab,Tab,'move.w  d0,(a0)',$0D,$0A
OV_STABIL_ASCII_FIN:

NOP:	DC.B Tab,Tab,'nop',$0D,$0A
NOP_FIN:

Old_Raster:	DS.B 1
		even

Num�ro_De_Zone		DS.W 1
Nombre_Cycles_Restants	DS.W 1
Ancienne_Addresse	DS.L 1
Code_Objet		DS.L 1

CODE_OBJET:		; Espace m�moire pour le code objet g�n�r�
		DS.W $8000
LISTE2:			; Espace m�moire pour la liste chain�e du
		DS.L 2	; code source, et pour la table des
		DC.L LISTE ; �tiquettes
LISTE:		DS.W $A000
CODE_ASCII		; Le code source originel.
		incbin	"F:\INTEGRC1.S"
		DC.B $0D,$0A	; Marqueur fin de ligne au cas o� il
FIN_CODE_ASCII:			; serait absent
		END
