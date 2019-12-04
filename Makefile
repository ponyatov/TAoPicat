
CWD = $(CURDIR)
MODULE = $(notdir $(CWD))

TEX  = $(MODULE).tex header.tex
TEX += about.tex intro.tex
TEX += bib.tex
TEX += 1logic/logic.tex 1logic/basconstr.tex 1logic/11facts.tex

SRC += 1logic/father.pl 1logic/father.pi 1logic/plus.pl 1logic/plus.pi 1logic/plus.pi.log

LATEX = pdflatex -halt-on-error

$(MODULE).pdf: $(TEX) $(SRC)
	$(LATEX) $< | tail -n7
	$(LATEX) $< | tail -n7
	# $(LATEX) $<

NOW = $(shell date +%y%m%d)
REL = $(shell git rev-parse --short=4 HEAD)

pdf: doc $(MODULE).pdf $(MODULE)_$(NOW)-$(REL).pdf

doc: doc/TAOP.pdf doc/book.pdf doc/manual.pdf
doc/TAOP.pdf:
	wget -c -O $@ https://doc.lagout.org/programmation/Prolog/The%20Art%20of%20Prolog%20%202nd%20Ed%20-%20Leon%20Sterling%20%2C%20Ehud%20Shapiro.pdf
doc/book.pdf:
	wget -c -O $@ http://picat-lang.org/picatbook2015/constraint_solving_and_planning_with_picat.pdf
doc/manual.pdf:
	wget -c -O $@ http://picat-lang.org/download/picat_guide.pdf

MERGE  = Makefile .gitignore README.md doc
MERGE += $(MODULE).tex 1logic

merge:
	git checkout master
	git checkout shadow -- $(MERGE)

release: $(MODULE)_$(NOW)-$(REL).pdf
	git tag $(NOW)-$(REL)
	git push -v --tags ; git push -v

$(MODULE)_$(NOW)-$(REL).pdf: $(MODULE).pdf
	cp $< $@

