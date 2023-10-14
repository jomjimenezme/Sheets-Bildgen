/// \file    vec3d.h
/// \author  Holger Arndt, Sebastian Birk, Martin Galgon
/// \version 0.1
/// \date    10.11.2016

#ifndef CPPQT_VEC3D_H_
#define CPPQT_VEC3D_H_

#include <iostream>

/// Koordinaten eines 3D-Vektors
class Vec3D
{
public:
  /// x-, y-, und z-Koordinate
  double el[3];

  /// Default-Konstruktor: Vektor (0, 0, 0)
  Vec3D();

  /// Konstruktor für einen Vektor (\p x, \p y, \p z)
  Vec3D(double x, double y, double z);

  /// Additionszuweisung
  Vec3D& operator+=(const Vec3D& v);
};

/// Skalar mal Vektor
Vec3D operator*(double a, const Vec3D& v);

/// Elementweise Multiplikation Vektor mal Vektor
Vec3D operator*(const Vec3D& v1, const Vec3D& v2);

/// Elementweise Division Vektor durch Skalar
Vec3D operator/(const Vec3D& v, double a);

/// Vektor plus Vektor
Vec3D operator+(const Vec3D& v1, const Vec3D& v2);

/// Vektor minus Vektor
Vec3D operator-(const Vec3D& v1, const Vec3D& v2);

/// Ausgabe eines Vektors in der Form (x y z)
std::ostream& operator<<(std::ostream& os, const Vec3D& v);

/// Vektornorm
double norm(const Vec3D& v);

/// Skalarprodukt
double skalarprod(const Vec3D& v1, const Vec3D& v2);

/// Kreuzprodukt
Vec3D kreuzprod(const Vec3D& v1, const Vec3D& v2);

#endif // CPPQT_VEC3D_H_
