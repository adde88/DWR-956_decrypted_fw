#!/bin/sh
#sed -i 's/ugly/beautiful/g' /home/bruno/old-friends/sue.txt
if [ -n "$1" ] ; then
        MAC_MTD=/dev/mtdblock3

        mkdir -p /tmp/wlan_cal
        tar xf "$MAC_MTD" -C /tmp/wlan_cal
        cd /tmp/wlan_cal
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
        dd if=datab.gz of="$MAC_MTD"
        cd /tmp
        rm -rf /tmp/wlan_cal
else
        echo "Usage: update_SN.sh 00000001"
fi
