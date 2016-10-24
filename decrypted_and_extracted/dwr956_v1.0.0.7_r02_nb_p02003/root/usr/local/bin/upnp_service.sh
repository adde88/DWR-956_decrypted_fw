#! /bin/sh

echo "run script : upnp_service.sh"

if [ "_$1" = "_init" ];then
	echo "upnp_service init"
	
	EXTIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LTE-WAN1';"`

	#adding the UPNP chain for filter
	iptables -N UPNP
	iptables -A FORWARD -i $EXTIF ! -o $EXTIF -j UPNP
	#adding the UPNP chain for nat
	iptables -t nat -N UPNP
	iptables -t nat -A PREROUTING -i $EXTIF -j UPNP
	
	return
else
	logger -t [UPNP] -p local4.info upnp restart	
fi

UPNP_CONFIG_FILE=/tmp/miniupnpd.conf
killall miniupnpd
rm -f $UPNP_CONFIG_FILE

mask2cidr() {
    nbits=0
    IFS=.
    for dec in $1 ; do
        case $dec in
            255) let nbits+=8;;
            254) let nbits+=7;;
            252) let nbits+=6;;
            248) let nbits+=5;;
            240) let nbits+=4;;
            224) let nbits+=3;;
            192) let nbits+=2;;
            128) let nbits+=1;;
            0);;
            *) echo "Error: $dec is not recognised"; exit 1
        esac
    done
    echo "$nbits"
}

UPNP_SW=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from UPNP;"`

if [ "${UPNP_SW}" = "0" ]; then
	echo "UPNP Service off"
elif [ "${UPNP_SW}" = "1" ]; then	
	echo "UPNP Service on"
	
	LANIF=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select interfaceName from networkInterface where LogicalIfName = 'LAN1';"`
	LANIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ipaddr from networkInterface where LogicalIfName = 'LAN1';"`
	MASK=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select subnetmask from networkInterface where LogicalIfName = 'LAN1';"`	
	IP_MASK=$(mask2cidr $MASK)
	IP_NET=`/bin/ipcalc.sh $LANIP/$IP_MASK | grep NETWORK | sed '1s/NETWORK=//'`
	URL=http://$LANIP
	FRIENDLY_NAME=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select name from system;"`
	SN=`cat /tmp/mac | grep SN | sed -n 's/^.*=//p'`
	/usr/sbin/version.sh
	MODEL_NUM=`cat /tmp/version | grep Software | sed -n 's/^.*://p' | cut -d "-" -f 1`
	MAC=`cat /tmp/mac | grep MAC | sed -n 's/^.*=//p' | sed -n 's/://gp'`
	UUID=37221887-6b68-4017-957d-$MAC
	
	echo "ext_ifname=usb0" >> $UPNP_CONFIG_FILE
	echo "listening_ip=$LANIF" >> $UPNP_CONFIG_FILE
	echo "port=0" >> $UPNP_CONFIG_FILE
	echo "enable_natpmp=yes" >> $UPNP_CONFIG_FILE
	echo "upnp_forward_chain=UPNP" >> $UPNP_CONFIG_FILE
	echo "upnp_nat_chain=UPNP" >> $UPNP_CONFIG_FILE	
	echo "friendly_name=$FRIENDLY_NAME" >> $UPNP_CONFIG_FILE
	echo "bitrate_up=1000000" >> $UPNP_CONFIG_FILE
	echo "bitrate_down=10000000" >> $UPNP_CONFIG_FILE
	echo "secure_mode=no" >> $UPNP_CONFIG_FILE
	echo "presentation_url=$URL" >> $UPNP_CONFIG_FILE
	echo "bitrate_up=1000000" >> $UPNP_CONFIG_FILE
	echo "system_uptime=yes" >> $UPNP_CONFIG_FILE
	echo "notify_interval=60" >> $UPNP_CONFIG_FILE
	echo "clean_ruleset_interval=600" >> $UPNP_CONFIG_FILE
	echo "uuid=$UUID" >> $UPNP_CONFIG_FILE
	echo "serial=$SN" >> $UPNP_CONFIG_FILE
	echo "model_number=$MODEL_NUM" >> $UPNP_CONFIG_FILE	
	echo "allow 1024-65535 $IP_NET/$IP_MASK 1024-65535" >> $UPNP_CONFIG_FILE	
	echo "deny 0-65535 0.0.0.0/0 0-65535" >> $UPNP_CONFIG_FILE
	
	miniupnpd -f $UPNP_CONFIG_FILE
else
	echo "Unknow UPNP_SW skip!"	
fi
