// Second-order differences, integer arithmetic
void drawEllipse_diff2( Drawing &pic, IPoint2D center, int a, int b, bool filled, int colour = 0 )
{
  // zeichnet eine Ellipse um center mit Halbachsen a und b
  
  int x  = 0;
  int y  = b;
  int a2 = a * a;
  int b2 = b * b;
  int d    = 4 * b2 - 4 * a2 * b + a2;
  int deltaE  = 12 * b2;
  int deltaSE = 12 * b2 + 8 * a2 * (1 - b);

  drawEllipsePoints( pic, x, y, center.x, center.y, filled, colour );

  // Region 1 (2. Oktant)
  while ( a2 * (2 * y - 1) > 2 * b2 * (x + 1) )  // teste a^2y==b^2x für punkt (x+1,y-1/2), ganzzahlig: mit 2 multiplizieren
  {
    x++;
    if ( d < 0 )
    {
      d       += deltaE;
      deltaE  += 8 * b2;
      deltaSE += 8 * b2;
    }
    else
    {
      d       += deltaSE;
      deltaE  += 8 * b2;
      deltaSE += 8 * (b2 + a2);
      y--;
    }
    drawEllipsePoints( pic, x, y, center.x, center.y, filled, colour );
  }
  
  // Region 2 (1. Oktant)
  d = b2 * (2 * x + 1) * (2 * x + 1) + 4 * a2 * (y - 1) * (y - 1) - 4 * a2 * b2;
  int deltaS = 4 * a2 * (-2 * y + 3);
  deltaSE = 4 * (b2 * (2 * x + 2) + a2 * (-2 * y + 3));
  while ( y >= 0 )
  {
    y--;
    if ( d >= 0 )
    {
      d       += deltaS;
      deltaS  += 8 * a2;
      deltaSE += 8 * a2;
    }
    else
    {
      d       += deltaSE;
      deltaS  += 8 * a2;
      deltaSE += 8 * (a2 + b2);
      x++;
    }
    drawEllipsePoints( pic, x, y, center.x, center.y, filled, colour );
  }
} 
