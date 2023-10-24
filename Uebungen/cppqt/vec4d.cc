/// \file    vec4d.cc
/// \author  Holger Arndt, Sebastian Birk, Martin Galgon
/// \version 0.1
/// \date    10.11.2016

#include <vec4d.h>
#include <iomanip>

Vec4D::Vec4D()
{
  el[0] = el[1] = el[2] = el[3] = 0;
}

Vec4D::Vec4D(double x, double y, double z)
{
  el[0] = x;
  el[1] = y;
  el[2] = z;
  el[3] = 1;
}

Vec4D::Vec4D(double x, double y, double z, double w)
{
  el[0] = x;
  el[1] = y;
  el[2] = z;
  el[3] = w;
}

Vec4D::Vec4D(const Vec3D& v)
{
  el[0] = v.el[0];
  el[1] = v.el[1];
  el[2] = v.el[2];
  el[3] = 1;
}

double skalarprod(const Vec4D& v1, const Vec4D& v2)
{
  return v1.el[0] * v2.el[0] + v1.el[1] * v2.el[1] + v1.el[2] * v2.el[2] + v1.el[3] * v2.el[3];
}

std::ostream& operator<<(std::ostream& os, const Vec4D& v)
{
  os << '(' << std::setprecision(4) << v.el[0] << ' ' << std::setprecision(4) << v.el[1]
     << ' ' << std::setprecision(4) << v.el[2] << ' ' << std::setprecision(4) << v.el[3]
     << ')';
  return os;
}
