#!/bin/sh
while :
do
cpuLoad=$(top -n 1 | grep mini_httpd | awk '{print $7}' | cut -d % -f1)
if [ -n $cpuLoad ];then
    if [ $cpuLoad -ge 99 ];then
	echo "kill mini_httpd"
	kill -9 `cat /var/run/mini_httpd.pid`
    fi
fi
sleep 10
done
