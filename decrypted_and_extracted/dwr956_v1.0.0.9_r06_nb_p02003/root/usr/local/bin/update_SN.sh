#!/bin/sh
#sed -i 's/ugly/beautiful/g' /home/bruno/old-friends/sue.txt
if [ -n "$1" ] ; then
	MAC_MTD=/dev/mtd3

	mkdir -p /tmp/wlan_cal
	cd /tmp/wlan_cal
	nanddump -f datab.gz "$MAC_MTD"
	tar xf datab.gz
	SN=`cat mac |grep "SN="|cut -d= -f2`
	HAS_SN_ID=`cat mac | grep "SN="`
	#echo now SN $SN now 1 $1
	if [ -n "$SN" ]; then
		#echo "now edit"
		sed -i 's/'"$SN"'/'"$1"'/g' mac
	else
		if [ -n "$HAS_SN_ID" ]; then
			sed -i 's/'"SN=$SN"'/'"SN=$1"'/g' mac
		else
			echo "SN=$1" >> mac
		fi
	fi
	tar cf datab.gz cal_wlan0.bin mac
	cat mac | grep "SN="
	nandwrite -e -p "$MAC_MTD" datab.gz
	cd /tmp
	rm -rf /tmp/wlan_cal
else
	echo "Usage: update_SN.sh 00000001"
fi
