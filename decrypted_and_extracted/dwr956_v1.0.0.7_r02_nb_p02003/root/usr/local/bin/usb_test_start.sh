#!/bin/sh

STOP_FLAG=0
test_start=`date`
# echo "Start to run usb_test.sh in the background."
usb_test.sh 99999 &
echo "USB Testing..."
echo "=============================================="
echo "Please press ENTER to stop usb test procedure."
echo "=============================================="



read INPUT

case $INPUT in
*)
	echo "Stop usb test proceduce, please wait..."
	
	while [ $STOP_FLAG -eq 0 ]
	do
		echo "checking..."
		
		read_pass=`cat /ramdisk/tmp/read_pass`
		if [ -z $read_pass ]; then
			echo "read_pass is empty, try again"
			continue
		fi
		
		read_fail=`cat /ramdisk/tmp/read_fail`
		if [ -z $read_fail ]; then
			echo "read_fail is empty, try again"
			continue
		fi
		
		write_pass=`cat /ramdisk/tmp/write_pass`
		if [ -z $write_pass ]; then
			echo "write_pass is empty, try again"
			continue
		fi
		
		write_fail=`cat /ramdisk/tmp/write_fail`
		if [ -z $write_fail ]; then
			echo "write_fail is empty, try again"
			continue
		fi
		
		write_test_count=`cat /ramdisk/tmp/write_test_count`
		if [ -z $write_test_count ]; then
		        echo "write_test_count is empty, try again"
		        continue
		fi

		read_test_count=`cat /ramdisk/tmp/read_test_count`
		if [ -z $read_test_count ]; then
			echo "read_test_count is empty, try again"
		        continue
		fi
		
		pass_cycle=`cat /ramdisk/tmp/pass_cycle`
		if [ -z $pass_cycle ]; then
			echo "pass_cycle is empty, try again"
			continue
		fi
		
		fail_cycle=`cat /ramdisk/tmp/fail_cycle`
		if [ -z $fail_cycle ]; then
			echo "fail_cycle is empty, try again"
			continue
		fi
		

		STOP_FLAG=1

	done
	killall usb_test.sh
	test_end=`date`
	read_unfinish=$(($read_test_count - $read_pass - $read_fail))
	write_unfinish=$(($write_test_count - $write_pass - $write_fail))
	total_cycle=$(($pass_cycle + $fail_cycle))
	
	echo "============== TEST RESULT START =============="
	echo "Start at time : $test_start"
	echo "End at time : $test_end"
	echo "Total Read Test : $read_test_count"	
	echo "Read Pass : $read_pass"
	echo "Read Fail : $read_fail"
	echo "Unfinish Raed Round : $read_unfinish"
	echo "Total Write Test : $write_test_count"
	echo "Write Pass : $write_pass"
	echo "Write Fail : $write_fail"
	echo "Unfinish Write Round : $write_unfinish"
	echo "Total Test Cycle : $total_cycle"
	echo "PASS Cycle : $pass_cycle"
	echo "FAIL Cycle : $fail_cycle"
	echo "Pass Rate : $(($pass_cycle * 100  / $total_cycle ))% ($pass_cycle/$total_cycle)"
	echo "=============== TEST RESULT END ==============="
	echo "============== TEST RESULT START ==============" >> /ramdisk/tmp/usb_test_result
	echo "Start at time : $test_start" >> /ramdisk/tmp/usb_test_result
	echo "End at time : $test_end" >> /ramdisk/tmp/usb_test_result
	echo "Total Read Test : $read_test_count" >> /ramdisk/tmp/usb_test_result
	echo "Read Pass : $read_pass" >> /ramdisk/tmp/usb_test_result
	echo "Read Fail : $read_fail" >> /ramdisk/tmp/usb_test_result
	echo "Unfinish Raed Round : $read_unfinish" >> /ramdisk/tmp/usb_test_result
	echo "Total Write Test : $write_test_count" >> /ramdisk/tmp/usb_test_result
	echo "Write Pass : $write_pass" >> /ramdisk/tmp/usb_test_result
	echo "Write Fail : $write_fail" >> /ramdisk/tmp/usb_test_result
	echo "Unfinish Write Round : $write_unfinish" >> /ramdisk/tmp/usb_test_result
	echo "Total Test Cycle : $total_cycle" >> /ramdisk/tmp/usb_test_result
	echo "PASS Cycle : $pass_cycle" >> /ramdisk/tmp/usb_test_result
	echo "FAIL Cycle : $fail_cycle" >> /ramdisk/tmp/usb_test_result
	echo "Pass Rate : $(($pass_cycle * 100  / $total_cycle ))% ($pass_cycle/$total_cycle)" >> /ramdisk/tmp/usb_test_result
	echo "=============== TEST RESULT END ===============" >> /ramdisk/tmp/usb_test_result
	;;

esac

exit 0

