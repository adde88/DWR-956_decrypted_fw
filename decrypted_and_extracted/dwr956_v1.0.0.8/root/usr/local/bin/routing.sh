#!/bin/sh
#static routing

#killall -9 zebra

STATICRT_RULE=/tmp/staticrt_rule
RIPD_CONFIG_FILE=/tmp/ripd.conf

NAME=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select name from system;"`
SRENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select StaticRoutingEnable from RoutingConfig;"`
DRENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DynamicRoutingEnable from RoutingConfig;"`
EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`
LANIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LAN1';"`

if [ -e $STATICRT_RULE ];then
	# GARYeh 20120420: clear static routing table
	cat $STATICRT_RULE | while read line
	do
		echo $line | grep "route"
		if [ $? == 0 ];then
			delete=`echo $line | sed 's/add/del/g' | sed 's/ gw_index.*$//g'`
			`$delete`
		fi
	done 
fi
rm -f $STATICRT_RULE

if [ "$SRENABLE" = "0" ]; then
	if [ "$DRENABLE" = "0" ]; then
		return 0
	fi
fi

#For static routing
if [ "$SRENABLE" = "1" ]; then
	SRCOUNT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from StaticRoute;"`
	if [ "$SRCOUNT" -ne 0 ]; then
		i=1
		while [ $i -le $SRCOUNT ]
		do
			SREN=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from StaticRoute where _ROWID_='$i';"`
			if [ "$SREN" = "1" ]; then
				DIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DestineNetwork from StaticRoute where _ROWID_='$i';"`
				DMASK=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DestineNetmask from StaticRoute where _ROWID_='$i';"`
				NETWORK=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Local from StaticRoute where _ROWID_='$i';"`
				GW=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select LocalGateway from StaticRoute where _ROWID_='$i';"`

				if [ $DMASK = "255.255.255.255" ];then
					add_route="route add -host "
				else
					add_route="route add -net "
				fi
				
				DestNET=`ipcalc.sh $DIP $DMASK | grep NETWORK |sed 's/^.*NETWORK=//g'`
				DestMASK=`ipcalc.sh $DIP $DMASK | grep PREFIX |sed 's/^.*PREFIX=//g'`
				
				dest_net="$DestNET/$DestMASK "
				
				if [ $NETWORK = "Default" ];then
					interface="dev $LANIF "
				else
					interface="dev $EXTIF "
				fi
				
				if [ -z $GW ];then
					gw=""
				else
					gw="gw $GW "
				fi
				
				routerule=$add_route$dest_net$interface$gw
				
				echo "$routerule" >> $STATICRT_RULE
			fi
			i=`expr $i + 1`
		done	
	fi
	
	if [ -e $STATICRT_RULE ];then
	# GARYeh 20120420: clear static routing table
		cat $STATICRT_RULE | while read line
		do
			echo $line | grep "route"
			if [ $? == 0 ];then
				`$line`
			fi
		done 
	fi
fi


if [ !-z `pidof ripd` ]; then
	killall -9 ripd
fi

#For dynamic routing
if [ "$DRENABLE" = "1" ]; then
	rm -f $RIPD_CONFIG_FILE
	# create ripd.conf
	echo "hostname $NAME" > $RIPD_CONFIG_FILE
	echo "password ripd" >> $RIPD_CONFIG_FILE
	echo "interface $LANIF" >> $RIPD_CONFIG_FILE
	echo "interface $EXTIF" >> $RIPD_CONFIG_FILE	
	echo "router rip" >> $RIPD_CONFIG_FILE
	echo " network $LANIF" >> $RIPD_CONFIG_FILE
	echo " network $EXTIF" >> $RIPD_CONFIG_FILE

	if [ $DRENABLE = "2" ];then
		echo " version 1" >> $RIPD_CONFIG_FILE
	fi
	if [ $DRENABLE = "2" ];then
		echo " version 2" >> $RIPD_CONFIG_FILE
	fi
	#echo "interface $EXTIF" >> $RIPD_CONFIG_FILE
	#echo " no ip rip authentication mode" >> $RIPD_CONFIG_FILE
	echo "log syslog" >> $RIPD_CONFIG_FILE
	
	ripd -f $RIPD_CONFIG_FILE -d -i /tmp/ripd.pid
fi

if [ "$1" != "init" ]; then
	# clear all conntrack
	conntrack -F
fi
