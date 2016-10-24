#!/bin/sh
Debug=1
WLANIf_1="wlan0"
WLANIf_2="wlan0.0"
WLANIf_ac="ath0"
WLANSTACnt_f1="/tmp/wlan0_peers"
WLANSTACnt_f2="/tmp/wlan0.0_peers"
WLANSTACnt_f_ac="/tmp/ath0_peers"
WLANSTACnt_1=0
WLANSTACnt_2=0
WLANSTACnt_ac=0
# Access the database
WLANEn_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select wlanEnabled from wifiAP where wlanName = 'ap1';"`
WLANEn_2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select wlanEnabled from wifiAP where wlanName = 'ap2';"`
WLANEn_ac=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select wlanEnabled from wifiAP where wlanName = 'ap3';"`

if [ "$WLANEn_1" != "0" ]; then
	#store the peers list
	iwlist $WLANIf_1 peers > $WLANSTACnt_f1
	#Count the clients
	WLANSTACnt_1=`cat $WLANSTACnt_f1 | sed 1d | grep -c :`
fi

if [ "$WLANEn_2" != "0" ]; then
        #store the peers list
        iwlist $WLANIf_2 peers > $WLANSTACnt_f2
        #Count the clients
        WLANSTACnt_2=`cat $WLANSTACnt_f2 | sed 1d | grep -c :`
fi

if [ "$WLANEn_ac" != "0" ]; then
        #store the peers list
        wlanconfig $WLANIf_ac list sta > $WLANSTACnt_f_ac
        #Count the clients
        WLANSTACnt_ac=`cat $WLANSTACnt_f_ac | sed 1d | grep -c :`
fi

if [ "$Debug" != "0" ]; then
	echo "WLANSTACnt_1=$WLANSTACnt_1"
	echo "WLANSTACnt_2=$WLANSTACnt_2"
	echo "WLANSTACnt_ac=$WLANSTACnt_ac"
fi

#Todo: update the database for WebUI.
sqlite3 -cmd ".timeout 1000" /tmp/system.db "update wifiStatus set peers1='$WLANSTACnt_1' where profileName = 'wlan1'"
sqlite3 -cmd ".timeout 1000" /tmp/system.db "update wifiStatus set peers2='$WLANSTACnt_2' where profileName = 'wlan1'"
sqlite3 -cmd ".timeout 1000" /tmp/system.db "update wifiStatus set peers3='$WLANSTACnt_ac' where profileName = 'wlan1'"

