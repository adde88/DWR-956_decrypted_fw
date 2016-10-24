#!/bin/sh

#This script is to set packet interval in rc.conf

CONF=/ramdisk/flash/rc.conf
DB_LOG="/tmp/setpki.log"

if [ ! -f $DB_LOG ]
then
   touch $DB_LOG
fi

if [ $1 -lt 0 -o $1 -gt 19 ]; then
		echo Codec list number should be 0~19
		exit 1
fi		

STR=List_"$1"_SupFrame=  

#No input value => Read                                       
if [ -z $2 ]
then
	OUT="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
	echo $OUT
	exit 1
else
	echo write packet interval of codec $1 to $2 >> $DB_LOG
	if [ $2 -lt 10 -o $2 -gt 60 ]; then
		echo Packet Interval should be 10~60
		exit 1
	fi

	while [ -f /tmp/rc_conf_lock ]
	do
	  #echo locked
		sleep 1
	done
	touch /tmp/rc_conf_lock
	
	SAVE="$STR"'"'"$2"'"'
	echo SAVE STR = $SAVE >> $DB_LOG
	sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 
	savecfg.sh
	rm -f /tmp/rc_conf_lock
fi
#end of [ -z $2 ]
