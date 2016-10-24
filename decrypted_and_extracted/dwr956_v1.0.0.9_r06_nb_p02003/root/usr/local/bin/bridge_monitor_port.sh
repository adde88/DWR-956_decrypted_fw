#!/bin/sh

if [ -e /tmp/rcdialup_lock_usb0 ]; then
	echo "Monitor bridge device: dialup is running!"
	return
fi

dev_num=0
if [ `switch_cli IFX_ETHSW_PORT_LINK_CFG_GET nPortId=0 |grep eLink | awk '{print $2}'` == 0 ];then
	dev_num=`expr $dev_num + 1`
fi
if [ `switch_cli IFX_ETHSW_PORT_LINK_CFG_GET nPortId=1 |grep eLink | awk '{print $2}'` == 0 ];then
	dev_num=`expr $dev_num + 1`
fi
if [ `switch_cli IFX_ETHSW_PORT_LINK_CFG_GET nPortId=2 |grep eLink | awk '{print $2}'` == 0 ];then
	dev_num=`expr $dev_num + 1`
fi
if [ `switch_cli IFX_ETHSW_PORT_LINK_CFG_GET nPortId=4 |grep eLink | awk '{print $2}'` == 0 ];then
	dev_num=`expr $dev_num + 1`
fi

if [ -f /tmp/bridge_dev_old ];then
	old_dev_num=`cat /tmp/bridge_dev_old`
	if [ "$old_dev_num" = "reconnect" ];then
		echo "Monitor bridge device is reconnectting..."
		return
	fi
	
	if [ "$old_dev_num" = "0" -a "$dev_num" = "1" ];then
		echo "Monitor bridge device change and lte need reconnect..."
		echo "reconnect" > /tmp/bridge_dev_old
		
		lte_set -d -q 0
		
		lte_status=`lte_get --ip-status | grep "CLIENT:status:" | sed 's/^.*status://g'`
		while [ "$lte_status" != "no connection"  ]; do
			echo "Monitor bridge device change and lte wait disconnect..."
			sleep 1
			lte_status=`lte_get --ip-status | grep "CLIENT:status:" | sed 's/^.*status://g'`
		done
		
		lte_set -q 0 -c -1
		rm -f /tmp/bridge_dev_old
	else	
		echo $dev_num > /tmp/bridge_dev_old
	fi

else 	
	if [ "$dev_num" = "0" ];then
		return
	else
		echo $dev_num > /tmp/bridge_dev_old
	fi
fi
