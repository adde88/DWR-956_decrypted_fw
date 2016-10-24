#! /bin/sh

counter=0
test_num=$1
pass=0
fail=0

if [ -z $test_num ]; then 
	echo "Please enter test round nmuber."
	echo "[Usage] ModuleResetTest.sh [NUM]"
	exit 0
fi


echo "killall tr69d"
killall tr69d
echo "killall lte_watchdog"
killall lte_watchdog
echo "killall lte_daemon"
killall lte_daemon
echo "killall ifxsip 3 times"
killall ifxsip
killall ifxsip
killall ifxsip
echo "ifconfig usb0 down"
ifconfig usb0 down
echo "ifconfig usb1 down"
ifconfig usb1 down
echo "ifconfig usb2 down"
ifconfig usb2 down


test -e /tmp/module_reset_test_report && rm -f /tmp/module_reset_test_report
echo "@@@@@ TEST START @@@@@"
echo "@@@@@ TEST START @@@@@" >> /tmp/module_reset_test_report
test_start_time=`date`

while [ $counter -lt $test_num ]; do
	temp_time=`date`
	counter=$(($counter+1))
	echo "Round $counter start at $temp_time" >> /tmp/module_reset_test_report

	lte_set -O 0x03
	
	sleep 3
	
	echo 1 > /sys/devices/virtual/leds/LTE_RST/brightness

	while [ -e "/dev/qcqmi0" ]; do
	sleep 1
	done

	sleep 1

	echo 0 > /sys/devices/virtual/leds/LTE_RST/brightness

	sleep 300

	if [ -e /dev/qcqmi0 ]; then		
		echo "qcqmi0 exist!" >> /tmp/module_reset_test_report
		echo "qcqmi0 exist!"
#		mdmID=`lte_get -D 0 | sed 's/......$//'`
#		if [ "$mdmID" = "CLIENT:ModelID" ]; then
#			echo "Get mdm ID OK!" >> /tmp/module_reset_test_report
#			echo "Get mdm ID OK!"
			pass=$(($pass+1))
			echo "Test Pass ($pass/$test_num)" >> /tmp/module_reset_test_report
			echo "Test Pass ($pass/$test_num)"
#		else
#			echo "Get mdm ID FAILED!" >> /tmp/module_reset_test_report
#			echo "Get mdm ID FAILED!"
#			fail=$(($fail+1))
#			echo "Test Failed ($fail/$test_num)" >> /tmp/module_reset_test_report
#			echo "Test Failed ($fail/$test_num)"
#		fi
	else
		echo "qcqmi0 NOT exist!" >> /tmp/module_reset_test_report
		echo "qcqmi0 NOT exist!"
		fail=$(($fail+1))
		echo "Test Failed ($fail/$test_num)" >> /tmp/module_reset_test_report
		echo "Test Failed ($fail/$test_num)"
	fi
done

test_end_time=`date`

echo "@@@@@ TEST END @@@@@" >> /tmp/module_reset_test_report
echo "========== Test Result START ==========" >> /tmp/module_reset_test_report
echo "Test Start at $test_start_time" >> /tmp/module_reset_test_report
echo "Test End at $test_end_time" >> /tmp/module_reset_test_report
echo "Total test number : $test_num" >> /tmp/module_reset_test_report
echo "Test Pass : $pass time(s)" >> /tmp/module_reset_test_report
echo "Test Failed : $fail time(s)" >> /tmp/module_reset_test_report
echo "==========  Test Result END  ==========" >> /tmp/module_reset_test_report

echo "@@@@@ TEST END @@@@@"
echo "========== Test Result START =========="
echo "Test Start at $test_start_time"
echo "Test End at $test_end_time"
echo "Total test number : $test_num"
echo "Test Pass : $pass time(s)"
echo "Test Failed : $fail time(s)"
echo "==========  Test Result END  =========="
