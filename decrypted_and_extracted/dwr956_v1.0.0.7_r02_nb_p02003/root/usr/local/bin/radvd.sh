#create radvd config files
RADVD_CONFIG_FILE=/sysconfig/radvd.conf

create_radvd_conf() {
    if [ "${IPV6_TYPE}" = "6to4" ]; then
        tun6to4_prefix=$(find_6to4_prefix ${usb0_ip})
    fi

    echo     "interface br0 {" > $RADVD_CONFIG_FILE
    echo     "    AdvSendAdvert        on;" >> $RADVD_CONFIG_FILE
    echo     "    UnicastOnly          off;" >> $RADVD_CONFIG_FILE
    echo     "    AdvHomeAgentFlag     off;" >> $RADVD_CONFIG_FILE
    echo     "    AdvSourceLLAddress   on;" >> $RADVD_CONFIG_FILE
    echo     "    MinDelayBetweenRAs   3;" >> $RADVD_CONFIG_FILE
    echo     "    AdvReachableTime     0;" >> $RADVD_CONFIG_FILE
    echo     "    AdvRetransTimer      0;" >> $RADVD_CONFIG_FILE
    echo     "    MaxRtrAdvInterval    15;" >> $RADVD_CONFIG_FILE
    echo     "    MinRtrAdvInterval    5;" >> $RADVD_CONFIG_FILE

    if [ "${LAN_V6_TYPE}" = "stateful" ]; then
        echo "    AdvManagedFlag       on;" >> $RADVD_CONFIG_FILE
    else
        echo "    AdvManagedFlag       off;" >> $RADVD_CONFIG_FILE
    fi

    if [ "${LAN_V6_TYPE}" != "stateless" ]; then
        echo "    AdvOtherConfigFlag   on;" >> $RADVD_CONFIG_FILE
    else
        echo "    AdvOtherConfigFlag   off;" >> $RADVD_CONFIG_FILE
    fi


    if [ "${IPV6_TYPE}" = "6to4" ]; then
        echo     "    prefix ${tun6to4_prefix}:1::1/64 {"  >> $RADVD_CONFIG_FILE
        echo     "        AdvOnLink        on;" >> $RADVD_CONFIG_FILE
        if [ "${LAN_V6_TYPE}" = "stateful" ]; then
            echo "        AdvAutonomous    off;" >> $RADVD_CONFIG_FILE
        else
            echo "        AdvAutonomous    on;" >> $RADVD_CONFIG_FILE
        fi
        echo     "        AdvRouterAddr    on;" >> $RADVD_CONFIG_FILE
        echo     "        AdvValidLifetime 40;" >> $RADVD_CONFIG_FILE
        echo     "        AdvPreferredLifetime 30;" >> $RADVD_CONFIG_FILE
        echo     "    };" >> $RADVD_CONFIG_FILE
    elif [ ! -z ${V6IPPREFIX} ]; then
        echo     "    prefix $V6IPPREFIX {"  >> $RADVD_CONFIG_FILE
        echo     "        AdvOnLink        on;" >> $RADVD_CONFIG_FILE
        if [ "${LAN_V6_TYPE}" = "stateful" ]; then
            echo "        AdvAutonomous    off;" >> $RADVD_CONFIG_FILE
        else
            echo "        AdvAutonomous    on;" >> $RADVD_CONFIG_FILE
        fi
        echo     "        AdvRouterAddr    off;" >> $RADVD_CONFIG_FILE
        if [ "${DHCPPD_VTIME}" != "" ]; then
            echo "        AdvValidLifetime $DHCPPD_VTIME;" >> $RADVD_CONFIG_FILE
        else
            echo "        AdvValidLifetime 40;" >> $RADVD_CONFIG_FILE
        fi
        if [ "${DHCPPD_PTIME}" != "" ]; then
            echo "        AdvPreferredLifetime $DHCPPD_PTIME;" >> $RADVD_CONFIG_FILE
        else
            echo "        AdvPreferredLifetime 30;" >> $RADVD_CONFIG_FILE
        fi
        echo     "    };" >> $RADVD_CONFIG_FILE
    fi

    if [ "${LAN_V6_TYPE}" = "stateless" ]; then
        echo "    RDNSS $PRIMARY_V6DNS $SECOND_V6DNS {" >> $RADVD_CONFIG_FILE
        echo "        AdvRDNSSOpen on;" >> $RADVD_CONFIG_FILE 
        echo "    };" >> $RADVD_CONFIG_FILE
    fi

    echo     "};" >> $RADVD_CONFIG_FILE
}

