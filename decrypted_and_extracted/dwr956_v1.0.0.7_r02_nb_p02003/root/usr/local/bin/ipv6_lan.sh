#!/bin/sh
. /sysconfig/ipv6-cfg
if [ "${IPV6_ENABLE}" = "off" ]; then
    sysctl -w net.ipv6.conf.all.disable_ipv6=1
    echo "IPv6 ENABLE is off"
    return 0
else
    echo "IPv6 ENABLE on Lan Service"
    sysctl -w net.ipv6.conf.all.disable_ipv6=0
    sysctl -w net.ipv6.conf.all.forwarding=1
fi

if [ "${IPV6_ENABLE}" = "on" -a "${LAN_V6_CONFIG}" = "on" ]; then
    if [ "${LAN_V6_DNS}" = "on" ]; then
        if [ -e /tmp/resolv.conf.dhcp6c-new ]; then
            PRIMARY_V6DNS=`grep 'nameserver1 ' /tmp/resolv.conf.dhcp6c-new | sed 's/^.*nameserver1 //g'`
            SECOND_V6DNS=`grep 'nameserver2 ' /tmp/resolv.conf.dhcp6c-new | sed 's/^.*nameserver2 //g'`
        else
            if [ ! -z ${AP_IPADDR_V6} ]; then
                PRIMARY_V6DNS=${AP_IPADDR_V6}
            fi
        fi
    else
        PRIMARY_V6DNS=$WAN_IPV6PRIDNS
        SECOND_V6DNS=$WAN_IPV6SECDNS
    fi

    # enable LAN site only.
    . /usr/local/bin/radvd.sh
    V6IPPREFIX=${AP_IPADDR_V6_PREFIX}/64
    IPV6_TYPE=
    if [ ! -z ${AP_IPADDR_V6} ]; then
        ifconfig br0 ${AP_IPADDR_V6}/64
    fi
    create_radvd_conf
    radvd -C /sysconfig/radvd.conf
    echo "start radvd in LanInit"

    if [ "${LAN_V6_TYPE}" != "stateless" ]; then
        . /usr/local/bin/dhcpv6.sh
        #create dhcpv6 config file by the settings
        LAN_DHCP_START_V6=${AP_IPADDR_V6_PREFIX}${LAN_DHCPV6START}
        LAN_DHCP_END_V6=${AP_IPADDR_V6_PREFIX}${LAN_DHCPV6END}
        DHCPPD_PTIME=30
        DHCPPD_VTIME=40
        create_dhcp6s_conf
        dhcp6s br0 -c $DHCP6S_CONFIG_FILE &
        echo "start dhcp6s in LanInit"
    fi
else
    echo "IPv6 enable is ${IPV6_ENABLE}, LAN_V6_CONFIG is ${LAN_V6_CONFIG}"
fi

