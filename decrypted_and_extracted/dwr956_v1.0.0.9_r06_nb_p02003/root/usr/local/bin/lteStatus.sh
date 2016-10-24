#!/bin/sh

CUR_CONFIG_PATH=/sysconfig/jnr-cfg.ascii
APNPROFILE=/tmp/getAPNProfile
APNSTATUS=/tmp/getIPStatus
PINCONFIG=/tmp/getPinConfig
WANINFO=/tmp/getWanInfo
NETWORKINFO=/tmp/getNetworkInfo
LTERADIO=/tmp/getLTERadio

case $1 in
 getAPNProfiles)
  `lte_get -i 0 1 --timeout 5000 > $APNPROFILE`
  PROFILE_NAME_1=`grep 'CLIENT:Profile Name' $APNPROFILE | awk -F '=' '{print $2}'`
  APN_NAME_1=`grep 'CLIENT:APN Name' $APNPROFILE | awk -F '=' '{print $2}'`
  `lte_get -i 0 2 --timeout 5000 > $APNPROFILE`
  PROFILE_NAME_2=`grep 'CLIENT:Profile Name' $APNPROFILE | awk -F '=' '{print $2}'`
  APN_NAME_2=`grep 'CLIENT:APN Name' $APNPROFILE | awk -F '=' '{print $2}'`
  if [ -z "$PROFILE_NAME_1" ] ; then
    PROFILE_NAME_1=`grep 'config.lteNwProfile\[1\]\["name"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
  fi
  if [ -z "$APN_NAME_1" ] ; then
    APN_NAME_1=`grep 'config.lteNwProfile\[1\]\["APNName"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
  fi
  if [ -z "$PROFILE_NAME_2" ] ; then
    PROFILE_NAME_2=`grep 'config.lteNwProfile\[2\]\["name"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
  fi
  if [ -z "$APN_NAME_2" ] ; then
    APN_NAME_2=`grep 'config.lteNwProfile\[2\]\["APNName"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
  fi
  echo -e "$PROFILE_NAME_1" > $APNPROFILE
  echo -e "$APN_NAME_1" >> $APNPROFILE
  echo -e "$PROFILE_NAME_2" >> $APNPROFILE
  echo -e "$APN_NAME_2" >> $APNPROFILE
  ;;
 getAPNStatus)
  IP_STATUS_1=`lte_get --ip-status -q 0 --timeout 5000 | grep 'CLIENT:status:' | awk -F ':' '{print $3}'`
  IP_STATUS_2=`lte_get --ip-status -q 1 --timeout 5000 | grep 'CLIENT:status:' | awk -F ':' '{print $3}'`
  if [ -z "$IP_STATUS_1" ] ; then
    IP_STATUS_1=`grep 'config.lteIPStatus\[1\]\["status"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
  fi
  if [ -z "$IP_STATUS_2" ] ; then
    IP_STATUS_2=`grep 'config.lteIPStatus\[2\]\["status"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
  fi
  echo -e "$IP_STATUS_1" > $APNSTATUS
  echo -e "$IP_STATUS_2" >> $APNSTATUS
  ;;
 getPinConfig)
  `lte_get -p --timeout 5000 > $PINCONFIG`
  PIN_STATUS=`grep 'CLIENT:PIN1=' $PINCONFIG`
  if [ -n "$PIN_STATUS" ] ; then
    PIN_STATUS_1=`grep 'CLIENT:PIN1' $PINCONFIG | awk -F ', ' '{print $1}' | awk -F '=' '{print $2}'`
    PIN_VERIFY_1=`grep 'CLIENT:PIN1' $PINCONFIG | awk -F ', ' '{print $2}' | awk -F ':' '{print $2}'`
    PIN_UNBLOCK_1=`grep 'CLIENT:PIN1' $PINCONFIG | awk -F ', ' '{print $3}' | awk -F ':' '{print $2}'`
    if [ -z "$PIN_STATUS_1" ] ; then
      PIN_STATUS_1=`grep 'config.ltePinStatus\[1\]\["pinStatus"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
    fi
    if [ -z "$PIN_VERIFY_1" ] ; then
      PIN_VERIFY_1=`grep 'config.ltePinStatus\[1\]\["pinVerifyRetryLeft"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
    fi
    if [ -z "$PIN_UNBLOCK_1" ] ; then
      PIN_UNBLOCK_1=`grep 'config.ltePinStatus\[1\]\["pinUnblockRetryLeft"\]' $CUR_CONFIG_PATH | awk -F '= ' '{print $2}' | cut -d'"' -f2`
    fi
  else
    PIN_STATUS=`grep 'Error:' $PINCONFIG`
    if [ -n "$PIN_STATUS" ] ; then
      PIN_STATUS_1="-1"
    else
      PIN_STATUS_1="0"
    fi
    PIN_VERIFY_1="0"
    PIN_UNBLOCK_1="0"
  fi
  echo -e "$PIN_STATUS_1" > $PINCONFIG
  echo -e "$PIN_VERIFY_1" >> $PINCONFIG
  echo -e "$PIN_UNBLOCK_1" >> $PINCONFIG
  ;;
 getWanInfo)
  `lte_get --ip-status -q 0 --timeout 5000 > $WANINFO`
  IP_ADDR_1=`grep 'CLIENT:ip address:' $WANINFO | awk -F ':' '{print $3}'`
  IP_GATEWAY_1=`grep 'CLIENT:gateway:' $WANINFO | awk -F ':' '{print $3}'`
  IP_PRIMARY_DNS_1=`grep 'CLIENT:primary DNS:' $WANINFO | awk -F ':' '{print $3}'`
  if [ -n "$IP_ADDR_1" ] ; then
    echo "$IP_ADDR_1" > $WANINFO
  else
    echo "0.0.0.0" > $WANINFO
  fi
  if [ -n "$IP_GATEWAY_1" ] ; then
    echo "$IP_GATEWAY_1" >> $WANINFO
  else
    echo "0.0.0.0" >> $WANINFO
  fi
  if [ -n "$IP_PRIMARY_DNS_1" ] ; then
    echo "$IP_PRIMARY_DNS_1" >> $WANINFO
  else
    echo "0.0.0.0" >> $WANINFO
  fi
  ;;
 getNetworkInfo)
  `lte_get -n -q 0 --timeout 5000 > $NETWORKINFO`
  NETWORK_NAME=`grep 'CLIENT:Network Description' $NETWORKINFO | awk -F '=' '{print $2}'`
  REGIST_STATUS=`grep 'CLIENT:Registration State' $NETWORKINFO | awk -F '=' '{print $2}'`
  RADIO_INTERFERENCE=`lte_get --signal-strength -q 0 --timeout 5000 | grep 'CLIENT:Signal Strength' | awk -F ',' '{print $2}'`
  echo -e "$NETWORK_NAME" > $NETWORKINFO
  echo -e "$RADIO_INTERFERENCE" >> $NETWORKINFO
  echo -e "$REGIST_STATUS" >> $NETWORKINFO
  ;;
 getLTERadio)
  `lte_get -S --timeout 5000 > $LTERADIO`
  LTE_MODE=`grep 'CLIENT:MODE PREFERENCE=' $LTERADIO | awk -F '=' '{print $2}'`
  LTE_BAND=`grep 'CLIENT:LTE BAND PREFERENCE=' $LTERADIO | awk -F '=' '{print $2}'`
  if [ -z "$LTE_MODE" ] ; then
    LTE_MODE="auto"
  fi
  if [ -z "$LTE_BAND" ] ; then
    LTE_BAND="auto"
  fi
  echo -e "$LTE_MODE" > $LTERADIO
  echo -e "$LTE_BAND" >> $LTERADIO
  ;;
 *)
  exit 1
  ;;
esac
