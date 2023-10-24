// Datei:  dreieck.cc
// Autor:  Holger Arndt
// Datum:  04.11.2002

#include <iostream>
#include <cmath>
#include "picture.h"
#include "draw.h"

using namespace std;

void DrawLine(Picture<GreyVal> &pic, IPoint2D p1, IPoint2D p2)
{
  double len = sqrt(double((p1.X - p2.X) * (p1.X - p2.X) +
                           (p1.Y - p2.Y) * (p1.Y - p2.Y)));
  IPoint2D q;

  for (double k = 0; k <= len; k += .1)
    {
      q.X = int(p1.X + k / len * (p2.X - p1.X) + .5);
      q.Y = int(p1.Y + k / len * (p2.Y - p1.Y) + .5);
      DrawPoint(pic, q);
    }
}

void DrawFilledTriangle1(Picture<GreyVal> &pic, IPoint2D p1, IPoint2D p2,
                         IPoint2D p3)
{
  // eine erste, nicht allzu gute Idee:
  // das gefuellt Dreieck wird dadurch erzeugt, dass der Punkt (x1, y1) mit
  // allen Punkten auf der gegenueberliegenden Seite durch Linien verbunden wird
  // eventuell koennen hierbei einzelne Pixel weiss bleiben

  double len23 = sqrt(double((p2.X - p3.X) * (p2.X - p3.X) +
                             (p2.Y - p3.Y) * (p2.Y - p3.Y)));
  IPoint2D q;
  for (double k = 0; k <= len23; k += .5)
    {
      q.X = int(p2.X + k / len23 * (p3.X - p2.X) + .5);
      q.Y = int(p2.Y + k / len23 * (p3.Y - p2.Y) + .5);
      DrawLine(pic, q, p1);
    }
}

double TriangleArea(IPoint2D p1, IPoint2D p2, IPoint2D p3)
{
  // berechnet den Flaecheninhalt des Dreiecks
  return 0.5 * ((p1.X - p2.X) * (p3.Y - p2.Y) - (p3.X - p2.X) * (p1.Y - p2.Y));
}

void DrawFilledTriangle2(Picture<GreyVal> &pic, IPoint2D p1, IPoint2D p2,
                         IPoint2D p3)
{
  // Idee: verwende baryzentrische Koordinaten, um festzustellen, ob ein
  // Punkt im Inneren des Dreiecks liegt

  // Rechteck ums Dreick bestimmen
  int xmin = min(min(p1.X, p2.X), p3.X);
  int ymin = min(min(p1.Y, p2.Y), p3.Y);
  int xmax = max(max(p1.X, p2.X), p3.X);
  int ymax = max(max(p1.Y, p2.Y), p3.Y);

  // Eckpunkte positiv orientieren
  if (TriangleArea(p1, p2, p3) < 0)
    swap(p2, p3);

  // Punkte des Rechtecks durchlaufen
  IPoint2D q;
  for (q.X = xmin; q.X <= xmax; q.X++)
    for (q.Y = ymin; q.Y <= ymax; q.Y++)
      if (TriangleArea(p1, p2, q) > 0 &&
          TriangleArea(p2, p3, q) > 0 &&
          TriangleArea(p3, p1, q) > 0)
        // dann liegt der Punkt im Innern
        DrawPoint(pic, q);
}

int main()
{
  Picture<GreyVal> pic1(100, 100, 255);
  Picture<GreyVal> pic2(100, 100, 255);

  IPoint2D p1, p2, p3;

  cout << "Eingabe von p1, p2, p3: ";
  cin >> p1 >> p2 >> p3;
  DrawFilledTriangle1(pic1, p1, p2, p3);
  pic1.Show(3, "Dreieck 1");
  DrawFilledTriangle2(pic2, p1, p2, p3);
  pic2.Show(3, "Dreieck 2");

  return 0;
}
