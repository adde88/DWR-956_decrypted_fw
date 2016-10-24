#!/bin/sh

test_num=$1
test_count=0
read_pass=0
read_fail=0
write_pass=0
write_fail=0
backup_flag=0
pass_cycle=0
fail_cycle=0

if [ -z $test_num ]; then 
	echo "Please enter test round nmuber."
	echo "[Usage] ./usb_test.sh [NUM]"
	exit 0
fi

echo $test_count > /ramdisk/tmp/read_test_count
echo $test_count > /ramdisk/tmp/write_test_count
echo $read_pass > /ramdisk/tmp/read_pass
echo $read_fail > /ramdisk/tmp/read_fail
echo $write_pass > /ramdisk/tmp/write_pass
echo $write_fail > /ramdisk/tmp/write_fail
echo $pass_cycle > /ramdisk/tmp/pass_cycle
echo $fail_cycle > /ramdisk/tmp/fail_cycle

if [ -e /ramdisk/tmp/usb_test_result ]; then
	rm -f /ramdisk/tmp/usb_test_result
fi

if [ -e /ramdisk/tmp/run/mountd/sda1/usb_test_file ]; then
	test_start=`date`	
	for test_count in $(seq 1 $test_num)
	do
		read_status=0
		write_status=0
		
	# read test
		cp -f /ramdisk/tmp/run/mountd/sda1/usb_test_file /ramdisk/tmp/usb_test_tmp && cp_result=0 || cp_result=1
		cmp /ramdisk/tmp/run/mountd/sda1/usb_test_file /ramdisk/tmp/usb_test_tmp > /ramdisk/tmp/usb_cmp_tmp
		# cmp_result=`du /ramdisk/tmp/usb_cmp_tmp | awk '{print $1}'`

		cmp_result=`cat /ramdisk/tmp/usb_cmp_tmp`
		# if [ $cmp_result -ne 0 ]; then
		if [ -z $cmp_result ] && [ $cp_result -eq 0 ]; then
			read_pass=$(($read_pass + 1))			
			echo "Read OK! ($read_pass)" >> /ramdisk/tmp/usb_test_result
			echo "Read OK! ($read_pass)"
			echo $read_pass > /ramdisk/tmp/read_pass
			if [ $backup_flag -eq 0 ]; then
				backup_flag=1
				mv -f /ramdisk/tmp/usb_test_tmp /ramdisk/tmp/usb_test_file
			fi
			read_status=1
		else
			read_fail=$(($read_fail + 1))
			echo "Read FAIL! ($read_fail)" >> /ramdisk/tmp/usb_test_result
			echo "Read FAIL! ($read_fail)"
			echo $read_fail > /ramdisk/tmp/read_fail
			if [ $cp_result -eq 1 ]; then
				echo "Copy to Memory FAILED!!"
				echo "Copy to Memory FAILED!!" >> /ramdisk/tmp/usb_test_result
			fi
			read_status=0
		fi
		echo $test_count > /ramdisk/tmp/read_test_count
		
	# write test
		if [ -e /ramdisk/tmp/usb_test_file ]; then		

			cp -f /ramdisk/tmp/usb_test_file /ramdisk/tmp/run/mountd/sda1/usb_test_tmp && cp_result=0 || cp_result=1
			cmp /ramdisk/tmp/run/mountd/sda1/usb_test_tmp /ramdisk/tmp/usb_test_file > /ramdisk/tmp/usb_cmp_tmp
			# cmp_result=`du /ramdisk/tmp/usb_cmp_tmp | awk '{print $1}'`
			cmp_result=`cat /ramdisk/tmp/usb_cmp_tmp`

			# if [ $cmp_result -ne 0 ]; then
			if [ -z $cmp_result ] && [ $cp_result -eq 0 ]; then
				write_pass=$(($write_pass + 1))
				echo "Write OK! ($write_pass)" >> /ramdisk/tmp/usb_test_result
				echo "Write OK! ($write_pass)"
				echo $write_pass > /ramdisk/tmp/write_pass
				write_status=1
			else
				write_fail=$(($write_fail + 1))
				echo "Write FAIL! ($write_fail)" >> /ramdisk/tmp/usb_test_result
				echo "Write FAIL! ($write_fail)"
				echo $write_fail > /ramdisk/tmp/write_fail
				if [ $cp_result -eq 1 ]; then
					echo "Copy to USB Storage FAILED!!"
					echo "Copy to USB Storage FAILED!!" >> /ramdisk/tmp/usb_test_result
				fi
				write_status=0
			fi
			echo $test_count > /ramdisk/tmp/write_test_count
		else
			echo "ERROR!! usb_test_file dose NOT exist in /tmp folder!"
			echo "Skip one write test round!"
		fi
		echo "====================================" >> /ramdisk/tmp/usb_test_result
		echo "===================================="
		
		if [ $read_status -eq 1 ] && [ $write_status -eq 1 ]; then
			pass_cycle=$(($pass_cycle + 1))
			echo $pass_cycle > /ramdisk/tmp/pass_cycle
		else
			fail_cycle=$(($fail_cycle + 1))
			echo $fail_cycle > /ramdisk/tmp/fail_cycle
		fi
	done
	test_end=`date`
else
	echo "ERROR!! usb_test_file dose NOT exist in USB storage!"
	exit 0
fi

echo "============== TEST RESULT START ==============" >> /ramdisk/tmp/usb_test_result
echo "Total Test : $test_num" >> /ramdisk/tmp/usb_test_result
echo "Read Pass : $read_pass" >> /ramdisk/tmp/usb_test_result
echo "Read Fail : $read_fail" >> /ramdisk/tmp/usb_test_result
echo "Write Pass : $write_pass" >> /ramdisk/tmp/usb_test_result
echo "Write Fail : $write_fail" >> /ramdisk/tmp/usb_test_result
echo "Start at time : $test_start" >> /ramdisk/tmp/usb_test_result
echo "Finish at time : $test_end" >> /ramdisk/tmp/usb_test_result
echo "=============== TEST RESULT END ===============" >> /ramdisk/tmp/usb_test_result


echo "============== TEST RESULT START =============="
echo "Total Test : $test_num"
echo "Read Pass : $read_pass"
echo "Read Fail : $read_fail"
echo "Write Pass : $write_pass"
echo "Write Fail : $write_fail"
echo "Start at time : $test_start"
echo "Finish at time : $test_end"
echo "=============== TEST RESULT END ==============="


