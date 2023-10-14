/// \file    drawcolour.cc
/// \author  Sebastian Birk
/// \version 0.3
/// \date    04.11.2013

#ifndef DRAWCOLOUR_CC
#define DRAWCOLOUR_CC

#include <iostream>
#include "drawcolour.h"

std::ostream& operator<<(std::ostream& os, const DrawColour& dc)
{
  os << '(' << dc.red() << ',' << dc.green() << ',' << dc.blue() << ')';
  return os;
}

std::istream& operator>>(std::istream& is, DrawColour& dc)
{
  int c;
  is.ignore(255, '(');
  is >> c;
  dc.setRed(c);
  is.ignore(255, ',');
  is >> c;
  dc.setGreen(c);
  is.ignore(255, ',');
  is >> c;
  dc.setBlue(c);
  is.ignore(255, ')');
  return is;
}

#endif
