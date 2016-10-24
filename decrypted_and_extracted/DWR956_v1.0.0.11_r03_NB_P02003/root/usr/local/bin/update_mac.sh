#!/bin/sh
if [ -n "$1" ] ; then
	MAC_MTD=/dev/mtd3
	NOW_MAC=$1
	mkdir -p /tmp/wlan_cal
	cd /tmp/wlan_cal
	nanddump -f datab.gz "$MAC_MTD"
	tar -xf datab.gz && {
		echo "MAC=$1" > mac
		tar cf datab.gz cal_wlan0.bin mac && {
			nandwrite -e -p "$MAC_MTD" datab.gz || {
				echo "Failed to write datab.gz back into $MAC_MTD"
				cd /tmp
				rm -rf /tmp/wlan_cal
				exit
			}
			cd /tmp
			rm -rf /tmp/wlan_cal
			uboot_env --set --name ethaddr --value "$NOW_MAC" && echo "Update successfully" || echo "Update failed"
		} || {
			touch cal_wlan0.bin
			tar cf datab.gz cal_wlan0.bin mac
			nandwrite -e -p "$MAC_MTD" datab.gz || {
				echo "Failed to write datab.gz back into $MAC_MTD"
				cd /tmp
				rm -rf /tmp/wlan_cal
				exit
			}
			cd /tmp
			rm -rf /tmp/wlan_cal
			uboot_env --set --name ethaddr --value "$NOW_MAC" && echo "Update successfully" || echo "Update failed"
		}
	} || {
		echo "MAC=$1" > mac
		touch cal_wlan0.bin
		tar cf datab.gz cal_wlan0.bin mac
		nandwrite -e -p "$MAC_MTD" datab.gz || {
			echo "Failed to write datab.gz back into $MAC_MTD"
			cd /tmp
			rm -rf /tmp/wlan_cal
			exit
		}
		cd /tmp
		rm -rf /tmp/wlan_cal
		uboot_env --set --name ethaddr --value "$NOW_MAC" && echo "Update successfully" || echo "Update failed"
	}
	TMP_file="/tmp/tmp.$$"
	cp /tmp/mac $TMP_file
	sed '/MAC/d' /tmp/mac > $TMP_file
	echo "MAC=$NOW_MAC" >> $TMP_file
	mv $TMP_file /tmp/mac
else
	echo "Usage: update_mac.sh 00:11:22:33:44:55"
fi
