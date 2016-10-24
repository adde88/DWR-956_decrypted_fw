#!/bin/sh
COMMAND=$1
IFACE=$2
WLANSEC=""
LED_IF=""
Debug=`cat /tmp/wifiDebug`
[ "$Debug" != "" ] && echo "Debug mode on"

led_trigger_setting()
{
    [ "$Debug" != "" ] && echo " led trigger IFACE=$1"
    # LED sys path
    if [ "$IFACE" == "ath0" -o "$IFACE" == "ath1" ]; then
        LED_FS=WIFI_5G_ON
        iwpriv $IFACE enable_ol_stats 1
        iwpriv wifi0 enable_ol_stats 1
    else 
        LED_FS=WIFI_2G_ON
    fi 
    [ "$Debug" != "" ] && echo "LED_FS=$LED_FS"
    
    # setting the LED interface
    if [ "$IFACE" == "wlan0" -o "$IFACE" == "ath0" ]; then
      LED_IF=$IFACE
    else
        if [ "$IFACE" == "wlan0.0" ]; then
            WLANEn=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select wlanEnabled from wifiAP where wlanName = 'ap1';"`
        fi

        if [ "$IFACE" == "ath1" ]; then
            WLANEn=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select wlanEnabled from wifiAP where wlanName = 'ap3';"`
        fi

        if [ "$WLANEn" != "1" ]; then
            LED_IF=$IFACE
	fi
    fi

    [ "$Debug" != "" ] && echo "LED_IF=$LED_IF"

    if [ "$LED_IF" != "" ]; then
        [ "$Debug" != "" ] && echo "setting LED to $LED_IF ,$LED_FS"
            echo 1 > /sys/devices/virtual/leds/$LED_FS/brightness
            echo netdev > /sys/devices/virtual/leds/$LED_FS/trigger
            echo $LED_IF  > /sys/devices/virtual/leds/$LED_FS/device_name
            echo "link tx" > /sys/devices/virtual/leds/$LED_FS/mode
            echo 125 > /sys/devices/virtual/leds/$LED_FS/interval
    fi
}


lookup_iface_params()
{

    [ "$Debug" != "" ] && echo " look up IFACE=$1"

    if [ "$1" == "wlan0" ]; then	
        HOSTAPD_CONF="/tmp/hostapd_1.conf"
	HOSTAPD_EXE="hostapd"
        DB_PROFILE="wlan1"
	DB_WLANNAME="ap1"
    elif [ "$1" == "wlan0.0" ]; then
        HOSTAPD_CONF="/tmp/hostapd_2.conf"
	HOSTAPD_EXE="hostapd"
        DB_PROFILE="wlan2"
	DB_WLANNAME="ap2"
    elif [ "$1" == "ath0" ]; then
        HOSTAPD_CONF="/tmp/hostapd_ac.conf"
	HOSTAPD_EXE="hostapd_ath"
        DB_PROFILE="wlan3"
	DB_WLANNAME="ap3"
    elif [ "$1" == "ath1" ]; then
        HOSTAPD_CONF="/tmp/hostapd_ac_2.conf"
	HOSTAPD_EXE="hostapd_ath"
        DB_PROFILE="wlan4"
	DB_WLANNAME="ap4"
    fi

    [ "$Debug" != "" ] && echo "HOSTAPD_CONF=$HOSTAPD_CONF"
    [ "$Debug" != "" ] && echo "HOSTAPD_EXE=$HOSTAPD_EXE"
    [ "$Debug" != "" ] && echo "DB_PROFILE=$DB_PROFILE"
    [ "$Debug" != "" ] && echo "DB_WLANNAME=$DB_WLANNAME"
    
}

wifi_schedule_enable_ap()
{
    [ "$Debug" != "" ] && echo "WIFI Schedule enable AP:$IFACE"
    # look up the parameters
    lookup_iface_params $IFACE
    WLANSEC=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select security from wifiProfile where profileName = '$DB_PROFILE';"`
    [ "$Debug" != "" ] && echo "WLANSEC=$WLANSEC"

    # write to runtime database for dhcpd_br1Init
    sqlite3 /tmp/system.db "update wifiAP set wlanEnabled='1' where wlanName = '$DB_WLANNAME'"
    # enable for SSID2 and SSID4 
    if [ "$IFACE" == "wlan0.0" -o "$IFACE" == "ath1" ]; then
        /usr/local/bin/dhcpd_br1Init start
        [ "$Debug" != "" ] && echo "enable $IFACE bridge control"
    fi

    # setting the LED trigger
    led_trigger_setting $IFACE

    if [ "$WLANSEC" == "WEP" ]; then
        WLANWEPKEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select wepkey0 from wifiProfile where profileName = '$DB_PROFILE';"`
        iwconfig $IFACE key off
	iwconfig $IFACE key open
        WEPLEN=${#WLANWEPKEY}
        if [ "$WEPLEN" = "5" -o "$WEPLEN" = "13" ]; then
            # this is ascii lenght
            iwconfig $IFACE key [1] s:${WLANWEPKEY}
        else
            # the is hex lenght
            iwconfig $IFACE key [1] ${WLANWEPKEY}
        fi
        [ "$Debug" != "" ] && echo "WLANWEPKEY=$WLANWEPKEY"
        [ "$Debug" != "" ] && echo "WEPLEN=$WEPLEN"
        # Force using the key index 1
	iwconfig $IFACE key [1]
        ifconfig $IFACE up
    else 
	# execute the hostapd anyway.
	$HOSTAPD_EXE $HOSTAPD_CONF &
	if [ "$WLANSEC" == "OPEN" ]; then
        	[ "$Debug" != "" ] && echo "open mode"
		if [ "$IFACE" == "ath0" -o "$IFACE" == "ath1" ]; then
        	[ "$Debug" != "" ] && echo "athx open mode"
			sleep 2 
			iwpriv $IFACE authmode 1
			iwconfig $IFACE key off
		fi
	fi
    fi
    # write back to database
    # sqlite3 /tmp/system.db "update wifiAP set wlanEnabled='1' where wlanName = '$DB_WLANNAME'"
    # Save to ASCII
    /usr/local/bin/export_db -a /tmp/system.db /sysconfig/jnr-cfg.ascii
}

wifi_schedule_disable_ap()
{
    [ "$Debug" != "" ] && echo "WIFI Schedule disable AP:$IFACE"
    #look up the parameters 
    lookup_iface_params $IFACE
    
    # write to runtim database for dhcpd_br1Init
    sqlite3 /tmp/system.db "update wifiAP set wlanEnabled='0' where wlanName = '$DB_WLANNAME'"
 
    if [ "$IFACE" == "wlan0.0" -o "$IFACE" == "ath1" ]; then
        /usr/local/bin/dhcpd_br1Init stop
        [ "$Debug" != "" ] && echo "disable $IFACE bridge control"
    fi

    # kill the hostapd daemon
    HOSTAPDLIST=`ps | grep $HOSTAPD_CONF | cut -b 1-5`
    if [ "${HOSTAPDLIST}" != "" ]; then
        for i in $HOSTAPDLIST ; do
            [ "$Debug" != "" ] && echo "killing $i hostapd"
            kill $i
        done
    fi
    # disable the interface
    ifconfig $IFACE down
    # write back to database
    #sqlite3 /tmp/system.db "update wifiAP set wlanEnabled='0' where wlanName = '$DB_WLANNAME'"
    # Save to ASCII
    /usr/local/bin/export_db -a /tmp/system.db /sysconfig/jnr-cfg.ascii
}

[ "$Debug" != "" ] && echo "COMMAND=$COMMAND"
[ "$Debug" != "" ] && echo "IFACE=$IFACE"

case $COMMAND in
        enable)
                wifi_schedule_enable_ap
        ;;
        disable)
                wifi_schedule_disable_ap
        ;;
esac

