	/* Les includes de mani�re � disposer des fonctions syst�mes */
#include "tos.h"
#include "vdi.h"
#include "aes.h"
#include "float.h"
#include "math.h"
	/* J'en mets trop, c'est fait expr�s. */

	/* Maintenant je d�clare mes fonctions */
void main (void);				/* D�clarer main() est facultatif, je le fais */
void fonction1 (int a);	/* Fonction acceptant 1 param�tre de type int */
long discriminant (double a, double b, double c);

	/* Variables globales */
int mouse_x, mouse_y;		/* On peut d�clarer plusieurs var d'un meme type d'un coup */
float a, b;							/* Ce que vous voulez */

	/* Corps des fonctions */
void main (void)			/* R�p�tition du prototype sans ; */
{
	int var_locale1;
	long dis;
	
	dis = discriminant (1.2, 2.3, 4.5);
	
	Pterm (0);
}

void fonction1 (int a)
{
	/* Cette fonction ne fait rien, remarquez simplement
		qu'un param�tre est juste une variable initialis�e
		� une certaine valeur mais on peut la modifier.
		Passez au d�bugger pour voir. */
	a = a + 1;
}

void discriminant (double a, double b, double c)
{
	double dis;			/* Variable locale */
	
	dis = b * b - 4 * a * c;
	
	return dis;			/* Renvoie une valeur et quitte la fonction. */
}
