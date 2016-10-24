#!/bin/sh

set_fallback1()
{
sed -i "s/\(config.lte.*\[1\]\[\"apn_status\"\]\).*$/\1 = \"1\"/" /sysconfig/jnr-cfg.ascii
#sed -i "s/\(config.voip.*\[1\]\[\"USED_NETWORK_INTERFACE\"\]\).*$/\1 = \"usb0\"/" /sysconfig/jnr-cfg.ascii

#For VoIP/TR69/Syslog, we don't support pure IPv6.
PDPTYPE=`grep "config.lte.*\[1\]\[\"PDPType\"\]" /sysconfig/jnr-cfg.ascii | cut -d= -f2 | cut -d'"' -f2`
if [ "$PDPTYPE" = "2" ] ; then
    sed -i "s/\(config.lte.*\[1\]\[\"PDPType\"\]\).*$/\1 = \"3\"/" /sysconfig/jnr-cfg.ascii
fi
sync
}

set_fallback2()
{
sed -i "s/\(config.lte.*\[1\]\[\"apn_status\"\]\).*$/\1 = \"2\"/" /sysconfig/jnr-cfg.ascii
#sed -i "s/\(config.voip.*\[1\]\[\"USED_NETWORK_INTERFACE\"\]\).*$/\1 = \"usb1\"/" /sysconfig/jnr-cfg.ascii
sync
}

reboot_device()
{  
	#sleep 60
	CFG="/sysconfig/jnr-cfg.ascii"
	#Check if jnr-cfg.ascii file is exist
	CHKSUM=`grep "config.checksum" $CFG`
  
	while [ -z "$CHKSUM" ]
	do
		echo "fallback checksum is empty"
		sleep 5
		CHKSUM=`grep "config.checksum" $CFG`
	done

	echo "fallback check checksum is not empty."
	
	echo "setvoipint to $INT"
	
	/usr/local/bin/setvoipint.sh $INT
	sleep 3
	
	if [ "$PDPTYPE" = "2" ] ; then
		/usr/local/bin/lte_set -M 0 1 -t 3 >/dev/null
		echo "Set PDP Type 3"
		sleep 5
	fi
	
	reboot 
}

if [ -n "$1" ] ; then
	echo "start fallback $1"
	# 1st APN fallback
	if [ "$1" -eq 1 ];  then
		echo "1 apn" >> /tmp/fallback
		#sed -i "s/\(config.lte.*\[1\]\[\"apn_status\"\]\).*$/\1 = \"1\"/" /flash/teamf1.cfg.ascii
		#sed -i "s/\(config.voip.*\[1\]\[\"USED_NETWORK_INTERFACE\"\]\).*$/\1 = \"usb0\"/" /flash/teamf1.cfg.ascii
		#sync
		set_fallback1
		INT="usb0"
		sleep 2
		echo "fallback $1 reboot_device"
		reboot_device
		#/pfrm2.0/bin/callmngr_cli set SIPGENERAL_USED_NETWORK_INTERFACE 1 usb0
	fi

	# 2nd APN recovery
	if [ "$1" -eq 2 ]; then
		echo "2 apn" >> /tmp/fallback
		#sed -i "s/\(config.lte.*\[1\]\[\"apn_status\"\]\).*$/\1 = \"2\"/" /flash/teamf1.cfg.ascii
		#sed -i "s/\(config.voip.*\[1\]\[\"USED_NETWORK_INTERFACE\"\]\).*$/\1 = \"usb1\"/" /flash/teamf1.cfg.ascii
		#sync
		set_fallback2
		INT="usb1"
		/usr/local/bin/lte_set -q 1 -c -2
		sleep 2
		echo "fallback $1 reboot_device"
		reboot_device
		#/pfrm2.0/bin/callmngr_cli set SIPGENERAL_USED_NETWORK_INTERFACE 1 usb1
	fi

fi
