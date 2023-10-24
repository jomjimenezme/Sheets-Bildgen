// Autor:  Sebastian Birk, Holger Arndt
// Datum:  2016-01-07
// Beispiel zu Blatt 11

#include "colors.inc"
#include "finish.inc"
#include "textures.inc"
#include "shapes.inc"
#include "glass.inc"
#include "metals.inc"
#include "woods.inc"

// #######################
// Kamera
camera {
  location <0, 70, -100>
  look_at  <0, 0,  0>
}


// #######################
// Licht
light_source {
  <100, 100, 20>
  color White
}

light_source {
  <-20, 100, 100>
  color White
  spotlight
  point_at <0,0,0>
}


// #######################
// Objekte

sphere {
  <0,20,10>, 30
    pigment
      {
        OrangeRed
      }
    finish
      {
        ambient 0.15
        diffuse 0.6
        specular 0.5
        roughness 0.05
        reflection 0.4
      }
}

plane {
  <0,1,0>, -10
  pigment {
    checker color Blue, color White
    scale 30
  }
  finish {
    Phong_Glossy
  }
}
