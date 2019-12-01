
CWD = $(CURDIR)
MODULE = $(notdir $(CWD))

TEX  = $(MODULE).tex header.tex
TEX += about.tex intro.tex
TEX += bib.tex

LATEX = pdflatex -halt-on-error

$(MODULE).pdf: $(TEX)
	$(LATEX) $< | tail -n7
	$(LATEX) $< | tail -n7

NOW = $(shell date +%y%m%d)
REL = $(shell git rev-parse --short=4 HEAD)

pdf: TAOP.pdf $(MODULE).pdf $(MODULE)_$(NOW)-$(REL).pdf
TAOP.pdf:
	wget -c -O $@ https://doc.lagout.org/programmation/Prolog/The%20Art%20of%20Prolog%20%202nd%20Ed%20-%20Leon%20Sterling%20%2C%20Ehud%20Shapiro.pdf

release: $(MODULE)_$(NOW)-$(REL).pdf
	git tag $(NOW)-$(REL)
	git push -v --tags ; git push -v

$(MODULE)_$(NOW)-$(REL).pdf: $(MODULE).pdf
	cp $< $@
