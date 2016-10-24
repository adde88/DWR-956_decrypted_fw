#!/bin/sh
NATENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from FirewallNatConfig;"`

if [ "$NATENABLE" = "1" ]; then
	LANIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ipaddr from networkInterface where LogicalIfName = 'LAN1';"`
	SUBNET=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select subnetmask from networkInterface where LogicalIfName = 'LAN1';"`
	INTERFACE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LAN1';"`
	WANINTERFACE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`
	WANINTERFACE2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN2';"`

	echo "*nat" > /tmp/nat.txt
	echo ":PREROUTING ACCEPT [0:0]" >> /tmp/nat.txt
	echo ":PORTFPRWARD - [0:0]" >> /tmp/nat.txt
	echo ":UPNP - [0:0]" >> /tmp/nat.txt
	echo ":DMZ - [0:0]" >> /tmp/nat.txt
	echo ":OUTPUT ACCEPT [0:0]" >> /tmp/nat.txt
	echo ":POSTROUTING ACCEPT [0:0]" >> /tmp/nat.txt
	echo "-A POSTROUTING -o $WANINTERFACE -j MASQUERADE" >> /tmp/nat.txt
	echo "-A POSTROUTING -o $WANINTERFACE2 -j MASQUERADE" >> /tmp/nat.txt
	#echo "-A POSTROUTING -o $INTERFACE -s $LANIP/$SUBNET -d $LANIP/$SUBNET -j MASQUERADE" >> /tmp/nat.txt
	echo "-A POSTROUTING -o lo -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT" >> /tmp/nat.txt
	#port forwarding
	PFENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select PortForwardingEnable from FirewallNatConfig;"`
	if [ "$PFENABLE" = "1" ]; then
		PFCOUNT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from PortForwarding;"`
		if [ "$PFCOUNT" -ne 0 ]; then
			i=1
			echo "-A PREROUTING -j PORTFPRWARD" >> /tmp/nat.txt
			while [ $i -le $PFCOUNT ]
			do
				PFEN=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from PortForwarding where _ROWID_='$i';"`
				if [ "$PFEN" = "1" ]; then
					IP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Ip from PortForwarding where _ROWID_='$i';"`
					PROTOCOL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Protocol from PortForwarding where _ROWID_='$i';"`
					PORTRANGE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select portRange from PortForwarding where _ROWID_='$i';"`
					if [ $PROTOCOL = "both" ]; then
						echo "-A PORTFPRWARD -i $WANINTERFACE -p tcp --dport $PORTRANGE -j DNAT --to $IP" >> /tmp/nat.txt
						echo "-A PORTFPRWARD -i $WANINTERFACE -p udp --dport $PORTRANGE -j DNAT --to $IP" >> /tmp/nat.txt
					else
						echo "-A PORTFPRWARD -i $WANINTERFACE -p $PROTOCOL --dport $PORTRANGE -j DNAT --to $IP" >> /tmp/nat.txt
					fi
				fi
					i=`expr $i + 1`
			done
		fi
	fi
	#dmz host
	DMZENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from FirewallDmz;"`
	if [ "$DMZENABLE" = "1" ]; then
		echo "-A PREROUTING -j DMZ" >> /tmp/nat.txt
		DMZIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DmzIpAddress from FirewallDmz;"`
		echo "-A DMZ -i $WANINTERFACE -j DNAT --to $DMZIP" >> /tmp/nat.txt
	fi
	
	# Add UPNP
	echo "-A PREROUTING -i usb0 -j UPNP" >> /tmp/nat.txt

	echo "COMMIT" >> /tmp/nat.txt
		
elif [ "$NATENABLE" = "5" ]; then #bridge mode
	INTERFACE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LAN1';"`
	LANIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ipaddr from networkInterface where LogicalIfName = 'LAN1';"`
	SUBNET=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select subnetmask from networkInterface where LogicalIfName = 'LAN1';"`
	
	echo "*nat" > /tmp/nat.txt
	echo ":PREROUTING ACCEPT [0:0]" >> /tmp/nat.txt
	echo ":OUTPUT ACCEPT [0:0]" >> /tmp/nat.txt
	echo ":POSTROUTING ACCEPT [0:0]" >> /tmp/nat.txt
	echo "-A POSTROUTING -o $INTERFACE -s $LANIP/$SUBNET -d $LANIP/$SUBNET -j MASQUERADE" >> /tmp/nat.txt
	echo "-A POSTROUTING -o lo -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT" >> /tmp/nat.txt
	echo "COMMIT" >> /tmp/nat.txt  
fi
iptables-restore < /tmp/nat.txt

conntrack -D
