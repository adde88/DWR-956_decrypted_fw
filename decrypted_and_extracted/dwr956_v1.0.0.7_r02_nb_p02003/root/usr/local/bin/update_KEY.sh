#!/bin/sh
#sed -i 's/ugly/beautiful/g' /home/bruno/old-friends/sue.txt
if [ -n "$1" ] ; then
        MAC_MTD=/dev/mtdblock3

        mkdir -p /tmp/wlan_cal
        tar xf "$MAC_MTD" -C /tmp/wlan_cal
        cd /tmp/wlan_cal
	KEY=`cat mac |grep "KEY="|cut -d= -f2`
	HAS_KEY_ID=`cat mac | grep "KEY="`
	#echo now KEY $KEY now 1 $1
	if [ -n "$KEY" ]; then
		#echo "now edit"
		sed -i 's/'"$KEY"'/'"$1"'/g' mac
	else
        	if [ -n "$HAS_KEY_ID" ]; then
                	sed -i 's/'"KEY=$KEY"'/'"KEY=$1"'/g' mac
        	else
                	echo "KEY=$1" >> mac
        	fi
	fi
        tar cf datab.gz cal_wlan0.bin mac
	cat mac | grep "KEY="
        dd if=datab.gz of="$MAC_MTD"
        cd /tmp
        rm -rf /tmp/wlan_cal
else
        echo "Usage: update_KEY.sh 00000001"
fi
