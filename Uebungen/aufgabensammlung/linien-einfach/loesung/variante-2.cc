// Datei:  einflinie.cpp
// Autor:  Martin Galgon
// Datum:  21.10.2014

#include <iostream>
#include <cmath>
#include <random>

#include <cppqt.h>

using namespace std;

int maindraw()
{
	Drawing pic( 200, 200 );
	pic.show();
	pic.setZoom(4);

	IPoint2D p0;
	IPoint2D p1;

	// Just some random numbers
	default_random_engine generator;
	uniform_int_distribution<int> distribution(0, 255);
	auto dice = bind(distribution, generator);

	bool bWeiter = true;

	while(bWeiter){
		cout << "Eingabe P0 (x,y): ";
		cin >> p0;

		bWeiter = (p0.x >= 0) && (p0.y >= 0);
		if(!bWeiter) break;

		cout << "Eingabe P1 (x,y): ";
		cin >> p1;

		bWeiter = (p1.x >= 0) && (p1.y >= 0) ;
		if(!bWeiter) break;

		int dx = p1.x - p0.x;
		int dy = p1.y - p0.y;

		int sx = (dx < 0) ? -1 : 1;
		int sy = (dy < 0) ? -1 : 1;

		DrawColour c(dice(), dice(), dice());

		if(dx == 0){ // Vertikale Linie
			for(int i = 0; i != dy+sy; i += sy)
				pic.drawPoint( p0.x, p0.y + i, c, true );
		}else if(dy == 0){ // Horizontale Linie
			for(int i = 0; i != dx+sx; i += sx)
				pic.drawPoint( p0.x + i, p0.y, c, true );
		}else if(abs(dx) >= abs(dy)){ // Steigung [-45°,45°]
			float m = (float)dy / (float)dx;
			for(int i = 0; i != dx+sx; i += sx){
				pic.drawPoint( p0.x + i, round(p0.y + i*m), c, true );
			}
		}else{ // dx < dy
			float m = (float)dx / (float)dy;
			for(int i = 0; i != dy+sy; i += sy){
				pic.drawPoint( round(p0.x + i*m), p0.y + i, c, true );
			}
		}
	};

	cout << endl;
	IOThread::waitForWindow(60);

	return 0;
}
