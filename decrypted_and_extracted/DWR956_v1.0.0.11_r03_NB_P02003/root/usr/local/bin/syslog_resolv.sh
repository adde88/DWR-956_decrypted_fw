#!/bin/sh

fall_back=`cat /mnt/data/lte_connection_settings |  cut -c 7`
if [ "_$fall_back" = "_0" ] 	
then
	return
fi

while [ -z "$USB1_IP" ]
do	
	USB1_IP=`ifconfig usb1 | grep "inet addr" | cut -d: -f2 | awk -F" " '{print $1}'`
    if [ -z "$USB1_IP" ] ; then
		sleep 5
	    continue
	else
	    if [ ! -f /tmp/usb1_IP  ]; then
			echo -n "$USB1_IP" > /tmp/usb1_IP
		fi
		USB1_IP_OLD=`cat /tmp/usb1_IP`
    fi
done

Retry=0
while [ -z "$DNS1" -a $Retry -lt 3 ]
do
	if [ -n "$1" -a -n "$2" ] ; then
		DNS1="$1"
		DNS2="$2"
	else
		DNS1=`/usr/local/bin/lte_get -q 1 --ip --timeout 0 | grep "CLIENT:primary DNS" | cut -d: -f3`
		DNS2=`/usr/local/bin/lte_get -q 1 --ip --timeout 0 | grep "CLIENT:secondary DNS" | cut -d: -f3`
	fi
    [ "$DNS1" = "0.0.0.0" ] && DNS1=''
	if [ -z "$DNS1" ] ; then
	    sleep 1
		Retry=$(( $Retry + 1 ))
	fi
done
if [ -z "$DNS1" ] ; then
    DNS1="8.8.8.8"
fi

Retry=0
Enable=`grep "config.RemoteLog\[2\]\[\"Enable\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}' | cut -d/ -f3 | cut -d: -f1`
if [ "$Enable" != "0" ] ; then
while [ -z "$RADIO_LOG_SERVER_IP" -a $Retry -lt 3 ]
do
    RADIO_LOG_SERVER=`grep "config.RemoteLog\[2\]\[\"serverName\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}' | cut -d/ -f3 | cut -d: -f1`
	if [ -n "$RADIO_LOG_SERVER" ] ; then
		nslookup $RADIO_LOG_SERVER $DNS1 >> /tmp/radiologresolv 2>&1
		RADIO_LOG_SERVER_IP=`cat /tmp/radiologresolv | tail -n 1  | awk -F" " '{print $3}'`
		[ "$RADIO_LOG_SERVER_IP" = "resolve" ] && RADIO_LOG_SERVER_IP=''		
			
		[ -z "$RADIO_LOG_SERVER_IP" ] && {
			if [ -n "$DNS2" -a "$DNS2" != "0.0.0.0" ] ; then
				nslookup $RADIO_LOG_SERVER $DNS2 >> /tmp/radiologresolv 2>&1
				RADIO_LOG_SERVER_IP=`cat /tmp/radiologresolv | tail -n 1  | awk -F" " '{print $3}'`
				[ "$RADIO_LOG_SERVER_IP" = "resolve" ] && RADIO_LOG_SERVER_IP=''				
			fi
		}

	    if [ -n "$RADIO_LOG_SERVER_IP" ] ; then
			ip route del $RADIO_LOG_SERVER_IP dev usb1
		    ip route add $RADIO_LOG_SERVER_IP dev usb1
		else
	        sleep 2
			Retry=$(( $Retry + 1 ))
	    fi
	else
	    sleep 5
	fi
done
fi

Retry=0
Enable=`grep "config.RemoteLog\[3\]\[\"Enable\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}' | cut -d/ -f3 | cut -d: -f1`
if [ "$Enable" != "0" ] ; then
while [ -z "$VOIP_LOG_SERVER_IP" -a $Retry -lt 3 ]
do
    VOIP_LOG_SERVER=`grep "config.RemoteLog\[3\]\[\"serverName\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}' | cut -d/ -f3 | cut -d: -f1`
	if [ -n "$VOIP_LOG_SERVER" ] ; then
		nslookup $VOIP_LOG_SERVER $DNS1 >> /tmp/voiplogresolv 2>&1
		VOIP_LOG_SERVER_IP=`cat /tmp/voiplogresolv | tail -n 1  | awk -F" " '{print $3}'`
		[ "$VOIP_LOG_SERVER_IP" = "resolve" ] && VOIP_LOG_SERVER_IP=''		
			
		[ -z "$VOIP_LOG_SERVER_IP" ] && {
			if [ -n "$DNS2" -a "$DNS2" != "0.0.0.0" ] ; then
				nslookup $VOIP_LOG_SERVER $DNS2 >> /tmp/voiplogresolv 2>&1
				VOIP_LOG_SERVER_IP=`cat /tmp/voiplogresolv | tail -n 1  | awk -F" " '{print $3}'`
				[ "$VOIP_LOG_SERVER_IP" = "resolve" ] && VOIP_LOG_SERVER_IP=''				
			fi
		}

	    if [ -n "$VOIP_LOG_SERVER_IP" ] ; then
			ip route del $VOIP_LOG_SERVER_IP dev usb1
		    ip route add $VOIP_LOG_SERVER_IP dev usb1
		else
	        sleep 2
			Retry=$(( $Retry + 1 ))
	    fi
	else
	    sleep 5
	fi
done
fi
