#!/bin/sh

echo "WPS testing....."
WLANWPSEn_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnabled from wifiAP where wlanName = 'ap3';"`
WLANIf_1="ath0"
WLANWPSIf=""

if [ "$WLANWPSEn_1" = "1" ]; then
        WLANWPSIf=$WLANIf_1
#elif [ "$WLANWPSEn_2" = "1" ]; then
#        WLANWPSIf=$WLANIf_2
else
        WLANWPSIf=""
fi
	echo "WLANWPSIf=$WLANWPSIf"

if [ "$WLANWPSIf" != "" ]; then
# --PBC,EnPIN,APPIN
WLANWPSMethod=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSmethod from wifiWPS where profileName = 'wlan3';"`
WLANWPSEnrollee=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select WPSEnrollPIN from wifiWPS where profileName = 'wlan3';"`
        if [ "$WLANWPSMethod" == "PBC" ]; then
                hostapd_cli_ath -i $WLANWPSIf wps_pbc
        elif [ "$WLANWPSMethod" == "EnPIN" -a "$WLANWPSEnrollee" != "" ]; then
                hostapd_cli_ath -i $WLANWPSIf wps_pin any $WLANWPSEnrollee 120
        	#echo 2 > /proc/wps_led/wps_led_state
	else 
	    # dont setting the WPS
	    echo "Illegal WPS setting"
	    exit 0
	fi
	# hostapd_ath cant edit now... , control the LED by script.
	echo 2 > /proc/wps_led/wps_led_state
        echo "WLANWPSMethod=$WLANWPSMethod"
        echo "WLANWPSEnrollee=$WLANWPSEnrollee"
	echo "WLANWPSIf=$WLANWPSIf"
	echo 1 > /tmp/wps_state_ac
	sleep 120
	echo 0 > /tmp/wps_state_ac
	echo "turn off the LED manually."
	echo 0 > /proc/wps_led/wps_led_state
fi


