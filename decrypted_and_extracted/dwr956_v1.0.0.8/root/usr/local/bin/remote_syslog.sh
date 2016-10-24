#!/bin/sh

#MANU_FACT=`/usr/local/bin/sqlite3 /tmp/system.db "select vendor from system"`
#MANU_FACT=`cat /tmp/save_some_sysinfo.txt | grep MANU_FACT | awk -F\= '{print $2}'`
MANU_FACT=`echo NA`
#MODEL_NAME=`/usr/local/bin/sqlite3 /tmp/system.db "select name from system"`
MODEL_NAME=`cat /tmp/save_some_sysinfo.txt | grep MODEL_NAME | awk -F\= '{print $2}'`
#HW_VER=`cat /proc/cns3xxx/hwversion`
HW_VER=`echo NA`
#FW_VER=`/usr/local/bin/sqlite3 /tmp/system.db "select firmwareVer from system"`
FW_VER=`cat /tmp/save_some_sysinfo.txt | grep FW_VER | awk -F\= '{print $2}'`
MOD_HW_VER=`lte_get -D3 | cut -d= -f2`
if lte_get -D1 | grep -q OL19; then
    MOD_FW_VER=`lte_get -D1 | cut -d= -f2 | awk '{print $1}' | cut -b 19-26`
elif lte_get -D1 | grep -q D15Q1; then
    MOD_FW_VER=`lte_get -D1 | cut -d= -f2 | awk '{print $1}' | cut -b 7-22`
else
    MOD_FW_VER="Unknow"
fi

IMEI=`lte_get -d | grep IMEI | cut -d= -f2`
IMSI=`lte_get -D5 | grep IMSI | cut -d= -f2`
CLIENT_OS=`echo OS NA`
CELL_ID=`lte_get -n  | grep Cell | cut -d= -f2`

#DL_BYTES=`lte_get -n | grep "RX Packet" | awk '{print $6}'`
DL_BYTES=`ifconfig usb0 | grep 'RX bytes:' | awk '{print $2}' | awk -F: '{print $2}'`
let DL_BYTES/=1048576
#UL_BYTES=`lte_get -n | grep "TX Packet" | awk '{print $6}'`
UL_BYTES=`ifconfig usb0 | grep 'TX bytes:' | awk '{print $6}' | awk -F: '{print $2}'`
let UL_BYTES/=1048576
DL_PEAK=`echo NA`
UL_PEAK=`echo NA`
RAT_MASK=`lte_get --data-bearer | grep RAT | cut -b 19-20`
case $RAT_MASK in
   01)
      RAT="WCDMA";;
   02)
      RAT="GPRS";;
   04 | 05 | 08)
      RAT="HSPA";;
   10)
      RAT="EDGE";;
   20)
      RAT="LTE";;
   40)
      RAT="HSPA+";;
   80 | 84 | 88)
      RAT="DC-HSPA+";;
esac
if lte_get --rf-band-info | grep -q WCDMA; then
PRI_CARRIER="2100"
fi
if lte_get --rf-band-info | grep -q LTE; then
    LTE_BAND=`lte_get --rf-band-info | grep LTE | awk '{print $5}'`
case $LTE_BAND in
   3,)
      PRI_CARRIER="1800";;
   7,)
      PRI_CARRIER="2600";;
   8,)
      PRI_CARRIER="900";;
   20,)
      PRI_CARRIER="800";;
esac
fi
SEC_CARRIER=`echo NA`
if lte_get --rf-band-info | grep -q WCDMA; then
    PSC=`lte_get --cell | grep psc= | cut -b 17-`
    RSCP=`lte_get --cell | grep rscp= | cut -b 18-`
    RSSI=`lte_get --sig-info | cut -b 19-21`
    ECIO=`lte_get --sig-info | cut -b 29-37`
    TGSIGN1="3G_1_PSC/RSCP/ECIO/RSSI $PSC/$RSCP/$ECIO/$RSSI"
else
    TGSIGN1="3G_1_PSC/RSCP/ECIO/RSSI NA/NA/NA/NA"
fi
TGSIGN2="3G_2_PSC/RSCP/ECIO/RSSI NA/NA/NA/NA"
if lte_get --rf-band-info | grep -q LTE; then
    PCI=`lte_get --cell | grep serving_cell_id= | cut -b 43-`
    RSSI=`lte_get --sig-info | cut -b 17-19`
    RSRQ=`lte_get --sig-info | cut -b 27-28`
    RSRP=`lte_get --sig-info | cut -b 36-38`
    SNR=`lte_get --sig-info | cut -b 45-48`
    FGSIGN1="4G_1_PCI/RSRP/RSRQ/RSSI/SNR $PCI/$RSRP/$RSRQ/$RSSI/$SNR"
else
    FGSIGN1="4G_1_PCI/RSRP/RSRQ/RSSI/SNR NA/NA/NA/NA/NA"
fi
FGSIGN2="4G_2_PCI/RSRP/RSRQ/RSSI/SNR NA/NA/NA/NA/NA"
VEND=`echo Vend NA`

TIME=`date | awk '{print $2,$3,$4}'`
USB1IP=`ifconfig usb1 | grep 'inet addr:' | grep Bcast | awk '{print $2}' | awk -F: '{print $2}'`
#SN=`fw_printenv SN | sed 's/=/ /g'`
SN=`grep -w serNum /sysconfig/jnr-cfg.ascii | grep serNum | awk '{print $3}' | cut -d\" -f2`
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
#PNUM=`cat /flash/teamf1.cfg.ascii | grep USERNAME | awk '{print $3}' | sed 2d`
PNUM=`echo NA`
#REPLACE=`echo "[$USB1IP] [IMEI $IMEI] [IMSI $IMSI] [Cell-Id $CELL_ID] [$SN] [SYS-UPTIME $UPTIME] [HW $HW_VER] [FW $FW_VER] VOIP:"`

#VOIP_CALL_MGN=`cat /var/log/backup_msg | grep callmngr | awk '/Call Statistics|SIP Call Signaling|SIP Registration|Phone Event/{print}'| sed 's/DWR-923 user callmngr: /] '"$REPLACE"'/g' | awk '{printf("[")}{print}'`
FACILITY_RADIO=`cat /tmp/save_radio_syslog_conf.txt | grep FACILITY_RADIO | awk -F\= '{print $2}'`
SERVERITY_RADIO=`cat /tmp/save_radio_syslog_conf.txt | grep SERVERITY_RADIO | awk -F\= '{print $2}'`

logger -p $FACILITY_RADIO.$SERVERITY_RADIO "[$TIME][$USB1IP][IMEI $IMEI][IMSI $IMSI][Cell $CELL_ID][$SN][$UPTIME][$MANU_FACT][$MODEL_NAME][HW $HW_VER][FW $FW_VER][RadFW $MOD_FW_VER][$CLIENT_OS][SessDL $DL_BYTES][SessUL $UL_BYTES][PeakDL $DL_PEAK][PeakUL $UL_PEAK][RAT $RAT][PriCar $PRI_CARRIER][SecCar $SEC_CARRIER][$TGSIGN1][$TGSIGN2][$FGSIGN1][$FGSIGN2][$VEND]"
#echo "[$TIME][$USB1IP][IMEI $IMEI][IMSI $IMSI][Cell $CELL_ID][$SN][$UPTIME][$MANU_FACT][$MODEL_NAME][HW $HW_VER][FW $FW_VER][RadFW $MOD_FW_VER][$CLIENT_OS][SessDL $DL_BYTES][SessUL $UL_BYTES][PeakDL $DL_PEAK][PeakUL $UL_PEAK][RAT $RAT][PriCar $PRI_CARRIER][SecCar $SEC_CARRIER][$TGSIGN1][$TGSIGN2][$FGSIGN1][$FGSIGN2][$VEND]" > /tmp/MyTestLog

#if [ x"$VOIP_CALL_MGN" != x"" ]; then
#  echo "$VOIP_CALL_MGN" >> /tmp/voip_log
#  logger -p alert -f /tmp/voip_log
#  rm /tmp/voip_log
#  echo 0 > /var/log/backup_msg
#fi
