
#include <e_gem.h>
#include <string.h>
#include "example.h"

char *title = "EnhancedGEM "VERSION;
char *version = VERSION;

/* Text f�r die Beispiel-Alert-Box */

char *alert_text =  "Nat�rlich gibt es auch Alert-Boxen,|"
					"wobei diese bis zu 10 Zeilen Text|"
					"sowie 5 Buttons, welche �ber Hotkeys|"
					"bedient werden k�nnen, enthalten d�r-|"
					"fen.|"
					"Neben 18 vordefinierten Icons k�nnen|"
					"auch benutzer-definierte Icons ver-|"
					"wendet werden.";

/* Prototypen */

void CycleCloseWindow(int mode);
void OpenDialog(DIAINFO *info,OBJECT *tree,int obj,DIAINFO *parent,int dial_mode);
void CloseDialog(DIAINFO *info);
int InitMsg(EVENT *evt);
void Messag(EVENT *event);
void ExitExample(int all);

/* Hilfetext und ben�tigte Variablen/Strukturen */
extern char *help[];
extern int help_lines,line_help_h,view_help_lines;
extern USERBLK helpblk;
extern SLINFO sl_help;
boolean scroll_help;

EVENT event;

/* Zeiger auf Objektb�ume sowie DIAINFO-Strukturen f�r Dialoge */
OBJECT *dial_tree, *help_tree, *more_tree, *pop_tree, *info_tree, *menu;
DIAINFO dial_info, help_info, more_info, infodial_info, *ex_info;

POPUP pop = { &dial_info,0l,POPINFO,POPBTN,POPCYCLE,TRUE,TRUE };

/* Liste von Zeigern auf DIAINFO-Strukturen der ge�ffneten Dialoge */
DIAINFO *wins[4];
/* Anzahl der ge�ffneten Dialoge */
int win_cnt;

/***********************************************************************
 Alle Dialoge schlie�en sowie optional Beenden der Applikation
 (Men�leiste l�schen, Resource freigeben, Abmeldung bei AES und VDI)
***********************************************************************/

void ExitExample(int all)
{
	/* alle ge�ffneten Dialoge schlie�en */
	while (--win_cnt>=0)
		close_dialog(wins[win_cnt],FALSE);

	if (all)
	{
		/* Men�leiste entfernen */
		menu_bar(menu,0);
		/* Resource freigeben, Abmeldung bei AES und VDI */
		close_rsc();
		/* Programm beenden */
		exit(0);
	}

	win_cnt=0;
}

/***********************************************************************
 Resource und Objektb�ume initialsieren
***********************************************************************/

void init_resource(void)
{
/* Adressen der Objektb�ume (Dialoge,Men�s,Popups) ermitteln */

	rsrc_gaddr(R_TREE, MENU, &menu);
	rsrc_gaddr(R_TREE, INFODIA, &info_tree);
	rsrc_gaddr(R_TREE, DIALOG, &dial_tree);
	rsrc_gaddr(R_TREE, MOREDIA, &more_tree);
	rsrc_gaddr(R_TREE, HELPDIAL, &help_tree);
	rsrc_gaddr(R_TREE, POP, &pop_tree);
	pop.p_menu = pop_tree;

/* erweiterte Objekte sowie Images/Icons anpassen */

	fix_objects(menu,NO_SCALING);
	fix_objects(dial_tree,NO_SCALING);
	fix_objects(info_tree,DARK_SCALING);
	fix_objects(more_tree,NO_SCALING);
	fix_objects(help_tree,NO_SCALING);
	fix_objects(pop_tree,NO_SCALING);

/* Ikonifizierte Darstellung von Dialog-Fenstern unter MTOS */
	rsrc_gaddr(R_TREE, EGEMICON, &iconified);
/* Icon nicht skalieren */
	fix_objects(iconified,NO_SCALING);

/* Erstellungsdatum und Versionsnummer im Informations- und 
   Haupt-Dialog setzen */

	info_tree[DATE].ob_spec.tedinfo->te_ptext = __DATE__;
	strcpy(ob_get_text(info_tree,VERS,FALSE)+8,version);
	strcpy(ob_get_text(dial_tree,TITEL,FALSE)+27,version);

	{
		reg OBJECT *obj = help_tree + HELPVIEW;

		/* Hilfe-Dialog auf benutzerdefiniertes Objekt setzen */
		obj->ob_type = G_USERDEF;
		obj->ob_spec.userblk = &helpblk;

		/* Slider-Struktur und ben�tigte Variablen zur Darstellung setzen  */
		line_help_h = gr_sh<<1;
		sl_help.sl_page = view_help_lines = obj->ob_height/line_help_h;
		sl_help.sl_max = help_lines;

		/* Koordinaten des Parent-Objektes anpassen */
		obj = help_tree + HELPPAR;
		obj->ob_y++;
		obj->ob_height -= 2;

		/* Slider-Objekte initialisieren */
		graf_set_slider(&sl_help,help_tree,GRAF_SET);
	}

/* Eingabe-Felder in Hauptdialog zur�cksetzen */

	ob_get_text(dial_tree,DATEI,TRUE);
	ob_get_text(dial_tree,PFAD,TRUE);
}

/***********************************************************************
 Fensterdialog rotieren (mode==0) oder schlie�en (mode!=0) 
***********************************************************************/

void CycleCloseWindow(int mode)
{
	/* Dialog ge�ffnet ? */
	if (win_cnt>0)
	{
		reg int i,handle = FAIL;
		int top,dummy;

		/* Handle des obersten Fensters ermitteln */
		wind_get(0,WF_TOP,&top,&dummy,&dummy,&dummy);

		/* DIAINFO-Struktur des obersten Fensterdialoges suchen */
		for (i=0;i<win_cnt;i++)
			if (wins[i]->di_flag>=WINDOW && wins[i]->di_handle==top)
			{
				/* Dialog schlie�en ? */
				if (mode)
				{
					/* Falls Hauptdialog geschlossen wird, auch alle
					   anderen Dialoge schlie�en */
					if (wins[i]==&dial_info)
						ExitExample(0);
					/* ansonsten nur obersten Dialog schlie�en */
					else
						CloseDialog(wins[i]);
				}
				/* Dialog rotieren ? */
				else if (i<(win_cnt-1))
					handle = wins[i+1]->di_handle;
				else
					handle = wins[0]->di_handle;
				break;
			}

		/* Dialog nach Rotation in Vordergrund bringen */
		if (handle>0)
			wind_set(handle,WF_TOP);
	}
}

/***********************************************************************
 Dialog �ffnen und in Liste der ge�ffneten Dialoge eintragen bzw. falls
 der Dialog schon ge�ffnet ist, diesen in den Vordergrund bringen. Au�erdem
 Verwaltung der ge�ffneten Dialoge und Auswertung der Benutzeraktionen
***********************************************************************/

void OpenDialog(DIAINFO *info,OBJECT *tree,int obj,DIAINFO *parent,int dial_mode)
{
	reg int double_click,exit=win_cnt;

	/* Button in �bergeordnetem Dialog zur�cksetzen ? */
	if (parent && obj>FAIL)
	{
		/* Button deselektieren und neuzeichnen */
		ob_undostate(parent->di_tree,obj,SELECTED);
		ob_draw_chg(parent,obj,NULL,FAIL,FALSE);
	}

	switch (info->di_flag)
	{
	/* Fensterdialog bereits ge�ffnet ? */
	case WINDOW:
	case WIN_MODAL:
		/* Dialog in den Vordergrund holen */
		wind_set(info->di_handle,WF_TOP);
		break;
	/* Dialog geschlossen ? */
	case CLOSED:
		/* Dialog �ffnen (zur Mausposition, keine Grow-Boxen) und bei Erfolg
		   in Liste eintragen */
		if (open_dialog(tree,info,title,TRUE,FALSE,dial_mode))
			wins[win_cnt++]=info;
	}

	/* Waren bereits vorher Dialoge ge�ffnet ? */
	if (exit>0)
		/* Ja, also wird die Verwaltung bereits an anderer Stelle �bernommen */
		return;

	/* Verwaltung der ge�ffneten Dialoge und Auswertung der Benutzeraktionen */

	/* Solange Dialog ge�ffnet, Schleife wiederholen */
	while (win_cnt>0)
	{
		/* Auf Benutzeraktionen warten
		   exit -> angew�hltes Objekt (Bit 15 = Doppelklick)
		   ex_info -> Zeiger auf DIAINFO-Struktur des angew�hlten Dialogs
	    */
		exit = X_Form_Do(&ex_info, 0, InitMsg, Messag);

		/* Fenster-Closer */
		if (exit == W_CLOSED)
			/* Dialog schlie�en */
			CloseDialog(ex_info);
		/* Dialog wurde geschlossen, aber kein Objekt angew�hlt
		   (z.B. durch AC_CLOSE) */
		else if (exit == W_ABANDON)
			ExitExample(0);
		else
		{
			/* Doppelklick erfassen und aus Wert f�r Exit-Objekt ausmaskieren */
			exit ^= (double_click = exit & 0x8000);

			/* Exit-Objekt selektiert? */
			if (ob_isstate(ex_info->di_tree,exit,SELECTED))
			{
				/* angew�hltes Objekt deselektieren und neu zeichnen */
				ob_undostate(ex_info->di_tree,exit,SELECTED);
				ob_draw_chg(ex_info,exit,NULL,FAIL,FALSE);
			}

			/* Haupt-Dialog */
			if (ex_info==&dial_info)
			{
				switch (exit)
				{
				/* Popup-Infotext/-button/-cycleobjekt angew�hlt */
				case POPINFO:
				case POPBTN:
				case POPCYCLE:
					/* Falls Cycle-Objekt angew�hlt wurde oder das Popup-Men�
					   mit Alternate-Shift-Hotkey aufgerufen wurde, n�chsten
					   Eintrag ermitteln, ansonsten Popup aufrufen */
					Popup(&pop,(exit==POPCYCLE || double_click) ? POPUP_CYCLE_CHK : POPUP_BTN_CHK,
						  OBJPOS,0,0,NULL,FAIL);
					break;
				/* Hilfe-Button -> Hilfe-Dialog �ffnen */
				case HELP:
					OpenDialog(&help_info,help_tree,exit,ex_info,AUTO_DIAL);
					break;
				/* Mehr-Button -> Sonstiges-Dialog �ffnen */
				case MORE:
					OpenDialog(&more_info,more_tree,exit,ex_info,AUTO_DIAL);
					break;
				/* Info-Button -> Informations-Dialog �ffnen */
				case INFOBTN:
					OpenDialog(&infodial_info,info_tree,exit,ex_info,AUTO_DIAL|MODAL);
					break;
				/* Suchen-Button -> Alert-Box �ffnen
				   -> alle m�glichen Icons nacheinander */
				case SEARCH:
					{
						static int icon = 0;
						if (xalert(3,1,icon++,NULL,title,alert_text,"[Abbruch|Gibt's [mehr?|[Ok",InitMsg,Messag)==1)
							xalert(1,0,X_ICN_STOP,NULL,title,"Leider (noch) nicht!","[Pech",InitMsg,Messag);
					}
					break;
				/* Ansonsten Dialog schlie�en */
				default:
					CloseDialog(ex_info);
				}
			}
			/* Hilfe-Dialog */
			else if (ex_info==&help_info)
			{
				/* Slider-Objekt angew�hlt */
				if (exit!=HELPOK)
				{
					scroll_help = TRUE;
					graf_rt_slidebox(&sl_help,exit);
					scroll_help = FALSE;
				}
				/* ansonsten Dialog schlie�en */
				else
					CloseDialog(ex_info);
			}
			/* andere Dialoge schlie�en */
			else
				CloseDialog(ex_info);
		}
	}
}

/***********************************************************************
 Dialog schlie�en und aus Liste der ge�ffneten Dialoge entfernen
***********************************************************************/

void CloseDialog(DIAINFO *info)
{
	/* Dialog ge�ffnet ? */
	if (info->di_flag>CLOSED)
	{
		int i;

		/* Dialog schlie�en ohne Shrink-Box */
		close_dialog(info,FALSE);

		/* Dialog in Liste suchen und entfernen */
		for (i=0;i<win_cnt;i++)
			if (wins[i]==info)
				break;

		for (win_cnt--;i<win_cnt;i++)
			wins[i] = wins[i+1];
	}
}

/***********************************************************************
 Initialisierungs-Routine, welche von X_Form_Do aufgerufen wird und
 die Event-Struktur setzt sowie die Ereignisse, die von der Applikation
 ben�tigt werden, zur�ckgibt
***********************************************************************/

int InitMsg(EVENT *evt)
{
	/* Nachrichten und Tastendr�cke auswerten */
	evt->ev_mflags |= MU_MESAG|MU_KEYBD;
	return (MU_MESAG|MU_KEYBD);
}

/***********************************************************************
 Ereignisauswertung (AES-Nachrichten und Tastendr�cke), welche sowohl
 von der Hauptschleife in der Funktion main() als auch von X_Form_Do()
 aufgerufen wird
***********************************************************************/

void Messag(EVENT *event)
{
	reg int ev = event->ev_mwich,*msg = event->ev_mmgpbuf;

	/* Nachricht vom AES ? */
	if (ev & MU_MESAG)
	{
		switch (*msg)
		{
		/* Men�eintrag angeklickt ? */
		case MN_SELECTED:
			/* Men�eintrag deselektieren */
			menu_tnormal(menu,msg[3],1);
			switch (msg[4])
			{
			/* Infodialog �ffnen */
			case INFOBOX:
				OpenDialog(&infodial_info,info_tree,0,NULL,FLY_DIAL);
				break;
			/* Applikation beenden */
			case QUIT:
				ExitExample(1);
				break;
			/* Hauptdialog �ffnen */
			case OPEN:
				OpenDialog(&dial_info,dial_tree,0,NULL,AUTO_DIAL);
				break;
			/* Fenster wechseln/schlie�en */
			case CYCLE:
			case CLOSE:
				CycleCloseWindow(msg[4]==CLOSE);
				break;
			/* Hilfedialog �ffnen */
			case HELPMENU:
				OpenDialog(&help_info,help_tree,0,NULL,AUTO_DIAL);
				break;
			}
			break;
		/* Applikation beenden/r�cksetzen */
		case AP_TERM:
		case AC_CLOSE:
			ExitExample(0);
			break;
		/* Accessory �ffnen (Hauptdialog �ffnen) */
		case AC_OPEN:
			OpenDialog(&dial_info,dial_tree,0,NULL,AUTO_DIAL);
			return;
		}
	}

	/* Tastatur-Ereignis und Control-Taste gedr�ckt ? */
	if ((ev & MU_KEYBD) && (event->ev_mmokstate & K_CTRL))
	{
		switch (scan_2_ascii(event->ev_mkreturn,event->ev_mmokstate))
		{
		/* 'I' -> Infodialog �ffnen */
		case 'I':
			OpenDialog(&infodial_info,info_tree,0,NULL,FLY_DIAL);
			break;
		/* 'Q' -> Applikation beenden */
		case 'Q':
			ExitExample(1);
			break;
		/* 'O' -> Hauptdialog �ffnen */
		case 'O':
			OpenDialog(&dial_info,dial_tree,0,NULL,AUTO_DIAL);
			break;
		/* 'W' -> Fenster wechseln */
		case 'W':
			CycleCloseWindow(FALSE);
			break;
		/* 'U' -> Fenster schlie�en */
		case 'U':
			CycleCloseWindow(TRUE);
			break;
		/* 'H' -> Hilfedialog �ffnen */
		case 'H':
			OpenDialog(&help_info,help_tree,0,NULL,AUTO_DIAL);
		}
	}
}

void main()
{
	/* Resource-File laden und Bibliothek sowie AES und VDI initialisieren */
	switch (open_rsc("EXAMPLE.RSC",""))
	{
		/* Resource-Datei konnte nicht geladen werden */
		case FAIL:
			form_alert(1, "[3][EXAMPLE.RSC not found!][Cancel]");
			break;
		/* Fehler w�hrend der Inititialisierung von AES/VDI */
		case FALSE:
			form_alert(1, "[3][Couldn't open|workstation!][Cancel]");
			break;
		case TRUE:
		{
			/* wind_update(BEG_UPDATE/END_UPDATE)-Klammerung f�r Accessories
			   w�hrend der Initialisierung */
			wind_update(BEG_UPDATE);

			/* Resource (Objektb�ume) initialisieren */
			init_resource();

			/* Hintergrundbedienung von Fensterdialogen sowie Fliegen mit nicht-
			   selektierbaren Objekten ausschalten */
			dial_options(TRUE,TRUE,FALSE,TRUE,TRUE,FALSE,FALSE,FALSE);

			wind_update(END_UPDATE);			

			/* Falls Applikation als Programm gestartet, Pull-Down-Men� zeichnen
			   und Hauptdialog �ffnen */
			if (_app)
			{
				menu_bar(menu,1);
				OpenDialog(&dial_info,dial_tree,0,NULL,AUTO_DIAL);
			}

            /* Auf Ereignis (Nachrichten/Tastendr�cke) warten und dieses auswerten */
			event.ev_mflags	= MU_MESAG|MU_KEYBD;

			for (;;)
			{
				EvntMulti(&event);
				Messag(&event);
			}
		}
	}

	/* Accessories enden nie */
	if (!_app)
		for (;;) evnt_timer(0,32000);
}
