// Einfache gefüllte Kreise
// Zeigt das Problem unterschiedlich gezeichneter Quadranten bei naiv
// berechneten Kreiskoordinaten.
// Autor:  Martin Galgon
// Datum:  26.10.2021

#include <iostream>
#include <cmath>

#include <cppqt.h>

using namespace std;

int maindraw()
{
	Drawing pic( 400, 300 );
	pic.show();
	pic.setZoom(3);

	IPoint2D m;
	int r;

	bool bWeiter = true;

	while(bWeiter)
	{
		cout << "Eingabe des Mittelpunktes (x,y): ";
		cin >> m;
		cout << "Eingabe des Radius (integer): ";
		cin >> r;

		bWeiter = (m.x >= 0) && (m.y >= 0) && (r >= 0);

		if( bWeiter ){
//======================================================================
			for(int i = -r; i <= r; i++){ // y-direction

				// Pythagoras:
// 				int j = static_cast<int>(floor(sqrt(r*r - i*i)));
				int j = static_cast<int>(round(sqrt(r*r - i*i)));
// 				int j = static_cast<int>(ceil(sqrt(r*r - i*i)));

				// Trigonometrisch:
// 				int j = static_cast<int>(round(r*cos(asin(static_cast<double>(i)/r))));

				// Blau
				for(int l = -j; l <= j; l++) pic.drawPoint( m.x + l, m.y + i, DrawColour(0,0,255));
			}
//======================================================================
			for(int i = -r; i <= r; i++){ // x-direction

				// Pythagoras:
// 				int j = static_cast<int>(floor(sqrt(r*r - i*i)));
				int j = static_cast<int>(round(sqrt(r*r - i*i)));
// 				int j = static_cast<int>(ceil(sqrt(r*r - i*i)));

				// Trigonometrisch:
// 				int j = static_cast<int>(round(r*cos(asin(static_cast<double>(i)/r))));

				// Rot / XOR (grün)
				for(int l = -j; l <= j; l++) pic.drawPoint( m.x + i, m.y + l, DrawColour(0,255,255), false, true);
			}
//======================================================================
		}
	};

	cout << endl;
	IOThread::waitForWindow(60);

	return 0;
}
