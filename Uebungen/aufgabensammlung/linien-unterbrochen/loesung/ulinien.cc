// Datei:  ulinien.cpp
// Autor:  Sebastian Birk
// Datum:  2013-11-10

#include <iostream>
#include <cmath>
#include <unistd.h>
#include <vector>

#include <cppqt.h>

using namespace std;

void drawLine(Drawing& pic, IPoint2D p1, IPoint2D p2, vector<float> mask, int colour = 0)
{
  // zeichnet eine Linie von p1 nach p2
  int dx = p2.x - p1.x;
  int dy = p2.y - p1.y;
  int x = p1.x;
  int y = p1.y;

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // lambda-Funktion, die die Pixelfarbe anhand der Maske berechnet
  auto calcMaskColour = [colour] (vector<float> _mask, int _point, int _refpoint) {
    return (int)( 255 - _mask[abs(_point-_refpoint) % _mask.size()] * (255-colour) );
  };

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // Sonderfälle zuerst
  if (dy == 0)
    // Linie W-O oder O-W
    if (p1.x < p2.x)
      for (; x <= p2.x; x++)
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    else
      for (; x >= p2.x; x--)
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  else if (dx == 0)
    // Linie N-S oder S-N
    if (p1.y < p2.y)
      for (; y <= p2.y; y++)
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    else
      for (; y >= p2.y; y--)
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  else {
    double m = double(dy) / dx;

    // Maske auf Steigung m umrechnen
    float scale = sqrt(dx*dx + dy*dy)/max(abs(dx),abs(dy));
    // kürzere Maske erstellen
    vector<float> mmask( (int)floor(mask.size()/scale) );
    // interpolieren
    for ( size_t i = 0; i < mmask.size(); i++ ) {
      size_t pos = (size_t)(i*scale);
      float inter = 1.0 - (i*scale - pos);
      mmask[i] = inter*mask[pos] + (1-inter)*mask[(pos+1) % mask.size()];
    }

    if (m > 0 && m <= 1 && p1.x < p2.x) {
      // Linie WSW-ONO
      int M = 2*dy;
      int Halb = dx;
      int Eins = 2*Halb;
      int D = 0;
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      pic.drawPoint(x, y, calcMaskColour(mmask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      for( x++; x <= p2.x; x++ ) {
        D += M;
        if ( D > Halb ) { // NO
          y++;
          D -= Eins;
        }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mmask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      }
    }
    else if (m > 0 && m <= 1 && p1.x > p2.x) {
      // Linie ONO-WSW
      int M = -2*dy;
      int Halb = -dx;
      int Eins = 2*Halb;
      int D = 0;
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      pic.drawPoint(x, y, calcMaskColour(mmask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      for( x--; x >= p2.x; x-- ) {
        D += M;
        if ( D >= Halb ) { // SW
          y--;
          D -= Eins;
        }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mmask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      }
    }
    else if (m < 0 && m >= -1 && p1.x < p2.x) {
      // Linie WNW-OSO
      int M = 2*dy;
      int Halb = dx;
      int Eins = 2*Halb;
      int D = 0;
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      pic.drawPoint(x, y, calcMaskColour(mmask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      for( x++; x <= p2.x; x++ ) {
        D -= M;
        if ( D > Halb ) {
          y--;
          D -= Eins;
        }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mmask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      }
    }
    else if (m < 0 && m >= -1 && p1.x > p2.x) {
      // Linie OSO-WNW
      int M = -2*dy;
      int Halb = -dx;
      int Eins = 2*Halb;
      int D = 0;
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      pic.drawPoint(x, y, calcMaskColour(mmask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      for( x--; x >= p2.x; x-- ) {
        D -= M;
        if ( D >= Halb ) {
          y++;
          D -= Eins;
        }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mmask,x,p1.x), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      }
    }
    else if (m > 1 && p1.y < p2.y) {
      // Linie SSW-NNO
      int M = 2*dx;
      int Halb = dy;
      int Eins = 2*Halb;
      int D = 0;
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      pic.drawPoint(x, y, calcMaskColour(mmask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      for( y++; y <= p2.y; y++ ) {
        D += M;
        if ( D > Halb ) { // NO
          x++;
          D -= Eins;
        }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mmask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      }
    }
    else if (m > 1 && p1.y > p2.y) {
      // Linie NNO-SSW
      int M = -2*dx;
      int Halb = -dy;
      int Eins = 2*Halb;
      int D = 0;
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      pic.drawPoint(x, y, calcMaskColour(mmask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      for( y--; y >= p2.y; y-- ) {
        D += M;
        if ( D >= Halb ) { // SW
          x--;
          D -= Eins;
        }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mmask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      }
    }
    else if (p1.y < p2.y) { // && m < -1
      // Linie SSO-NNW
      int M = 2*dx;
      int Halb = dy;
      int Eins = 2*Halb;
      int D = 0;
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      pic.drawPoint(x, y, calcMaskColour(mmask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      for( y++; y <= p2.y; y++ ) {
        D -= M;
        if ( D > Halb ) {
          x--;
          D -= Eins;
        }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mmask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      }
    }
    else {
      // Linie NNW-SSO
      int M = -2*dx;
      int Halb = -dy;
      int Eins = 2*Halb;
      int D = 0;
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      pic.drawPoint(x, y, calcMaskColour(mmask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      for( y--; y >= p2.y; y-- ) {
        D -= M;
        if ( D >= Halb ) {
          x++;
          D -= Eins;
        }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        pic.drawPoint(x, y, calcMaskColour(mmask,y,p1.y), true);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      }
    }
  }
}

int maindraw()
{
  Drawing pic(201, 201);

  pic.show();
  pic.setZoom(3);

  IPoint2D p1, p2;
  int colour;

  vector<float> mask;

  cout << "Eingabe der Maske (0,1), Ende mit -1: ";
  float val;
  do {
    cin >> val;
    if (val >= 0.0 && val <= 1.0)
      mask.push_back(val);
  } while (val >= 0.0);

  while (true) {
    cout << "Eingabe von p1, p2, colour: ";
    cin >> p1 >> p2 >> colour;
    if (p1.x < 0 || p1.y < 0 || p2.x < 0 || p2.y < 0)
      break;
    drawLine(pic, p1, p2, mask, colour);
  }

  cout << endl;
  IOThread::waitForWindow(60);

  return 0;
}

