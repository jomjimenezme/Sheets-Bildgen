// einfache gefüllte Kreise
// Autor:  Holger Arndt
// Datum:  26.10.2015

#include <iostream>

#include <cppqt.h>

using namespace std;

// malt einen gefüllten Kreis um m mit Radius r
void zeichneKreis(Drawing& pic, IPoint2D m, int r)
{
  // Idee: durchlaufe alle Punkte des umschließenden Quadrats und teste,
  //       ob die Entfernung zum Mittelpunkte m ≤ dem Radius r ist.

  // Quadrat um den Kreis bestimmen
  int xmin = m.x - r;
  int ymin = m.y - r;
  int xmax = m.x + r;
  int ymax = m.y + r;

  // Punkte des Quadrats durchlaufen
  IPoint2D q;
  for (q.x = xmin; q.x <= xmax; ++q.x)
    for (q.y = ymin; q.y <= ymax; ++q.y)
      if (norm(q - m) <= r)
        // dann liegt der Punkt im Innern
        pic.drawPoint(q, 0, true);
}

int maindraw()
{
  Drawing pic(200, 200);
  pic.show();
  pic.setZoom(3);

  IPoint2D m;
  int r;

  while(true){
    cout << "Eingabe von Mittelpunkt m und Radius r: ";
    cin >> m >> r;
    if((m.x < 0) || (m.y < 0) || (r < 0)) break;
    zeichneKreis(pic, m, r);
    cin.get();
  }
  
  cout << endl;
  IOThread::waitForWindow(60);

  return 0;
}
