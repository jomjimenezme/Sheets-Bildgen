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
    // Bilderzeugung mit rekursivem Ray Tracing

    // HIER ERGÄNZEN <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  }

  Vector3d Raytracer::raytrace( const Scene &scene, const Ray &ray, int dep,
                                Object *origin )
  {
    // I(r, P, t)
    Vector3d rgbCol;

    // HIER ERGÄNZEN <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

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
