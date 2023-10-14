// Rundflug ums Colosseum
// Autor: Holger Arndt, Sebastian Birk, Martin Galgon
// Datum: 05.01.2016

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
  vector<Vec3D> vups(npics);
  for (i = 0; i < npics; ++i)
    {
      cops[i].el[0] = 0;
      cops[i].el[1] = 1500 * sin(0.01 * M_PI * i);
      cops[i].el[2] = 1500 * cos(0.01 * M_PI * i);
      vrps[i].el[0] = 0;
      vrps[i].el[1] = 1000 * sin(0.01 * M_PI * i);
      vrps[i].el[2] = 1000 * cos(0.01 * M_PI * i);
      vups[i].el[0] = 0;
      vups[i].el[1] = cos(0.01 * M_PI * i);
      vups[i].el[2] = -sin(0.01 * M_PI * i);
    }
  for (i = 51; i <= 80; i++)
    {
      cops[i].el[0] = 0;
      cops[i].el[1] = 1500;
      cops[i].el[2] = 0;
      vrps[i].el[0] = 0;
      vrps[i].el[1] = 1000;
      vrps[i].el[2] = 0;
      vups[i].el[0] = sin(0.01 * M_PI * (i - 51));
      vups[i].el[1] = 0;
      vups[i].el[2] = -cos(0.01 * M_PI * (i - 51));
    }
  for (i = 81; i <= 100; i++)
    {
      cops[i].el[0] = 0;
      cops[i].el[1] = 1500;
      cops[i].el[2] = 0;
      vrps[i].el[0] = 0;
      vrps[i].el[1] = 1000 - 20 * (i - 81);
      vrps[i].el[2] = 0;
      vups[i].el[0] = sin(0.3 * M_PI);
      vups[i].el[1] = 0;
      vups[i].el[2] = -cos(0.3 * M_PI);
    }
  
  vector<Drawing> pics(npics);
  Drawing pic(1400, 1000, 255);
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

  Drawing::makeanim(pics, "Colosseum", "gif", 4);
  Drawing::makeanim(pics, "Colosseum", "mpg");

  return 0;
}
