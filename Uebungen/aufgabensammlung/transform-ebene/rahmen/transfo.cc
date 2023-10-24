// Datei:  transfo_rahmen.cc
// Autor:  Holger Arndt
// Datum:  23.11.2004
// Rahmenprogamm zu Blatt 05, Aufgabe 09

#include <iostream>
#include <cmath>
#include <vector>
#include <maindraw.h>
#include <picture.h>
#include <draw.h>

using namespace std;

class Transformation2D
{
public:
  double t11;
  double t12;
  double t13;
  double t21;
  double t22;
  double t23;
  friend std::ostream &operator<<(std::ostream &os, const Transformation2D t)
  {
    os << '(' << t.t11 << ' ' << t.t12 << ' ' << t.t13 << ')' << endl;
    os << '(' << t.t21 << ' ' << t.t22 << ' ' << t.t23 << ')' << endl;
    os << '(' << 0 << ' ' << 0 << ' ' << 1 << ')' << endl;
    return os;
  }

};

Transformation2D BerechneTransformation(DPoint2D p1, DPoint2D p2, DPoint2D p3,
                                        DPoint2D q1, DPoint2D q2, DPoint2D q3)
{
  // berechnet die Transformation t, die pi in qi ueberfuehrt (i=1,2,3)

  // HIER ERGAENZEN
}

DPoint2D Transformiere(Transformation2D t, DPoint2D p)
{
  // wendet die Transformation t auf den Punkt p an

  // HIER ERGAENZEN
}

int maindraw()
{
  Picture pic1(300, 300, 255);
  pic1.Show(1, "Transformationen");

  DPoint2D p1, p2, p3, q1, q2, q3;
  cout << "Eingabe von p1, p2, p3, q1, q2, q3: ";
  cin >> p1 >> p2 >> p3 >> q1 >> q2 >> q3;;

  vector<IPoint2D> ecken(3);
  ecken[0] = p1;
  ecken[1] = p2;
  ecken[2] = p3;
  DrawPolygon(pic1, ecken, false, DrawColour(0, 0, 255));
  ecken[0] = q1;
  ecken[1] = q2;
  ecken[2] = q3;
  DrawPolygon(pic1, ecken, false, DrawColour(255, 0, 0));

  Transformation2D t;
  t = BerechneTransformation(p1, p2, p3, q1, q2, q3);

  int n;
  cout << "Eingabe eines Polygons (n, ecke(0), ..., ecke(n-1): ";
  cin >> n;
  ecken.resize(n);
  for (int i = 0; i < n; i++)
    cin >> ecken[i];
  DrawPolygon(pic1, ecken, true, 0, DrawColour(0, 0, 255));

  for (int i = 0; i < n; i++)
    ecken[i] = round(Transformiere(t, ecken[i]));
  DrawPolygon(pic1, ecken, true, 0, DrawColour(255, 0, 0));

  cout << "Abbruch mit CTRL-C oder nach 60 Sekunden" << endl;
  sleep(60);

  return 0;
}
