#!/bin/sh

#[Phone1]
#OFF : echo 0 > /proc/phone1_led/phone1_led_state
#ON : echo 1 > /proc/phone1_led/phone1_led_state
#BLINKING 500MS : echo 2 > /proc/phone1_led/phone1_led_state
#BLINKING 1000MS : echo 3 > /proc/phone1_led/phone1_led_state
#FAIL ON: echo 1 > /sys/devices/virtual/leds/phone1_fail/brightness
#FAIL OFF: echo 0 > /sys/devices/virtual/leds/phone1_fail/brightness

#[Phone2]
#OFF : echo 0 > /proc/phone2_led/phone2_led_state
#ON : echo 1 > /proc/phone2_led/phone2_led_state
#BLINKING 500MS : echo 2 > /proc/phone2_led/phone2_led_state
#BLINKING 1000MS : echo 3 > /proc/phone2_led/phone2_led_state
#FAIL ON: echo 1 > /sys/devices/virtual/leds/phone2_fail/brightness
#FAIL OFF: echo 0 > /sys/devices/virtual/leds/phone2_fail/brightness



PH1_STATUS=/tmp/phone1_status
PH2_STATUS=/tmp/phone2_status

PH1_HOOK=/tmp/phone1_hook
PH2_HOOK=/tmp/phone2_hook


while [ -f /tmp/voip_led_lock ]
do
	sleep 1
done
touch /tmp/voip_led_lock

if [ -f $PH1_STATUS ]
then
LINE1_ENABLE=`cat $PH1_STATUS | awk -F" " '{print $1}'`
LINE1_REG=`cat $PH1_STATUS | awk -F" " '{print $2}'`
else
LINE1_ENABLE=0
LINE1_REG=0
fi

if [ -f $PH1_HOOK ]
then
LINE1_HOOK=`cat $PH1_HOOK | awk -F" " '{print $1}'`
else
LINE1_HOOK=0
fi

if [ -f $PH2_STATUS ]
then
LINE2_ENABLE=`cat $PH2_STATUS | awk -F" " '{print $1}'`
LINE2_REG=`cat $PH2_STATUS | awk -F" " '{print $2}'`
else
LINE2_ENABLE=0
LINE2_REG=0
fi

if [ -f $PH2_HOOK ]
then
LINE2_HOOK=`cat $PH2_HOOK | awk -F" " '{print $1}'`
else
LINE2_HOOK=0
fi

#Phone1
if [ $LINE1_HOOK == 0 ]
then
	if [ $LINE1_ENABLE == 0 ]
	then
		echo 0 > /proc/phone1_led/phone1_led_state
		echo 0 > /sys/devices/virtual/leds/phone1_fail/brightness	
	else
		if [ $LINE1_REG == 7 ]
		then
			echo 1 > /proc/phone1_led/phone1_led_state
			echo 0 > /sys/devices/virtual/leds/phone1_fail/brightness	
		else
			echo 0 > /proc/phone1_led/phone1_led_state
			echo 1 > /sys/devices/virtual/leds/phone1_fail/brightness	
		fi
		#End [ $LINE1_REG == 7 ]
	fi 
	#End [ $LINE1_ENABLE == 0 ]
else
	#off hook event
	if [ $LINE1_ENABLE == 0 ]
	then
		echo 0 > /proc/phone1_led/phone1_led_state
		echo 0 > /sys/devices/virtual/leds/phone1_fail/brightness	
	else
		if [ $LINE1_REG == 7 ]
		then
			echo 2 > /proc/phone1_led/phone1_led_state
			echo 0 > /sys/devices/virtual/leds/phone1_fail/brightness	
		else
			echo 0 > /proc/phone1_led/phone1_led_state
			echo 1 > /sys/devices/virtual/leds/phone1_fail/brightness	
		fi
		#End [ $LINE1_REG == 7 ]
	fi 
fi	

#phone2
if [ $LINE2_HOOK == 0 ]
then
	if [ $LINE2_ENABLE == 0 ]
	then
		echo 0 > /proc/phone2_led/phone2_led_state
		echo 0 > /sys/devices/virtual/leds/phone2_fail/brightness	
	else
		if [ $LINE2_REG == 7 ]
		then
			echo 1 > /proc/phone2_led/phone2_led_state
			echo 0 > /sys/devices/virtual/leds/phone2_fail/brightness	
		else
			echo 0 > /proc/phone2_led/phone2_led_state
			echo 1 > /sys/devices/virtual/leds/phone2_fail/brightness	
		fi
		#End [ $LINE2_REG == 7 ]
	fi 
	#End [ $LINE2_ENABLE == 0 ]
else
	if [ $LINE2_ENABLE == 0 ]
	then
		echo 0 > /proc/phone2_led/phone2_led_state
		echo 0 > /sys/devices/virtual/leds/phone2_fail/brightness	
	else
		if [ $LINE2_REG == 7 ]
		then
			echo 2 > /proc/phone2_led/phone2_led_state
			echo 0 > /sys/devices/virtual/leds/phone2_fail/brightness	
		else
			echo 0 > /proc/phone2_led/phone2_led_state
			echo 1 > /sys/devices/virtual/leds/phone2_fail/brightness	
		fi
		#End [ $LINE2_REG == 7 ]
	fi 
fi
	
rm -f /tmp/voip_led_lock






