#! /bin/sh

echo "run script : SessionLimit.sh"

if [ "_$1" = "_init" ];then
	echo "SessionLimit init"
	iptables -N SESSION_LIMIT
	iptables -A FORWARD -j SESSION_LIMIT
else
	logger -t [IPTABLES] -p local2.info SessionLimit restart
fi

echo 0 > /proc/sys/net/ipv4/ip_forward
iptables -F SESSION_LIMIT
iptables -Z SESSION_LIMIT

SessionsEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from PeerToPeer;"`

if [ "$SessionsEnable" = "1" ]; then
	Sessions=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Sessions from PeerToPeer;"`
	#LANIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LAN1';"`
	LANIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ipaddr from networkInterface where LogicalIfName = 'LAN1';"`
	#EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`	
	LANMASK=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select subnetmask from networkInterface where LogicalIfName = 'LAN1';"`
	#LANMASK=`ipcalc.sh $LANIP $LANMASK | grep PREFIX | sed 's/^.*PREFIX=//g'`

	iptables -A SESSION_LIMIT -m state --state NEW,RELATED,INVALID -m connlimit --connlimit-above $Sessions --connlimit-mask 32 -j LOG --log-level "info" --log-prefix "[SESSION_LIMIT] "
	iptables -A SESSION_LIMIT -m state --state NEW,RELATED,INVALID -m connlimit --connlimit-above $Sessions --connlimit-mask 32 -j DROP
fi

if [ "$1" != "init" ]; then
	# clear all conntrack
	conntrack -F
fi

echo 1 >/proc/sys/net/ipv4/ip_forward
