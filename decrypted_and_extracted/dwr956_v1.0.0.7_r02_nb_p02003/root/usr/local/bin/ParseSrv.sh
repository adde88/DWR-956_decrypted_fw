#!/bin/sh
#
#

sqlite3 -cmd ".timeout 1000" /tmp/system.db "delete from DNSSrv";

# disable srv function
if [ -f /tmp/disable_SRV ]; then
	echo "disable DNS SRV function"
	exit 0
fi

# enable srv function
echo "start srv parsing..."
dig $1 srv | awk -F"SRV" '/SRV/ && $0!~/;/ {print $2}' > /tmp/DNStemp
sleep 3
sed 's/.$//' /tmp/DNStemp > /tmp/DNStemp1
rm -f /tmp/DNStemp
echo "query done."

echo "#!/bin/sh" > /tmp/DNStemp1.sh

awk '{print "sqlite3 -cmd \".timeout 1000\" /tmp/system.db \"insert into DNSSrv values("$1", " $2", " $3", '\''" $4"'\'');\""}' /tmp/DNStemp1 >> /tmp/DNStemp1.sh

chmod 777 /tmp/DNStemp1.sh
sh /tmp/DNStemp1.sh
rm -f /tmp/DNStemp1
rm -f /tmp/DNStemp1.sh
exit 0
