// Datei:  transfo.cc
// Autor:  Holger Arndt
// Datum:  23.11.2004
// Loesung zu Blatt 05, Aufgabe 09

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

double det3x3(double a11, double a12, double a13, double a21, double a22,
	      double a23, double a31, double a32, double a33)
{
  return a11 * a22 * a33 + a12 * a23 * a31 + a13 * a21 * a32
    - a11 * a23 * a32 - a12 * a21 * a33 - a13 * a22 * a31;
}

Transformation2D BerechneTransformation(DPoint2D p1, DPoint2D p2, DPoint2D p3,
                                        DPoint2D q1, DPoint2D q2, DPoint2D q3)
{
  // berechnet die Transformation t, die pi in qi ueberfuehrt (i=1,2,3)
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  Transformation2D t;

  double detp = det3x3(p1.X, p1.Y, 1, p2.X, p2.Y, 1, p3.X, p3.Y, 1);
  cout << detp << endl;
  t.t11 = det3x3(q1.X, p1.Y, 1, q2.X, p2.Y, 1, q3.X, p3.Y, 1) / detp;
  t.t12 = det3x3(p1.X, q1.X, 1, p2.X, q2.X, 1, p3.X, q3.X, 1) / detp;
  t.t13 = det3x3(p1.X, p1.Y, q1.X, p2.X, p2.Y, q2.X, p3.X, p3.Y, q3.X) / detp;
  t.t21 = det3x3(q1.Y, p1.Y, 1, q2.Y, p2.Y, 1, q3.Y, p3.Y, 1) / detp;
  t.t22 = det3x3(p1.X, q1.Y, 1, p2.X, q2.Y, 1, p3.X, q3.Y, 1) / detp;
  t.t23 = det3x3(p1.X, p1.Y, q1.Y, p2.X, p2.Y, q2.Y, p3.X, p3.Y, q3.Y) / detp;

  return t;
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}

DPoint2D Transformiere(Transformation2D t, DPoint2D p)
{
  // wendet die Transformation t auf den Punkt p an
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  DPoint2D q;

  q.X = t.t11 * p.X + t.t12 * p.Y + t.t13;
  q.Y = t.t21 * p.X + t.t22 * p.Y + t.t23;

  return q;
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
