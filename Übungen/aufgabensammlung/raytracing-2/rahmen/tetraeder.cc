// Raytracer
// Autor: Sebastian Birk, Holger Arndt
// Datum: 21.12.2015

#include <cmath>
#include <utility>

#include <Eigen/Core>
#include <Eigen/Dense>

#include "tetraeder.h"

#ifndef M_PI
const double M_PI = 3.14159265358979323846;
#endif

using namespace std;
using namespace Eigen;

namespace rtai {

  HitInfo Tetraeder::isHitBy( const Ray &ray )
  {
    HitInfo hi;


    // -------------
    // HIER ERGÄNZEN
    // -------------


    return hi;
  }

  void Tetraeder::setPos( const Vector3d& cen, double dim, const Vector3d& rot )
  {
    //  Rotation um durch rot gegebene Achse mit durch norm(rot) gegebenem
    //  Winkel in Grad
    position = cen;
    center = cen;
    dimension = dim;
    rotation = rot;


    // -------------
    // HIER ERGÄNZEN
    // -------------


  }

}



