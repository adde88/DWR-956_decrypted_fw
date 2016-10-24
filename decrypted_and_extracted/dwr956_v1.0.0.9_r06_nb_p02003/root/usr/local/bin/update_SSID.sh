#!/bin/sh
#sed -i 's/ugly/beautiful/g' /home/bruno/old-friends/sue.txt
if [ -n "$1" ] ; then
	MAC_MTD=/dev/mtd3

	mkdir -p /tmp/wlan_cal
	cd /tmp/wlan_cal
	nanddump -f datab.gz "$MAC_MTD"
	tar xf datab.gz
	SSID=`cat mac |grep "SSID="|cut -d= -f2`
	HAS_SSID_ID=`cat mac | grep "SSID="`
	#echo now SSID $SSID now 1 $1
	if [ -n "$SSID" ]; then
		#echo "now edit"
		sed -i 's/'"$SSID"'/'"$1"'/g' mac
	else
		if [ -n "$HAS_SSID_ID" ]; then
			sed -i 's/'"SSID=$SSID"'/'"SSID=$1"'/g' mac
		else
			echo "SSID=$1" >> mac
		fi
	fi
	tar cf datab.gz cal_wlan0.bin mac
	cat mac | grep "SSID="
	nandwrite -e -p "$MAC_MTD" datab.gz
	cd /tmp
	rm -rf /tmp/wlan_cal
else
	echo "Usage: update_SSID.sh 00000001"
fi
