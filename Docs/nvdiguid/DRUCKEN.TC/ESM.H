/*
	Tabulatorweite: 3
	Kommentare ab: Spalte 60											*Spalte 60*
*/

#define	ESM_MONOCHROME	
#define	ESM_GRAYSCALE	2

typedef struct
{
	LONG	magic;															/* 'TMS\0' */
	WORD	size;																/* L�nge des Headers in Bytes (0x032c) */

	WORD	width;															/* Breite in Pixeln */
	WORD	height;															/* H�he in Zeilen */

	WORD	planes;															/* Bits pro Pixel */
	WORD	format;															/* Bildtyp */

	WORD	r_bits;															/* Anzahl der Bits f�r Rot */
	WORD	g_bits;															/* Anzahl der Bits f�r Gr�n */
	WORD	b_bits;															/* Anzahl der Bis f�r Blau */
	WORD	k_bits;															/* Anzahl der Bits f�r Schwarz (??) */	

	WORD	version;															/* Versionsnummer */
	WORD	hdpi;																/* horizontale Aufl�sung in dpi */
	WORD	vdpi;																/* vertikale Aufl�sung in dpi */

	WORD	file_height;
	WORD	y1;																/* erste anzuzeigende Zeile */
	WORD	y2;																/* letzte anzuzeigende Zeile */

	WORD	mask;																/* Maske */

	UBYTE	red[256];														/* Rot-Intensit�ten */
	UBYTE	green[256];														/* Gr�n-Intensit�ten */
	UBYTE	blue[256];														/* Blau-Intensit�ten */

} ESM_HEAD;







