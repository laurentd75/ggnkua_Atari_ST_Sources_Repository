/********************************************************************/
/* Funktionsprototypen f�r Funktionen, die die Kommunikation mit
   GEMINI bzw. Venus vereinfachen
   
   (c) 1990 by Stephan Gerle
   
   E-Mail: Maus Net: Stephan Gerle @ DO
   
   Stand: 16.4.1991

   Additions   1994 Mark Davidson

   S�mtliche Funktionen liefern 1, wenn die Hauptapplikation die
   Funktion kennt bzw. 0, wenn die Hauptapplikation die Funktion
   nicht kennt.
   
   Die Funktionen wurden komplett umgeschrieben, da es erhebliche
   Probleme mit dem Timeout gab.
   Da das AV-Protokoll Event-orientiert arbeitet, ist die Realisierung
   einiger Funktionen als Funktion nicht m�glich bzw. f�hrt nur
   zu Problemen.   

   Siehe auch VAPROTO.H.
   
   Achtung: 5er Tabs
*/

#ifndef __VAFUNC_H
#define __VAFUNC_H

#include <vaproto.h>

/*** Macros **********************************************************/

/* AVSTR2MSG setzt den Wert eines String-Pointers in ein Message-
   array ein.
       msg    : Name des Integerarrays.
       offset : Kleinerer Index des Interger-P�rchens
       str    : Zeiger auf String
*/
#define	AVSTR2MSG(msg,offset,str)	(*(char **)(msg+offset) = str)

/* AVMSG2STR bastelt aus einem Integer-P�rchens einer Messages einen
   String-Pointer zusammen.
       msg    : Name des Integerarrays
       offset : Kleinerer Index des Integer-P�rchens.
*/
#define	AVMSG2STR(msg,offset)			((char *)(((long)msg[offset]<<16)|(((long)msg[offset+1])&0xffff)))


/*** Globale Variablen f�r die Library f�r das AV-Protokoll **********/



/* AVName ist ein Pointer auf einen String, in dem der Name der
   Hauptapplikation steht, die das AV-Protokoll beherrscht.
   Diese Variable wird durch AVActive gesetzt. Der String ist ein
   Leerstring, wenn das Hauptprogramm das AV-Protokoll nicht versteht.*/
   
extern char	AVName[];


/*** Funktionen f�r die Protokollunterst�tzung ***********************/


/* AVInit mu� einmal beim Start des Acc's aufgerufen werden. Damit
   wird die Applikationsid, der Name des Acc (wie bei appl_find benutzt;
   also 8 des Programmnamens eventuell mit Leerzeichen aufgef�llt) sowie
   die vom Acc unterst�tzten Funktionen als Bitvektor den Funktionen
   f�r das AV-Protokoll �bergeben.
   Diese Routine sollte direkt vor Eintritt in die Messageloop
   aufgerufen werden. */

void	AVInit(int myapid,char *myname,int myprotostatus);


/* Ermittelt, ob Gemini oder Venus bzw. irgendein Hauptprogramm,
   welches das AV-Protokoll versteht, aktiv ist.
   Wenn nein, so wird 0 zur�ckgeliefert, sonst ein Wert ungleich 0.
   Falls der Protokollstatus noch nicht ermittelt werden konnte, so
   wird eine entsprechende Message an das Hauptprogramm geschickt.
   Das Ergebnis ist dann ersteinmal 0. */
   
int	AVActive(void);


/* Sorgt daf�r, das der AV-Protokoll-Status neu ermittelt wird. Diese
   Funktion wird bei einem AC_CLOSE durch AVProcessMsg() automatisch
   aufgerufen. */
   
void	AVGetNewProtoStatus(void);


/* Sendet Statusinformationen an die Hauptapplikation. */
   
int	AVSendStatus(char *status);


/* Fragt bei der Hauptapplikation den f�r das Acc gespeicherten Status
   nach.
   Als Antwort kommt von der Hauptapplikation die Meldung VA_SETSTATUS.
   Ansonsten mu� die Meldung VA_SETSTATUS in der Messageloop behandelt
   werden. In msg[3/4] ist ein Pointer auf einen String, der den
   Status enth�lt. */

void	AVReceiveStatus(void);


/* AVProcessMsg muss f�r jede empfangene Message aufgerufen werden.
   AVProcessMsg liefert einen Wert ungleich 0, falls sich der
   Protokollstatus ge�ndert hat. */
   
int	AVProcessMsg(short *msg);



/*** Programmspezifische Funktionen *********************************/



/* Emittelt den f�r Verzeichnisfenster eingestellten Font und die
   Fonth�he.
   Die Hauptapplikation schickt daraufhin die Message VA_FILEFONT. */

int	AVAskFileFont(void);


/* Dasselbe wie AVAskFileFont, nur f�r das Console-Fenster.
   Als Ergebnis kommt die Message VA_CONFONT. */

int	AVAskConsoleFont(void);


/* Fragt bei der Hauptapplikation nach den selektierten Objekten.
   Als Antwort kommt die Message VA_OBJECT. Die Objekte sind jeweils
   durch ein ' ' im String voneinander getrennt. */
   
void	AVAskSelectedObjects(void);


/* Sagt Gemini, da� das Console-Fenster ge�ffnet werden soll. */

int	AVOpenConsole(void);


/* Sagt der Hauptapplikation, das ein Fenster mit dem Verzeichnis
   pfad und der Maske mask ge�ffnet werden soll. */
   
int	AVOpenWindow(char *pfad,char *mask);


/* Startet mittels Venus bzw. Gemini ein Programm. In pfad steht
   der komplette Pfad und der Programmname. cmdline enth�lt
   die Kommandozeile f�r das zu startende Programm. */
   
int	AVStartProgram(char *pfad,char *cmdline);


/* Sagt der Hauptapplikation, da� das Accessorie ein Fenster ge�ffnet hat. */

int	AVAccOpenedWindow(int winhandle);


/* Sagt der Hauptapplikation, da� das Accessorie ein Fenster geschlossen hat.
   (ist nur bei nicht durch AC_CLOSE bedingtem Schlie�en notwendig) */
   
int	AVAccClosedWindow(int winhandle);


/* Schickt der Hauptapplikation einen Tastaturevent. Ist dann anzuwenden,
   wenn ein ACC ein Fenster offen hat, und einen Tastendruck bekommt,
   den es selber nicht verwendet. */

int	AVSendKeyEvent(int state,int key);


/* AVCopyDragged schickt die Message AV_COPY_DRAGGED an die Hauptapplikation.
   Die Hauptapplikation sollte daraufhin die vorher in das Fenster des
   Accs gedraggten Icons in den Zielpfad kopieren.
   kstate ist der Tastaturstatus wie von evnt_multi() erhalten.
   Von der Hauptapplikation kommt als Antwort VA_COPY_COMPLETE. Nachdem
   diese Mitteilung empfangen wurde, kann ein eventuell f�r das Kopieren
   allozierter Speicher wieder freigegeben werden.
   Diese Funktion darf nur als Antwort auf VA_DRAGACCWIND benutzt werden,
   da sonst nicht eindeutig ist, was kopiert werden soll. */

int	AVCopyDragged(int kstate,char *dest);


/* Calls to ST-Guide and 1ST Guide */

int CallSTGuide(char *help, char *pattern);  
int Call1STGuide(char *file);  




/*** Zur Anwendung ***************************************************/

#ifdef __DO_NOT_DEFINE

/* Hier ein minimales Skelett f�r die Verwendung der AV-Funktionen. */

void	HandleMessage(int kstate,short *msg)
{
	int	FontId,FontPointsHeight;
	char	*status;
	
	if (AVProcessMsg(msg))
	{
		/* Protokollstatus hat sich ge�ndert */

		if ("Habe offene Fenster")
			for ("f�r jedes offene Fenster")
				AVAccOpenedWindow(winhandle);
		AVAskFileFont();
		AVReceiveStatus();
		...
	}
	switch (msg[0])
	{
		case	WM_FULLED:	...
		case	WM_SIZED:		...
		case	WM_MOVED:		...
		case	WM_REDRAW:	...
		case	WM_TOPPED:	...
		case	WM_ARROWED:	...
		case WM_VSLID:		...
		case WM_HSLID:		...

		case	VA_SETSTATUS:
					/* msg[3] und msg[4] enthalten Pointer auf
					   String mit Status (kann auch NULL sein) */
					...
					break;
		case	VA_FILEFONT:
					/* msg[3] und msg[4] enthalten die Fontdaten
					   (siehe VAPROTO.H) */
					...
					break:
		case	VA_START:
					/* msg[3] und msg[4] enthalten Pointer auf
					   Kommandozeile */
					...
					break;
		case	VA_DRAGACCWIND:
					/* msg[6] und msg[7] enthalten Pointer auf
					   String mit Liste der auf das Fenster gezogenen
					   Objekte. */
					...
					break;
		case	VA_COPY_COMPLETE:
					/* Kopiervorgang beendet. Eventuelle allozierter
					   Speicher wieder freigeben. */
					break;
		...
	}
}

void	HandleKey(int ks,int kb)
{
	switch (kb)
	{
		...
		default:	AVSendKeyEvent(ks,kb);
				break;
	}
}

void	EventLoop(void)
{
	int	event,msg[8],kb,ks;
	
	do
	{
		event = evnt_multi(MU_MESAG|MU_KEYBD...,...,msg,...,ks,kb,...);
		if (event&MU_MESAG)
			HandleMessage(ks,msg);
		if (event&MU_KEYBD)
			HandleKey(ks,kb);
		...
	} while (!QuitFlg);
}

/* Die AV-Protokollfunktionen m�ssen durch den Aufruf von AVInit()
   initialisiert werden.
   Dieser Aufruf mu� vor Benutzung aller anderen AV-Funktionen
   gemacht werden. */

int	gl_apid;

void	main(void)
{
	if ((gl_apid = appl_init())>=0)
	{
		...
		AVInit(gl_apid,"ACCNAME ",1|2);
		EventLoop();
		...
	}
}
#endif
#endif
