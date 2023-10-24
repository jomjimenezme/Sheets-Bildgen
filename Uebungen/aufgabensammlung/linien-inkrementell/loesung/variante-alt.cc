// Scan Conversion für Linien
// Autor:  Sebastian Birk
// Datum:  2013-10-27

  /*
   * Variante von Herrn Grosche - äquivalent zu Brunos Version.
   */

#include <iostream>
#include <cmath>
#include <unistd.h>

#include <cppqt.h>

using namespace std;

void drawLine(Drawing& pic, IPoint2D p1, IPoint2D p2, int colour = 0)
{
  // zeichnet eine Linie von p1 nach p2
  int dx = p2.x - p1.x;
  int dy = p2.y - p1.y;
  int x = p1.x;
  int y = p1.y;

  // Sonderfälle zuerst
  if (dy == 0)
    // Linie W-O oder O-W
    for (x = min(p1.x,p2.x); x <= max(p1.x,p2.x); x++)
      pic.drawPoint(x, y, colour, true);
  else if (dx == 0)
    // Linie N-S oder S-N
    for (y = min(p1.y,p2.y); y <= max(p1.y,p2.y); y++)
      pic.drawPoint(x, y, colour, true);
  else {
    double m = double(dy) / dx;

    if (m > 0 && m <= 1 && p1.x < p2.x) {
      // Linie WSW-ONO
      int d = 2 * dy - dx;
      int incrO = 2 * dy;
      int incrNO = 2 * (dy - dx);
      pic.drawPoint(x, y, colour, true);
      for (x++; x <= p2.x; x++) {
        if (d <= 0)
          d += incrO;
        else {
          d += incrNO;
          y++;
        }
        pic.drawPoint(x, y, colour, true);
      }
    }
    else if (m > 0 && m <= 1 && p1.x > p2.x) {
      // Linie ONO-WSW
      int d = -2 * dy + dx;
      int incrW = -2 * dy;
      int incrSW = -2 * (dy - dx);
      pic.drawPoint(x, y, colour, true);
      for (x--; x >= p2.x; x--)
      {
        if (d < 0)
          d += incrW;
        else {
          d += incrSW;
          y--;
        }
        pic.drawPoint(x, y, colour, true);
      }
    }
    else if (m < 0 && m >= -1 && p1.x < p2.x) {
      // Linie WNW-OSO
      int d = -2 * dy - dx;
      int incrO = -2 * dy;
      int incrSO = 2 * (-dy - dx);
      pic.drawPoint(x, y, colour, true);
      for (x++; x <= p2.x; x++) {
        if (d <= 0)
          d += incrO;
        else {
          d += incrSO;
          y--;
        }
        pic.drawPoint(x, y, colour, true);
      }
    }
    else if (m < 0 && m >= -1 && p1.x > p2.x) {
      // Linie OSO-WNW
      int d = 2 * dy + dx;
      int incrW = 2 * dy;
      int incrNW = 2 * (dy + dx);
      pic.drawPoint(x, y, colour, true);
      for (x--; x >= p2.x; x--) {
        if (d < 0)
          d += incrW;
        else {
          d += incrNW;
          y++;
        }
        pic.drawPoint(x, y, colour, true);
      }
    }
    else if (m > 1 && p1.y < p2.y) {
      // Linie SSW-NNO
      int d = 2 * dx - dy;
      int incrN = 2 * dx;
      int incrNO = 2 * (dx - dy);
      pic.drawPoint(x, y, colour, true);
      for (y++; y <= p2.y; y++) {
        if (d <= 0)
          d += incrN;
        else {
          d += incrNO;
          x++;
        }
        pic.drawPoint(x, y, colour, true);
      }
    }
    else if (m > 1 && p1.y > p2.y) {
      // Linie NNO-SSW
      int d = -2 * dx + dy;
      int incrS = -2 * dx;
      int incrSW = -2 * (dx - dy);
      pic.drawPoint(x, y, colour, true);
      for (y--; y >= p2.y; y--) {
        if (d < 0)
          d += incrS;
        else {
          d += incrSW;
          x--;
        }
        pic.drawPoint(x, y, colour, true);
      }
    }
    else if (p1.y < p2.y) { // && m < -1
      // Linie SSO-NNW
      int d = -2 * dx - dy;
      int incrN = -2 * dx;
      int incrNW = 2 * (-dx - dy);
      pic.drawPoint(x, y, colour, true);
      for (y++; y <= p2.y; y++) {
        if (d <= 0)
          d += incrN;
        else {
          d += incrNW;
          x--;
        }
        pic.drawPoint(x, y, colour, true);
      }
    }
    else {
      // Linie NNW-SSO
      int d = 2 * dx + dy;
      int incrS = 2 * dx;
      int incrSO = 2 * (dx + dy);
      pic.drawPoint(x, y, colour, true);
      for (y--; y >= p2.y; y--) {
        if (d < 0)
          d += incrS;
        else {
          d += incrSO;
          x++;
        }
        pic.drawPoint(x, y, colour, true);
      }
    }
  }
}

int maindraw()
{
  Drawing pic(200, 200);

  pic.show();
  pic.setZoom(3);

  IPoint2D p1, p2;
  int colour;

  while (true) {
    cout << "Eingabe von p1, p2, colour: ";
    cin >> p1 >> p2 >> colour;
    if (p1.x < 0 || p1.y < 0 || p2.x < 0 || p2.y < 0)
      break;
    drawLine(pic, p1, p2, colour);
  }

  cout << endl;
  IOThread::waitForWindow(60);

  return 0;
}

