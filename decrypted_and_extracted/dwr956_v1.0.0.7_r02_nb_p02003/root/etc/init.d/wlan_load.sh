#!/bin/sh /etc/rc.common
START=80
start() {
# prevent the null cal_wlan0.bin
        if [ -f /tmp/cal_wlan0.bin ]; then
            echo "extract from mtdblock3" > /tmp/cal_source
        else
            cp /root/mtlk/cal/cal_wlan0.bin /tmp/cal_wlan0.bin
            echo "no eeprom found, copy default cal Data" > /tmp/cal_source
        fi
# protect the WIFI initial flow
	echo 1 > /tmp/wifisetting

	if [ "$CONFIG_FEATURE_ATHEROS_WLAN_TYPE_USB" != "1" ]; then
		if [ "$CONFIG_FEATURE_IFX_WIRELESS" = "1" ]; then
      /etc/rc.d/wlan_discover
			if [ "$CONFIG_TARGET_LTQCPE_PLATFORM_AR10" = "1" ]; then
				/etc/rc.d/rc.bringup_wlan init
			fi
		fi
	fi
}

stop() {
	if [ "$CONFIG_FEATURE_ATHEROS_WLAN_TYPE_USB" != "1" ]; then
	    if [ "$CONFIG_FEATURE_IFX_WIRELESS" = "1" ]; then
			if [ "$CONFIG_TARGET_LTQCPE_PLATFORM_AR10" = "1" ]; then
				/etc/rc.d/rc.bringup_wlan uninit
			fi
		fi
	fi
}
