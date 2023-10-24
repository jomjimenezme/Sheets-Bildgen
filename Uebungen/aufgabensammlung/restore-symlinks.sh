#!/bin/bash
# ^(.*) \-> (.*)/.*
# remove_and_link \1 \2

remove_and_link(){
	rm -f $1
	ln -s $2/$1
}

folder_remove_and_link(){
	rm -rf $1
	ln -s $2 $1
}

link_ogl_default(){
remove_and_link glsupport.cc ../../__common__/code/opengl
remove_and_link glsupport.h ../../__common__/code/opengl
remove_and_link gltypes.h ../../__common__/code/opengl
remove_and_link Makefile ../../__common__/code/opengl
}

link_points(){
remove_and_link points0.in ../../__common__/in
remove_and_link points1.in ../../__common__/in
remove_and_link points2.in ../../__common__/in
remove_and_link points3.in ../../__common__/in
remove_and_link points4.in ../../__common__/in
}

link_models(){
remove_and_link colosseum.in ../../__common__/modelle
remove_and_link dreiecke.in ../../__common__/modelle
remove_and_link liberty.in ../../__common__/modelle
remove_and_link lunarlander.in ../../__common__/modelle
remove_and_link mc_tower.in ../../__common__/modelle
remove_and_link notredame.in ../../__common__/modelle
remove_and_link parthenon.in ../../__common__/modelle
remove_and_link pc.in ../../__common__/modelle
remove_and_link penguin.in ../../__common__/modelle
remove_and_link pyramide.in ../../__common__/modelle
remove_and_link saturnv.in ../../__common__/modelle
remove_and_link scissors.in ../../__common__/modelle
remove_and_link shell.in ../../__common__/modelle
remove_and_link sts.in ../../__common__/modelle
remove_and_link sydneyopera.in ../../__common__/modelle
remove_and_link toureiffel.in ../../__common__/modelle
remove_and_link wuerfel.in ../../__common__/modelle
}

link_clip_models(){
remove_and_link colosseum.in ../../__common__/modelle
remove_and_link sts.in ../../__common__/modelle
remove_and_link wuerfel.in ../../__common__/modelle
}

link_clip_info(){
remove_and_link colosseum1.info ../../__common__/clip-info
remove_and_link colosseum2.info ../../__common__/clip-info
remove_and_link colosseum3.info ../../__common__/clip-info
remove_and_link noclip.info ../../__common__/clip-info
remove_and_link sts1.info ../../__common__/clip-info
remove_and_link wuerfel1.info ../../__common__/clip-info
remove_and_link wuerfel2.info ../../__common__/clip-info
remove_and_link wuerfel3.info ../../__common__/clip-info
remove_and_link wuerfel4.info ../../__common__/clip-info
remove_and_link wuerfel5.info ../../__common__/clip-info
remove_and_link wuerfel6.info ../../__common__/clip-info
}

link_raytrace(){
remove_and_link camera.cc ../../__common__/code/raytracer
remove_and_link camera.h ../../__common__/code/raytracer
remove_and_link hitinfo.h ../../__common__/code/raytracer
remove_and_link image.cc ../../__common__/code/raytracer
remove_and_link image.h ../../__common__/code/raytracer
remove_and_link light.cc ../../__common__/code/raytracer
remove_and_link light.h ../../__common__/code/raytracer
remove_and_link object.h ../../__common__/code/raytracer
remove_and_link plane.cc ../../__common__/code/raytracer
remove_and_link plane.h ../../__common__/code/raytracer
remove_and_link ray.h ../../__common__/code/raytracer
remove_and_link raytracer.h ../../__common__/code/raytracer
remove_and_link README ../../__common__/code/raytracer
remove_and_link scene.cc ../../__common__/code/raytracer
remove_and_link scene_exercise.cc ../../__common__/code/raytracer
remove_and_link scene.h ../../__common__/code/raytracer
remove_and_link scene_snowman.cc ../../__common__/code/raytracer
remove_and_link sphere.cc ../../__common__/code/raytracer
remove_and_link sphere.h ../../__common__/code/raytracer
remove_and_link visibleinfo.h ../../__common__/code/raytracer
}

link_raytrace2(){
remove_and_link box.cc ../../__common__/code/raytracer
remove_and_link box.h ../../__common__/code/raytracer
remove_and_link objects.h ../../__common__/code/raytracer
remove_and_link parallelepiped.cc ../../__common__/code/raytracer
remove_and_link parallelepiped.h ../../__common__/code/raytracer
remove_and_link parallelogram.cc ../../__common__/code/raytracer
remove_and_link parallelogram.h ../../__common__/code/raytracer
remove_and_link planar.cc ../../__common__/code/raytracer
remove_and_link planar.h ../../__common__/code/raytracer
remove_and_link scene_exercise2.cc ../../__common__/code/raytracer
remove_and_link tetraeder.h ../../__common__/code/raytracer
remove_and_link triangle.h ../../__common__/code/raytracer
}

link_muster(){
remove_and_link muster1.ppm ../../__common__/in
remove_and_link muster2.ppm ../../__common__/in
remove_and_link NW2.ppm ../../__common__/in
}

link_polygons(){
remove_and_link polygon1.in ../../__common__/in
remove_and_link polygon2.in ../../__common__/in
remove_and_link polygon3.in ../../__common__/in
remove_and_link polygon4.in ../../__common__/in
remove_and_link polygon5.in ../../__common__/in
remove_and_link polygon6.in ../../__common__/in
}

#=======================================================================
pushd opengl-bezier/loesung
link_ogl_default
popd
#=======================================================================
pushd opengl-bezier/material
link_points
popd
#=======================================================================
pushd opengl-bezier/rahmen
link_ogl_default
popd
#=======================================================================
pushd opengl-bezier-flaechen/loesung
link_ogl_default
remove_and_link splinesurf.h ../../__common__/code
popd
#=======================================================================
pushd opengl-bezier-flaechen/rahmen
link_ogl_default
remove_and_link splinesurf.h ../../__common__/code
popd
#=======================================================================
pushd opengl-modellierung/loesung
link_ogl_default
popd
#=======================================================================
pushd opengl-modellierung/rahmen
link_ogl_default
popd
#=======================================================================
pushd opengl-projektion/loesung
link_ogl_default
remove_and_link in-reader.h ../../__common__/code
popd
#=======================================================================
pushd opengl-projektion/modelle
link_models
link_clip_info
remove_and_link dreiecke2.in ../../__common__/modelle
remove_and_link snowman.in ../../__common__/modelle
remove_and_link voyager.in ../../__common__/modelle
popd
#=======================================================================
pushd opengl-projektion/rahmen
link_ogl_default
remove_and_link in-reader.h ../../__common__/code
popd
#=======================================================================
pushd opengl-rotationskoerper/loesung
link_ogl_default
remove_and_link splinerotk.h ../../__common__/code
popd
#=======================================================================
pushd opengl-rotationskoerper/rahmen
link_ogl_default
remove_and_link splinerotk.h ../../__common__/code
popd
#=======================================================================
pushd opengl-z-buffer/loesung
link_ogl_default
remove_and_link in-reader.h ../../__common__/code
popd
#=======================================================================
pushd opengl-z-buffer/modelle
link_models
link_clip_info
remove_and_link dreiecke2.in ../../__common__/modelle
remove_and_link snowman.in ../../__common__/modelle
remove_and_link voyager.in ../../__common__/modelle
popd
#=======================================================================
pushd opengl-z-buffer/rahmen
link_ogl_default
remove_and_link in-reader.h ../../__common__/code
popd
#=======================================================================
pushd polygone-1-fuellen/material
link_polygons
popd
#=======================================================================
pushd polygone-2-muster
folder_remove_and_link loesung ../polygone-3-fuellen-muster/loesung
popd
#=======================================================================
pushd polygone-2-muster/material
link_polygons
remove_and_link polygon1a.in ../../__common__/in
remove_and_link polygon1b.in ../../__common__/in
popd
#=======================================================================
pushd polygone-2-muster/rahmen
link_muster
remove_and_link polygmuster_polygon1a.png ../../polygone-3-fuellen-muster/rahmen
remove_and_link polygmuster_polygon1b.png ../../polygone-3-fuellen-muster/rahmen
remove_and_link polygmuster_polygon1.png ../../polygone-3-fuellen-muster/rahmen
remove_and_link polygmuster_polygon2.png ../../polygone-3-fuellen-muster/rahmen
remove_and_link polygmuster_polygon3.png ../../polygone-3-fuellen-muster/rahmen
remove_and_link polygmuster_polygon4.png ../../polygone-3-fuellen-muster/rahmen
remove_and_link polygmuster_polygon5.png ../../polygone-3-fuellen-muster/rahmen
remove_and_link polygmuster_polygon6.png ../../polygone-3-fuellen-muster/rahmen
popd
#=======================================================================
pushd polygone-3-fuellen-muster/loesung
link_muster
popd
#=======================================================================
pushd polygone-3-fuellen-muster/material
link_polygons
remove_and_link polygon1a.in ../../__common__/in
remove_and_link polygon1b.in ../../__common__/in
popd
#=======================================================================
pushd polygone-3-fuellen-muster/rahmen
link_muster
popd
#=======================================================================
pushd projektion-1-perspektive/loesung
remove_and_link in-reader.h ../../__common__/code
popd
#=======================================================================
pushd projektion-1-perspektive/modelle
link_models
remove_and_link snowman.in ../../__common__/modelle
remove_and_link voyager.in ../../__common__/modelle
popd
#=======================================================================
pushd projektion-1-perspektive/rahmen
remove_and_link in-reader.h ../../__common__/code
popd
#=======================================================================
pushd projektion-2-clip-3d/loesung
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
popd
#=======================================================================
pushd projektion-2-clip-3d/modelle
link_clip_models
link_clip_info
#remove_and_link snowman.in ../../__common__/modelle
popd
#=======================================================================
pushd projektion-2-clip-3d/rahmen
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
popd
#=======================================================================
pushd projektion-3-z-buffer/loesung
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
remove_and_link zbuffer.h ../../__common__/code/loesungen
popd
#=======================================================================
pushd projektion-3-z-buffer/modelle
link_models
link_clip_info
remove_and_link dreiecke2.in ../../__common__/modelle
remove_and_link snowman.in ../../__common__/modelle
remove_and_link voyager.in ../../__common__/modelle
popd
#=======================================================================
pushd projektion-3-z-buffer/rahmen
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
popd
#=======================================================================
pushd projektion-4-beleuchtung/loesung
remove_and_link in-reader.h ../../__common__/code
remove_and_link lighting.h ../../__common__/code/loesungen
remove_and_link proj-clip.h ../../__common__/code
remove_and_link zbuffer.h ../../__common__/code/loesungen
popd
#=======================================================================
pushd projektion-4-beleuchtung/modelle
link_models
link_clip_info
remove_and_link dreiecke2.in ../../__common__/modelle
remove_and_link snowman.in ../../__common__/modelle
remove_and_link voyager.in ../../__common__/modelle
popd
#=======================================================================
pushd projektion-4-beleuchtung/rahmen
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
remove_and_link zbuffer.h ../../__common__/code/loesungen
popd
#=======================================================================
pushd projektion-rundflug/loesung
remove_and_link in-reader.h ../../__common__/code
remove_and_link lighting.h ../../__common__/code/loesungen
remove_and_link proj-clip.h ../../__common__/code
remove_and_link zbuffer.h ../../__common__/code/loesungen
popd
#=======================================================================
pushd projektion-rundflug/modelle
remove_and_link toureiffel.in ../../__common__/modelle
popd
#=======================================================================
pushd projektion-rundflug2/loesung
remove_and_link in-reader.h ../../__common__/code
remove_and_link lighting.h ../../__common__/code/loesungen
remove_and_link proj-clip.h ../../__common__/code
remove_and_link zbuffer.h ../../__common__/code/loesungen
popd
#=======================================================================
pushd projektion-rundflug2/modelle
remove_and_link colosseum.in ../../__common__/modelle
remove_and_link lunarlander.in ../../__common__/modelle
popd
#=======================================================================
pushd raytracing-1
folder_remove_and_link loesung ../__common__/code/raytracer
popd
#=======================================================================
pushd raytracing-1/rahmen
link_raytrace
remove_and_link scene_exercise.png ../../__common__/code/raytracer/images
remove_and_link scene_snowman.png ../../__common__/code/raytracer/images
popd
#=======================================================================
pushd raytracing-2
folder_remove_and_link loesung ../__common__/code/raytracer
popd
#=======================================================================
pushd raytracing-2/rahmen
link_raytrace
link_raytrace2
popd
#=======================================================================
pushd raytracing-2/rahmen-combi
link_raytrace
link_raytrace2
remove_and_link Makefile ../rahmen
remove_and_link raytracer.cc ../../raytracing-1/rahmen
remove_and_link scene_exercise2.png ../rahmen
remove_and_link tetraeder.cc ../rahmen
remove_and_link triangle.cc ../rahmen
popd
#=======================================================================
pushd splines-b
folder_remove_and_link material ../splines-catmull-rom/material
folder_remove_and_link rahmen ../splines-catmull-rom/rahmen
popd
#=======================================================================
pushd splines-b/loesung
remove_and_link curves.cc ../../splines-catmull-rom/loesung
popd
#=======================================================================
pushd splines-bezier
folder_remove_and_link material ../splines-catmull-rom/material
folder_remove_and_link rahmen ../splines-catmull-rom/rahmen
popd
#=======================================================================
pushd splines-bezier/loesung
remove_and_link curves.cc ../../splines-catmull-rom/loesung
popd
#=======================================================================
pushd splines-bezier-flaechen/loesung
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
remove_and_link splinesurf.h ../../__common__/code
popd
#=======================================================================
pushd splines-bezier-flaechen/rahmen
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
remove_and_link splinesurf.h ../../__common__/code
popd
#=======================================================================
pushd splines-catmull-rom/material
link_points
popd
#=======================================================================
pushd splines-hermite-animation/loesung
remove_and_link hermite.h ../../splines-hermite/loesung
popd
#=======================================================================
pushd splines-rotationskoerper/loesung
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
remove_and_link splinerotk.h ../../__common__/code
popd
#=======================================================================
pushd splines-rotationskoerper/rahmen
remove_and_link in-reader.h ../../__common__/code
remove_and_link proj-clip.h ../../__common__/code
remove_and_link splinerotk.h ../../__common__/code
popd
#=======================================================================
