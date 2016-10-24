# /bin/sh
op=$1
sleep 60
if [ $op -eq 1 ]; then
	REPORTDIR=/tmp/modem_fw/LOG
	progress=`cat $REPORTDIR/module_upgrade_process`
	echo "@@@ check progress=[$progress]"

	if [ $progress -lt 2 ]; then
		if [ -e "$REPORTDIR"/module_upgrade_error ]; then
			echo "@@@ module_upgrade_error exist! @@@"
			exit 0
		else
			echo "@@@ Reset module to download again! @@@"
			echo 1 > /sys/devices/virtual/leds/LTE_RST/brightness
			sleep 1
			echo 0 > /sys/devices/virtual/leds/LTE_RST/brightness
		fi
	fi
elif [ $op -eq 2 ]; then
	qcn=`ps | grep lte_restore_qcn | awk '{print $7}'`
	if [ $qcn = "/tmp/modem_fw/SCAQDB" ]; then
		echo "@@@ Reset module to reboot device. @@@"
		echo 1 > /sys/devices/virtual/leds/LTE_RST/brightness
		sleep 5
		echo 0 > /sys/devices/virtual/leds/LTE_RST/brightness
		sleep 1
	else
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		echo "@@@ lte_restore_qcn process NOT exist!!! @@@"
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	fi
else
	echo "Unknow parameter, exit!!"
	exit 0
fi
echo "@@@ upgrade_check FINISH!! @@@"

