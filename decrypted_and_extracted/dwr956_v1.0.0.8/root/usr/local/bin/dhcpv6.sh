DHCP6S_CONFIG_FILE=/sysconfig/dhcp6s.conf

create_dhcp6s_conf() {
#create dhcpv6 config file by the settings
    echo     "option domain-name-servers $PRIMARY_V6DNS $SECOND_V6DNS;" > $DHCP6S_CONFIG_FILE
    echo     "option domain-name \"$DOMAIN_NAME\";" >> $DHCP6S_CONFIG_FILE
    if [ "${LAN_V6_TYPE}" = "stateful" ]; then
        echo "interface br0 {" >> $DHCP6S_CONFIG_FILE
        if [ "${V6DHCP_RAPID}" = "on" ]; then
            echo "    allow rapid-commit;" >> $DHCP6S_CONFIG_FILE
        fi

        if [ "${DHCPPD_PTIME}" != "" -a "${DHCPPD_VTIME}" != "" ]; then
            echo "    address-pool wx55 $DHCPPD_PTIME $DHCPPD_VTIME;" >> $DHCP6S_CONFIG_FILE
        else
            echo "    address-pool wx55 $IP_LIFETIME $IP_LIFETIME;" >> $DHCP6S_CONFIG_FILE
        fi

        echo "};" >> $DHCP6S_CONFIG_FILE

        echo "pool wx55 {" >> $DHCP6S_CONFIG_FILE
        echo "    range $LAN_DHCP_START_V6 to $LAN_DHCP_END_V6 ;" >> $DHCP6S_CONFIG_FILE
        echo "};" >> $DHCP6S_CONFIG_FILE
    fi
}


