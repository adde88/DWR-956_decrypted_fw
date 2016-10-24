#! /bin/sh
#set -x

echo "run script : vpn_method.sh"

if [ "_$1" = "_init" ];then
	echo "vpn_method init"
	iptables -N VPN_PT
	iptables -A FORWARD -j VPN_PT
else
	logger -t [IPTABLES] -p local2.info vpn_method restart
fi

echo 0 > /proc/sys/net/ipv4/ip_forward
# GARYeh 20120423: clear nat table to avoid save network rule
iptables -F VPN_PT
iptables -Z VPN_PT

iptables -A VPN_PT -p 47 -j ACCEPT -m comment --comment "PPTP_PT GRE"
iptables -A VPN_PT -p tcp --dport 1723:1723 -j ACCEPT -m comment --comment "PPTP_PT PPTP"

iptables -A VPN_PT -p udp --dport 1701:1701 -j ACCEPT -m comment --comment "L2TP_PT L2TP"

iptables -A VPN_PT -p udp --dport 500:500 -j ACCEPT -m comment --comment "IPSEC_PT IKE"
iptables -A VPN_PT -p 51 -j ACCEPT -m comment --comment "IPSEC_PT AH"
iptables -A VPN_PT -p 50 -j ACCEPT -m comment --comment "IPSEC_PT ESP"
iptables -A VPN_PT -p udp --dport 4500:4500 -j ACCEPT -m comment --comment "IPSEC_PT NAT-T ESP"

iptables -A VPN_PT -p udp --dport 443:443 -j ACCEPT -m comment --comment "SSL_PT SSL"

echo 1 >/proc/sys/net/ipv4/ip_forward
