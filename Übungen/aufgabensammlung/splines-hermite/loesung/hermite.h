void maleHermiteKurve( Drawing& pic, DPoint2D p1, DPoint2D p4, DPoint2D r1,
                       DPoint2D r4, int n, bool slow = false )
{
  double cx[4], cy[4];
  DPoint2D anf, end;
  double t;
  double ninv = 1.0 / n;
  int i;

  pic.drawCircle(p1, 3, true, BLUE, BLUE, slow);
  pic.drawCircle(p4, 3, true, BLUE, BLUE, slow);
  pic.drawLine(p1, p1 + r1, RED, slow);
  pic.drawLine(p4, p4 + r4, RED, slow);

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // Q(t) = (2t^3 − 3t^2 + 1) P1 + (−2t^3 + 3t^2 ) P4 + (t^3 − 2t^2 + t) R1 + (t^3 − t^2) R4
  //
  // Q(t) = 2t^3 P1 − 3t^2 P1 + P1 − 2t^3 P4 + 3t^2 P4 + t^3 R1 − 2t^2 R1 + t R1 + t^3 R4 − t^2 R4
  //
  // Q(t) = t^3 (2 P1 − 2 P4 + R1 + R4) + t^2 (−3 P1 + 3 P4 − 2 R1 − R4) + t (R1) + P1
  //             ---------------------         ------------------------       --    --
  //                      c0                              c1                  c2    c3
  //
  // Q(t) = c0 t^3 + c1 t^2 + c2 t + c3
  // Q(t) = (c0 t^2 + c1 t + c2) t + c3
  // Q(t) = ((c0 t + c1) t + c2) t + c3

  cx[0] = 2 * p1.x - 2 * p4.x + r1.x + r4.x;
  cx[1] = -3 * p1.x + 3 * p4.x - 2 * r1.x - r4.x;
  cx[2] = r1.x;
  cx[3] = p1.x;
  cy[0] = 2 * p1.y - 2 * p4.y + r1.y + r4.y;
  cy[1] = -3 * p1.y + 3 * p4.y - 2 * r1.y - r4.y;
  cy[2] = r1.y;
  cy[3] = p1.y;

  end.x = cx[3];
  end.y = cy[3];
  for (i = 1; i <= n; i++)
  {
    t = ninv * i;
    anf = end;
    end.x = ((cx[0] * t + cx[1]) * t + cx[2]) * t + cx[3];
    end.y = ((cy[0] * t + cy[1]) * t + cy[2]) * t + cy[3];
    pic.drawLine(round(anf), round(end), 0, slow);
  }
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}
