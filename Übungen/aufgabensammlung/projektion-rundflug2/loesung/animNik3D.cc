// animiertes 3D-Nikolaushaus
// Autor: Holger Arndt, Sebastian Birk, Martin Galgon
// Datum: 07.12.2015

#include <algorithm>
#include <iomanip>
#include <iostream>
#include <vector>

#include <cppqt.h>

using namespace std;

#include "in-reader.h"
#define CPPQT_DUMMY_CLIP3D
#define CPPQT_DUMMY_CLIP3DPOINT
#define CPPQT_DUMMY_DRAWPOINTZ
#define CPPQT_DUMMY_LIGHTING
#include "proj-clip.h"

void maleLinie(Drawing& pic, const Kante& kante,
               const Matrix4x4& nzen, ClipQuad clip)
{
  // malt die transformierte Kante ins Bild pic

  Vec4D nanf, nend;                 // Anfangs- und Endpunkt nach Normalisierung
  Vec3D canf, cend;                       // Anfangs- und Endpunkt nach Clipping
  Vec4D zanf, zend;              // Anfangs- und Endpunkt nach Zentralprojektion
  IPoint2D panf, pend;                      // Anfangs- und Endpunkt im Bild pic

  Matrix4x4 mzen = matrixMzen(1.0 / clip.farf, clip, pic.getWidth(), pic.getHeight());

  // 1. Normalisiere Anfangs- und Endpunkt der Kante
  //    d.h. Tranformation in kanonischen Bildraum
  nanf = nzen * kante.anf;
  nend = nzen * kante.end;

  // 2. hier kein Clipping
  canf = homTo3D(nanf);
  cend = homTo3D(nend);

  // 3. Führe Zentralprojektion aus
  zanf = mzen * Vec4D(canf);
  zend = mzen * Vec4D(cend);

  // 4. Umwandlung von 3D homogen nach 2D
  panf = homTo2D(zanf);
  pend = homTo2D(zend);

  // 5. Male Linie
  pic.drawLine(panf, pend, kante.col);
}

int maindraw()
{
  Drawing pic(500, 500);
  pic.show();

  int n;
  vector<Kante> kanten;
  ClipQuad clip = ClipQuadDefault;               // clipping Information
  int i;
  int r, g, b;

  cin >> n;
  kanten.resize(n);
  for (i = 0; i < n; i++)
    {
      cin >> kanten[i].anf.el[0] >> kanten[i].anf.el[1] >> kanten[i].anf.el[2]
          >> kanten[i].end.el[0] >> kanten[i].end.el[1] >> kanten[i].end.el[2];
      kanten[i].anf.el[3] = kanten[i].end.el[3] = 1;
      cin >> r >> g >> b;
      kanten[i].col = DrawColour(r, g, b);
    }

  int npics = n + 1;

  Vec3D cop(320, 380, 660);
  Vec3D vrp(240, 280, 360);
  Vec3D vup(0, 1, 0);
  Vec4D prp;

  Matrix4x4 nzen;
  nzen = berechneTransformation(cop, vrp, vup, clip,
                                pic.getWidth(), pic.getHeight());

  vector<Drawing> pics(npics);
  pics[0] = pic;
  for (i = 1; i < npics; ++i)
    {
      maleLinie(pic, kanten[i - 1], nzen, clip);
      pics[i] = pic;
    }

  Drawing::makeanim(pics, "Nik3D", "gif", 40);
  Drawing::makeanim(pics, "Nik3D", "mpg");

  return 0;
}
