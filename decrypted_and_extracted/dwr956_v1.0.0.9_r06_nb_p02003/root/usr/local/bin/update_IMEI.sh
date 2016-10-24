#!/bin/sh
#sed -i 's/ugly/beautiful/g' /home/bruno/old-friends/sue.txt
if [ -n "$1" ] ; then
	MAC_MTD=/dev/mtd3

	mkdir -p /tmp/wlan_cal
	cd /tmp/wlan_cal
	nanddump -f datab.gz "$MAC_MTD"
	tar xf datab.gz
	IMEI=`cat mac |grep "IMEI="|cut -d= -f2`
	HAS_IMEI_ID=`cat mac | grep "IMEI="`
	#echo now IMEI $IMEI now 1 $1
	if [ -n "$IMEI" ]; then
		#echo "now edit"
		sed -i 's/'"$IMEI"'/'"$1"'/g' mac
	else
		if [ -n "$HAS_IMEI_ID" ]; then
			sed -i 's/'"IMEI=$IMEI"'/'"IMEI=$1"'/g' mac
		else
			echo "IMEI=$1" >> mac
		fi
	fi
	tar cf datab.gz cal_wlan0.bin mac
	cat mac | grep "IMEI="
	nandwrite -e -p "$MAC_MTD" datab.gz        
	cd /tmp
	rm -rf /tmp/wlan_cal
else
	echo "Usage: update_IMEI.sh 00000001"
fi
