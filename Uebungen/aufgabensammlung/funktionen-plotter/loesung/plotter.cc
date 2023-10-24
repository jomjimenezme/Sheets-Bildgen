// Datei:  plotter.cpp
// Autor:  Sebastian Birk
// Datum:  21.10.2013

#include <iostream>
#include <functional>
#include <cmath>

#include <cppqt.h>

using namespace std;

void plotter( Drawing &pic, double left, double right,
              std::function<double(double)> &func )
{
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  // Geg.: left, right (in Funktionskoordinaten)

  double w = pic.getWidth();
  double h = pic.getHeight();

  // f_min und f_max ermitteln (in Funktionskoordinaten)
  double fmin = func(left);
  double fmax = func(right);

  // Pixelkoordinaten --> Funktionskoordinaten
  // Pixelbreite: (right - left) / w
  for (int i=0; i<w; ++i) {
    double f = func( left + i*(right-left)/w );
    fmin = (f<fmin) ? f : fmin;
    fmax = (f>fmax) ? f : fmax;
  }

  // Koordinatenkreuz zeichen
  // (in Funktionskoordinaten) 0 --> Pixelkoordinaten
  //
  //       0 = left + pix * (right - left) / w
  //   =>  pix = -left * w / (right - left)
  //
  //       0 = fmin + pix * (fmax - fmin) / h
  //   =>  pix = -fmin * h / (fmax - fmin)
  //
  if (fmin < 0 && fmax > 0)
    for (int i=0; i<w; ++i)
      pic.drawPoint( i, -fmin/(fmax-fmin)*h, DrawColour(0,0,0) );
  if (left < 0 && right > 0)
    for (int i=0; i<h; ++i)
      pic.drawPoint( -left/(right-left)*w, i, DrawColour(0,0,0) );

  // Funktion plotten
  // Pixelkoordinaten_x --> Funktionskoordinaten_x
  // Funktionskoordinaten_y = func( Funktionskoordinaten_x )
  // Funktionskoordinaten_y --> Pixelkoordinaten_y
  for (int i=0; i<w; ++i)
    pic.drawPoint( i, h*(func( left + i*(right-left)/w )-fmin)/(fmax-fmin),
                   DrawColour(0,0,255) );
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}


int maindraw()
{
  Drawing pic( 500, 500 );
  pic.show();

  // lin. Funktion
  std::function<double(double)> f0 = [](double d)->double{ return .5 + .5*d; };
  plotter( pic, -5.0, 1.0, f0 );
  cout << "Weiter mit Return" << endl;
  cin.get();

  // sinus
  pic = DrawColour(255,255,255);
  std::function<double(double)> f1 = [](double d)->double{ return sin(d); };
  plotter( pic, -5.0, 5.0, f1 );
  cout << "Weiter mit Return" << endl;
  cin.get();

  // sqrt-1
  pic = DrawColour(255,255,255);
  std::function<double(double)> f2 = [](double d)->double{ return sqrt(d)-1.0; };
  plotter( pic, 0.0, 4.0, f2 );
  cout << "Weiter mit Return" << endl;
  cin.get();

  // 1/x
  pic = DrawColour(255,255,255);
  std::function<double(double)> f3 = [](double d)->double{ return 1.0/d; };
  plotter( pic, 0.2, 3.0, f3 );

  cout << endl;
  IOThread::waitForWindow(60);

  return 0;
}


