SRCS        = $(wildcard *.tex)
OBJS        = $(basename $(SRCS)).pdf
DEPS        = $(wildcard $(FORMAT_DIR)/*.tex)

BUILD_DIR   = build
OUTPUT_DIR  = output
FORMAT_DIR  = format

LATEX_ENGINE    = xelatex
#LATEX_ENGINE    = pdflatex
LATEX_ENG_PARAM = -output-directory=$(BUILD_DIR) #-dALLOWPSTRANSPARENCY
latexmk_param   = $(LATEX_ENG_PARAM) -$(LATEX_ENGINE)
latexmk_param  += -use-make -pvc -new-viewer- -f -view=pdf

.PHONY: all auto/%.pdf clean clean/all

all: $(OBJS)

%.pdf: %.tex $(BUILD_DIR)/%.title.tex $(BUILD_DIR)/format.tex $(BUILD_DIR) $(OUTPUT_DIR)
	${LATEX_ENGINE} $(LATEX_ENG_PARAM) $(basename $<)
	${LATEX_ENGINE} $(LATEX_ENG_PARAM) $(basename $<)
	${LATEX_ENGINE} $(LATEX_ENG_PARAM) $(basename $<)
	cp ${BUILD_DIR}/$@ $(OUTPUT_DIR)/$@

$(BUILD_DIR)/format.tex: $(DEPS) $(BUILD_DIR)
	ls -1 $(DEPS) | sed -e 's/^/\\input{..\//' | sed -e 's/$$/}/' > $@

$(BUILD_DIR)/%.title.tex: %.tex $(BUILD_DIR) FORCE
	@echo "\\\title{`ls -1 $< | sed -e 's/\.tex$$//'`}" > $@
	@echo "\\\date{`git --no-pager log -1 --format='%cd' --date='format:%Y-%m-%d' $<`}" >> $@
	@echo "\\\author{`git shortlog -n -s -- $< | awk '{print $$2}' | tr '\n' ',' | sed -e 's/,$$//' -e 's/,/& /'`}" >> $@

$(BUILD_DIR) $(OUTPUT_DIR):
	mkdir -p $@

%/auto: %.tex $(BUILD_DIR)/%.title.tex $(BUILD_DIR)/format.tex $(BUILD_DIR)
	latexmk ${latexmk_param} $(basename $<)

clean/all: clean
	-rm -rf $(OBJS)

clean:
	-rm -rvf $(BUILD_DIR)

FORCE:
