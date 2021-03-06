# In-Outs
ENTRY_DIR = .
ENTRY = main
ENTRY_FNAME = $(ENTRY_DIR)/$(ENTRY).tex

DEST = build
TARGET = $(DEST)/$(ENTRY).pdf

# Latexmk commands
ENGINE = lualatex
FLAGS = -$(ENGINE) \
	-outdir=./$(DEST) \
	-synctex=1 \
	-interaction=nonstopmode \
	-file-line-error \
	-cd

# Sources
SCRIPT_DIR = sources
SOURCE = $(shell find \
	./$(SCRIPT_DIR) \
	./images \
	-type f)

# Build log
BUILD_TS = $(shell date "+%Y%m%d_%H%M%S")
LOG_DIR = $(DEST)/log
LOGFILE = $(LOG_DIR)/$(ENTRY)_build_$(BUILD_TS).log

$(TARGET): $(SOURCE)
	mkdir -p ./$(DEST)
	mkdir -p ./$(LOG_DIR)
	latexmk $(FLAGS) ./$(ENTRY_FNAME) > ./$(LOGFILE) 2>&1

clean:
	rm -f -r ./$(LOG_DIR)
	rm -f -r ./$(DEST)
	# clean log of latexindent generated by VSCode
	rm -f indent.log
