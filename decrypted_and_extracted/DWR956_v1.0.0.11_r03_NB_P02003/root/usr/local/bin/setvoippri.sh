#!/bin/sh

#This script is to set voip priority.

DB_LOG="/tmp/setvoippri.log"

if [ ! -f $DB_LOG ]
then
   touch $DB_LOG
else   
   rm $DB_LOG
   touch $DB_LOG
fi

PSTMP=/tmp/voipps.tmp


rm -f $PSTMP

pgrep GwApp > $PSTMP
pgrep Rtp >> $PSTMP
pgrep Fax >> $PSTMP

while read line
do
echo process id = $line >> $DB_LOG
chrt -f -p 50 $line >> $DB_LOG
renice -10 $line 
done < $PSTMP

#Start dns cache script
#/sbin/voip_dns_cache.sh &
