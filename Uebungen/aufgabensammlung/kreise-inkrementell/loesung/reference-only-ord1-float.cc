// First-order differences, floating point arithmetic
void drawCircle_float(Drawing& pic, IPoint2D center, int radius, bool filled, int colour = 0)
{
  int x = 0;
  int y = radius;
  double d = radius - 5.0/4.0;

  while(y >= x){
    drawCirclePoints(pic, x, y, center, filled, colour);
    x++;
    if(d >= 0){
      d -= (2*x+1);
    }else{
      y = y-1;
      d -= (2*(x-y)+1);
    }
  }
}
