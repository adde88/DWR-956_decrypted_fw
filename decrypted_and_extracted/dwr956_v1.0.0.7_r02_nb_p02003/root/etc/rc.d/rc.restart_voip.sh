#!/bin/sh
killall -9 ifxsip

if [ ! "$CONFIGLOADED" ]; then
	if [ -r /etc/rc.d/config.sh ]; then
		. /etc/rc.d/config.sh 2>/dev/null
		CONFIGLOADED="1"
	fi
fi

if [ ! "$ENVLOADED" ]; then
	if [ -r /etc/rc.conf ]; then
		. /etc/rc.conf 2> /dev/null
    ENVLOADED="1"
	fi
fi
. /etc/rc.d/get_wan_if $SIP_IF
export WAN=$WAN_IFNAME
echo "Restart_VoIP on WANIf $WAN"
if [ -n "$CONFIG_TARGET_LTQCPE_PLATFORM_DANUBE" -a "$CONFIG_TARGET_LTQCPE_PLATFORM_DANUBE" = "1" ]; then
	echo DECT_ISDN_FXS_RESET > /sys/class/leds/dect_isdn_fxs_reset/trigger
fi
/usr/sbin/ifxsip &
