.PHONY: all


all: ../toe/patched

../toe/patched: 0001-Change-target-part-to-Alveo-U50.patch
	cd ../toe; patch -p1 < $(abspath $<)
	touch $@
