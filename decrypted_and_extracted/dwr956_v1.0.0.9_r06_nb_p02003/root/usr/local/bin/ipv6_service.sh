#!/bin/sh

. /sysconfig/ipv6-cfg

if [ X"$IPV6_ENABLE" = X"off" ]; then
    echo "IPV6_ENABLE is off"
    return 0
fi

WANIP=$(ip -4 addr show dev usb0|grep inet | awk '{print $2}'| cut -d'/' -f 1)

sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.all.forwarding=1

unload_napt66() {
    is_load_napt66=$(lsmod |grep napt66 |wc -l)
    if [ X"${is_load_napt66}" = X"1" ]; then
        rmmod napt66
    fi
}

load_napt66() {
  . /sysconfig/ipv6-cfg
  if [ X"${IPV6_ENABLE}" = X"on" -a X"${IPV6_TYPE}" = X"dyna_dual" ]; then
    if [ X"${NAPT66}" = X"on" ]; then
      sysctl -w net.ipv6.conf.all.disable_ipv6=0
      sysctl -w net.ipv6.conf.all.forwarding=1
      insmod /lib/modules/`uname -r`/napt66.ko wan_if=usb0
    fi
  fi
}


# in dual mode, we will disconnect connection and re-connect
# it will call rc.diaup to setting WAN
old_is_dual=$(grep IPV6_TYPE=dyna_dual /tmp/ipv6-cfg.old |wc -l)
if [ X"$old_is_dual" = X"0" ]; then
    if [ X"$IPV6_TYPE" = X"dyna_dual" ]; then
        echo "!!!!!!!! Fixme: change IPv6 from non-dual to dual mode !!!!!!!!".
        # non-dual mode to dual mode, should setup IPv6 connection and will trigger rc.dualup?
        lte_set -M 0 1 -t 3
        lte_service.sh restart
        return 0
    fi
else
     if [ X"$IPV6_TYPE" != X"dyna_dual" ]; then
        echo "!!!!!!!! change IPv6 from dual to non-dual mode !!!!!!!!".
        # dual mode to non-dual mode, should disconnect IPv6 connection.
        lte_set -M 0 1 -t 0
        lte_service.sh restart
        return 0
     fi
fi

if [ -z $WANIP ]; then
    echo "run lan service only";
    /usr/local/bin/ipv6_lan.sh
    return 0;
fi;

/usr/local/bin/ipv6_wan.sh

