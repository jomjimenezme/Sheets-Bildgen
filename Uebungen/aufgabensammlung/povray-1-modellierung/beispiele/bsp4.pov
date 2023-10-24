// Autor:  Sebastian Birk
// Datum:  2014-01-15
// Beispiel zu Blatt 11

#include "colors.inc"
#include "stones.inc"
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


// #######################
// Objekte

object {
  union {
    difference {
      cylinder {
        <0,0,0>, <0,20,0>, 10
      }
      cylinder {
        <0,2,0>, <0,22,0>, 8
      }
    }
    difference {
      torus {
        6, 1
        rotate 90*x
      }
      box {
        <-30,-30,-30>, <0,30,30>
      }
      translate <9.5,10,0>
    }
  }
  texture {
    pigment {Green}
  }
  rotate 40*y
  scale 2
}



plane {
  <0,1,0>, -10
  pigment {
    checker color Blue, color White
    scale 30
  }
}
