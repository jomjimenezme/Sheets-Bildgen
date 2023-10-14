# Pfade fuer alle Vorlesungen
## Pfad fuer Tools wie twl2tex, lst2src, lst2tex, ...
PATH := $(PATH):$(HOME)/LehreAllgemein/VorlesungsTemplate/Tools/bin
## Pfad fuer Perl-Dateien (syhlfun.pl)
PERL5LIB := $(HOME)/LehreAllgemein/VorlesungsTemplate/Tools/src/syhl
export PATH PERL5LIB

# Notebook
NOTEBOOK := wmainb6

# Variable fuer Quelldateien und Programme einlesen
include mkvars.inc
export CPP MAKEDEP CC CCFLAGS CXX CXXFLAGS JBC JBCFLAGS DC DCFLAGS \
	FC FCFLAGS F77 F77FLAGS F90 F90FLAGS AR ARFLAGS RANLIB TOPMAKEDIR

# Rechner-abhaengige Alternativen einbinden
NODENAME := $(shell uname -n | sed 's/\..*//')
-include mkvars_$(NODENAME).inc

# Include-File fuer alternative Compiler einbinden
-include mkvarsalt_$(subst $(REALSRCDIR).,,$(SRCDIR)).inc
-include mkvarsalt_$(NODENAME)_$(subst $(REALSRCDIR).,,$(SRCDIR)).inc

# automatisch erzeugte Variable
TOPMAKEDIR := $(shell pwd)/
MAKEFLAGS += --no-print-directory

TEX := $(patsubst %.twl,%.tex,$(TWL))

PNGBW := $(patsubst %.png,%_bw.png,$(PNG))
JPGBW := $(patsubst %.jpg,%_bw.jpg,$(JPG))

EPSPDF := $(patsubst %.eps,%.pdf,$(EPS))
EPSPDFMT := $(patsubst %.eps,%.pdf.mt,$(EPS))

TFIGTWL := $(patsubst %.fig,%.twl,$(TFIG))
TFIGTEX := $(patsubst %.fig,%.tex,$(TFIG))
TFIGPDF := $(patsubst %.fig,%.pdf,$(TFIG))
PFIGPDF := $(patsubst %.fig,%.pdf,$(PFIG))
FIGTWL = $(TFIGTWL)
FIGTEX = $(TFIGTEX)
FIGPDF = $(TFIGPDF) $(PFIGPDF)

TINKTWL := $(patsubst %.svg,%.twl,$(TINKSVG))
TINKTEX := $(patsubst %.svg,%.tex,$(TINKSVG))
TINKPDF := $(patsubst %.svg,%.pdf,$(TINKSVG))
TINKPDFMT := $(patsubst %.svg,%.tinkpdf.mt,$(TINKSVG))
PINKPDF := $(patsubst %.svg,%.pdf,$(PINKSVG))
INKTWL = $(TINKTWL)
INKTEX = $(TINKTEX)
INKPDF = $(TINKPDF) $(PINKPDF)

GPTEX := $(patsubst %.gp,%.tex,$(GP))
GPPDF := $(patsubst %.gp,%.pdf,$(GP))
#GPPDFMT := $(patsubst %.gp,%.pdf.mt,$(GP))

LYPDF := $(patsubst %.ly,%.pdf,$(LY))

ALLGENEPS = $(GPEPS)
ALLEPS := $(ALLGENEPS) $(EPS)
ALLEPSBW := $(patsubst %.eps,%_bw.eps,$(ALLEPS))
ALLPDF := $(EPSPDF) $(FIGPDF) $(INKPDF) $(GPPDF) $(LYPDF)
ALLPDFBW := $(patsubst %.pdf,%_bw.pdf,$(ALLPDF) $(PDF))
ALLPDFMT := $(EPSPDFMT) $(TINKPDFMT) #$(GPPDFMT)
ALLPDFBWMT := $(patsubst %.pdf.mt,%_bw.pdf.mt,$(ALLPDFMT)) \
	$(patsubst %.pdf,%_bw.oripdf.mt,$(PDF)) \
	$(patsubst %.pdf,%_bw.figpdf.mt,$(FIGPDF)) \
	$(patsubst %.pdf,%_bw.tinkpdf.mt,$(TINKPDF)) \
	$(patsubst %.pdf,%_bw.pinkpdf.mt,$(PINKPDF)) \
	$(patsubst %.pdf,%_bw.gppdf.mt,$(GPPDF)) \
	$(patsubst %.pdf,%_bw.lypdf.mt,$(LYPDF))

CSRC := $(patsubst %,$(SRCDIR)/%,$(CSRCREL))
CLMSRC := $(patsubst %,$(SRCDIR)/%,$(CLMSRCREL))
CEXEMT := $(patsubst %.c,%.cexe.mt,$(CSRC))
CLMEXEMT := $(patsubst %.c,%.clmexe.mt,$(CLMSRC))
CSRC += $(CLMSRC)
CSRCLST := $(patsubst %,%.lst,$(CSRC))
COBJ := $(patsubst %.c,%.o,$(CSRC))
CEXE := $(patsubst %.o,%,$(COBJ))
CTEXMT := $(patsubst %,%.tex.mt,$(CSRC))
CDEP := $(patsubst %.c,%.dep,$(CSRC))

CCSRC := $(patsubst %,$(SRCDIR)/%,$(CCSRCREL))
CCSRCLST := $(patsubst %,%.lst,$(CCSRC))
CCOBJ := $(patsubst %.cc,%.o,$(CCSRC))
CCEXE := $(patsubst %.o,%,$(CCOBJ))
CCEXEMT := $(patsubst %.o,%.ccexe.mt,$(CCOBJ))
CCTEXMT := $(patsubst %,%.tex.mt,$(CCSRC))
CCDEP := $(patsubst %.cc,%.dep,$(CCSRC))

CPPSRC := $(patsubst %,$(SRCDIR)/%,$(CPPSRCREL))
CPPSRCLST := $(patsubst %,%.lst,$(CPPSRC))
CPPOBJ := $(patsubst %.cpp,%.o,$(CPPSRC))
CPPEXE := $(patsubst %.o,%,$(CPPOBJ))
CPPEXEMT := $(patsubst %.o,%.cppexe.mt,$(CPPOBJ))
CPPTEXMT := $(patsubst %,%.tex.mt,$(CPPSRC))
CPPDEP := $(patsubst %.cpp,%.dep,$(CPPSRC))

HEADERSRC := $(patsubst %,$(SRCDIR)/%,$(HEADERSRCREL))
HEADERSRCLST := $(patsubst %,%.lst,$(HEADERSRC))
HEADERTEXMT := $(patsubst %,%.tex.mt,$(HEADERSRC))

JAVASRC := $(patsubst %,$(SRCDIR)/%,$(JAVASRCREL))
JAVACLASS :=$(patsubst %.java,%.class,$(JAVASRC))
JAVASRCLST := $(patsubst %,%.lst,$(JAVASRC))
JAVATEXMT := $(patsubst %,%.tex.mt,$(JAVASRC))

F77SRC := $(patsubst %,$(SRCDIR)/%,$(F77SRCREL))
F77SRCLST := $(patsubst %,%.lst,$(F77SRC))
F77OBJ := $(patsubst %.f,%.o,$(F77SRC))
F77EXE := $(patsubst %.o,%,$(F77OBJ))
F77EXEMT := $(patsubst %.o,%.f77exe.mt,$(F77OBJ))
F77TEXMT := $(patsubst %,%.tex.mt,$(F77SRC))

F90SRC := $(patsubst %,$(SRCDIR)/%,$(F90SRCREL))
F90SRCLST := $(patsubst %,%.lst,$(F90SRC))
F90OBJ := $(patsubst %.f90,%.o,$(F90SRC))
F90EXE := $(patsubst %.o,%,$(F90OBJ))
F90EXEMT := $(patsubst %.o,%.f90exe.mt,$(F90OBJ))
F90TEXMT := $(patsubst %,%.tex.mt,$(F90SRC))

PERLSRC := $(patsubst %,$(SRCDIR)/%,$(PERLSRCREL))
PERLSRCMT := $(patsubst %,%.perl.mt,$(PERLSRC))
PERLSRCLST := $(patsubst %,%.lst,$(PERLSRC))
PERLTEXMT := $(patsubst %,%.tex.mt,$(PERLSRC))

MATLABSRC := $(patsubst %,$(SRCDIR)/%,$(MATLABSRCREL))
MATLABSRCMT := $(patsubst %,%.mt,$(MATLABSRC))
MATLABSRCLST := $(patsubst %,%.lst,$(MATLABSRC))
MATLABTEXMT := $(patsubst %,%.tex.mt,$(MATLABSRC))

SHSRC := $(patsubst %,$(SRCDIR)/%,$(SHSRCREL))
SHSRCMT := $(patsubst %,%.bash.mt,$(SHSRC))
SHSRCLST := $(patsubst %,%.lst,$(SHSRC))
SHTEXMT := $(patsubst %,%.tex.mt,$(SHSRC))

NOLANGSRC := $(patsubst %,$(SRCDIR)/%,$(NOLANGSRCREL))
NOLANGSRCMT := $(patsubst %,%.nolang.mt,$(NOLANGSRC))
NOLANGSRCLST := $(patsubst %,%.lst,$(NOLANGSRC))
NOLANGTEXMT := $(patsubst %,%.tex.mt,$(NOLANGSRC))

OTHERSRC := $(patsubst %,$(SRCDIR)/%,$(OTHERSRCREL))
OTHERSRCLST := $(patsubst %,%.lst,$(OTHERSRC))
OTHERTEXMT := $(patsubst %,%.tex.mt,$(OTHERSRC))

SUBMAKESDIR := $(patsubst %,$(SRCDIR)/%,$(SUBMAKESDIRREL))
SUBMAKES := $(patsubst %,%/Makefile,$(SUBMAKESDIR))
SUBMAKESCOL := $(patsubst %,%.col,$(SUBMAKES))
SUBMAKESLST := $(patsubst %,%.lst,$(SUBMAKES))
SUBMAKESTEXMT := $(patsubst %,%.tex.mt,$(SUBMAKES))

MAKEINCSRC := $(patsubst %,$(SRCDIR)/%,$(MAKEINCSRCREL))
MAKEINCSRCMT := $(patsubst %,%.makeinc.mt,$(MAKEINCSRC))
MAKEINCSRCLST := $(patsubst %,%.lst,$(MAKEINCSRC))
MAKEINCTEXMT := $(patsubst %,%.tex.mt,$(MAKEINCSRC))

OTHERFILES := $(patsubst %,$(SRCDIR)/%,$(OTHERFILESREL))
OTHERCLEANFILES := $(patsubst %,$(SRCDIR)/%,$(OTHERCLEANFILESREL))

ALLNONMTSRC1 = $(CSRC) $(CCSRC) $(CPPSRC) $(HEADERSRC) $(JAVASRC) $(F77SRC) \
	$(F90SRC)
ALLNONMTSRC2 = $(OTHERSRC) $(SUBMAKES)
ALLNONMTSRC = $(ALLNONMTSRC1) $(ALLNONMTSRC2)
ALLNONBINSRC1 = $(ALLNONMTSRC1)
ALLNONBINSRC2 = $(ALLNONMTSRC2)
ALLNONBINSRC3 = $(PERLSRC) $(MATLABSRC) $(SHSRC) $(NOLANGSRC) $(MAKEINCSRC)
ALLNONBINSRC = $(ALLNONBINSRC1) $(ALLNONBINSRC2) $(ALLNONBINSRC3)
ALLSRC = $(ALLNONBINSRC) $(OTHERFILES)
ALLSRCMT = $(PERLSRCMT) $(MATLABSRCMT) $(SHSRCMT) $(NOLANGSRCMT) $(MAKEINCSRCMT)
ALLSRCLST1 = $(CSRCLST) $(MATLABSRCLST) $(CCSRCLST) $(CPPSRCLST) \
	$(HEADERSRCLST) $(JAVASRCLST) $(F77SRCLST) $(F90SRCLST)
ALLSRCLST2 = $(PERLSRCLST) $(SHSRCLST) $(NOLANGSRCLST)
ALLSRCLST3 = $(OTHERSRCLST) $(SUBMAKESCOL) $(MAKEINCSRCLST)
ALLSRCLST = $(ALLSRCLST1) $(ALLSRCLST2) $(ALLSRCLST3)
ALLTEXMT = $(CTEXMT) $(CCTEXMT) $(CPPTEXMT) $(HEADERTEXMT) $(JAVATEXMT) \
	$(F77TEXMT) $(F90TEXMT) $(PERLTEXMT) $(MATLABTEXMT) $(SHTEXMT) \
	$(NOLANGTEXMT) $(OTHERTEXMT) $(SUBMAKESTEXMT) $(MAKEINCTEXMT)
ALLLANGINFO = $(patsubst %.tex.mt,%.langinfo,$(ALLTEXMT))
ALTDIR := $(ALTDIR1) $(ALTDIR2) $(ALTDIR3) $(ALTDIR4) $(ALTDIR5) $(ALTDIR6) \
	$(ALTDIR7) $(ALTDIR8)
ALLALTSRCLST = $(foreach \
	AD,$(ALTDIR),$(patsubst $(SRCDIR)/%,$(AD)/%,$(ALLSRCLST) $(OTHERFILES)))

ifeq (landscape,$(findstring landscape,$(shell head $(MAIN).twl)))
ORIENTATION := landscape
else
ORIENTATION := portrait
endif

ALLV := pdf ps ps4 bwpdf bwps bwps4
ALLV += slpdf slps slps4 slbwpdf slbwps slbwps4
ALLV += webpdf webps webps4 webbwpdf webbwps webbwps4
ALLV += shps
ifeq ($(ORIENTATION),portrait)
ALLV += 2pps 2ppdf sl2ppdf
endif

# feste Variable
#PDF2PS = acroread
PDF2PS = pdftops
ifeq ($(ORIENTATION),landscape)
# --keepinfo gab Fehlermeldung, Skript in /usr/local/texlive/2020/texmf-dist/scripts/pdfjam angepasst
PDF4UP = pdfjam --nup 2x2 --frame true --scale 0.98 --keepinfo --quiet \
	--landscape --outfile
PDF8UP = pdfjam --nup 2x4 --frame true --scale 0.98 --keepinfo --quiet \
	--no-landscape --outfile
#PDF2PSOPT = -toPostScript -level2 -size a4 -landscape -pairs
PDF2PSOPT = -level2 -paper A4 -noshrink -nocenter -r 1200
#PDF82PSOPT = -toPostScript -level2 -size a4 -pairs
PDF82PSOPT = -level2 -paper A4 -noshrink -nocenter -r 1200
#PS4UP = pstops -h210mm -w297mm "4:0L@0.5(0.52h,0.01w)+1L@0.5(0.52h,0.49w)+2L@0.5(0.98h,0.01w)+3L@0.5(0.98h,0.49w)"
#PS8UP = psnup -8 -f
PDF2EPSOPT = -eps
else
PDF4UP = pdfjam --nup 2x2 --frame true --scale 0.98 --keepinfo --quiet \
	--no-landscape --outfile
PDF8UP = pdfjam --nup 4x2 --frame true --scale 0.98 --keepinfo --quiet \
	--landscape --outfile
#PDF2PSOPT = -toPostScript -level2 -size a4 -pairs
PDF2PSOPT = -level2 -paper A4 -noshrink -nocenter -r 1200
#PDF82PSOPT = -toPostScript -level2 -size a4 -landscape -pairs
PDF82PSOPT = -level2 -paper A4 -noshrink -nocenter -r 1200
#PS4UP = pstops "4:0@0.5(0.02w,0.49h)+1@0.5(0.5w,0.49h)+2@0.5(0.02w,0.01h)+3@0.5(0.5w,0.01h)"
#PS8UP = psnup -8
endif
PS2PDF = ps2pdf14 -dPDFSETTINGS=/prepress -dSubsetFonts=true \
	-dEmbedAllFonts=true -dAutoRotatePages=/All
EPS2PDF = GS_OPTIONS="-dPDFSETTINGS=/prepress -dSubsetFonts=true -dEmbedAllFonts=true" \
		epstopdf
OKULAREXE = okular
ifeq ($(ORIENTATION),landscape)
OKULAR = $(OKULAREXE) --qwindowgeometry 1400x970
OKULAR8 = $(OKULAREXE) --qwindowgeometry 930x1200
PSVIEW = gv -watch -media=a4 -orientation=landscape -scale=2 -antialias
PS4VIEW = gv -watch -media=a4 -orientation=landscape -scale=2 -antialias
PS8VIEW = gv -watch -media=a4 -scale=2 -antialias
GVPDFVIEW = gv -watch -scale=0 -antialias
else
OKULAR = $(OKULAREXE) --qwindowgeometry 930x1200
OKULAR8 = $(OKULAREXE) --qwindowgeometry 1400x970
PSVIEW = gv -watch -media=a4 -scale=0 -antialias
PS4VIEW = $(PSVIEW)
PS8VIEW = gv -watch -media=a4 -orientation=landscape -scale=0 -antialias
GVPDFVIEW = gv -watch -scale=0 -antialias
endif
XVIEW = xournalpp

#Farben
STDCOL=[0m
CMDCOL=[38;2;0;180;0m
ERRCOL=[38;2;180;0;0m
OUTCOL=[38;2;0;0;180m
ARCHCOL=[38;2;180;0;180m
CLEANCOL=[38;2;180;180;180m
WHATCOL=[1;38;2;255;255;0;48;2;180;0;0m
CLOSINGBRACKETSDUMMY=]]]]]]]
export STDCOL CMDCOL ERRCOL OUTCOL CLEANCOL

default: what

all: srctgz allv allpp

some: allp ps

allv: $(ALLV)

pdf: $(MAIN).pdf
pdf4: $(MAIN)_4up.pdf
pdf8: $(MAIN)_8up.pdf
ps: $(MAIN).ps
ps4: $(MAIN)_4up.ps
ps8: $(MAIN)_8up.ps

bwpdf: $(MAIN)_bw.pdf
bwps: $(MAIN)_bw.ps
bwps4: $(MAIN)_bw_4up.ps
bwps8: $(MAIN)_bw_8up.ps

slpdf: $(MAIN)_slides.pdf
slps: $(MAIN)_slides.ps
slps4: $(MAIN)_slides_4up.ps
slps8: $(MAIN)_slides_8up.ps

slbwpdf: $(MAIN)_slides_bw.pdf
slbwps: $(MAIN)_slides_bw.ps
slbwps4: $(MAIN)_slides_bw_4up.ps
slbwps8: $(MAIN)_slides_bw_8up.ps

webpdf: $(MAIN)_web.pdf
webps: $(MAIN)_web.ps
webps4: $(MAIN)_web_4up.ps
webps8: $(MAIN)_web_8up.ps

webbwpdf: $(MAIN)_web_bw.pdf
webbwps: $(MAIN)_web_bw.ps
webbwps4: $(MAIN)_web_bw_4up.ps
webbwps8: $(MAIN)_web_bw_8up.ps

sh: shpdf
shpdf: $(MAIN)_short.pdf
shps: $(MAIN)_short.ps

2pps: $(MAIN)_2p.ps.mt
2ppdf: $(MAIN)_2p.pdf.mt
sl2ppdf: $(MAIN)_slides_2p.pdf.mt

tgz: $(MAIN).tgz
srctgz: $(MAIN)_$(SRCDIR).tgz

# verhindere, dass make selbst zu wissen glaubt, wie man dvi's u.a. erzeugt
.SUFFIXES:

#default-Target
what:
	@printf "$(WHATCOL)make what?$(STDCOL)\n"
	@printf "$(ERRCOL)e.g.: pdf, slpdf, webpdf, bwpdf, sh, ps, ...\n"
	@printf "$(ERRCOL)e.g.: view, psview, kview, kslview, ...\n"
	@printf "$(ERRCOL)e.g.: all, allv, allp, allpp, cleanall, ...\n"

#Ausgabe von $(MAIN) zur Verwendung im Skript makepack
printmain:
	@printf "%s" $(MAIN)

#Ausgabe der Sprache zur Verwendung im Skript makepack
printlang:
	@(head -2 $(MAIN).tex | grep -q german) && printf "%s" german || \
		printf "%s" english

#Vorlesung
%.tex: %.twl
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(TWL2TEX) $@
	@$(TWL2TEX) -srcdir=$(SRCDIR) $*

%_bw.tex: %.tex
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" sed $@
	@sed 's/colour,/nocolour,/' $< > $@

%_slides.tex: %.tex
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" sed $@
	@sed 's/,noblanks/,blanks/' $< > $@

%_web.tex: %.tex
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" sed $@
	@sed 's/,noblanks/,blanks,web/' $< > $@

%_short.tex: %.tex
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" sed $@
	@sed 's/,noshort/,short/' $< > $@

$(MAIN)_bw.pdf: $(ALLPDFBWMT) $(PNGBW) $(JPGBW)
$(MAIN)_slides_bw.pdf: $(ALLPDFBWMT) $(PNGBW) $(JPGBW)
$(MAIN)_web_bw.pdf: $(ALLPDFBWMT) $(PNGBW) $(JPGBW)

%.pdf: %.tex $(TEX) $(STY) %.bbl $(FIGTEX) $(FIGPDF) $(INKTEX) $(PINKPDF) \
		$(GPTEX) $(LYPDF) $(ALLPDFMT) $(PNG) $(JPG) $(ALLSRCLST) \
		$(ALLTEXMT)
	@test -r $*.toc && cp $*.toc $*.oldtoc || touch $*.oldtoc
	@test -r $*.idx && cp $*.idx $*.oldidx || touch $*.oldidx
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" xeLaTeX $@
	@xelatex \\nonstopmode \\input $* | $(LTXFILT)
	@egrep -q 'Citation .* undefined.' $*.log && \
		(cp $*.toc $*.oldtoc && \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" biber $@ && \
		((biber $* | grep -v INFO | grep -v WARN || true) > $*.bbl) && \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "xeLaTeX (cite)" $@ && \
		(xelatex \\nonstopmode \\input $* | $(LTXFILT))) || true
	@grep -q 'Rerun to get cross-references right' $*.log \
		&& (cp $*.toc $*.oldtoc && \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "xeLaTeX (ref)" $@ && \
		(xelatex \\nonstopmode \\input $* | $(LTXFILT))) || true
	@test -r $*.idx && \
		(cmp -s $*.idx $*.oldidx && true || \
		(cp $*.toc $*.oldtoc && \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" xindy $@ && \
		(cat $*.idx | tr '%' ' ' | \
			sed 's/达\([SW]S\)\([0-9]\+\)[0-9/]*/达Sem\2\1/' | \
			xindy -M latex -M latex-loc-fmts -M makeindex \
			-M latin-lettergroups -M halecture -C utf8 -L general \
			-o $*.ind > /dev/null) && \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "xeLaTeX (idx)" $@ && \
		(xelatex \\nonstopmode \\input $* | $(LTXFILT))) || \
		true) || true
	@grep -q 'Rerun to get cross-references right' $*.log \
		&& (cp $*.toc $*.oldtoc && \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "xeLaTeX (ref 2)" $@ && \
		(xelatex \\nonstopmode \\input $* | $(LTXFILT))) || true
	@cmp -s $*.toc $*.oldtoc && true || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "xeLaTeX (toc)" $@ && \
		(xelatex \\nonstopmode \\input $* | $(LTXFILT)))
	@rm -f $*.oldtoc $*.oldidx

%4up.ps: %4up.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(PDF2PS) $@
	@$(PDF2PS) $(PDF2PSOPT) $< $*_0.ps
ifeq ($(ORIENTATION),XXXlandscape)
#ifeq ($(ORIENTATION),landscape)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" pstops $@
	@pstops -h210mm -w297mm "1:0L(1h,0w)" $*_0.ps $@ 2>&1| $(LTXFILT)
	@rm -f $*_0.ps
else
	@mv -f $*_0.ps $@
endif
	@chmod g+r $@

%8up.ps: %8up.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(PDF2PS) $@
	@$(PDF2PS) $(PDF82PSOPT) $< $*_0.ps
ifeq (A,A) #($(ORIENTATION),landscape)
#ifeq ($(ORIENTATION),landscape)
	@mv -f $*_0.ps $@
else
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" pstops $@
	@pstops -h210mm -w297mm "1:0L(1h,0w)" $*_0.ps $@ 2>&1| $(LTXFILT)
	@rm -f $*_0.ps
endif
	@chmod g+r $@

%.ps: %.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(PDF2PS) $@
	@$(PDF2PS) $(PDF2PSOPT) $< $*_0.ps
	@mv -f $*_0.ps $@
	@chmod g+r $@

%_2p.ps.mt: %.ps
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "perl+psselect+pstops" $*_2p.ps
	@( \
		PPS=$^ ; \
		NUMPAGES=`grep Pages $$PPS | grep -v atend | head -1 | cut -b 10-` ; \
		PCMD="\$$pp = \"_,\"; \$$i = 0; \
		      \$$pp .= \"\$$i,\$$i,\" while \$$i++ < $$NUMPAGES - 1; \
		      \$$pp .= $$NUMPAGES; print \$$pp" ; \
		PAGESTR=`perl -e "$$PCMD"` ; \
		psselect -p$$PAGESTR $$PPS | \
			pstops -d0.25pt \
				"2:0@0.565L(0.85w,0h)+1@0.85L(1.07w,0.4h)" \
			> $*_2p.ps \
	) 2> /dev/null
	@ln -sf $*_2p.ps $@

%_2p.pdf.mt: %_2p.ps.mt
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "ps2pdf14" $*_2p.pdf
	@$(PS2PDF) $< $*_2p.pdf
	@ln -sf $*_2p.pdf $@

%_4up.pdf: %.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" pdfjam $@
	@$(PDF4UP) $@ $< > /dev/null

%_8up.pdf: %.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" pdfjam $@
	@$(PDF8UP) $@ $< > /dev/null

%.bbl: $(BIB)
	@if [ -r $*.aux ] ; then \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" biber $@ ; \
		((biber $* | grep -v INFO | grep -v WARN || true) > $*.bbl) ; \
	else \
		touch $@ ; \
	fi

%.twl: %.fig
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" fig2dev $@
	@fig2dev -L pdftex_t -E 0 -p $* $< $@
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" iconv $@
	@iconv -f LATIN1 -t UTF8 -o $@.u8 $@
	@mv $@.u8 $@

%.twl %.tinkpdf.mt: %.svg
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" inkscape "$*.twl, $*.pdf"
	@inkscape --export-latex --export-filename=$*.pdf -D $<
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" sed $@
	@sed 's/\.pdf//' $*.pdf_tex | \
		sed 's/\\color\[rgb\]{\([0-9.]*\),\([0-9.]*\),\([0-9.]*\)}/\\inkscapecolor[rgb]{\1}{\2}{\3}/g' | \
		sed 's/\\&/\&/g' | sed 's/\\%/\%/g' > $*.twl
	@rm -f $*.pdf_tex
	@ln -sf $(notdir $*).pdf $*.tinkpdf.mt

.SECONDARY:
%_bw.png: %.png
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" convert $@
	@convert -colorspace gray $< $@

%_bw.jpg: %.jpg
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" convert $@
	@exiftool $< | grep 'Resolution Unit' | grep -q None && \
		convert -type GrayScale -density 72 $< $@ || \
		convert -type GrayScale $< $@

%.pdf: %.fig
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" fig2dev $@
	@fig2dev -L pdftex $< $@

%.pdf: %.svg
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" inkscape $@
	@inkscape --export-filename=$@ -D $<

%.tex %.pdf: %.gp
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" gnuplot "$*.tex, $*.pdf"
	@gnuplot $<
#@sed -i 's/\\begingroup/\\begingroup\\renewcommand{\\mathcol}{}/' $*.tex

%.pdf: %.ly
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" lilypond $@
	@lilypond -s -o $*_0 $<
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" pdfcrop $@
	@pdfcrop --margins "0 0 8 0" $*_0.pdf $@ > /dev/null
	@rm $*_0.pdf

%_bw.eps: %.eps
	@if [ $< == BUW_Logo.eps ] ; then \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" cp $@ ; \
		cp $< $@ ; \
	else \
		(grep -q 'Creator: gnuplot' $< && \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" sed $@ && \
			sed 's;%%EndComments;%%EndComments\n/setrgbcolor {.11 mul exch .59 mul add exch .3 mul add setgray} def;' $< > $@) || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "gs+sed" $@ && \
		gs -dNOPAUSE -dBATCH -sOutputFile=- -sDEVICE=ps2write \
			-sColorConversionStrategy=Gray \
			-dProcessColorModel=/DeviceGray	-dEPSCrop -q $*.eps | \
			sed 's;/letter setpagesize;null setpagesize;' > $@)) ; \
	fi

#%_bw.figpdf.mt: %.pdf
#	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "gs" $*_bw.pdf
#	@gs -dNOPAUSE -dBATCH -sOutputFile=$*_bw.pdf -sDEVICE=pdfwrite \
		-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray \
		-dCompatibilityLevel=1.4 -q $<
#	@ln -sf $(notdir $*)_bw.pdf $@

%_bw.figpdf.mt: %.fig
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" fig2dev $@
	@fig2dev -L pdftex -N $< $*_bw.pdf
	@ln -sf $(notdir $*)_bw.pdf $@

%_bw.tinkpdf.mt: %.tinkpdf.mt
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "gs" $*_bw.pdf
	@gs -dNOPAUSE -dBATCH -sOutputFile=$*_bw.pdf -sDEVICE=pdfwrite \
		-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray \
		-dCompatibilityLevel=1.4 -q $<
	@ln -sf $(notdir $*)_bw.pdf $@

%_bw.pinkpdf.mt: %.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "gs" $*_bw.pdf
	@gs -dNOPAUSE -dBATCH -sOutputFile=$*_bw.pdf -sDEVICE=pdfwrite \
		-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray \
		-dCompatibilityLevel=1.4 -q $<
	@ln -sf $(notdir $*)_bw.pdf $@

%_bw.gppdf.mt: %.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "gs" $*_bw.pdf
	@gs -dNOPAUSE -dBATCH -sOutputFile=$*_bw.pdf -sDEVICE=pdfwrite \
		-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray \
		-dCompatibilityLevel=1.4 -q $<
	@ln -sf $(notdir $*)_bw.pdf $@

%_bw.lypdf.mt: %.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" cp $*_bw.pdf
	@cp $< $*_bw.pdf
	@ln -sf $(notdir $*)_bw.pdf $@

unused_alternative: nothing
	printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(PDF2PS)+gs+epstopdf" $*_bw.pdf
	$(PDF2PS) $(PDF2EPSOPT) $< - | \
		gs -dNOPAUSE -dBATCH -sOutputFile=- -sDEVICE=psgray -dEPSCrop \
			-q - | \
		$(EPS2PDF) --filter > $*_bw.pdf


%_bw.oripdf.mt: %.pdf
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" gs $*_bw.pdf
	@gs -dNOPAUSE -dBATCH -sOutputFile=$*_bw.pdf -sDEVICE=pdfwrite \
		-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray \
		-dCompatibilityLevel=1.4 -q $<
	@ln -sf $(notdir $*)_bw.pdf $@

%.pdf.mt: %.eps
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" epstopdf $*.pdf
	@$(EPS2PDF) $*.eps
	@ln -sf $(notdir $*).pdf $*.pdf.mt

%.langinfo: %.lst
	@if [ -e $@ ] ; then \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" touch $@ ; \
		touch $@ ; \
	else \
		printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" echo $@ ; \
		echo -n NoLang > $@ ; \
	fi

%.tex.mt: %.lst %.langinfo
	@printf "$(CMDCOL) %-20s -> %s$(OUTCOL)\n" $(LST2TEX) $*.\*.tex
	@$(LST2TEX) -lang=`cat $*.langinfo` $*
	@touch $@

touch:
	@touch $(MAIN).twl

#Viewer fuer Vorlesung
view: $(MAIN).pdf
	@acroread $< &

kview: $(MAIN).pdf
	@$(OKULAR) $< 2> /dev/null &

xview: $(MAIN).pdf
	@$(XVIEW) $< 2> /dev/null &

k4view: $(MAIN)_4up.pdf
	@$(OKULAR) $< 2> /dev/null &

k8view: $(MAIN)_8up.pdf
	@$(OKULAR8) $< 2> /dev/null &

gvview: $(MAIN).pdf
	@$(GVPDFVIEW) $< &

psview: $(MAIN).ps
	@$(PSVIEW) $< &

ps4view: $(MAIN)_4up.ps
	@$(PS4VIEW) $< &

ps8view: $(MAIN)_8up.ps
	@$(PS8VIEW) $< &

kbwview: $(MAIN)_bw.pdf
	@$(OKULAR) $< 2> /dev/null &

bwpsview: $(MAIN)_bw.ps
	@$(PSVIEW) $< &

bwps4view: $(MAIN)_bw_4up.ps
	@$(PS4VIEW) $< &

slview: $(MAIN)_slides.pdf
	@acroread $< &

kslview: $(MAIN)_slides.pdf
	@$(OKULAR) $< 2> /dev/null &

xslview: $(MAIN)_slides.pdf
	@$(XVIEW) $< 2> /dev/null &

slpsview: $(MAIN)_slides.ps
	@$(PSVIEW) $< &

kslbwview: $(MAIN)_slides_bw.pdf
	@$(OKULAR) $< 2> /dev/null &

slbwpsview: $(MAIN)_slides_bw.ps
	@$(PSVIEW) $< &

webview: $(MAIN)_web.pdf
	@acroread $< &

kwebview: $(MAIN)_web.pdf
	@$(OKULAR) $< 2> /dev/null &

webpsview: $(MAIN)_web.ps
	@$(PSVIEW) $< &

kwebbwview: $(MAIN)_web_bw.pdf
	@$(OKULAR) $< 2> /dev/null &

webbwpsview: $(MAIN)_web_bw.ps
	@$(PSVIEW) $< &

kshview: $(MAIN)_short.pdf
	@$(OKULAR) $< 2> /dev/null &

shpsview: $(MAIN)_short.ps
	@$(PSVIEW) $< &

2ppsview: $(MAIN)_2p.ps.mt
	@gv -watch -media=a4 -orientation=landscape -scale=0 -antialias \
		$(MAIN)_2p.ps &

2pview: $(MAIN)_2p.pdf.mt
	@acroread $(MAIN)_2p.pdf &

sl2pview: $(MAIN)_slides_2p.pdf.mt
	@acroread $(MAIN)_slides_2p.pdf &

#Programme
allpp: allp allpalt

allp: $(ALLSRCMT) $(ALLNONMTSRC) $(COBJ) $(CEXEMT) $(CLMEXEMT) \
	$(CCOBJ) $(CCEXEMT) $(CPPOBJ) $(CPPEXEMT) \
	$(JAVACLASS) \
	$(F77OBJ) $(F77EXEMT) $(F90OBJ) $(F90EXEMT) \
	submakeall

%.c: %.c.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.cc: %.cc.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.cpp: %.cpp.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.h: %.h.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.hpp: %.hpp.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.h.in: %.h.in.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.java: %.java.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.javash: %.javash.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@cp $< $@  # to keep file permissions
	@$(LST2SRC) $@ > /dev/null

%.d: %.d.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.cs: %.cs.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $@ > /dev/null

%.f: %.f.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXF77) $@ > /dev/null

%.f90: %.f90.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXF90) $@ > /dev/null

%.pl: %.pl.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@cp $< $@  # to keep file permissions
	@$(LST2SRC) $(LST2XXXPROLOG) $@ > /dev/null

%.perl.mt: %.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $*
	@cp $< $*  # to keep file permissions
	@$(LST2SRC) $(LST2XXXPERL) $* > /dev/null
	@ln -sf $(notdir $*) $@

%.py: %.py.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@cp $< $@  # to keep file permissions
	@$(LST2SRC) $(LST2XXXPYTHON) $@ > /dev/null

%.m: %.m.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@cp $< $@  # to keep file permissions
	@$(LST2SRC) $(LST2XXXOCTAVE) $@ > /dev/null

%.m.mt: %.m.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $*.m
	@$(LST2SRC) $(LST2XXXMATLAB) $*.m > /dev/null
	@ln -sf $(notdir $*.m) $@

%.lisp: %.lisp.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@cp $< $@  # to keep file permissions
	@$(LST2SRC) $(LST2XXXLISP) $@ > /dev/null

%.bash.mt: %.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $*
	@cp $< $*  # to keep file permissions
	@$(LST2SRC) $(LST2XXXSH) $* > /dev/null
	@ln -sf $(notdir $*) $@

%.ma: %.ma.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXMATHEMATICA) $@ > /dev/null

%.sql: %.sql.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXSQL) $@ > /dev/null

%.html: %.html.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXHTML) $@ > /dev/null

%.jsp: %.jsp.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXHTML) $@ > /dev/null

%.xml: %.xml.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXXML) $@ > /dev/null

%.qrc: %.qrc.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXXML) $@ > /dev/null

%.qml: %.qml.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXQML) $@ > /dev/null

%.ac: %.ac.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXAC) $@ > /dev/null

%.tex: %.tex.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXTEX) $@ > /dev/null

%.pas: %.pas.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXPASCAL) $@ > /dev/null

%.p: %.p.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXPASCAL) $@ > /dev/null

%.vb: %.vb.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXBASIC) $@ > /dev/null

%Makefile.lst: %Makefile.col
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(UNCOLMAKE) $@
	@$(UNCOLMAKE) $< > $@

%Makefile: %Makefile.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $@
	@$(LST2SRC) $(LST2XXXMAKE) $@ > /dev/null
	@$(MAKE) -f Makefile.col -e --no-print-directory -C $(@D) clean

%.makeinc.mt: %.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $*
	@$(LST2SRC) $(LST2XXXMAKE) $* > /dev/null
	@ln -sf $(notdir $*) $@

%.nolang.mt: %.lst
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(LST2SRC) $*
	@cp $< $*  # to keep file permissions
	@$(LST2SRC) $(LST2XXXNOLANG) $* > /dev/null
	@ln -sf $(notdir $*) $@

%.dep: %.c $(HEADERSRC)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(MAKEDEP)" $@
	@$(MAKEDEP) $< | \
		sed 's,^\(.*\):,$(dir $<)\1:,' | \
		sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@

%.dep: %.cc $(HEADERSRC)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(MAKEDEP)" $@
	@(echo -n $(dir $<) ; $(MAKEDEP) $<) | \
		sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@

%.dep: %.cpp $(HEADERSRC)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(MAKEDEP)" $@
	@(echo -n $(dir $<) ; $(MAKEDEP) $<) | \
		sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@

%.o: %.c
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(CC)" $@
	@(cd $(dir $<) ; $(CC) $(CCFLAGS) -c $(notdir $<))

%.cexe.mt: %.o
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(CC) (ld)" $*
	@(cd $(dir $<) ; $(CC) $(notdir $<) -o $(notdir $*))
	@ln -sf $(notdir $*) $@

%.clmexe.mt: %.o
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(CC) (ld)" $*
	@(cd $(dir $<) ; $(CC) $(notdir $<) -o $(notdir $*) -lm)
	@ln -sf $(notdir $*) $@

%.o: %.cc
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(CXX)" $@
	@(cd $(dir $<) ; $(CXX) $(CXXFLAGS) -c $(notdir $<))

%.ccexe.mt: %.o
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(CXX) (ld)" $*
	@(cd $(dir $<) ; $(CXX) $(notdir $<) -o $(notdir $*))
	@ln -sf $(notdir $*) $@

%.o: %.cpp
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(CXX)" $@
	@(cd $(dir $<) ; $(CXX) $(CXXFLAGS) -c $(notdir $<))

%.cppexe.mt: %.o
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(CXX) (ld)" $*
	@(cd $(dir $<) ; $(CXX) $(notdir $<) -o $(notdir $*))
	@ln -sf $(notdir $*) $@

%.class: %.java
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" $(JBC) $@
	@(cd $(dir $<) ; $(JBC) $(JBCFLAGS) $(notdir $<))

%.o: %.f
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(F77)" $@
	@(cd $(dir $<) ; $(F77) $(F77FLAGS) -c $(notdir $<))

%.f77exe.mt: %.o
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(F77) (ld)" $*
	@(cd $(dir $<) ; $(F77) $(notdir $<) -o $(notdir $*))
	@ln -sf $(notdir $*) $@

%.o: %.f90
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(F90)" $@
	@(cd $(dir $<) ; $(F90) $(F90FLAGS) -c $(notdir $<))

%.f90exe.mt: %.o
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" "$(F90) (ld)" $*
	@(cd $(dir $<) ; $(F90) $(notdir $<) -o $(notdir $*))
	@ln -sf $(notdir $*) $@

submakeall:
	@for i in $(SUBMAKESCOL) ; do \
		$(MAKE) -f Makefile.col -e  \
			-q -C `dirname $$i` || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" make "$$i : all" ; \
		$(MAKE) -f Makefile.col -e  \
			-C `dirname $$i` all) || exit ; done

srcalt: $(ALLALTSRCLST)

$(ALTDIR1)/%: $(SRCDIR)/%
	@[ -d `dirname $@` ] || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" mkdir `dirname $@` ; \
		mkdir -p `dirname $@`)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" ln $@
	@ln -s `pwd`/$< $@

$(ALTDIR2)/%: $(SRCDIR)/%
	@[ -d `dirname $@` ] || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" mkdir `dirname $@` ; \
		mkdir -p `dirname $@`)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" ln $@
	@ln -s `pwd`/$< $@

$(ALTDIR3)/%: $(SRCDIR)/%
	@[ -d `dirname $@` ] || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" mkdir `dirname $@` ; \
		mkdir -p `dirname $@`)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" ln $@
	@ln -s `pwd`/$< $@

$(ALTDIR4)/%: $(SRCDIR)/%
	@[ -d `dirname $@` ] || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" mkdir `dirname $@` ; \
		mkdir -p `dirname $@`)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" ln $@
	@ln -s `pwd`/$< $@

$(ALTDIR5)/%: $(SRCDIR)/%
	@[ -d `dirname $@` ] || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" mkdir `dirname $@` ; \
		mkdir -p `dirname $@`)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" ln $@
	@ln -s `pwd`/$< $@

$(ALTDIR6)/%: $(SRCDIR)/%
	@[ -d `dirname $@` ] || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" mkdir `dirname $@` ; \
		mkdir -p `dirname $@`)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" ln $@
	@ln -s `pwd`/$< $@

$(ALTDIR7)/%: $(SRCDIR)/%
	@[ -d `dirname $@` ] || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" mkdir `dirname $@` ; \
		mkdir -p `dirname $@`)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" ln $@
	@ln -s `pwd`/$< $@

$(ALTDIR8)/%: $(SRCDIR)/%
	@[ -d `dirname $@` ] || \
		(printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" mkdir `dirname $@` ; \
		mkdir -p `dirname $@`)
	@printf "$(CMDCOL) %-20s -> %s$(ERRCOL)\n" ln $@
	@ln -s `pwd`/$< $@

allpalt: srcalt
	@for i in $(ALTDIR) ; do \
		export REALSRCDIR=$(SRCDIR) ; \
		export SRCDIR=$$i ; \
		export ALTDIR1=invalid ; \
		export ALTDIR2=invalid ; \
		export ALTDIR3=invalid ; \
		export ALTDIR4=invalid ; \
		export ALTDIR5=invalid ; \
		export ALTDIR6=invalid ; \
		export ALTDIR7=invalid ; \
		export ALTDIR8=invalid ; \
		$(MAKE) allp ; \
		done

#Editieren
edit:
	@$(EDITOR) $(TWL) &

#Aufraeumen
cleanall: cleanv cleanpp

cleantwltex:
	@printf "$(CLEANCOL)cleaning (erzeugte TeX-Dateien)\n"
	@rm -f $(TEX) $(TFIGTEX) $(TINKTEX) \
		$(SRCDIR)/*.*.tex \
		$(SRCDIR)/*/*.*.tex \
		$(SRCDIR)/*/*/*.*.tex \
		$(SRCDIR)/*/*/*/*.*.tex \
		$(SRCDIR)/*/*/*/*/*.*.tex \
		$(SRCDIR)/*/*/*/*/*/*.*.tex
	@rm -f $(ALLTEXMT)

cleanv: cleantwltex
	@printf "$(CLEANCOL)cleaning (Vorlesung)\n"
	@rm -f $(MAIN)*.pdf $(MAIN)*.ps* $(MAIN)*.pdf.mt \
		$(MAIN)*.aux $(MAIN)*.toc \
		$(MAIN)*.log $(MAIN)*.out $(MAIN).tpt \
		$(MAIN)*.bbl $(MAIN)*.blg $(MAIN)_*.tex \
		$(MAIN)*.idx $(MAIN)*.ind $(MAIN)*.bcf $(MAIN)*.run.xml \
		$(MAIN)*.mtc* $(MAIN)*.maf $(MAIN)*.bmt $(MAIN)*.thm \
		$(MAIN)*.oldidx $(MAIN)*.oldtoc *~ fig*.bak *.fig.bak \
		$(ALLGENEPS) $(ALLPDF) $(ALLPDFMT) \
		$(ALLEPSBW) $(ALLPDFBW) $(ALLPDFBWMT) \
		$(FIGTWL) $(FIGTEX) $(INKTWL) $(INKTEX) $(GPTEX) \
		$(PNGBW) $(JPGBW)
	@rm -f $(ALLLANGINFO)

cleanpp: cleanp cleanpalt

cleanp: submakeclean
	@printf "$(CLEANCOL)cleaning (Programme)\n"
	@rm -f $(CSRC) $(COBJ) $(CEXE) $(CEXEMT) $(CLMEXEMT) $(CDEP) \
		$(CCSRC) $(CCOBJ) $(CCEXE) $(CCEXEMT) $(CCDEP) \
		$(CPPSRC) $(CPPOBJ) $(CPPEXE) $(CPPEXEMT) $(CPPDEP) \
		$(HEADERSRC)
	@rm -f $(JAVASRC) \
		$(F77SRC) $(F77OBJ) $(F77EXE) $(F77EXEMT) \
		$(F90SRC) $(F90OBJ) $(F90EXE) $(F90EXEMT)
	@rm -f $(SUBMAKES) $(SUBMAKESLST)
	@rm -f $(SRCDIR)/*/*.mod $(SRCDIR)/*/*/*.mod \
		$(SRCDIR)/*/*/*/*.mod $(SRCDIR)/*/*/*/*/*.mod \
		$(SRCDIR)/*/*.class $(SRCDIR)/*/*/*.class \
		$(SRCDIR)/*/*/*/*.class $(SRCDIR)/*/*/*/*/*.class \
		$(SRCDIR)/*/*.pyc $(SRCDIR)/*/*/*.pyc \
		$(SRCDIR)/*/*/*/*.pyc $(SRCDIR)/*/*/*/*/*.pyc
	@rm -rf $(SRCDIR)/*/__pycache__ $(SRCDIR)/*/*/__pycache__ \
		$(SRCDIR)/*/*/*/__pycache__ $(SRCDIR)/*/*/*/*/__pycache__
	@rm -f $(PERLSRC) $(PERLSRCMT) $(MATLABSRC) $(MATLABSRCMT) \
		$(SHSRC) $(SHSRCMT) $(NOLANGSRC) $(NOLANGSRCMT) $(OTHERSRC) \
		$(MAKEINCSRC) $(MAKEINCSRCMT)
	@rm -f $(SRCDIR)/*~ $(SRCDIR)/*/*~ $(SRCDIR)/*/*/*~ \
		$(SRCDIR)/*/*/*/*~ $(SRCDIR)/*/*/*/*/*~ \
		$(SRCDIR)/*/*/*/*/*/*~ \
		$(MAIN)_$(SRCDIR).tgz \
		$(MAIN)_$(SRCDIR).tgz.filelist $(MAIN).tgz.filelist
	@rm -rf $(OTHERCLEANFILES)

cleanpalt:
	@rm -rf $(ALTDIR)

submakeclean:
	@for i in $(SUBMAKES) ; do \
		$(MAKE) -f Makefile.col -e --no-print-directory \
			-C `dirname $$i` clean ; done

#Archivieren
$(MAIN).tgz.filelist: $(TWL) $(STY) $(PNG) $(JPG) $(EPS) $(PDF) \
		$(BIB) $(TFIG) $(PFIG) $(TINKSVG) $(PINKSVG) $(GP) $(LY) \
		$(ALLSRCLST) $(OTHERFILES) \
		$(TOOLS) Makefile mkvars*.inc
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" echo $@
	@echo $(TWL) $(STY) $(PNG) $(JPG) $(EPS) $(PDF) \
		$(BIB) $(TFIG) $(PFIG) $(TINKSVG) $(PINKSVG) \
		$(GP) $(LY) $(OTHERFILES) $(TOOLS) \
		Makefile mkvars*.inc | tr ' ' '\n' > $@
	@echo $(ALLSRCLST1) | tr ' ' '\n' >> $@
	@echo $(ALLSRCLST2) | tr ' ' '\n' >> $@
	@echo $(ALLSRCLST3) | tr ' ' '\n' >> $@
	@echo Makefile mkvars*.inc | tr ' ' '\n' >> $@

$(MAIN).tgz: $(MAIN).tgz.filelist
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "tar | gzip" $@
	@tar cfvT - $< | gzip -c9 > $@

$(MAIN)_$(SRCDIR).tgz.filelist: $(ALLSRCMT) $(ALLNONMTSRC) $(OTHERFILES)
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" echo $@
	@echo $(ALLNONBINSRC1) | tr ' ' '\n' > $@
	@echo $(ALLNONBINSRC2) | tr ' ' '\n' >> $@
	@echo $(ALLNONBINSRC3) | tr ' ' '\n' >> $@
	@echo $(OTHERFILES) | tr ' ' '\n' >> $@

$(MAIN)_$(SRCDIR).tgz: $(MAIN)_$(SRCDIR).tgz.filelist
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "tar | gzip" $@
	@tar cfvT - $< | gzip -c9 > $@

VorlesungsTemplate.tgz: $(VORLESUNGSTEMPLATE) $(TOOLS)
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "tar | gzip" $@
	@tar cfv - $^ | gzip -c9 > $@

#Transport auf Diskette
DISKETTE = /media/stick
save: tgz
	@mount $(DISKETTE)
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "cp" $(DISKETTE)/$(MAIN).tgz
	@cp -v $(MAIN).tgz $(DISKETTE)
	@sync
	@umount $(DISKETTE)

restore:
	@mount $(DISKETTE)
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "tar" \*
	@tar xfvz $(DISKETTE)/$(MAIN).tgz
	@sync
	@umount $(DISKETTE)

#Kopien via scp
sget:
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" make "$(SCPHOST): tgz"
	@ssh $(SCPHOST) \( cd $(SCPPATH) \; make tgz \)
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" scp $(MAIN).tgz
	@scp $(SCPHOST):$(SCPPATH)/$(MAIN).tgz .
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "tar" \*
	@tar xfvz $(MAIN).tgz

sput: tgz
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" scp "$(SCPHOST): $(MAIN).tgz"
	@scp $(MAIN).tgz $(SCPHOST):$(SCPPATH)
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "ssh tar" "$(SCPHOST): \*"
	@ssh $(SCPHOST) \( cd $(SCPPATH) \; tar xfvz $(MAIN).tgz \)

#Subversion
add:
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "svn add" ""
	@svn add -N --force $(sort $(shell \
		for f in $(TWL) $(STY) $(PNG) $(JPG) \
			$(EPS) $(PDF) $(BIB) $(TFIG) $(PFIG) \
			$(TINKSVG) $(PINKSVG) $(GP) $(LY) \
			$(OTHERFILES) $(TOOLS) ; \
		do \
			while [ true ] ; \
			do \
				out+=" $$f" ; \
				[[ $$f =~ @ ]] && out+=@ ; \
				[ $$f == $${f/\//} ] && break ; \
				f=$${f%/*} ; \
			done ; \
		done ; \
		echo -n $$out)) Makefile mkvars.inc
	@svn add -N --force $(sort $(shell \
		for f in $(ALLSRCLST1) ; \
		do \
			while [ true ] ; \
			do \
				out+=" $$f" ; \
				[[ $$f =~ @ ]] && out+=@ ; \
				[ $$f == $${f/\//} ] && break ; \
				f=$${f%/*} ; \
			done ; \
		done ; \
		echo -n $$out)) Makefile
	@svn add -N --force $(sort $(shell \
		for f in $(ALLSRCLST2) ; \
		do \
			while [ true ] ; \
			do \
				out+=" $$f" ; \
				[[ $$f =~ @ ]] && out+=@ ; \
				[ $$f == $${f/\//} ] && break ; \
				f=$${f%/*} ; \
			done ; \
		done ; \
		echo -n $$out)) Makefile
	@svn add -N --force $(sort $(shell \
		for f in $(ALLSRCLST3) ; \
		do \
			while [ true ] ; \
			do \
				out+=" $$f" ; \
				[[ $$f =~ @ ]] && out+=@ ; \
				[ $$f == $${f/\//} ] && break ; \
				f=$${f%/*} ; \
			done ; \
		done ; \
		echo -n $$out)) Makefile
# in frueherer svn-Version: out+=" $$f@"	

commit: add
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "svn commit" ""
	@svn commit -m "commit aus Makefile"

status:
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "svn status" ""
	@svn status -uq

update:
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "svn update" ""
	@svn update

#Kopie auf Notebook und erzeugen der vorlesungsrelevanten Dateien
cp2nb: tgz
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" scp "$(NOTEBOOK): $(MAIN).tgz"
	@scp $(MAIN).tgz $(NOTEBOOK):$(NOTEBOOKPATH)
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "ssh tar" "$(NOTEBOOK): \*"
	@ssh $(NOTEBOOK) \( cd $(NOTEBOOKPATH) \; tar xfvz $(MAIN).tgz \)

nbupd:
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" "$(NOTEBOOK): svn update" ""
	@ssh $(NOTEBOOK) \( cd $(NOTEBOOKPATH) \; make update \)

nball: nbupd
	@printf "$(ARCHCOL) %-20s -> %s$(OUTCOL)\n" make "$(NOTEBOOK): slpdf allp"
ifeq ($(ORIENTATION),landscape)
	@ssh $(NOTEBOOK) \( cd $(NOTEBOOKPATH) \; make slpdf allp \)
else
	@ssh $(NOTEBOOK) \( cd $(NOTEBOOKPATH) \; make sl2ppdf allp \)
endif

#Statistik
size: twlsize picsize xfigsize inkscapesize gpsize srcsize submakesize \
	pagesize pdfpssize

twlsize:
	@printf "twl-files:  %4i, %6i lines, %7i bytes\n" \
		`ls -l $(TWL) | wc -l` `cat $(TWL) | wc -l` \
		`cat $(TWL) | wc -c`
picsize:
	@if [ -n "$(strip $(PNG) $(JPG) $(EPS))" ] ; then \
		printf \
			"pictures:   %4i\n" `ls -l $(PNG) $(JPG) $(EPS) | wc -l`; \
			fi
xfigsize:
	@if [ -n "$(strip $(TFIG) $(PFIG))" ] ; then \
		printf "xfig-files: %4i\n" `ls -l $(TFIG) $(PFIG) | wc -l`; fi
inkscapesize:
	@if [ -n "$(strip $(TINKSVG) $(PINKSVG))" ] ; then \
		printf \
			"svg-files:  %4i\n" `ls -l $(TINKSVG) $(PINKSVG) | wc -l`; \
			fi
gpsize:
	@if [ -n "$(strip $(GP))" ] ; then \
		printf "gp-files:   %4i\n" `ls -l $(GP) | wc -l`; fi
srcsize:
ifneq (,$(strip $(ALLNONBINSRC)))
	@echo $(ALLNONBINSRC1) > $(MAIN).srcsize.tmp
	@echo $(ALLNONBINSRC2) >> $(MAIN).srcsize.tmp
	@echo $(ALLNONBINSRC3) >> $(MAIN).srcsize.tmp
	@printf "sources:    %4i" `cat $(MAIN).srcsize.tmp | wc -w`
ifneq (,$(strip $(ALLNONBINSRC1)))
	@cat $(ALLNONBINSRC1) > $(MAIN).srcsize.tmp
endif
ifneq (,$(strip $(ALLNONBINSRC2)))
	@cat $(ALLNONBINSRC2) >> $(MAIN).srcsize.tmp
endif
ifneq (,$(strip $(ALLNONBINSRC3)))
	@cat $(ALLNONBINSRC3) >> $(MAIN).srcsize.tmp
endif
	@printf ", %6i lines" `cat $(MAIN).srcsize.tmp | wc -l`
	@printf ", %7i bytes\n" `cat $(MAIN).srcsize.tmp | wc -c`
	@rm -f $(MAIN).srcsize.tmp
else
	@true
endif
submakesize:
	@if [ -n "$(strip $(SUBMAKES))" ] ; then \
		printf "submakes:   %4i\n" `ls -l $(SUBMAKES) | wc -l`; fi
pagesize:
	@#if [ -r $(MAIN).ps ]; then \
	#	printf "pages: %29i pages\n" \
	#	`tail -20 $(MAIN).ps | grep Pages | cut -d ' ' -f 2`; fi
	@if [ -r $(MAIN).ps ]; then \
		printf "pages: %32i pages\n" \
		`head -20 $(MAIN).ps | grep Pages | cut -d ' ' -f 2`; fi
pdfpssize: pdfsize bwpdfsize pssize bwpssize
pdfsize:
	@if [ -r $(MAIN).pdf ]; then \
		printf "pdf: %34i bytes\n" \
		`ls -l $(MAIN).pdf | cut -d ' ' -f 5`; fi
bwpdfsize:
	@if [ -r $(MAIN)_bw.pdf ]; then \
		printf "bwpdf: %32i bytes\n" \
		`ls -l $(MAIN)_bw.pdf | cut -d ' ' -f 5`; fi
pssize:
	@if [ -r $(MAIN).ps ]; then \
		printf "ps: %35i bytes\n" \
		`ls -l $(MAIN).ps | cut -d ' ' -f 5`; fi
bwpssize:
	@if [ -r $(MAIN)_bw.ps ]; then \
		printf "bwps: %33i bytes\n" \
		`ls -l $(MAIN)_bw.ps | cut -d ' ' -f 5`; fi

#.dep-Dateien
-include $(CDEP) $(CCDEP)
