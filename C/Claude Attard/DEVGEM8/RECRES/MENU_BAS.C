#include <stdio.h>
#include <stdlib.h>
#include <aes.h>
#include "menu.h"
int id;
void main (void);
void main (void)
{
int i = 4, evnt, d, buf[8], quit = 0, yb, hb;
OBJECT *adr;

	id = appl_init ();
	rsrc_load ("MENU.RSC");
	rsrc_gaddr (R_TREE, MENUBAR, &adr);
	wind_get (0, WF_WORKXYWH, &d, &yb, &d, &hb);	/* Coordonn�es du bureau */
	adr[1].ob_y = (yb + hb) - adr[2].ob_height;
	do
	{
		if (adr[i].ob_type == G_BOX)
			adr[i].ob_y = hb - adr[2].ob_height - adr[i].ob_height;
	} while (! (adr[i++].ob_flags & LASTOB));

	menu_bar (adr, 1);
	graf_mouse (0, 0);
	do
	{
		evnt = evnt_multi ((MU_MESAG|MU_TIMER), 0, 0,
                0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0,
                buf, 10, 0,
                &d, &d, &d, &d, &d, &d);
		if (evnt & MU_MESAG)
			if (buf[0] == MN_SELECTED)
				quit = 1;
  } while (quit != 1);
  menu_bar (adr, 0);
  appl_exit ();
}

