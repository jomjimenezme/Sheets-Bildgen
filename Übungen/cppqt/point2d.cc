/// \file    point2d.cc
/// \author  Holger Arndt
/// \version 0.4
/// \date    15.09.2015

#ifndef POINT2D_CC
#define POINT2D_CC

#include <cmath>
#include <iostream>
#include "point2d.h"

template <class T>
std::ostream& operator<<(std::ostream& os, const Point2D<T>& p)
{
  os << '(' << p.x << ',' << p.y << ')';
  return os;
}

template <class T>
std::istream& operator>>(std::istream& is, Point2D<T>& p)
{
  is.ignore(255, '(');
  is >> p.x;
  is.ignore(255, ',');
  is >> p.y;
  is.ignore(255, ')');
  return is;
}

template <class T>
Point2D<int> round(const Point2D<T>& p)
{
  return Point2D<int>(static_cast<int>(round(p.x)),
                      static_cast<int>(round(p.y)));
}

template <class T>
Point2D<T> operator+(const Point2D<T>& p1, const Point2D<T>& p2)
{ return Point2D<T>(p1.x + p2.x, p1.y + p2.y); }

template <class T>
Point2D<T> operator-(const Point2D<T>& p1, const Point2D<T>& p2)
{ return Point2D<T>(p1.x - p2.x, p1.y - p2.y); }

template <class T>
Point2D<T> operator*(T a, const Point2D<T>& p)
{ return Point2D<T>(a * p.x, a * p.y); }

template <class T>
Point2D<T> operator*(const Point2D<T>& p, T a)
{ return a * p; }

template <class T>
Point2D<T> operator/(const Point2D<T>& p, T a)
{ return Point2D<T>(p.x / a, p.y / a); }

template <class T>
double norm(const Point2D<T>& p)
{ return std::sqrt(p.x * p.x + p.y * p.y); }

template <>
inline double norm(const Point2D<int>& p)
{ return std::sqrt(static_cast<double>(p.x * p.x + p.y * p.y)); }

#endif
