.PHONY: all
.PHONY: clean ccleanall cleansrc
.PHONY: symlinks rmsymlinks

outfile=uebersicht.pdf

all: $(outfile)

list.tex:
	@./list.sh list.tex

$(outfile): list.tex FORCE
	@latexmk -pdf -xelatex uebersicht.tex

symlinks:
	@./restore-symlinks.sh

rmsymlinks:
	@./wipe-symlinks.sh

clean:
	@rm -f *.aux *.log *.out *.fls *.fdb_latexmk *.xdv
	@rm -f list.tex

cleanall: clean
	@rm -f uebersicht.pdf

cleansrc:
	@find . -type f -name "*.dep" -delete
	@find . -type f -name "*.o" -delete
	@find . -type f -executable -not -name "*.*" -delete

.PHONY: FORCE
FORCE:

