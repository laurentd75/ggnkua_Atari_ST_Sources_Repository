/*
 * SE-Protokoll zur Kommunikation zwischen Shells zur Programmentwicklung
 * und Editoren.
 *
 * Dieses Protokoll dient dazu, unter Multitasking-Systemen die Shell
 * zur Compilierung und �hnlichen Sachen zu veranlassen, und um Fehler-
 * meldungen und/oder Fehlerdateien an den Editor zur�ckzugeben.
 *
 * Kommandos bzw. Nachrichten von der Shell zum Editor beginnen
 * mit SE_, Nachrichten vom Editor zur Shell beginnen mit ES_
 *
 * Da teilweise Zeiger auf Speicherbereiche �bergeben werden, ist vom
 * jeweiligen Absender der Nachricht darauf zu achten, da� diese
 * Speicherbereiche vom Empf�nger auch lesbar sind (Memory Protection!).
 * Daf�r sind diese als Readable zu allozieren!
 *
 */

/*
 * Erweiterungen
 *
 * Datum 	Version �nderungen
 *
 * 30.01.96  1.01 	SE_CLOSE f�r Dateien/Masken, mit Close-Flag
 * 							msg[5] = 0 -> nur sichern
 * 							msg[5] = 1 -> sichern + schlie�en
 * 						ES/SE_PROJEKT mit leerem Argument (NULL)
 * 						Um zur Version 0x100 kompatibel zu sein, sollte
 * 						das Programm die Versionsnummer �berpr�fen!!
 *
 * 13.08.96  1.02 	SE_OPEN mit Zeilen- und Spaltennummer
 * 						neue Nachricht SE_MENU
 *
 * 19.11.96  1.03 	bei ES_COMPILE kann der Dateiname auch NULL sein
 *
 * 08.01.97  1.04 	SE_CLOSE: Flag 2
 * 						SE_MENU: progName
 *
 * 23.12.97  1.05 	ES_SHLCTRL neu, zur Kontrolle der Shell
 *							Daf�r neuer String in SEMENUINFO.
 *
 */

#define SEPROTOVERSION 0x105	
/*
 * Die Versionsnummer des Protokolls. Highbyte ist die Major Number
 * Lowbyte ist die Lower Number
*/


/*
 * Shell -> Editor
*/
#define SE_INIT			0x4200
	/*
	 * Die Shell fragt an, ob ein Editor das SE-Protokoll versteht.
	 * Wort 3		Ein Bitset, welche Nachrichten die Shell versendet
	 * Wort 4+5		Ein Bitset, welche Editorkommandos verstanden werden
	 * Wort 6		Unterst�tze Versionsnummer des Protokolls
	 * Als Antwort erh�lt es ein ES_OK vom  Editor.
	 */

#define SE_OK				0x4201
	/*
	 * Die Shell sagt dem Editor, das sie das Protokoll versteht.
	 * Wort 3		Ein Bitset, welche Nachrichten die Shell versendet
	 * Wort 4+5		Ein Bitset, welche Editorkommandos verstanden werden
	 * Wort 6		Unterst�tze Versionsnummer des Protokolls
	 * Wort 7		Die ApId des Programmes, dessen Nachricht beantwortet wird
	 */

#define SE_ACK 			0x4202
	/*
	 * Die Shell best�tigt den Empfang eines Editorkommandos und gibt zur�ck,
	 * ob das Kommando ausgef�hrt wird.
	 * Wort 3		TRUE: Kommando wird verstanden und ausgef�hrt.
	 *			  		FALSE: Das Kommando wird nicht verstanden
	 * Eine SE_ACK mit TRUE sagt nichts dar�ber aus, ob das Kommando erfolg-
	 * reich ausgef�hrt wurde. Es sagt nur, da� die Shell das Kommando
	 * versteht und ausf�hren wird!
	 */

#define SE_OPEN			0x4203
	/*
	 * Die Shell sagt dem Editor, da� er einen Text �ffnen soll.
	 * Wort 3+4		Ein Zeiger auf den Filenamen des zu �ffnenden Files
	 * Wort 5+6		Cursorposition (Zeilennummer)
	 * Wort 7		Cursorposition (Spaltennummer)
	 * Als Antwort erh�lt die Shell ein ES_ACK
	 */

#define SE_ERROR			0x4204
	/*
	 * Es ist ein Fehler beim Compilieren aufgetreten.
	 * Wort 3+4		Ein Zeiger auf eine Infostruktur, die wie folgt
	 *			  		aufgebaut ist:
	 *				  	Wort 0+1	Ein Zeiger auf den Namen des compilierten Textes.
	 *				  	Wort 2+3	Ein Zeiger auf den Text der Fehlermeldung
	 *				  	Wort 4	Die Fehlernummer
	 *				  	Wort 5+6	Die fehlerhafte Zeile
	 *				  	Wort 7  	Die Spalte mit dem Fehler (oder 0)
	 * Mit ES_ACK best�tigt der Editor die Meldung.
	 */

#define SE_ERRFILE		0x4205
	/*
	 * Es sind Fehler aufgetreten. Die Fehlermeldungen stehen in einem
	 * Errorfile, welches in der Message spezifiziert wird.
	 * Wort 3+4		Ein Zeiger auf den Filenamen des Errorfiles mit den
	 *			  		Fehlermeldungen
	 * Wort 5+6		Ein Zeiger auf den Namen des compilierten Textes
	 * Mit ES_ACK best�tigt der Editor die Meldung.
	 */

#define SE_PROJECT		0x4206
	/*
	 * Die Shell teilt dem Editor mit, da� das Projekt ge�ndert wurde.
	 * Der Filename des aktuellen Projektfiles wird als Parameter �bergeben
	 * Wort 3+4		Ein Zeiger auf den Namen des Projektfiles oder NULL.
	 * 				Wird NULL �bergeben, sollte das aktuelle Projekt abgemeldet 
	 *					werden.
	 * Der Editor best�tigt mit ES_ACK.
	 * Eine vern�nftige Reaktion des Editors w�re es in dem Fall,
	 * ebenfalls das Projekt zu wechseln, sofern er diese unterst�tzt.
	 */

#define SE_QUIT			0x4207
	/*
	 * Die Shell teilt dem Editor mit, da� sie jetzt beendet wird.
	 * Der Editor sollte in dem Fall die Shell als Kommunikationspartner
	 * vergessen.
	 * Parameter gibt es keine.
	 * Es wird keine Antwort erwartet!
	 */

#define SE_TERMINATE 	  0x4208
	/*
	 * Die Shell teilt dem Editor mit, da� dieser sich beenden soll.
	 * Der Editor sollte in dem Fall sich selbst beenden und seinen ganz
	 * normalen Terminierungsproze� durchlaufen (und in dem auch ein ES_QUIT
	 * schicken!). Der Grund f�r so eine Meldung der Shell k�nnte zum Beispiel
	 * zu wenig Speicher zum compilieren sein.
	 * Mit ES_ACK best�tigt der Editor die Meldung.
	 */

#define SE_CLOSE			  0x4209
	/*
	 * Die Shell teilt dem Editor mit, da� dieser bestimmte Texte sichern
	 * bzw. schlie�en soll. Beim Schlie�en von ge�nderten Texten sollte der
	 * Editor vorher nachfragen.
	 * Wort 3+4		Ein Zeiger auf den Namen einer Datei oder eine Dateimaske.
	 *			  		'*.*' steht f�r alle Textfenster (entspricht also dem SE_CLOSE
	 *			  		der Protokoll-Version 0x100).
	 * Wort 5		Steuer-Flag:
	 *						0 = nur sichern
	 *			  			1 = sichern und schlie�en
	 *			  			2 = schlie�en ohne sichern
	 * Mit ES_ACK best�tigt der Editor die Meldung.
	 */

#define SE_MENU			0x420A
	/*
	 * Die Shell teilte dem Editor mit, was er f�r die einzelnen Programme
	 * in sein Men� eintragen soll.
	 * Word 3+4		Ein Zeiger auf eine SEMENUINFO-Struktur mit den Eintr�gen.
	 * Mit ES_ACK best�tigt der Editor die Meldung.
	 */


/*
 * Editor -> Shell
*/
#define ES_INIT			0x4240
	/*
	 * Ein Editor fragt an, ob eine Shell das SE-Protokoll versteht.
	 * Wort 3		Ein Bitset, welche Shellnachrichten verstanden werden
	 * Wort 4+5		Ein Bitset, welche Editorkommandos versendet werden
	 * Wort 6		Unterst�tze Versionsnummer des Protokolls
	 * Als Antwort erh�lt es SE_OK von der Shell
	 */

#define ES_OK				0x4241
	/*
	 * Der Editor beantwortet die Anfrage der Shell nach dem Protokoll.
	 * Wort 3		Ein Bitset, welche Shellnachrichten verstanden werden
	 * Wort 4+5		Ein Bitset, welche Editorkommandos versendet werden
	 * Wort 6		Unterst�tze Versionsnummer des Protokolls
	 * Wort 7		Die ApId des Programmes, dessen Nachricht beantwortet wird
	 */

#define ES_ACK 			0x4242
	/*
	 * Der Editor best�tigt den Empfang des Kommandos
	 * Wort 3		TRUE: Kommando wird verstanden und ausgef�hrt.
	 *					FALSE: Das Kommando wird nicht verstanden
	 * Eine ES_ACK mit TRUE sagt nichts dar�ber aus, ob das Kommando erfolg-
	 * reich ausgef�hrt wurde. Es sagt nur, da� der Editor das Kommando
	 * versteht und ausf�hren wird!
	 */

#define ES_COMPILE		0x4243
	/*
	 * Der Editor sagt der Shell, da� sie ein File �bersetzen soll.
	 * Ein Pointer auf den Dateinamen wird in der Message �bergeben.
	 * Wort 3+4		Zeiger auf den Namen der zu compilierenden Datei oder NULL.
	 * Diese Nachricht mu� mit SE_ACK best�tigt werden.
	 */

#define ES_MAKE			0x4244
	/*
	 * Der Editor sagt der Shell, da� sie ein Make ausf�hren soll.
	 * Ein Filename kann in der Message �bergeben werden, mu� aber nicht 
	 * gesetzt sein und mu� von der Shell auch nicht beachtet werden!
	 * Wort 3+4		Zeiger auf den Namen des Makefiles oder NULL.
	 * Die Shell best�tigt mit SE_ACK.
	 */

#define ES_MAKEALL		0x4245
	/*
	 * Der Editor sagt der Shell, da� ein komplettes Make All ausgef�hrt
	 * werden soll. Ein Filename f�r das Makefile kann (mu� nicht) in
	 * der Message �bergeben werden.
	 * Wort 3+4		Zeiger auf den Namen des Makefiles oder NULL.
	 * Die Shell best�tigt mit SE_ACK.
	 */

#define ES_LINK			0x4246
	/*
	 * Der Editor sagt der Shell, da� das Programm gelinkt werden soll. 
	 * Ein Filename kann in der Message �bergeben werden, mu� aber nicht 
	 * unbedingt beachtet werden von der Shell!
	 * Wort 3+4		Zeiger auf den Namen der Source oder NULL.
	 * Die Shell best�tigt mit SE_ACK.
	 */

#define ES_EXEC			0x4247
	/*
	 * Der Editor sagt der Shell, da� das Programm zu der Source ausgef�hrt 
	 * werden soll. Ein Filename kann �bergeben werden, mu� von der Shell 
	 * aber nicht beachtet werden.
	 * Wort 3+4		Zeiger auf den Namen des auszuf�hrenden Files oder NULL.
	 *			  		Bei einer Sourcedatei ist diese ggf. noch zu compilieren 
	 *					und/oder zu linken.
	 * Die Shell best�tigt mit SE_ACK.
	 */

#define ES_MAKEEXEC		0x4248
	/*
	 * Die Shell soll ein Make ausf�hren und danach das Programm ausf�hren.
	 * Ein Filename f�r das Makefile kann (mu� nicht) in der Message
	 * �bergeben werden.
	 * Wort 3+4		Zeiger auf den Namen des Makefiles oder NULL.
	 * Die Shell best�tigt mit SE_ACK.
	 */

#define ES_PROJECT		0x4249
	/*
	 * Der Editor teilt der Shell mit, da� das Project ge�ndert/gewechselt
	 * wurde. Der Filename des  Projektfiles wird als Parameter in der Message
	 * �bergeben. 
	 * Wort 3+4		Zeiger auf den Namen des Projektfiles oder NULL.
	 *					Wird NULL �bergeben, sollte das aktuelle Projekt abgemeldet
	 * 				werden.
	 * Die Shell best�tigt mit SE_ACK.
	 * Eine vern�nftige Reaktion der Shell w�re in dem Fall, ebenfalls
	 * das Projekt zu wechseln, sofern sie diese unterst�tzt.
	 */

#define ES_QUIT			0x424A
	/*
	 * Der Editor teilt der Shell mit, da� er jetzt beendet wird. Die Shell 
	 * sollte in dem Fall den Editor als Kommunikationspartner vergessen.
	 * Parameter gibt es keine.
	 * Es wird keine Antwort erwartet!
	 */

#define ES_SHLCTRL		0x424B
	/*
	 * Sonstige Kontrolle der Shell durch den Editors.
	 * Wort 3+4		Zeiger auf den Namen des obersten Fensters des Editors
	 *             oder NULL.
	 * Wort 5		Steuer-Flag:
	 *						0: Shell soll sich toppen (Men�/Fenster).
	 * Die Shell best�tigt mit SE_ACK.
	 */


/*
 * Shell-Kommando-Bits 
 */
#define _SEINIT		0x0001
#define _SEOK			0x0002
#define _SEACK 		0x0004
#define _SEOPEN		0x0008
#define _SEERROR		0x0010
#define _SEERRFILE	0x0020
#define _SEPROJECT	0x0040
#define _SEQUIT		0x0080
#define _SETERMINATE 0x0100
#define _SECLOSE		0x0200
#define _SEMENU		0x0400

/*
 * Editor-Kommando-Bits
 */
#define _ESINIT		0x0001
#define _ESOK			0x0002
#define _ESACK 		0x0004
#define _ESCOMPILE	0x0008
#define _ESMAKE		0x0010
#define _ESMAKEALL	0x0020
#define _ESLINK		0x0040
#define _ESEXEC		0x0080
#define _ESMAKEEXEC	0x0100
#define _ESPROJECT	0x0200
#define _ESQUIT		0x0400
#define _ESSHLCTRL	0x0800



/*
 * Die Nachricht SE_ERROR liefert einen Zeiger auf diese Struktur:
 */
typedef struct
{
	char	*errFile;			/* Zeiger auf den Namen der compilierten Datei */
	char	*errMess;			/* Zeiger auf die Fehlermeldung */
	int	errNum;				/* Die Fehlernummer */
	long	errLine; 			/* Die fehlerhafte Zeile */
	int	errRow;				/* Die Spalte mit dem Fehler (oder 0) */
} ERRINFO;

/*
 * Die Nachricht SE_MENU verwendet einen Zeiger auf diese Struktur:
 */
typedef struct
{
	char	*compStr;
	char	*makeStr;
	char	*makeAllStr;
	char	*linkStr;
	char	*execStr;
	char	*makeExecStr;
	char	*progName;
	char	*shellCtrlStr; 	/* neu f�r ES_SHLCTRL ab 0x105 */
} SEMENUINFO;
