REAL_MAC_ADDRESS=""
MAC_ADD_BY_ONE()
{
    echo "input value = \"$1\""
    now_value=$1
    #now_value=$(printf "0x%012x\n" $now_value)
    echo  ddd $now_value
    now_value=`echo $(($now_value + $2))`
    echo $now_value
    now_value=$(printf "%012x\n" $now_value)

    now_value=$(echo $now_value | sed 's/^\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3:\4:\5:/')    
    echo $now_value
    REAL_MAC_ADDRESS=$now_value
    #return $now_value
}

NOW_MAC_VALUE=`cat $FILE_GET_MAC |grep "MAC="|cut -d= -f2`

ifconfig eth0 down
ifconfig eth0 hw ether $NOW_MAC_VALUE
ifconfig eth0 up

MAC_ADD_BY_ONE $NOW_MAC_VALUE 1

ifconfig eth1 down
ifconfig eth1 hw ether $REAL_MAC_ADDRESS
ifconfig eth1 up

MAC_ADD_BY_ONE $NOW_MAC_VALUE 2
ifconfig wlan0 down
ifconfig wlan0 hw ether $REAL_MAC_ADDRESS
ifconfig wlan0 up

MAC_ADD_BY_ONE $NOW_MAC_VALUE 3
ifconfig wlan0.1 down
ifconfig wlan0.1 hw ether $REAL_MAC_ADDRESS
ifconfig wlan0.1 up


MAC_ADD_BY_ONE $NOW_MAC_VALUE 4
ifconfig wlan0.2 down
ifconfig wlan0.2 hw ether $REAL_MAC_ADDRESS
ifconfig wlan0.2 up


MAC_ADD_BY_ONE $NOW_MAC_VALUE 5
ifconfig wlan0.3 down
ifconfig wlan0.3 hw ether $REAL_MAC_ADDRESS
ifconfig wlan0.3 up



