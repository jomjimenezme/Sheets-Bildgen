/// \file    matrix4x4.cc
/// \author  Holger Arndt, Sebastian Birk, Martin Galgon
/// \version 0.1
/// \date    10.11.2016

#include <matrix4x4.h>
#include <iomanip>

Matrix4x4::Matrix4x4()
{
  for (int i = 0; i < 4; ++i)
  for (int j = 0; j < 4; ++j)
    el[i][j] = 0;
}

Matrix4x4::Matrix4x4(double m[4][4])
{
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
      el[i][j] = m[i][j];
}

std::ostream& operator<<(std::ostream& os, const Matrix4x4& t)
{
  for (int i = 0; i < 4; ++i)
    {
      for (int j = 0; j < 4; ++j)
        os << std::setw(9) << t.el[i][j] << ' ';
      os << std::endl;
    }
  return os;
}

Matrix4x4 operator*(const Matrix4x4& t1, const Matrix4x4& t2)
{
  Matrix4x4 erg;
  int i, j, k;
  for (i = 0; i < 4; ++i)
    for (j = 0; j < 4; ++j)
      for (k = 0; k < 4; ++k)
        erg.el[i][j] += t1.el[i][k] * t2.el[k][j];
  return erg;
}

Vec4D operator*(const Matrix4x4& t, const Vec4D& v)
{
  Vec4D erg;
  int i, k;
  for (i = 0; i < 4; ++i)
    for (k = 0; k < 4; ++k)
      erg.el[i] += t.el[i][k] * v.el[k];
  return erg;
}
