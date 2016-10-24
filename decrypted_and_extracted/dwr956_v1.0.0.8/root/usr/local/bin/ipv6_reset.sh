#!/bin/sh

. /sysconfig/ipv6-cfg
. /usr/local/bin/6in4.sh
. /usr/local/bin/6to4.sh
. /usr/local/bin/6rd.sh

if [ "${IPV6_ENABLE}" = "off" ]; then
    echo IPV6 is off
    exit 0
fi

sysctl -w net.ipv6.conf.all.disable_ipv6=1
cp /sysconfig/ipv6-cfg /tmp/ipv6-cfg.old

if [ "${IPV6_TYPE}" = "6to4" ]; then
    shutdown_6to4
elif [ "${IPV6_TYPE}" = "6rd" ]; then
    shutdown_6rd
elif [ "${IPV6_TYPE}" = "6in4" ]; then
    shutdown_6in4
elif [ "${IPV6_TYPE}" = "gogoc" ]; then
    ifconfig gogoc &>/dev/null
    if [ $? -ne 0 ]; then
        echo "why no gogoc"
        return 0
    fi

    ifconfig gogoc down
    ip tunnel del gogoc
    sleep 1
    sed -i '/# gogoc/,/nameserver/ d' /ramdisk/etc/resolv.conf
fi

killall -q radvd
killall -q dhcp6s
killall gogoc

