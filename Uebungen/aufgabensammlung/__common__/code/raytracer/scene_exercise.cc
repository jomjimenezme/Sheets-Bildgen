// Raytracer
// Autor: Sebastian Birk, Holger Arndt
// Datum: 21.12.2015

#include <iostream>
#include <string>
#include <fstream>
#include <ios>
#include <vector>
#include <array>
#include <memory>

#include <Eigen/Core>

#include <drawing.h>
#include <maindraw.h>

#include "scene.h"
#include "raytracer.h"
#include "image.h"
#include "objects.h"

using namespace std;

using namespace rtai;


int maindraw()
{
  Scene scene;

  scene.setBackground( Vector3d(.2,.5,.6) );
  scene.setAmbient( Vector3d(1,1,1) );

  scene.getCamera().setPosition( Vector3d(0,3,10) );
  scene.getCamera().lookAt( Vector3d(0,0,0) );

  shared_ptr<Light> light1( new Light(Vector3d(0,6,3),Vector3d(1,1,1)) );
  light1->setAttenuationCoeff( Vector3d(.5,.001,.004) );
  scene.addLight(light1);

  shared_ptr<Light> light2( new Light(Vector3d(10,2,10),Vector3d(1,1,1)) );
  light2->setAttenuationCoeff( Vector3d(.2,.001,.0004) );
  scene.addLight(light2);

  shared_ptr<Object> plane1( new Plane(Vector3d(0,1,0), 0 ) );
  plane1->setAmbient( Vector3d(0,.2,0) );
  plane1->setDiffuse( Vector3d(.3,.4,.3) );
  plane1->setSpecular( Vector3d(.2,.3,.2) );
  scene.addObject(plane1);

  shared_ptr<Object> sphere1( new Sphere(Vector3d(0,0,0), 2 ) );
  sphere1->setAmbient( Vector3d(.2,0,0) );
  sphere1->setDiffuse( Vector3d(.3,.1,.1) );
  sphere1->setSpecular( Vector3d(.7,.7,.7) );
  scene.addObject(sphere1);

  shared_ptr<Object> sphere2( new Sphere(Vector3d(1,1,-1), 2.5 ) );
  sphere2->setAmbient( Vector3d(0,0,.2) );
  sphere2->setDiffuse( Vector3d(0,0,.5) );
  sphere2->setSpecular( Vector3d(.4,.4,.4) );
  sphere2->setSpecularityExponent( 10 );
  scene.addObject(sphere2);

  shared_ptr<Object> sphere3( new Sphere(Vector3d(1,1,4), 1 ) );
  sphere3->setAmbient( Vector3d(0,0,0) );
  sphere3->setDiffuse( Vector3d(.3,.3,0) );
  sphere3->setSpecular( Vector3d(.5,.5,.3) );
  sphere3->setSpecularityExponent( 10 );
  scene.addObject(sphere3);

  shared_ptr<Object> sphere4( new Sphere(Vector3d(-4,2,1), 2 ) );
  sphere4->setAmbient( Vector3d(.02,.02,.02) );
  sphere4->setDiffuse( Vector3d(.3,.3,.3) );
  sphere4->setSpecular( Vector3d(.4,.4,.4) );
  sphere4->setSpecularityExponent( 10 );
  sphere4->setReflection( Vector3d(1,1,1) );
  scene.addObject(sphere4);

  shared_ptr<Object> sphere5( new Sphere(Vector3d(6,2,1), 3 ) );
  sphere5->setAmbient( Vector3d(0,0,0) );
  sphere5->setDiffuse( Vector3d(.03,.03,.03) );
  sphere5->setSpecular( Vector3d(.4,.4,.4) );
  sphere5->setSpecularityExponent( 10 );
  sphere5->setReflection( Vector3d(1,1,1) );
  scene.addObject(sphere5);

  shared_ptr<Object> sphere6( new Sphere(Vector3d(0,20,20), 18 ) );
  sphere6->setAmbient( Vector3d(.02,0,.02) );
  sphere6->setDiffuse( Vector3d(.5,0,.5) );
  sphere6->setSpecular( Vector3d(.5,0,.5) );
  sphere6->setSpecularityExponent( 100 );
  scene.addObject(sphere6);

  Raytracer rt;
  Image img(1024,768);
  rt.raytrace( scene, img );
  img.saveImage( "scene_exercise.png" );

  return 0;
}
