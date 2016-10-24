#!/bin/sh

LOGFILE=${1}.1
COMPRESS_LOGFILE=${1%/*}/tr69log.gz
if [ -e $COMPRESS_LOGFILE ]; then
	COMPRESS_LOGFILESIZE=`ls -l $COMPRESS_LOGFILE | awk '{print $5}'`
	MAX_COMPRESS_LOGFILESIZE=$((5*1024*1024))
	
	if [ "$COMPRESS_LOGFILESIZE" -ge "$MAX_COMPRESS_LOGFILESIZE" ]; then
	  echo "backup tr69 compressed log file"
	  LOGFILESIZE=`ls -l $LOGFILE | awk '{print $5}'`
	  zcat $COMPRESS_LOGFILE | tail -c +$LOGFILESIZE | gzip -c - > $COMPRESS_LOGFILE.tmp
	  rm -f $COMPRESS_LOGFILE
	  mv $COMPRESS_LOGFILE.tmp $COMPRESS_LOGFILE
	fi
fi
echo "backup tr69 log file"
gzip -c $LOGFILE >> $COMPRESS_LOGFILE
rm -f $LOGFILE
