#!/bin/sh

set -e

case "${1}" in
	prereqs)
		exit 0
		;;
esac

rm -rf /dev/block/mtd/by-name/
mkdir -p /dev/block/mtd/by-name
if [ -d /sys/class/mtd/ ]; then
    # nand
    for i in `ls /sys/class/mtd/mtd[0-9]*/name`; do
	    name=`cat ${i}`
	    i=${i##*mtd}
	    i=${i%/name}
	    ln -s /dev/mtdblock${i} /dev/block/mtd/by-name/${name}
    done
else
    # emmc
    i=1
    while ! ls /dev/mmcblk0p* >/dev/null 2>&1; do
        if [ $i -gt 10 ]; then
	    echo "Timeout!"
            exit 1
        fi
	echo "Waiting for eMMC storage..."
	i=$(($i+1))
    done
 
    for i in `ls /sys/block/mmcblk0/mmcblk0p*/volname`; do
	    name=`cat ${i}`
	    i=${i##*mmcblk0/}
	    i=${i%/volname}
	    ln -s /dev/${i} /dev/block/mtd/by-name/${name}
    done
fi

exit 0

