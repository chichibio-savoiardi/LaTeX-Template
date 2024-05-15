# Main filename
ALL=$(patsubst %.tex,%.pdf,$(wildcard *.tex))
PDF=Template.pdf

# Directories
FIG_DIR=fig
AUX_DIR=aux
OUT_DIR=out

# LaTeXMK
LMK=latexmk
LMKOPTS=--pdf --use-make --outdir=$(OUT_DIR) --auxdir=$(AUX_DIR) --bibfudge --indexfudge

all: main.pdf booklet

pdf: all
	cp -f ./$(OUT_DIR)/main.pdf ./$(PDF)
	cp -f ./$(OUT_DIR)/booklet.pdf ./Booklet_$(PDF)

booklet: prebooklet.pdf booklet.pdf

clean:
	$(LMK) -c
	
cleanall:
	$(LMK) -C
	rm -rf ./$(AUX_DIR) ./$(OUT_DIR)

%.pdf: %.tex
	$(LMK) $(LMKOPTS) $<

%.ind: %.idx
	makeindex $<

drawio/%.png: $(FIG_DIR)/drawio/%.drawio
	drawio --export --output ./$(FIG_DIR)/$@ $<

puml/%.png: $(FIG_DIR)/puml/%.puml
	plantuml $<

