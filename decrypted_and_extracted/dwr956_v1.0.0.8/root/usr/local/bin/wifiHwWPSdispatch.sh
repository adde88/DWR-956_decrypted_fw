#!/bin/sh

echo "WPS control dispatcher...." >> /tmp/wps_debug

LED_STATUS=`cat /tmp/wps_state`
LED_STATUS_AC=`cat /tmp/wps_state_ac`

if [ "$LED_STATUS" == "" ]; then
LED_STATUS=0
echo "no 11n wps status found" >> /tmp/wps_debug
fi

if [ "$LED_STATUS_AC" == "" ]; then
LED_STATUS_AC=0
echo "no 11ac wps status found" >> /tmp/wps_debug
fi

if [ "$LED_STATUS" != "0" -o "$LED_STATUS_AC" != "0" ]; then
	echo "WPS in active" >> /tmp/wps_debug
	exit 0
fi

WLANWPSEn_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnabled from wifiAP where wlanName = 'ap1';"`
WLANWPSEn_ac=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnabled from wifiAP where wlanName = 'ap3';"`


#echo "WIFItoSet=$WIFItoSet"

if [ "$WLANWPSEn_1" == "1" ]; then
	echo "run 11n setting" >> /tmp/wps_debug
	[ -e /usr/local/bin/wifiHwPBC.sh ]  && /usr/local/bin/wifiHwPBC.sh
	exit 0 
elif [ "$WLANWPSEn_ac" == "1" ]; then
	echo "run 11ac setting" >> /tmp/wps_debug 
	[ -e /usr/local/bin/wifiACHwPBC.sh ]  && /usr/local/bin/wifiACHwPBC.sh
	exit 0
fi
