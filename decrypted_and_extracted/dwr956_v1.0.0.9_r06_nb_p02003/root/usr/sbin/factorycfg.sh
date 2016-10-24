#!/bin/sh

/usr/sbin/upgrade /etc/rc.conf.gz sysconfig 0 0
lte_set -S 0x1C > /dev/NULL
lte_set --LTE-band 0x800C4 > /dev/NULL
cp -f /usr/local/etc/lte_profiles.txt /mnt/data/lte_profiles.txt
cp -f /usr/local/etc/lte_connection_settings /mnt/data/lte_connection_settings
rm -f /mnt/data/lte_pin_code
rm -f /sysconfig/jnr-cfg.ascii
rm -f /sysconfig/ipv6-cfg
rm -f /sysconfig/vpn-cfg
rm -f /sysconfig/samba-cfg
rm -f /mnt/data/ant_status

#default 2.4GHz SSID : Telenor4G_XXXXXX
LAST_DEVICE_MAC=`cat /tmp/mac | grep "MAC=" | awk -F '=' '{print $2}' | awk -F ':' '{print $4$5$6}'`
if [ ${#LAST_DEVICE_MAC} -ne 6 ]; then
 UPDATE_SSID="Telenor4G_000000"
else
 #LAST_DEVICE_MAC=`printf "%d" 0x$LAST_DEVICE_MAC`
 #LAST_DEVICE_MAC=`expr $LAST_DEVICE_MAC + 2`
 #LAST_DEVICE_MAC=`printf "%06X" $LAST_DEVICE_MAC`
 #if [ ${#LAST_DEVICE_MAC} -gt 6 ]; then
  #MAC_HEAD=`expr ${#LAST_DEVICE_MAC} - 6 + 1`
  #MAC_END=${#LAST_DEVICE_MAC}
  #LAST_DEVICE_MAC=`echo $LAST_DEVICE_MAC | cut -c $MAC_HEAD-$MAC_END`
 #fi
 UPDATE_SSID="Telenor4G_"${LAST_DEVICE_MAC}
fi
#DEVICE_SSID=`cat /tmp/mac | grep "SSID=" | awk -F '=' '{print $2}'`
if [ -z $DEVICE_SSID ] || [ ${UPDATE_SSID} != ${DEVICE_SSID} ]; then
 #echo "update_SSID.sh ${UPDATE_SSID}"
 update_SSID.sh ${UPDATE_SSID}
fi

sync; sleep 4
reboot

