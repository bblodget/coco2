SOURCES=sort.asm speed.asm prob41.asm dtc.asm itc.asm forth.asm
BINARIES=$(SOURCES:.asm=.bin)
MAME_DIR=/home/brandonb/projects/mame
CURR_DIR=$(shell pwd)
DISK=DISK0.DSK
DISK_DIR=$(CURR_DIR)/../disks

all: $(SOURCES) $(BINARIES) writedisk mame

sort.bin: sort.asm
	lwasm sort.asm --6809 --list --symbols --6800compat --output=sort.bin --format=decb

speed.bin: speed.asm
	lwasm speed.asm --6809 --list --symbols --6800compat --output=speed.bin --format=decb

prob41.bin: prob41.asm
	lwasm prob41.asm --6809 --list --symbols --6800compat --output=prob41.bin --format=decb

dtc.bin: dtc.asm
	lwasm dtc.asm --6809 --list --symbols --6800compat --output=dtc.bin --format=decb

itc.bin: itc.asm
	lwasm itc.asm --6809 --list --symbols --6800compat --output=itc.bin --format=decb

forth.bin: forth.asm
	lwasm forth.asm --6809 --list --symbols --6800compat --output=forth.bin --format=decb
#	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" forth.bin forth.bin

writedisk:
# --asci = [A=ASCII, B=binary]
# --ftype 
#  		0 = BASIC program
#  		1 = BASIC data file
#  		2 = machine-languate file
#  		3 = editor source file
# --filter=ascii : Translate line endings from PC to coco2
#
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" sort.bin sort.bin
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" speed.bin speed.bin
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" prob41.bin prob41.bin
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" dtc.bin dtc.bin
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" itc.bin itc.bin
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" forth.bin forth.bin

debug: $(SOURCES) $(BINARIES)
# run in debug mode
	mame64 coco2 -skip_gameinfo -window -debug -flop1 "$(DISK_DIR)/$(DISK)"

mame:
# normal mode
	mame64 coco2 -skip_gameinfo -window -flop1 "$(DISK_DIR)/$(DISK)"

clean:
	rm -f $(BINARIES)





