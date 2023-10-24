/// \file    main.cc
/// \author  Holger Arndt, Martin Galgon
/// \version 0.4
/// \date    11.11.2016

#include <QApplication>
#include <QObject>
#include <QWaitCondition>
#include "drawing.h"
#include "drawops.h"
#include "drawwindow.h"
#include "iothread.h"
#include "maindraw.h"

/// Dieses Hauptprogramm ist für alle Draw-Programme fest.
/// Als Pseudo-Hauptprogramm dient die Funktion \p maindraw.
int main(int argc, char** argv)
{
  QApplication drawApp(argc, argv);
  IOThread* ioThr;
  DrawOps* drawOps;
  DrawWindow* drawWin;

  ioThr = IOThread::getInstance();
  drawOps = DrawOps::getInstance();
  drawWin = DrawWindow::getInstance();
 
  // Der Umweg über QueuedConnections ist notwendig, da der X-Server es nicht
  // mag, wenn Graphikoperationen von anderen Threads als dem GUI-Thread
  // ausgelöst werden.
  // # Auto connection is the default and falls back to either direct
  // # connection or queued connection, depending on whether the signal
  // # is emitted in the same thread that owns the receiving object. MG
  QObject::connect(drawOps, &DrawOps::sigZoom, drawWin, &DrawWindow::setZoom,
                   Qt::QueuedConnection);
  QObject::connect(drawOps, &DrawOps::sigActivate, drawWin,
                   &DrawWindow::changeDrawing, Qt::QueuedConnection);
  QObject::connect(drawOps, &DrawOps::sigSize, drawWin, &DrawWindow::changeSize,
                   Qt::QueuedConnection);
  QObject::connect(drawOps, &DrawOps::sigUpdate, drawWin,
                   static_cast<void (DrawWindow::*)()>(&DrawWindow::update),
                   Qt::QueuedConnection);
  QObject::connect(drawOps, &DrawOps::sigDead, drawWin, &DrawWindow::noDrawing,
                   Qt::QueuedConnection);
  QObject::connect(ioThr, &IOThread::finished, &drawApp, &QApplication::quit,
                   Qt::QueuedConnection);
  QObject::connect(ioThr, &IOThread::sigAllowClose, drawWin, &DrawWindow::allowClose,
                   Qt::QueuedConnection);

  // Alternativ könnte das Fenster weiterhin alle closeEvents ignorieren.
  // Der IOThread würde dann die Zwangschließung üebrnehmen.
  qApp->setQuitOnLastWindowClosed(false);

  ioThr->start();
  drawApp.exec();
  ioThr->wait();

  return 0;
}
