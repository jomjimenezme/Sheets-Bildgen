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
  location <0, 10, -100>
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
sphere {
  <-30,0,30>, 20
  texture {
    pigment {color Yellow}
  }
}

box {
  <10,-10,-10>, <30,10,10>
  texture {
    Jade
    scale 20
  }
  rotate x*-45
}

plane {
  <0,1,0>, -20
  pigment {
    checker color Blue, color White
    scale 10
  }
}

