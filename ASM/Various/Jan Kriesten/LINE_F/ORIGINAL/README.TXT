Smart Systems im September 1992                Michael Hauschild
                                               Windhornstra�e 2
Telefon: 05137 / 9 20 09                                                                
                                               3016 Seelze 1
                                                                                                                
Das unwichtige vorweg: LFED der LineF-Emulator ist Freeware und
darf somit nach herzenslust kopiert und  weitergegeben werden 
(Voraussetzung ist allerdings, da� der gesamte Ordner FPU_EMU 
und alle Dateien weitergegeben werden!).

--------------------------------------------------------------------------

Was ist LFED ?
--------------
LFED ist die Kommunikations-Schnittstelle zwischen CPU und FPU. Das
Protokoll, welches die Motorola-Prozessoren ab MC68020 von Haus aus kennen
und damit die FloatingPointUnit (MatheCo-Prozessor / MC68881 oder MC68882)
ansteuern, mu� beim MC68000 oder MC68010 emuliert werden. Dieses �bernimmt
LFED. Der Atari TT hat nat�rlich keine Probleme mit seiner FPU, denn in ihm 
"wohnt" ja ein MC68030, der sich liebevoll um den MC68882 k�mmert - folg-
lich ist f�r einen TT ein LFED eher ein Klotz am Bein als eine Hilfe.


Warum zwei Versionen von LFED ?
-------------------------------
Die Version 1.x ist f�r Systeme mit TOS v1.0 bis einschlie�lich v1.04! In
diesen Tos-Versionen wurde der LineF-Trap "mi�braucht" und daher ist eine
Pr�fung notwendig, die zwischen "kam aus dem ROM oder aus dem RAM?" unter-
scheidet.

Die LFED-Version 2.x macht diese Pr�fung nicht mehr und ist daher auch et-
was schneller :-). Diese Version ist aber nur auf Systemen einsetzbar, die
ein TOS ab Version 1.06 haben!


F�r wen ist LFED ?
------------------
Geeignetes Einsatzgebiet f�r LFED ist jeder Atari ST, Mega ST, STE und 
Mega STE mit Standard-Prozessoren (MC68000/10) UND FPU (MC68881) !
Besonders interessant d�rfte LFED f�r Entwickler/Programmierer sein, die
mit Entwicklungssystemen arbeiten, welche die FPU direkt unterst�tzen 
(Beispielhaft sei hier PureC und Pure Pascal genannt) und nat�rlich f�r 
Anwender, die solche Programme/Applikationen auf ihren Rechnern instal-
lieren wollen. Zum Beispiel CAD-, EBV-Applikationen, Tabellenkalkulationen 
und nicht zuletzt wissenschaftliche Programme k�nnen durch die effektive 
Nutzung (ohne programmiertechnischen Mehraufwand) der FPU auch auf den 
"kleineren" Ataris recht z�gig bearbeitet werden.


Wie verh�lt sich LFED im System ?
---------------------------------
Kurz und gut - v�llig neutral, d.h. Unvertr�glichkeiten sind nicht bekannt.
LFED ist XBRA-Konform programmiert und erkennt sein "schon Vorhandensein"
an seiner Kennung 'LFED'. Er ist nicht resetfest und mu� bei Warm- oder
Kaltstart wieder neu geladen werden.


Wie installiert man LFED ?
--------------------------
Da LFED nicht resetfest und vom Prinzip eine Systemkomponente ist, f�hlt
er sich im AUTO-Ordner auf den "vorderen Pl�tzen" am wohlsten. Er instal-
liert einen eigenen LineF-Handler (eben das FPU-Protokoll). Wer m�chte,
kann ihn aber auch vom Desktop aus starten.


Was ist mit uns Entwicklern ?
-----------------------------
F�r die sind vor allem die Sourcen von Interesse - und diese sind hier im
Ordner. Wie man "FPU-Projekte" behandelt sieht man in FPUDEF.PRJ


Die Zukunft von LFED !
----------------------
Nun, es fehlen noch ein paar FPU-Befehle (z.B. FSAVE/FRESTORE; und bei
beiden bin ich mir nicht sicher, ob sie nicht in einer Multitasking-
Umgebung notwendig werden) und der FTRAP-Befehl erscheint mir sehr inte-
ressant in seinen M�glichkeiten - man wird sehen ...


Mehr Informationen ? - immer, z.B. in ...
--------------------
c't 4/90 "Schneller rechnen" von Roger Butenuth ab Seite 430

ATARI Profibuch ST-STE-TT von Jankowski/Rabich/Reschke erschienen im 
Sybex Verlag

PureC Compiler-Handbuch und Online-Hilfe (obwohl dort die Nutzbarkeit
der FPU in o.g. Rechnertypen (noch) verneint wird) - �brigens, der 
Pure-Assembler erlaubt auch den Befehlssatz der FPU (neben vielen anderen
M�glichkeiten!) zu nutzen.

... und nat�rlich die einschl�gige Literatur von Motorola.

Ich w�nsche Allen viel Spa� dabei, der FPU in ihren Rechnern 'mal richtig
"Dampf" zu machen ;-)