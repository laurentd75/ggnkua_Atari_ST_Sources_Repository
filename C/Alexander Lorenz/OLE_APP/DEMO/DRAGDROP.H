/*
*	MultiTOS Drag&Drop Header file
*/

#include "portab.h"


/* R�ckgabewerte von ddstry() etc. */

#define	DD_OK			0
#define DD_NAK			1
#define DD_EXT			2
#define DD_LEN			3
#define DD_TRASH		4
#define DD_PRINTER		5
#define DD_CLIPBOARD	6


/* Timeout in Millisekunden (4 sek.) */

#define DD_TIMEOUT		4000


/* Anzahl der Extensionen/Bytes der "bevorzugten Extensionen" */

#define DD_NUMEXTS		8
#define DD_EXTSIZE		32L


/* Max. L�nge des Drag&Drop name/file */

#define DD_NAMEMAX		128


/* Max. L�nge des Drag&Drop Header */

#define DD_HDRMAX		(8+DD_NAMEMAX+DD_NAMEMAX)


/*
*	Funktionsdeklarationen
*/

WORD ddcreate(WORD *pipe);
WORD ddmessage(WORD apid, WORD fd, WORD winid, WORD mx, WORD my, WORD kstate, WORD pipename);
WORD ddrexts(WORD fd, BYTE *exts);
WORD ddstry(WORD fd, BYTE *ext, BYTE *text, BYTE *name, LONG size);
VOID ddclose(WORD fd);
VOID ddgetsig(LONG *oldsig);
VOID ddsetsig(LONG oldsig);
WORD ddopen(WORD ddnam, BYTE ddmsg);
WORD ddsexts(WORD fd, BYTE *exts);
WORD ddrtry(WORD fd, BYTE *name, BYTE *file, BYTE *whichext, LONG *size);
WORD ddreply(WORD fd, BYTE ack);
