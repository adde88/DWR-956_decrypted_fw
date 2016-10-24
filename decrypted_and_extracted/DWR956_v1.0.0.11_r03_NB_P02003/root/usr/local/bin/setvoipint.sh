#!/bin/sh

display_usage() {
	echo -e "usage: setvoipint.sh [interface]"
	echo "Interface: usb0, usb1 ,br0"
}
                                 
CONF=/ramdisk/flash/rc.conf

if [ $# -le 0 ]
then
      SIP_BIND1="$(awk -F'"' '/wanip_1_l2ifName=/{ print $2 }' $CONF)"
      #echo $SIP_BIND1
      SIP_BIND2="$(awk -F'"' '/wanip_1_iface=/{ print $2 }' $CONF)"
      #echo $SIP_BIND2
      SIP_BIND3="$(awk -F'"' '/default_wan_4_conn_iface=/{ print $2 }' $CONF)"
      #echo $SIP_BIND3
      
      if [ "$SIP_BIND1" != "$SIP_BIND2" ] && [ "$SIP_BIND1" != "$SIP_BIND2" ]
      then
        echo "Match Error: $SIP_BIND1 , $SIP_BIND2 , $SIP_BIND3"
        display_usage
      else
        echo Bind Interface to $SIP_BIND1 
      fi  
else
      if [ "$1" != "usb0" ] && [ "$1" != "usb1" ] && [ "$1" != "br0" ]
      then
        echo "Interface is not supported"
      	display_usage
      	exit 1
      else
      	while [ -f /tmp/rc_conf_lock ]
	do
	#echo locked
	sleep 1
	done
	touch /tmp/rc_conf_lock
	SAVE=wanip_1_l2ifName='"'"$1"'"'
	echo $SAVE
	sed -i 's|\(^wanip_1_l2ifName=\).*|\'"$SAVE"'|' $CONF
	SAVE=wanip_1_iface='"'"$1"'"'
	echo $SAVE
	sed -i 's|\(^wanip_1_iface=\).*|\'"$SAVE"'|' $CONF
	SAVE=default_wan_4_conn_iface='"'"$1"'"'
	echo $SAVE
	sed -i 's|\(^default_wan_4_conn_iface=\).*|\'"$SAVE"'|' $CONF
	savecfg.sh
	rm -f /tmp/rc_conf_lock   
      fi
fi   

