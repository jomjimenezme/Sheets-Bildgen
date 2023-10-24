// Ergebnis stimmt nicht ganz mit Weltkoordinaten überein. Vermutlich
// muss die Beleuchtungsfunktion angepasst werden.

// Beleuchtung in Clip-Koordinaten um Operationen zu sparen
      Vec3D ndr = kreuzprod( ecken3D[0] - ecken3D[1],
                             ecken3D[0] - ecken3D[2] );
// Äquivalent:
      Vec3D ndr = kreuzprod( eckenWelt[0] - eckenWelt[1],
                             eckenWelt[0] - eckenWelt[2] );
      ndr = transformiereNormale(nzen, ndr);
//----------------------------------------------------------------------
      ndr1 = ndr / norm(ndr);
      lcc = homTo3D(nzen * Vec4D(l));
      copcc = homTo3D(nzen * Vec4D(cop));

      vc = berechneBeleuchtung(point, ndr1, copcc, lcc, dreiecke[i].col);
//======================================================================
double inline determinante(const Matrix4x4& a)
{
  return   a.el[0][0] * a.el[1][1] * a.el[2][2] * a.el[3][3] + a.el[0][0] * a.el[1][2] * a.el[2][3] * a.el[3][1] + a.el[0][0] * a.el[1][3] * a.el[2][1] * a.el[3][2]
         + a.el[0][1] * a.el[1][0] * a.el[2][3] * a.el[3][2] + a.el[0][1] * a.el[1][2] * a.el[2][0] * a.el[3][3] + a.el[0][1] * a.el[1][3] * a.el[2][2] * a.el[3][0]
         + a.el[0][2] * a.el[1][0] * a.el[2][1] * a.el[3][3] + a.el[0][2] * a.el[1][1] * a.el[2][3] * a.el[3][0] + a.el[0][2] * a.el[1][3] * a.el[2][0] * a.el[3][1]
         + a.el[0][3] * a.el[1][0] * a.el[2][2] * a.el[3][1] + a.el[0][3] * a.el[1][1] * a.el[2][0] * a.el[3][2] + a.el[0][3] * a.el[1][2] * a.el[2][1] * a.el[3][0]
         - a.el[0][0] * a.el[1][1] * a.el[2][3] * a.el[3][2] - a.el[0][0] * a.el[1][2] * a.el[2][1] * a.el[3][3] - a.el[0][0] * a.el[1][3] * a.el[2][2] * a.el[3][1]
         - a.el[0][1] * a.el[1][0] * a.el[2][2] * a.el[3][3] - a.el[0][1] * a.el[1][2] * a.el[2][3] * a.el[3][0] - a.el[0][1] * a.el[1][3] * a.el[2][0] * a.el[3][2]
         - a.el[0][2] * a.el[1][0] * a.el[2][3] * a.el[3][1] - a.el[0][2] * a.el[1][1] * a.el[2][0] * a.el[3][3] - a.el[0][2] * a.el[1][3] * a.el[2][1] * a.el[3][0]
         - a.el[0][3] * a.el[1][0] * a.el[2][1] * a.el[3][2] - a.el[0][3] * a.el[1][1] * a.el[2][2] * a.el[3][0] - a.el[0][3] * a.el[1][2] * a.el[2][0] * a.el[3][1];
}
//======================================================================
Vec3D transformiereNormale(const Matrix4x4& a, const Vec3D& n)
{
  double nm[3][3];
  nm[0][0] = a.el[1][1] * a.el[2][2] * a.el[3][3] + a.el[1][2] * a.el[2][3] * a.el[3][1] + a.el[1][3] * a.el[2][1] * a.el[3][2] - a.el[1][1] * a.el[2][3] * a.el[3][2] - a.el[1][2] * a.el[2][1] * a.el[3][3] - a.el[1][3] * a.el[2][2] * a.el[3][1];
  nm[0][1] = a.el[0][1] * a.el[2][3] * a.el[3][2] + a.el[0][2] * a.el[2][1] * a.el[3][3] + a.el[0][3] * a.el[2][2] * a.el[3][1] - a.el[0][1] * a.el[2][2] * a.el[3][3] - a.el[0][2] * a.el[2][3] * a.el[3][1] - a.el[0][3] * a.el[2][1] * a.el[3][2];
  nm[0][2] = a.el[0][1] * a.el[1][2] * a.el[3][3] + a.el[0][2] * a.el[1][3] * a.el[3][1] + a.el[0][3] * a.el[1][1] * a.el[3][2] - a.el[0][1] * a.el[1][3] * a.el[3][2] - a.el[0][2] * a.el[1][1] * a.el[3][3] - a.el[0][3] * a.el[1][2] * a.el[3][1];
  nm[1][0] = a.el[1][0] * a.el[2][3] * a.el[3][2] + a.el[1][2] * a.el[2][0] * a.el[3][3] + a.el[1][3] * a.el[2][2] * a.el[3][0] - a.el[1][0] * a.el[2][2] * a.el[3][3] - a.el[1][2] * a.el[2][3] * a.el[3][0] - a.el[1][3] * a.el[2][0] * a.el[3][2];
  nm[1][1] = a.el[0][0] * a.el[2][2] * a.el[3][3] + a.el[0][2] * a.el[2][3] * a.el[3][0] + a.el[0][3] * a.el[2][0] * a.el[3][2] - a.el[0][0] * a.el[2][3] * a.el[3][2] - a.el[0][2] * a.el[2][0] * a.el[3][3] - a.el[0][3] * a.el[2][2] * a.el[3][0];
  nm[1][2] = a.el[0][0] * a.el[1][3] * a.el[3][2] + a.el[0][2] * a.el[1][0] * a.el[3][3] + a.el[0][3] * a.el[1][2] * a.el[3][0] - a.el[0][0] * a.el[1][2] * a.el[3][3] - a.el[0][2] * a.el[1][3] * a.el[3][0] - a.el[0][3] * a.el[1][0] * a.el[3][2];
  nm[2][0] = a.el[1][0] * a.el[2][1] * a.el[3][3] + a.el[1][1] * a.el[2][3] * a.el[3][0] + a.el[1][3] * a.el[2][0] * a.el[3][1] - a.el[1][0] * a.el[2][3] * a.el[3][1] - a.el[1][1] * a.el[2][0] * a.el[3][3] - a.el[1][3] * a.el[2][1] * a.el[3][0];
  nm[2][1] = a.el[0][0] * a.el[2][3] * a.el[3][1] + a.el[0][1] * a.el[2][0] * a.el[3][3] + a.el[0][3] * a.el[2][1] * a.el[3][0] - a.el[0][0] * a.el[2][1] * a.el[3][3] - a.el[0][1] * a.el[2][3] * a.el[3][0] - a.el[0][3] * a.el[2][0] * a.el[3][1];
  nm[2][2] = a.el[0][0] * a.el[1][1] * a.el[3][3] + a.el[0][1] * a.el[1][3] * a.el[3][0] + a.el[0][3] * a.el[1][0] * a.el[3][1] - a.el[0][0] * a.el[1][3] * a.el[3][1] - a.el[0][1] * a.el[1][0] * a.el[3][3] - a.el[0][3] * a.el[1][1] * a.el[3][0];

  double d = 1.0 / determinante(a);

//   return Vec3D(
//     d * (nm[0][0] * n.el[0] + nm[0][1] * n.el[1] + nm[0][2] * n.el[2]),
//     d * (nm[1][0] * n.el[0] + nm[1][1] * n.el[1] + nm[1][2] * n.el[2]),
//     d * (nm[2][0] * n.el[0] + nm[2][1] * n.el[1] + nm[2][2] * n.el[2])
//   );
  return Vec3D(
    d * (nm[0][0] * n.el[0] + nm[1][0] * n.el[1] + nm[2][0] * n.el[2]),
    d * (nm[0][1] * n.el[0] + nm[1][1] * n.el[1] + nm[2][1] * n.el[2]),
    d * (nm[0][2] * n.el[0] + nm[1][2] * n.el[1] + nm[2][2] * n.el[2])
  );
}
