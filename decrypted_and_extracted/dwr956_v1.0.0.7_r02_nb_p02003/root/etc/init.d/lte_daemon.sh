#!/bin/sh /etc/rc.common

#START=93
#STOP=03

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

start() 
{
  echo "insmod lte modules ....."
  if [ -e /lib/modules/`uname -r`/qmi_wwan.ko ]; then
    insmod /lib/modules/`uname -r`/cdc-wdm.ko
    insmod /lib/modules/`uname -r`/qmi_wwan.ko
  else
    insmod /lib/modules/`uname -r`/GobiNet.ko
  fi
  insmod /lib/modules/`uname -r`/GobiSerial.ko
  sleep 1
  ifconfig usb0 up
  load_napt66
  Retry=0
  while [ ! -e "/dev/qcqmi0" ] && [ $Retry -lt 5 ]; do
    sleep 3
	Retry=$(( $Retry + 1 ))
	echo "Retry: $Retry"
  done
  sleep 3
  lte_daemon -m 1500 -d 0 -o /tmp/system.db &
  sleep 1
  lte_watchdog &
#  echo "enable lte wifi ppa"
#  echo w be1a00a0 90010c7 > /proc/eth/mem
}

stop()
{
  echo "stop lte daemon..."
  #if [ -e /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 ]; then
  #  umount -f /tmp/mdm_mass_storage/
  #fi
  count=`pidof lte_daemon | wc -w`
  if [ $count -ne 0 ]; then
    lte_set -O 0x03
    sleep 2
  fi
}
