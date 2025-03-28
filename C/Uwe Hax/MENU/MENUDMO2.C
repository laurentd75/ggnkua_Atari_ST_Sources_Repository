/******************************************************************************/
/*                           Men�demo II V3.02                                */
/*                   - Jedem Fenster seine Men�leiste -                       */
/*                          (C) 1990 by Uwe Hax                               */
/******************************************************************************/

#include <gemdefs.h>
#include <obdefs.h>
#include <osbind.h>
#include <portab.h>

#include "menudmo2.h"

#define DESKTOP 0

WORD contrl[12];
WORD intin[128];
WORD ptsin[128];
WORD intout[128];
WORD ptsout[128];
WORD int_in[11];
WORD int_out[57];

WORD dummy;

FDB memory,screen;                   /* zum Sichern der Men�zeile als Grafik */
WORD vdi_handle;                     /* Handle f�r VDI-Routinen              */
WORD w1_handle,w2_handle;            /* Fenster-Kennungen                    */
LONG adr1,adr2;                      /* Speicheradressen f�r Grafik          */

main()
{
  OBJECT *menu;                      /* Zeiger auf den Men�baum              */
  OBJECT *about;                     /* Zeiger auf die Info-Box              */
  REG WORD mesg_buff[8];             /* Message-Buffer                       */
  WORD x_desk,y_desk,w_desk,h_desk;  /* Koordinaten und Gr��e des Desktop    */
  REG WORD ende=FALSE;               /* Programmende                         */
  WORD x,y,w,h;                      /* Koordinaten f�r Dialogbox            */

  /* Programm anmelden */
  appl_init();
  vdi_handle=graf_handle(&dummy,&dummy,&dummy,&dummy);
  open_vwork();
  hide_mouse();

  /* Resource-File mit Men�zeile und Info-Box laden */
  if (!rsrc_load("menudmo2.rsc"))
  {
    form_alert(1,"[3][MENUDMO2.RSC nicht gefunden!][ Abbruch ]");
    appl_exit();
    exit();
  }
  rsrc_gaddr(R_TREE,MENU,&menu);
  rsrc_gaddr(R_TREE,DABOUT,&about);

  /* Fenster 1 erzeugen und �ffnen */
  wind_get(DESKTOP,WF_WORKXYWH,&x_desk,&y_desk,&w_desk,&h_desk);
  w1_handle=wind_create(NAME | CLOSER | MOVER | SIZER,
                        x_desk,y_desk,w_desk,h_desk);
  wind_set(w1_handle,WF_NAME," Fenster 1 mit Men�leiste ",0,0);
  wind_open(w1_handle,50,50,400,200);  /* Fenstergr��e f�r h�chste Aufl�sung */

  /* Men�zeile in Fenster 1 installieren */
  install_menu(w1_handle,menu,0,0,0,0);

  /* Fenster 1 mit Inhalt f�llen */
  fill_window(w1_handle,menu);

  /* Fenster 2 erzeugen und �ffnen */
  w2_handle=wind_create(NAME | CLOSER | MOVER | SIZER,
                        x_desk,y_desk,w_desk,h_desk);
  wind_set(w2_handle,WF_NAME," Fenster 2 mit Men�leiste ",0,0);
  wind_open(w2_handle,100,100,500,250); /* Fenstergr��e f�r h�chste Aufl�sung */

  /* Men�zeile in Fenster 2 installieren */
  install_menu(w2_handle,menu,0,0,0,0);

  /* Fenster 2 mit Inhalt f�llen */
  fill_window(w2_handle,menu);

  graf_mouse(ARROW,&dummy);
  show_mouse();

  /* Nachrichten verarbeiten, bis Programm beendet wird */
  do
  {
    evnt_mesag(mesg_buff);

    hide_mouse();
    wind_update(BEG_UPDATE);

    switch (mesg_buff[0])
    {
      case WM_REDRAW:    /* Fenster neuzeichnen */
                         redraw(mesg_buff[3],menu,mesg_buff[4],
                                mesg_buff[5],mesg_buff[6],mesg_buff[7]);
                         break;

      case WM_MOVED:     /* Fenster auf neue Koordinaten setzen */
                         wind_set(mesg_buff[3],WF_CURRXYWH,mesg_buff[4],
                                  mesg_buff[5],mesg_buff[6],mesg_buff[7]);

                         /* ACHTUNG: kein BREAK!! */
                         /* die folgenden Routinen m�ssen auch noch
                            ausgef�hrt werden: */

      case WM_SIZED:    /* Men�zeile anpassen und... */
                         install_menu(mesg_buff[3],menu,mesg_buff[4],
                                      mesg_buff[5],mesg_buff[6],mesg_buff[7]);

                         /* ...Fenster neu ausf�llen */
                         fill_window(mesg_buff[3],menu);

                         break;

      case WM_TOPPED:    /* Fenster in den Vordergrund bringen */
                         wind_set(mesg_buff[3],WF_TOP,0,0,0,0);

                         /* und Men�zeile installieren */
                         install_menu(mesg_buff[3],menu,0,0,0,0);
                         break;

      case WM_CLOSED:    /* Programmende */
                         ende=TRUE;
                         break;

      case MN_SELECTED:  /* Men�eintrag wurde angew�hlt */
                         if (mesg_buff[4]==ABOUT)
                         {
                           /* Info-Box zeichnen und wieder beenden */
                           about[OK].ob_state &= ~SELECTED;
                           form_center(about,&x,&y,&w,&h);
                           form_dial(FMD_START,x,y,w,h,x,y,w,h);
                           objc_draw(about,ROOT,MAX_DEPTH,x,y,w,h);
                           show_mouse();
                           form_do(about,0);
                           hide_mouse();
                           form_dial(FMD_FINISH,x,y,w,h,x,y,w,h);
                         }
                         /* Men�titel wieder zur�cksetzen */
                         menu_tnormal(menu,mesg_buff[3],TRUE);
                         break;
    }

    wind_update(END_UPDATE);
    show_mouse();
  }
  while (!ende);

  /* Fenster schlie�en und l�schen */
  wind_close(w1_handle);
  wind_close(w2_handle);
  wind_delete(w1_handle);
  wind_delete(w2_handle);

  /* Men�zeile entfernen und Programm verlassen */
  menu_bar(menu,FALSE);
  Mfree(adr1);
  Mfree(adr2);
  v_clsvwk(vdi_handle);
  appl_exit();
}


install_menu(w_handle,menu,x,y,width,height)
REG WORD w_handle;                   /* Fenster-Kennung                      */
REG OBJECT *menu;                    /* Adresse der Men�leiste               */
WORD x,y,width,height;               /* neue Gr��e des Fensters; enthalten
                                        alle Werte 0, wird die augenblick-
                                        liche Gr��e und Position beibehalten */
{
  WORD wx,wy,ww,wh;                  /* Koordinaten des Arbeitsbereiches     */
  WORD cx,cy,cw,ch;                  /* Koordinaten der Fenster-Gesamtgr��e  */
  WORD x_desk,y_desk,w_desk,h_desk;  /* Bildschirmausma�e                    */
  REG WORD index1,index2;            /* Men�-Indices                         */
  REG WORD array[8];                 /* Eingabefeld f�r diverse Routinen     */
  WORD m_width;                      /* Men�-Breite                          */
  WORD resolution;                   /* Aufl�sung                            */
  WORD rows,cols;                    /* Bildschirmgr��e                      */
  WORD tail=menu[0].ob_tail;         /* diverse Abk�rzungen                  */
  WORD tail2=menu[tail].ob_head;
  WORD head=menu[0].ob_head;
  WORD head2=menu[head].ob_head;
  WORD temp1,temp2;

  static WORD first=TRUE;            /* erster Aufruf dieser Funktion?       */

  /* Gr��e des Arbeitsbereiches und Gesamtgr��e des Fensters ermitteln */
  wind_get(w_handle,WF_WORKXYWH,&wx,&wy,&ww,&wh);
  wind_get(w_handle,WF_CURRXYWH,&cx,&cy,&cw,&ch);

  /* sind alle �bergebenen Werte Null, wird die augenblickliche Gr��e und
     Position beibehalten */
  if (!x && !y && !width && !height)
  {
    x=cx;
    y=cy;
    width=cw;
    height=ch;
  }

  /* Minimalh�he und -breite: willk�rlich gew�hlt */
  if (height<60)
    height=60;
  if (width<100)
    width=100;

  /* neue Fenstergr��e setzen */
  wind_set(w_handle,WF_CURRXYWH,x,y,width,height);

  /* neue Position der Men�zeile */
  menu[0].ob_x=x+1;
  menu[0].ob_y=y+(ch-wh)/2;     /* "/2" entf�llt, falls das Fenster keine
                                   untere Leiste enth�lt */

  /* geht die Men�zeile �ber das Bildschirmende hinaus? */
  wind_get(DESKTOP,WF_WORKXYWH,&x_desk,&y_desk,&w_desk,&h_desk);
  if (menu[0].ob_x+width-cw+ww>x_desk+w_desk)
    width=x_desk+w_desk-menu[0].ob_x+cw-ww-1; /* Breite nur bis Bildschirmende */

  /* Breite der Men�zeile = Breite des Fensters bzw. bis Bildschirmende */
  menu[head].ob_width=width-cw+ww;

  index1=menu[head2].ob_head;
  index2=tail2;
  menu[head2].ob_width=0 ;
  while (menu[index1].ob_type==G_TITLE)
  {
    /* Breite des Men�titels */
    temp1=menu[0].ob_x+menu[head].ob_x+menu[head2].ob_x+menu[index1].ob_x+
          menu[index1].ob_width;

    /* Breite des Men�s */
    temp2=menu[0].ob_x+menu[tail].ob_x+menu[index2].ob_x+menu[index2].ob_width;

    /* welche Men�s passen noch auf den Bildschirm bzw. ins Fenster? */
    if ((temp1>=x_desk+w_desk) || (temp2>=x_desk+w_desk) ||
        (temp1>=x+width-cw+ww) || (temp2>=x+width-cw+ww))
    {
      /* alle nicht mehr auf den Bildschirm passenden Men�s abschalten */
      while (menu[index1].ob_type==G_TITLE)
      {
        menu[index1].ob_flags=HIDETREE;
        index1=menu[index1].ob_next;
      }
      break;
    }
    else
    {
      /* Breite der Men�zeile anpassen */
      menu[head2].ob_width=menu[index1].ob_x+menu[index1].ob_width;

      /* Men� eingeschaltet */
      menu[index1].ob_flags=NONE;

      index1=menu[index1].ob_next;
      index2=menu[index2].ob_next;
    }
  }

  /* modifizierte Men�zeile installieren */
  menu_bar(menu,TRUE);

  if (first)    /* erster Aufruf dieser Funktion? */
  {
    /* Breite des Bildschirms = maximale L�nge der Men�zeile */
    vq_chcells(vdi_handle,&rows,&cols);

    adr1=Malloc((LONG)(++cols*(menu[head].ob_height+2))); /* maximale Gr��e  */
    adr2=Malloc((LONG)(cols*(menu[head].ob_height+2)));

    /* sonstige Initialisierungen f�r vro_cpyfm */
    resolution=Getrez();
    screen.fd_addr=0L;
    memory.fd_stand=0;
    memory.fd_nplanes=resolution ? 2/resolution : 4;

    first=FALSE;
  }

  /* Men�zeile als Grafik f�r Redraw sichern: */
  /* Quell-Koordinaten */
  array[0]=menu[0].ob_x+menu[head].ob_x;
  array[1]=menu[0].ob_y+menu[head].ob_y;
  array[2]=array[0]+menu[head].ob_width-1;
  array[3]=array[1]+menu[head].ob_height-1;

  /* Zielkoordinaten */
  array[4]=0;
  array[5]=0;
  array[6]=menu[head].ob_width-1;
  array[7]=menu[head].ob_height-1;

  /* sonstige jedesmal notwendige Initialisierungen */
  memory.fd_addr=(w_handle==w1_handle) ? adr1 : adr2;
  memory.fd_wdwidth=array[6]/16+1;
  vro_cpyfm(vdi_handle,3,array,&screen,&memory);
}


fill_window(w_handle,menu)
REG WORD w_handle;                   /* Fenster-Kennung                      */
OBJECT *menu;                        /* Adresse der Men�zeile                */
{
  REG WORD array[4];                 /* Eingabefeld f�r diverse Routinen     */
  WORD wx,wy,ww,wh;                  /* Koordinaten des Arbeitsbereichs      */
  WORD head=menu[0].ob_head;         /* als Abk�rzung                        */

  /* Gr��e des Arbeitsbereiches des Fensters ermitteln */
  wind_get(w_handle,WF_WORKXYWH,&wx,&wy,&ww,&wh);

  /* Fenster und Hintergrund der Men�zeile mit wei�er Fl�che f�llen */
  vsf_color(vdi_handle,0);
  array[0]=wx;
  array[1]=wy+menu[head].ob_height+1;
  array[2]=wx+ww-1;
  array[3]=wy+wh-1;
  vr_recfl(vdi_handle,array);

  /* Linie unter der Men�zeile zeichnen */
  array[0]=wx;
  array[1]=array[3]=wy+menu[head].ob_height;
  array[2]=wx+ww-1;
  vsf_color(vdi_handle,1);
  v_pline(vdi_handle,2,array);
}


redraw(w_handle,menu,x,y,width,height)
REG WORD w_handle;               /* Fenster-Kennung                          */
REG WORD x,y,width,height;       /* Koordinaten des zu erneuernden Bereiches */
OBJECT *menu;                    /* Adresse der Men�zeile                    */
{
  GRECT rect1,rect2;             /* Strukturen f�r Rechteck-Koordinaten      */
  WORD array[8];                 /* Eingabefeld f�r diverse Routinen         */
  WORD wx,wy,ww,wh;              /* Koordinaten des Arbeitsbereiches         */
  WORD head=menu[0].ob_head;     /* als Abk�rzung                            */
  WORD x_desk,y_desk,w_desk,h_desk; /* Bildschirmgr��e                       */

  rect2.g_x=x;                   /* Redraw-Rechteck initialisieren           */
  rect2.g_y=y;
  rect2.g_w=width;
  rect2.g_h=height;

  /* Koordinaten und Gr��e des Arbeitsbereiches ermitteln */
  wind_get(w_handle,WF_WORKXYWH,&wx,&wy,&ww,&wh);

  /* Bildschirmgr��e ermitteln... */
  wind_get(DESKTOP,WF_WORKXYWH,&x_desk,&y_desk,&w_desk,&h_desk);

  /* ...und damit Breite f�r vro_cpyfm anpassen */
  if (wx+ww>x_desk+w_desk)
    ww=x_desk+w_desk-wx;

  /* Koordinaten und Gr��e des ersten neu zu zeichnenden Rechtecks aus
     der Rechteck-Liste holen */
  wind_get(w_handle,WF_FIRSTXYWH,&rect1.g_x,&rect1.g_y,&rect1.g_w,&rect1.g_h);

  while (rect1.g_w && rect1.g_h)  /* fertig? */
  {
    /* �berlappen sich beide Rechtecke? */
    if (rc_intersect(&rect2,&rect1))
    {
      /* Clip-Koordinaten setzen */
      array[0]=rect1.g_x;
      array[1]=rect1.g_y;
      array[2]=rect1.g_x+rect1.g_w-1;
      array[3]=rect1.g_y+rect1.g_h-1;
      vs_clip(vdi_handle,TRUE,array);

      /* Fenster-Inhalt neu zeichnen */
      fill_window(w_handle,menu);

      /* Grafik der Men�zeile neu zeichnen */
      /* Quellkoordinaten */
      array[0]=0;
      array[1]=0;
      array[2]=ww-1;
      array[3]=menu[head].ob_height-1;

      /* Zielkoordinaten */
      array[4]=wx;
      array[5]=wy;
      array[6]=wx+array[2];
      array[7]=wy+array[3];

      /* sonstige jedesmal notwendige Initialisierungen */
      memory.fd_addr=(w_handle==w1_handle) ? adr1 : adr2;
      memory.fd_wdwidth=array[2]/16+1;

      /* alle anderen Parameter sind bereits gesetzt */
      vro_cpyfm(vdi_handle,3,array,&memory,&screen);
    }

    /* Koordinaten und Gr��e des n�chsten Rechtecks aus der Rechteck-
       Liste holen */
    wind_get(w_handle,WF_NEXTXYWH,&rect1.g_x,&rect1.g_y,&rect1.g_w,&rect1.g_h);
  }
}


open_vwork()      /* Virtuelle Workstation einrichten */
{
  REG WORD i;

  for (i=1; i<10; i++)
    int_in[i]=1;
  int_in[10]=2;
  v_opnvwk(int_in,&vdi_handle,int_out);
}


hide_mouse()       /* Maus ausschalten */
{
  graf_mouse(M_OFF,&dummy);
}


show_mouse()       /* Maus einschalten */
{
  graf_mouse(M_ON,&dummy);
}


