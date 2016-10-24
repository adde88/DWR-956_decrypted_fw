#!/bin/sh

NTPPID=`pidof ntpclient`
if [ -n "$NTPPID" ]; then
killall ntpclient
fi

ENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select enabled from ntpConfig";`
if [ "$ENABLE" = "1" ]; then
	SERVER1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select server1 from ntpConfig";`
	SERVER2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select server2 from ntpConfig";`
	SERVER3=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select server3 from ntpConfig";`
	SYNC_INTERVAL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select reSyncNtpVal from ntpConfig";`
	DAY_LIGHT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select autoDaylight from ntpConfig";`
	TIMEOFFSET=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select timezone from ntpConfig";`
	
	if [ "$DAY_LIGHT" == "1" ]; then
		if [ "$TIMEOFFSET" == "0" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Europe/London`		
		elif [ "$TIMEOFFSET" = "-720" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/GMT+12`
		elif [ "$TIMEOFFSET" = "-660" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Pacific/Samoa`
		elif [ "$TIMEOFFSET" = "-600" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/US/Aleutian`
		elif [ "$TIMEOFFSET" = "-570" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Pacific/Marquesas`
		elif [ "$TIMEOFFSET" = "-540" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/Anchorage`
		elif [ "$TIMEOFFSET" = "-480" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/Los_Angeles`
		elif [ "$TIMEOFFSET" = "-420" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/Denver`
		elif [ "$TIMEOFFSET" = "-360" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/Chicago`
		elif [ "$TIMEOFFSET" = "-300" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/New_York`
		elif [ "$TIMEOFFSET" = "-270" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/Caracas`	
		elif [ "$TIMEOFFSET" = "-240" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/Halifax`
		elif [ "$TIMEOFFSET" = "-210" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Canada/Newfoundland`
		elif [ "$TIMEOFFSET" = "-180" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/Sao_Paulo`	
		elif [ "$TIMEOFFSET" = "-120" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/GMT+2`
		elif [ "$TIMEOFFSET" = "-60" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/America/Scoresbysund`					
		elif [ "$TIMEOFFSET" = "60" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Europe/Paris`	
		elif [ "$TIMEOFFSET" = "120" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Israel`	
		elif [ "$TIMEOFFSET" = "180" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Baghdad`
		elif [ "$TIMEOFFSET" = "240" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Baku`
		elif [ "$TIMEOFFSET" = "270" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Kabul`
		elif [ "$TIMEOFFSET" = "300" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Karachi`
		elif [ "$TIMEOFFSET" = "330" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Calcutta`
		elif [ "$TIMEOFFSET" = "360" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Dhaka`
		elif [ "$TIMEOFFSET" = "390" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Rangoon`
		elif [ "$TIMEOFFSET" = "420" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Bangkok`
		elif [ "$TIMEOFFSET" = "480" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Hong_Kong`
		elif [ "$TIMEOFFSET" = "540" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Asia/Tokyo`
		elif [ "$TIMEOFFSET" = "570" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Australia/Adelaide`
		elif [ "$TIMEOFFSET" = "600" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Australia/Sydney`
		elif [ "$TIMEOFFSET" = "630" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Australia/Lord_Howe`
		elif [ "$TIMEOFFSET" = "660" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Pacific/Noumea`
		elif [ "$TIMEOFFSET" = "690" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Pacific/Norfolk`
		elif [ "$TIMEOFFSET" = "720" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/NZ`
		elif [ "$TIMEOFFSET" = "780" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Pacific/Apia`
		elif [ "$TIMEOFFSET" = "840" ]; then
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Pacific/Kiritimati`
		else
			TIMEZONE=`tail -n 1 /usr/share/zoneinfo/Europe/Oslo`
		fi
		
		echo $TIMEZONE > /tmp/timezone
	else
		echo $TIMEOFFSET > /tmp/timezone
	fi	
	
	if [ "$SERVER1" != "" ]; then
		/usr/sbin/ntpclient -h $SERVER1 -s -o "$TIMEOFFSET" -l -i "$SYNC_INTERVAL" &
	fi

	if [ "$SERVER2" != "" ]; then
		/usr/sbin/ntpclient -h $SERVER2 -s -o "$TIMEOFFSET" -l -i "$SYNC_INTERVAL" &
	fi
	
	if [ "$SERVER3" != "" ]; then
		/usr/sbin/ntpclient -h $SERVER3 -s -o "$TIMEOFFSET" -l -i "$SYNC_INTERVAL" &
	fi
fi
