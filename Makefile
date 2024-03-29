# Main filename
ALL=$(patsubst %.tex,%.pdf,$(wildcard *.tex))
PDF=Template.pdf
# LaTeXMK
LMK=latexmk
LMKOPTS=--pdf --use-make --outdir=out --auxdir=aux --bibfudge --indexfudge

all: main.pdf booklet

pdf: all
	cp -f ./out/main.pdf ./$(PDF)
	cp -f ./out/booklet.pdf ./Booklet_$(PDF)

booklet: prebooklet.pdf booklet.pdf

clean:
	$(LMK) -c
	
cleanall:
	$(LMK) -C
	rm -rf ./aux ./out

%.pdf: %.tex
	$(LMK) $(LMKOPTS) $<

%.ind: %.idx
	makeindex $<
