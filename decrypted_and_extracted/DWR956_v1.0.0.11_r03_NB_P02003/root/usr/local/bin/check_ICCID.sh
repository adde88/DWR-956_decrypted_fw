#!/bin/sh

do_landing_page()
{
  if [ ! -e /tmp/ICCID_not_same ]; then
    echo "1, 0, 0" > /mnt/data/lte_connection_settings
    touch /tmp/ICCID_not_same
    package_forward_reset
    rm /mnt/data/lte_pin_code
    sync
  fi
}


package_forward_reset()
{
	echo "delete iptables for detect SIM Card was changed, routed to the landingpage" >> /var/log/messages
	BDG1IP=`grep "config.Lan\[1\]\[\"IpAddress\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}'`
    iptables -t nat -D PREROUTING -i br0 -p tcp --dport 80 -j DNAT --to-destination $BDG1IP
    iptables -t nat -I PREROUTING -i br0 -p tcp --dport 80 -j DNAT --to-destination $BDG1IP
    echo "killall dnsmasq, run dnsmasq --address=/#/$BDG1IP" >> /var/log/messages
    killall -9 dnsmasq
    /usr/sbin/dnsmasq -u root --address=/#/$BDG1IP
}

ICCIDFile=/mnt/data/SIM_ICCID
if [ -e "$ICCIDFile" ]; then
    OLD_ICCID=`cat $ICCIDFile`
	echo "OLD_ICCID=$OLD_ICCID" >> /var/log/messages
fi
if [ -n "$1" ]; then
    echo $1 > $ICCIDFile
	sync
	echo "NEW_ICCID=$1" >> /var/log/messages
else
    SIMCheckFile=/tmp/lte_sim_check
    if [ ! -e "$SIMCheckFile" ]; then
	    SIMState=`cat /proc/sim_detect/sim_detect_state`
		if [ "$SIMState" = "0" ]; then
		    touch $SIMCheckFile
		    killall lte_daemon
		fi
	fi
fi
ResetToDefault=`grep "config.ResetToDefault\[1\]\[\"resetToDefault\"\]" /sysconfig/jnr-cfg.ascii | awk -F"\"" '{print $4}'`
echo "ResetToDefault=$ResetToDefault" >> /var/log/messages
if [ "$ResetToDefault" = "1" ]; then
    do_landing_page
else
    if [ -n "$1" ] && [ "$OLD_ICCID" != "$1" ]; then
        sqlite3 -cmd ".timeout 1500" /tmp/system.db "update ResetToDefault set resetToDefault=1"
        export_db -a /tmp/system.db /sysconfig/jnr-cfg.ascii
	    do_landing_page
	fi
fi