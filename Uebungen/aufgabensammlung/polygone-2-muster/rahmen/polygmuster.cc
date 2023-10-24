// Datei:  polygmuster_rahmen.cpp
// Autor:  Holger Arndt
// Datum:  07.11.2006
// modifiziert: 04.11.2008 Sebastian Birk

#include <iostream>
#include <cmath>
#include <list>
#include <vector>
#include <drawing.h>
#include <maindraw.h>
#include <point2d.h>
#include <QImage>

using namespace std;

struct Kante
{
  int ymax;
  double x;
  double einsdurchm;
  friend bool operator<( const Kante& k1, const Kante& k2 )
  {
    if ( k1.x != k2.x )
      return k1.x < k2.x;
    else
      return k1.einsdurchm < k2.einsdurchm;
  }
};

typedef list<Kante> KantenTabelle;

void drawPatternPolygon( Drawing& pic, const vector<IPoint2D>& ecken,
                         const QImage& muster )
{
  // HIER ERGAENZEN
}

int maindraw()
{
  Drawing pic1( 300, 300, 255 );

  pic1.show();
  pic1.setZoom( 2 );

  int n;
  IPoint2D p;
  vector<IPoint2D> ecken;
  string musterdatei;

  cout << "Anzahl der Ecken: ";
  cin >> n;

  for ( int i = 1; i <= n; i++ )
    {
      cout << "Ecke " << i << ": ";
      cin >> p;
      ecken.push_back( p );
    }

  cout << "Datei mit Fuellmuster: ";
  cin >> musterdatei;
  QImage muster;
  muster.load( musterdatei.c_str() );

  drawPatternPolygon( pic1, ecken, muster );

  cout << "Beenden mit Return" << endl;
  cin.get();

  return 0;
}
