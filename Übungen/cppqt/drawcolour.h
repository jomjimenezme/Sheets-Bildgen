/// \file    drawcolour.h
/// \author  Holger Arndt, Sebastian Birk
/// \version 0.3
/// \date    16.09.2015

#ifndef DRAWCOLOUR_H
#define DRAWCOLOUR_H

#include <iostream>
#include <QColor>

/// Farbklasse
class DrawColour : public QColor
{
public:
  /// Default-Konstruktor: Farbe schwarz
  DrawColour() : QColor() {}

  /// Kopier-Konstruktor
  DrawColour(const QColor& c2) : QColor(c2) {}

  /// Konstruktur für RGB-Werte
  DrawColour(int r, int g, int b) : QColor(r, g, b) {}

  /// Konstruktor für Grauwerte
  DrawColour(int gr) : QColor(gr, gr, gr) {}
};

/// Ausgabe der Farbe in der Form (0,0,255)
std::ostream& operator<<(std::ostream& os, const DrawColour& dc);

/// Eingabe der Farbe in der Form (0,0,255)
std::istream& operator>>(std::istream& is, DrawColour& dc);


#endif
