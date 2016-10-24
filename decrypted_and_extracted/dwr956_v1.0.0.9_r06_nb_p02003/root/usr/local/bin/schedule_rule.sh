#! /bin/sh
#set -x

SchedulesEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EnableProfiles from UrlFltrConfig;"`

echo "run script : schedule_rule.sh"

if [ "_$1" = "_init" ];then
	echo "schedule_rule init"
	iptables -N SCH_RULE
	iptables -N EMPTY_RULE
	iptables -A FORWARD -p tcp -j SCH_RULE
else
	logger -t [IPTABLES] -p local2.info schedule_rule restart
fi


if [ "_$1" = "_release_URLLink" ];then
	if [ "$SchedulesEnable" = "1" ]; then
		PCProfileCnt=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from UrlProfile;"`
		if [ "$PCProfileCnt" -ne 0 ]; then
			i=1
			while [ $i -le $PCProfileCnt ]
			do
				PCProfileName=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ProfileName from UrlProfile where _ROWID_='$i'";`
				iptables -F $PCProfileName
				iptables -Z $PCProfileName
				i=`expr $i + 1`
			done
		fi
	fi
	return
fi

if [ "_$1" = "_access_network" ];then
	if [ "$SchedulesEnable" = "1" ]; then
		if [ "_$2" != "_" ];then  
			logger -t [IPTABLES] -p local2.info $2 login to access network
			if [ "_$3" != "_" ];then
				echo $2 > /proc/net/ipt_recent/$3  
				echo $2 > /proc/net/ipt_recent/idle_$3
			else
				for list in /proc/net/ipt_recent/*; do
					echo $2 > ${list}
				done          
			fi
		fi 
	fi
	return
fi

if [ "_$1" = "_session_timeout" ];then
	if [ "$SchedulesEnable" = "1" ]; then
		if [ "_$2" != "_" ];then
			logger -t [IPTABLES] -p local2.info $2 session timeout or logout
			if [ "_$3" != "_" ];then
				echo -$2 > /proc/net/ipt_recent/$3  
				echo -$2 > /proc/net/ipt_recent/idle_$3
			else
				for list in /proc/net/ipt_recent/*; do
					echo -$2 > ${list}
				done
			fi
		fi
	fi
	return
fi

echo 0 > /proc/sys/net/ipv4/ip_forward
#clear schedule filter 
iptables -L SCH_RULE | sed 1,2d | awk '{print "\t" $1}' > /tmp/SCHtempList
iptables -F SCH_RULE
iptables -Z SCH_RULE
cat /tmp/SCHtempList | while read line
do
	if [ "$line" != "REJECT" ]; then
		iptables -F $line
		iptables -X $line
	fi
done
rm -f /tmp/SCHtempList

# clear recent ip list
if [ "_$1" != "_init" ];then
	for list in /proc/net/ipt_recent/*; do
		echo clear > ${list}
	done
fi

#create schedule filter
if [ "$SchedulesEnable" = "1" ]; then
	PCProfileCnt=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from UrlProfile;"`
	ppacmd control --disable-lan --disable-wan
	
	if [ "$PCProfileCnt" -ne 0 ]; then
		i=1
		while [ $i -le $PCProfileCnt ]
		do
			PCProfileName=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ProfileName from UrlProfile where _ROWID_='$i'";`
			PCProfileSchEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EnableSchedules from UrlProfile where _ROWID_='$i'";`
			 
			# add schedule rule
			iptables -N $PCProfileName
			if [ "$PCProfileSchEnable" = "1" ]; then
				PCProfileSchName=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ScheduleName from UrlProfile where _ROWID_='$i';"`
				SchName=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ScheduleName from Schedules where ScheduleName='$PCProfileSchName';"`
			
				if [ "$SchName" != "" ]; then
					StartHour=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select StartTimeHours from Schedules where ScheduleName='$PCProfileSchName';"`
					StartMin=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select StartTimeMins from Schedules where ScheduleName='$PCProfileSchName';"`
					StartMeridian=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select StartTimeMeridian from Schedules where ScheduleName='$PCProfileSchName';"`
					EndHour=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EndTimeHours from Schedules where ScheduleName='$PCProfileSchName';"`
					EndMin=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EndTimeMins from Schedules where ScheduleName='$PCProfileSchName';"`
					EndMeridian=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EndTimeMeridian from Schedules where ScheduleName='$PCProfileSchName';"`
					
					if [ "$StartMeridian" = "1" ]; then
						if [ "$StartHour" = "12" ]; then
							StartHour=0
						else
							StartHour=`expr $StartHour + 12`
						fi
					fi
					
					if [ "$EndMeridian" = "1" ]; then
						if [ "$EndHour" = "12" ]; then
							EndHour=0
						else
							EndHour=`expr $EndHour + 12`
						fi
					fi
					
					# Mon(1) Tue(2) Wed(4) Thu(8) Fri(16) Sat(32) Sun(64)
					Weeks=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Days from Schedules where ScheduleName='$PCProfileSchName';"`
					WeekDays=""
					
					chkSun=`expr $Weeks \/ 64`
					if [ "$chkSun" = "1" ]; then
						WeekDays=Sun,$WeekDays
					fi
					chkSat=`expr $Weeks \% 64 \/ 32`
					if [ "$chkSat" = "1" ]; then
						WeekDays=Sat,$WeekDays
					fi
					chkFri=`expr $Weeks \% 64 \% 32 \/ 16`
					if [ "$chkFri" = "1" ]; then
						WeekDays=Fri,$WeekDays
					fi
					chkThu=`expr $Weeks \% 64 \% 32 \% 16 \/ 8`
					if [ "$chkThu" = "1" ]; then
						WeekDays=Thu,$WeekDays
					fi
					chkWed=`expr $Weeks \% 64 \% 32 \% 16 \% 8 \/ 4`
					if [ "$chkWed" = "1" ]; then
						WeekDays=Wed,$WeekDays
					fi
					chkTue=`expr $Weeks \% 64 \% 32 \% 16 \% 8 \% 4 \/ 2`
					if [ "$chkTue" = "1" ]; then
						WeekDays=Tue,$WeekDays
					fi
					chkMon=`expr $Weeks \% 64 \% 32 \% 16 \% 8 \% 4 \% 2`
					if [ "$chkMon" = "1" ]; then
						WeekDays=Mon,$WeekDays
					fi
										
					SessionTimeout=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select SessionTimeout from UrlProfile where _ROWID_='$i'";`
					SessionTimeout=`expr $SessionTimeout \* 60`
					iptables -A SCH_RULE -m recent --name $PCProfileName --rcheck --seconds $SessionTimeout -m time --weekdays $WeekDays --timestart $StartHour:$StartMin --timestop $EndHour:$EndMin -j $PCProfileName
					
					IdleTimeout=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select InactivityTimeout from UrlProfile where _ROWID_='$i'";`
					IdleTimeout=`expr $IdleTimeout \* 60`
			
					PCProfileURLEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EnableContentFltr from UrlProfile where _ROWID_='$i'";`
					if [ "$PCProfileURLEnable" = "1" ]; then
						URLProfileName=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ContentFltrName from UrlProfile where _ROWID_='$i';"`
						iptables -A $PCProfileName -m recent --name idle_$PCProfileName --update --seconds $IdleTimeout -j CF$URLProfileName
					else	
						iptables -A $PCProfileName -m recent --name idle_$PCProfileName --update --seconds $IdleTimeout -j ACCEPT
					fi
				else	
					echo "No schedule to create parent control rule!!!"
				fi
			else
				SessionTimeout=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select SessionTimeout from UrlProfile where _ROWID_='$i'";`
				SessionTimeout=`expr $SessionTimeout \* 60`
				iptables -A SCH_RULE  -m recent --name $PCProfileName --rcheck --seconds $SessionTimeout -j $PCProfileName
				
				IdleTimeout=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select InactivityTimeout from UrlProfile where _ROWID_='$i'";`
				IdleTimeout=`expr $IdleTimeout \* 60`
				
				PCProfileURLEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EnableContentFltr from UrlProfile where _ROWID_='$i'";`
				if [ "$PCProfileURLEnable" = "1" ]; then
					URLProfileName=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ContentFltrName from UrlProfile where _ROWID_='$i';"`	
					iptables -A $PCProfileName -m recent --name idle_$PCProfileName --update --seconds $IdleTimeout -j CF$URLProfileName
				else	
					iptables -A $PCProfileName -m recent --name idle_$PCProfileName --update --seconds $IdleTimeout -j ACCEPT
				fi
			fi			
			i=`expr $i + 1`
		done
	fi	
	iptables -A SCH_RULE -j REJECT --reject-with web-redirect
else	
	QOS_Enable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from QoS;"`
	if [ $QOS_Enable = "0" ];then
		ppacmd control --enable-lan --enable-wan
	fi	
fi

if [ "$1" != "init" ]; then
	# clear all conntrack
	conntrack -F
fi

echo 1 >/proc/sys/net/ipv4/ip_forward
