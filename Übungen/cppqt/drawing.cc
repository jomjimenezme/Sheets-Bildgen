/// \file    drawing.cc
/// \author  Holger Arndt, Sebastian Birk, Martin Galgon
/// \version 0.2.2
/// \date    16.09.2015

#include <iostream>
#include <iomanip>
#include <sstream>
#include <string>
#include <QMutexLocker>
#include <QPainter>
#include <QPoint>
#include <QPolygon>
#include "drawcolour.h"
#include "drawing.h"
#include "drawops.h"
#include "iothread.h"

using namespace std;

Drawing::~Drawing()
{ DrawOps::getInstance()->obituary(this); }

void Drawing::setZoom(int z)
{
  if (DrawWindow::getInstance()->getDrawing() == this)
    DrawOps::getInstance()->setZoom(z);
}

void Drawing::show() const
{ DrawOps::getInstance()->makeActive(this); }

void Drawing::update() const
{ DrawOps::getInstance()->updateIfActive(this); }

Drawing& Drawing::operator=(const Drawing& d2)
{
  if (this != &d2)
    {
      img = d2.img.copy();
      DrawOps::getInstance()->changeSize();
    }
  return *this;
}

Drawing& Drawing::operator=(DrawColour colour)
{
  {
    QMutexLocker locker(&imgMutex);
    img.fill(colour.rgb());
  }
  update();
  return *this;
}

void Drawing::loadImage(const string& filename)
{
  img.load(filename.c_str());
  DrawOps::getInstance()->changeSize();
}

void Drawing::savePGM(const string& filename) const
{ img.save(filename.c_str(), "PGM"); }

void Drawing::savePPM(const string& filename) const
{ img.save(filename.c_str(), "PPM"); }

void Drawing::savePNG(const string& filename) const
{ img.save(filename.c_str(), "PNG"); }

DrawColour Drawing::getPointColour(int x, int y) const
{
  QColor c;
  if (x >= 0 && y >= 0 && x < getWidth() && y < getHeight())
    {
      QMutexLocker locker(&imgMutex);
      c = QColor(img.pixel(x,getHeight() - y - 1));
    }
  return DrawColour(c);
}

void Drawing::drawPoint(int x, int y, DrawColour colour, bool drawslow, bool drawXOR)
{
  if (x >= 0 && y >= 0 && x < getWidth() && y < getHeight())
    {
      {
        QMutexLocker locker(&imgMutex);
        QPainter pnt(&img);
        if(drawXOR) pnt.setCompositionMode(QPainter::RasterOp_SourceXorDestination);
        pnt.setPen(colour);
        pnt.drawPoint(x, getHeight() - y - 1);
        pnt.end();
      }
      update();
      if (drawslow)
        IOThread::msleep(sleepMilli);
    }
}

void Drawing::drawLine(int x1, int y1, int x2, int y2, DrawColour colour,
                       bool drawslow)
{
  {
    QMutexLocker locker(&imgMutex);
    QPainter pnt(&img);
    pnt.setPen(colour);
    pnt.drawLine(x1, getHeight() - y1 - 1, x2, getHeight() - y2 - 1);
    pnt.end();
  }
  update();
  if (drawslow)
    IOThread::msleep(sleepMilli);
}

void Drawing::drawCircle(IPoint2D c, int r, bool filled, DrawColour fg,
                         DrawColour bg, bool drawslow)
{
  {
    QMutexLocker locker(&imgMutex);
    QPainter pnt(&img);
    pnt.setPen(fg);
    if (!filled)
      pnt.setBrush(Qt::NoBrush);
    else
      pnt.setBrush(bg);
    pnt.drawEllipse(c.x - r, getHeight() - c.y - r - 1, 2 * r, 2 * r);
    pnt.end();
  }
  update();
  if (drawslow)
    IOThread::msleep(sleepMilli);
}

void Drawing::drawPolygon(const vector<IPoint2D>& e, bool filled, DrawColour fg,
                          DrawColour bg, bool drawslow)
{
  {
    QMutexLocker locker(&imgMutex);
    QPainter pnt(&img);
    pnt.setPen(fg);
    if (!filled)
      pnt.setBrush(Qt::NoBrush);
    else
      pnt.setBrush(bg);
    QPolygon pg(e.size());
    for (unsigned int i = 0; i < e.size(); ++i)
      pg[i] = QPoint(e[i].x, getHeight() - e[i].y - 1);
    pnt.drawPolygon(pg);
    pnt.end();
  }
  update();
  if (drawslow)
    IOThread::msleep(sleepMilli);
}

void Drawing::drawText(IPoint2D pos, const std::string& text, DrawColour colour)
{
  {
    QMutexLocker locker(&imgMutex);
    QPainter pnt(&img);
    pnt.setPen(colour);
    pnt.drawText(pos.x, getHeight() - pos.y - 1, QString(text.c_str()));
    pnt.end();
  }
  update();
}

void Drawing::makeanim(const vector<Drawing>& pics, const string& filename,
                       const string& type, int delay)
{
  cout << "Speichere Bilder:" << endl;
  for (unsigned int i = 0; i < pics.size(); i++)
    {
      ostringstream nameoss;
      cout << i << endl;
      nameoss << filename << '_' << setw(4) << setfill('0') << i << ".ppm"
              << ends;
      pics[i].savePPM(nameoss.str());
    }

  cout << "Erzeuge Animation" << endl;
  ostringstream cmdoss;
  if (type == "gif")
    cmdoss << "convert -delay " << delay << ' ' << filename << "_????.ppm "
           << filename << ".gif" << ends;
  else if (type == "mpg")
    cmdoss << "convert " << filename << "_????.ppm " << filename << ".mpg"
           << ends;

  system(cmdoss.str().c_str());

  ostringstream rmoss;
  rmoss << "rm -f " << filename << "_????.ppm" << ends;
  system(rmoss.str().c_str());
}
