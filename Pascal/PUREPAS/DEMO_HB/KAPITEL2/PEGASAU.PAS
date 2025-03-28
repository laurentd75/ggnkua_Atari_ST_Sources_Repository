PROGRAM pegasau;

(* Gegeben sind drei T�ren. Hinter zwei T�ren befinden sich zwei
	Ziegen, hinter einer T�r ein Auto. Man w�hlt eine T�r. Danach wird 
	eine T�r ge�ffnet (die man nat�rlich nicht gew�hlt hat), hinter 
	der eine Ziege ist. Danach wir behauptet, da� die Wahrscheinlichkeit,
	da� man das Auto findet, sich verdoppelt, wenn man sich umentscheidet, 
	also die andere geschlossene T�r w�hlt.
	Das Programm erechnet die Wahrscheinlichkeit daf�r.
	Bleibt man bei seiner Wahl, ist die Wahrscheinlichkeit nat�rlich 1/3 *)

	CONST	nummer=3;
			anzahl=100000;
			
	VAR k, j, wahl1, wahl2, offen : INTEGER;
		tuer : ARRAY[1..3] OF INTEGER;
		verh : REAL;
		counter, richtig : longint;

BEGIN
	clrscr;
	WRITELN('Moment bitte, ich rechne...');
	WRITELN;
	offen:=0;
	wahl2:=0;
	richtig:=0;
	FOR counter:=1 TO anzahl DO
	BEGIN
		FOR j:=1 TO 3 DO tuer[j]:=0; 	(* Inhalt der T�ren wird gel�scht *)
		j:=RANDOM(nummer)+1; 			(* Zufallszahl f�r T�r *)
		tuer[j]:=1;     					(* hinter der das Auto versteckt ist *)
		wahl1:=RANDOM(nummer)+1; 		(* Erste Wahl *)
		FOR k:=1 TO 3 DO
		BEGIN
			IF (k<>j) AND (k<>wahl1) THEN 
				offen:=k; 					(* Jetzt wird ein T�r ge�ffnet, *)
		END;									(* die nicht gew�hlt wurde und hinter *)
												(* der das Auto nicht ist. *)

		FOR k:=1 TO 3 DO
		BEGIN
			IF (k<>wahl1) AND (k<>offen) THEN
				wahl2:=k; 	(* Jetzt wird umentschieden auf die andere T�r *)
		END;					(* die noch zu ist. *)

		IF wahl2=j THEN 	(* Auto gefunden *)
			richtig:=richtig+1;
	END;
	verh:=richtig /anzahl;
	WRITE('Wahrscheinlichkeit f�r Treffer nach Umentscheiden ist :');
	WRITELN(verh:2:8);
	WRITELN('Dr�cke Taste...');
	REPEAT UNTIL KEYPRESSED;
END.