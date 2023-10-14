Matrix4x4 berechneTransformation(const Vec3D& cop, const Vec3D& vrp,
                                 const Vec3D& vup, int umin, int umax, int vmin,
                                 int vmax, int back, Vec4D& prp)
{
  // Berechnet die normalisierende Transformation nzen, die die Projektion
  // in den kanonischen Bildraum bewirkt für:
  // IN:  Projektionszentrum cop (Augenposition)
  // IN:  Bildebenenursprung vrp
  // IN:  Aufwärtsvektor vup
  // IN:  Projektionsfenster [umin; umax] × [vmin; vmax]
  // IN:  hintere Fläche (backplane) back
  // OUT: Projektionszentrum prp (im u-v-n-System)

  Matrix4x4 nzen;     // fertige Matrix
  Matrix4x4 tvrp;     // Translation vrp
  Matrix4x4 rot;      // Rotation uvn
  Matrix4x4 tprp;     // Translation des transformierten cop in den Ursprung
  Matrix4x4 sh;       // Scherung
  Matrix4x4 szen;     // Skalierung auf kanonischen Bildraum
  double vrpz;
  Vec3D u, v, n;
  Vec3D cw;           // Bildmittelpunkt (center of window)
  Vec3D dop;          // Projektionsrichtung (direction of projection)
  Vec3D vpn;          // Viewport normal
  int i;

  // Da wir (zumindest hier) immer senkrecht auf die Projektionsebene 
  // schauen wollen, legen wir die Normale fest wie folgt.
  vpn = cop - vrp;

  // 1. Verschiebung von vrp in den Ursprung
  tvrp.el[0][0] = tvrp.el[1][1] = tvrp.el[2][2] = tvrp.el[3][3] = 1;
  tvrp.el[0][3] = -vrp.el[0];
  tvrp.el[1][3] = -vrp.el[1];
  tvrp.el[2][3] = -vrp.el[2];

  // 2. a) Bestimme (u,v,n)-Koordinatensystem
  n = vpn / norm(vpn);
  v = vup - skalarprod(vup, n) * n;
  v = v / norm(v);
  u = kreuzprod(v, n);

  // 2. b) Rotation: (x, y, z) ⇝ (u, v, n)
  for (i = 0; i < 3; ++i)
    {
      rot.el[0][i] = u.el[i];
      rot.el[1][i] = v.el[i];
      rot.el[2][i] = n.el[i];
    }
  rot.el[3][3] = 1;

  // 3. Transformation des cop in das u-v-n-System, ergibt prp
  prp = rot * tvrp * Vec4D(cop.el[0], cop.el[1], cop.el[2]);

  // 4. Verschiebung um -prp
  tprp.el[0][0] = tprp.el[1][1] = tprp.el[2][2] = tprp.el[3][3] = 1;
  tprp.el[0][3] = -prp.el[0];
  tprp.el[1][3] = -prp.el[1];
  tprp.el[2][3] = -prp.el[2];

  // 5. Scherung
  cw.el[0] = (umax + umin) / 2;
  cw.el[1] = (vmax + vmin) / 2;
  dop = cw - Vec3D(prp.el[0], prp.el[1], prp.el[2]);
  sh.el[0][0] = sh.el[1][1] = sh.el[2][2] = sh.el[3][3] = 1;
  sh.el[0][2] = -dop.el[0] / dop.el[2];
  sh.el[1][2] = -dop.el[1] / dop.el[2];
  
  // 6. Skalierung auf kanonischen Bildraum
  vrpz = -prp.el[2];
  szen.el[0][0] = 2 * vrpz / ((umax - umin) * (vrpz + back));
  szen.el[1][1] = 2 * vrpz / ((vmax - vmin) * (vrpz + back));
  szen.el[2][2] = -1 / (vrpz + back);
  szen.el[3][3] = 1;

  // 7. Multiplikation der einzelnen Transformationen
  nzen = szen * sh * tprp * rot * tvrp;

  return nzen;
}

Matrix4x4 matrixMzen()
{
  // gibt die Transformationsmatrix für die eigentliche Zentralprojektion zurück
  // Da vorher in den kanonischen Bildraum transformiert wurde, ist die 
  // Projektion sehr einfach.

  Matrix4x4 mzen;

  // Eigentliche Zentralprojektion, Projektionsebene = (u,v)-Ebene
  mzen.el[0][0] = mzen.el[1][1] = mzen.el[2][2] = 1;
  mzen.el[3][2] = -1;

  return mzen;
}

void maleLinien(Drawing& pic, const vector<Kante>& kanten,
                const Matrix4x4& nzen, double zmin, bool doClip)
{
  // malt die transformierten Kanten ins Bild pic

  Vec4D nanf, nend;                 // Anfangs- und Endpunkt nach Normalisierung
  Vec3D canf, cend;                       // Anfangs- und Endpunkt nach Clipping
  Vec4D zanf, zend;              // Anfangs- und Endpunkt nach Zentralprojektion
  IPoint2D panf, pend;                      // Anfangs- und Endpunkt im Bild pic
  Matrix4x4 mzen = matrixMzen();
  
  int n = kanten.size();
  for (int i = 0; i < n; ++i)
    {
      // 1. Normalisiere Anfangs- und Endpunkt der Kante
      //    d.h. Tranformation in kanonischen Bildraum
      nanf = nzen * kanten[i].anf;
      nend = nzen * kanten[i].end;

      // 2. Clipping
      canf = homTo3D(nanf);
      cend = homTo3D(nend);
      if (doClip)
        if (!clip3D(canf, cend, zmin))                   // ändert canf und cend
          continue; // wenn Kante komplett unsichtbar, weiter mit nächster Kante
      
      // 3. Führe Zentralprojektion aus
      zanf = mzen * Vec4D(canf);
      zend = mzen * Vec4D(cend);

      // 4. Umwandlung von 3D homogen nach 2D und
      //    Verschiebung des Ursprung in die Mitte von pic sowie
      //    Skalierung auf Größe von pic
      int wh = min(pic.getWidth(), pic.getHeight());
      panf = homTo2D(zanf) * (0.5 * wh)
        + 0.5 * DPoint2D(pic.getWidth(), pic.getHeight());
      pend = homTo2D(zend) * (0.5 * wh)
        + 0.5 * DPoint2D(pic.getWidth(), pic.getHeight());

      // 4. Male Linien
      pic.drawLine(panf, pend, kanten[i].col, n < 100 || i % (n / 500) == 0);
    }
}
