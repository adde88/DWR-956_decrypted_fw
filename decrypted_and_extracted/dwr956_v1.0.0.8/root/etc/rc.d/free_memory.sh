#!/bin/sh
# Kill heavy duty daemons before firmware download

kill_daemon ()
{
	killall $@ >&- 2>&-
}

for _apps in check_dsl snmpd minidlna smbd mountd; do
	kill_daemon $_apps
done

if [ "$1" != "tr69" ] && [ "$1" != "tr69_postdl" ] && [ "$1" != "diag" ]; then
	kill_daemon devm
fi

if [ "$1" != "http" ] && [ "$1" != "diag" ]; then
	kill_daemon dwatch
	kill_daemon mini_httpd
fi
if [ "$1" != "tftp" ]; then
	kill_daemon tftpd
fi
if [ "$1" != "ftp" ]; then
	kill_daemon ftpd
fi

echo 1 > /proc/sys/vm/drop_caches; sleep 1
sync

