/*
 * Desk_Public.h
 */

	#include	"DESKICON.H"				/* noms des objets du bureau et icones */
	#include	"DEFICONS.H"				/* noms des objets du bureau et icones */
	#include "DFSTRUCT.H"
	#include "GEMWDEF.H"


	/*
	 * Membres:
	 */
	extern	OBJECT	*	G_desktop_adr;				/* Ptr sur arbre bureau */
	extern	WIPARAMS	*	G_desk_params_adr;		/* Param�tres de la "fen�tre bureau" */
	extern	ICONIMGS		G_icon_images;				/* Pointeurs sur les images des ic�nes */
	extern	int			G_icon_w, G_icon_h;		/* Dimensions des ic�nes */
	extern	int			G_iconw_max_w;				/* Dimension maximale d'une fen�tre contenant des ic�nes */
	extern	int			G_fantome_icone[18];		/* Tableau contenant les coord pour le dessin d'un fant�me d'ic�ne */
	extern	DATAGROUP *	G_datagroups;				/* Pointeur sur tableau de G_datagroups */




	/* 
	 * Bureau: 
	 */
	extern	void	init_desktop( void );	/* Installe nouveau bureau */
	extern	void	clear_desktop( void );	/* D�sinstalle ce bureau */
	extern	void	init_icons( void );		/* Init ic�nes */
	extern	DATAGROUP	*dgroup_adr_byiconno( int icon_no );
	DATAGROUP	*	find_datagroup_byType( 		/* Out: Ptr sur datagroup */
						DATATYPE		DataType );	/* In:  Type DTYP_* */
						
void	Icon_CopyIBLKtoICONIMG(
			ICONBLK * pIconBlk,
			ICONIMG * pIconImg );
void	Icon_CopyICONIMGtoIBLK(
			ICONIMG * pIconImg,
			ICONBLK * pIconBlk );

						
