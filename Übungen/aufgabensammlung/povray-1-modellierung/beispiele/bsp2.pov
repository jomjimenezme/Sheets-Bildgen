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
  <0,0,0>, 30
  texture {
    pigment {color Yellow}
  }
}


