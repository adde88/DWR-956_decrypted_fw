#! /bin/sh
#set -x

echo "run script : forward.sh"

if [ "_$1" = "_init" ];then
	echo "forward init"
	iptables -t nat -N USER_FORWARD
	iptables -t nat -A PREROUTING -j USER_FORWARD
	iptables -N USER_FORWARD
	iptables -A FORWARD -j USER_FORWARD
else
	logger -t [IPTABLES] -p local2.info forward restart
fi

EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`

#Default Policy 
echo 0 > /proc/sys/net/ipv4/ip_forward

# GARYeh 20120407: clear the CHAIN of USER_FORWARD
iptables -t nat -F USER_FORWARD
iptables -t nat -Z USER_FORWARD
iptables -F USER_FORWARD
iptables -Z USER_FORWARD

#port forwarding
PFCOUNT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from PortForwarding;"`
if [ "$PFCOUNT" -ne 0 ]; then
	i=1
	while [ $i -le $PFCOUNT ]
	do
		PFSERVICE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ServiceName from PortForwarding where _ROWID_='$i';"`
		
		# check is there any ServiceName for port forwarding in Services tables
		SERVICE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ServiceName from Services where ServiceName='$PFSERVICE';"`
		if [ "$SERVICE" != "" ]; then
			PFSERVICE_PROTOCOL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Protocol from Services where ServiceName='$SERVICE';"`
			PORTSTART=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DestinationPortStart from Services where ServiceName='$SERVICE';"`
			PORTEND=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DestinationPortEnd from Services where ServiceName='$SERVICE';"`
			
			PFIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Ip from PortForwarding where _ROWID_='$i';"`
			PFPortACTIVE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DNATPortEnable from PortForwarding where _ROWID_='$i';"`
			if [ "$PFPortACTIVE" = "1" ]; then
				PFPort=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DNATPort from PortForwarding where _ROWID_='$i';"`
				
				iptables -t nat -A USER_FORWARD -i $EXTIF -p $PFSERVICE_PROTOCOL --dport $PORTSTART:$PORTEND -j DNAT --to $PFIP:$PFPort
				iptables -A USER_FORWARD -p $PFSERVICE_PROTOCOL -d $PFIP --dport $PFPort -j ACCEPT
			else	
				iptables -t nat -A USER_FORWARD -i $EXTIF -p $PFSERVICE_PROTOCOL --dport $PORTSTART:$PORTEND -j DNAT --to $PFIP
				iptables -A USER_FORWARD -p $PFSERVICE_PROTOCOL -d $PFIP --dport $PORTSTART:$PORTEND -j ACCEPT
			fi
		else	
			echo "No service to create port forwarding rule!!!"
		fi
		i=`expr $i + 1`
	done
fi
#end port forwarding

if [ "$1" != "init" ]; then
	# clear all conntrack
	conntrack -F
fi

echo 1 >/proc/sys/net/ipv4/ip_forward
