include ../mkvars.inc

ALLEXE = bin/ltxfilt bin/lst2src bin/lst2tex bin/syhl bin/twl2tex bin/list2pr \
	bin/nocc bin/nocxx bin/nojc bin/nojch bin/nojbc bin/nodc bin/nof90 \
	bin/nof77 bin/nopc bin/nodelphic bin/nomcs bin/novbnc bin/nomkbundle \
	bin/nolisp

all: $(ALLEXE)

bin/ltxfilt: src/ltxfilt/ltxfilt.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/lst2src: src/lst2xxx/lst2src.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/lst2tex: src/lst2xxx/lst2tex.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/syhl: src/syhl/syhl.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/twl2tex: src/twl2tex/twl2tex.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/list2pr: src/list2pr/list2pr.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nocc: src/nocomp/nocc.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nocxx: src/nocomp/nocxx.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nojc: src/nocomp/nojc.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nojch: src/nocomp/nojch.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nojbc: src/nocomp/nojbc.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nodc: src/nocomp/nodc.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nof90: src/nocomp/nof90.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nof77: src/nocomp/nof77.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nopc: src/nocomp/nopc.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nodelphic: src/nocomp/nodelphic.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nomcs: src/nocomp/nomcs.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/novbnc: src/nocomp/novbnc.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nomkbundle: src/nocomp/nomkbundle.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

bin/nolisp: src/nocomp/nolisp.pl
	@printf "[0;32m %-20s -> %s[31m\n" ln $@
	@ln -s ../$^ $@

clean:
	rm -f *~ src/*/*~ src/*/*.o $(ALLEXE)
