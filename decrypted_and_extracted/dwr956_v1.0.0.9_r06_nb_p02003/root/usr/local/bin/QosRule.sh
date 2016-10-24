#! /bin/sh

echo "run script : QosRule.sh"

logger -t [IPTABLES] -p local2.info QosRule restart

CONFIG_FILE=/tmp/QoS/QoS_Rule

QOS_Enable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from QoS;"`

if [ "_$QOS_Enable" = "_1" ];then
	test -e $CONFIG_FILE && rm -f $CONFIG_FILE
	echo "Start to config QoS Rule"
	# downlink cmd
	mangle_ip_dl="iptables -t mangle -A QoS_DL -d"
	mangle_dscp_dl="iptables -t mangle -A QoS_DL -m dscp --dscp"

	#uplink cmd
	mangle_ip_ul="iptables -t mangle -A QoS_UL -s"
	mangle_dscp_ul="iptables -t mangle -A QoS_UL -m dscp --dscp"
	#mangle_if_ul="iptables -t mangle -A QoS_UL -o usb0"
	
	# iptables mark parameter
	mangle_mark_para="-j MARK --set-mark"

	COUNT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from QosRule;"`
	if [ "$COUNT" -ne 0 ]; then
		i=1
		while [ $i -le $COUNT ]
		do
			QOS_NAME=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Name from QosRule where _ROWID_='$i';"`
			QOS_PRIORITY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Priority from QosRule where _ROWID_='$i';"`
			QOS_RULE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Rule from QosRule where _ROWID_='$i';"`
			QOS_CONTENT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Content from QosRule where _ROWID_='$i';"`
			SERVICE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ServiceName from Services where ServiceName='$QOS_NAME';"`

			if [ "$SERVICE" != "" ]; then
				QOS_PORT_START=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DestinationPortStart from Services where ServiceName='$SERVICE';"`
				QOS_PORT_END=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DestinationPortEnd from Services where ServiceName='$SERVICE';"`
				QOS_PROTOCOL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Protocol from Services where ServiceName='$SERVICE';"`

				#downlink command
				if [ $QOS_RULE = "IP" ];then
					#downlink rule
					echo "$mangle_ip_dl $QOS_CONTENT -i usb0 -p $QOS_PROTOCOL --sport $QOS_PORT_START:$QOS_PORT_END $mangle_mark_para 1$QOS_PRIORITY" >> $CONFIG_FILE
					echo "$mangle_ip_dl $QOS_CONTENT -i usb0 -p $QOS_PROTOCOL --dport $QOS_PORT_START:$QOS_PORT_END $mangle_mark_para 1$QOS_PRIORITY" >> $CONFIG_FILE
					#uplink rule
					echo "$mangle_ip_ul $QOS_CONTENT -i br0 -p $QOS_PROTOCOL --sport $QOS_PORT_START:$QOS_PORT_END $mangle_mark_para 2$QOS_PRIORITY" >> $CONFIG_FILE
					echo "$mangle_ip_ul $QOS_CONTENT -i br0 -p $QOS_PROTOCOL --dport $QOS_PORT_START:$QOS_PORT_END $mangle_mark_para 2$QOS_PRIORITY" >> $CONFIG_FILE
				elif [ $QOS_RULE = "DSCP" ]; then
					#downlink rule
					echo "$mangle_dscp_dl $QOS_CONTENT -i usb0 -p $QOS_PROTOCOL --sport $QOS_PORT_START:$QOS_PORT_END $mangle_mark_para 1$QOS_PRIORITY" >> $CONFIG_FILE
					echo "$mangle_dscp_dl $QOS_CONTENT -i usb0 -p $QOS_PROTOCOL --dport $QOS_PORT_START:$QOS_PORT_END $mangle_mark_para 1$QOS_PRIORITY" >> $CONFIG_FILE
					#uplink rule
					echo "$mangle_dscp_ul $QOS_CONTENT -i br0 -p $QOS_PROTOCOL --sport $QOS_PORT_START:$QOS_PORT_END $mangle_mark_para 2$QOS_PRIORITY" >> $CONFIG_FILE
					echo "$mangle_dscp_ul $QOS_CONTENT -i br0 -p $QOS_PROTOCOL --dport $QOS_PORT_START:$QOS_PORT_END $mangle_mark_para 2$QOS_PRIORITY" >> $CONFIG_FILE
				else
					echo "Unknow QoS Rule : $QOS_RULE !!"
				fi				

			else
				echo "No service to create QoS rule!!!"
			fi
				i=`expr $i + 1`
		done
		
		#uplink command
		#echo "$mangle_if_ul $mangle_mark_para 21" >> $CONFIG_FILE
		
		iptables -t mangle -F QoS_UL
		iptables -t mangle -F QoS_DL
		chmod +x $CONFIG_FILE
		$CONFIG_FILE		
	fi
else
	iptables -t mangle -F QoS_UL
	iptables -t mangle -F QoS_DL
fi
