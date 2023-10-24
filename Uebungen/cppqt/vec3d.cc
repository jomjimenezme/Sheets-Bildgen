/// \file    vec3d.cc
/// \author  Holger Arndt, Sebastian Birk, Martin Galgon
/// \version 0.1
/// \date    10.11.2016

#include <vec3d.h>
#include <iomanip>
#include <cmath>

Vec3D::Vec3D()
{
  el[0] = el[1] = el[2] = 0;
}

Vec3D::Vec3D(double x, double y, double z)
{
  el[0] = x;
  el[1] = y;
  el[2] = z;
}

Vec3D& Vec3D::operator+=(const Vec3D& v)
{
  el[0] += v.el[0];
  el[1] += v.el[1];
  el[2] += v.el[2];
  return *this;
}

Vec3D operator*(double a, const Vec3D& v)
{
  return Vec3D(a * v.el[0], a * v.el[1], a * v.el[2]);
}

Vec3D operator*(const Vec3D& v1, const Vec3D& v2)
{
  return Vec3D(v1.el[0] * v2.el[0], v1.el[1] * v2.el[1], v1.el[2] * v2.el[2]);
}

Vec3D operator/(const Vec3D& v, double a)
{
  return (1 / a) * v;
}

Vec3D operator+(const Vec3D& v1, const Vec3D& v2)
{
  return Vec3D(v1.el[0] + v2.el[0], v1.el[1] + v2.el[1], v1.el[2] + v2.el[2]);
}

Vec3D operator-(const Vec3D& v1, const Vec3D& v2)
{
  return Vec3D(v1.el[0] - v2.el[0], v1.el[1] - v2.el[1], v1.el[2] - v2.el[2]);
}

std::ostream& operator<<(std::ostream& os, const Vec3D& v)
{
  os << '(' << std::setprecision(4) << v.el[0] << ' ' << std::setprecision(4) << v.el[1]
     << ' ' << std::setprecision(4) << v.el[2] << ')';
  return os;
}

double norm(const Vec3D& v)
{
  return sqrt(v.el[0] * v.el[0] + v.el[1] * v.el[1] + v.el[2] * v.el[2]);
}

double skalarprod(const Vec3D& v1, const Vec3D& v2)
{
  return v1.el[0] * v2.el[0] + v1.el[1] * v2.el[1] + v1.el[2] * v2.el[2];
}

Vec3D kreuzprod(const Vec3D& v1, const Vec3D& v2)
{
  return Vec3D(v1.el[1] * v2.el[2] - v1.el[2] * v2.el[1],
               v1.el[2] * v2.el[0] - v1.el[0] * v2.el[2],
               v1.el[0] * v2.el[1] - v1.el[1] * v2.el[0]);
}
