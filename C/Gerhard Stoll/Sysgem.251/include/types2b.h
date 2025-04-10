/*
	Tabulatorweite: 3
	Kommentare ab: Spalte 60											*Spalte 60*
*/

#ifndef __2B_UNIVERSAL_TYPES__										/* schon vorhanden? */
#define __2B_UNIVERSAL_TYPES__


/*----------------------------------------------------------------------------------------*/
/* Compiler-Plattform																							*/
/*----------------------------------------------------------------------------------------*/
#define	IS_MACOS		0													/* MacOS */
#define	IS_WINOS		0													/* Windows */
#define	IS_TOS		0													/* MagiC */

#if __MWERKS__																/* Metrowerks CodeWarrior */

#undef	IS_MACOS
#define	IS_MACOS		1

#elif __PUREC__															/* Pure-C */

#undef	IS_TOS
#define	IS_TOS		1

#elif _MSC_VER																/* MSVC */

#undef	IS_WINOS
#define	IS_WINOS		1

#else

#error Unknown Compiler

#endif

/*----------------------------------------------------------------------------------------*/
/* Zielplattform																									*/
/*----------------------------------------------------------------------------------------*/
/*
#include "target.h"														/* Zielplattform des Projekts (lokale Include-Datei) */
*/

#if __MWERKS__																/* Metrowerks CodeWarrior */

#define LITTLE_ENDIAN	__INTEL__
#define INTEL				__INTEL__
#define PPC					__POWERPC__
#define MC68K				__MC68K__

#elif __PUREC__															/* Pure-C */

#define LITTLE_ENDIAN	0
#define INTEL				0
#define PPC					0
#define MC68K				1

#elif _MSC_VER																/* MSVC */

#define LITTLE_ENDIAN	1
#define INTEL				1
#define PPC					0
#define MC68K				0

#else

#error Unknown Compiler

#endif


/*----------------------------------------------------------------------------------------*/
/* Umgebungsspezifische Schl�sselworte (nicht ANSI-konform)											*/
/*----------------------------------------------------------------------------------------*/
#if IS_MACOS
	#define	cdecl
#endif


/*----------------------------------------------------------------------------------------*/
/* Strukturanordnung/Alignment																				*/
/*----------------------------------------------------------------------------------------*/
#if INTEL																	/* MSVC, CW f�r x86, ... */

#define	PRAGMA_PACKED_ALIGN	pack(push,1)						/* Strukturelemente auf Bytegrenze packen */
#define	PRAGMA_NATIVE_ALIGN	pack(push,8)						/* 8 Byte ist f�r MSVC die normale Einstellung */
#define	PRAGMA_RESET_ALIGN	pack(pop)							/* Anordnung zur�cksetzen */

#elif __MWERKS__															/* CW f�r 68k, PPC, ... */

#define	PRAGMA_PACKED_ALIGN	options align=packed				/* Strukturelemente auf Bytegrenze packen */
#define	PRAGMA_NATIVE_ALIGN	options align=native				/* Strukturelemente auf sinnvolle Positionen packen */
#define	PRAGMA_RESET_ALIGN	options align=reset				/* Anordnung zur�ccksetzen */

#else																			/* unbekannter Compiler mit Byte-Alignment */

#define	PRAGMA_PACKED_ALIGN
#define	PRAGMA_NATIVE_ALIGN
#define	PRAGMA_RESET_ALIGN

#endif

#define	VARIABLE_ARRAY_SIZE	1										/* Konstante f�r variabel gro�e Felder (mu� wegen C++ bzw. Ansi-Strict >= 1 sein) */


/*----------------------------------------------------------------------------------------*/
/* Standarddatentypen f�r 8, 16, 32 und 64 Bit															*/
/*----------------------------------------------------------------------------------------*/
typedef signed char		int8;											/* 8 Bit vorzeichenbehaftet */
typedef unsigned char	uint8;										/* 8 Bit vorzeichenlos */

typedef signed short		int16;										/* 16 Bit vorzeichenbehaftet */
typedef unsigned short	uint16;										/* 16 Bit vorzeichenlos */

typedef signed long		int32;										/* 32 Bit vorzeichenbehaftet */
typedef unsigned long	uint32;										/* 32 Bit vorzeichenlos */


#if __MWERKS__ >= 0x0710												/* CodeWarrior 11 mit C-Compiler >= 7.1 ? */

#define	__2B_HAS64_SUPPORT											/* Compiler unterst�tzt int64/uint64 */
typedef signed long long	int64;									/* 64 Bit vorzeichenbehaftet */
typedef unsigned long long	uint64;									/* 64 Bit vorzeichenlos */

#elif _MSC_VER >= 900													/* MSVC 2.0? */

#define	__2B_HAS64_SUPPORT											/* Compiler unterst�tzt int64/uint64 */
typedef signed __int64	int64;										/* 64 Bit vorzeichenbehaftet */
typedef unsigned __int64	uint64;									/* 64 Bit vorzeichenlos */

#else																			/* Compiler ohne Unterst�tzung von 64 Bit Integers */
#pragma	PRAGMA_PACKED_ALIGN

typedef struct
{
	int32		hi;
	uint32	lo;
} int64;																		/* 64 Bit vorzeichenbehaftet */

typedef struct
{
	uint32	hi;
	uint32	lo;
} uint64;																	/* 64 Bit vorzeichenlos */

#pragma	PRAGMA_RESET_ALIGN
#endif


/*----------------------------------------------------------------------------------------*/
/* Boolean																											*/
/*----------------------------------------------------------------------------------------*/

#define	__TMP_HAS_BOOL__	0

#if __MWERKS__																/* Metrowerks CodeWarrior, C++ mit boolean? */

#if __cplusplus && __option(bool)
#undef	__TMP_HAS_BOOL__
#define	__TMP_HAS_BOOL__	1
#endif

#endif

#if __TMP_HAS_BOOL__														/* C++-Compiler mit bool? */

typedef bool	boolean;

#ifndef FALSE
#define	FALSE	false
#endif

#ifndef TRUE
#define	TRUE	true
#endif

#else																			/* Compiler ohne bool */

/* typedef uint8	boolean;*/

#ifndef FALSE
#define	FALSE	0
#endif

#ifndef TRUE
#define	TRUE	1
#endif


#endif																		/* __TMP_HAS_BOOL__ */

#undef __TMP_HAS_BOOL__

/*----------------------------------------------------------------------------------------*/
/* Festpunktformate																								*/
/*----------------------------------------------------------------------------------------*/
typedef int32	fixed32;													/* 16.16 vorzeichenbehaftet */
typedef int64	fixed64;													/* 32.32 vorzeichenbehaftet */
typedef int32	fixed2p30;												/* 2.30 vorzeichenbehaftet (f�r Berechnungen im Zahlenbereich von -1.0 bis +1.0) */
#define	fixed	fixed32


/*----------------------------------------------------------------------------------------*/
/* Wandelmakros f�r Festpunktformate																		*/
/*----------------------------------------------------------------------------------------*/

/* Makros f�r 16.16 */
#define	int_to_fixed( i )				(((fixed) i ) << 16 )
#define	double_to_fixed( f )			((fixed) ( f * ( 1L << 16 )))

#define	fixed_to_int16( x )			((int16) ( x >> 16 ))
#define	fixed_to_int32( x )			((int32) ( x >> 16 ))
#define	fixed_to_double( x )			(((double) x ) / ( 1L << 16 ))

/* Makros f�r 32.32 */
#ifdef	__2B_HAS64_SUPPORT											/* nur f�r Compiler mit Unterst�tzung von int64 */

#define	int_to_fixed64( i )			(((fixed64) i ) << 32 )
#define	double_to_fixed64( f )		((fixed64) ( f * ( 1L << 32 )))

#define	fixed64_to_int16( x )			((int16) ( x >> 32 ))
#define	fixed64_to_int32( x )			((int32) ( x >> 32 ))
#define	fixed64_to_int64( x )			((int64) ( x >> 32 ))
#define	fixed64_to_double( x )			(((double) x ) / ( 1L << 32 ))

#endif

/* Makros f�r 2.30 */
#define	int_to_fixed2p30( i )		(((fixed2p30) i ) << 30 )
#define	double_to_fixed2p30( f )	((fixed2p30) ( f * ( 1L << 30 )))

#define	fixed2p30_to_int16( x )		((int16) ( x >> 30 ))
#define	fixed2p30_to_int32( x )		((int32) ( x >> 30 ))
#define	fixed2p30_to_double( x )	(((double) x ) / ( 1L << 30 ))


/*----------------------------------------------------------------------------------------*/
/* Wandelmakros f�r Little-Endian (Intel)																	*/
/*----------------------------------------------------------------------------------------*/
#define	REVERSE16( a ) 	(int16) (((uint16)(a) >> 8 ) | ((uint16)(a) << 8 ))
#define	REVERSEu16( a )	(((uint16)(a) >> 8 ) | ((uint16)(a) << 8 ))

#define	REVERSE32( a )		(int32) (((uint32)(a) << 24 ) | (((uint32)(a) & 0xff00L ) << 8 ) | \
											  (((uint32)(a) >> 8 ) & 0xff00L ) | ((uint32)(a) >> 24 ))

#define	REVERSEu32( a )	(((uint32)(a) << 24 ) | (((uint32)(a) & 0xff00UL ) << 8 ) | \
									(((uint32)(a) >> 8 ) & 0xff00UL ) | ((uint32)(a) >> 24 ))

#define	REVERSEptr( a )	((void *) REVERSEu32( a ))


/*----------------------------------------------------------------------------------------*/
/* 68k-Makros (u.a. Inline-Assembler)																		*/
/*----------------------------------------------------------------------------------------*/
#if MC68K
#if USE_INLINE																/* Inline-Assembler benutzen? */

#if __PUREC__																/* Pure-C? */

#undef	REVERSE16
#undef	REVERSEu16
#undef	REVERSE32
#undef	REVERSEu32
#undef	REVERSEptr

static int16	REVERSE16( int16 d0 )	0xe058;					/* ror.w		#8,d0 */
static uint16	REVERSEu16( uint16 d0 )	0xe058;					/* ror.w		#8,d0 */

static int32	rorw1( int32 d0 )			0xe058;					/* ror.w		#8,d0 */
static int32	swapl( int32 d0 )			0x4840;					/* swap		d0 */

#define REVERSE32( a )	(rorw1(swapl(rorw1( a ))))
#define REVERSEu32( a )	((uint32)(rorw1(swapl(rorw1((int32)( a ))))))
#define REVERSEptr( a )	((void *) REVERSEu32(((uint32) a )))

#elif __MWERKS__															/* Metrowerks CodeWarrior? */

#undef	REVERSE16
#undef	REVERSEu16
#undef	REVERSE32
#undef	REVERSEu32
#undef	REVERSEptr

static int16	REVERSE16( int16 d0: __D0 ) = (0xe058);		/* ror.w		#8,d0 */
static uint16	REVERSEu16( uint16 d0: __D0 ) = (0xe058);		/* ror.w		#8,d0 */

static int32	rorw1( int32 d0: __D0 ) = (0xe058);				/* ror.w		#8,d0 */
static int32	swapl( int32 d0: __D0 ) = (0x4840);				/* swap		d0 */

#define REVERSE32( a )	(rorw1(swapl(rorw1( a ))))
#define REVERSEu32( a )	((uint32)(rorw1(swapl(rorw1((int32)( a ))))))
#define REVERSEptr( a )	((void *) REVERSEu32(((uint32) a )))

#endif

#endif																		/* USE_INLINE */
#endif																		/* MC68K */

/*----------------------------------------------------------------------------------------*/
/* Intel-Makros (u.a. Inline-Assembler)																	*/
/*----------------------------------------------------------------------------------------*/
#define	FASTCALL															/* f�r normale Prozessoren/Compiler */

#if INTEL																	/* Intel-CPU? */
#if USE_INLINE																/* Inline-Assembler benutzen? */

#if __MWERKS__ >= 0x0710												/* CodeWarrior 11 mit C-Compiler >= 7.1 ? */
#define	__asm	asm														/* der CW versteht nur asm { } und nicht __asm */
#endif

#if _MSC_VER >= 900														/* MSVC 2.0? */

/*
	Die untenstehende Inline-Funktionen in Intel-Assembler benutzen die folgenden
	MSVC Eigenschaften:

	__declspec( naked )
	===================

	Mit dem naked-Attribut deklarierte Funktionen werden vom Compiler ohne Prolog- und
	Epilog-Code generiert, sie enthalten nur die angegebenen (Assembler-) Befehle. Da 
	das naked-Attribut nur die Code-Generierung f�r Prolog und Epilog betrifft und nicht
	die Art der Parameter�bergabe �ndert, wird es nicht bei der Deklaration der Funktion
	angegeben.
	Es �brigens eine Eigenart von MSVC, da� bei einer naked-Funktion die static-Definition
	nur bei der Deklaration erlaubt ist aber bei der Funktion selber einen Fehler ausl�st.

	__fastcall
	==========
	
	Parameter�bergabe:	Die ersten beiden (u)int32-Argumente (oder kleiner) werden in ECX und EDX
								�bergeben. Alle anderen werden von rechts nach links auf dem Stack �bergeben.
	R�ckgabe:				Das Funktionsresultat wird in EAX zur�ckgeliefert (wenn es uint32 oder kleiner ist).
	Benamung:				Ein "@" kommt vor den Namen und ein "@" gefolgt von der Byteanzahl in der 
								Parameterliste wird an den Namen angeh�ngt.
*/

/* Makros entfernen */
#undef	REVERSE16
#undef	REVERSEu16
#undef	REVERSE32
#undef	REVERSEu32
#undef	REVERSEptr
#undef	FASTCALL

#undef	FASTCALL
#define	FASTCALL	__fastcall

/* Funktionen definieren */
static int16 __fastcall REVERSE16( int16 value );
static uint16 __fastcall REVERSEu16( uint16 value );
static int32 __fastcall REVERSE32( int32 value );
static uint32 __fastcall REVERSEu32( uint32 value );
static void *__fastcall REVERSEptr( void *ptr );

__declspec( naked ) int16 FASTCALL REVERSE16( int16 value )
{
	__asm	ror	cx,8
	__asm	mov	ax,cx
	__asm	ret
}
__declspec( naked ) uint16 FASTCALL REVERSEu16( uint16 value )
{
	__asm	ror	cx,8
	__asm	mov	ax,cx
	__asm	ret
}
__declspec( naked ) int32 FASTCALL REVERSE32( int32 value )
{
	__asm	bswap	ecx
	__asm	mov	eax,ecx
	__asm	ret
}
__declspec( naked ) uint32 FASTCALL REVERSEu32( uint32 value )
{
	__asm	bswap	ecx
	__asm	mov	eax,ecx
	__asm	ret
}
__declspec( naked ) void *FASTCALL REVERSEptr( void *ptr )
{
	__asm	bswap	ecx
	__asm	mov	eax,ecx
	__asm	ret
}

#endif																		/* _MSC_VER */

/* Bei INTEL_SWAPxx() m�ssen die Werte direkt �bergeben werden. */
/* Aufrufe wie INTEL_SWAP32( bitmap->width ) sind nicht erlaubt, */
/* da der Compiler damit nicht klarkommt. */

#define	INTEL_SWAP16( value )										\
{																				\
	__asm {	mov		eax,value	}									\
	__asm	{	ror		ax,8			}									\
	__asm	{	mov		value,eax	}									\
}

#define	INTEL_SWAP32( value )										\
{																				\
	__asm {	mov		eax,value	}									\
	__asm	{	bswap 	eax			}									\
	__asm	{	mov		value,eax	}									\
}

#else																			/* kein Inline-Assembler */

#define	INTEL_SWAP16( value )	value = REVERSEu16( value )
#define	INTEL_SWAP32( value )	value = REVERSEu32( value )

#endif																		/* USE_INLINE */

#else																			/* normaler Prozessor */

#define	INTEL_SWAP16( value )										/* keine Byteumkehrung */
#define	INTEL_SWAP32( value )										/* keine Byteumkehrung */

#endif																		/* INTEL */


/*----------------------------------------------------------------------------------------*/
/* Makros f�r Wandlung LITTLE_ENDIAN/BIG_ENDIAN <-> Zielplattform									*/
/*----------------------------------------------------------------------------------------*/
#if LITTLE_ENDIAN

#define HOST_2_LENDIAN_16( a ) ( a )
#define HOST_2_LENDIAN_32( a ) ( a )
#define HOST_2_BENDIAN_16( a ) ( REVERSEu16( a ))
#define HOST_2_BENDIAN_32( a ) ( REVERSEu32( a ))

#define LENDIAN_2_HOST_16( a ) ( a )
#define LENDIAN_2_HOST_32( a ) ( a )
#define BENDIAN_2_HOST_16( a ) ( REVERSEu16( a ))
#define BENDIAN_2_HOST_32( a ) ( REVERSEu32( a ))

#else																			/* normaler Prozessor */

#define HOST_2_LENDIAN_16( a ) ( REVERSEu16( a ))
#define HOST_2_LENDIAN_32( a ) ( REVERSEu32( a ))
#define HOST_2_BENDIAN_16( a ) ( a )
#define HOST_2_BENDIAN_32( a ) ( a )

#define LENDIAN_2_HOST_16( a ) ( REVERSEu16( a ))
#define LENDIAN_2_HOST_32( a ) ( REVERSEu32( a ))
#define BENDIAN_2_HOST_16( a ) ( a )
#define BENDIAN_2_HOST_32( a ) ( a )

#endif																		/* LITTLE_ENDIAN */


/*----------------------------------------------------------------------------------------*/
/* �berlauf einer Addtion feststellen																		*/
/*----------------------------------------------------------------------------------------*/
#define	XBIT8( a, b )	((( a & b ) | (( a | b ) & ( a + b ))) >> 7 )
#define	XBIT16( a, b )	((( a & b ) | (( a | b ) & ( a + b ))) >> 15 )
#define	XBIT32( a, b )	((( a & b ) | (( a | b ) & ( a + b ))) >> 31 )

/*----------------------------------------------------------------------------------------*/
/* Rotation nach links																							*/
/*----------------------------------------------------------------------------------------*/
#define	LROTATE8( a, shifts )	((uint8) (((uint8) a << shifts ) | ((uint8) a >> ( 8 - shifts ))))
#define	LROTATE16( a, shifts )	((uint16) (((uint16) a << shifts ) | ((uint16) a >> ( 16 - shifts ))))
#define	LROTATE32( a, shifts )	((uint32) (((uint32) a << shifts ) | ((uint32) a >> ( 32 - shifts ))))

/*----------------------------------------------------------------------------------------*/
/* Rotation nach rechts																							*/
/*----------------------------------------------------------------------------------------*/
#define	RROTATE8( a, shifts )	((uint8) (((uint8) a >> shifts ) | ((uint8) a << ( 8 - shifts ))))
#define	RROTATE16( a, shifts )	((uint16) (((uint16) a >> shifts ) | ((uint16) a << ( 16 - shifts ))))
#define	RROTATE32( a, shifts )	((uint32) (((uint32) a >> shifts ) | ((uint32) a << ( 32 - shifts ))))


/*----------------------------------------------------------------------------------------*/
/* Zeichenkonstanten																								*/
/*----------------------------------------------------------------------------------------*/
#if LITTLE_ENDIAN															/* wir m�ssen wieder alles drehen */

#define	CHAR_CONST16( a )	REVERSEu16( a )
#define	CHAR_CONST32( a )	REVERSEu32( a )

#else																			/* normale Bytereihenfolge */

#define	CHAR_CONST16( a )	( a )
#define	CHAR_CONST32( a )	( a )

#endif


/*----------------------------------------------------------------------------------------*/
/* Pr�ffunktion																									*/
/*----------------------------------------------------------------------------------------*/
#if USE_TYPE_CHECKING

static int	are_types_ok( void );
static int	are_types_ok( void )										/* Gr��e der Standarddatentypen �berpr�fen */
{
	if ( FALSE != 0 )
		return( 0 );

	if ( TRUE != 1 )
		return( 0 );

	if ( sizeof( int8 ) != 1 )
		return( 0 );

	if ( sizeof( uint8 ) != 1 )
		return( 0 );
	
	if ( sizeof( int16 ) != 2 )
		return( 0 );

	if ( sizeof( uint16 ) != 2 )
		return( 0 );

	if ( sizeof( int32 ) != 4 )
		return( 0 );

	if ( sizeof( uint32 ) != 4 )
		return( 0 );

	if ( sizeof( int64 ) != 8 )
		return( 0 );

	if ( sizeof( uint64 ) != 8 )
		return( 0 );

	return( 1 );															/* alle Datentypen haben die korrekte L�nge */
}

#endif																		/* USE_TYPE_CHECKING */
#endif																		/* __2B_UNIVERSAL_TYPES__ */
