                                        Karlsruhe, den 4.1.91

Sehr geehrter Leser,

Sie  haben ein Buch mit Programmdiskette erworben.  Die  Diskette 
enth�lt so viele Beispiele zu GEM,  da� sie nicht alle  unkompri-
miert Platz gefunden h�tten.  Aus diesem Grunde wurde das Projekt 
SCRAP mit dem bekannten Programm ARC gepackt abgelegt.

Das  Projekt  SCRAP ist eine komplette  GEM-Applikation,  die  so 
programmiert wurde,  da� ein Softwareentwickler minimalsten  Auf-
wand betreiben mu�,  um perfekteste GEM-Applikation zu  realisie-
ren.  Auch die Portierbarkeit auf alle anderen Rechnersysteme und 
Betriebssysteme  ist ein Kinderspiel.  Kapitel 6 des  Buches  ist 
eine komplette Beschreibung der Programmierumgebung.

Die Datei AUFLAGE2.TXT enth�lt alle �nderungen, welche die zweite
Auflage dieses Buches betreffen.

Um die Dateien wieder zu entpacken,  wurden die beiden  Programme 
ARCE.PRG (ATARI ST) und ARCE.COM (MSDOS) beigelegt. F�r den ATARI 
ST wurde zus�tzlich ein kleiner Kommando-Interpreter dazugepackt, 
um Batch-Dateien ablaufen lassen zu k�nnen (COMMAND.TOS).

Beachten Sie unbedingt die Hinweise am Ende dieses Textes!

Gehen Sie zum Installieren wie folgt vor,  um die Entwicklungsum-
gebung auf Ihre Festplatte zu installieren:

1.  Kopieren  Sie  die Dateien aus dem MISC-Ordner  der  Diskette 
(dies sind die ben�tigten Include-Dateien) auf den Ordner INCLUDE 
ihres Compilers (wie in Kapitel 3 beschrieben),  nachdem Sie  die 
Datei PORTAB.H angepa�t haben. Der INCLUDE Ordner enth�lt alle C-
Header-Dateien. Haben Sie z.B. den Turbo C-Compiler, so wird dies 
meist  der  Ordner  TC  sein,  in dem  sich  der  Ordner  INCLUDE 
befindet.


2. Installation von SCRAP

a) IBM PC und Kompatible

Wenn Sie die Applikation SCRAP z.B.  auf dem Laufwerk D:  instal-
lieren m�chten, so geben Sie ein:

A:\INSTALL D:

Jedes  andere Laufwerk kann auch angegeben werden.  Kopieren  Sie 
dann  noch  die  entsprechenden  Dateien  aus  dem  Ordner  Ihres 
Compilers und Betriebssystems (siehe Kapitel 6.4,  Programmierum-
gebungen)  auf  das  angegebene Laufwerk  in  den  Ordner  SCRAP. 
Kopieren  Sie dorthin au�erdem die Datei SCRAP.RSC und  SCRAP.DFN 
aus dem Laufwerk bzw. Ordner "A:\SCRAP\I8086.RSC".


b) ATARI ST und TT

Starten Sie den Kommandointerpreter COMMAND.TOS von Laufwerk  A:. 
Wenn Sie die Applikation SCRAP z.B.  auf dem Laufwerk D:  instal-
lieren m�chten, so geben Sie ein:

A:\INSTALL D:

Jedes andere Laufwerk kann auch angegeben werden (z.B.  eine RAM-
Disk).  Kopieren Sie dann noch die entsprechenden Dateien aus dem 
Ordner  Ihres Compilers und Betriebssystems (siehe  Kapitel  6.4, 
Programmierumgebungen) auf das angegebene Laufwerk in den  Ordner 
SCRAP.  Kopieren  Sie  dorthin au�erdem die Datei  SCRAP.RSC  und 
SCRAP.DEF aus dem Laufwerk bzw. Ordner "A:\SCRAP\M68000.RSC".


Danach ist die Installation f�r beide Rechnertypen  abgeschlossen 
und die �bersetzung der Applikation kann beginnen.


Wichtig!!!!
===========

Allgemeine  Hinweise zum Benutzen der Software aus dem Buch  bzw. 
auf der Diskette:

Die Rechte an den Quellen zu den Beispielprogrammen und insbeson-
dere zum Projekt SCRAP liegen beim H�thig Verlag, Heidelberg. Die 
kommerzielle  Nutzung  sowie  der Verkauf  der  Quellen  auch  in 
�bersetzter  (kompilierter)  Form  oder  Teilen  daraus  f�r  die 
Entwicklung von eigenen Programmen ist strengstens untersagt. Die
private Nutzung aber ist ausdr�cklich erlaubt.

Zuwiederhandlungen  werden  strafrechtlich  verfolgt  und  k�nnen 
daher zu schwerwiegenden wirtschaftlichen Konsequenzen f�hren.

M�chte  jemand dennoch aufsetzend auf SCRAP  Software  entwickeln 
und  verkaufen,  so  mu� er die  schriftliche  Genehmigung  unter 
Angabe  des  Projektes beim H�thig Verlag  einholen.  Wird  diese 
Genehmigung  erteilt,  so  kann er �ber die  Quellen  f�r  dieses 
Projekt  frei verf�gen.  F�r jedes weitere Projekt mu� eine  neue 
Genehmigung einholen werden.


Die Autoren Dieter & J�rgen Gei�

