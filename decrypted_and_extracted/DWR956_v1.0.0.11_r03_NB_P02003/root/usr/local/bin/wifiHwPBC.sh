#!/bin/sh

DEBUG=1

echo "test the usermodehelp" >> /tmp/wps_debug
#LED_STATUS=`cat /proc/wps_led/wps_led_state`
LED_STATUS=`cat /tmp/wps_state`

if [ "$DEBUG" == "1" ]; then
	echo "LED_STATUS=$LED_STATUS" >> /tmp/wps_debug
fi

if [ "$LED_STATUS" == "0" ]; then

	WLANWPSEn_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnabled from wifiAP where wlanName = 'ap1';"`
	WLANWPSEn_2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnabled from wifiAP where wlanName = 'ap2';"`
	WLANIf_1="wlan0"
	WLANIf_2="wlan0.0"
	WLANWPSIf=""


# Reserved for VAP2 WPS feature.....
#if [ "$WLANWPSEn_1" = "1" ]; then
#        WLANWPSIf=$WLANIf_1
#elif [ "$WLANWPSEn_2" = "1" ]; then
#        WLANWPSIf=$WLANIf_2
#else
#        WLANWPSIf=""
#fi
#
#if [ "$DEBUG" == "1" ]; then
#	echo "WLANWPSIf=$WLANWPSIf" >> /tmp/wps_debug
#fi
# enable the WPS PBC function.
#hostapd_cli -i $WLANWPSIf wps_pbc
	if [ "$WLANWPSEn_1" == "1" ]; then
		echo "Trigger HW PBC" >> /tmp/wps_debug
		hostapd_cli -i wlan0 wps_pbc
	else
                echo "WPS n is not set" >> /tmp/wps_debug
                exit 0
	fi

	if [ "$DEBUG" == "1" ]; then
		echo "sleep 120 sec" >> /tmp/wps_debug
	fi
	echo 3 > /tmp/wps_state
	sleep 120

	if [ "$DEBUG" == "1" ]; then
		echo "turn off the WPS LED" >> /tmp/wps_debug
	fi
	echo 0 > /tmp/wps_state
	echo 0 > /proc/wps_led/wps_led_state

else 
     echo "WPS is triggered , skip this event" >> /tmp/wps_debug
fi



