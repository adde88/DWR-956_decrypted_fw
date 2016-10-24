#!/bin/sh

echo "run script : QosInit.sh"

init=`iptables -t mangle -L | grep QoS_DL | awk 'NR==1' | awk '{print $1}'`

if [ "_$init" = "_QoS_DL" ]; then
echo "QoS_DL and QoS_UL chain exist, exit..."
exit 0
fi

iptables -t mangle -N QoS_UL
iptables -t mangle -N QoS_DL
iptables -t mangle -A FORWARD -j QoS_UL
iptables -t mangle -A FORWARD -j QoS_DL

test -d /tmp/QoS && echo QoS_Folder_Exist || mkdir /tmp/QoS

QoS_Enable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from QoS;"`

if [ $QoS_Enable = "1" ];then
	echo "QoS Enable : run QosPolicy.sh"
	QosPolicy.sh

	echo "QoS Enable : run QosRule.sh"
	QosRule.sh
fi
