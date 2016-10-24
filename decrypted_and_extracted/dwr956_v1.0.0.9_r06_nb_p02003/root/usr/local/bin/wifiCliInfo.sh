#!/bin/sh
DelMAC=$1
#echo "MAC=$DelMAC"
sqlite3 -cmd ".timeout 1000" /tmp/system.db "delete from DhcpLeasedClients WHERE MacAddr='$DelMAC'"
#rearrange the table again
sqlite3 /tmp/system.db "VACUUM"
#echo "0" > /tmp/cliInfo
