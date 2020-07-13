.PHONY: all clean restore device-tree open

PROJECT_NAME := loopback
HARDWARE_DEF := ../board/design_top_wrapper.xsa
TARGET_MAKEFILE := $(PROJECT_NAME)/Debug/makefile

all: build

restore: $(PROJECT_NAME).xpr

clean:
	-@rm -rf $(PROJECT_NAME)* .Xil .metadata
	-@rm *.log *.jou .analytics

$(TARGET_MAKEFILE): $(HARDWARE_DEF)
	xsct ./restore_project.tcl $(PROJECT_NAME) $(HARDWARE_DEF) src/main.cpp
	rm $(PROJECT_NAME)/src/main.cpp
	ln -s $(abspath src/main.cpp) $(PROJECT_NAME)/src/main.cpp

build: $(TARGET_MAKEFILE)
	cd $(PROJECT_NAME)/Debug; make
