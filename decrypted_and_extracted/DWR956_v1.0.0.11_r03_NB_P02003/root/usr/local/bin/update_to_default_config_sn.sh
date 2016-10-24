#config.system[1]["serNum"]=""
FILE_NEED_TO_PROCESS=$1
FILE_GET_MAC=/tmp/mac
NOW_SN_VALUE=`cat $FILE_GET_MAC |grep "SN="|cut -d= -f2`
if [ -z "$NOW_SN_VALUE" ];then
NOW_SN_VALUE="9876543210"
fi

if [ ! -f "$FILE_NEED_TO_PROCESS" ] ; then 
        echo "no such file $FILE_NEED_TO_PROCESS" 
        exit 0
fi

#default SN
echo $NOW_SN_VALUE
HAS_SN_1_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.system\[1\]\[\"serNum\"\]"`
if [ -n "$HAS_SN_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.system\[1\]\[\"serNum\"\]"'.*/'"config.system\[1\]\[\"serNum\"\] = \"$NOW_SN_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.system[1][\"serNum\"]=\"$NOW_SN_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi


