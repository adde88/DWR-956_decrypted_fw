#!/bin/sh

echo "WPS control dispatcher...."

WLANWPSEn_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnabled from wifiAP where wlanName = 'ap1';"`
WLANWPSEn_ac=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnabled from wifiAP where wlanName = 'ap3';"`


#echo "WIFItoSet=$WIFItoSet"

if [ "$WLANWPSEn_1" == "1" ]; then
	echo "run 11n setting"
	[ -e /usr/local/bin/wifiWPS.sh ]  && /usr/local/bin/wifiWPS.sh
	exit 0 
elif [ "$WLANWPSEn_ac" == "1" ]; then
	echo "run 11ac setting"
	[ -e /usr/local/bin/wifiACWPS.sh ]  && /usr/local/bin/wifiACWPS.sh
	exit 0
fi
