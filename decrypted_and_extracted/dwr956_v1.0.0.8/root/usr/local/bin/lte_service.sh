#!/bin/sh
if [ -e /lib/modules/`uname -r`/qmi_wwan.ko ]; then
QMI=qmi_wwan
else
QMI=GobiNet
fi

start() {
  Retry=0
  while [ ! -e "/dev/qcqmi0" ] && [ $Retry -lt 30 ]; do
    sleep 2
	Retry=$(( $Retry + 1 ))
	echo "Retry: $Retry"
  done
  sleep 3
  rm -rf /tmp/lte.lock
  if [ "$1" == "" ]; then
    lte_daemon -d 0 -o /tmp/system.db &
  else
    lte_daemon -d $1 -o /tmp/system.db &
  fi
}

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

stop() {
  #dual image
  if [ -e /dev/disk/by-id/usb-Linux_File-CD_Gadget_0123456789ABCDEF-0:0 ]; then
    umount -f /tmp/mdm_mass_storage/
  fi
  
  count=`pidof lte_daemon | wc -w`
  if [ $count -ne 0 ]; then
    lte_set -O 0x03
    sleep 2
  fi

  #wshaper.htb ifb0 stop
  #sleep 1

  touch /tmp/lte_restart

  killall remserial
  killall udhcpc
  killall lte_daemon
  killall lte_get
  killall lte_set
  
  rc.clear usb0 &
  rc.clear usb1 &

  num=`lsmod | grep $QMI | awk '{print $3}'`
  for i in `seq 1 20`
  do
    if [ "$num" == "0" ]; then
      break
    else
      sleep 1
      num=`lsmod | grep $QMI | awk '{print $3}'`
    fi
  done

  ifconfig usb0 down
  ifconfig usb1 down

  echo 0 > /sys/devices/virtual/leds/LTE_LINK/brightness
  echo 0 > /sys/devices/virtual/leds/LTE_fail/brightness
  echo 0 > /sys/devices/virtual/leds/Signal_high/brightness
  echo 0 > /sys/devices/virtual/leds/Signal_low/brightness
  echo 0 > /sys/devices/virtual/leds/internet/brightness
  sleep 2

  unload_napt66
  echo 1 > /sys/devices/virtual/leds/LTE_RST/brightness
  Retry=0
  while [ -e "/dev/qcqmi0" ]; do
    sleep 2
	Retry=$(( $Retry + 1 ))
	echo "retry: $Retry"
  done
  #rmmod ifxusb_host
  #rmmod xhci.ko
  rmmod $QMI
  rmmod GobiSerial
  
  echo 0 > /sys/devices/virtual/leds/LTE_RST/brightness
  #sleep 1

  #insmod /lib/modules/`uname -r`/ifxusb_host.ko
  #insmod /lib/modules/`uname -r`/xhci.ko
  insmod /lib/modules/`uname -r`/$QMI.ko
  insmod /lib/modules/`uname -r`/GobiSerial.ko
  load_napt66
}

if [ $# == 0 ]; then
  CMD="restart"
else
  CMD=$1
fi

case $CMD in
  start)
    start $2
    ;;
  stop)
    stop
    ;;
  restart|reload)
    stop
    start $2
    ;;
  *)
    echo $"Usage: $0 {start|stop|restart}"
    exit 1
    ;;
esac
