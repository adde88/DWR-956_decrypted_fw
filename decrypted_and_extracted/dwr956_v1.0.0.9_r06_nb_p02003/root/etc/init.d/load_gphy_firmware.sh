#!/bin/sh /etc/rc.common

START=10

start() {
	echo "Load GPHY FW..."
	if [ -f /proc/driver/ifx_gphy/phyfirmware ]; then
		cd /tmp
		# For NOR, SPI and SLC NAND models partition name is "gphyfirmware"
		grep -qw "gphyfirmware" /proc/mtd && {
			local mtdb=`grep -w "gphyfirmware" /proc/mtd | cut -d: -f1`
			#dd if=/dev/$mtdb bs=72c skip=1 | unlzma > /tmp/gphy_image 2>/dev/null
			nanddump -f /tmp/gphy_image.lzma.img /dev/$mtdb
			dd if=/tmp/gphy_image.lzma.img bs=72c skip=1 of=/tmp/gphy_image.lzma
			rm /tmp/gphy_image.lzma.img
			unlzma /tmp/gphy_image.lzma
			[ $? -ne 0 ] && rm -f /tmp/gphy_image || true
		} || {
			# For MLC NAND models partition name is "uboot+gphyfw"
			grep -qw "uboot+gphyfw" /proc/mtd && {
				local mtdb=`grep -w "uboot+gphyfw" /proc/mtd | cut -d: -f1`
				#dd if=/dev/$mtdb bs=1M skip=1 | dd bs=72c skip=1 | unlzma > /tmp/gphy_image 2>/dev/null
				nanddump -f /tmp/gphy_image.lzma.img /dev/$mtdb
				dd if=/tmp/gphy_image.lzma.img bs=72c skip=1 of=/tmp/gphy_image.lzma
				rm /tmp/gphy_image.lzma.img
				unlzma /tmp/gphy_image.lzma
				[ $? -ne 0 ] && rm -f /tmp/gphy_image || true
			} || true
		}
		[ -f /tmp/gphy_image ] && {
			cat /tmp/gphy_image > /proc/driver/ifx_gphy/phyfirmware
			rm -f gphy_image
		}
	fi
}

