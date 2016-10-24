#!/bin/sh

echo "run script : firewall.sh"

if [ "_$1" = "_init" ];then
	echo "firewall init"
else
	logger -t [IPTABLES] -p local2.info firewall restart
fi

EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`
EXTIF2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN2';"`
LANIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LAN1';"`
LANIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ipaddr from networkInterface where LogicalIfName = 'LAN1';"`
ResetDefault=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select resetToDefault from ResetToDefault;"`
NATENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from FirewallNatConfig;"`

# firewall security level : 1-max 2-typical 3-no
SECURITY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Mode from SecurityConfig;"`

LOG="LOG --log-tcp-sequence --log-tcp-options"
LOG="$LOG --log-ip-options"

RLIMIT="-m limit --limit 3/s --limit-burst 8"

iptables -F 
iptables -X 
iptables -t mangle -F
iptables -t mangle -X
iptables -t nat -F 
iptables -t nat -X 
iptables -t raw -F 
iptables -t raw -X 

# bridge mode
if [ "$NATENABLE" = "5" ]; then 
	# drop modem arp packet which incoming br0
	arptables -I INPUT -i $LANIF --source-mac 02:50:f3:00:00:00/FF:FF:FF:00:00:00 -j DROP

	iptables -P INPUT ACCEPT
	iptables -P OUTPUT ACCEPT
	iptables -P FORWARD ACCEPT
	return
fi

iptables -P INPUT DROP
if [ "$SECURITY" = "3" ]; then
	iptables -P FORWARD ACCEPT
else
	iptables -P FORWARD DROP
fi
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A OUTPUT -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

# LOG packets, then DROP.
iptables -N DROPLOG
#iptables -A DROPLOG -j $LOG $RLIMIT --log-level "info" --log-prefix "[IPTABLES_DROP] "
iptables -A DROPLOG -j DROP

# load iptables
# GARYeh 20131003: add PREROUTING rule for Landing Page
#if [ "$ResetDefault" = "1" ]; then
#	iptables -t nat -A PREROUTING -i $LANIF -p tcp --dport 80 -j DNAT --to-destination $LANIP

	#iptables -A INPUT -i $LANIF -p tcp --syn -m tcp --dport 80 -m state --state NEW -m recent --set --name "limit-http" --rsource
	#iptables -A INPUT -i $LANIF -p tcp --syn -m tcp --dport 80 -m state --state NEW -m recent --update --seconds 60 --hitcount 60 --name "limit-http" -j LOG --log-level "info" --log-prefix "[LIMIT_HTTP] "
	#iptables -A INPUT -i $LANIF -p tcp --syn -m tcp --dport 80 -m state --state NEW -j ACCEPT
#fi

# GARYeh 20120505: load firewall rule
/usr/local/bin/iptables_fw.sh init

# WNC Woody 2013-10-02 : load session limit rule (should load this rule after DoS rule)
/usr/local/bin/SessionLimit.sh init

# GARYeh 20120407: output ipv4 filter rule to FORWARD iptables
/usr/local/bin/filter.sh init

# GARYeh 20130121: add UPNP rule
/usr/local/bin/upnp_service.sh init

# GARYeh 20121225: add NAT rule to POSTROUTING iptables 
iptables -t nat -N NAT_SNAT
iptables -t nat -A POSTROUTING -j NAT_SNAT
iptables -t nat -A NAT_SNAT -o $EXTIF -j MASQUERADE
iptables -t nat -A NAT_SNAT -o $EXTIF2 -j MASQUERADE

# GARYeh 20120407: output port forward rule to PREROUTING iptables 
/usr/local/bin/forward.sh init

# GARYeh 20120601: add VPN rule
/usr/local/bin/vpn_method.sh init

# GARYeh 20121205: output ipv4 URL filter to FORWARD iptables
/usr/local/bin/urlfilter.sh init

# GARYeh 20121205: output ipv4 schedule rule to FORWARD iptables
/usr/local/bin/schedule_rule.sh init

# GARYeh 20120412: Add remote management default rule to iptables
/usr/local/bin/remmag.sh init

# GARYeh 201400213: workaround for fix upload issue in telenor network 
iptables -t mangle -I FORWARD -o usb0 ! -d 90.130.66.198/32 -p TCP -j TCPOPTSTRIP --strip-options sack-permitted
	
# WNC Woody 2012-10-23 : add QoS : START
/usr/local/bin/QosInit.sh init
# WNC Woody 2012-10-23 : add QoS : END

# GARYeh 20120527: add DMZ rule to PREROUTING iptables after adding port forward rule
/usr/local/bin/dmz.sh init

iptables -N fwInBypass
iptables -A INPUT -j fwInBypass
#iptables -A fwInBypass -i $LANIF -p udp --dport 67 -m limit --limit 10/s --limit-burst 10 -j ACCEPT
#iptables -A fwInBypass -i $LANIF -p udp --dport 67 -m limit --limit 1 -j LOG --log-prefix "[DHCPFlood] "
#iptables -A fwInBypass -i $LANIF -p udp --dport 67 -j DROP
iptables -A fwInBypass -i $LANIF -p tcp -m multiport --dports 22,23,80,8080,443,139,445 -j ACCEPT
iptables -A fwInBypass -i $LANIF -p udp -m multiport --dports 53,67,68,137,138,500,4500 -j ACCEPT

iptables -N fwCommonSvcs
iptables -A FORWARD -j fwCommonSvcs
iptables -A fwCommonSvcs -p tcp -m multiport --dports 80,443,110,995,143,220,993,23,25,465,21,1701,1723 -j ACCEPT
iptables -A fwCommonSvcs -p udp -m multiport --dports 53,110,995,143,220,993,1701,500,4500 -j ACCEPT

iptables -A INPUT -m state --state RELATED,ESTABLISH -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISH -j ACCEPT

iptables -N DEFAULT_POLICY
iptables -A INPUT -j DEFAULT_POLICY
iptables -A FORWARD -j DEFAULT_POLICY
if [ "$SECURITY" != "1" ]; then
	iptables -A DEFAULT_POLICY -i $LANIF -j ACCEPT
fi
