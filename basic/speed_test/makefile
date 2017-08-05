SOURCE=speed.bas
DISK=BASIC0.DSK
MAME_DIR=/home/brandonb/projects/mame
CURR_DIR=$(shell pwd)

all: $(SOURCE) writedisk mame

makedisk:
	imgtool create coco_jvc_rsdos $(DISK) 

writedisk:
# --asci = [A=ASCII, B=binary]
# --ftype 
#  		0 = BASIC program
#  		1 = BASIC data file
#  		2 = machine-languate file
#  		3 = editor source file
# --filter=ascii : Translate line endings from PC to coco2
#
	imgtool put coco_jvc_rsdos $(DISK) $(SOURCE) $(SOURCE) --filter=ascii --ascii=A --ftype=0

mame:
# Run from the mame directory
	cd $(MAME_DIR); \
	mame64 coco2 -skip_gameinfo -window -flop1 $(CURR_DIR)/$(DISK)


