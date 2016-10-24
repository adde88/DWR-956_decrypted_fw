#!/bin/sh
USHARE_PID=`pidof ushare`
if [ -n "$USHARE_PID" ]; then
killall ushare
fi

ENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select enable from dlnaConfig;"`;

if [ "$ENABLE" = "0" ]; then
logger -t [DLNA] -p local4.info "Init:switch usb driver to NetUSB.ko"
rmmod usb-storage
insmod /lib/modules/2.6.32.42/GPL_NetUSB.ko
insmod /lib/modules/2.6.32.42/NetUSB.ko kcReadConfigFile=/usr/local/etc/VID_PID_LIST.dat
insmod /lib/modules/2.6.32.42/usb-storage.ko
#mount -t vfat /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 /tmp/mdm_mass_storage/
logger -t [DLNA] -p local4.info dlna stop

elif [ "$ENABLE" = "1" ]; then

logger -t [DLNA] -p local4.info "Init:switch usb driver to usb-storage.ko"
rmmod usb-storage
insmod /lib/modules/2.6.32.42/usb-storage.ko
#mount -t vfat /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 /tmp/mdm_mass_storage/

`ushare -f /etc/ushare.conf -D`
logger -t [DLNA] -p local4.info dlna start
fi

`echo $ENABLE > /tmp/dlnaStatus`
