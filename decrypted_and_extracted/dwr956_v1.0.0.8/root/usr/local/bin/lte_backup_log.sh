#!/bin/sh

LOG_COMPRESS=/tmp/ltelog.gz
BACKUP=$1
LOGFILE=$2
LOGFILESIZE=$3

if [ "$BACKUP" == "r" ]; then
  zcat $LOG_COMPRESS | tail -c +$LOGFILESIZE | gzip -c - > $LOG_COMPRESS.tmp
  rm -f $LOG_COMPRESS
  mv $LOG_COMPRESS.tmp $LOG_COMPRESS
fi

gzip -c $LOGFILE >> $LOG_COMPRESS
rm -f $LOGFILE
