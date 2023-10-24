// Parallelogramme und Kreise mit Muster
// Autor:  Sebastian Birk
// Datum:  2013-11-04

#include <iostream>
#include <cmath>
#include <unistd.h>
#include <string>
#include <cctype>
#include <deque>

#include <cppqt.h>

using namespace std;

const bool drawSlow = true;
const int muster_dichte = 5;

void fuellen( Drawing& pic, IPoint2D where, IPoint2D referenz, char muster,
              const DrawColour &farbe1, const DrawColour &farbe2 )
{
  // +++++++++++++
  // Hier ergänzen
  //
}

void parallelogramm( Drawing& pic, IPoint2D P1, IPoint2D P2, IPoint2D P3, char muster,
                     const DrawColour &farbe1, const DrawColour &farbe2 )
{
  // +++++++++++++
  // Hier ergänzen
  //
}

void kreis( Drawing& pic, IPoint2D M, int radius, char muster,
            const DrawColour &farbe1, const DrawColour &farbe2 )
{
  // +++++++++++++
  // Hier ergänzen
  //
}

int maindraw()
{
  Drawing pic(200, 200);
  pic.show();
  pic.setZoom(2);

  while (true)
  {
    cout << "[P]arallelogramm, [K]reis oder [B]eenden: ";
    char eingabe;
    cin >> eingabe;
    if (toupper(eingabe) == 'B')
      break;
    else if (toupper(eingabe) == 'P') {
      IPoint2D P1, P2, P3;
      char muster;
      DrawColour farbe1, farbe2;
      cout << "P1, P2, P3: ";
      cin >> P1 >> P2 >> P3;
      cout << "Muster ([V]oll, [N]ord-Ost, [S]ued-Ost, [K]aros): ";
      cin >> muster;
      cout << "Farbe 1: ";
      cin >> farbe1;
      cout << "Farbe 2: ";
      cin >> farbe2;
      parallelogramm(pic, P1, P2, P3, muster, farbe1, farbe2);
    }
    else if (toupper(eingabe) == 'K') {
      IPoint2D M;
      int radius;
      char muster;
      DrawColour farbe1, farbe2;
      cout << "M, r: ";
      cin >> M >> radius;
      cout << "Muster ([V]oll, [N]ord-Ost, [S]ued-Ost, [K]aros): ";
      cin >> muster;
      cout << "Farbe 1: ";
      cin >> farbe1;
      cout << "Farbe 2: ";
      cin >> farbe2;
      kreis(pic, M, radius, muster, farbe1, farbe2);
    }
    cin.get();
  }

  cout << endl;
  IOThread::waitForWindow(60);

  return 0;
}
