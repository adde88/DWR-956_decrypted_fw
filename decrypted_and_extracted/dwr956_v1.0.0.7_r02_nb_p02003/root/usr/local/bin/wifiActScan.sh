#!/bin/sh

AOCS_enable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select AOCSenable from wifiAOCSstatus where profileName = 'wifiAOCS';"`
AOCS_Debug=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select debugFlag from wifiAOCSstatus where profileName = 'wifiAOCS';"`
WLANIf_1="wlan0"
WLANIf_2="wlan0.0"

if [ "$AOCS_enable" == "1" ]; then
    [ "$AOCS_Debug" != "0" ] && echo "AOCS run"
    #shut down all wifi interface
    ifconfig $WLANIf_1 down
    ifconfig $WLANIf_2 down
    # turn off the WIFI 2.4GHz LED
    echo 0 > /sys/devices/virtual/leds/WIFI_2G_ON/brightness
    killall hostapd
    sleep 1 
# Setting the common driver capability
# setting radio mode
#iwpriv wlan0 sNetworkMode 23
#iwpriv $WLANIf_1 sFortyMHzOpMode 0
# Setting to auto-channel
    iwconfig $WLANIf_1 channel 0

# setting the interface 1
    iwconfig $WLANIf_1 essid active_scan
    iwpriv $WLANIf_1 sHiddenSSID 1
    ifconfig wlan0 up
    sleep 1

#run AOCS to Database 
    /usr/local/bin/wifiAOCS.sh

#shut down all wifi interface
    ifconfig $WLANIf_1 down
fi
