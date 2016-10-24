#! /bin/sh

echo "run script : firewall_rule.sh"

EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`
#LANIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LAN1';"`
#LANIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ipaddr from networkInterface where LogicalIfName = 'LAN1';"`	
#LANMASK=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select subnetmask from networkInterface where LogicalIfName = 'LAN1';"`
#LANMASK=`ipcalc.sh $LANIP $LANMASK | grep PREFIX |sed 's/^.*PREFIX=//g'`

#block ping
BLOCKPING=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ICMPBLOCK from FirewallConfig;"`
if [ "$BLOCKPING" = "1" ]; then
	echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
else
	echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_all
fi
#end block ping

echo 0 >/proc/sys/net/ipv4/ip_forward

# GARYeh 20120407: clear the CHAIN of FW_SYN_FLOOD_WAN
iptables -F FW_SYN_FLOOD_WAN
iptables -Z FW_SYN_FLOOD_WAN
iptables -F FW_FIN_FLOOD_WAN
iptables -Z FW_FIN_FLOOD_WAN

TCPSynEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select TCPSynEnable from FirewallConfig;"`
TCPFinEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select TCPFinEnable from FirewallConfig;"`

if [ "$TCPSynEnable" = "1" ]; then
	TCPSynFlood=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select TCPSynFlood from FirewallConfig;"`
	# GARYeh 20120407: add FW_SYN_FLOOD_WAN rule
	iptables -A FW_SYN_FLOOD_WAN -m limit --limit ${TCPSynFlood}/s --limit-burst $TCPSynFlood -j RETURN
	iptables -A FW_SYN_FLOOD_WAN -m limit --limit 1/s --limit-burst 3 -j LOG --log-level "info" --log-prefix "[SYNFLOOD_WAN] "
	iptables -A FW_SYN_FLOOD_WAN -j DROP
fi

if [ "$TCPFinEnable" = "1" ]; then
	TCPFinFlood=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select TCPFinFlood from FirewallConfig;"`
	# GARYeh 20120407: add FW_FIN_FLOOD_WAN rule
	iptables -A FW_FIN_FLOOD_WAN -m limit --limit ${TCPFinFlood}/s --limit-burst $TCPFinFlood -j RETURN
	iptables -A FW_FIN_FLOOD_WAN -m limit --limit 1/s --limit-burst 3 -j LOG --log-level "info" --log-prefix "[FINFLOOD_WAN] "
	iptables -A FW_FIN_FLOOD_WAN -j DROP
fi

# ICMP/ICMP_Ping Flood
iptables -F FW_ICMP_FLOOD
iptables -Z FW_ICMP_FLOOD
iptables -F FW_ICMP_PING_FLOOD
iptables -Z FW_ICMP_PING_FLOOD

ICMPFlood=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ICMPFlood from FirewallConfig;"`
ICMPPingFlood=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ICMPPingFlood from FirewallConfig;"`

iptables -A FW_ICMP_FLOOD -p icmp -m limit --limit $ICMPFlood/s --limit-burst $ICMPFlood -j RETURN
iptables -A FW_ICMP_FLOOD -p icmp -m limit --limit 1 -j LOG --log-prefix "[ICMPFlood] "
iptables -A FW_ICMP_FLOOD -p icmp -j DROP
iptables -A FW_ICMP_PING_FLOOD -p icmp --icmp-type 8 -m limit --limit $ICMPPingFlood/s --limit-burst $ICMPPingFlood -j ACCEPT
iptables -A FW_ICMP_PING_FLOOD -p icmp --icmp-type 8 -m limit --limit 1 -j LOG --log-prefix "[ICMPPingFlood] "
iptables -A FW_ICMP_PING_FLOOD -p icmp --icmp-type 8 -j DROP

iptables -t raw -N ANTI_IP_SPOOFING
iptables -t raw -A PREROUTING -j ANTI_IP_SPOOFING
iptables -t raw -F ANTI_IP_SPOOFING
iptables -t raw -Z ANTI_IP_SPOOFING
#if [ "$FW_RULE_ANTI_SPOOFING" = "on" ]; then
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 0.0.0.0/8 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 127.0.0.0/8 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 255.255.255.255/32 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 10.0.0.0/8 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 172.16.0.0/12 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 192.168.0.0/16 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 224.0.0.0/3 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 168.254.0.0/16 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 169.254.0.0/16 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 240.0.0.0/4 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 240.0.0.0/5 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 248.0.0.0/5 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $EXTIF -s 192.0.2.0/24 -j DROP
#	iptables -t raw -A ANTI_IP_SPOOFING -i $LANIF -s $LANIP/$LANMASK -j RETURN
#	iptables -t raw -A ANTI_IP_SPOOFING -i $LANIF -s $LANIP -j RETURN
#	iptables -t raw -A ANTI_IP_SPOOFING -i $LANIF -s 0.0.0.0/8 -j RETURN
#	iptables -t raw -A ANTI_IP_SPOOFING -i $LANIF -j DROP
#fi

iptables -F SPI
iptables -Z SPI
SPIEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from SPI;"`
SECURITY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Mode from SecurityConfig;"`
if [ "$SECURITY" != "3" ]; then
	if [ "$SPIEnable" = "1" ]; then
		### state tracking rules
		#iptables -A SPI -m conntrack --ctstate INVALID -j LOG --log-level "info" --log-prefix "[SPI_CTSTATE_DROP] "
		iptables -A SPI -m conntrack --ctstate INVALID -j DROP
		#iptables -A SPI -m state --state INVALID -j LOG --log-level "info" --log-prefix "[SPI_STATE_DROP] "
		iptables -A SPI -m state --state INVALID -j DROP
		iptables -A SPI -m conntrack --ctstate ESTABLISHED,RELATED -j RETURN
	fi
fi

echo 1 >/proc/sys/net/ipv4/ip_forward

