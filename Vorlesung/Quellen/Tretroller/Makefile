## Makefile für roller.c
## author:  Holger Arndt
## version: 06.11.2015
CPP := cpp
MAKEDEP := $(CPP) -MM
CC := gcc
CCFLAGS := -Wall -std=c11

CEXE := roller
CSRC := $(CEXE).c
COBJ := $(patsubst %.c,%.o,$(CSRC))
CDEP := $(patsubst %.c,%.dep,$(CSRC))
OPENGLLIBS := -lGL -lGLU -lglut -lm

all: $(CEXE)

.SUFFIXES:
.SECONDARY:

%: %.o $(COBJ)
	$(CC) $(COBJ) -o $@ $(OPENGLLIBS)

%.o: %.c
	$(CC) $(CCFLAGS) -c $<

%.dep: %.c
	$(MAKEDEP) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@

clean:
	rm -f $(COBJ) $(CDEP) $(CEXE)

-include $(CDEP)
