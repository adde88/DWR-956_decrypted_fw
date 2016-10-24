#config.lteHwInfo[1]["IMEI"] = ""
FILE_NEED_TO_PROCESS=$1
FILE_GET_MAC=/tmp/mac
NOW_IMEI_VALUE=`cat $FILE_GET_MAC |grep "IMEI="|cut -d= -f2`

if [ -z "$NOW_IMEI_VALUE" ];then
NOW_IMEI_VALUE="9876543210"
fi

if [ ! -f "$FILE_NEED_TO_PROCESS" ] ; then 
        echo "no such file $FILE_NEED_TO_PROCESS" 
        exit 0
fi

#default IMEI
echo $NOW_IMEI_VALUE
HAS_IMEI_1_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.lteHwInfo\[1\]\[\"IMEI\"\]"`
if [ -n "$HAS_IMEI_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.lteHwInfo\[1\]\[\"IMEI\"\]"'.*/'"config.lteHwInfo\[1\]\[\"IMEI\"\] = \"$NOW_IMEI_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.lteHwInfo[1][\"IMEI\"]=\"$NOW_IMEI_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi


