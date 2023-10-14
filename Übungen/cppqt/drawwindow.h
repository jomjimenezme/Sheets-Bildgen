/// \file    drawwindow.h
/// \author  Holger Arndt, Martin Galgon
/// \version 0.3
/// \date    11.11.2016

#ifndef DRAWWINDOW_H
#define DRAWWINDOW_H

class DrawWindow;

#include <QCloseEvent>
#include <QMatrix>
#include <QPaintEvent>
#include <QWaitCondition>
#include <QWidget>
#include "drawing.h"

#include <QApplication>
#include <QStyle>
#include <QDesktopWidget>

/// Das Fenster zum Anzeigen eines Bildes, verwendet Singleton-Pattern
class DrawWindow : public QWidget
{
  Q_OBJECT

private:
  /// Die DrawWindow Instanz
  static DrawWindow* theInstance;
  /// Signalisiert dem IOThread, dass das Fenster geschlossen wurde
  QWaitCondition* allow_close = nullptr;
  /// Das momentan angezeigte Drawing
  const Drawing* currentDrw;
  /// Zoomfaktor
  int zoom;

  /// Default-Konstruktor
  DrawWindow() : QWidget(), currentDrw(nullptr), zoom(1)
  {
    setFixedSize(200, 100);
    setWindowFlags(Qt::WindowStaysOnTopHint);
    center();
    show();
  }

  /// Fenster auf Bildschirm zentrieren
  void center();

protected:
  // Das Fenster wird am Ende des IOThreads automatisch geschlossen,
  // manuelles Schließen muss verhindert werden
  virtual void closeEvent(QCloseEvent* ce) override;

  virtual void paintEvent(QPaintEvent* pe) override;

public:
  /// Liefert Zeiger auf das einzige DrawWindow
  static DrawWindow* getInstance();

  /// Liefert Zeiger auf die aktuell angezeigte Zeichnung
  const Drawing* getDrawing() { return currentDrw; }

public slots:
  /// Ändert den Zoomfaktor für die Anzeige
  void setZoom(int z);

  /// Passt das Fenster an eine geänderte Bildgröße an
  void changeSize(QWaitCondition* changedSize);

  /// Verknüpft das Fenster mit einer anderen Zeichnung
  void changeDrawing(const Drawing* drw, QWaitCondition* madeActive);

  /// Löst die Verknüpfung des Fensters mit einer Zeichnung, wenn
  /// diese gerade angezeigt wird
  void noDrawing(const Drawing* drw, QWaitCondition* forDeletion);

  /// Aktiviert die Möglichkeit zum Schließen des Fensters
  void allowClose(QWaitCondition* closeWindow);
};

#endif
