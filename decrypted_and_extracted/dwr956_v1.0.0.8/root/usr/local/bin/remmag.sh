#! /bin/sh
#set -x

echo "run script : regmag.sh"

if [ "_$1" = "_init" ];then
	echo "regmag init"
	EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`
	iptables -N REMMAG
	iptables -A INPUT -i $EXTIF -j REMMAG
	iptables -N Remote_TR69
	iptables -N Remote_VOIP
	iptables -N Remote_HTTP
	iptables -N Remote_TELNET
	iptables -N Remote_SSH
else
	logger -t [IPTABLES] -p local2.info regmag restart
fi


EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`

#TR69_EN=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable_TR69 from RmtMgrConfig;"`
#VOIP_EN=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable_VOIP from RmtMgrConfig;"`
#HTTP_EN=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable_HTTP from RmtMgrConfig;"`
#TELNET_EN=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable_TELNET from RmtMgrConfig;"`
#SSH_EN=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable_SSH from RmtMgrConfig;"`

echo 0 >/proc/sys/net/ipv4/ip_forward
# GARYeh 20120407: clear the CHAIN of REMMAG
iptables -F REMMAG
iptables -Z REMMAG

#tr69
iptables -F Remote_TR69
iptables -Z Remote_TR69
iptables -A REMMAG -j Remote_TR69
iptables -A Remote_TR69 -p tcp -s 146.172.4.0/23 --dport 7676 -j ACCEPT
iptables -A Remote_TR69 -p tcp -s 148.122.34.48/28 --dport 7676 -j ACCEPT
iptables -A Remote_TR69 -p tcp -m iprange --src-range 195.54.96.1-195.54.127.254 --dport 9000 -j ACCEPT
iptables -A Remote_TR69 -p tcp -m iprange --src-range 213.163.128.129-213.163.128.231 --dport 9000 -j ACCEPT
iptables -A Remote_TR69 -p tcp -m iprange --src-range 212.247.164.128-212.247.164.191 --dport 9000 -j ACCEPT
iptables -A Remote_TR69 -p tcp -m iprange --src-range 213.150.96.1-213.150.141.254 --dport 9000 -j ACCEPT
#if [ "$TR69_EN" = "1" ]; then
#	TR69_PORT=`grep "config.tr69Config\[1\]\[\"ConnectionRequestPort\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}'`
#	if [ -n "$TR69_PORT" ]; then
#		iptables -A REMMAG -p tcp --dport $TR69_PORT -j ACCEPT -m comment --comment "Enable access TR69"
#	else
#		iptables -A REMMAG -p tcp --dport 9000 -j ACCEPT -m comment --comment "Enable access TR69"
#	fi
#fi
	
#voip
iptables -F Remote_VOIP
iptables -Z Remote_VOIP
iptables -A REMMAG -j Remote_VOIP
#if [ "$VOIP_EN" = "1" ]; then
#	iptables -A REMMAG -p udp --dport 5060 -j ACCEPT -m comment --comment "Enable access VOIP"
#fi
	
#http
iptables -F Remote_HTTP
iptables -Z Remote_HTTP
iptables -A REMMAG -j Remote_HTTP
iptables -A Remote_HTTP -p tcp -m iprange --src-range 195.54.96.1-195.54.127.254 --dport 80 -j ACCEPT
iptables -A Remote_HTTP -p tcp -m iprange --src-range 213.163.128.129-213.163.128.231 --dport 80 -j ACCEPT
iptables -A Remote_HTTP -p tcp -m iprange --src-range 212.247.164.128-212.247.164.191 --dport 80 -j ACCEPT
iptables -A Remote_HTTP -p tcp -m iprange --src-range 213.150.96.1-213.150.141.254 --dport 80 -j ACCEPT
#if [ "$HTTP_EN" = "1" ]; then
#	iptables -A REMMAG -p tcp --dport 80 -j ACCEPT -m comment --comment "Enable access HTTP"
#fi
REMMAG_EN=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select accessMgmtEnable from accessMgmt;"`
if [ "$REMMAG_EN" = "1" ]; then
	REMMAG_ACTYPE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select accessType from accessMgmt;"`
	if [ "$REMMAG_ACTYPE" = "0" ]; then
		iptables -A Remote_HTTP -p tcp --dport 80 -j ACCEPT -m comment --comment "All IP access HTTP"
	fi
	if [ "$REMMAG_ACTYPE" = "1" ]; then
		REMMAGCOUNT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from ipRanges;"`
		if [ "$REMMAGCOUNT" -ne 0 ]; then
			i=1
			while [ $i -le $REMMAGCOUNT ]
			do
				STARTIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select startIP from ipRanges where _ROWID_='$i';"`
				ENDIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select endIP from ipRanges where _ROWID_='$i';"`
				
				iptables -A Remote_HTTP -p tcp -m iprange --src-range $STARTIP-$ENDIP --dport 80 -j ACCEPT -m comment --comment "IP Range access HTTP"
				
				i=`expr $i + 1`
			done
		fi
	fi
	if [ "$REMMAG_ACTYPE" = "2" ]; then
		REMMAGIP1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select accessMgmtIP1 from accessMgmt;"`
		iptables -A Remote_HTTP -p tcp -s $REMMAGIP1 --dport 80 -j ACCEPT -m comment --comment "One IP access HTTP"
	fi
fi
	
#telnet
iptables -F Remote_TELNET
iptables -Z Remote_TELNET
iptables -A REMMAG -j Remote_TELNET
iptables -A Remote_TELNET -p tcp -m iprange --src-range 195.54.96.1-195.54.127.254 --dport 23 -j ACCEPT
iptables -A Remote_TELNET -p tcp -m iprange --src-range 213.163.128.129-213.163.128.231 --dport 23 -j ACCEPT
iptables -A Remote_TELNET -p tcp -m iprange --src-range 212.247.164.128-212.247.164.191 --dport 23 -j ACCEPT
iptables -A Remote_TELNET -p tcp -m iprange --src-range 213.150.96.1-213.150.141.254 --dport 23 -j ACCEPT
#if [ "$TELNET_EN" = "1" ]; then
#	iptables -A REMMAG -p tcp --dport 23 -j ACCEPT -m comment --comment "Enable access TELNET"
#fi
	
#ssh
iptables -F Remote_SSH
iptables -Z Remote_SSH
iptables -A REMMAG -j Remote_SSH
iptables -A Remote_SSH -p tcp -m iprange --src-range 195.54.96.1-195.54.127.254 --dport 22 -j ACCEPT
iptables -A Remote_SSH -p tcp -m iprange --src-range 213.163.128.129-213.163.128.231 --dport 22 -j ACCEPT
iptables -A Remote_SSH -p tcp -m iprange --src-range 212.247.164.128-212.247.164.191 --dport 22 -j ACCEPT
iptables -A Remote_SSH -p tcp -m iprange --src-range 213.150.96.1-213.150.141.254 --dport 22 -j ACCEPT
#if [ "$SSH_EN" = "1" ]; then
#	iptables -A REMMAG -p tcp --dport 22 -j ACCEPT -m comment --comment "Enable access SSH"
#fi

if [ "$1" != "init" ]; then
	# clear all conntrack
	conntrack -F
fi
echo 1 >/proc/sys/net/ipv4/ip_forward
