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
  // +++++++++++++
  // Hier ergänzen
  //
  // Hinweise:
  //   - f_min und f_max ermitteln
  //   - Koordinatenkreuz zeichnen
  //   - Funktion plotten
}


int maindraw()
{
  Drawing pic( 500, 500 );
  pic.show();

  // lin. Funktion
  std::function<double(double)> f0 = [](double d)->double{ return .5 + .5*d; };
  plotter( pic, -5.0, 5.0, f0 );
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


