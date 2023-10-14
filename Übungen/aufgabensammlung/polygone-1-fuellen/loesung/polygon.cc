// Scan Conversion für Polygone
// Autor: Holger Arndt, Sebastian Birk, Martin Galgon
// Datum: 13.11.2015

#include <algorithm>
#include <iostream>
#include <list>
#include <vector>

#include <cppqt.h>

using namespace std;

struct Kante
{
  int ymax; // maximale y-Koordinate
  double x; // AKTUELLE x-Koordinate
  double einsdurchm; // Da die Kanten in y-Richtung ausgewertet werden,
                     // wird die inverse Steigung benötigt.
  /*
   * Sortierung in horizontaler Anordnung; es gibt keine sich
   * überschneidenden Kanten, deshalb liegt eine Kante „links neben“
   * einer weiteren Kante, wenn
   *  • sie am (zur Zeit) untersten Punkt links neben der zweiten Kante
   *    liegt, oder
   *  • beide Kanten zwar an der selben x-Koordinate beginnen, die Erste
   *    aber eine steilere Steigung hat.
   *
   * Die oberen Punkte spielen dabei keine Rolle (es gibt in dieser
   * Variante keine Liste für Kanten, die an einer bestimmten
   * y-Koordinate inaktiv werden).
   * Die zweite Bedingung ist nötig, um neu hinzukommende Kanten einfach
   * einsortieren zu können, ohne die alten Kanten neu sortieren zu
   * müssen.
   */
  friend bool operator<(const Kante& k1, const Kante& k2)
  {
    if (k1.x != k2.x)
      return k1.x < k2.x;
    else
      return k1.einsdurchm < k2.einsdurchm;
  }
};

typedef list<Kante> KantenTabelle;

void drawFilledPolygon(Drawing& pic, const vector<IPoint2D>& ecken,
                       int colour = 0)
{
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  int ymin = pic.getHeight() + 1;
  int ymax = -1;
  unsigned int n = ecken.size();

  // bestimme kleinste und größte Bildzeile
  // for (unsigned int i = 0; i < n; i++)
  //   {
  //     if (ecken[i].y < ymin)
  //       ymin = ecken[i].y;
  //     if (ecken[i].y > ymax)
  //       ymax = ecken[i].y;
  //   }
  // bestimme kleinste und größte Bildzeile, C++11
  auto yminmax = minmax_element(std::begin(ecken),std::end(ecken),
                                [](const IPoint2D& e1, const IPoint2D& e2)
                                { return e1.y < e2.y; });
  ymin = yminmax.first->y;
  ymax = yminmax.second->y;

  /*
   * Active edge table; Tabelle der momentan aktiven Kanten.
   * Enthält alle Kanten, zwischen denen in der aktuellen Zeile spans
   * gezeichnet werden müssen.
   * Die Kanten sind horizontal sortiert (siehe struct Kante).
   */
  KantenTabelle aet(0);
  /*
   * Für jede Pixelzeile des Polygons, verwalte eine Liste an Kanten,
   * die bei dieser y-Koordinate beginnen. So können diese Kanten leicht
   * int die AET eingefügt werden.
   * Dazu sind die einzelnen Listen in ET horizontal sortiert (siehe
   * struct Kante).
   */
  vector<KantenTabelle> et(ymax + 1);             // et(0, …, ymin) bleiben leer
  // Iteratoren
  KantenTabelle::iterator kitaet;        // Kanteniterator für Active-Edge-Table
  KantenTabelle::iterator kitety;      // Kanteniterator für Edge-Table, Zeile y
  Kante k;
  int kymin;
  double xanf, xend;

  /*
   * Erzeuge die Kanten aus der Punkteliste. Sortiere die beiden Punkte
   * einer Kante dabei nach ihrer y-Koordinate. Die aktuelle
   * x-Koordinate ist zu Beginn dann die x-Koordinate des unteren
   * Punktes.
   * Füge die Kante in die zu ihrer y-Koordinate gehörenden Liste ein.
   */
  for (unsigned int i = 0; i < n - 1; ++i)
    {
      if (ecken[i].y != ecken[i + 1].y)
        {
          if (ecken[i].y < ecken[i + 1].y)
            {
              k.ymax = ecken[i + 1].y;
              k.x = ecken[i].x;
              kymin = ecken[i].y;
            }
          else
            {
              k.ymax = ecken[i].y;
              k.x = ecken[i + 1].x;
              kymin = ecken[i + 1].y;
            }
          k.einsdurchm = static_cast<double>(ecken[i + 1].x - ecken[i].x) /
            (ecken[i + 1].y - ecken[i].y);
          et[kymin].push_back(k);
        }
    }
  /*
   * Das Polygon wird geschlossen, indem der letzte und der erste Punkt
   * verbunden werden.
   */
  if (ecken[n - 1].y != ecken[0].y)
    {
      if (ecken[n - 1].y < ecken[0].y)
        {
          k.ymax = ecken[0].y;
          k.x = ecken[n - 1].x;
          kymin = ecken[n - 1].y;
        }
      else
        {
          k.ymax = ecken[n - 1].y;
          k.x = ecken[0].x;
          kymin = ecken[0].y;
        }
      k.einsdurchm = static_cast<double>(ecken[0].x - ecken[n - 1].x) /
        (ecken[0].y - ecken[n - 1].y);
      et[kymin].push_back(k);
    }

  /*
   * Sortiere die Kanten in et[y] horizontal (siehe struct Kante).
   * So lassen sich die Kanten einfach sortiert in die AET einfügen.
   */
  for (int y = ymin; y <= ymax; ++y)
    et[y].sort();

  /*
   * Hauptschleife über die y-Zeilen des Polygons
   */
  for (int y = ymin; y <= ymax; ++y)
    {
      // füge alle in Zeile y startenden Kanten sortiert ein
      kitety = et[y].begin();
      kitaet = aet.begin();
      while (kitety != et[y].end() && kitaet != aet.end())
        {
          if (*kitaet < *kitety)
            ++kitaet;
          else
            {
              aet.insert(kitaet, *kitety);
              ++kitety;
            }
        }
      /*
       * Am Ende sind u.U. noch Kanten in et[y] übrig. Aufgrund der
       * Sortierung können sie hier einfach angehängt werden.
       */
      while (kitety != et[y].end())
        aet.push_back(*kitety++);

      /*
       * Entferne alle bei y endenden Kanten aus der AET.
       * Durch das Entfernen vor dem Malen fehlen bei Spitzen die obersten
       * Pixel. Das Entfernen ist notwendig, um die Spans zwischen Paaren
       * von Kanten der AET malen zu können. Dieser Fall tritt immer dann
       * ein, wenn am Ende einer Kante beim aktuellen y eine neue Kante
       * beginnt.
       */
      for (kitaet = aet.begin(); kitaet != aet.end(); )
        if (kitaet->ymax == y)
          kitaet = aet.erase(kitaet);
        else
          ++kitaet;

      /*
       * Male Pixel der einzelnen Spans. Durch die Sortierung (und die
       * vorherige Entfernung hier endender Kanten) werden immer Spans
       * zwischen Paaren von Kanten aus der AET gemalt.
       */
      for (kitaet = aet.begin(); kitaet != aet.end(); )
        {
          xanf = (kitaet++)->x;
          xend = (kitaet++)->x;
          for (int x = static_cast<int>(round(xanf));
               x <=  static_cast<int>(round(xend)); ++x)
            pic.drawPoint(x, y, colour, false);
        }

      /*
       * Aktualisiere die x-Werte aller Kanten in AET.
       */
      for (kitaet = aet.begin(); kitaet != aet.end(); ++kitaet)
        kitaet->x += kitaet->einsdurchm;
    }
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}

int maindraw()
{
  Drawing pic1(300, 300);
  pic1.setSleepTime(3);

  pic1.show();
  pic1.setZoom(2);

  int n;
  IPoint2D p;
  vector<IPoint2D> ecken;
  // zum STL-Typ vector vergleiche z.B.:
  //http://en.cppreference.com/w/cpp/container/vector
  //http://www.cplusplus.com/reference/vector/vector/
  //http://www.sgi.com/tech/stl/Vector.html

  cout << "Anzahl der Ecken: ";
  cin >> n;

  for (int i = 1; i <= n; ++i)
    {
      cout << "Ecke " << i << ": ";
      cin >> p;
      ecken.push_back(p);
    }

  cout << "Eingegebenes Polygon: ";
  for (unsigned int i = 0; i < ecken.size(); ++i)
    cout << ecken[i] << '-';
  cout << ecken[0] << endl;

  drawFilledPolygon(pic1, ecken, 0);

  pic1.savePNG("polygon.png");

  cout << endl;
  IOThread::waitForWindow(60);

  return 0;
}
