#!/bin/sh
# export the channel information to database.
# which will be called by wifiInit.
Debug=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select debugFlag from wifiAOCSstatus where profileName = 'wifiAOCS';"`
WLAN_AOCS_FILE="/proc/net/mtlk/wlan0/aocs_channels"

#####
##
## This is only 2.4G part, not easy extend to 5G
## channel index is not easy mapping to database.....
#####
# check the available channel
# iwlist wlan0 channel | sed 1d | grep -c ":"
AvailCH=`cat $WLAN_AOCS_FILE | sed 1,2d | grep -c "-"`
# Todo : write to database....
sqlite3 -cmd ".timeout 1000" /tmp/system.db "update wifiAOCSstatus set availableCh='$AvailCH' where profileName = 'wifiAOCS'"
CHinfo_db=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from wifiAOCSChstatus;"`
# Check the database columns, or recreate all column.
[ "$Debug" != "0" ] && echo "CHinfo_db=$CHinfo_db"
[ "$Debug" != "0" ] && echo "AvailCH=$AvailCH"
if [ "$CHinfo_db" != "$AvailCH" ]; then
    # clear old, only run when country code changed.
    sqlite3 -cmd ".timeout 1000" /tmp/system.db "VACUUM"
    if [ "$CHinfo_db" != "0" ]; then 
        #sqlite3 -cmd ".timeout 1000" /tmp/system.db "VACUUM"
	i=1
        while [ $i -le $CHinfo_db ]
	do 
	sqlite3 -cmd ".timeout 1000" /tmp/system.db "delete from wifiAOCSChstatus WHERE _ROWID_='$i'"
        i=`expr $i + 1`
	done 
	#sqlite3 -cmd ".timeout 1000" /tmp/system.db "VACUUM"
    fi
    # recreate the database column
    j=1  
    index_to_freq=2407 
    while [ $j -le $AvailCH ]
    do
    index_to_freq=`expr $index_to_freq + 5`
    sqlite3 -cmd ".timeout 1000" /tmp/system.db "insert into wifiAOCSChstatus VALUES('$j','$index_to_freq','-100','0');"
    j=`expr $j + 1`
    done
    sqlite3 -cmd ".timeout 1000" /tmp/system.db "VACUUM"

    if [ "$Debug" != "0" ]; then
        CHinfo_db_debug=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select count(*) from wifiAOCSChstatus;"`
    	echo "CHinfo_db_debug=$CHinfo_db_debug"
    fi
fi

if [ -f "$WLAN_AOCS_FILE" ]; then
    # read the channel loading information 
    cat $WLAN_AOCS_FILE | sed 1,2d | while read line
    do
	[ "$Debug" != "0" ] && echo "$line"
        CH=`echo $line | cut -d " " -f 1`
	CHLoad=`echo $line | cut -d " " -f 3`
	VisiableAP=`echo $line | cut -d " " -f 4`
  	[ "$Debug" != "0" ] && echo "CHLoad of CH($CH)=$CHLoad" 
  	[ "$Debug" != "0" ] && echo "VisiableAP of CH($CH)=$VisiableAP" 
	# update the channel information
        # using the CH as the ROWID, (2.4GHz only)
        sqlite3 -cmd ".timeout 1000" /tmp/system.db "update wifiAOCSChstatus set channelLoad='$CHLoad' where _ROWID_ = '$CH'"
        sqlite3 -cmd ".timeout 1000" /tmp/system.db "update wifiAOCSChstatus set visiableAP='$VisiableAP' where _ROWID_ = '$CH'"
    done
fi



