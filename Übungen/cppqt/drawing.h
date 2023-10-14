/// \file    drawing.h
/// \author  Holger Arndt, Sebastian Birk, Martin Galgon
/// \version 0.2.3
/// \date    16.09.2015

#ifndef DRAWING_H
#define DRAWING_H

class Drawing;

#include <string>
#include <vector>
#include <QImage>
#include <QMutex>
#include <QPixmap>
#include "drawcolour.h"
#include "drawops.h"
#include "point2d.h"

/// Ein Bild.
class Drawing
{
private:
  QImage img;
  int sleepMilli;
  static const int defaultSleepMilli = 10;
  mutable QMutex imgMutex;
public:
  /// Default-Konstruktor.
  /// Erzeugt ein leeres weißes Bild der Standardgröße 200×100
  Drawing() : img(200, 100, QImage::Format_RGB32), sleepMilli(defaultSleepMilli)
  { img.fill(0xffffff); }

  /// Kopier-Konstruktor
  Drawing(const Drawing& d2) : img(d2.img.copy()), sleepMilli(d2.sleepMilli) {}    

  /// Konstruktor für vorgegebene Breite \p w und Höhe \p h.
  /// Der Hintergrund wird automatisch auf weiß gesetzt.
  Drawing(int w, int h)
    : img(w, h, QImage::Format_RGB32), sleepMilli(defaultSleepMilli)
  { img.fill(0xffffff); }

  /// Konstruktor für vorgegebene Breite \p w, Höhe \p h und
  /// Hintergrundfarbe \p colour
  Drawing(int w, int h, const DrawColour& colour)
    : img(w, h, QImage::Format_RGB32), sleepMilli(defaultSleepMilli)
  { img.fill(colour.rgb()); }

  /// Destruktor. Informiert DrawWindow über das Ableben dieser Instanz.
  ~Drawing();

  /// Gibt die Breite des Bildes aus
  int getWidth() const { return img.width(); };

  /// Gibt die Hoehe des Bildes aus
  int getHeight() const { return img.height(); };

  /// Liefert Zeiger auf das enthaltene Image
  const QImage* getImage() const { return &img; }

  /// Liefert Zeiger auf Mutex zum Sperren des Bildzugriffs
  QMutex* getMutex() const { return &imgMutex; }

  /// Ändert den Zoomfaktor für des Fensters, falls es angezeigt wird
  void setZoom(int z);

  /// Zeigt dieses Bild im Graphikfenster an, ersetzt bisherigen Fensterinhalt
  void show() const;

  /// Informiert das Zeichenfenster über Veränderungen
  void update() const;

  /// Zuweisungsoperator
  Drawing& operator=(const Drawing& d2);

  /// Setzt das ganze Bild auf die Farbe \p colour
  Drawing& operator=(DrawColour colour);

  /// Lädt die Bilddatei \p filename
  void loadImage(const std::string& filename);

  /// Speichert das Bild im pgm-Format in der Datei \p filename
  void savePGM(const std::string& filename) const;

  /// Speichert das Bild im ppm-Format in der Datei \p filename
  void savePPM(const std::string& filename) const;

  /// Speichert das Bild im png-Format in der Datei \p filename
  void savePNG(const std::string& filename) const;

  /// Liefert die Farbe des Pixels an Position (\p x, \p y)
  DrawColour getPointColour(int x, int y) const;

  /// Liefert die Farbe des Pixels an Position \p p
  DrawColour getPointColour(IPoint2D p) const
  { return getPointColour(p.x,p.y); }

  /// Setzt die Wartezeit für verzögertes Malen
  void setSleepTime(int milli){ sleepMilli = milli; }

  /// Zeichnet einen Punkt der Farbe \p colour an Position (\p x, \p y)
  /// ins Bild.
  /// Falls \p drawslow auf \p true gesetzt ist, werden die Punkte verzögert
  /// gezeichnet.
  /// Falls \p drawXOR auf \p true gesetzt ist, werden die Punkte im
  /// XOR-Modus gefärbt, die Pixelfarbe also mit der Hintergrundfarbe
  /// kombiniert.
  void drawPoint(int x, int y, DrawColour colour = 0, bool drawslow = false, bool drawXOR = false);

  /// Zeichnet einen Punkt der Farbe \p colour an Position \p p ins Bild.
  /// Falls \p drawslow auf \p true gesetzt ist, werden die Punkte verzögert
  /// gezeichnet.
  /// Falls \p drawXOR auf \p true gesetzt ist, werden die Punkte im
  /// XOR-Modus gefärbt, die Pixelfarbe also mit der Hintergrundfarbe
  /// kombiniert.
  void drawPoint(IPoint2D p, DrawColour colour = 0, bool drawslow = false, bool drawXOR = false)
  { drawPoint(p.x, p.y, colour, drawslow, drawXOR); }

  /// Zeichnet eine Linie der Farbe \p colour von (\p x1, \p y1) nach
  /// (\p x2 \p y2) ins Bild.
  void drawLine(int x1, int y1, int x2, int y2, DrawColour colour = 0,
                bool drawslow = false);

  /// Zeichnet eine Linie der Farbe \p colour von \p p1 nach \p p2 ins Bild.
  void drawLine(IPoint2D p1, IPoint2D p2, DrawColour colour = 0,
                bool drawslow = false)
  { drawLine(p1.x, p1.y, p2.x, p2.y, colour, drawslow); }

  /// Zeichnet einen Kreis mit Mittelpunkt \p c und Radius \p r ins Bild.
  /// Der Rand hat die Farbe \p fg; falls \p filled auf \p true gesetzt ist,
  /// wird mit Farbe \p bg gefüllt.
  void drawCircle(IPoint2D c, int r, bool filled = false, DrawColour fg = 0,
                  DrawColour bg = 255, bool drawslow = false);

  /// Zeichnet ein Polygon mit Ecken \p e ins Bild.
  /// Der Rahmen hat die Farbe \p fg; falls \p filled auf \p true gesetzt ist,
  /// wird mit Farbe \p bg gefüllt.
  void drawPolygon(const std::vector<IPoint2D>& e, bool filled = false,
                   DrawColour fg = 0, DrawColour bg = 255,
                   bool drawslow = false);

  /// Zeichnet den Text \p text mit der Frabe \p colour an die Position \p pos
  /// ins Bild.
  void drawText(IPoint2D pos, const std::string& text, DrawColour colour = 0);

  /// Erzeugt eine Animation namens \p filename.type aus den Einzelbildern in
  /// pics.
  /// Falls \p type = \c "gif", wird eine animierte gif-Datei erzeugt;
  /// falls \p type = \c "mpg" eine MPEG-Datei.
  /// \p delay ist bei gif-Animtionen der Zeitabstand zwischen zwei Bildern.
  static void makeanim(const std::vector<Drawing>& pics,
                       const std::string& filename, const std::string& type,
                       int delay = 4);
};

#endif
