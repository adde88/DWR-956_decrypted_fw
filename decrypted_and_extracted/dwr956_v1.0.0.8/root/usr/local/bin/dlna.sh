#!/bin/sh

USHARE_PID=`pidof ushare`
if [ -n "$USHARE_PID" ]; then
killall ushare
fi

ENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select enable from dlnaConfig;"`;
logger -t [DLNA] -p local4.info "dlnaConfig enable=$ENABLE"
`echo $ENABLE > /tmp/dlnaStatus`

umount_usb_storage(){
	echo "umount mdm_mass_storage"
	mount_pt=/mnt/usb
	# umount mdm_mass_storage	
	umount -f /tmp/mdm_mass_storage/
	
	# umount all plug-in usb storage 
	umount_dir=`ls -al $mount_pt/ | awk 'NR==4' | awk '{print $9}'`
	if [ "_$umount_dir" != "_" ]; then
		subdir=`ls -al $mount_pt/$umount_dir/ | awk 'NR==3' | awk '{print $9}'`
		echo "umount $mount_pt/$umount_dir/$subdir/"
		umount -f $mount_pt/$umount_dir/$subdir/
	fi
	

#	while [ "_$umount_dir" != "_" ]
#	do
#		subdir=`ls -al $mount_pt/$umount_dir/ | awk 'NR==3' | awk '{print $9}'`
#		while [ "_$subdir" != "_" ]
#		do			
#			echo "umount usb storage : $umount_dir/$subdir/"
 #               	umount -f $mount_pt/$umount_dir/$subdir/
#			sleep 3
#			subdir=`ls -al $mount_pt/$umount_dir/ | awk 'NR==3' | awk '{print $9}'`
#		done
#		umount_dir=`ls -al $mount_pt/ | awk 'NR==4' | awk '{print $9}'`
#	done
	echo "Umount all usb storage : FINISH!"
}

#mount_mdm_mass_storage(){
#	echo "mount mdm_mass_storage"
#	# for TR069 mdm fw upgrade usage
#	mount -t vfat /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 /tmp/mdm_mass_storage/
#}

if [ "$ENABLE" = "0" ]; then
logger -t [DLNA] -p local4.info "switch usb driver to NetUSB.ko"
killall -9 mountd
umount_usb_storage
umount -f /mnt/usb/.run/mountd/
umount -f /tmp/mdm_mass_storage/
sleep 1
rmmod usb-storage
insmod /lib/modules/2.6.32.42/GPL_NetUSB.ko
insmod /lib/modules/2.6.32.42/NetUSB.ko kcReadConfigFile=/usr/local/etc/VID_PID_LIST.dat
insmod /lib/modules/2.6.32.42/usb-storage.ko
sleep 2
/sbin/mountd &
sleep 6
mount -t vfat /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 /tmp/mdm_mass_storage/

logger -t [DLNA] -p local4.info dlna stop
fi

if [ "$ENABLE" = "1" ]; then
logger -t [DLNA] -p local4.info "switch usb driver to usb-storage.ko"
killall -9 mountd
umount_usb_storage
umount -f /mnt/usb/.run/mountd/
umount -f /tmp/mdm_mass_storage/
sleep 1
rmmod usb-storage
rmmod NetUSB
rmmod GPL_NetUSB
insmod /lib/modules/2.6.32.42/usb-storage.ko
sleep 2
/sbin/mountd &
sleep 6
mount -t vfat /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 /tmp/mdm_mass_storage/

`ushare -f /etc/ushare.conf -D`
logger -t [DLNA] -p local4.info dlna start
fi
