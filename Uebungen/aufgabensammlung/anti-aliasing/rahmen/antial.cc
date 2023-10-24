// Antialiasing für Linien
// Autor: Holger Arndt, Sebastian Birk
// Datum: 09.11.2015

#include <algorithm>
#include <cmath>
#include <iostream>
#include <numeric>
#include <vector>

#include <cppqt.h>

using namespace std;

void drawAntialiasedWideLine(Drawing& pic, DPoint2D p1, DPoint2D p2,
                             double w, int f = 4, int colour = 0)
// zeichnet eine Linie von p1 nach p2 der Dicke w, der Algorithmus verwendet
// zur Berechnung ein f-fach in x- und y-Richtung verfeinertes Raster
{
  // HIER ERGÄNZEN
}

int maindraw()
{
  Drawing pic1(170, 170);

  pic1.show();

  DPoint2D p1, p2;
  double width;
  int f;

  cout << "Dicke, Raster: ";
  cin >> width >> f;

  for (int theta = 0; theta <= 90; theta += 9)
    {
      p1 = DPoint2D(10,10);
      p2 = p1 + 150.0 * DPoint2D(sin(theta * M_PI / 180.0),
                                 cos(theta * M_PI / 180.0));
      drawAntialiasedWideLine(pic1, p1, p2, width, f, 0);
    }

  cin.get();
  cout << "Return zum Vergrößern" << endl;
  cin.get();
  pic1.setZoom(4);

  IOThread::waitForWindow(60);

  return 0;
}
