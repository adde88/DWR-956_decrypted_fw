#!/bin/sh

#/etc/rc.d/invoke_upgrade.sh image image_type expand saveenv reboot &

# Added ap fw encrypted
mv -f $1 /tmp/og4610_fw.img
cd /tmp && ./ap_fw_upgrade.sh og4610_fw.img

CheckResult=`cat /tmp/ap_fw_check`
if [ "_$CheckResult" = "_1" ]; then
	echo "FW check failed! Abort!"
	exit
fi

UpgradeTarget=`cat /tmp/ap_fw_target`
if [ "_$UpgradeTarget" = "_1" ]; then
	echo "@@@ cpt fw"
	UpgradePara="/tmp/fullimage.img fullimage 1 saveenv reboot"
else
	echo "@@@ img fw"
	UpgradePara="/tmp/og4610_fw.img fullimage 1 saveenv reboot"
fi

if [ "_$7" = "_webui" ]; then
CheckWebui=`cat /tmp/ap_fw_webui`
while [ "_$CheckWebui" = "_255" ]
do
        sleep 1
        CheckWebui=`cat /tmp/ap_fw_webui`
done
fi

echo "@@@ UpgradePara=[$UpgradePara] @@@"
if [ "$5" = "reboot" ]; then
	. /etc/rc.d/free_memory.sh
	killall br2684ctld >&- 2>&-
	killall syslogd >&- 2>&-
fi

#echo "stop lte daemon..."
#if [ -e /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 ]; then
#  umount -f /tmp/mdm_mass_storage/
#fi
count=`pidof lte_daemon | wc -w`
if [ $count -ne 0 ]; then
  lte_set -O 0x03
fi

echo "timer" > /sys/devices/virtual/leds/power/trigger
echo "timer" > /sys/devices/virtual/leds/power_error/trigger
echo 500 > /sys/devices/virtual/leds/power/delay_on
echo 500 > /sys/devices/virtual/leds/power/delay_off
echo 500 > /sys/devices/virtual/leds/power_error/delay_on
echo 500 > /sys/devices/virtual/leds/power_error/delay_off

cd /mnt/data/ && {
#	upgrade $@ &
	upgrade $UpgradePara &
	sed -i 's/^config.patch = .*/config.patch = \"true\"/g' /sysconfig/jnr-cfg.ascii
}

