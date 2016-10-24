#!/bin/sh
local IF6RD=tun6rd
local dhcpc_6rd_result=/tmp/dhcpc_6rd.result

setup_6rd_dhcp() {
    if [ -e ${dhcpc_6rd_result} ]; then
        . ${dhcpc_6rd_result}
        sixrd_wan_ip=$1
        sixrd_masklen=$(echo $sixrd | cut -f1 -d' ')
        sixrd_prefix_len=$(echo $sixrd | cut -f2 -d' ')
        sixrd_prefix=$(echo $sixrd | cut -f3 -d' ')
        sixrd_relay=$(echo $sixrd | cut -f4 -d' ')
        sixrd_addr=$(/usr/sbin/ipv6helper -p $sixrd_prefix -l $sixrd_prefix_len -i $sixrd_wan_ip -m $sixrd_masklen -t sixrd)
	sixrd_addr_wan=$(echo $sixrd_addr | cut -f1 -d ' ')
	AP_IPADDR_V6=$(echo $sixrd_addr | cut -f2 -d ' ')

        ip tunnel add ${IF6RD} mode sit ttl 64 local $sixrd_wan_ip
        ip tunnel 6rd dev ${IF6RD} 6rd-prefix $(ipv6_prefix $sixrd_prefix $sixrd_prefix_len)/$sixrd_prefix_len
        ip addr add $sixrd_addr_wan/$sixrd_prefix_len dev ${IF6RD} 
        ip link set ${IF6RD} mtu 1400 up
        ip -6 route add ::/0 via ::${sixrd_relay} dev ${IF6RD}
    else
        echo "no /tmp/dhcpc_6rd.result"
        return
    fi
}

setup_6rd_static() {
    sixrd_wan_ip=$1
    ip tunnel add ${IF6RD} mode sit ttl 64 local ${sixrd_wan_ip}
    ip tunnel 6rd dev ${IF6RD} 6rd-prefix $(ipv6_prefix ${IP6RDPREFIX} ${IP6RDPREFIX_LEN})/${IP6RDPREFIX_LEN}
    ip addr add ${IP6RDPREFIX}/${IP6RDPREFIX_LEN} dev ${IF6RD} 
    ip link set ${IF6RD} mtu 1400 up
    ip -6 route add ::/0 via ::${IP6RDRELAY} dev ${IF6RD}
}

setup_6rd() {
    if [ "${IP6RD_CONFIG}" = "dhcp" ]; then
        rm ${dhcpc_6rd_result}
        udhcpc -nq -i br0 -s /usr/local/bin/6rd_udhcpc.sh -t 2 -O sixrd
        if [ $? -eq 0 ]; then
            setup_6rd_dhcp $1
        else
            echo "request 6rd option from dhcpc failed or no such option"
        fi
    else
        setup_6rd_static $1
    fi
}


shutdown_6rd() {
    ifconfig ${IF6RD} &>/dev/null
    if [ $? -ne 0 ]; then
        echo "why no ${IF6RD}"
        return 0
    fi

    ifconfig ${IF6RD} down
    ip tunnel del ${IF6RD}
    sleep 1
}

