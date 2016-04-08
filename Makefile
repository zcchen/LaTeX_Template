LATEX_ENGINE    = xelatex
OUTPUT_FILE     = 示例文档.pdf
OUTPUT_DIR      = build

# If you don't know why,
# Please DO NOT edit below:
data_dir        = data/
template_file   = template.tex
format_dir      = format/

template_basename = $(basename ${template_file})
latexmk_param     = -output-directory=${OUTPUT_DIR} -pdflatex=${LATEX_ENGINE}
latexmk_param    += -use-make -pvc -new-viewer- -f -view=pdf

all: make_dir ${data_dir} ${template_file} ${format_dir}
	${LATEX_ENGINE} -output-directory=${OUTPUT_DIR} ${template_file}
	${LATEX_ENGINE} -output-directory=${OUTPUT_DIR} ${template_file}
	${LATEX_ENGINE} -output-directory=${OUTPUT_DIR} ${template_file}
	cp ${OUTPUT_DIR}/${template_basename}.pdf ${OUTPUT_FILE}

make_dir:
	mkdir -p ${OUTPUT_DIR}

auto: make_dir
	latexmk ${latexmk_param} ${template_basename}

clean_all:
	-rm -rf ${OUTPUT_DIR}
	-rm ${OUTPUT_FILE}

clean:
	#-find ./${OUTPUT_DIR} ! -name '${OUTPUT_FILE}' -type f -exec rm -f {} +
	-rm -rf ${OUTPUT_DIR}

