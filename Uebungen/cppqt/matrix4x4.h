/// \file    matrix4x4.h
/// \author  Holger Arndt, Sebastian Birk, Martin Galgon
/// \version 0.1
/// \date    10.11.2016

#ifndef CPPQT_MATRIX4X4_H_
#define CPPQT_MATRIX4X4_H_

#include <iostream>
#include <vec4d.h>

/// 4x4-Matrix, dient auch als Transformationsmatrix für 3D-Vektoren mit homogenen Koordinaten
class Matrix4x4
{
public:
  /// Matrixelemente
  double el[4][4];

  /// Nullmatrix Konstruktor
  Matrix4x4();

  /// Matrix aus 2D-Array
  Matrix4x4(double m[4][4]);
};

/// Zeilenweise Ausgabe einer Matrix
std::ostream& operator<<(std::ostream& os, const Matrix4x4& t);

/// Matrix-Matrix-Multiplikation
Matrix4x4 operator*(const Matrix4x4& t1, const Matrix4x4& t2);

/// Matrix-Vektor-Multiplikation
Vec4D operator*(const Matrix4x4& t, const Vec4D& v);

#endif // CPPQT_MATRIX4X4_H_
