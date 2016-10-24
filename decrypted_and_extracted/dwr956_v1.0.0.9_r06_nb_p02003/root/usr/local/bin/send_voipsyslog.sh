#!/bin/sh
#change VoIP debug level db_cmd.sh 6 LOG_DEBUG_EXTRA LOG_INFO

sleep 20

uptime1() {
	SECS=`uptime | cut -d: -f3 | awk '{print $1}'`
	if uptime | grep -q day; then
	   DAYS=`uptime | awk '{print $3}'`
	   if uptime | awk '{print $5}' | grep -q :; then
	      HOURS=`uptime | awk '{print $5}' | awk -F: '{print $1}'`
	      MINS=`uptime | awk '{print $5}' | awk -F: '{print $2}' | sed 's/,//g'`
	      UPTIME="$DAYS:$HOURS:$MINS:$SECS"
	   else
	      MINS=`uptime | awk '{print $5}'`
	      UPTIME="$DAYS:00:$MINS:$SECS"
	   fi
	else
	   if uptime | awk '{print $3}' | grep -q :; then
	      HOURS=`uptime | awk '{print $3}' | awk -F: '{print $1}'`
	      MINS=`uptime | awk '{print $3}' | awk -F: '{print $2}' | sed 's/,//g'`
	      UPTIME="0:$HOURS:$MINS:$SECS"
	   else
	      MINS=`uptime | awk '{print $3}'`
	      UPTIME="0:0:$MINS:$SECS"
	   fi
	fi
}

#TIME=`date | awk '{print $2,$3,$4}'`
IMEI=`lte_get -d | grep IMEI | cut -d= -f2`
IMSI=`lte_get -D5 | grep IMSI | cut -d= -f2`
CELL_ID=`lte_get -n  | grep Cell | cut -d= -f2`
#SN=`fw_printenv SN | sed 's/=/ /g'`
SN=`echo NA`
#HW_VER=`cat /proc/cns3xxx/hwversion`
HW_VER=`echo NA`
#FW_VER=`/usr/local/bin/sqlite3 /tmp/system.db "select firmwareVer from system"`
FW_VER=`cat /tmp/save_some_sysinfo.txt | grep FW_VER | awk -F\= '{print $2}'`
while (([ x"$FW_VER" == x"" ] ))
do
   sleep 1
   #FW_VER=`/usr/local/bin/sqlite3 /tmp/system.db "select firmwareVer from system"`
   FW_VER=`cat /tmp/save_some_sysinfo.txt | grep FW_VER | awk -F\= '{print $2}'`
done

#tail -f -n0 /var/log/messages | while read line
touch /tmp/callmgr_sip_msg.log
#touch /tmp/testVoIPTmp.txt
tail -f -n0 /tmp/callmgr_sip_msg.log | while read line
do
    #echo "@@@------------------------------separator------------------------------"
    #echo "@@@Read line=$line"
    USB1IP=`ifconfig usb1 2>/dev/null | grep 'inet addr:' | grep Bcast | awk '{print $2}' | awk -F: '{print $2}'`
    #if [ x"$USB1IP" != x"" ]; then
#    FILTER_LOG=`echo $line | grep callmngr | grep '\[[1-6]\]' | awk '/Call Statistics|SIP Call Signaling|SIP Registration|Phone Event/{print}'`
    FILTER_LOG_PHONE=""
    FILTER_LOG_PHONE=`echo $line | grep '\[FXS\]' | awk '/MsgRouterEvtHdlr|IdleOffHookHdlr|DialingRmtAcceptHdlr|RemoteAnswerHdlr|RemoteCallHold|RemoteCallResume/{print}'`
    #echo "FILTER_LOG_PHONE=$FILTER_LOG_PHONE" >> /tmp/testVoIPTmp.txt
    FILTER_LOG_SIP=""
    if [ "$FILTER_LOG_PHONE" = "" ]; then
        FILTER_LOG_SIP_TMP=`echo $line | grep 'SIP/2.0' | awk '{print $1}'`
        if [ "$FILTER_LOG_SIP_TMP" == "SIP/2.0" ]; then
            FILTER_LOG_SIP=`echo $line`
            #echo "FILTER_LOG_SIP=$FILTER_LOG_SIP" >> /tmp/testVoIPTmp.txt
        fi
    fi
    #if [ x"$FILTER_LOG" != x"" ]; then
    if [ "$FILTER_LOG_PHONE" != "" ] || [ "$FILTER_LOG_SIP" != "" ]; then
        uptime1
        FACILITY_VOIP=`cat /tmp/save_voip_syslog_conf.txt | grep FACILITY_VOIP | awk -F\= '{print $2}'`
        SEVERITY_VOIP=`cat /tmp/save_voip_syslog_conf.txt | grep SERVERITY_VOIP | awk -F\= '{print $2}'`        
        
        REPLACE=""
        FINAL_OUT=""
        if [ "$FILTER_LOG_PHONE" != "" ]; then
            #echo "EnterPhone" >> /tmp/testVoIPTmp.txt
            TIME=`date | awk '{print $2,$3,$4}'`
            REPLACE=`echo "[$TIME] [$USB1IP] [IMEI $IMEI] [IMSI $IMSI] [Cell-Id $CELL_ID] [$SN] [SYS-UPTIME $UPTIME] [HW $HW_VER] [FW $FW_VER] VOIP: "`
            FINAL_OUT=`echo $FILTER_LOG_PHONE | cut -f1,5- -d' ' | sed 's/\[FXS\] / '"$REPLACE"'/g'`
        elif [ "$FILTER_LOG_SIP" != "" ]; then 
            #echo "EnterSIP" >> /tmp/testVoIPTmp.txt
            TIME=`date | awk '{print $2,$3,$4}'`
            REPLACE=`echo "[$TIME] [$USB1IP] [IMEI $IMEI] [IMSI $IMSI] [Cell-Id $CELL_ID] [$SN] [SYS-UPTIME $UPTIME] [HW $HW_VER] [FW $FW_VER] VOIP:"`   
            FINAL_OUT=`echo $REPLACE$FILTER_LOG_SIP`
        fi
#        logger -p $FACILITY_VOIP.$SERVERITY_VOIP $REPLACE
#        sleep 60
        #echo "@@@Replace header=$REPLACE"
#        FINAL_OUT=`echo $FILTER_LOG | sed 's/DWR-923 user callmngr: /] '"$REPLACE"'/g' | awk '{printf("[")}{print}' | cut -b 1,6-`
        #echo "FINAL_OUT=$FINAL_OUT" >> /tmp/testVoIPTmp.txt
        logger -p $FACILITY_VOIP.$SEVERITY_VOIP "$FINAL_OUT"
        #echo "@@@Final out=$FINAL_OUT"
#        echo "$FINAL_OUT" >> /tmp/voip_log
#        echo "$REPLACE" >> /tmp/voip_log
#        cat /tmp/voip_log | while read line
#        do
            #echo "@@@Send out=$line"
#            if ! echo $line | grep -q 'DTMF\[[ ]\]'; then
#            if ! echo $line; then
#                logger -p info $line
#            fi
#        done
#        rm /tmp/voip_log
    fi
    #else
        #echo "NO IP"
    #fi

    #USB1IP=`ifconfig usb1 2>/dev/null | grep 'inet addr:' | grep Bcast | awk '{print $2}' | awk -F: '{print $2}'`
    #VOIP='echo VoIPNA'
    #logger -p info "[$TIME][$USB1IP][IMEI $IMEI][IMSI $IMSI][Cell $CELL_ID][$SN][$UPTIME][HW $HW_VER][FW $FW_VER][$VOIP]"
done 
