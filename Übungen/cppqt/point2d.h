/// \file    point2d.h
/// \author  Holger Arndt
/// \version 0.4
/// \date    15.09.2015

#ifndef POINT2D_H
#define POINT2D_H

#include <iostream>

/// Punkt in der Ebene.
/// Kann auch für Vektoren in der Ebene verwendet werden.
template <class T = int>
class Point2D
{
public:
  /// x-Koordinate
  T x;

  /// y-Koordinate
  T y;

  /// Default-Konstruktor: Punkt (0, 0)
  Point2D() : x(0), y(0) {};

  /// Konstruktor für einen Punkt (\p x, \p y)
  Point2D(T xx, T yy) : x(xx), y(yy) {};

  /// Kopier-Konstruktor
  Point2D(const Point2D<T> &p2) : x(p2.x), y(p2.y) {};

  /// Typumwandlung
  template <class U> operator Point2D<U>() const
  { return Point2D<U>(static_cast<U>(x), static_cast<U>(y)); }
};

/// Ausgabe eines Punktes in der Form (2,3)
template <class T>
std::ostream &operator<<(std::ostream& os, const Point2D<T>& p);

/// Eingabe eines Punktes in der Form (2,3)
template <class T> std::istream &operator>>(std::istream& is, Point2D<T>& p);

/// Rundung auf Integer-Punkte
template <class T> Point2D<int> round(const Point2D<T>& p);

/// Vektor plus Vektor
template <class T>
Point2D<T> operator+(const Point2D<T>& p1, const Point2D<T>& p2);

/// Vektor minus Vektor
template <class T>
Point2D<T> operator-(const Point2D<T>& p1, const Point2D<T>& p2);

/// Skalar mal Vektor
template <class T> Point2D<T> operator*(T a, const Point2D<T>& p);

/// Vektor mal Skalar
template <class T> Point2D<T> operator*(const Point2D<T>& p, T a);

/// Vektor durch Skalar
template <class T> Point2D<T> operator/(const Point2D<T>& p, T a);

/// Vektornorm
template <class T> double norm(const Point2D<T> &p);

/// Vektornorm, Variante für int-Punkte
template <> double norm(const Point2D<int> &p);

/// Ein Punkt mit ganzzahligen Koordinaten
typedef Point2D<int> IPoint2D;

/// Ein Punkt mit double-wertigen Koordinaten
typedef Point2D<double> DPoint2D;

#include "point2d.cc"

#endif
