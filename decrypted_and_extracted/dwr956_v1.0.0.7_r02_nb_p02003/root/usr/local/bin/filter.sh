#! /bin/sh
#set -x

echo "run script : filter.sh"

if [ "_$1" = "_init" ];then
	echo "filter init"
	iptables -N USER_FILTER
	iptables -A FORWARD -j USER_FILTER
else
	logger -t [IPTABLES] -p local2.info filter restart
fi

#Default Policy 
echo 0 > /proc/sys/net/ipv4/ip_forward
# GARYeh 20120423: clear iptables to avoid save network rule
iptables -F USER_FILTER
iptables -Z USER_FILTER

#Access Control
ACCOUNT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from FirewallRule;"`
if [ "$ACCOUNT" -ne 0 ]; then
	i=1
	while [ $i -le $ACCOUNT ]
	do
		ACSERVICE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ServiceName from FirewallRule where _ROWID_='$i';"`
		ACHOST=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select HostName from FirewallRule where _ROWID_='$i';"`
		
		# check is there any ServiceName and Cname for Access Control in Services tables
		SERVICE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ServiceName from Services where ServiceName='$ACSERVICE';"`
		HOST=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Cname from hostTbl where Cname='$ACHOST';"`
		
		if [ "$SERVICE" != "" -a "$HOST" != "" ]; then
			PFSERVICE_PROTOCOL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Protocol from Services where ServiceName='$SERVICE';"`
			PORTSTART=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DestinationPortStart from Services where ServiceName='$SERVICE';"`
			PORTEND=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DestinationPortEnd from Services where ServiceName='$SERVICE';"`
			
			HOSTIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select IpAddr from hostTbl where Cname='$HOST';"`
			
			ACSTATUS=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Status from FirewallRule where _ROWID_='$i';"`
			
			if [ "$ACSTATUS" = "0" ]; then
				iptables -A USER_FILTER -s $HOSTIP -p $PFSERVICE_PROTOCOL --dport $PORTSTART:$PORTEND -j ACCEPT
			else
				iptables -A USER_FILTER -s $HOSTIP -p $PFSERVICE_PROTOCOL --dport $PORTSTART:$PORTEND -j DROPLOG
			fi
		else	
			echo "No service and host to create Access Control rule!!!"
		fi
		i=`expr $i + 1`
	done
fi
#end Access Control

#packet filter
#iptables -N PACKETFILTER
#iptables -A USER_FILTER -j PACKETFILTER

#PacketFilterEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select PacketFilterEnable from FirewallConfig;"`
#if [ "$PacketFilterEnable" = "1" ]; then
#	PacketFilterCnt=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from PacketFilter;"`
#	if [ "$PacketFilterCnt" -ne 0 ]; then
#		i=1
#		while [ $i -le $PacketFilterCnt ]
#		do
#			pfilterenable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from PacketFilter where _ROWID_='$i'";`
#			if [ "$pfilterenable" = "1" ]; then
#				IpAddr=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select IpAddr from PacketFilter where _ROWID_='$i'";`
#				Protocol=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Protocol from PacketFilter where _ROWID_='$i'";`
#				portRange=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select portRange from PacketFilter where _ROWID_='$i'";`
#				if [ $Protocol = "both" ]; then
#					iptables -A PACKETFILTER -s $IpAddr -p tcp --dport $portRange -j LOG --log-prefix \"Pkt filter:\"
#					iptables -A PACKETFILTER -s $IpAddr -p tcp --dport $portRange -j DROP
#					iptables -A PACKETFILTER -s $IpAddr -p udp --dport $portRange -j LOG --log-prefix \"Pkt filter:\"
#					iptables -A PACKETFILTER -s $IpAddr -p udp --dport $portRange -j DROP
#				else
#					iptables -A PACKETFILTER -s $IpAddr -p $Protocol --dport $portRange -j LOG --log-prefix \"Pkt filter:\"
#					iptables -A PACKETFILTER -s $IpAddr -p $Protocol --dport $portRange -j DROP
#				fi
#			fi
#			i=`expr $i + 1`
#		done
#	fi
#fi
#end packet filter
	
#mac filter
#iptables -N MACFILTER
#iptables -A USER_FILTER -j MACFILTER	
	
#MacFilterEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select MacFilterEnable from FirewallConfig;"`
#if [ "$MacFilterEnable" = "1" ]; then
#	MacFilterCnt=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from MacFilter;"`
#	if [ "$MacFilterCnt" -ne 0 ]; then
#		i=1
#		while [ $i -le $MacFilterCnt ]
#		do
#			mfilterenable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from MacFilter where _ROWID_='$i'";`
#			if [ "$mfilterenable" = "1" ]; then
#				MacAddr=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select MacAddr from MacFilter where _ROWID_='$i'";`					
#				iptables -A MACFILTER -m mac --mac-source $MacAddr  -j LOG --log-prefix \"Mac filter:\"
#				iptables -A MACFILTER -m mac --mac-source $MacAddr -j DROP
#			fi
#			i=`expr $i + 1`
#		done
#	fi
#fi
#end mac filter

if [ "$1" != "init" ]; then
	# clear all conntrack
	conntrack -F
fi

echo 1 >/proc/sys/net/ipv4/ip_forward
