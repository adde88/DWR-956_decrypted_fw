#!/bin/sh

if [ ! -s /sysconfig/ipv6-cfg ]; then
  cp -f /usr/local/etc/ipv6-cfg.default /sysconfig/ipv6-cfg
fi
if [ ! -s /sysconfig/vpn-cfg ]; then
  cp -f /usr/local/etc/vpn-cfg.default /sysconfig/vpn-cfg
fi

. /sysconfig/ipv6-cfg
. /sysconfig/vpn-cfg

eval val='$'${1}
echo $val
