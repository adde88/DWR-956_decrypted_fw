#!/bin/sh
echo "WIFI ACL control script"
sleep 2
WLANIf_1="wlan0"
WLANIf_2="wlan0.0"
# check the VAP is enabled or not
WLANEn_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select wlanEnabled from wifiAP where wlanName = 'ap1';"`
WLANEn_2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select wlanEnabled from wifiAP where wlanName = 'ap2';"`

# check the ACL policy
# 0: disable, 1:whitelist, 2:blacklist
WLANACLEn_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ACLPolicy1 from wifiACLconfig where profileName = 'wifiacl';"`
WLANACLEn_2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ACLPolicy2 from wifiACLconfig where profileName = 'wifiacl';"`

echo "WLANACLEn_1=$WLANACLEn_1"
echo "WLANACLEn_2=$WLANACLEn_2"

# store the old wifiACL list
WLANACLCONF_1="/tmp/wifiACL_1"
WLANACLCONF_2="/tmp/wifiACL_2"

# setting SSID_1's ACL policy and MAC Address list
if [ "$WLANEn_1" = "1" ]; then
    if [ "$WLANACLEn_1" = "0" ]; then
       echo "disable the ACL" 
       iwpriv wlan0 sAclMode $WLANACLEn_1    
    else 	
    # clean the old setting on driver.....
    # due to no flush command
        if [ -f "$WLANACLCONF_1" ]; then
     	    cat $WLANACLCONF_1 | while read line
	    do
                iwpriv $WLANIf_1 sDelACL $line
	        echo "clear the MAC address $line"
	    done
	    rm -rf $WLANACLCONF_1
        fi
        # counting the SSID_1 ACL MAC Address.
	ACLCOUNT_1=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from wifiACLTable1;"`
        if [ "$ACLCOUNT_1" -ne 0 ]; then
            i=1
            while [ $i -le $ACLCOUNT_1 ]
            do
                ACL_MAC=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ACL_MAC from wifiACLTable1 where _ROWID_='$i';"`
	        echo "$ACL_MAC" >> $WLANACLCONF_1
		echo "ACL_MAC=$ACL_MAC"
	        iwpriv $WLANIf_1 sACL $ACL_MAC
		# Todo : Kick the MAC is ACL list???
		i=`expr $i + 1`
            done
        fi
	# enable the WIFI ACL policy
	iwpriv wlan0 sAclMode $WLANACLEn_1
    fi
fi

# setting SSID_2's ACL policy and MAC Address list
if [ "$WLANEn_2" = "1" ]; then
    if [ "$WLANACLEn_2" = "0" ]; then
       echo "disable the ACL"
       iwpriv $WLANIf_2 sAclMode $WLANACLEn_2
    else
    # clean the old setting on driver.....
    # due to no flush command
        if [ -f "$WLANACLCONF_2" ]; then
            cat $WLANACLCONF_2 | while read line
            do
                iwpriv $WLANIf_2 sDelACL $line
                echo "clear the MAC address $line"
            done
            rm -rf $WLANACLCONF_2
        fi
        # counting the SSID_2 ACL MAC Address.
        ACLCOUNT_2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from wifiACLTable2;"`
        if [ "$ACLCOUNT_2" -ne 0 ]; then
            i=1
            while [ $i -le $ACLCOUNT_2 ]
            do
                ACL_MAC_2=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select ACL_MAC from wifiACLTable2 where _ROWID_='$i';"`
                echo "$ACL_MAC_2" >> $WLANACLCONF_2
                echo "ACL_MAC_2=$ACL_MAC_2"
                iwpriv $WLANIf_2 sACL $ACL_MAC_2
                # Todo : Kick the MAC is ACL list???
                i=`expr $i + 1`
            done
        fi
        # enable the WIFI ACL policy
        iwpriv wlan0.0 sAclMode $WLANACLEn_2
    fi
fi
