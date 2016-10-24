#! /bin/sh

echo "run script : QosPolicy.sh"

logger -t [IPTABLES] -p local2.info QosPolicy restart

CONFIG_FILE=/tmp/QoS/QoS_Policy
QOS_Enable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from QoS;"`

if [ "_$QOS_Enable" = "_1" ];then

# Read config values from DB
	QOS_THROUGHPUT_DL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DL_Total from QoS;"`
	QOS_HIGHEST_DL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DL_Highest from QoS;"`
	QOS_HIGH_DL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DL_High from QoS;"`
	QOS_NORMAL_DL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DL_Nornmal from QoS;"`
	QOS_LOW_DL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select DL_Low from QoS;"`
	QOS_THROUGHPUT_UL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select UL_Total from QoS;"`
	QOS_HIGHEST_UL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select UL_Highest from QoS;"`
	QOS_HIGH_UL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select UL_High from QoS;"`
	QOS_NORMAL_UL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select UL_Nornmal from QoS;"`
	QOS_LOW_UL=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select UL_Low from QoS;"`
	QOS_DEFAULT=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Default_Priority from QoS;"`

# Calculate values for tc rules
	DL_RATE_HIGHEST=$(($QOS_THROUGHPUT_DL*40/100))
	DL_RATE_HIGH=$(($QOS_THROUGHPUT_DL*30/100))
	DL_RATE_NORMAL=$(($QOS_THROUGHPUT_DL*20/100))
	DL_RATE_LOW=$(($QOS_THROUGHPUT_DL*10/100))

	UL_RATE_HIGHEST=$(($QOS_THROUGHPUT_UL*40/100))
	UL_RATE_HIGH=$(($QOS_THROUGHPUT_UL*30/100))
	UL_RATE_NORMAL=$(($QOS_THROUGHPUT_UL*20/100))
	UL_RATE_LOW=$(($QOS_THROUGHPUT_UL*10/100))

	DL_CBURST_THROUGHPUT=$(($QOS_THROUGHPUT_DL*2+500))
	DL_CBURST_HIGHEST=$(($QOS_HIGHEST_DL*2+500))
	DL_CBURST_HIGH=$(($QOS_HIGH_DL*2+500))
	DL_CBURST_NORMAL=$(($QOS_NORMAL_DL*2+500))
	DL_CBURST_LOW=$(($QOS_LOW_DL*2+500))

	UL_CBURST_THROUGHPUT=$(($QOS_THROUGHPUT_UL*2+500))
	UL_CBURST_HIGHEST=$(($QOS_HIGHEST_UL*2+500))
	UL_CBURST_HIGH=$(($QOS_HIGH_UL*2+500))
	UL_CBURST_NORMAL=$(($QOS_NORMAL_UL*2+500))
	UL_CBURST_LOW=$(($QOS_LOW_UL*2+500))


	if [ $DL_RATE_HIGHEST -gt $QOS_HIGHEST_DL ]; then
		DL_RATE_HIGHEST=$QOS_HIGHEST_DL
	fi

	if [ $DL_RATE_HIGH -gt $QOS_HIGH_DL ]; then
		DL_RATE_HIGH=$QOS_HIGH_DL
	fi

	if [ $DL_RATE_NORMAL -gt $QOS_NORMAL_DL ]; then
		DL_RATE_NORMAL=$QOS_NORMAL_DL
	fi

	if [ $DL_RATE_LOW -gt $QOS_LOW_DL ]; then
		DL_RATE_LOW=$QOS_LOW_DL
	fi

	if [ $UL_RATE_HIGHEST -gt $QOS_HIGHEST_UL ]; then
		UL_RATE_HIGHEST=$QOS_HIGHEST_UL
	fi

	if [ $UL_RATE_HIGH -gt $QOS_HIGH_UL ]; then
		UL_RATE_HIGH=$QOS_HIGH_UL
	fi

	if [ $UL_RATE_NORMAL -gt $QOS_NORMAL_UL ]; then
		UL_RATE_NORMAL=$QOS_NORMAL_UL
	fi

	if [ $UL_RATE_LOW -gt $QOS_LOW_UL ]; then
		UL_RATE_LOW=$QOS_LOW_UL
	fi


	echo "QOS_Enable=Enable"
	test -e $CONFIG_FILE && rm -f $CONFIG_FILE
	
	echo "Disable PPA"
	ppacmd control --disable-lan --disable-wan
	
# Configure DownLink Traffic Rules to /tmp/QoS/QoS_Policy
	echo "tc qdisc del dev br0 root 2>/dev/null" > $CONFIG_FILE
	echo "tc qdisc add dev br0 root handle 10: htb default "$QOS_DEFAULT"0" >> $CONFIG_FILE
	echo "tc class add dev br0 parent 10: classid 10:1 htb rate "$QOS_THROUGHPUT_DL"kbps ceil "$QOS_THROUGHPUT_DL"kbps cburst "$DL_CBURST_THROUGHPUT"kbit" >> $CONFIG_FILE
	echo "tc class add dev br0 parent 10:1 classid 10:10 htb rate "$DL_RATE_HIGHEST"kbps ceil "$QOS_HIGHEST_DL"kbps prio 100 cburst "$DL_CBURST_HIGHEST"kbit" >> $CONFIG_FILE
	echo "tc class add dev br0 parent 10:1 classid 10:20 htb rate "$DL_RATE_HIGH"kbps ceil "$QOS_HIGH_DL"kbps prio 100 cburst "$DL_CBURST_HIGH"kbit" >> $CONFIG_FILE
	echo "tc class add dev br0 parent 10:1 classid 10:30 htb rate "$DL_RATE_NORMAL"kbps ceil "$QOS_NORMAL_DL"kbps prio 100 cburst "$DL_CBURST_NORMAL"kbit" >> $CONFIG_FILE
	echo "tc class add dev br0 parent 10:1 classid 10:40 htb rate "$DL_RATE_LOW"kbps ceil "$QOS_LOW_DL"kbps prio 100 cburst "$DL_CBURST_LOW"kbit" >> $CONFIG_FILE
	echo "tc qdisc add dev br0 parent 10:10 handle 101: pfifo" >> $CONFIG_FILE
	echo "tc qdisc add dev br0 parent 10:20 handle 102: pfifo" >> $CONFIG_FILE
	echo "tc qdisc add dev br0 parent 10:30 handle 103: pfifo" >> $CONFIG_FILE
	echo "tc qdisc add dev br0 parent 10:40 handle 104: pfifo" >> $CONFIG_FILE
	echo "tc filter add dev br0 parent 10: protocol ip prio 100 handle 11 fw classid 10:10" >> $CONFIG_FILE
	echo "tc filter add dev br0 parent 10: protocol ip prio 100 handle 12 fw classid 10:20" >> $CONFIG_FILE
	echo "tc filter add dev br0 parent 10: protocol ip prio 100 handle 13 fw classid 10:30" >> $CONFIG_FILE
	echo "tc filter add dev br0 parent 10: protocol ip prio 100 handle 14 fw classid 10:40" >> $CONFIG_FILE

# Configure 3G/4G UpLink Traffic Rules to /tmp/QoS/QoS_Policy
	echo "tc qdisc del dev usb0 root 2>/dev/null" >> $CONFIG_FILE
	echo "tc qdisc add dev usb0 root handle 11: htb default "$QOS_DEFAULT"0" >> $CONFIG_FILE
	echo "tc class add dev usb0 parent 11: classid 11:1 htb rate "$QOS_THROUGHPUT_UL"kbps ceil "$QOS_THROUGHPUT_UL"kbps cburst "$UL_CBURST_THROUGHPUT"kbit" >> $CONFIG_FILE
	echo "tc class add dev usb0 parent 11:1 classid 11:10 htb rate "$UL_RATE_HIGHEST"kbps ceil "$QOS_HIGHEST_UL"kbps prio 100 cburst "$UL_CBURST_HIGHEST"kbit" >> $CONFIG_FILE
	echo "tc class add dev usb0 parent 11:1 classid 11:20 htb rate "$UL_RATE_HIGH"kbps ceil "$QOS_HIGH_UL"kbps prio 100 cburst "$UL_CBURST_HIGH"kbit" >> $CONFIG_FILE
	echo "tc class add dev usb0 parent 11:1 classid 11:30 htb rate "$UL_RATE_NORMAL"kbps ceil "$QOS_NORMAL_UL"kbps prio 100 cburst "$UL_CBURST_NORMAL"kbit" >> $CONFIG_FILE
	echo "tc class add dev usb0 parent 11:1 classid 11:40 htb rate "$UL_RATE_LOW"kbps ceil "$QOS_LOW_UL"kbps prio 100 cburst "$UL_CBURST_LOW"kbit" >> $CONFIG_FILE

	echo "tc qdisc add dev usb0 parent 11:10 handle 201: pfifo" >> $CONFIG_FILE
	echo "tc qdisc add dev usb0 parent 11:20 handle 202: pfifo" >> $CONFIG_FILE
	echo "tc qdisc add dev usb0 parent 11:30 handle 203: pfifo" >> $CONFIG_FILE
	echo "tc qdisc add dev usb0 parent 11:40 handle 204: pfifo" >> $CONFIG_FILE
	echo "tc filter add dev usb0 parent 11: protocol ip prio 100 handle 21 fw classid 11:10" >> $CONFIG_FILE
	echo "tc filter add dev usb0 parent 11: protocol ip prio 100 handle 22 fw classid 11:20" >> $CONFIG_FILE
	echo "tc filter add dev usb0 parent 11: protocol ip prio 100 handle 23 fw classid 11:30" >> $CONFIG_FILE
	echo "tc filter add dev usb0 parent 11: protocol ip prio 100 handle 24 fw classid 11:40" >> $CONFIG_FILE

	chmod +x $CONFIG_FILE
	$CONFIG_FILE

else

	echo "QOS_Enable=Disable"
	test -e $CONFIG_FILE && rm -f $CONFIG_FILE
	
	SchedulesEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EnableProfiles from UrlFltrConfig;"`
	if [ $SchedulesEnable = "0" ];then
		echo "Enable PPA"
		ppacmd control --enable-lan --enable-wan
	fi
	
# Erase DownLink Traffic Rules
	tc qdisc del dev br0 root 2>/dev/null
	
# Erase Uplink Traffic Rules
	tc qdisc del dev usb0 root 2>/dev/null
fi

