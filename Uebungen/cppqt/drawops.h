/// \file    drawops.h
/// \author  Holger Arndt, Martin Galgon
/// \version 0.7
/// \date    16.09.2015

#ifndef DRAWOPS_H
#define DRAWOPS_H

class DrawOps;

#include <QObject>
#include <QWaitCondition>
#include "drawing.h"
#include "drawwindow.h"

/// Klasse zur Bereitstellung von Zeichenoperationen und zur Kommunikation mit
/// dem Zeichenfenster. Verwendet Singleton-Pattern
class DrawOps : public QObject
{
  Q_OBJECT

private:
  static DrawOps* theInstance;

  DrawOps() {};

public:
  /// Liefert Zeiger auf die einzige DrawOps-Instanz
  static DrawOps* getInstance();

  /// Ändert den Zoomfaktor für des Fensters
  void setZoom(int z) { emit sigZoom(z); }

  /// Aktiviert eine Zeichnung, d.h. Anzeige im Graphikfenster
  void makeActive(const Drawing* img);

  /// Informiert das Zeichenfenster über eine geänderte Größe
  void changeSize();

  /// Informiert das Zeichenfenster über Veränderungen, falls \p pm gerade
  /// angezeigt wird
  void updateIfActive(const Drawing* drw);

  /// Informiert das Zeichenfenster über das Ableben einer Drawing-Instanz.
  /// Blockiert, bis das Fenster das Signal bestätigt hat.
  void obituary(const Drawing* drw);

signals:
  void sigZoom(int z);
  void sigActivate(const Drawing* drw, QWaitCondition* madeActive);
  void sigSize(QWaitCondition* changedSize);
  void sigUpdate();
  void sigDead(const Drawing* drw, QWaitCondition* forDeletion);
};

#endif
