// Second-order differences, integer arithmetic
void drawCircle_diff2(Drawing& pic, IPoint2D center, int radius, bool filled, int colour = 0)
{
  // zeichnet einen Kreis um center mit Radius radius
  int x = 0;
  int y = radius;
  int d = 1 - radius;

  int deltaE  = 3;
  int deltaSE = -2 * radius + 5;

  drawCirclePoints(pic, x, y, center, filled, colour);

  while (y > x) {
    x++;
    if (d < 0) {
      d += deltaE;
      deltaE += 2;
      deltaSE += 2;
    }
    else {
      d += deltaSE;
      deltaE += 2;
      deltaSE += 4;
      y--;
    }
    drawCirclePoints(pic, x, y, center, filled, colour);
  }
}
