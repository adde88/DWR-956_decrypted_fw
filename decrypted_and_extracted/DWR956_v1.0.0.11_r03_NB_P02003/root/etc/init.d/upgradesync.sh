#!/bin/sh /etc/rc.common

STOP=01
if [ ! "$CONFIGLOADED" ]; then
	if [ -r /etc/rc.d/config.sh ]; then
		sync
		. /etc/rc.d/config.sh 2>/dev/null
		CONFIGLOADED="1"
	fi
fi

stop ()
{

	touch /tmp/upgrade_chk.txt
	sync;
	while : ; do
		grep -q "(upgrade)" /proc/*/stat && {
			sleep 3;
			echo -en "\n ####################################\n"
			echo -en "\n Hold until upgrade process completes\n"
			echo -en "\n ####################################\n"
		} || break
	done
	 if [ -n "$CONFIG_UBOOT_CONFIG_BOOT_FROM_SPI" ]; then
	        if [ -f "/tmp/devm_reboot_chk.txt" ] ; then
                       sleep 120;
                fi
                syscfg_lock /flash/rc.conf '
                        echo "Reboot in progress..."
                        sync; sleep 5; sync; reboot -f;
                '
        fi
}

