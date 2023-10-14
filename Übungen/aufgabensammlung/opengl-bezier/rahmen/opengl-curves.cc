// Bézier-Kurven (OpenGL)
// Autor: Sebastian Birk, Martin Galgon
// Datum: 10.12.2008

#include <cmath>
#include <iostream>
#include <vector>
#include <signal.h>

// GL & SDL Includes
#include <SDL/SDL.h>
#include <SDL/SDL_thread.h>
#include <GL/gl.h>
#include <GL/glu.h>

#include "gltypes.h"
#include "glsupport.h"

using namespace std;

vector<DPoint2D> leseBezier( void )
{
  int nump;
  cin >> nump;

  vector<DPoint2D> p(nump);
  int i;

  for (i = 0; i < nump; i++)
    cin >> p[i];

  return p;
}

void maleBezier( const vector<DPoint2D>& points, int nSegments )
{
  // Kontrollpunkte
  glColor3f( 1.0f, 0.0f, 0.0f );
  for ( unsigned int i = 0; i < points.size(); i++ )
  {
    glBegin( GL_POLYGON );
    glVertex3f( points[i].x + 4, points[i].y,     0 );
    glVertex3f( points[i].x,     points[i].y + 4, 0 );
    glVertex3f( points[i].x - 4, points[i].y,     0 );
    glVertex3f( points[i].x,     points[i].y - 4, 0 );
    glEnd();
  }

  // HIER ERGAENZEN

}

/*******************************************************************
 * OpenGL-Funktionen
 */

// initScene initialisiert alles, was von OpenGL benoetigt wird.
void initScene()
{
  // Anzeige-Einstellungen
  SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 );
  glViewport( 0, 0, windowSize[0], windowSize[1] );
  glClearColor( 1.0f, 1.0f, 1.0f, 1.0f );

  // Projektionseinstellungen
  glMatrixMode( GL_PROJECTION );
  glLoadIdentity();

  // Orthogonale Projektion fuer 2D einstellen
  glOrtho( 0.0, windowSize[0], 0.0, windowSize[1], -1.0, 1.0 );

  // Szeneneinstellungen
  glMatrixMode( GL_MODELVIEW );
  glLoadIdentity();
}

void objektHinzufuegen(vector<GLint>& objekte, const vector<DPoint2D>& points)
{
  beginneObjekt(objekte);
    glLineWidth( 1.0f );
    maleBezier( points, 50 );
//     maleBezierHoehereOrdnung( points, 50, 7 );
  beendeObjekt();
}

int main( int argc, char *argv[] )
{
  SDL_Event     event;
  vector<GLint> objekte;

  windowSize[0] = 650; windowSize[1] = 650;

  // SDL initialisieren
  initialisiereSDL();

  // Szene initialisieren
  initScene();

  // Eingabe der Daten
  vector<DPoint2D> points = leseBezier();
  objektHinzufuegen(objekte, points);

  // Ereignis-Schleife starten
  while ( !finished )
  {
    // auf events reagieren
    SDL_WaitEvent( &event );
    // Einige standard-events bearbeiten
    behandleStandardEvents(event, objekte);

    switch ( event.type )
    {
      case SDL_KEYDOWN:
        // Tastatursteuerung
        switch ( event.key.keysym.sym )
        {
          // Space setzt die Position zurueck
          case SDLK_SPACE:
            camera.position[0] = 0;
            camera.position[1] = 0;
            camera.position[2] = 0;
            break;
          // Bewegungssteuerung:
          // Pfeiltasten zur Steuerung
          case SDLK_RIGHT:
            camera.position[0] -= 10.0f;
            break;
          case SDLK_LEFT:
            camera.position[0] += 10.0f;
            break;
          case SDLK_UP:
            camera.position[1] -= 10.0f;
            break;
          case SDLK_DOWN:
            camera.position[1] += 10.0f;
            break;
          default:
            break;
        }
        break;
      // Maussteuerung:
      // Bei gedrueckter linker Maustaste laesst sich die Position steuern
      case SDL_MOUSEMOTION:
        if( event.motion.state & SDL_BUTTON(1) )
        {
          camera.position[0] -= event.motion.xrel;
          camera.position[1] += event.motion.yrel;
        }
        break;
      default:
        break;
    }
  }

  finalisiereSDL();

  return 0;
}
