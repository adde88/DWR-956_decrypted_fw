#!/bin/sh
local IF6IN4=tun6in4

check_6in4_params() {
    if [ -z $IP6IN4REMOTEIP4 ]; then
        echo "NO IP6IN4REMOTEIP4 or invalid $IP6IN4REMOTEIP4"
        return -1
    fi

#    if [ -z $IP6IN4REMOTEIP6 ]; then
#        echo "NO IP6IN4REMOTEIP6 or invalid $IP6IN4REMOTEIP6"
#        return -1
#    fi

    if [ -z $IP6IN4LOCALIP6 ]; then
        echo "NO IP6IN4LOCALIP6 or invalid $IP6IN4LOCALIP6"
        return -1
    fi

    return 0
}

setup_6in4() {
    local local4=$1
    check_6in4_params
    if [ $? -ne 0 ]; then
        return -1;
    fi
    ip tunnel add ${IF6IN4} mode sit remote ${IP6IN4REMOTEIP4} local ${local4} ttl 255
    ifconfig ${IF6IN4} mtu 1470 up
    ip addr add ${IP6IN4LOCALIP6}/64 dev ${IF6IN4}
    ip route add ::/0 dev ${IF6IN4}
}


shutdown_6in4() {
    ifconfig ${IF6IN4} &>/dev/null
    if [ $? -ne 0 ]; then
        echo "why no ${IF6IN4}"
        return 0
    fi

    ifconfig ${IF6IN4} down
    ip tunnel del ${IF6IN4}
    sleep 1
}

