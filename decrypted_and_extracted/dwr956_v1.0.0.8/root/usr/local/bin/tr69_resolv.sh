#!/bin/sh
Enable=`grep "config.tr69Config\[1\]\[\"Enable\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}' | cut -d/ -f3 | cut -d: -f1`
if [ "$Enable" = "0" ] ; then
    return
fi

USED_INTERFACE=`grep "config.tr69Config\[1\]\[\"InterfaceName\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}'`
if [ "$1" != "$USED_INTERFACE" ]; then
    return
fi

if [ "$USED_INTERFACE" = "usb1" ] ; then
    fall_back=`cat /mnt/data/lte_connection_settings |  cut -c 7`
elif [ "$USED_INTERFACE" = "usb2" ] ; then
    fall_back=`cat /mnt/data/lte_connection_settings |  cut -c 10`
else
    return
fi
if [ "_$fall_back" = "_0" ] ; then
	return
fi


while [ -z "$USB_IP" ]
do	
    if [ "$USED_INTERFACE" = "usb1" ] ; then
	    USB_IP=`ifconfig usb1 | grep "inet addr" | cut -d: -f2 | awk -F" " '{print $1}'`
	elif [ "$USED_INTERFACE" = "usb2" ] ; then
	    USB_IP=`ifconfig usb2 | grep "inet addr" | cut -d: -f2 | awk -F" " '{print $1}'`
	else
		USB_IP=`ifconfig usb0 | grep "inet addr" | cut -d: -f2 | awk -F" " '{print $1}'`
	fi
    if [ -z "$USB_IP" ] ; then
		sleep 5
	    continue
    fi
done

Retry=0
while [ -z "$DNS1" -a $Retry -lt 3 ]
do
	if [ -n "$2" -a -n "$3" ] ; then
		DNS1="$2"
		DNS2="$3"
	else
        if [ "$USED_INTERFACE" = "usb1" ] ; then
		    DNS1=`/usr/local/bin/lte_get -q 1 --ip --timeout 0 | grep "CLIENT:primary DNS" | cut -d: -f3`
		    DNS2=`/usr/local/bin/lte_get -q 1 --ip --timeout 0 | grep "CLIENT:secondary DNS" | cut -d: -f3`
	    elif [ "$USED_INTERFACE" = "usb1" ] ; then
		    DNS1=`/usr/local/bin/lte_get -q 2 --ip --timeout 0 | grep "CLIENT:primary DNS" | cut -d: -f3`
		    DNS2=`/usr/local/bin/lte_get -q 2 --ip --timeout 0 | grep "CLIENT:secondary DNS" | cut -d: -f3`
		else
		    DNS1=`/usr/local/bin/lte_get -q 0 --ip --timeout 0 | grep "CLIENT:primary DNS" | cut -d: -f3`
		    DNS2=`/usr/local/bin/lte_get -q 0 --ip --timeout 0 | grep "CLIENT:secondary DNS" | cut -d: -f3`
		fi
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
while [ -z "$ACS_SERVER_IP" -a $Retry -lt 5 ]
do
    ACS_SERVER=`grep "config.tr69Config\[1\]\[\"URL\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}' | cut -d/ -f3 | cut -d: -f1`
	if [ -n "$ACS_SERVER" ] ; then
		nslookup $ACS_SERVER $DNS1 >> /tmp/69resolv 2>&1
		ACS_SERVER_IP=`cat /tmp/69resolv | tail -n 1  | awk -F" " '{print $3}'`
		[ "$ACS_SERVER_IP" = "resolve" ] && ACS_SERVER_IP=''		
			
		[ -z "$ACS_SERVER_IP" ] && {
			if [ -n "$DNS2" -a "$DNS2" != "0.0.0.0" ] ; then
				nslookup $ACS_SERVER $DNS2 >> /tmp/69resolv 2>&1
				ACS_SERVER_IP=`cat /tmp/69resolv | tail -n 1  | awk -F" " '{print $3}'`
				[ "$ACS_SERVER_IP" = "resolve" ] && ACS_SERVER_IP=''				
			fi
		}

	    if [ -n "$ACS_SERVER_IP" ] ; then
			#ip route del $ACS_SERVER_IP dev $USED_INTERFACE
		    ip route add $ACS_SERVER_IP dev $USED_INTERFACE
		else
	        sleep 2
			Retry=$(( $Retry + 1 ))
	    fi
	else
	    sleep 5
	fi
done
