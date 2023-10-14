#include <iostream>

using namespace std;

int main()
{
  int n = 20261;
  double z = 0.5;  // zoom
  double yi = 1; // yinv

  double p1x, p1y, p1z, p2x, p2y, p2z, p3x, p3y, p3z;

  cout << n << endl;
  for (int i = 1; i <= 12; i++)
    {
      cin >> p1x >> p1y >> p1z >> p2x >> p2y >> p2z >> p3x >> p3y >> p3z;
      cout << z * p1x << ' ' << z * yi * p1y << ' ' << z * p1z << ' '
           << z * p2x << ' ' << z * yi * p2y << ' ' << z * p2z << ' '
           << z * p3x << ' ' << z * yi * p3y << ' ' << z * p3z << ' '
           << 90 <<' ' << 90 <<' ' << 90 <<' ' << endl;
    }
  for (int i = 13; i <= 468; i++)
    {
      cin >> p1x >> p1y >> p1z >> p2x >> p2y >> p2z >> p3x >> p3y >> p3z;
      cout << z * p1x << ' ' << z * yi * p1y << ' ' << z * p1z << ' '
           << z * p2x << ' ' << z * yi * p2y << ' ' << z * p2z << ' '
           << z * p3x << ' ' << z * yi * p3y << ' ' << z * p3z << ' '
           << 25 <<' ' << 25 <<' ' << 70 <<' ' << endl;
    }
  for (int i = 469; i <= 2788; i++)
    {
      cin >> p1x >> p1y >> p1z >> p2x >> p2y >> p2z >> p3x >> p3y >> p3z;
      cout << z * p1x << ' ' << z * yi * p1y << ' ' << z * p1z << ' '
           << z * p2x << ' ' << z * yi * p2y << ' ' << z * p2z << ' '
           << z * p3x << ' ' << z * yi * p3y << ' ' << z * p3z << ' '
           << 255 <<' ' << 255 <<' ' << 120 <<' ' << endl;
    }
  for (int i = 2789; i <= 20261; i++)
    {
      cin >> p1x >> p1y >> p1z >> p2x >> p2y >> p2z >> p3x >> p3y >> p3z;
      cout << z * p1x << ' ' << z * yi * p1y << ' ' << z * p1z << ' '
           << z * p2x << ' ' << z * yi * p2y << ' ' << z * p2z << ' '
           << z * p3x << ' ' << z * yi * p3y << ' ' << z * p3z << ' '
           << 240 <<' ' << 210 <<' ' << 0 <<' ' << endl;
    }

  return 0;
}
