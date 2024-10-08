/*
 * popup.c
 *
 * Purpose:
 * --------
 * Routines de gestion de menus POP-UP
 *
 * Notes:
 * ------
 * This template is designed to ease program maintainance
 *
 * Suggest:
 * --------
 * Keep comments up to date, all the time!
 *
 * History:
 * --------
 * 1993: fplanque: Created
 */

 
 	#include "!OPTIONS.H"				/* Options de compilation */         
	#define	THIS_FILE	"POPUP.C v1.10 - 03.95"
          

/*
 * System headers:
 */
	#include	<stdio.h>
	#include	<string.h>					/* strlen() etc.. */
	#include	<aes.h>						/* header AES */
   

/*
 * Custom headers:
 */
	#include	"POPUP.H"	

	#include "SPEC_PU.H"
	#include "S_MALLOC.H"
	#include "DEBUG_PU.H"
	#include "TEXT_PU.H"						/* D�finitions texte */
	#include	"EXFRM_PU.H"			
	#include "OBJCT_PU.H"	

   
/*
 * ------------------------ VARIABLES -------------------------
 */

	extern	int		G_x_mini, G_y_mini;		/* Coord sup gauche de l'�cran */
	extern	int		G_w_maxi, G_h_maxi;		/* Taille de l'�cran de travail */
	extern	VDI_TEXT_PARAMS	G_aes_text;		/* Param�tres texte AES */

/*
 * Private variables: 
 */
	static OBJECT M_basic_popup[] = {
				-1, -1, -1, G_BOX, NONE, SHADOWED, 0xFF1100L, 1,1, 12*8,10*16,
				 0, -1, -1, G_STRING, TOUCHEXIT|SELECTABLE, NORMAL, 0x0L, 0,0, 12*8,1*16};
	 
 
/*
 * ------------------------ FUNCTIONS -------------------------
 */


/*
 * PopUp_Init(-)
 *
 * Purpose:
 * --------
 * Init gestion des menus Pop-Up
 *
 * History:
 * --------
 * 13.02.95: fplanque: Created
 */
void	PopUp_Init( void )
{
	TRACE0( "Initializing " THIS_FILE );

	/*
	 * Fixe taille d'une ligne popup en fonction de la r�solution:
	 */
	M_basic_popup[ 1 ] .ob_height = G_aes_text .cell_h;
}


/*
 * popup(-)
 *
 * Purpose:
 * --------
 * Gestion d'un menu Pop-Up
 *
 * Notes:
 * ------
 * N'utilise PAS junk1
 *
 * History:
 * --------
 * fplanque: Created
 */
int	popup( 
			int pop_x, 
			int pop_y, 
			POPUP_ENTRY *entries, 	/* In: Menu � d�rouler */
			int current_val )			/* In: Valeur courante -> re�oit un Checkmark! */
{
	/*
	 * Variables: 
	 */
	int		nb_entries = 0;		/* Nombre d'options du menu */
	char		*curr_name;				/* Nom en cours de traitement */
	int		checked_item = NIL;	/* No de l'option devant laquelle on a plac� une checkmark */
	int		i;	
	int		line_width;				/* Largeur de la ligne courante */
	int		menu_width = 0;		/* Largeur requise pour le menu */
	GRECT		popup_box;				/* Coordonn�es sur l'�cran: */
	OBJECT	*popup_tree;			/* Arbre Popup */
	int		edit = 0;				/* Bidon */
	int		exit_obj;				/* Objet de sortie */

	/* 
	 * Parcourt les lignes: 
	 */
	while(	curr_name = entries[ nb_entries ] .name,
				curr_name != NULL )
	{
		/*
		 * Contr�le de la largeur 
		 */
		line_width = (int) strlen( curr_name );	/* Long ligne courante */
		if ( line_width > menu_width )
		{	/*
			 * Si cette ligne est plus longue que les autres: 
			 */
			menu_width = line_width;	/* Nlle largeur du menu */
		}

		/*
		 * Contr�le Checkmark 
		 */
		if ( checked_item == NIL && entries[ nb_entries ] .value == current_val )
		{	/*
			 * Si on a trouv� l'option courante: 
			 */ 
			curr_name[ 0 ] = CHECK ;	/* Place checkmark */
			checked_item = nb_entries;	/* M�morise no de la ligne */
		}

		/*
		 * Une option de plus dans le menu: 
		 */
		nb_entries++;
	}

	/*
	 * Augmente la largeur du menu de la taille d'un caract�re: 
	 * (Pour laisser un espace � droite) 
	 */
	menu_width ++;	
	/*
	 * Convertit la largeur en pixels: 
	 */
	menu_width *= G_aes_text .cell_w;

	/* 
	 * Cr�e l'arbre d'objet: 
	 * R�serve de la place pour les lignes texte et le p�re: 
	 */
	popup_tree = (OBJECT *) MALLOC( sizeof( OBJECT ) * (nb_entries+1) );
	/*
	 * Copie le p�re: 
	 */
	memcpy( popup_tree, M_basic_popup, sizeof( OBJECT ) );
	/*
	 * Fixe position du p�re: 
	 */
	popup_tree[ 0 ] .ob_x = pop_x;
	/*
	 * Fixe largeur du p�re: 
	 */
	popup_tree[ 0 ] .ob_width = menu_width;

	/* 
	 * Fixe la largeur de l'objets-STRING servant de mod�le aux lignes qui vont �tre ajout�es au menu: 
	 */
	M_basic_popup[ 1 ] .ob_width = menu_width;

	/* 
	 * Ajoute les entr�es popup: 
	 */
	for( i=1; i<=nb_entries; i++ )
	{
		/*
		 * Ajoute un objet STRING: 
		 */
		memcpy( &popup_tree[ i ], &M_basic_popup[ 1 ], sizeof( OBJECT ) );
		/*
		 * Modifie les liens pour le ratacher au p�re: 
		 */
		objc_add( popup_tree, 0, i );
		/*
		 * Fixe sa position: 
		 */
		popup_tree[ i ] .ob_y = G_aes_text .cell_h * (i-1);
		/*
		 * Fixe ptr sur la chaine-texte concern�e: 
		 */
		popup_tree[ i ] .ob_spec.free_string = entries[ i-1 ] .name;
	}
	/*
	 * Dernier objet: 
	 */
	popup_tree[ i-1 ] .ob_flags |= LASTOB;
	
	/*
	 * Fixe hauteur totale du p�re: 
	 */
	popup_tree[ 0 ] .ob_height = G_aes_text .cell_h * (i-1);

	/* 
	 * Position verticale: Contr�le si on ne d�passe pas le bord de l'�cran: 
	 */
	if ( pop_y + popup_tree[ 0 ] .ob_height > G_y_mini + G_h_maxi -2 )
	{	/*
		 * Si on d�passe le bas: 
		 */
		popup_tree[ 0 ] .ob_y = G_y_mini + G_h_maxi - 2 - popup_tree[ 0 ] .ob_height;
	}
	else
	{
		popup_tree[ 0 ] .ob_y = pop_y;
	}

	/* 
	 * Gestion "formulaire": 
	 */
	open_panel( popup_tree, NULL, &popup_box, FALSE0 );	

	exit_obj = ext_form_gest( popup_tree, &edit, TRUE_1 );

	close_pannel( popup_tree, exit_obj, &popup_box );	 

	/*
	 * Lib�re m�moire occup�e par le pop-up: 
	 */
	FREE( popup_tree );

	/* 
	 * Enl�ve checkmark: 
	 */
	if ( checked_item != NIL )
	{	/*
		 * Si on a plac� une checkmark: 
		 */
		entries[ checked_item ] .name[ 0 ] = ' ';	/* Enl�ve */
	}

	/* 
	 * Valeur en retour: 
	 */
	if ( exit_obj != NIL )
	{	/*
		 * Si on a s�lectionn� une option: 
		 * Retourne no de ligne s�lectionn�e [0...x] 
		 */
		return	entries[ -- exit_obj ] .value;
	}
	else
	{	/*
		 * On a cliqu� hors du menu : rien s�lectionn�: 
		 */
		return	ABORT_2;		/* (-2) */
	}
}




/*
 * popup_inform(-)
 *
 * Purpose:
 * --------
 * Appel d'un menu Pop-Up depuis un Formulaire
 *
 * Notes:
 * ------
 * N'utilise PAS junk1
 *
 * History:
 * --------
 * fplanque: Created
 */
int	popup_inform( 					/* Out: Valeur s�lectionn�e */
			OBJECT *call_form, 		/* In:  Formulaire appellant */
			int call_obj, 				/* In:  Objet appellant */
			int title_obj, 			/* In:  No Objet sur lequel le menu va s'aligner (Titre de menu) */
			POPUP_ENTRY *entries, 	/* In:  Menu Pop-Up � d�rouler */
			int current_val )			/* In:  Valeur courante -> recevra checkmark */
{
	int	selected_value;

	/* 
	 * D�termine coordonn�es du Popup: 
	 */
	int	pop_x, pop_y;
	objc_offset( call_form, title_obj, &pop_x, &pop_y );
	pop_y += call_form[ title_obj ] .ob_height +2;

	/*
	 * Appelle Popup 
	 */
	selected_value = popup( pop_x, pop_y, entries, current_val );
	
	/* 
	 * D�s�lectionne objet qui a appell� le Pop-Up: 
	 */
	objc_dsel( call_form, call_obj );

	/* 
	 * Retourne no de la ligne s�lectionn�e: 
	 */
	return	selected_value;

}



/*
 * get_popup_name(-)
 *
 * Purpose:
 * --------
 * Renvoie le nom de l'option correspondant � la valeur donn�e 
 * d'apr�s un menu popup.
 *
 * History:
 * --------
 * 14.03.95: fplanque: Extracted from fix_popup_title()
 */
const char * get_popup_name( 			/* Out: Nom correspondant ou "" */
			POPUP_ENTRY *	entries, 	/* In:  Menu Pop-Up */
			int 				n_val )		/* In:  Valeur � rechercher */
{
	int	i = 0;		/* Compteur */

	/* 
	 * Cherche l'option courante: 
	 */
	while( entries[ i ] .name != NULL )
	{
		if ( entries[ i ] .value == n_val )
		{	/*
			 * Si on a trouv� l'option actuelle 
			 * Fixe nom dans titre: 
			 */
			return	entries[ i ] .name +2;	/* Saute les espaces */
		}
	
		/*
		 * Passe au suivant: 
		 */
		i++;
	}

	/*
	 * On a pas trouv�:
	 */
	return	G_empty_string;
}


/*
 * Popup_GetCurrVal(-)
 *
 * Purpose:
 * --------
 * Renvoie la valeur courament stock�e dans un menu popup
 *
 * History:
 * --------
 * 14.03.95: fplanque: Extracted from fix_popup_title()
 */
int	Popup_GetCurrVal( 
			OBJECT		*	popup_title ) 	/* In: Objet titre de Menu */
{
	/*
	 * Junk1 contient la valeur actuelle! 
	 */
	return	popup_title -> ob_spec.tedinfo -> te_junk1;
}

/*
 * fix_popup_title(-)
 *
 * Purpose:
 * --------
 * Fixe le nom de l'option courament s�lectionn�e 
 * dans le titre d'un menu Pop-Up
 *
 * Suggest:
 * --------
 * Ne pas sauver de valeur dans Junk_1
 *
 * History:
 * --------
 * 1993: fplanque: Created
 * 14.03.95: appelle get_popup_name()
 */
void	fix_popup_title( 
			OBJECT		*	popup_title, 	/* In: Objet titre de Menu */
			POPUP_ENTRY *	entries,	 		/* In: Menu Pop-Up associ� */
			int 				current_val )	/* In: Valeur � assigner au titre */
{
	const char * cpsz_Title = get_popup_name( entries, current_val );

	dlink_teptext( popup_title, cpsz_Title );	/* Saute les espaces */
	
	/* 
	 * (Autoris�?!?) Sauve la valeur courante dans Junk1: 
	 */
	(popup_title -> ob_spec.tedinfo) -> te_junk1 = current_val;
	/* printf("Junk1=%d Junk2=%d \r", (M_ed_saisie[ exit_obj ] .ob_spec.tedinfo) -> te_junk1, (M_ed_saisie[ exit_obj ] .ob_spec.tedinfo) -> te_junk2 ); */

}
