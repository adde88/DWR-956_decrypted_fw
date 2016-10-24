#! /bin/sh

echo "run script : iptables_fw.sh"

if [ "_$1" = "_init" ];then
	echo "iptables_fw init"
else
	logger -t [IPTABLES] -p local2.info iptables_fw restart
fi

EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`
LANIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LAN1';"`

# Turn on reverse path filtering. This helps make sure that packets use
# legitimate source addresses, by automatically rejecting incoming packets
# if the routing table entry for their source address doesn't match the network
# interface they're arriving on. This has security advantages because it prevents
# so-called IP spoofing, however it can pose problems if you use asymmetric routing
# (packets from you to a host take a different path than packets from that host to you)
# or if you operate a non-routing host which has several IP addresses on different
# interfaces. (Note - If you turn on IP forwarding, you will also get this).
for interface in /proc/sys/net/ipv4/conf/*/rp_filter; do
	echo 1 > ${interface}
done

#Don't accept or send ICMP redirects. 
for interface in /proc/sys/net/ipv4/conf/*/accept_redirects; do 
	echo 0 > ${interface} 
done

for interface in /proc/sys/net/ipv4/conf/*/send_redirects; do 
	echo 0 > ${interface}
done 

# Don't accept source routed packets.
for interface in /proc/sys/net/ipv4/conf/*/accept_source_route; 
	do echo 0 > ${interface} 
done

# Do not reply to 'proxyarp' packets
#for interface in /proc/sys/net/ipv4/conf/*/proxy_arp;
#	do echo 0 > ${interface}
#done

#for interface in /proc/sys/net/ipv4/conf/*/secure_redirects;
#	do echo 1 > ${interface}
#done

# Log packets with impossible addresses.
#for interface in /proc/sys/net/ipv4/conf/*/log_martians;
#	do echo 1 > ${interface}
#done

# Don't log invalid responses to broadcast
echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses

# Disable bootp_relay
#for interface in /proc/sys/net/ipv4/conf/*/bootp_relay;
#	do echo 0 > ${interface}
#done

# GARYeh 20120526: enable syn cookie protect
#echo 1 > /proc/sys/net/ipv4/tcp_syncookies
echo 1 > /proc/sys/net/ipv4/tcp_syn_retries 
echo 3 > /proc/sys/net/ipv4/tcp_synack_retries 
echo 2048 > /proc/sys/net/ipv4/tcp_max_syn_backlog 
echo 180000 > /proc/sys/net/ipv4/tcp_max_tw_buckets 
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse 
echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle 
# reduce TCP CLOSE_WAIT
echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout
echo 600 > /proc/sys/net/ipv4/tcp_keepalive_time
echo 3 > /proc/sys/net/ipv4/tcp_keepalive_probes 
echo 30 > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo 5 > /proc/sys/net/ipv4/tcp_retries2 
echo 0 > /proc/sys/net/ipv4/tcp_timestamps 
echo 1 > /proc/sys/net/ipv4/tcp_sack
echo 1 > /proc/sys/net/ipv4/tcp_window_scaling
echo 100 > /proc/sys/net/ipv4/route/gc_timeout 
echo 2 > /proc/sys/net/ipv4/route/gc_elasticity 

#echo 120 > /proc/sys/net/ipv4/netfilter/ip_conntrack_udp_timeout 30

# treat reset close session as fin close session, set same timeout
# this is required to pass CDRouter NAT timeout test case.
#echo 120 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_close 10

# add this to support up to 20 PPTP tunnel
#echo 40 > /proc/sys/net/netfilter/nf_conntrack_expect_max 64

# GARYeh 20120521: add ip_conntrack_tcp_timeout_established to 600 for fixing p2p issue
echo 600 > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established
echo 32768 > /proc/sys/net/ipv4/route/max_size
echo 65536 > /proc/sys/net/ipv4/netfilter/ip_conntrack_max

#echo 65536 > /proc/sys/fs/file-max
#echo "1024 65000" > /proc/sys/net/ipv4/ip_local_port_range
#echo 256960 > /proc/sys/net/core/rmem_default
#echo 513920 > /proc/sys/net/core/rmem_max
#echo 256960 > /proc/sys/net/core/wmem_default
#echo 513920 > /proc/sys/net/core/wmem_max
#echo "8760 256960 4088000" > /proc/sys/net/ipv4/tcp_wmem
#echo "8760 256960 4088000" > /proc/sys/net/ipv4/tcp_rmem
#echo "131072 262144 524288" > /proc/sys/net/ipv4/tcp_mem
#echo 2048 > /proc/sys/net/core/netdev_max_backlog
#echo 2048 > /proc/sys/net/core/somaxconn

# Set dynamic ip
echo 2 > /proc/sys/net/ipv4/ip_dynaddr

#port scan 
#iptables -A input -p all -m state --state ESTABLISHED, RELATED -j ACCEPT
#iptables -A input -p all -m state --state NEW -m recent --name port_scan --update --seconds 1800 --hitcount 10 -j DROP
#iptables -A input -p tcp --syn -m state --state NEW -m multiport --dport 22,80 -j ACCEPT
#iptables -A input -p all --syn -m recent --name port_scan --set

#virus
#iptables -A FORWARD -i br0 -o usb0 -p all -m state --state NEW -m recent --name virus --update --seconds 60 --hitcount 120 -j REJECT
#iptables -A FORWARD -i br0 -o usb0 -p all -m state --state NEW -m recent --name virus --set

iptables -N FWFlood
iptables -N FW_SYN_FLOOD_LAN
iptables -N FW_SYN_FLOOD_WAN
iptables -A FWFlood -i $LANIF -p tcp --tcp-flags FIN,SYN,RST,ACK SYN -j FW_SYN_FLOOD_LAN
iptables -A FWFlood -i $EXTIF -p tcp --tcp-flags FIN,SYN,RST,ACK SYN -j FW_SYN_FLOOD_WAN
iptables -N FW_FIN_FLOOD_LAN
iptables -N FW_FIN_FLOOD_WAN
iptables -A FWFlood -i $LANIF -p tcp --tcp-flags FIN,SYN,RST,ACK FIN -j FW_FIN_FLOOD_LAN
iptables -A FWFlood -i $EXTIF -p tcp --tcp-flags FIN,SYN,RST,ACK FIN -j FW_FIN_FLOOD_WAN
iptables -N FW_ICMP_FLOOD
iptables -N FW_ICMP_PING_FLOOD
iptables -A FWFlood -p icmp --icmp-type 8 -j FW_ICMP_PING_FLOOD
iptables -A FWFlood -j FW_ICMP_FLOOD
iptables -A INPUT -j FWFlood
iptables -A FORWARD -j FWFlood

# fix limit to 128 for lan SYNFLOOD
iptables -A FW_SYN_FLOOD_LAN -m limit --limit 128/s --limit-burst 128 -j RETURN
iptables -A FW_SYN_FLOOD_LAN -m limit --limit 1/s --limit-burst 3 -j LOG --log-level "info" --log-prefix "[SYNFLOOD_LAN] "
iptables -A FW_SYN_FLOOD_LAN -j DROP

# fix limit to 128 for lan FINFLOOD
iptables -A FW_FIN_FLOOD_LAN -m limit --limit 128/s --limit-burst 128 -j RETURN
iptables -A FW_FIN_FLOOD_LAN -m limit --limit 1/s --limit-burst 3 -j LOG --log-level "info" --log-prefix "[FINFLOOD_LAN] "
iptables -A FW_FIN_FLOOD_LAN -j DROP

#iptables -t raw -N ANTI_IP_SPOOFING
#iptables -t raw -A PREROUTING -j ANTI_IP_SPOOFING

iptables -N SPI
iptables -A FORWARD -j SPI

/usr/local/bin/firewall_rule.sh init


iptables -N FWInFlood

### state tracking rules
iptables -N FWInvalidState
iptables -A FWInvalidState -m state --state INVALID -j DROPLOG
iptables -A FWInvalidState -p tcp ! --syn -m state --state NEW -j DROPLOG
#iptables -A FWInvalidState -i $EXTIF -p tcp --syn -m multiport ! --dports 80,23,22 -m state --state NEW -j DROPLOG
iptables -A FWInvalidState -m state --state NEW -p tcp --tcp-flags ALL ALL -j DROPLOG 
iptables -A FWInvalidState -m state --state NEW -p tcp --tcp-flags ALL NONE -j DROPLOG
iptables -A FWInvalidState -p icmp --fragment -j DROPLOG
iptables -A FWInFlood -j FWInvalidState


iptables -N FWInvalidFlags
# Make sure NEW tcp connections are SYN packets
iptables -A FWInvalidFlags -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,PSH,URG -j DROPLOG
iptables -A FWInvalidFlags -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,SYN,RST,PSH,ACK,URG -j DROPLOG
iptables -A FWInvalidFlags -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,SYN,RST,ACK,URG -j DROPLOG
iptables -A FWInvalidFlags -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROPLOG
iptables -A FWInvalidFlags -p tcp --tcp-flags SYN,RST SYN,RST -j DROPLOG
iptables -A FWInvalidFlags -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROPLOG
iptables -A FWInvalidFlags -p tcp --tcp-flags ALL FIN -j DROPLOG 
iptables -A FWInFlood -j FWInvalidFlags


iptables -A INPUT -j FWInFlood
