#!/bin/sh

USHARE_PID=`pidof ushare`

if [ -n "$USHARE_PID" ]; then
killall ushare
fi

ENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select enable from dlnaConfig;"`;


umount_usb_storage(){
	echo "umount mdm_mass_storage"
	mount_pt=/mnt/usb
	# umount mdm_mass_storage
	test -e /tmp/mdm_mass_storage && echo "mdm_storage exist" || echo "mdm_storage NOT exist!"
	umount -f /tmp/mdm_mass_storage/
	# umount all plug-in usb storage
	umount_dir=`ls -al $mount_pt/ | awk 'NR==4' | awk '{print $9}'`
	if [ "_$umount_dir" != "_" ]; then
		subdir=`ls -al $mount_pt/$umount_dir/ | awk 'NR==3' | awk '{print $9}'`
		echo "umount $mount_pt/$umount_dir/$subdir/"
		umount -f $mount_pt/$umount_dir/$subdir/
	fi
}


if [ "$ENABLE" = "0" ]; then
logger -t [DLNA] -p local4.info "Init:switch usb driver to NetUSB.ko"
umount_usb_storage
rmmod usb-storage
insmod /lib/modules/2.6.32.42/GPL_NetUSB.ko
insmod /lib/modules/2.6.32.42/NetUSB.ko kcReadConfigFile=/usr/local/etc/VID_PID_LIST.dat
insmod /lib/modules/2.6.32.42/usb-storage.ko
sleep 7
mount -t vfat /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 /tmp/mdm_mass_storage/
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
