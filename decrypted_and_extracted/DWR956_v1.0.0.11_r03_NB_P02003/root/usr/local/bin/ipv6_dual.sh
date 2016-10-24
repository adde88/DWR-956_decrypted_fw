#!/bin/sh
stateful_addr=0
stateful_other=0
setup_ipv6_dual() {
    local RA_INFO_FILE=/tmp/ra_info
    local DHCP6C_CONFIG_FILE=/tmp/dhcp6c.conf
    rdisc6 usb0 > $RA_INFO_FILE

    grep 'Stateful address' $RA_INFO_FILE | grep 'Yes'
    stateful_addr=$?

    grep 'Stateful other' $RA_INFO_FILE | grep 'Yes'
    stateful_other=$?

    printf "Stateful address:%d, Stateful other:%d\n" ${stateful_addr} ${stateful_other}

    # check if need perform dhcpv6 client
    if [ X"$stateful_addr" = X"0" -o X"$stateful_other" = X"0" -o X"${DHCPPD_ENABLE}" = X"on" ]; then
        # perform dhcp6 client
        echo "interface usb0 {" > $DHCP6C_CONFIG_FILE
        if [ $stateful_addr = 0 ];then
            echo "    send ia-na 0;" >> $DHCP6C_CONFIG_FILE
        fi
    
        if [ "${DHCPPD_ENABLE}" = "on" ]; then
            echo "    send ia-pd 1;" >> $DHCP6C_CONFIG_FILE
        fi
    
        if [ "$stateful_addr" != "0" -a "${DHCPPD_ENABLE}" != "on" ]; then
            echo "    information-only;" >> $DHCP6C_CONFIG_FILE
        fi        
    
        echo "    request domain-name-servers;" >> $DHCP6C_CONFIG_FILE
        echo "    request domain-name;" >> $DHCP6C_CONFIG_FILE
        if [ "${V6DHCP_RAPID}" = "on" ]; then
            echo "    send rapid-commit;" >> $DHCP6C_CONFIG_FILE
        fi
        echo "    script \"/usr/local/bin/dhcp6c-script\";" >> $DHCP6C_CONFIG_FILE
        echo "};" >> $DHCP6C_CONFIG_FILE
        if [ "$stateful_addr" = "0" ];then
            echo "id-assoc na 0 {" >> $DHCP6C_CONFIG_FILE
            echo "};" >> $DHCP6C_CONFIG_FILE
        fi    
        # for DHCP-PD
        if [ "${DHCPPD_ENABLE}" = "on" ]; then
            echo "id-assoc pd 1 {" >> $DHCP6C_CONFIG_FILE
            echo "    prefix-interface br0 {" >> $DHCP6C_CONFIG_FILE
            echo "        sla-id 1;" >> $DHCP6C_CONFIG_FILE
            echo "    };" >> $DHCP6C_CONFIG_FILE
            echo "};" >> $DHCP6C_CONFIG_FILE
        fi
        
        dhcp6c -c $DHCP6C_CONFIG_FILE usb0
    fi
}

