// Parallelogramme und Kreise mit Muster
// Autor:  Sebastian Birk
// Datum:  2013-11-04

#include <iostream>
#include <cmath>
#include <unistd.h>
#include <string>
#include <cctype>
#include <deque>

#include <cppqt.h>

using namespace std;

const bool drawSlow = true;
const int muster_dichte = 5;
const int slowness = 1;

//######################################################################

void fuellen( Drawing& pic, IPoint2D where, IPoint2D referenz, char muster,
              const DrawColour &farbe1, const DrawColour &farbe2 )
{
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  std::deque<IPoint2D> d;

  pic.setSleepTime(slowness);

   //===================================================================

  auto test_and_add_point = [farbe1,farbe2,&d,&pic] (IPoint2D _test) {
    // 1. liegt der Punkt innerhalb des Bildes?
    // 2. wurde der Punkt bereits gefärbt?
    if (   _test.x >= 0 && _test.y >= 0
           && _test.x < pic.getWidth()
           && _test.y < pic.getHeight()
           && (pic.getPointColour(_test.x,_test.y) != DrawColour(farbe1))
           && (pic.getPointColour(_test.x,_test.y) != DrawColour(farbe2)))
    {
      d.push_back(_test);
    }
  };

   //===================================================================

  auto get_colour = [farbe1,farbe2,muster,&referenz] (IPoint2D _point) {
    // Verschiebung in Musterkoordinaten
    IPoint2D p = IPoint2D(_point.x-referenz.x,_point.y-referenz.y);

    // Eine Linie, beginnend bei Punkt p mit Steigung 1, hat die Form
    // p.y = 1 * p.x + 0, bzw. die implizite Form p.x - p.y = 0.
    // Für jeden anderen Punkt (p.x, p.y) gibt die implizite Form den
    // Abstand zur Geraden an.
    // p.y = -1 * p.x + 0 liefert p.x + p.y = 0.
    bool NOSW = ((p.x-p.y)%muster_dichte == 0);
    bool SONW = ((p.x+p.y)%muster_dichte == 0);

    switch (muster) {
      case 'N':
        return (NOSW) ? farbe1 : farbe2;
      case 'S':
        return (SONW) ? farbe1 : farbe2;
      case 'K':
        return (NOSW || SONW) ? farbe1 : farbe2;
      case 'V':
      default:
        return farbe1;
    }

    return farbe1;
  };

   //===================================================================

  d.push_back(where);
  IPoint2D p;
  while( !d.empty() ) {
    p = d.front();
    d.pop_front();

    // Der Punkt könnte inzwischen gefärbt worden sein.
    if ( !(pic.getPointColour(p.x,p.y) == DrawColour(farbe1)
        || pic.getPointColour(p.x,p.y) == DrawColour(farbe2)))
    {
      pic.drawPoint(p.x, p.y, get_colour(p), drawSlow);
      // Füge die vier Nachbarn hinzu
      test_and_add_point( IPoint2D(p.x+1,p.y) );
      test_and_add_point( IPoint2D(p.x-1,p.y) );
      test_and_add_point( IPoint2D(p.x,p.y+1) );
      test_and_add_point( IPoint2D(p.x,p.y-1) );
    }
  }
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}

//######################################################################

void parallelogramm( Drawing& pic, IPoint2D P1, IPoint2D P2, IPoint2D P3, char muster,
                     const DrawColour &farbe1, const DrawColour &farbe2 )
{
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  IPoint2D P4 = P1 + P3 - P2;

  // Linien des Parallelogramms zeichnen
  pic.drawLine( P1, P2, farbe1 );
  pic.drawLine( P2, P3, farbe1 );
  pic.drawLine( P3, P4, farbe1 );
  pic.drawLine( P4, P1, farbe1 );

  // beginnend im Schwerpunkt füllen
  fuellen(pic, (P1+P3)/2, P1, muster, farbe1, farbe2);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}

//######################################################################

void kreis( Drawing& pic, IPoint2D M, int radius, char muster,
            const DrawColour &farbe1, const DrawColour &farbe2 )
{
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  pic.drawCircle(M, radius, false, farbe1);

  // beginnend im Mittelpunkt füllen
  fuellen(pic, M, IPoint2D(M.x-radius,M.y-radius), muster, farbe1, farbe2);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}

//######################################################################

int maindraw()
{
  Drawing pic(200, 200);
  pic.show();
  pic.setZoom(4);

  while (true)
  {
    std::cout << "[P]arallelogramm, [K]reis oder [B]eenden: ";
    char eingabe;
    std::cin >> eingabe;
    if (toupper(eingabe) == 'B')
      break;
    else if (toupper(eingabe) == 'P') {
      IPoint2D P1, P2, P3;
      char muster;
      DrawColour farbe1, farbe2;
      std::cout << "P1, P2, P3: ";
      std::cin >> P1 >> P2 >> P3;
      std::cout << "Muster ([V]oll, [N]ord-Ost, [S]ued-Ost, [K]aros): ";
      std::cin >> muster;
      std::cout << "Farbe 1: ";
      std::cin >> farbe1;
      std::cout << "Farbe 2: ";
      std::cin >> farbe2;
      parallelogramm(pic, P1, P2, P3, muster, farbe1, farbe2);
    }
    else if (toupper(eingabe) == 'K') {
      IPoint2D M;
      int radius;
      char muster;
      DrawColour farbe1, farbe2;
      std::cout << "M, r: ";
      std::cin >> M >> radius;
      std::cout << "Muster ([V]oll, [N]ord-Ost, [S]ued-Ost, [K]aros): ";
      std::cin >> muster;
      std::cout << "Farbe 1: ";
      std::cin >> farbe1;
      std::cout << "Farbe 2: ";
      std::cin >> farbe2;
      kreis(pic, M, radius, muster, farbe1, farbe2);
    }
    std::cin.get();
  }

  cout << endl;
  IOThread::waitForWindow(60);

  return 0;
}
