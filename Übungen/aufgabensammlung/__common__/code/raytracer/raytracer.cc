// Raytracer
// Autor: Sebastian Birk, Martin Galgon, Holger Arndt
// Datum: 22.12.2015

#include <algorithm>
#include <limits>
#include <cmath>

#include <Eigen/Core>
#include <Eigen/Dense>

#include "raytracer.h"
#include "ray.h"

#ifndef M_PI
const double M_PI = 3.14159265358979323846;
#endif

using namespace std;
using namespace Eigen;

namespace rtai {

  void Raytracer::raytrace( const Scene &scene, Image &image )
  {
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    // Ecke und spannende Vektoren der Projektionsebene bestimmen
    Vector3d campos = scene.getCamera().getPosition();
    Vector3d camdir = scene.getCamera().getDirection();
    Vector3d up     = scene.getCamera().getUp();
    double horangle = scene.getCamera().getHorAngle();
    double aspect   = static_cast<double>(image.getWidth())/image.getHeight();

    Vector3d planeright = camdir.cross(up);
    Vector3d planedown  = camdir.cross(planeright);

    camdir     /= camdir.norm();
    planeright /= planeright.norm();
    planedown  /= planedown.norm();

    double pi = M_PI;
    planeright *= tan(horangle * pi / 360.0);
    planedown  *= tan(horangle * pi / 360.0) / aspect;

    Vector3d topleft = campos + camdir - planeright - planedown;

    // Größe des Bildes ermitteln und temporäres Bild erzeugen
    int w, h;
    int aalias = 2;
    double aa1 = 1.0 / ( aalias * aalias );

    w = image.getWidth()  * aalias;
    h = image.getHeight() * aalias;

    // Ein größeres Bild ist nicht nötig.
    vector<vector<Vector3d>> tmpImage;
    tmpImage.resize( image.getHeight() );
    for (int y = 0; y < image.getHeight(); y++) {
      tmpImage[y].resize( image.getWidth(), Vector3d(0, 0, 0) );
    }

    // Pixelmaße
    double w1 = 1.0 / w;
    double h1 = 1.0 / h;
    double w1_halbe = 0.5 * w1;
    double h1_halbe = 0.5 * h1;

    // alle Punkte auf der Projektionsebene erzeugen und Strahlen verfolgen
    Ray currentray;
    currentray.origin = campos;
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        currentray.direction = topleft - campos
                             + 2 * planeright * ( x * w1 + w1_halbe )
                             + 2 * planedown  * ( y * h1 + h1_halbe );

        tmpImage[y/aalias][x/aalias] += aa1 * raytrace( scene, currentray, 1 );
        // Farben im resultierenden Bild setzen + Beobachtung des Bildaufbaus
        Vector3d col;
        // Skalieren für richtigen Farbwert (kann man auch weglassen)
        // aalias * aalias / ((y % aalias) * aalias + (x % aalias) + 1) = 4,3,2,1 für aalias = 2, etc.
        col = tmpImage[y/aalias][x/aalias] * aalias * aalias / ((y % aalias) * aalias + (x % aalias) + 1);
        clampCol(col);
        image.setPixel( x/aalias, y/aalias, col );
      }
    }
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  }

  Vector3d Raytracer::raytrace( const Scene &scene, const Ray &ray, int dep,
                                Object *origin )
  {
    Vector3d rgbCol;

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    HitInfo hi;
    for (auto o: scene.objects) {
      if (o.get() == origin)
        continue;

      HitInfo hitest = o->isHitBy( ray );
      if ( hitest.hit
           && (hitest.rayparam < hi.rayparam)
           && (hitest.rayparam >= 0) ) {
        hi = hitest;
      }
    }

    if (!hi.hit) {
      rgbCol = scene.getBackground();
    }
    else {
      // Ambienter Anteil
      rgbCol = scene.getAmbient().cwiseProduct(hi.object->getAmbient());

      // Lichtbeitrag aller Lichtquellen ermitteln
      VisibleInfo vi;
      for (auto l: scene.lights) {
        vi = l->visibleFrom( scene, hi, hi.object );

        if (vi.visible) {
          // diffuser und winkelabhängiger Anteil
          Vector3d diffspec(0,0,0);   // <-- kombinierter diffuser und
          //                                 winkelabhängiger Lichtanteil

          double dotNormalLightDir = hi.normal.dot(vi.direction);
          if (dotNormalLightDir > 0) {
            // diffuser Anteil
            diffspec = dotNormalLightDir*hi.object->getDiffuse();

            // winkelabhängiger Anteil
            Vector3d tocam = -ray.direction/ray.direction.norm();
            Vector3d lightreflectdir
              = 2*dotNormalLightDir*hi.normal-vi.direction;
            double dotTocamLightreflect = tocam.dot(lightreflectdir);
            if (dotTocamLightreflect > 0)
              diffspec += pow(dotTocamLightreflect,
                              hi.object->getSpecularityExponent())
                *hi.object->getSpecular();
          }

          // zusammen zur Farbe
          rgbCol += l->getAttenuation(vi.distance)
            *l->getIntensity().cwiseProduct(diffspec);
        }
      }

      // Spiegelung
      if (hi.object->getReflective() && dep < depth) {
        Vector3d tocam = -ray.direction/ray.direction.norm();
        Ray reflray;
        reflray.origin = hi.position;
        reflray.direction = 2*tocam.dot(hi.normal)*hi.normal-tocam;
        Vector3d rgbRefl = raytrace( scene, reflray, dep+1, hi.object );
        rgbCol += rgbRefl.cwiseProduct(hi.object->getReflection());
      }

      // Lichtbrechung
      if (hi.object->getRefractive() && dep < depth) {
        Ray inray;
        inray.origin = hi.position;
        inray.insideObject = hi.object;

        // Winkel bestimmen
        // cos(a1) = dot(tocam, normal)
        double c1 = -ray.direction.dot(hi.normal)/ray.direction.norm();
        // n1(air) = 1,   n1/n2 = 1.0/n2
        double n = 1.0/hi.object->getRefraction();
        // sin^2 + cos^2 = 1
        // sin^2(a1) = 1 - cos(a1)^2
        // sin(a2) = sin(a1) * n1/n2
        // cos(a2) = sqrt( 1 - sin^2(a2) )
        //         = sqrt( 1 - sin^2(a1) * n1^2/n2^2 )
        //         = sqrt( 1 - (1 - cos(a1)^2) * n1^2/n2^2 )
        double c2 = sqrt( 1 - n*n*(1-c1*c1) );

        //  g1
        // o-->o                                                      //
        //  \  |                                                      //
        //  t\ |normal                                                //
        //    \|                                                      //
        //  ---x---                                                   //
        //     |\                                                     //
        //     | \i                                                   //
        //     |  \                                                   //
        //     o-->o                                                  //
        //      g2
        //
        // Da
        //   n1 * sin(a1) = n2 * sin(a2)                   und
        //   sin(a1) = |g1|/|d| bzw. sin(a2) = |g2|/|i|    sowie
        //   |d| = |i| = 1                                 ist
        //   n1 * |g1| = n2 * |g2|.
        //
        // d: ray.dir
        // t: tocam = -ray.dir
        // i: inray.dir
        //
        // Ferner
        //   g1 = normal * dot(-d, normal) - t
        //      = normal * c1 + d                      und
        //   g2 = i - (-normal) * dot(i, -normal)
        //      = i + normal * c2
        //
        // Also
        //   n1 * |normal * c1 + d| = n2 * |i + normal * c2|
        //
        // Wenn zudem die Richtungen von g1 und g2 als gleich angenommen
        // werden, gilt außerdem
        //   n1 * (normal * c1 + d) = n2 * (i + normal * c2)
        // <=>
        //   n2 * i - n1 * d = (n1 * c1 - n2 * c2) * normal
        // <=>
        //   i = n1/n2 * d + (n1/n2 * c1 - c2) * normal
        //
        inray.direction = n*ray.direction + (n*c1-c2)*hi.normal;
        inray.direction /= inray.direction.norm();

        // zeigt Strahl ins Objekt? Totalreflektion nicht simuliert
        if (inray.direction.dot(hi.normal) < 0) {
          // Austrittsort und Winkel bestimmen
          HitInfo insidehi = hi.object->isHitBy( inray );
          Ray outray;
          outray.origin = insidehi.position;
          c1 = -inray.direction.dot(-insidehi.normal);
          n = hi.object->getRefraction();
          c2 = sqrt( 1 - n*n*(1-c1*c1) );
          outray.direction = n*inray.direction + (n*c1-c2)*(-insidehi.normal);
          outray.direction /= outray.direction.norm();

          // zeigt Strahl aus Objekt? Totalreflektion nicht simuliert
          Vector3d rgbRefr = scene.getBackground();
          if (outray.direction.dot(insidehi.normal) > 0) {
            // Strahl weiterverfolgen
            rgbRefr = raytrace( scene, outray, dep+1, hi.object );

            // TODO: Länge des Weges im Objekt bestimmen und Lichtanteil dämpfen
          }

          // Farbe setzen
          rgbCol += rgbRefr.cwiseProduct(hi.object->getPigment());
        }
      }
    }
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    return rgbCol;
  }

  void Raytracer::clampCol( Vector3d &rgb )
  {
    rgb[0] = min(rgb[0],1.0);
    rgb[1] = min(rgb[1],1.0);
    rgb[2] = min(rgb[2],1.0);
    rgb[0] = max(rgb[0],0.0);
    rgb[1] = max(rgb[1],0.0);
    rgb[2] = max(rgb[2],0.0);
  }

}
