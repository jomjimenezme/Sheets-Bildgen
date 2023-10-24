// Rundflug um Lunar Lander
// Autor: Holger Arndt, Sebastian Birk, Martin Galgon
// Datum: 07.12.2015

#include <algorithm>
#include <cmath>
#include <iomanip>
#include <iostream>
#include <limits>
#include <vector>

#include <cppqt.h>

using namespace std;

#ifndef M_PI
const double M_PI = 3.14159265358979323846;
#endif

#include "in-reader.h"
#define CPPQT_DUMMY_CLIP3D
#include "proj-clip.h"

#include "zbuffer.h"
#include "lighting.h"

int maindraw()
{
  bool doClip = false;

  vector<Dreieck> dreiecke;                       // die Dreiecke selbst
  ClipQuad clip = ClipQuadDefault;               // clipping Information
  int i;
  Vec3D cop;                     // center of projection = Augenposition
  Vec3D tgt;                              // target = Betrachteter Punkt
  Vec3D vup(0, 1, 0);               // view-up vector = Aufwärtsrichtung
  Matrix4x4 nzen;                   // Transformation zur Normalisierung
                                                   //auf kanon. Bildraum

  modellEinlesen(dreiecke, cop, tgt);

  Vec3D l = standardLichtQuelle(tgt, cop, vup); // Position der Lichtquelle

  int npics = 101;
  vector<Vec3D> cops(npics);
  vector<Vec3D> vrps(npics);
  for (i = 0; i < npics; ++i)
    {
      cops[i].el[0] = 20 * cos(0.02 * M_PI * i);
      cops[i].el[1] = 0.04 * i - 2;
      cops[i].el[2] = 20 * sin(0.02 * M_PI * i);
      vrps[i].el[0] = 2 * cos(0.02 * M_PI * i);
      vrps[i].el[1] = 0.02 * i - 1;
      vrps[i].el[2] = 2 * sin(0.02 * M_PI * i);
    }
  
  vector<Drawing> pics(npics);
  Drawing pic(1600, 1200, 255);
  pic.show();
  cout << "Erzeuge Bilder:" << endl;
  for (i = 0; i < npics; ++i)
    {
      cout << i << endl;
      pic = 255;

      nzen = berechneTransformation(cops[i], vrps[i], vup, clip,
                                    pic.getWidth(), pic.getHeight());

      maleDreiecke(pic, dreiecke, nzen, clip, doClip, cop, l, false, false);

      pics[i] = pic;
    }
  cout << endl;

  Drawing::makeanim(pics, "Lunarlander", "gif", 10);
  Drawing::makeanim(pics, "Lunarlander", "mpg");

  return 0;
}
