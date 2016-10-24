#!/bin/sh

BACKUP_LOG_PATH=/mnt/data/backup_log
test -d $BACKUP_LOG_PATH || mkdir $BACKUP_LOG_PATH

clean_all () {
	rm -rf $BACKUP_LOG_PATH/*
}

clean_up () {
	#FILE_COUNT=`ls -a1 $BACKUP_LOG_PATH | grep '^[a-zA-Z0-9]' | wc -l`
	FILE_COUNT=`find $BACKUP_LOG_PATH -name '*.tar' | wc -l`
	while [ $FILE_COUNT -gt $1 ]
	do
		rm -f $BACKUP_LOG_PATH/`ls $BACKUP_LOG_PATH | head -n 1`
		FILE_COUNT=`find $BACKUP_LOG_PATH -name '*.tar' | wc -l`
	done
}

clean_up 2

#FREE_SPACE=`df | grep /mnt/data | awk '{print $4}'`
#if [ "$FREE_SPACE" -le 10240 ] ; then
#        clean_all
#fi

LOG_NAME=`date +'%Y_%m_%d_%H%M'`.tar
#if [ "$FREE_SPACE" -gt 10240 ] ; then
tar -zcf $BACKUP_LOG_PATH/$LOG_NAME /var/log/messages* /tmp/lte.log /tmp/ltelog.gz /tmp/tr69client.log /tmp/tr69log.gz
#fi

TAR_FILE_SIZE=`ls -l $BACKUP_LOG_PATH/$LOG_NAME | awk '{print $5}'`
TAR_FILE_SIZE=`expr $TAR_FILE_SIZE / 1024`
TAR_FILE_SIZE=$(($TAR_FILE_SIZE+1))
FREE_SPACE=`df | grep /mnt/data | awk '{print $4}'`
if [ "$FREE_SPACE" -le "$TAR_FILE_SIZE" ] ; then
	ERROR_LOG_NAME=`date +'%Y_%m_%d_%H%M'`_error.tar
	echo "No space left on device, please contact operator." > $BACKUP_LOG_PATH/$ERROR_LOG_NAME
	#df >> $BACKUP_LOG_PATH/$ERROR_LOG_NAME
	echo "Available: `df | grep '/mnt/data' | awk '{print $4}'` KB" >> $BACKUP_LOG_PATH/$ERROR_LOG_NAME
	ls -lh $BACKUP_LOG_PATH | awk '{print $9,$5}' >> $BACKUP_LOG_PATH/$ERROR_LOG_NAME
fi

sync; sleep 3
