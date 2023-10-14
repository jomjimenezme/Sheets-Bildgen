# \file    Makefile
# \author  Holger Arndt, Martin Galgon
# \date    11.11.2016
# \version 0.3

CPP = cpp
CXX = g++
MOC = moc-qt5

QT_INCLUDE_PATH = /usr/include/qt5
QT_LIBRARY_PATH = .

MAKEDEP = $(CPP) -MM -fPIC
CXXFLAGS = -std=c++11 -Wall -fPIC -DQT_NO_VERSION_TAGGING
QTINC = -I$(QT_INCLUDE_PATH)/QtCore -I$(QT_INCLUDE_PATH)/QtGui \
        -I$(QT_INCLUDE_PATH)/QtWidgets -I$(QT_INCLUDE_PATH)
QTLIB = -L$(QT_LIBRARY_PATH) -lQt5Core -lQt5Gui -lQt5Widgets

BSPSRC = bsp1.cc
BSPOBJ = $(patsubst %.cc,%.o,$(BSPSRC))
BSPEXE = $(patsubst %.cc,%,$(BSPSRC))
MOCHEA = drawwindow.h drawops.h iothread.h
MOCSRC = $(patsubst %.h,moc_%.cc,$(MOCHEA))
LIBSRC = drawcolour.cc drawing.cc drawops.cc drawwindow.cc iothread.cc main.cc matrix4x4.cc vec4d.cc vec3d.cc
LIBOBJ = $(patsubst %.cc,%.o,$(LIBSRC) $(MOCSRC))
LIBNAM = drawqt
LIB = lib$(LIBNAM).a
ALLDEP = $(patsubst %.cc,%.dep,$(BSPSRC) $(LIBSRC))
CPPQTCPY = drawcolour.h drawops.h iothread.h point2d.h \
           drawing.h drawwindow.h maindraw.h point2d.cc \
           vec3d.h vec4d.h matrix4x4.h

.PHONY: default
.PHONY: clean
.PHONY: doc
.PHONY: docu
.PHONY: copy
.PHONY: tstcopy

default: $(BSPEXE)

.SUFFIXES:
.SECONDARY:

%: %.o $(LIB)
	$(CXX) $< -o $@ -L. -l$(LIBNAM) $(QTLIB)

%.o: %.cc
	$(CXX) $(CXXFLAGS) -I. -c $(QTINC) $<

moc_%.cc: %.h
	$(MOC) $(QTINC) $< -o $@

$(LIB): $(LIBOBJ)
	ar rc $@ $^

%.dep: %.cc
	$(MAKEDEP) $(QTINC) $< | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@

clean:
	rm -rf $(BSPOBJ) $(LIBOBJ) $(BSPEXE) $(MOCSRC) $(LIB) $(ALLDEP) doc \
		pic1.png

doc: docu

docu:
	doxygen
	make -C doc/latex

copy:
	scp -r $(BSPSRC) $(LIBSRC) $(CPPQTCPY) Makefile Doxyfile \
		doc mb.pgm bildgen@l23:cppqt

tstcopy:
	scp -r $(BSPSRC) $(LIBSRC) $(CPPQTCPY) Makefile Doxyfile \
		mb.pgm l23:tst/cppqt

-include $(ALLDEP)
