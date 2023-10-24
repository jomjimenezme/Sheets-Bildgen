/// \file    drawwindow.cc
/// \author  Holger Arndt, Martin Galgon
/// \version 0.3
/// \date    11.11.2016

#include <QMutexLocker>
#include <QPainter>
#include <QPaintEvent>
#include <QWaitCondition>
#include "drawing.h"
#include "drawwindow.h"

DrawWindow* DrawWindow::theInstance = nullptr;

void DrawWindow::center()
{
  setGeometry(
    QStyle::alignedRect(
      Qt::LeftToRight,
      Qt::AlignCenter,
      size(),
      static_cast<QApplication*>(QApplication::instance())->desktop()->availableGeometry()
    )
  );
}

void DrawWindow::closeEvent(QCloseEvent* ce)
{
  if(allow_close){
    allow_close->wakeAll();
    ce->accept(); // Oder alle ignorieren und qApp->setQuitOnLastWindowClosed aus
  }else ce->ignore();
}

void DrawWindow::paintEvent(QPaintEvent* pe)
{
  QPainter pnt(this);
  if (zoom != 1)
    {
      QMatrix mat;
      mat.scale(zoom, zoom);
      pnt.setMatrix(mat);
    }
  if (currentDrw != nullptr)
    {
      QMutexLocker locker(currentDrw->getMutex());
      pnt.drawImage(0, 0, *currentDrw->getImage());
    }
  else
    pnt.drawText(0, 0, width() / zoom, height() / zoom, Qt::AlignCenter,
                 "No drawing assigned");
  pnt.end();
}

DrawWindow* DrawWindow::getInstance()
{
  if (theInstance == nullptr)
    theInstance = new DrawWindow;
  return theInstance;
}

void DrawWindow::setZoom(int z)
{
  if (zoom != z)
    {
      zoom = z;
      if (currentDrw != nullptr)
        setFixedSize(currentDrw->getWidth() * zoom,
                     currentDrw->getHeight() * zoom);
      else
        setFixedSize(200 * zoom, 100 * zoom);
//       center();
      update();
    }
}

void DrawWindow::changeSize(QWaitCondition* changedSize)
{
  if (currentDrw != nullptr){
    setFixedSize(currentDrw->getWidth() * zoom, currentDrw->getHeight() * zoom);
//     center();
  }
  update();
  changedSize->wakeAll();
}

void DrawWindow::changeDrawing(const Drawing* drw,
                               QWaitCondition* madeActive)
{
  if (drw != currentDrw)
    {
      bool fresh = (currentDrw == nullptr);
      currentDrw = drw;
      setFixedSize(currentDrw->getWidth() * zoom,
                   currentDrw->getHeight() * zoom);
     if(fresh) center();
     update();
    }
  madeActive->wakeAll();
}

void DrawWindow::noDrawing(const Drawing* drw, QWaitCondition* forDeletion)
{
  if(drw == currentDrw)
    {
      currentDrw = nullptr;
      update(); // maybe omit
    }
  forDeletion->wakeAll();
}

void DrawWindow::allowClose(QWaitCondition* closeWindow)
{
  allow_close = closeWindow;
}
