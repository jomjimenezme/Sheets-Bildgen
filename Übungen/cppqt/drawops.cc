/// \file    drawops.cc
/// \author  Holger Arndt, Martin Galgon
/// \version 0.7
/// \date    16.09.2015

#include <QMutex>
#include <QMutexLocker>
#include <QWaitCondition>
#include "drawing.h"
#include "drawops.h"

DrawOps* DrawOps::theInstance = nullptr;

DrawOps* DrawOps::getInstance()
{
  if (theInstance == nullptr)
    theInstance = new DrawOps;
  return theInstance;
}

void DrawOps::makeActive(const Drawing* drw)
{
  QWaitCondition madeActive;
  QMutex mutex;
  QMutexLocker locker(&mutex);
  emit sigActivate(drw, &madeActive);
  madeActive.wait(&mutex);
}

void DrawOps::changeSize()
{
  QWaitCondition changedSize;
  QMutex mutex;
  QMutexLocker locker(&mutex);
  emit sigSize(&changedSize);
  changedSize.wait(&mutex);
}

void DrawOps::updateIfActive(const Drawing* drw)
{
  if (drw == DrawWindow::getInstance()->getDrawing())
    emit sigUpdate();
}

void DrawOps::obituary(const Drawing* drw)
{
  QWaitCondition forDeletion;
  QMutex mutex;
  QMutexLocker locker(&mutex);
  emit sigDead(drw, &forDeletion);
  forDeletion.wait(&mutex);
}
