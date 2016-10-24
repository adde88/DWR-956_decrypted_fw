#! /bin/sh
#set -x

echo "run script : urlfilter.sh"

if [ "_$1" = "_init" ];then
	echo "urlfilter init"
	iptables -N URL_FILTER
	#iptables -N URL_IP_FILTER
	#iptables -A FORWARD -j URL_FILTER
else
	logger -t [IPTABLES] -p local2.info urlfilter restart
fi

echo 0 > /proc/sys/net/ipv4/ip_forward

if [ "_$1" != "_init" ];then
	/usr/local/bin/schedule_rule.sh release_URLLink

	#clear URL filter 
	iptables -L URL_FILTER | sed 1,2d | awk '{print "\t" $1}' > /tmp/URLtempList
	iptables -F URL_FILTER
	iptables -Z URL_FILTER
	cat /tmp/URLtempList | while read line
	do
		iptables -F $line
		iptables -X $line
	done
	rm -f /tmp/URLtempList
fi

#create URL filter 
ContentFltrCnt=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from ContentFltr;"`
if [ "$ContentFltrCnt" -ne 0 ]; then
	i=1
	while [ $i -le $ContentFltrCnt ]
	do
		ContentFltrName=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ContentFltrName from ContentFltr where _ROWID_='$i'";`
		ContentFltrPolicy=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Policy from ContentFltr where _ROWID_='$i'";`
		
		iptables -N CF$ContentFltrName
		iptables -A URL_FILTER -j CF$ContentFltrName
		
		sqlite3 -cmd ".timeout 1000" /tmp/system.db "select FltrString from Fltr where ContentFltrName='$ContentFltrName' and FltrType='1';" | while read line
		do
			if [ "$ContentFltrPolicy" = "1" ]; then
				iptables -A CF$ContentFltrName -m string --algo bm --string $line -j ACCEPT
			else 
				iptables -A CF$ContentFltrName -m string --algo bm --string $line -j REJECT --reject-with web-block 
			fi
		done
		
		sqlite3 -cmd ".timeout 1000" /tmp/system.db "select FltrString from Fltr where ContentFltrName='$ContentFltrName' and FltrType='2';" | while read line
		do
			if [ "$ContentFltrPolicy" = "1" ]; then
				iptables -A CF$ContentFltrName -m webstr --url $line -j ACCEPT
			else
				iptables -A CF$ContentFltrName -m webstr --url $line -j REJECT --reject-with web-block
			fi
		done
		
		if [ "$ContentFltrPolicy" = "1" ]; then
			iptables -A CF$ContentFltrName -j REJECT --reject-with web-block
		else
			iptables -A CF$ContentFltrName -j ACCEPT
		fi
		
		i=`expr $i + 1`
	done
fi

if [ "_$1" != "_init" ];then
	/usr/local/bin/schedule_rule.sh
fi

echo 1 >/proc/sys/net/ipv4/ip_forward
