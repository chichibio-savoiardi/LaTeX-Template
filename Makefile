# Main filename
ALL=$(patsubst %.tex,%.pdf,$(wildcard *.tex))

# Directories
FIG_DIR=fig
AUX_DIR=aux
OUT_DIR=out

# LaTeXMK
LMK=latexmk
LMKOPTS=--pdf --use-make --outdir=$(OUT_DIR) --auxdir=$(AUX_DIR) --bibfudge --indexfudge

all: booklet $(ALL)

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

