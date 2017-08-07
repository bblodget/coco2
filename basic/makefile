DISK=DISK0.DSK
MAME_DIR=/home/brandonb/projects/mame
CURR_DIR=$(shell pwd)
DISK_DIR=$(CURR_DIR)/../disks

all: writedisk mame

writedisk:
# --asci = [A=ASCII, B=binary]
# --ftype 
#  		0 = BASIC program
#  		1 = BASIC data file
#  		2 = machine-languate file
#  		3 = editor source file
# --filter=ascii : Translate line endings from PC to coco2
#
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" speed.bas speed.bas --filter=ascii --ascii=A --ftype=0
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" vect.bas vect.bas --filter=ascii --ascii=A --ftype=0
	imgtool put coco_jvc_rsdos "$(DISK_DIR)/$(DISK)" strfmt.bas strfmt.bas --filter=ascii --ascii=A --ftype=0

mame:
	mame64 coco2 -skip_gameinfo -window -flop1 "$(DISK_DIR)/$(DISK)"


