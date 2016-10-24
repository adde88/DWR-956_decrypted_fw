#config.wifiProfile[1]["pskPassAscii"] =
FILE_NEED_TO_PROCESS=$1
FILE_GET_MAC=/tmp/mac
NOW_KEY_VALUE=`cat $FILE_GET_MAC |grep "KEY="|cut -d= -f2`
if [ -z "$NOW_KEY_VALUE" ];then
NOW_KEY_VALUE="9876543210"
fi

if [ ! -f "$FILE_NEED_TO_PROCESS" ] ; then 
        echo "no such file $FILE_NEED_TO_PROCESS" 
        exit 0
fi


#wlan0 wpa key
echo $REAL_KEY_VALUE
HAS_KEY_1_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.wifiProfile\[1\]\[\"pskPassAscii\"\]"`
if [ -n "$HAS_KEY_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.wifiProfile\[1\]\[\"pskPassAscii\"\]"'.*/'"config.wifiProfile\[1\]\[\"pskPassAscii\"\] = \"$NOW_KEY_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.wifiProfile[1][\"pskPassAscii\"]=\"$REAL_KEY_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi


#wlan0.0  wpa key
echo $REAL_KEY_VALUE
HAS_KEY_2_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.wifiProfile\[2\]\[\"pskPassAscii\"\]"`
if [ -n "$HAS_KEY_2_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.wifiProfile\[2\]\[\"pskPassAscii\"\]"'.*/'"config.wifiProfile\[2\]\[\"pskPassAscii\"\] = \"$NOW_KEY_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.wifiProfile[2][\"pskPassAscii\"]=\"$REAL_KEY_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi


#wlan0.1 wpa key
echo $REAL_KEY_VALUE
HAS_KEY_3_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.wifiProfile\[3\]\[\"pskPassAscii\"\]"`
if [ -n "$HAS_KEY_3_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.wifiProfile\[3\]\[\"pskPassAscii\"\]"'.*/'"config.wifiProfile\[3\]\[\"pskPassAscii\"\] = \"$NOW_KEY_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
#        echo "config.wifiProfile[3][\"pskPassAscii\"]=\"$REAL_KEY_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi


#wlan0.2 wpa key
echo $REAL_KEY_VALUE
HAS_KEY_4_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.wifiProfile\[4\]\[\"pskPassAscii\"\]"`
if [ -n "$HAS_KEY_4_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.wifiProfile\[4\]\[\"pskPassAscii\"\]"'.*/'"config.wifiProfile\[4\]\[\"pskPassAscii\"\] = \"$NOW_KEY_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
#        echo "config.wifiProfile[4][\"pskPassAscii\"]=\"$REAL_KEY_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi




