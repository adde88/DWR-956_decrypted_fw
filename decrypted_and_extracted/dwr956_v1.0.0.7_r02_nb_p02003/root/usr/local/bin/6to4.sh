#!/bin/sh
IF6TO4=tun6to4
find_6to4_prefix() {
	local ip4="$1"
        local oIFS="$IFS"; IFS="."; set -- $ip4; IFS="$oIFS"

        printf "2002:%02x%02x:%02x%02x\n" $1 $2 $3 $4
}

setup_6to4() {
	local local4=$1
	local prefix6=$(find_6to4_prefix "$local4")
	local local6="$prefix6::1/16"
	ip tunnel add $IF6TO4 mode sit remote any local $local4 ttl 64
	ifconfig $IF6TO4 mtu 1470 up
	ip -6 addr add ${local6} dev $IF6TO4
	ip -6 route add 2000::/3 via ::192.88.99.1 dev $IF6TO4 metric 1
	ip -6 addr add ${prefix6}:1::1/64 dev br0
}

shutdown_6to4() {
    ifconfig $IF6TO4 &>/dev/null
    if [ $? -ne 0 ]; then
        echo "why no ${IF6TO4}"
        return 0
    fi

    ifconfig $IF6TO4 down
    ip tunnel del $IF6TO4
    sleep 1
}

