#!/bin/sh

FILE_GET_MAC=/tmp/mac
FILE_NEED_TO_PROCESS=$1
#FILE_NEED_TO_PROCESS=/sysconfig/jnr-cfg.ascii
NEED_GREP_STRING="config.Lan[1]["MacAddress"]"
#no need strip :
NOW_MAC_VALUE=`cat $FILE_GET_MAC |grep "MAC="|cut -d= -f2`
REAL_MAC_ADDRESS=""
if [ -z "$NOW_MAC_VALUE" ];then
NOW_MAC_VALUE="00:00:00:00:00:00"
fi

if [ ! -f "$FILE_NEED_TO_PROCESS" ] ; then 
        echo "no such file $FILE_NEED_TO_PROCESS" 
        exit 0
fi


#for debug
MAC_1=`cat $FILE_NEED_TO_PROCESS |grep "config.Lan\[1\]\[\"MacAddress\"\]"|cut -d= -f2`
echo org MAC_1 =$MAC_1 now  =$NOW_MAC_VALUE

# mac 1
HAS_MAC_1_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.Lan\[1\]\[\"MacAddress\"\]"`
if [ -n "$HAS_MAC_1_ID" ]; then
	echo "now edit $NOW_MAC_VALUE"
	sed -i -e 's/'"config.Lan\[1\]\[\"MacAddress\"\]"'.*/'"config.Lan\[1\]\[\"MacAddress\"\] = \"$NOW_MAC_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
	echo no recorder add to last
	echo "config.Lan[1][\"MacAddress\"]=\"$NOW_MAC_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi
#config.MacTable[2]["MacAddress"] = "00:00:00:00"

#mac2
#need strip :
NOW_MAC_VALUE=`cat $FILE_GET_MAC |grep "MAC="|cut -d= -f2`
REAL_MAC_ADDRESS=`echo $NOW_MAC_VALUE | /usr/sbin/next_macaddr -3`

echo "now mac $NOW_MAC_VALUE"


HAS_MAC_2_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.MacTable\[2\]\[\"MacAddress\"\]"`
if [ -n "$HAS_MAC_2_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.MacTable\[2\]\[\"MacAddress\"\]"'.*/'"config.MacTable\[2\]\[\"MacAddress\"\] = \"$REAL_MAC_ADDRESS\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.MacTable[2][\"MacAddress\"]=\"$REAL_MAC_ADDRESS\"" >> $FILE_NEED_TO_PROCESS
fi


#mac 3
HAS_MAC_3_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.MacTable\[3\]\[\"MacAddress\"\]"`
# add 2
REAL_MAC_ADDRESS=`echo $NOW_MAC_VALUE | /usr/sbin/next_macaddr -2`
if [ -n "$HAS_MAC_3_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.MacTable\[3\]\[\"MacAddress\"\]"'.*/'"config.MacTable\[3\]\[\"MacAddress\"\] = \"$REAL_MAC_ADDRESS\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.MacTable[3][\"MacAddress\"]=\"$REAL_MAC_ADDRESS\"" >> $FILE_NEED_TO_PROCESS
fi

#mac 4
HAS_MAC_4_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.MacTable\[4\]\[\"MacAddress\"\]"`
# add 3

REAL_MAC_ADDRESS=`echo $NOW_MAC_VALUE | /usr/sbin/next_macaddr -1`
if [ -n "$HAS_MAC_4_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.MacTable\[4\]\[\"MacAddress\"\]"'.*/'"config.MacTable\[4\]\[\"MacAddress\"\] = \"$REAL_MAC_ADDRESS\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.MacTable[4][\"MacAddress\"]=\"$REAL_MAC_ADDRESS\"" >> $FILE_NEED_TO_PROCESS
fi



#mac 5
HAS_MAC_5_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.MacTable\[5\]\[\"MacAddress\"\]"`
# add 4
REAL_MAC_ADDRESS=`echo $NOW_MAC_VALUE | /usr/sbin/next_macaddr 0`
if [ -n "$HAS_MAC_5_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.MacTable\[5\]\[\"MacAddress\"\]"'.*/'"config.MacTable\[5\]\[\"MacAddress\"\] = \"$REAL_MAC_ADDRESS\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.MacTable[5][\"MacAddress\"]=\"$REAL_MAC_ADDRESS\"" >> $FILE_NEED_TO_PROCESS
fi



#mac 6
HAS_MAC_6_ID=`cat $FILE_NEED_TO_PROCESS | grep "config.MacTable\[6\]\[\"MacAddress\"\]"`
# add 5
REAL_MAC_ADDRESS=`echo $NOW_MAC_VALUE | /usr/sbin/next_macaddr 1`
if [ -n "$HAS_MAC_6_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"config.MacTable\[6\]\[\"MacAddress\"\]"'.*/'"config.MacTable\[6\]\[\"MacAddress\"\] = \"$REAL_MAC_ADDRESS\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "config.MacTable[6][\"MacAddress\"]=\"$REAL_MAC_ADDRESS\"" >> $FILE_NEED_TO_PROCESS
fi





#mark no need open
if [ -n "$adfkajsfkljsdaf" ] ; then
ddd_value=111
add_value=10
now_value=`expr $ddd_value + $add_value`
echo $((0x0020f0000000+0x0))
echo $((0x0020f0000000+0x1))
echo $((0x0020f0000000+0x2))
echo $((0x0020f0000000+0x3))
echo $((0x0020f0000000+0x4))
echo $((0x0020f0000000+0x5))

now_value=$((0x0020f000000f+0x1))
now_value=$(printf "%012x\n" $now_value)
echo ddd $now_value

now_value=$(echo $now_value | sed 's/^\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:/')

echo $now_value
fi


