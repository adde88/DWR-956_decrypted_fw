#!/bin/sh
if [ -n "$1" ] ; then
	WLAN_CAL_MTD=/dev/mtd3

	mkdir -p /tmp/wlan_cal
	cd /tmp/wlan_cal
	nanddump -f datab.gz "$WLAN_CAL_MTD"
	tar -xf datab.gz && { 
		cp $1 /tmp/wlan_cal/cal_wlan0.bin
		tar -cf datab.gz cal_wlan0.bin mac && {
			nandwrite -e -p "$WLAN_CAL_MTD" datab.gz || {
				echo "Failed to write datab.gz back into $WLAN_CAL_MTD"
				cd /tmp
				rm -rf /tmp/wlan_cal
				exit
			}
			cd /tmp
			rm -rf /tmp/wlan_cal
			echo "Update successfully"
		} || {
			touch mac
			tar -cf datab.gz cal_wlan0.bin mac
			nandwrite -e -p "$WLAN_CAL_MTD" datab.gz || {
				echo "Failed to write datab.gz back into $WLAN_CAL_MTD"
				cd /tmp
				rm -rf /tmp/wlan_cal
				exit
			}
			cd /tmp
			rm -rf /tmp/wlan_cal
			echo "Update successfully"
		}
	} || {
		touch mac
		cp $1 /tmp/wlan_cal/cal_wlan0.bin
		tar -cf datab.gz cal_wlan0.bin mac
		nandwrite -e -p "$WLAN_CAL_MTD" datab.gz || {
			echo "Failed to write datab.gz back into $WLAN_CAL_MTD"
			cd /tmp
			rm -rf /tmp/wlan_cal
			exit
		}
		cd /tmp
		rm -rf /tmp/wlan_cal
		echo "Update successfully"
	}

else
	echo "Usage: update_wlan_cal.sh [wlan_cal_file]"
fi
