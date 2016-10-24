#!/bin/sh

if [ -n "$1" ] ; then

	WLAN_CAL_MTD=/dev/mtdblock3
	mkdir -p /tmp/wlan_cal
	tar xf "$WLAN_CAL_MTD" -C /tmp/wlan_cal && {
		cp $1 /tmp/wlan_cal/cal_wlan0.bin && cd /tmp/wlan_cal && tar cf datab.gz cal_wlan0.bin mac && dd if=datab.gz of="$WLAN_CAL_MTD" && rm -rf /tmp/wlan_cal && echo "Update successfully" || echo "Update failed"
	} || {
		cp $1 /tmp/wlan_cal/cal_wlan0.bin && cd /tmp/wlan_cal && touch mac && tar cf datab.gz cal_wlan0.bin mac && dd if=datab.gz of="$WLAN_CAL_MTD" && rm -rf /tmp/wlan_cal && echo "Update successfully" || echo "Update failed"		
	}
else
	echo "Usage: update_wlan_cal.sh [wlan_cal_file]"
fi
