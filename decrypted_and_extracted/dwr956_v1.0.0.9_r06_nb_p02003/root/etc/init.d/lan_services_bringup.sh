#!/bin/sh /etc/rc.common
START=50

	if [ ! "$ENVLOADED" ]; then
		if [ -r /etc/rc.conf ]; then
			. /etc/rc.conf 2> /dev/null
			ENVLOADED="1"
		fi
	fi

	if [ ! "$CONFIGLOADED" ]; then
	if [ -r /etc/rc.d/config.sh ]; then
		. /etc/rc.d/config.sh 2>/dev/null
		CONFIGLOADED="1"
	fi
	fi

check_mac ()
{
	local old_mac=$(upgrade mac_get 0 2>/dev/null);
	[ -n "$CONFIG_UBOOT_CONFIG_ETHERNET_ADDRESS" -a -n "$old_mac" ] && \
	  [ "$old_mac" = "$CONFIG_UBOOT_CONFIG_ETHERNET_ADDRESS" ] && {
		local i=0;
		while [ $i -lt 5 ]; do
			echo -en "\033[J"; usleep 150000;
			echo -en "#######################################################\n";
			echo -en "#     DEVICE CONFIGURED WITH DEFAULT MAC ADDRESS!!    #\n";
			echo -en "# This may conflict with other devices. Please change #\n";
			echo -en "#     the MAC address for un-interrupted services.    #\n";
			echo -en "#######################################################\n";
			echo -en "\033[5A\033G"; usleep 300000;
			i=$((i+1));
		done; echo -en "\n\n\n\n\n";
	} || true
}

start() {
	echo "LAN service bringup..."

	check_mac;

	if [ "$CONFIG_FEATURE_IFX_WIRELESS" = "1" ]; then
		if [ "$CONFIG_FEATURE_IFX_WIRELESS_WAVE300" = "1" ]; then
			#BR_MAC_ADDR="`/usr/sbin/upgrade mac_get 0 | /usr/sbin/next_macaddr -3`" 
			BR_MAC_ADDR="`/usr/sbin/upgrade mac_get 0`"
		else
			BR_MAC_ADDR="`/usr/sbin/upgrade mac_get 0 | /usr/sbin/next_macaddr -8`"
		fi
	else
		BR_MAC_ADDR="`/usr/sbin/upgrade mac_get 0 | /usr/sbin/next_macaddr -3`"
	fi

	/sbin/ifconfig lo 127.0.0.1 netmask 255.0.0.0
	
	#Set Active Wan Pvc's parameter in /tmp/system/status for LCP Prioritization
	/usr/sbin/status_oper SET "LCP_Wan_Info" "active_wan_pvc" "0"
	
	### Initialize the PPA hooks for use in LAN Start ###
	### Merge from PPA.sh script in S17PPA.sh ###
	if [ "1$CONFIG_FEATURE_PPA_SUPPORT" = "11" ]; then
		# initialize PPA hooks
		/sbin/ppacmd init 2> /dev/null

		SchedulesEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EnableProfiles from UrlFltrConfig;"`
		QOS_Enable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from QoS;"`
		if [ $SchedulesEnable = "0" -a $QOS_Enable = "0" ];then
			echo "Enable PPA"
			# enable wan / lan ingress
			/sbin/ppacmd control --enable-lan --enable-wan 2> /dev/null
		else	
			/sbin/ppacmd control --disable-lan --disable-wan 2> /dev/null
		fi

		# set WAN vlan range 3 to 4095		
		/sbin/ppacmd addvlanrange -s 3 -e 0xfff 2> /dev/null

		# In case of A4 or D4 and if ppe is loaded as module, in case of danube/tp-ve, 
		# then reinitialize TURBO MII mode since it is reset during module load.
		platform=${CONFIG_IFX_MODEL_NAME%%_*}
		if [ "$platform" = "DANUBE" -o "$platform" = "TP-VE" ]; then
			if [ "1$CONFIG_PACKAGE_KMOD_LTQCPE_PPA_A4_MOD" = "11" ]; then
				echo w 0xbe191808 0000096E > /proc/eth/mem
			fi

			if [ "1$CONFIG_PACKAGE_KMOD_LTQCPE_PPA_D4_MOD" = "11" ]; then
				echo w 0xbe191808 000003F6 > /proc/eth/mem
			fi
		fi

		#For PPA, the ack/sync/fin packet go through the MIPS and normal data packet go through PP32 firmware.
		#The order of packets could be broken due to different processing time.
		#The flag nf_conntrack_tcp_be_liberal gives less restriction on packets and 
		# if the packet is in window it's accepted, do not care about the order

		echo 1 > /proc/sys/net/netfilter/nf_conntrack_tcp_be_liberal
		#if PPA is enabled, enable hardware based QoS to be used later
		/usr/sbin/status_oper SET "IPQoS_Config" "ppe_ipqos" "1"
		. /etc/init.d/ipqos_qprio_cfg.sh
	fi

	i=0
	while [ $i -lt $lan_main_Count ]
	do
		eval iface='$lan_main_'$i'_interface'
		eval ip='$'lan_main_${i}_ipAddr
		eval netmask='$'lan_main_${i}_netmask
		if [ "$iface" = "br0" ]; then
			/usr/sbin/brctl addbr $iface
			/usr/sbin/brctl setfd $iface 1
			/sbin/ifconfig $iface hw ether $BR_MAC_ADDR up
			#/sbin/ifconfig $iface up
			[ `mount|grep -q nfs;echo $?` -eq  0 ] && /sbin/ifconfig $iface $ip netmask $netmask up
			/usr/sbin/brctl addif $iface eth0
			if [ -n "$CONFIG_TARGET_LTQCPE_PLATFORM_AR9_VB" ]; then
				/usr/sbin/brctl addif $iface eth1
			fi
			/usr/sbin/brctl stp $iface off
		fi
		i=$(( $i + 1 ))
	done

	#806131:<IFTW-leon> Let board accessing by eth0 before ppa ready
	/sbin/ifconfig eth0 0.0.0.0 up

	/etc/rc.d/rc.bringup_lan start
}
