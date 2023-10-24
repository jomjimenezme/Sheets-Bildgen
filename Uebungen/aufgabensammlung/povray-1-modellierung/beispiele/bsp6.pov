// Autor:  Sebastian Birk
// Datum:  2014-01-15
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
    T_Silver_3A
  }
  rotate 40*y
  scale 2
}

sphere {
  <-50,20,-10>, 10
  texture {
    T_Wood10
    scale 5
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
