#config.system[1]["serNum"]=""
FILE_NEED_TO_PROCESS=/flash/rc.conf
#FILE_NEED_TO_PROCESS=rc.conf
#wlmn_1_ssid
#wlmn_0_ssid
#FILE_GET_MAC=$1
#NOW_SN_VALUE=`cat $FILE_NEED_TO_PROCESS|grep "wlmn_0_ssid="|cut -d= -f2`

if [ -z "$1" ];  then
echo "please input 2 argument" 
echo "update_to_test_wifi_bw.sh 0 (auto) 1 (20Mhz) 2(40Mhz) "
exit 0
fi


NOW_BW_VALUE=$1

if [ ! -f "$FILE_NEED_TO_PROCESS" ] ; then 
        echo "no such file $FILE_NEED_TO_PROCESS" 
        exit 0
fi

NOW_BANDWIDTH="wlphy_0_nChanWidth"

#default channel bandwidth
echo $NOW_BW_VALUE
echo $NOW_BANDWIDTH
HAS_BANDWIDTH_1_ID=`cat $FILE_NEED_TO_PROCESS | grep "$NOW_BANDWIDTH"`
if [ -n "$HAS_BANDWIDTH_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"$NOW_BANDWIDTH="'.*/'"$NOW_BANDWIDTH=\"$NOW_BW_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "$NOW_BANDWIDTH=\"$NOW_BW_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi

NOW_BANDWIDTH_ENA_VALUE=0
if [ "$NOW_BW_VALUE" == "0" ];then
	NOW_BANDWIDTH_ENA_VALUE=1	
else
	NOW_BANDWIDTH_ENA_VALUE=0
fi

NOW_BANDWIDTH_ENA="wlphy_0_n2040CoexEna"
HAS_BANDWIDTH_ENA_1_ID=`cat $FILE_NEED_TO_PROCESS | grep "$NOW_BANDWIDTH_ENA"`
if [ -n "$HAS_BANDWIDTH_ENA_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"$NOW_BANDWIDTH_ENA="'.*/'"$NOW_BANDWIDTH_ENA=\"$NOW_BANDWIDTH_ENA_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "$NOW_BANDWIDTH_ENA=\"$NOW_BANDWIDTH_ENA_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi




savecfg.sh
