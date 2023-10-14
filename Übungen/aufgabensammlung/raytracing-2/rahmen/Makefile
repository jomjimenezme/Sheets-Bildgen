## Makefile für Raytracer
## Autor: Holger Arndt
## Datum: 22.12.2015

CPP = cpp
MAKEDEP = $(CPP) -MM -std=c++11 -fPIC
CXX = g++
CXXFLAGS = -std=c++11 -O3 -Wall \
	-Wno-unused-local-typedefs -Wno-deprecated-declarations \
	-fPIC -DQT_NO_VERSION_TAGGING
CPPQTINC = -I/home/bildgen/cppqt
CPPQTLIB = -L/home/bildgen/cppqt -ldrawqt
QTINC = -I/usr/include/qt5/QtCore -I/usr/include/qt5/QtGui \
	-I/usr/include/qt5/QtWidgets -I/usr/include/qt5
QTLIB = -lQt5Core -lQt5Gui -lQt5Widgets
EIGENINC = -I/usr/include/eigen3

SCENESEXE = scene_snowman scene_exercise scene_exercise2
SCENESSRC = $(patsubst %,%.cc,$(SCENESEXE))
SCENESOBJ = $(patsubst %.cc,%.o,$(SCENESSRC))
SCENESDEP = $(patsubst %.cc,%.dep,$(SCENESSRC))
RTSRC = box.cc camera.cc image.cc light.cc parallelepiped.cc parallelogram.cc \
	planar.cc plane.cc raytracer.cc scene.cc sphere.cc tetraeder.cc \
	triangle.cc
RTOBJ =  $(patsubst %.cc,%.o,$(RTSRC))
RTDEP = $(patsubst %.cc,%.dep,$(RTSRC))


default: $(SCENESEXE)

.SUFFIXES:
.SECONDARY:

%: %.o $(RTOBJ)
	$(CXX) $^ -o $@ $(CPPQTLIB) $(QTLIB)

%.o: %.cc
	$(CXX) $(CXXFLAGS) -c -I. $(CPPQTINC) $(QTINC) $(EIGENINC) $< -o $@

%.dep: %.cc
	$(MAKEDEP) $< | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@

clean:
	rm -rf $(SCENESEXE) $(SCENESOBJ) $(SCENESDEP) $(RTOBJ) $(RTDEP)

tgz:
	tar cfvz raytracer.tgz README Makefile *.h *.cc

-include $(SCENESDEP) $(RTDEP)
