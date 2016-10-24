#! /bin/sh
#set -x

echo "run script : dmz.sh"

if [ "_$1" = "_init" ];then
	echo "dmz init"
	iptables -t nat -N DMZ
	iptables -t nat -A PREROUTING -j DMZ	
	iptables -N DMZ
	iptables -A FORWARD -j DMZ
else
	logger -t [IPTABLES] -p local2.info dmz restart
fi

DMZENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from FirewallDmz;"`
WANINTERFACE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`

#Default Policy 
echo 0 > /proc/sys/net/ipv4/ip_forward
# GARYeh 20120423: clear nat table to avoid save network rule
iptables -t nat -F DMZ
iptables -t nat -Z DMZ
iptables -F DMZ
iptables -Z DMZ

if [ "$DMZENABLE" = "1" ]; then
	DMZIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DmzIpAddress from FirewallDmz;"`
	iptables -t nat -A DMZ -i $WANINTERFACE -j DNAT --to $DMZIP 
	iptables -A DMZ -d $DMZIP -j ACCEPT
fi

if [ "$1" != "init" ]; then
	# clear all conntrack
	conntrack -F
fi

echo 1 >/proc/sys/net/ipv4/ip_forward

