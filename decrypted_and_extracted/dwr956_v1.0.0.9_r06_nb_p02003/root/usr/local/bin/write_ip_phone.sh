#!/bin/sh

IPPHONE_LIST=/tmp/ip_phone_list

ip rule del from $1 table 20

ip rule add from $1 table 20

conntrack -D -s $1

cat $IPPHONE_LIST | grep "$1"
if [ $? != 0 ];then
	echo "$1" >> $IPPHONE_LIST
fi
