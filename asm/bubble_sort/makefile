SOURCE=bubble_sort.asm
BINARY=sort.bin
DISK=180K-RS.DSK
MAME_DIR=/home/brandonb/projects/mame

all: $(SOURCE) $(BINARY) writedisk mame

$(BINARY): $(SOURCE)
	lwasm $(SOURCE) --6809 --list --symbols --6800compat --output=$(BINARY) --format=decb

makedisk:
	imgtool create coco_jvc_rsdos $(DISK) 

writedisk:
	imgtool put coco_jvc_rsdos $(DISK) $(BINARY) $(BINARY)

mame:
# Run from the mame directory
	cd $(MAME_DIR); \
	mame64 coco2 -skip_gameinfo -window -debug -flop1 ~/projects/coco2/asm/bubble_sort/180K-RS.DSK

clean:
	rm -f $(BINARY)





