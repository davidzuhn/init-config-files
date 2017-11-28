BASH_DIR := $(shell pwd)



DOT_FILES = bashrc bash_profile


all:
	echo $(CWD)

install:
	for file in $(DOT_FILES) ; do \
	  rm -f $(HOME)/.$$file && ln -s $(BASH_DIR)/$$file $(HOME)/.$$file ; \
	done