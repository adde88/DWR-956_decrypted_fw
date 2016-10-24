#!/bin/sh

DEBUG=1
echo "==========================" >> /tmp/wps_debug
echo "HW PBC script for ac enter" >> /tmp/wps_debug
echo "==========================" >> /tmp/wps_debug
echo "test the usermodehelp" >> /tmp/wps_debug
#LED_STATUS=`cat /proc/wps_led/wps_led_state`
LED_STATUS=`cat /tmp/wps_state_ac`

if [ "$DEBUG" == "1" ]; then
	echo "LED_STATUS=$LED_STATUS" >> /tmp/wps_debug
fi

if [ "$LED_STATUS" == "0" ]; then

	WLANWPSEn_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnabled from wifiAP where wlanName = 'ap3';"`
	WLANIf_1="ath0"
	WLANWPSIf=""

	if [ "$WLANWPSEn_1" == "1" ]; then
		echo "Trigger HW PBC" >> /tmp/wps_debug
		hostapd_cli_ath -i ath0 wps_pbc
		# hostapd_ath cant edit now... , control the LED by script.
		echo 2 > /proc/wps_led/wps_led_state
	else 
		echo "WPS ac is not set" >> /tmp/wps_debug
	 	exit 0
	fi

	if [ "$DEBUG" == "1" ]; then
		echo "sleep 120 sec" >> /tmp/wps_debug
	fi
	echo 3 > /tmp/wps_state_ac
	sleep 120

	if [ "$DEBUG" == "1" ]; then
		echo "turn off the WPS LED" >> /tmp/wps_debug
	fi
	echo 0 > /tmp/wps_state_ac
	echo 0 > /proc/wps_led/wps_led_state

else 
     echo "WPS is triggered , skip this event" >> /tmp/wps_debug
fi



