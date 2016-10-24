#!/bin/sh

CONFIG_FILE=/tmp/ddns_inadyn.conf
LOG_FILE=/tmp/ddns_log

# First killall dhcp service and lease table
killall -9 inadyn

rm -f $LOG_FILE
rm -f $CONFIG_FILE

DDNSSERVICE=`sqlite+ /tmp/system.db "select ddnsService from ddns"`
if [ "$DDNSSERVICE" != "none" ]; then
    IF=`sqlite+ /tmp/system.db "select interfaceName from ddns"`
    HOST=`sqlite+ /tmp/system.db "select hostname from ddns"`
    USER=`sqlite+ /tmp/system.db "select username from ddns"`
    PASS=`sqlite+ /tmp/system.db "select password from ddns"`
    TIMEPERIOD=`sqlite+ /tmp/system.db "select timePeriod from ddns"`
    WILDFLAG=`sqlite+ /tmp/system.db "select wildflag from ddns"`
	
	# Conversion day to second
    TIMEPERIOD=`expr $TIMEPERIOD \* 86400`
		 	
	# add update time
	echo "forced_update_period $TIMEPERIOD" > $CONFIG_FILE	# update every 10 minutes
	
	echo "username $USER" >> $CONFIG_FILE
	echo "password $PASS" >> $CONFIG_FILE
	echo "alias $HOST"  >> $CONFIG_FILE
	
	# background perform inadyn
	echo "background" >> $CONFIG_FILE
	
	# add two check ip server
	echo "ip_server_name checkip.two-dns.de:80 /"  >> $CONFIG_FILE
	echo "ip_server_name checkip.dyndns.org:8245 /"  >> $CONFIG_FILE
		
	if [ "$DDNSSERVICE" = "dyndns.org" ];then
		echo "dyndns_system custom@dyndns.org"  >> $CONFIG_FILE
	fi
	if [ "$DDNSSERVICE" = "qdns" ];then
		echo "dyndns_system custom@http_svr_basic_auth"  >> $CONFIG_FILE
		echo "dyndns_server_name www.3322.org"  >> $CONFIG_FILE
		echo "dyndns_server_url /dyndns/update?hostname="  >> $CONFIG_FILE
	fi
	if [ "$DDNSSERVICE" = "dlink" ];then
		echo "dyndns_system custom@dyndns.org"  >> $CONFIG_FILE
	fi
	if [ "$DDNSSERVICE" = "noip" ];then
		echo "dyndns_system default@no-ip.com"  >> $CONFIG_FILE
	fi
	if [ "$DDNSSERVICE" = "dtdns" ]; then
		echo "dyndns_system custom@http_svr_basic_auth"  >> $CONFIG_FILE
		echo "dyndns_server_name www.dtdns.com"  >> $CONFIG_FILE
		echo "dyndns_server_url /api/autodns.cfm?id=$HOST&pw=$PASS&client="  >> $CONFIG_FILE
	fi
	#echo "verbose 5"  >> $CONFIG_FILE
	#echo "log_file $LOG_FILE"  >> $CONFIG_FILE
	echo "syslog "  >> $CONFIG_FILE
	
	# perform inadyn
	inadyn --input_file $CONFIG_FILE
fi
