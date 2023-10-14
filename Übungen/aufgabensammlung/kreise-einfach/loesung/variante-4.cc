// Einfache gefüllte Kreise
// Zeigt das Problem unterschiedlich gezeichneter Quadranten bei naiv
// berechneten Kreiskoordinaten.
// Autor:  Martin Galgon
// Datum:  26.10.2021

#include <iostream>
#include <cmath>

#include <cppqt.h>

#pragma GCC diagnostic ignored "-Wmisleading-indentation"

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
			double limit = round(r/sqrt(2.0));
//======================================================================
			for(int l = -r; l <= r; l++) pic.drawPoint( m.x + l, m.y, DrawColour(0,0,255));

			for(int i = 1; i <= limit; i++){ // y-direction

				// Pythagoras:
				int j = static_cast<int>(round(sqrt(r*r - i*i)));

				// Blau
				for(int l = -j; l <= j; l++) pic.drawPoint( m.x + l, m.y + i, DrawColour(0,128,0));
				for(int l = -j; l <= j; l++) pic.drawPoint( m.x + l, m.y - i, DrawColour(0,255,0));
			}
//======================================================================
			for(int l = -r; l < -limit; l++) pic.drawPoint( m.x, m.y + l, DrawColour(0,192,192));
			for(int l =  r; l >  limit; l--) pic.drawPoint( m.x, m.y + l, DrawColour(0,192,192));

			for(int i = 1; i <= limit; i++){ // y-direction

				// Pythagoras:
				int j = static_cast<int>(round(sqrt(r*r - i*i)));

				// Rot / XOR (grün)
				for(int l = -j; l < -limit; l++) pic.drawPoint( m.x + i, m.y + l, DrawColour(255,64,0));
				for(int l = -j; l < -limit; l++) pic.drawPoint( m.x - i, m.y + l, DrawColour(255,128,0));
				for(int l =  j; l >  limit; l--) pic.drawPoint( m.x + i, m.y + l, DrawColour(255,192,0));
				for(int l =  j; l >  limit; l--) pic.drawPoint( m.x - i, m.y + l, DrawColour(255,255,0));
			}
//======================================================================
		}
	};

	cout << endl;
	IOThread::waitForWindow(60);

	return 0;
}
