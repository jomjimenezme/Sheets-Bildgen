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

void maleKontrollPunkte(const vector<DPoint2D>& points)
{
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
}

void maleBezier( const vector<DPoint2D>& points, int nSegments )
{
  int n = points.size();
  int m = n - 1;

  // Kontrollpunkte
  maleKontrollPunkte(points);

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // Array der Kontrollpunkte fuer OpenGL vorbereiten
  GLfloat *apPoints = new GLfloat[12];

  // Male die Kurvenabschnitte
  glColor3f( 0.0f, 0.0f, 0.0f );
  for ( int k = 3; k <= m; k += 3 )
  {
    // Bezierkurve vorbereiten, indem alle 4 Kontrollpunkte des
    // aktuellen Kurvenabschnitts an OpenGL uebergeben werden
    for( int i = 0; i < 4; i++ )
    {
      apPoints[3*i+0] = points[k-3+i].x;
      apPoints[3*i+1] = points[k-3+i].y;
      apPoints[3*i+2] = 0.0;
    }

    // glMap1f( target, t1, t2, stride, order, points )
    //  Identifikator GL_MAP1_VERTEX_3 -> 3D-Points
    //  Parameterbereich [0,1]
    //  Anzahl floats zwischen zwei Kontrollpunkten im Speicher
    //  Ordnung / Anzahl Kontrollpunkte
    //  float-Array mit Kontrollpunkten

    glMap1f( GL_MAP1_VERTEX_3, 0.0, 1.0, 3, 4, apPoints );
    glEnable( GL_MAP1_VERTEX_3 );

    // auswerten an Zwischenpunkten und zeichnen
    glBegin( GL_LINE_STRIP );
      for ( int i = 0; i <= nSegments; i++ )
        // Erzeugt glVertex3-Befehl mit entsprechenden Koordinaten.
        glEvalCoord1f( ((GLfloat)i) / nSegments ); // Parameter t in [0,1]
    glEnd();
  }

  // Array der Kontrollpunkte wieder freigeben
  delete[] apPoints;

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}

void maleBezierHoehereOrdnung( const vector<DPoint2D>& points, int nSegments, int order )
{
  // Kontrollpunkte
  maleKontrollPunkte(points);

  // Höhere Ordnung
  // Array der Kontrollpunkte fuer OpenGL vorbereiten
  GLfloat *apPoints = new GLfloat[3*points.size()];

  for( unsigned int i = 0; i < points.size(); i++ )
  {
    apPoints[3*i+0] = points[i].x;
    apPoints[3*i+1] = points[i].y;
    apPoints[3*i+2] = 0.0;
  }

  // Male die Kurvenabschnitte
  glColor3f( 0.0f, 0.0f, 0.0f );

  glMap1f( GL_MAP1_VERTEX_3, 0.0, 1.0, 3, order, apPoints );
  glEnable( GL_MAP1_VERTEX_3 );

  glBegin( GL_LINE_STRIP );
    for ( int i = 0; i <= 4*nSegments; i++ )
      glEvalCoord1f( ((GLfloat)i) / (4 * nSegments) );
  glEnd();

  // Array der Kontrollpunkte wieder freigeben
  delete[] apPoints;
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
