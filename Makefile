LATEX_ENGINE    = xelatex
OUTPUT_FILE     = $(notdir $(CURDIR)).pdf

TEMPLATE_FILE   = template.tex
FORMAT_DIR      = format/
DATA_DIR        = data/
BUILD_DIR       = build/

# files and dirs configurations
TEMPLATE_BASENAME = $(basename $(TEMPLATE_FILE))
FORMAT_FILES      = $(call rwildcard,$(FORMAT_DIR)/,*.tex)
DATA_FILES        = $(call rwildcard,$(DATA_DIR)/,*.tex)

# latexmk param configurations
LATEXMK_PARAM     = -output-directory=$(BUILD_DIR)
LATEXMK_PARAM    += -$(LATEX_ENGINE) -pdf$(LATEX_ENGINE)=$(LATEX_ENGINE)
LATEXMK_PARAM    += -use-make -new-viewer- -view=pdf -pvc -f

# The recursive wildcard
rwildcard         = $(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

.PHONY: all auto clean clean/all

all: $(OUTPUT_FILE)

$(OUTPUT_FILE): $(BUILD_DIR)/$(TEMPLATE_BASENAME).pdf
	cp -av $< $@

#$(BUILD_DIR)/$(TEMPLATE_BASENAME).pdf: $(TEMPLATE_FILE) $(FORMAT_FILES) $(DATA_FILES) $(BUILD_DIR)
$(BUILD_DIR)/$(TEMPLATE_BASENAME).pdf: $(TEMPLATE_FILE) $(FORMAT_FILES) $(DATA_FILES)
	mkdir -p $(dir $@)
	$(LATEX_ENGINE) -output-directory=$(dir $@) $<
	$(LATEX_ENGINE) -output-directory=$(dir $@) $<
	$(LATEX_ENGINE) -output-directory=$(dir $@) $<

auto: $(BUILD_DIR)
	latexmk $(LATEXMK_PARAM) $(TEMPLATE_BASENAME)

clean/all: clean
	-rm $(OUTPUT_FILE)

clean:
	-rm -rf $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $@

