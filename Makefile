# Main filename
PROJ=main
# LaTeXMK
LMK=latexmk
LMKOPTS=--pdf --use-make --outdir=out --auxdir=build

proj: $(PROJ).pdf
	
booklet: prebooklet.pdf booklet.pdf
	
clean:
	$(LMK) -c
	
cleanall:
	$(LMK) -C

%.pdf: %.tex
	$(LMK) $(LMKOPTS) $<