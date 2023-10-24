/// \file    vec4d.h
/// \author  Holger Arndt, Sebastian Birk, Martin Galgon
/// \version 0.1
/// \date    10.11.2016

#ifndef CPPQT_VEC4D_H_
#define CPPQT_VEC4D_H_

#include <iostream>
#include <vec3d.h>

/// Homogene Koordinaten eines 3D-Vektors oder ein 4D-Vektor
class Vec4D
{
public:
  /// x-, y-, z-, und w-Koordinate
  double el[4];

  /// Default-Konstruktor: Vektor (0, 0, 0, 0)
  Vec4D();

  /// Konstruktor für einen Vektor (\p x, \p y, \p z, 1)
  Vec4D(double x, double y, double z);

  /// Konstruktor für einen Vektor (\p x, \p y, \p z, \p w)
  Vec4D(double x, double y, double z, double w);

  /// Konstruktor für einen 4D-Vektor aus einem 3D-Vektor
  Vec4D(const Vec3D& v);
};

/// Ausgabe eines Vektors in der Form (x y z w)
std::ostream& operator<<(std::ostream& os, const Vec4D& v);

/// Skalarprodukt
double skalarprod(const Vec4D& v1, const Vec4D& v2);

#endif // CPPQT_VEC4D_H_
