#!/bin/sh
. /sysconfig/ipv6-cfg
. /usr/local/bin/radvd.sh
. /usr/local/bin/dhcpv6.sh
. /usr/local/bin/6to4.sh
. /usr/local/bin/6in4.sh
. /usr/local/bin/gogoc.sh
. /usr/local/bin/ipv6_dual.sh
. /usr/local/bin/6rd.sh

DHCPPD_FILE=/sysconfig/dhcppd_result

# stop LAN side IPv6 service radvd and dhcpv6
killall -q -SIGKILL dhcp6s
killall -q -SIGKILL radvd
killall -q -SIGKILL gogoc
sleep 1

if [ "${IPV6_ENABLE}" = "off" ]; then
    echo "IPv6 ENABLE is off"
    return 0
fi

usb0_ip=`grep ip /tmp/dhcpc_usb0.result | awk '{print $2}'`
if [ "${IPV6_TYPE}" = "dyna_dual" ]; then
    setup_ipv6_dual
elif [ "${IPV6_TYPE}" = "6to4" ]; then
    if [ ! -z ${usb0_ip} ]; then
        setup_6to4 ${usb0_ip}
    else
        echo "6to4 need WAN IP"
    fi
elif [ "${IPV6_TYPE}" = "6rd" ]; then
    if [ ! -z ${usb0_ip} ]; then
        setup_6rd ${usb0_ip}
    else
        echo "6rd need WAN IP"
    fi
elif [ "${IPV6_TYPE}" = "6in4" ]; then
    if [ ! -z ${usb0_ip} ]; then
        setup_6in4 ${usb0_ip}
    else
        echo "6in4 need WAN IP"
    fi
elif [ "${IPV6_TYPE}" = "gogoc" ]; then
    create_gogoc_conf
    if [ ! -d /sysconfig/template ]; then
        mkdir /sysconfig/template
    fi
    cp /usr/local/bin/openwrt.sh /sysconfig/template
    gogoc -f /sysconfig/gw6c.conf
    # gogoc will take care radvd and dhcp6s
    return 0
fi

if [ "${LAN_V6_CONFIG}" = "off" ]; then
    echo "IPv6 in LAN is off"
    return 0
fi


if [ ! -z ${AP_IPADDR_V6} ]; then
    ifconfig br0 ${AP_IPADDR_V6}/64
    V6IPPREFIX=${AP_IPADDR_V6}/64
    LAN_DHCP_START_V6=`/usr/local/bin/ipv6_prefix ${AP_IPADDR_V6} 64`$LAN_DHCPV6START
    LAN_DHCP_END_V6=`/usr/local/bin/ipv6_prefix ${AP_IPADDR_V6} 64`$LAN_DHCPV6END
fi


#l for DHCP-PD
if [ "${IPV6_TYPE}" = "dyna_dual" -o "${IPV6_TYPE}" = "pppoe" ]; then
	if [ "${DHCPPD_ENABLE}" = "on" ]; then
		if [ ! -e ${DHCPPD_FILE} ]; then
			echo "Can not get DHCP-PD from ISP!!!"
			return 0
		else
			DHCPPD_PREFIX=`grep 'prefix addr ' $DHCPPD_FILE | sed 's/^.*addr //g'`
			DHCPPD_PRELEN=`grep 'prefix plen ' $DHCPPD_FILE | sed 's/^.*plen //g'`
			DHCPPD_PTIME=`grep 'prefix pltime ' $DHCPPD_FILE | sed 's/^.*pltime //g'`
			DHCPPD_VTIME=`grep 'prefix vltime ' $DHCPPD_FILE | sed 's/^.*vltime //g'`

			#gen ipv6 prefix from wan side with DHCP-PD if DHCP-PD enabled
			V6IPPREFIX=$DHCPPD_PREFIX/$DHCPPD_PRELEN
		fi
	fi
fi

#setting DNS
if [ "${LAN_V6_DNS}" = "on" ]; then
	if [ -e /tmp/resolv.conf.dhcp6c-new ]; then
		PRIMARY_V6DNS=`grep 'nameserver1 ' /tmp/resolv.conf.dhcp6c-new | sed 's/^.*nameserver1 //g'`
		SECOND_V6DNS=`grep 'nameserver2 ' /tmp/resolv.conf.dhcp6c-new | sed 's/^.*nameserver2 //g'`
	else
		PRIMARY_V6DNS=$WAN_IPV6PRIDNS
		SECOND_V6DNS=$WAN_IPV6SECDNS
	fi
else
	PRIMARY_V6DNS=$WAN_IPV6PRIDNS
	SECOND_V6DNS=$WAN_IPV6SECDNS
fi

create_radvd_conf
radvd -C $RADVD_CONFIG_FILE -l /tmp/radvd.log

if [ "${LAN_V6_TYPE}" != "stateless" ]; then
	if [ "${IPV6_TYPE}" = "dyna_dual" -o "${IPV6_TYPE}" = "pppoe" ]; then
		if [ "${DHCPPD_ENABLE}" = "on" ]; then
			LAN_DHCP_START_V6=$DHCPPD_PREFIX$LAN_DHCPV6START
			LAN_DHCP_END_V6=$DHCPPD_PREFIX$LAN_DHCPV6END
		fi
        elif [ "${IPV6_TYPE}" = "6to4" ]; then
            LAN_DHCP_START_V6=$(find_6to4_prefix ${usb0_ip}):1::${LAN_DHCPV6START}
            LAN_DHCP_END_V6=$(find_6to4_prefix ${usb0_ip}):1::${LAN_DHCPV6END}
            DHCPPD_PTIME=30
            DHCPPD_VTIME=40
	elif [ "${IPV6_TYPE}" = "6in4" ]; then
            DHCPPD_PTIME=30
            DHCPPD_VTIME=40
        elif [ "${IPV6_TYPE}" = "6rd" ]; then
            DHCPPD_PTIME=30
            DHCPPD_VTIME=40
	fi

	#create dhcpv6 config file by the settings
        create_dhcp6s_conf
	dhcp6s br0 -c $DHCP6S_CONFIG_FILE &
fi

