#config.wifiProfiloe[1]["ssid"] = 
FILE_NEED_TO_PROCESS=$1
FILE_GET_MAC=/tmp/mac
NOW_ESSID_VALUE=`cat $FILE_GET_MAC |grep "SSID="|cut -d= -f2`
COUNT=1
# REAL_ESSID_VALUE="$NOW_ESSID_VALUE""$COUNT"
REAL_ESSID_VALUE="$NOW_ESSID_VALUE"
if [ "$REAL_ESSID_VALUE" == "" ] ; then
    REAL_ESSID_VALUE="1"
    noSSID=1
fi
if [ -z "$NOW_ESSID_VALUE" ];then
NOW_ESSID_VALUE="IAD_NEED_INPUT"
fi

if [ ! -f "$FILE_NEED_TO_PROCESS" ] ; then 
	echo "no such file $FILE_NEED_TO_PROCESS" 
	exit 0
fi


#wlan0 essid
echo $REAL_ESSID_VALUE
HAS_ESSID_1_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.wifiProfile\[1\]\[\"ssid\"\]"`
if [ -n "$HAS_ESSID_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.wifiProfile\[1\]\[\"ssid\"\]"'.*/'"config.wifiProfile\[1\]\[\"ssid\"\] = \"$REAL_ESSID_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.wifiProfile[1][\"ssid\"]=\"$REAL_ESSID_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi



#wlan0.0  essid
COUNT=2
# REAL_ESSID_VALUE="$NOW_ESSID_VALUE""$COUNT"
if [ "$noSSID" = "1" ] ; then
	REAL_ESSID_VALUE="iad_ap2"
else
	REAL_ESSID_VALUE="GUEST"
fi
echo $REAL_ESSID_VALUE
HAS_ESSID_2_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.wifiProfile\[2\]\[\"ssid\"\]"`
if [ -n "$HAS_ESSID_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.wifiProfile\[2\]\[\"ssid\"\]"'.*/'"config.wifiProfile\[2\]\[\"ssid\"\] = \"$REAL_ESSID_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.wifiProfile[2][\"ssid\"]=\"$REAL_ESSID_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi





#wlan0.1 essid
COUNT=3
PREFIX=`cat $FILE_GET_MAC |grep "SSID="|cut -d= -f2 | cut -d "_" -f1`
MAC=`cat $FILE_GET_MAC |grep "SSID="|cut -d= -f2 | cut -d "_" -f2`
POSTFIX=`cat $FILE_GET_MAC |grep "SSID="|cut -d= -f2 | cut -d "_" -f3`
#echo "cut MAC=$MAC"

if [ "${POSTFIX}" == "11n" ]; then
	POSTFIX="_11ac"
else
	POSTFIX=""
fi

if [ "$MAC" == "000000" ]; then
    REAL_ESSID_VALUE="${PREFIX}_000000${POSTFIX}"
    #echo "cut MAC-1=$MAC"
else 
    MAC=`printf "%d" 0x$MAC`
    MAC=`expr $MAC - 1`
    MAC=`printf "%06X" $MAC`
    #echo "cut MAC-1=$MAC"
    REAL_ESSID_VALUE="${PREFIX}_${MAC}${POSTFIX}"
fi

#REAL_ESSID_VALUE="$NOW_ESSID_VALUE""$COUNT"
echo $REAL_ESSID_VALUE
HAS_ESSID_3_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.wifiProfile\[3\]\[\"ssid\"\]"`
if [ -n "$HAS_ESSID_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.wifiProfile\[3\]\[\"ssid\"\]"'.*/'"config.wifiProfile\[3\]\[\"ssid\"\] = \"$REAL_ESSID_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.wifiProfile[3][\"ssid\"]=\"$REAL_ESSID_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi




#wlan0.2 essid
COUNT=4
#REAL_ESSID_VALUE="$NOW_ESSID_VALUE""$COUNT"
if [ "$noSSID" = "1" ] ; then
        REAL_ESSID_VALUE="iad_ap2"
else
        REAL_ESSID_VALUE="GUEST"
fi

echo $REAL_ESSID_VALUE
HAS_ESSID_4_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.wifiProfile\[4\]\[\"ssid\"\]"`
if [ -n "$HAS_ESSID_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.wifiProfile\[4\]\[\"ssid\"\]"'.*/'"config.wifiProfile\[4\]\[\"ssid\"\] = \"$REAL_ESSID_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.wifiProfile[4][\"ssid\"]=\"$REAL_ESSID_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi




