#include <string.h>
#include "..\tools\gwindows.h"

#include     "defs.h"
#include "vtoolbar.h"
#include "gstenv.h"

GEM_WINDOW* WndToolBar ;
OBJECT*     adr_icones ;

static void OnMoveVToolBar(void *w, int xywh[4])
{
  GEM_WINDOW* wnd = (GEM_WINDOW*) w ;
  int        xt, yt, dummy ;

  GWOnMove( wnd, xywh ) ;
  wind_get( wnd->window_handle, WF_WORKXYWH, &xt, &yt, &dummy, &dummy) ;
  adr_icones[0].ob_x = xt ;
  adr_icones[0].ob_y = yt ;
}

static int OnCloseVToolBar(void *wnd)
{
  GWShowWindow( (GEM_WINDOW*)wnd, 0 ) ;
 
  return GW_EVTCONTINUEROUTING ;
}

void draw_zoombox(int xclip, int yclip, int wclip, int hclip)
{
  objc_draw(adr_icones, ZOOM_BOX, 5, xclip, yclip, wclip, hclip) ;
}

void OnDrawVToolBar(void *wd, int xywh[4])
{
  GEM_WINDOW* wnd = (GEM_WINDOW*) wd ;
  int        xy[4] ;
  int        xyc[4] ;
  int        x, y, w, h ;
  int        xt, yt ;
  int        dummy, i ;
  
  x = xywh[0] ; y = xywh[1] ;
  w = xywh[2] ; h = xywh[3] ;
  wind_get( wnd->window_handle, WF_WORKXYWH, &xt, &yt, &dummy, &dummy ) ;
  adr_icones[0].ob_x = xt ;
  adr_icones[0].ob_y = yt ;
  for ( i = 1; i <= ZOOM_BOX; i++ )
  {
    objc_offset( adr_icones, i, &xy[0], &xy[1] ) ;
    xy[2] = adr_icones[i].ob_width ;
    xy[3] = adr_icones[i].ob_height ;
    if ( intersect( x, y, w, h, xy[0], xy[1], xy[2], xy[3], xyc ) )
    {
      if ( i == PALETTE )
      {
        vswr_mode(handle, MD_REPLACE) ;
        vsf_color(handle, ftype.color) ;
        vsf_interior(handle, FIS_SOLID) ;
        vsf_perimeter(handle, 1) ;
        vr_recfl( handle, xyc ) ;
      }
      objc_draw( adr_icones, i, 5, xyc[0], xyc[1], xyc[2]-xyc[0]+1, xyc[3]-xyc[1]+1 ) ;
    }
  }
}

void VToolsPut(char high_res)
{
  if ( high_res )
  {
    adr_icones[POINT].ob_y         = adr_icones[TRACE].ob_y     = 0 ;
    adr_icones[PINCEAU].ob_y       = adr_icones[AEROSOL].ob_y   = 24 ;
    adr_icones[KLIGNE].ob_y        = adr_icones[LIGNE].ob_y     = 48 ;
    adr_icones[CERCLE].ob_y        = adr_icones[RECTANGLE].ob_y = 72 ;
    adr_icones[DISQUE].ob_y        = adr_icones[PLAN].ob_y      = 96 ;
    adr_icones[PEINTURE].ob_y      = adr_icones[GOMME].ob_y     = 120 ;
    adr_icones[TEXTE].ob_y         = adr_icones[LOUPE].ob_y     = 144 ;
    adr_icones[TEMPERATURE].ob_y   = adr_icones[TABLEAU].ob_y   = 168 ;
    adr_icones[MAIN].ob_y          = adr_icones[BLOC].ob_y      = 192 ;
    adr_icones[PALETTE].ob_y       = 216 ;
    adr_icones[ZOOM_BOX].ob_y      = 240 ;
    adr_icones[ZOOM_BOX].ob_height = 48 ;
    adr_icones[0].ob_height        = 288 ;
  }
  else if ( aspectratio < 0.99 )
  {
    adr_icones[TRACE].ob_y = adr_icones[AEROSOL].ob_y   = 24 ;
    adr_icones[LIGNE].ob_y = adr_icones[RECTANGLE].ob_y = 24 ;
    adr_icones[PLAN].ob_y  = adr_icones[GOMME].ob_y     = 24 ;
    adr_icones[LOUPE].ob_y = adr_icones[TABLEAU].ob_y   = 24 ;
    adr_icones[BLOC].ob_y  = adr_icones[ZOOM_BOX].ob_y  = 24 ;
    adr_icones[ZOOM_BOX].ob_height = 24 ;
    adr_icones[0].ob_height        = 48 ;
  }
}

void VToolBarShow(int show)
{
  int dummy, largeur, hauteur ;

  largeur = adr_icones[0].ob_width ;
  hauteur = adr_icones[0].ob_height ;
  WndToolBar->vx = xdesk ;
  WndToolBar->vy = ydesk ;
  wind_calc( WC_BORDER, WndToolBar->window_kind, xdesk+32, ydesk+32, largeur, hauteur,
             &dummy, &dummy, &WndToolBar->vw, &WndToolBar->vh ) ;
  if ( show ) config.flags |= FLG_TOOLBAR ;
  else        config.flags &= ~FLG_TOOLBAR ;

  GWShowWindow( WndToolBar, show ) ;
  GWSetWindowCaption( WndToolBar, MsgTxtGetMsg(hMsg, MSG_TITREOUTIL)  ) ;
}

static int OnToppedVToolBar(void *wd)
{
  GEM_WINDOW* wnd = (GEM_WINDOW*) wd ;
  EVENT      *event = &GemApp.Event ;
  int        x, y ,w, h ;

  wnd->GetWorkXYWH( wnd, &x, &y, &w, &h ) ;
  if ( (event->ev_mmox >= x) && (event->ev_mmox <= x+w-1) && (event->ev_mmoy >= y) && (event->ev_mmoy <= y+h-1) )
  {
    if ( Kbshift(-1) & 0x00000008L ) param_icon( event->ev_mmox, event->ev_mmoy ) ;
    else                             select_icon( event->ev_mmox, event->ev_mmoy ) ;
  }

  return 1 ; /* Refus du focus */
  /* Si on clique sur un outil et que la touche ALT est appuy�e, */
  /* On affiche alors la boite de param�trage de l'outil cliqu�  */
  /* (Si le lien a un sens) et on ne s�lectionne pas l'outil     */
}

#pragma warn -par
static int OnLButtonDownVToolBar(void *w, int mk_state, int x, int y)
{
  GEM_WINDOW* wnd = w ;
  int wx, wy, dummy ;

  wnd->GetWorkXYWH( wnd, &wx, &wy, &dummy, &dummy ) ;
  x += wx ;
  y += wy ;
  if ( Kbshift( -1 ) == 0x00000008L ) param_icon( x, y ) ;
  else                                select_icon( x, y ) ;
 
  return 0 ;
  /* Si on clique sur un outil et que la touche ALT est appuy�e,   */
  /* On affiche alors la boite de param�trage de l'outil cliqu�    */
  /* (Si le lien a un sens) et on ne s�lectionne pas l'outil.      */
  /* NB : on n'utilise pas la variable de retour event.ev_mmkstate */
  /*      du evnt_multi car cet �v�nement peut �galement provenir  */
  /*      d'un �v�nement GEM TOPPED car la fen�tre Outils n'est    */
  /*      pas en g�n�ral la fen�tre active.                        */
}

static int OnRButtonDownVToolBar(void *w, int mk_state, int x, int y)
{
  GEM_WINDOW* wnd = w ;
  int wx, wy, dummy ;

  wnd->GetWorkXYWH( wnd, &wx, &wy, &dummy, &dummy ) ;
  x += wx ;
  y += wy ;
  param_icon( x, y ) ;

  return 0 ;
}
#pragma warn +par

#pragma warn -par
static int OnTxtBubbleVToolBar(void* wnd, int mx, int my, char* txt)
{
  int obj = objc_find( adr_icones, 0, MAX_DEPTH, mx, my ) ;
  int objs[] = { POINT, TRACE, PINCEAU, AEROSOL, KLIGNE, LIGNE, CERCLE, RECTANGLE, DISQUE, PLAN, PEINTURE, GOMME, TEXTE, LOUPE, TEMPERATURE, TABLEAU, MAIN, BLOC, PALETTE, ZOOM_IN, ZOOM_VUE, ZOOM_BOX } ;
  int msgs[] = { MSG_HPOINT, MSG_HTRACE, MSG_HPINCEAU, MSG_HAEROSOL, MSG_HKLIGNES, MSG_HLIGNE, MSG_HCERCLE, MSG_HRECTANGLE, MSG_HDISQUE, MSG_HPLAN, MSG_HPEINTURE, MSG_HGOMME, MSG_HTEXTE, MSG_HLOUPE, 
                 MSG_HTEMP, MSG_HTABLEAU, MSG_HMAIN, MSG_HBLOC, MSG_HPALETTE, MSG_HZONE, MSG_HZONE, MSG_HZONE} ;

  return( vget_txtbubblemsg( obj, objs, msgs, ARRAY_SIZE(objs), txt ) ) ;
}
#pragma warn +par

void VToolBarInit(char high_res)
{
  Xrsrc_gaddr( R_TREE, CICONES, &adr_icones ) ;
  VToolsPut( high_res ) ;

  WndToolBar = GWCreateWindow( NAME | MOVER | CLOSER, 0, VTOOLBAR_CLASSNAME ) ;
  if ( WndToolBar )
  {
    WndToolBar->OnMove        = OnMoveVToolBar ;
    WndToolBar->OnDraw        = OnDrawVToolBar ;
    WndToolBar->OnTopped      = OnToppedVToolBar ;
    WndToolBar->OnClose       = OnCloseVToolBar ;
    WndToolBar->OnLButtonDown = OnLButtonDownVToolBar ;
    WndToolBar->OnRButtonDown = OnRButtonDownVToolBar ;
#ifndef __NO_BUBBLE
    WndToolBar->OnTxtBubble   = OnTxtBubbleVToolBar ;
#endif
    WndToolBar->flags &= ~FLG_MUSTCLIP ; 
    VToolBarShow( config.flags & FLG_TOOLBAR ) ;
  }

  adr_icones[ZOOM_IN].ob_x      = 0 ;
  adr_icones[ZOOM_IN].ob_y      = 0 ;
  adr_icones[ZOOM_IN].ob_width  = 0 ;
  adr_icones[ZOOM_IN].ob_height = 0 ;

  adr_icones[ZOOM_VUE].ob_x      = 0 ;
  adr_icones[ZOOM_VUE].ob_y      = 0 ;
  adr_icones[ZOOM_VUE].ob_width  = 0 ;
  adr_icones[ZOOM_VUE].ob_height = 0 ;
}

void VToolBarUpdate(char* flags)
{
  int xyarray[4] ;
  int xy[4] ;
  int x, y, w, h ;
  int rx, ry, rw, rh ;
  int xt, yt ;
  int i ;
  
  wind_get( WndToolBar->window_handle, WF_WORKXYWH, &xt, &yt, &w, &h ) ;
  adr_icones[0].ob_x = xt ;
  adr_icones[0].ob_y = yt ;
  wind_get( WndToolBar->window_handle, WF_FIRSTXYWH, &rx, &ry, &rw, &rh ) ;

  while ( rw != 0 )
  {
    for (i = 1; i <= NB_TOOLS; i++)
    {
      if (flags[i])
      {
        objc_offset( adr_icones, i, &x, &y ) ;
        w = adr_icones[i].ob_width ;
        h = adr_icones[i].ob_height ;
        if ( intersect( x, y, w, h, rx, ry, rw, rh, xyarray ) )
        {
          if ( i == PALETTE )
          {
            xy[0] = xt+adr_icones[i].ob_x ;
            xy[1] = yt+adr_icones[i].ob_y ;
            xy[2] = xy[0]+adr_icones[i].ob_width-1 ;
            xy[3] = xy[1]+adr_icones[i].ob_height-1 ;
            vswr_mode(handle, MD_REPLACE) ;
            vsf_color(handle, ftype.color) ;
            vsf_interior(handle, FIS_SOLID) ;
            vsf_perimeter(handle, 1) ;
            vs_clip(handle, 1, xyarray) ;
            GWHideCursor( 0 ) ;
            vr_recfl(handle, xy) ;
            GWShowCursor( 0 ) ;
            vs_clip(handle, 0, xyarray) ;
          }
          if ( i != ZOOM_BOX ) objc_draw( adr_icones, i, 0, xyarray[0], xyarray[1] , xyarray[2]-xyarray[0]+1, xyarray[3]-xyarray[1]+1 ) ;
          else                 draw_zoombox( xyarray[0], xyarray[1], xyarray[2]-xyarray[0]+1, xyarray[3]-xyarray[1]+1 ) ;
        }
      }
    }    
    wind_get( WndToolBar->window_handle, WF_NEXTXYWH, &rx, &ry, &rw, &rh ) ;
  }
}
