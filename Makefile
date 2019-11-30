
CWD = $(CURDIR)
MODULE = $(notdir $(CWD))

TEX = $(MODULE).tex header.tex

LATEX = pdflatex -halt-on-error

$(MODULE).pdf: $(TEX)
	$(LATEX) $< && $(LATEX) $<

pdf: TAOP.pdf $(MODULE).pdf
TAOP.pdf:
	wget -c -O $@ https://doc.lagout.org/programmation/Prolog/The%20Art%20of%20Prolog%20%202nd%20Ed%20-%20Leon%20Sterling%20%2C%20Ehud%20Shapiro.pdf
