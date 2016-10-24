#config.system[1]["serNum"]=""
FILE_NEED_TO_PROCESS=/flash/rc.conf
#FILE_NEED_TO_PROCESS=rc.conf
#wlmn_1_ssid
#wlmn_0_ssid
#FILE_GET_MAC=$1
#NOW_SN_VALUE=`cat $FILE_NEED_TO_PROCESS|grep "wlmn_0_ssid="|cut -d= -f2`

if [ -z "$1" ] || [ -z "$2" ]; then
echo "please input 2 argument" 
echo "update_to_test_wifi_essid.sh <id (start at 0)>   <ESSID>"
exit 0
fi


NOW_SN_VALUE=$2

if [ ! -f "$FILE_NEED_TO_PROCESS" ] ; then 
        echo "no such file $FILE_NEED_TO_PROCESS" 
        exit 0
fi

NOW_SSID="wlmn_""$1""_ssid"

#default wlan0 essid
echo $NOW_SN_VALUE
echo $NOW_SSID
HAS_ESSID0_1_ID=`cat $FILE_NEED_TO_PROCESS | grep "$NOW_SSID"`
if [ -n "$HAS_ESSID0_1_ID" ]; then
        echo "now edit"
        sed -i -e 's/'"$NOW_SSID="'.*/'"$NOW_SSID=\"$NOW_SN_VALUE\""'/g' $FILE_NEED_TO_PROCESS
else
        echo no recorder add to last
        echo "$NOW_SSID=\"$NOW_SN_VALUE\"" >> $FILE_NEED_TO_PROCESS
fi

savecfg.sh
