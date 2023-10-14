// einfache Linien
// Autor: Holger Arndt
// Datum: 26.10.2015

#include <cmath>
#include <iostream>

#include <cppqt.h>

using namespace std;

// zeichnet eine Linie von p1 nach p2 (Algorithmus ist verbesserungsfähig)
void zeichneLinie(Drawing& pic, IPoint2D p1, IPoint2D p2)
{
	// bestimme Abstand von p1 und p2 und male entsprechend viele Punkte
	// dazwischen
	int len = round(norm(p2 - p1));
	IPoint2D q;

	for(int k = 0; k <= len; ++k)
	{
		q = round(static_cast<DPoint2D>(p1) + static_cast<double>(k) / len
		        * static_cast<DPoint2D>(p2 - p1));
		pic.drawPoint(q, 0, true);
	}
}

int maindraw()
{
	Drawing pic(200, 200);
	pic.show();
	pic.setZoom(3);

	IPoint2D p1, p2;

	while(true)
	{
		cout << "Eingabe von p1, p2: ";
		cin >> p1 >> p2;

		if (p1.x < 0 || p1.y < 0 || p2.x < 0 || p2.y < 0)
			break;

		zeichneLinie(pic, p1, p2);
	}

	cout << endl;
	IOThread::waitForWindow(60);

	return 0;
}
