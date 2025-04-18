************************************************
* STOS EXTENSION ROUTINES BY  EDDIE BRYAN      *
*					       *
*        THE HAPPENING BOIZ (C) 1991           *
************************************************

************************************************
*      MEGA FAST 1 PLANE PIXEL PLOT ROUTINE    *
* 					       *
* ENTER WITH A0 - DESTINATION SCREEN           *
*            A1 - POINTS TO PIXEL DATA         *
*            A3 - POINTS TO OLD PIXELS         *
*      DRAWS 25 POINTS FROM A1 ONWARDS         *
*ALSO WIPES OFF OLD PIXELS AT A1-100(25*4)     *
************************************************

DOT_MATRIX
	MOVE.L	A0,A2			*SAVE SCREEN ADDRESS
*PLANE 1 - DARKEST PIXELS FIRST

	MOVE.W	#9,D0			*SET COUNT
	MOVEQ.L	#0,D5
DOT_LOOP
	MOVE.L	A2,A0
	MOVE.W	(A3),D1		*GET OLD PIXEL POS
	ADD.W	#4,A3
	ADD.W	D1,A0
	MOVE.W	D5,(A0)			*WIPE IT OFF!!

	MOVE.L	A2,A0	
	MOVE.W	(A1)+,D1		*GET SCREEN POS
	MOVE.W	(A1)+,D2		*GET PIXEL POS
	ADD.W	D1,A0
	MOVE.W	D2,D3		
	NOT.W	D3			*MASK PIXEL
	AND.W	D3,(A0)
	OR.W	D2,(A0)

	DBF	D0,DOT_LOOP		*LOOP

*PLANE 2 - ABIT LIGHTER
	MOVE.W	#9,D0			*SET COUNT
DOT_LOOP1
	MOVE.L	A2,A0
	ADD.L	#2,A0
	MOVE.L	A2,A4
	MOVE.W	(A3),D1			*GET OLD PIXEL POS
	ADD.W	#4,A3
	ADD.W	D1,A0
	MOVE.W	D5,(A0)		*WIPE IT OFF!!
	MOVE.L	A2,A0	
	MOVE.W	(A1)+,D1		*GET SCREEN POS
	MOVE.W	(A1)+,D2		*GET PIXEL POS
	ADD.W	D1,A0
	ADD.W	D1,A4
	MOVE.W	D2,D3		
	NOT.W	D3			*MASK PIXEL
	AND.W	D3,(A4)
	OR.W	D2,(A0)
	DBF	D0,DOT_LOOP1		*LOOP

*PLANE 3 - WHITER AT LAST!!
	MOVE.W	#23,D0			*SET COUNT
DOT_LOOP2
	MOVE.L	A2,A0
	ADD.L	#4,A0
	MOVE.L	A2,A4
	MOVE.W	(A3),D1			*GET OLD PIXEL POS
	ADD.W	#4,A3
	ADD.W	D1,A0
	MOVE.W	D5,(A0)		*WIPE IT OFF!!
	MOVE.L	A2,A0	
	MOVE.W	(A1)+,D1		*GET SCREEN POS
	MOVE.W	(A1)+,D2		*GET PIXEL POS
	ADD.W	D1,A0
	MOVE.W	D2,D3		
	NOT.W	D3			*MASK PIXEL
	AND.W	D3,(A4)
	OR.W	D2,(A0)
	DBF	D0,DOT_LOOP2		*LOOP


	RTS				*JUMP BACK TO STOS!!!