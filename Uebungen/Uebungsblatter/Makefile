LATEX=latexmk -pdf -xelatex

.PHONY: all clean uebungen purge

all: uebungen

uebungen:
	@$(LATEX) -pdf -xelatex uebungen.tex
	@sh uebungen-slices.sh

clean:
	@rm -f *.log *.aux *.out *.atfi *.fls *.fdb_latexmk *.xdv
	@rm -f uebungen-slices.sh

purge: clean
	@rm -f uebungen.pdf uebungen-*.pdf
