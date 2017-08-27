#!/bin/bash

# Get the file
imgtool get coco_jvc_rsdos "$DISK_DIR/BASIC.DSK" $1 $1

# convert line endings from coco to unix
sed -i 's/\x0d/\x0a/g' $1
