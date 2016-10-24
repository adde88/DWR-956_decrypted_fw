#!/bin/sh /etc/rc.common

START=992

start() 
{
# In bridge mode, do not init wifi
	NATENABLE=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from FirewallNatConfig;"`
	if [ "$NATENABLE" = "5" ]; then 
		return
	fi	
#temp sol : put the wifi AC intial script here
    [ -e /usr/local/bin/wifiACInit ]  && /usr/local/bin/wifiACInit
}



