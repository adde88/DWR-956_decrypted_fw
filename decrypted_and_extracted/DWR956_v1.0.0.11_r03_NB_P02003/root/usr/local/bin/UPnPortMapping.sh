#!/bin/sh

PORTMAP_FILE=/tmp/upnp_portmap

if [ "_$1" = "_refresh" ]; then

	echo "UPnP Port Mapping Table : Refresh"
	iptables -t nat -L UPNP -n > $PORTMAP_FILE
	sqlite3 -cmd ".timeout 1000" /tmp/system.db "delete from UPNPortMap;"	

	while read line
	do
	        export line
	        forward=$(awk 'BEGIN{ print index(ENVIRON["line"] ,"DNAT")}')
	        if [ $forward -gt 0 ];then
	                Protocol=`echo "$line" | sed 's/^.*DNAT       //g' | sed 's/  --.*$//g'`

	                Remote=`echo "$line" | sed 's/^.*--  //g' | sed 's/ 0.0.*$//g'`

	                Ex_Port=`echo "$line" | grep dpt | sed 's/^.*dpt://g' | sed 's/ to:.*$//g'`

	                In_Port=`echo "$line" | sed 's/^.* to://g' | sed 's/^.*://g'`

	                DestIP=`echo "$line" | sed 's/^.* to://g' | sed 's/:.*$//g'`
	                
#	                echo "Protocol=$Protocol"
#	                echo "Remote=$Remote"
#	                echo "Ex_Port=$Ex_Port"
#	                echo "In_Port=$In_Port"
#	                echo "DestIP=$DestIP"

	                sqlite3 -cmd ".timeout 1000" /tmp/system.db "insert into UPNPortMap values ('$DestIP','$Protocol','$In_Port','$Ex_Port');"
	        fi
	done < $PORTMAP_FILE
	
elif [ "_$1" = "_clear" ]; then

	echo "UPnP Port Mapping Table : Clear"
	
	# GARYeh 20140211: clear UPNP chain for restart UPNP
	sqlite3 -cmd ".timeout 1000" /tmp/system.db "delete from UPNPortMap;"
	iptables -F UPNP
	iptables -t nat -F UPNP	
else
	echo "Unknow parameter!!"
fi
