# /bin/sh
getFWUPStatus()
{
	FWUP_STATUS=`lte_get --download-status | grep Status | cut -d '=' -f2 | cut -d ',' -f1`
	while [ -z "$FWUP_STATUS" ]
	do
	    sleep 3
		FWUP_STATUS=`lte_get --download-status`
		echo "$FWUP_STATUS" >> /tmp/mdm_upgrade.tmp	
		if [ "$FWUP_STATUS" = "Error: lte_daemon not running." ]; then
	        return
		else
		    FWUP_STATUS=`echo $FWUP_STATUS | grep Status | cut -d '=' -f2 | cut -d ',' -f1`
		fi
	done
	echo "$FWUP_STATUS" >> /tmp/mdm_upgrade.tmp
}

getFWUPStatus
if [ "$FWUP_STATUS" != -1 ]; then
    if [ "$FWUP_STATUS" != 1 ]; then
	  return
	fi
	if [ -n "$1" ]; then
	  FileName=${1##/*/}
	else
	  FileName=mdm_fw
	fi
	
    lte_set --download $FileName
	sleep 2
	retry=0
	while [ ! -e /tmp/mdm_upgrade_command_start ]
	do
	    retry=$(( $retry + 1 ))
	    sleep 2
        lte_set --download $FileName
    done
	rm /tmp/mdm_upgrade_command_start
	retry=0
	while [ ! -e /tmp/mdm_upgrade_command_end ]
	do
	    retry=$(( $retry + 1 ))
	    sleep 2
	done
	rm /tmp/mdm_upgrade_command_end
	
	upgrade_process=0
	while [ "$upgrade_process" -le 90 ]
	do
	    sleep 5
	    getFWUPStatus
	    if [ "$FWUP_STATUS" != 1 ];then
		  return
		fi
		upgrade_process=$(( $upgrade_process + 5 ))
		echo $upgrade_process > /tmp/modem_fw/LOG/module_upgrade_process
	done
    return
fi

PRODUCT_ID_PATH=/sys/devices/platform/ifxusb_hcd/usb2/2-1/idProduct
D15_PRODUCT_ID=9011
D15_3RMNET_PRODUCT_ID=900f
D16_PRODUCT_ID=9046
DL_MODE_PRODUCT_ID=9008
DL_Count=0
DL_Count_Limit=3
FWDIR=/tmp/modem_fw/SCAQDBZ
REPORTDIR=/tmp/modem_fw/LOG
UPFW_STATE=/tmp/MDM_UPFW_STATE

echo 13 > $UPFW_STATE

echo "========== Check Module ID =========="
PRODUCT_ID=`cat $PRODUCT_ID_PATH`

if [ -e "$REPORTDIR"/module_upgrade_period ] ; then 
	echo "Module is under FW upgrading! Can NOT download again! Exit!"
	exit 0
fi

test -e $REPORTDIR && rm -rf $REPORTDIR
mkdir -p $REPORTDIR

touch $REPORTDIR/module_upgrade_period
echo 1 > $REPORTDIR/module_upgrade_result

if [ $PRODUCT_ID = $D15_PRODUCT_ID ] || [ $PRODUCT_ID = $D15_3RMNET_PRODUCT_ID ]; then
	echo "Modem Module : D15"
	UPGRADE_CMD="lte_upgrade -d $FWDIR -r $REPORTDIR"
elif [ $PRODUCT_ID = $D16_PRODUCT_ID ]; then
	echo "Modem Module : D16"
	UPGRADE_CMD="lte_upgrade -d $FWDIR -r $REPORTDIR -t d16"
elif [ $PRODUCT_ID = $DL_MODE_PRODUCT_ID ]; then
	echo "Module is under download mode!! Default try to download D15 FW"
	UPGRADE_CMD="lte_upgrade -d $FWDIR -r $REPORTDIR"
else
	echo "ERROR!! Unknown Module ID, STOP upgrade process!!"
	rm -f $REPORTDIR/module_upgrade_period
#	echo 0 > /sys/devices/virtual/leds/power/delay_on
#	echo 0 > /sys/devices/virtual/leds/power_error/delay_on
#	echo 0 > /sys/devices/virtual/leds/power_error/brightness
#	echo 1 > /sys/devices/virtual/leds/power/brightness
	echo 31 > $UPFW_STATE
	echo 2 > $REPORTDIR/module_upgrade_result
	exit 0
fi

if [ -e "$FWDIR"/qcn_update.qcn ]; then
	echo "qcn_update.qcn exist!!!"
	QCN_CMD="lte_restore_qcn -q $FWDIR/qcn_update.qcn -l 0xffff"
fi

echo "========== Blinking power and power_error LEDs =========="
echo "timer" > /sys/devices/virtual/leds/power/trigger
echo "timer" > /sys/devices/virtual/leds/power_error/trigger
echo 500 > /sys/devices/virtual/leds/power/delay_on
echo 500 > /sys/devices/virtual/leds/power_error/delay_on
echo 500 > /sys/devices/virtual/leds/power/delay_off
echo 500 > /sys/devices/virtual/leds/power_error/delay_off

echo "========== Kill Some Processes =========="
sleep 2
echo "killall tr69d"
killall tr69d
echo "killall lte_daemon"
killall lte_daemon
echo "killall lte_watchdog"
killall lte_watchdog
echo "killall ifxsip 3 times"
killall ifxsip
killall ifxsip
killall ifxsip
echo "ifconfig usb0 down"
ifconfig usb0 down
echo "ifconfig usb1 down"
ifconfig usb1 down
if [ $PRODUCT_ID = $D16_PRODUCT_ID ]; then
	echo "ifconfig usb2 down"
	ifconfig usb2 down
fi

echo "========== Modem FW Upgrade START =========="
while [ $DL_Count -lt $DL_Count_Limit ]
do
# Woody 2013-06-04 : add mdm_upgrade_check.sh to avoid upgrade failed
	echo "killall mdm_upgrade_check.sh"
	killall mdm_upgrade_check.sh
	mdm_upgrade_check.sh 1 &

	$UPGRADE_CMD
	if [ -e "$REPORTDIR"/module_upgrade_finish ]; then
		echo 0 > /sys/devices/virtual/leds/power_error/delay_on
		echo 0 > /sys/devices/virtual/leds/power_error/brightness
		echo "MDM FW Upgrade SUCCESS!"
		if [ -e "$FWDIR"/qcn_update.qcn ]; then
			echo "Device will be reboot after qcn updated!"
		else
			echo "Device will be reboot after 10 seconds!"
		fi
		echo 0 > $REPORTDIR/module_upgrade_result
		echo 31 > $UPFW_STATE
		DL_Count=$DL_Count_Limit
		
		if [ -e "$FWDIR"/qcn_update.qcn ]; then
			echo 1 > /sys/devices/virtual/leds/LTE_RST/brightness
			while [ -e "/dev/qcqmi0" ]; do
				echo "qcqmi0 exist, wait one second..."
				sleep 1
			done

			sleep 1
			echo 0 > /sys/devices/virtual/leds/LTE_RST/brightness
			sleep 10

			QCN_STATUS=Error
			
			until [ "$QCN_STATUS" = "Program exit normally." ]
			do
				if [ -e "/dev/qcqmi0" ]; then
					mdm_upgrade_check.sh 2 &
					$QCN_CMD > $REPORTDIR/MDM_QCN_STATUS
					sleep 5
					QCN_STATUS=`cat $REPORTDIR/MDM_QCN_STATUS | grep "Program exit normally."`
					sleep 5
					echo "QCN_STATUS=[$QCN_STATUS]"
					echo "====== MDM qcn update report START ======"
					cat $REPORTDIR/MDM_QCN_STATUS
					echo "====== MDM qcn update report END ======"
				else
					echo "qcqmi0 still not ready, wait one second..."
				fi
				sleep 1
			done
			echo "====== Update QCN FINISH!! ======"
		fi
		
		sleep 10
		reboot
	elif [ -e "$REPORTDIR"/module_upgrade_error ]; then
		DL_Count=$(($DL_Count+1))
		echo "MDM FW Upgrade Fail $DL_Count Time(s)!"
		mode_switch=`cat $REPORTDIR/module_upgrade_error`
		sleep 1
		# test -e $REPORTDIR && rm -rf $REPORTDIR
		# mkdir -p $REPORTDIR
		rm -f $REPORTDIR/module_upgrade_error

		if [ $DL_Count -eq $DL_Count_Limit ]; then
			rm -f $REPORTDIR/module_upgrade_period
			echo 0 > /sys/devices/virtual/leds/power/delay_on
			echo 0 > /sys/devices/virtual/leds/power/brightness
			echo 3 > $REPORTDIR/module_upgrade_result
			echo 31 > $UPFW_STATE
			echo "Upgrade Fail! ABORT!"
		else
			if [ $mode_switch = FF ];then
				echo "Switch to DL mode failed!"
				echo "Reboot MDM then try to redownload again."
				
				rmmod GobiNet
				rmmod GobiSerial
				
				echo 1 > /sys/devices/virtual/leds/LTE_RST/brightness
				while [ -e "/dev/qcqmi0" ]; do
				sleep 1
				done

				sleep 1

				echo 0 > /sys/devices/virtual/leds/LTE_RST/brightness
				sleep 1

				insmod /lib/GobiNet.ko
				insmod /lib/GobiSerial.ko
				sleep 10				
			fi

			echo "Waiting 20 seconds, then try to upgrade fw again."
			sleep 20
		fi		
	fi
done

echo "========== Modem FW Upgrade END =========="
