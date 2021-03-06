;
; nouvelle version 16/04/90
;  affichage dans un bitplane en m�moire en option
;
OFFSET_GAUCHE	EQU	0
OFFSET_DROIT	EQU	320	;PAR EXEMPLE
LARGE		EQU	320
PLAN0 = LARGE/2	;NB OCTETS DANS UNE LIGNE (160 SI 4 PLANS)
PLAN1 = 4		;NB PLANS (1->2 OCTETS,4->8 OCTETS)
;
; 3�me essai de fast-draw (SUPER)
;  avantage : marche dans tous les cas !
;
; am�liorations :
;	- transformer SUB/ADD par DIV dans le cas de longues droites
;	- ajouter routines de droites horizontales/verticales
;
	opt	o+,T-
;	ORG	$800
;
; D6 et A2 sont libres !!!
;
; ADRESSE ECRAN=USP !!!
;
FRE1	EQUR	D2	;BROUILLON OU D0
FRE2	EQUR	D1
CUMUL	EQUR	D3	;CUMUL
DX	EQUR	D4	;DELTAX
DY	EQUR	D5	;DELTAY
PAT	EQUR	D7	;PATTERN
ECRAN	EQUR	A0	;ECRAN
FRE3	EQUR	A3	;BROUILLON
FRE4	EQUR	A4	;BROUILLON
RETOUR1	EQUR	D6	;$4ED7=JMP(A7)
;
milieu		equ	160
;
; OFFSET=32=4*8 A GAUCHE=4*16 PIXELS A GAUCHE=OFFSET GAUCHE DE 64 PIXELS
;
; 12*8 BYTES DE LARGE=12*16 PIXELS DE LARGE=192 PIXELS DE LARGE
;
; REGISTRES UTILISES :
;
;	D3=CUMUL
;	D4=DX
;	DY=DY
;	D7=PATTERN
;	A0=ECRAN
;
; REGISTRES CONSTANTS :
;
; A1=MUL160(PC)
; USP=BASE ECRAN
; A7=RETURN\W
; A6=ADRESSE RETOUR APPELANT
;
	OPT	O+
RETOUR	MACRO
	JMP	(A6)		;SPEEDUP
	ENDM

DRAWV	MACRO
	OR	PAT,\1(ECRAN)
	SUB	DX,CUMUL
	BHS.S	.\@
	ADD	DY,CUMUL
	ADD	PAT,PAT
	BCC.S	.\@
	ADDX	PAT,PAT
	SUBQ	#PLAN1*2,ECRAN
.\@
	ENDM

CODE2	MACRO
.BASE
	DC.W	.1-.BASE
	DC.W	.2-.BASE
	DC.W	.3-.BASE
	DC.W	.4-.BASE
	DC.W	.5-.BASE
	DC.W	.6-.BASE
	DC.W	.7-.BASE
	DC.W	.8-.BASE
	DC.W	.9-.BASE
	DC.W	.10-.BASE
	DC.W	.11-.BASE
	DC.W	.12-.BASE
	DC.W	.13-.BASE
	DC.W	.14-.BASE
	DC.W	.15-.BASE
	DC.W	.16-.BASE
	DC.W	.17-.BASE
	DC.W	.18-.BASE
	DC.W	.19-.BASE
	DC.W	.20-.BASE
	DC.W	.21-.BASE
	DC.W	.22-.BASE
	DC.W	.23-.BASE
	DC.W	.24-.BASE
	DC.W	.25-.BASE
	DC.W	.26-.BASE
	DC.W	.27-.BASE
	DC.W	.28-.BASE
	DC.W	.29-.BASE
	DC.W	.30-.BASE
	DC.W	.31-.BASE
	DC.W	.32-.BASE
	DC.W	.33-.BASE
	DC.W	.34-.BASE
	DC.W	.35-.BASE
	DC.W	.36-.BASE
	DC.W	.37-.BASE
	DC.W	.38-.BASE
	DC.W	.39-.BASE
	DC.W	.40-.BASE
	DC.W	.41-.BASE
	DC.W	.42-.BASE
	DC.W	.43-.BASE
	DC.W	.44-.BASE
	DC.W	.45-.BASE
	DC.W	.46-.BASE
	DC.W	.47-.BASE
	DC.W	.48-.BASE
	DC.W	.49-.BASE
	DC.W	.50-.BASE
	DC.W	.51-.BASE
	DC.W	.52-.BASE
	DC.W	.53-.BASE
	DC.W	.54-.BASE
	DC.W	.55-.BASE
	DC.W	.56-.BASE
	DC.W	.57-.BASE
	DC.W	.58-.BASE
	DC.W	.59-.BASE
	DC.W	.60-.BASE
	DC.W	.61-.BASE
	DC.W	.62-.BASE
	DC.W	.63-.BASE
	DC.W	.64-.BASE
	DC.W	.65-.BASE
	DC.W	.66-.BASE
	DC.W	.67-.BASE
	DC.W	.68-.BASE
	DC.W	.69-.BASE
	DC.W	.70-.BASE
	DC.W	.71-.BASE
	DC.W	.72-.BASE
	DC.W	.73-.BASE
	DC.W	.74-.BASE
	DC.W	.75-.BASE
	DC.W	.76-.BASE
	DC.W	.77-.BASE
	DC.W	.78-.BASE
	DC.W	.79-.BASE
	DC.W	.80-.BASE
	DC.W	.81-.BASE
	DC.W	.82-.BASE
	DC.W	.83-.BASE
	DC.W	.84-.BASE
	DC.W	.85-.BASE
	DC.W	.86-.BASE
	DC.W	.87-.BASE
	DC.W	.88-.BASE
	DC.W	.89-.BASE
	DC.W	.90-.BASE
	DC.W	.91-.BASE
	DC.W	.92-.BASE
	DC.W	.93-.BASE
	DC.W	.94-.BASE
	DC.W	.95-.BASE
	DC.W	.96-.BASE
	DC.W	.97-.BASE
	DC.W	.98-.BASE
	DC.W	.99-.BASE
	DC.W	.100-.BASE
	DC.W	.101-.BASE
	DC.W	.102-.BASE
	DC.W	.103-.BASE
	DC.W	.104-.BASE
	DC.W	.105-.BASE
	DC.W	.106-.BASE
	DC.W	.107-.BASE
	DC.W	.108-.BASE
	DC.W	.109-.BASE
	DC.W	.110-.BASE
	DC.W	.111-.BASE
	DC.W	.112-.BASE
	DC.W	.113-.BASE
	DC.W	.114-.BASE
	DC.W	.115-.BASE
	DC.W	.116-.BASE
	DC.W	.117-.BASE
	DC.W	.118-.BASE
	DC.W	.119-.BASE
	DC.W	.120-.BASE
	DC.W	.121-.BASE
	DC.W	.122-.BASE
	DC.W	.123-.BASE
	DC.W	.124-.BASE
	DC.W	.125-.BASE
	DC.W	.126-.BASE
	DC.W	.127-.BASE
	DC.W	.128-.BASE
	DC.W	.129-.BASE
	DC.W	.130-.BASE
	DC.W	.131-.BASE
	DC.W	.132-.BASE
	DC.W	.133-.BASE
	DC.W	.134-.BASE
	DC.W	.135-.BASE
	DC.W	.136-.BASE
	DC.W	.137-.BASE
	DC.W	.138-.BASE
	DC.W	.139-.BASE
	DC.W	.140-.BASE
	DC.W	.141-.BASE
	DC.W	.142-.BASE
	DC.W	.143-.BASE
	DC.W	.144-.BASE
	DC.W	.145-.BASE
	DC.W	.146-.BASE
	DC.W	.147-.BASE
	DC.W	.148-.BASE
	DC.W	.149-.BASE
	DC.W	.150-.BASE
	DC.W	.151-.BASE
	DC.W	.152-.BASE
	DC.W	.153-.BASE
	DC.W	.154-.BASE
	DC.W	.155-.BASE
	DC.W	.156-.BASE
	DC.W	.157-.BASE
	DC.W	.158-.BASE
	DC.W	.159-.BASE
	DC.W	.160-.BASE
	DC.W	.161-.BASE
	DC.W	.162-.BASE
	DC.W	.163-.BASE
	DC.W	.164-.BASE
	DC.W	.165-.BASE
	DC.W	.166-.BASE
	DC.W	.167-.BASE
	DC.W	.168-.BASE
	DC.W	.169-.BASE
	DC.W	.170-.BASE
	DC.W	.171-.BASE
	DC.W	.172-.BASE
	DC.W	.173-.BASE
	DC.W	.174-.BASE
	DC.W	.175-.BASE
	DC.W	.176-.BASE
	DC.W	.177-.BASE
	DC.W	.178-.BASE
	DC.W	.179-.BASE
	DC.W	.180-.BASE
	DC.W	.181-.BASE
	DC.W	.182-.BASE
	DC.W	.183-.BASE
	DC.W	.184-.BASE
	DC.W	.185-.BASE
	DC.W	.186-.BASE
	DC.W	.187-.BASE
	DC.W	.188-.BASE
	DC.W	.189-.BASE
	DC.W	.190-.BASE
	DC.W	.191-.BASE
	DC.W	.192-.BASE
	DC.W	.193-.BASE
	DC.W	.194-.BASE
	DC.W	.195-.BASE
	DC.W	.196-.BASE
	DC.W	.197-.BASE
	DC.W	.198-.BASE
	DC.W	.199-.BASE
	DC.W	.200-.BASE

.200	DRAWV	\1*199
.199	DRAWV	\1*198
.198	DRAWV	\1*197
.197	DRAWV	\1*196
.196	DRAWV	\1*195
.195	DRAWV	\1*194
.194	DRAWV	\1*193
.193	DRAWV	\1*192
.192	DRAWV	\1*191
.191	DRAWV	\1*190
.190	DRAWV	\1*189
.189	DRAWV	\1*188
.188	DRAWV	\1*187
.187	DRAWV	\1*186
.186	DRAWV	\1*185
.185	DRAWV	\1*184
.184	DRAWV	\1*183
.183	DRAWV	\1*182
.182	DRAWV	\1*181
.181	DRAWV	\1*180
.180	DRAWV	\1*179
.179	DRAWV	\1*178
.178	DRAWV	\1*177
.177	DRAWV	\1*176
.176	DRAWV	\1*175
.175	DRAWV	\1*174
.174	DRAWV	\1*173
.173	DRAWV	\1*172
.172	DRAWV	\1*171
.171	DRAWV	\1*170
.170	DRAWV	\1*169
.169	DRAWV	\1*168
.168	DRAWV	\1*167
.167	DRAWV	\1*166
.166	DRAWV	\1*165
.165	DRAWV	\1*164
.164	DRAWV	\1*163
.163	DRAWV	\1*162
.162	DRAWV	\1*161
.161	DRAWV	\1*160
.160	DRAWV	\1*159
.159	DRAWV	\1*158
.158	DRAWV	\1*157
.157	DRAWV	\1*156
.156	DRAWV	\1*155
.155	DRAWV	\1*154
.154	DRAWV	\1*153
.153	DRAWV	\1*152
.152	DRAWV	\1*151
.151	DRAWV	\1*150
.150	DRAWV	\1*149
.149	DRAWV	\1*148
.148	DRAWV	\1*147
.147	DRAWV	\1*146
.146	DRAWV	\1*145
.145	DRAWV	\1*144
.144	DRAWV	\1*143
.143	DRAWV	\1*142
.142	DRAWV	\1*141
.141	DRAWV	\1*140
.140	DRAWV	\1*139
.139	DRAWV	\1*138
.138	DRAWV	\1*137
.137	DRAWV	\1*136
.136	DRAWV	\1*135
.135	DRAWV	\1*134
.134	DRAWV	\1*133
.133	DRAWV	\1*132
.132	DRAWV	\1*131
.131	DRAWV	\1*130
.130	DRAWV	\1*129
.129	DRAWV	\1*128
.128	DRAWV	\1*127
.127	DRAWV	\1*126
.126	DRAWV	\1*125
.125	DRAWV	\1*124
.124	DRAWV	\1*123
.123	DRAWV	\1*122
.122	DRAWV	\1*121
.121	DRAWV	\1*120
.120	DRAWV	\1*119
.119	DRAWV	\1*118
.118	DRAWV	\1*117
.117	DRAWV	\1*116
.116	DRAWV	\1*115
.115	DRAWV	\1*114
.114	DRAWV	\1*113
.113	DRAWV	\1*112
.112	DRAWV	\1*111
.111	DRAWV	\1*110
.110	DRAWV	\1*109
.109	DRAWV	\1*108
.108	DRAWV	\1*107
.107	DRAWV	\1*106
.106	DRAWV	\1*105
.105	DRAWV	\1*104
.104	DRAWV	\1*103
.103	DRAWV	\1*102
.102	DRAWV	\1*101
.101	DRAWV	\1*100
.100	DRAWV	\1*99
.99	DRAWV	\1*98
.98	DRAWV	\1*97
.97	DRAWV	\1*96
.96	DRAWV	\1*95
.95	DRAWV	\1*94
.94	DRAWV	\1*93
.93	DRAWV	\1*92
.92	DRAWV	\1*91
.91	DRAWV	\1*90
.90	DRAWV	\1*89
.89	DRAWV	\1*88
.88	DRAWV	\1*87
.87	DRAWV	\1*86
.86	DRAWV	\1*85
.85	DRAWV	\1*84
.84	DRAWV	\1*83
.83	DRAWV	\1*82
.82	DRAWV	\1*81
.81	DRAWV	\1*80
.80	DRAWV	\1*79
.79	DRAWV	\1*78
.78	DRAWV	\1*77
.77	DRAWV	\1*76
.76	DRAWV	\1*75
.75	DRAWV	\1*74
.74	DRAWV	\1*73
.73	DRAWV	\1*72
.72	DRAWV	\1*71
.71	DRAWV	\1*70
.70	DRAWV	\1*69
.69	DRAWV	\1*68
.68	DRAWV	\1*67
.67	DRAWV	\1*66
.66	DRAWV	\1*65
.65	DRAWV	\1*64
.64	DRAWV	\1*63
.63	DRAWV	\1*62
.62	DRAWV	\1*61
.61	DRAWV	\1*60
.60	DRAWV	\1*59
.59	DRAWV	\1*58
.58	DRAWV	\1*57
.57	DRAWV	\1*56
.56	DRAWV	\1*55
.55	DRAWV	\1*54
.54	DRAWV	\1*53
.53	DRAWV	\1*52
.52	DRAWV	\1*51
.51	DRAWV	\1*50
.50	DRAWV	\1*49
.49	DRAWV	\1*48
.48	DRAWV	\1*47
.47	DRAWV	\1*46
.46	DRAWV	\1*45
.45	DRAWV	\1*44
.44	DRAWV	\1*43
.43	DRAWV	\1*42
.42	DRAWV	\1*41
.41	DRAWV	\1*40
.40	DRAWV	\1*39
.39	DRAWV	\1*38
.38	DRAWV	\1*37
.37	DRAWV	\1*36
.36	DRAWV	\1*35
.35	DRAWV	\1*34
.34	DRAWV	\1*33
.33	DRAWV	\1*32
.32	DRAWV	\1*31
.31	DRAWV	\1*30
.30	DRAWV	\1*29
.29	DRAWV	\1*28
.28	DRAWV	\1*27
.27	DRAWV	\1*26
.26	DRAWV	\1*25
.25	DRAWV	\1*24
.24	DRAWV	\1*23
.23	DRAWV	\1*22
.22	DRAWV	\1*21
.21	DRAWV	\1*20
.20	DRAWV	\1*19
.19	DRAWV	\1*18
.18	DRAWV	\1*17
.17	DRAWV	\1*16
.16	DRAWV	\1*15
.15	DRAWV	\1*14
.14	DRAWV	\1*13
.13	DRAWV	\1*12
.12	DRAWV	\1*11
.11	DRAWV	\1*10
.10	DRAWV	\1*9
.9	DRAWV	\1*8
.8	DRAWV	\1*7
.7	DRAWV	\1*6
.6	DRAWV	\1*5
.5	DRAWV	\1*4
.4	DRAWV	\1*3
.3	DRAWV	\1*2
.2	DRAWV	\1*1
.1
	ENDM

DRAW3	MACRO
	MOVE	DY,CUMUL
	LSR	#1,CUMUL
	MOVE	DY,D2
	ADD	D2,D2
	LEA	DRW3(PC),FRE3
	ADD	(FRE3,D2.W),FRE3
	JMP	(FRE3)
	ENDM
DRAW4	MACRO
	MOVE	DY,CUMUL
	LSR	#1,CUMUL
	MOVE	DY,D2
	ADD	D2,D2
	LEA	DRW4(PC),FRE3
	ADD	(FRE3,D2.W),FRE3
	JMP	(FRE3)
	ENDM

NOLINE	RETOUR

DRAW_IT
	MOVE.L	USP,ECRAN
	MOVEQ	#0,PAT

	MOVE	D3,DY
	SUB	D1,DY		;dY
	BPL.S	OCTANT2
	NEG	DY
	EXG	D1,D3
	EXG	D0,D2
OCTANT2
;
; A1=MUL160
; USP=ADRESSE ECRAN
; ECRAN=PTR DYNAMIQUE
;
	cmp	#200,D1
	blo.s	nocliphaut
	bpl.S	NOLINE
	TST	DY
	BEQ.S	.ZERO
	MOVE	D2,DX
	SUB	D0,DX		;dX
	muls	DX,D1		;on clippe en haut
	divs	DY,D1		;X1=X1-(Y1*DX)/DY
	sub	D1,D0
.ZERO
	clr	D1		;YHAUT=0
	move	D3,DY
nocliphaut
	cmp	#200,D3
	blo.s	noclipbas
	bmi.S	NOLINE

	TST	DY
	BEQ.S	.ZERO
	MOVE	D2,DX
	SUB	D0,DX		;dX
	sub	#199,D3
	muls	DX,D3
	divs	DY,D3
	sub	D3,D2
.ZERO
	move	#199,D3
	move	D3,DY
	sub	D1,DY
noclipbas

	MOVE	D2,DX
	SUB	D0,DX		;dX
	BMI.S	OCTANT3
;
; dX>=0,dY>=0
;
	CMP	DX,DY
	BHS.S	DRAW21		;X0=GAUCHE,Y0=HAUT
;X0=GAUCHE,Y0=HAUT
	IFEQ	PLAN1-1
	MOVEQ	#-16,D3			;RIEN A FAIRE DE D3 !!!
	AND	D0,D3			;BUG CORRIGE !!!
	ENDC

	ADD	D1,D1			;YHAUT

	IFEQ	PLAN1-1
	ASR	#(7-PLAN1)/2,D3
	ADD	(A1,D1.W),D3
	ADD	D3,ECRAN
	ELSEIF
	ADD	(A1,D1.W),ECRAN
	MOVEQ	#-16,FRE2
	AND	D2,FRE2
	ENDC

	ADD	D0,D0
	ADD	D2,D2
	LEA	OFFSETS1(PC),FRE3
	MOVE.L	FRE3,FRE4
	ADD	(FRE3,D0.W),FRE4
	ADD	(FRE3,D2.W),FRE3

	MOVE	DX,CUMUL
	LSR	#1,CUMUL

	MOVE	(FRE3),FRE1
	MOVE	RETOUR1,(FRE3)		;JMP (An)
	JMP	-4(FRE4)
OCTANT3
;
; dX<0,dY>=0
;
	NEG	DX

	CMP	DX,DY
	BHS.S	DRAW12		;X0=DROITE,Y0=HAUT
;X0=DROITE,Y0=HAUT

	IFEQ	PLAN1-1
	MOVEQ	#-16,D1		;RIEN A FAIRE DE D1 !!!
	AND	D2,D1		;BUG CORRIGE !!
	ENDC

	ADD	D3,D3

	IFEQ	PLAN1-1
	ASR	#(7-PLAN1)/2,D1
	ADD	(A1,D3.W),D1
	ADD	D1,ECRAN
	ELSEIF
	ADD	(A1,D3.W),ECRAN
	MOVEQ	#-16,FRE2
	AND	D0,FRE2
	ENDC

	ADD	D2,D2
	ADD	D0,D0
	LEA	OFFSETS2(PC),FRE4
	MOVE.L	FRE4,FRE3
	ADD	(FRE4,D2.W),FRE4
	ADD	(FRE3,D0.W),FRE3

	MOVE	DX,CUMUL
	LSR	#1,CUMUL
	MOVE	(FRE3),FRE1
	MOVE	RETOUR1,(FRE3)		;JMP (An)
	JMP	-4(FRE4)

DRAW21
; PT DEPART=X1Y0
	MOVEQ	#$F,D0
	EOR	D0,D2		;INVERSE LES 4 BITS
	AND	D2,D0
	EOR	D0,D2
	ASR	#(7-PLAN1)/2,D2
	ADD	D1,D1
	ADD	(A1,D1.W),D2
	ADD	D2,ECRAN
	BSET	D0,PAT
	DRAW4


DRAW12
; PT DEPART=X0Y1
	MOVEQ	#$F,D2
	EOR	D2,D0		;INVERSE LES 4 BITS
	AND	D0,D2
	EOR	D2,D0
	ASR	#(7-PLAN1)/2,D0
	ADD	D3,D3
	ADD	(A1,D3.W),D0
	ADD	D0,ECRAN
	BSET	D2,PAT
	DRAW3

	OPT	OW-
DRW3
	CODE2	-PLAN0
	OR	PAT,(ECRAN)
	RETOUR
DRW4
	CODE2	PLAN0
	OR	PAT,(ECRAN)
	RETOUR
;
BRANCHE	MACRO
	dc.w	lab\<number>+4-\1
number	set	number+1
	ENDM

OFFSETS2
number	set	OFFSET_DROIT
	rept	LARGE
	BRANCHE	OFFSETS2
	endr

GENERE	MACRO
lab\<number>:
	ENDM

DXSUPDY	MACRO
lab\<number>:
number	set	number+1
	ifne	~\1&15
	iif	(\1&15)=0	move	#$8000,PAT
	iif	(\1&15)=1	or	#$4000,PAT
	iif	(\1&15)=2	or	#$2000,PAT
	iif	(\1&15)=3	or	#$1000,PAT
	iif	(\1&15)=4	or	#$0800,PAT
	iif	(\1&15)=5	or	#$0400,PAT
	iif	(\1&15)=6	or	#$0200,PAT
	iif	(\1&15)=7	or	#$0100,PAT
	iif	(\1&15)=8	tas	PAT
	iif	(\1&15)=9	or	#$40,PAT
	iif	(\1&15)=10	or	#$20,PAT
	iif	(\1&15)=11	or	#$10,PAT
	iif	(\1&15)=12	addq	#8,PAT
	iif	(\1&15)=13	addq	#4,PAT
	iif	(\1&15)=14	addq	#2,PAT
	SUB	DY,CUMUL
	BHS.s	\@
	IFEQ	PLAN1-1
	or	PAT,(ECRAN)
	ELSEIF
	or	PAT,(\1&-16)/2(ECRAN)
	ENDC
	clr	PAT
	elseif
	OR	#1,PAT
	IFEQ	PLAN1-1
	or	PAT,(ECRAN)+
	ELSEIF
	or	PAT,(\1&-16)/2(ECRAN)
	ENDC
	SUB	DY,CUMUL
	BHS.s	\@
	endc
	lea	y(ECRAN),ECRAN
	ADD	DX,CUMUL
\@
	endm

number	set	OFFSET_GAUCHE
y	set	PLAN0
x	set	OFFSET_GAUCHE
	rept	LARGE-1
	DXSUPDY	x
x	set	x+1
	endr
	GENERE
	OR	#1,PAT
	NOP			;ici est pok� le dernier JMP !!!
;
number	set	OFFSET_DROIT
y	set	-PLAN0
x	set	OFFSET_GAUCHE
	rept	LARGE-1
	DXSUPDY	x
x	set	x+1
	endr
	GENERE
	OR	#1,PAT
	NOP			;ici est pok� le dernier JMP !!!

OFFSETS1
number	set	OFFSET_GAUCHE
	rept	LARGE
	BRANCHE	OFFSETS1
	endr
	DS.L	50		;PLACE POUR LA PILE (CA PUE !!!)
;RETURN
	IFNE	PLAN1-1
	ASR	#1,FRE2
	OR	PAT,(ECRAN,FRE2.W)
	ELSEIF
	OR	PAT,(ECRAN)
	ENDC
	MOVE	FRE1,(FRE3)
	RETOUR
