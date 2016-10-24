#!/bin/sh

WebUIEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from RemoteLog where _ROWID_=1;"`
RadioLogEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from RemoteLog where _ROWID_=2;"`
VoIPLogEnable=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select Enable from RemoteLog where _ROWID_=3;"`

#if [ "$WebUIEnable" = "1" ] || [ "$RadioLogEnable" = "1" ] || [ "$VoIPLogEnable" = "1" ]; then
    killall syslogd   
    killall syslog-ng
#    cp /usr/local/etc/syslog-ng/syslog-ng.conf.default /tmp/syslog-ng.conf
    echo "options { long_hostnames(off); sync(0); };" > /tmp/syslog-ng.conf
    echo "source src { unix-stream(\""/dev/log"\"); internal(); file(\""/proc/kmsg"\"); };" >> /tmp/syslog-ng.conf

    echo "destination messages { file(\""/var/log/messages"\"); };" >> /tmp/syslog-ng.conf
    echo "destination d_Internet { file(\""/var/log/internet.log"\"); };" >> /tmp/syslog-ng.conf
    echo "destination d_WiFi { file(\""/var/log/wifi.log"\"); };" >> /tmp/syslog-ng.conf
    echo "destination d_Firewall { file(\""/var/log/firewall.log"\"); };" >> /tmp/syslog-ng.conf
    echo "destination d_Application { file(\""/var/log/app.log"\"); };" >> /tmp/syslog-ng.conf
    echo "destination d_LAN { file(\""/var/log/lan.log"\"); };" >> /tmp/syslog-ng.conf
    echo "destination d_WebUI_All { file(\""/var/log/messages_webui_all.log"\"); };" >> /tmp/syslog-ng.conf

	echo "filter f_Internet { facility(local0) or match(\"udhcpc\"); };" >> /tmp/syslog-ng.conf
    echo "filter f_WiFi { facility(local1); };" >> /tmp/syslog-ng.conf
    echo "filter f_Firewall { facility(local2) or facility(kern) and match(\"IN=\") and match(\"OUT=\"); };" >> /tmp/syslog-ng.conf
    echo "filter f_Application { facility(local4) or match(\"INADYN\"); };" >> /tmp/syslog-ng.conf
    echo "filter f_LAN { facility(local5) or match(\"udhcpd\"); };" >> /tmp/syslog-ng.conf
    echo "filter f_Messages_All { not filter(f_Internet) and not filter(f_WiFi) and not filter(f_Firewall) and not filter(f_Application) and not filter(f_LAN); };" >> /tmp/syslog-ng.conf

    echo "log { source(src); filter(f_Messages_All); destination(messages); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_Internet); destination(d_WebUI_All); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_WiFi); destination(d_WebUI_All); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_Firewall); destination(d_WebUI_All); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_Application); destination(d_WebUI_All); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_LAN); destination(d_WebUI_All); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_Internet); destination(d_Internet); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_WiFi); destination(d_WiFi); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_Firewall); destination(d_Firewall); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_Application); destination(d_Application); };" >> /tmp/syslog-ng.conf
    echo "log { source(src); filter(f_LAN); destination(d_LAN); };" >> /tmp/syslog-ng.conf

    if [ "$RadioLogEnable" = "1" ]; then
        FACILITY_RADIO=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select facilityId from RemoteLog where _ROWID_=2;"`
        echo "FACILITY_RADIO=$FACILITY_RADIO" > /tmp/save_radio_syslog_conf.txt
        SERVERITY_RADIO=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select severity from RemoteLog where _ROWID_=2;"`
        echo "SERVERITY_RADIO=$SERVERITY_RADIO" >> /tmp/save_radio_syslog_conf.txt
        echo "filter f_radio_syslog { level($SERVERITY_RADIO) and facility($FACILITY_RADIO); };" >> /tmp/syslog-ng.conf
	
        RADIO_SYSLOG_ACTIVATE=`pidof send_radiosyslog.sh`
        if [ -z "$RADIO_SYSLOG_ACTIVATE" ]; then
            if [ -e /usr/local/bin/send_radiosyslog.sh ]; then
                /usr/local/bin/send_radiosyslog.sh&
            fi
        fi

        RadioLogAddress=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select serverName from RemoteLog where _ROWID_=2;"`
        RadioLogPort=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select serverPort from RemoteLog where _ROWID_=2;"`
        if [ "$RadioLogAddress" != "" ]; then
            echo "destination dscRadioSyslog { udp(\""$RadioLogAddress"\" port($RadioLogPort)); };" >> /tmp/syslog-ng.conf
            echo "log { source(src); filter(f_radio_syslog); destination(dscRadioSyslog); };" >> /tmp/syslog-ng.conf
        fi
    else
        killall send_radiosyslog.sh 
        echo "" > /tmp/save_radio_syslog_conf.txt    
    fi

    if [ "$VoIPLogEnable" = "1" ]; then
        FACILITY_VOIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select facilityId from RemoteLog where _ROWID_=3;"`
        echo "FACILITY_VOIP=$FACILITY_VOIP" > /tmp/save_voip_syslog_conf.txt
        SERVERITY_VOIP=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select severity from RemoteLog where _ROWID_=3;"`
        echo "SERVERITY_VOIP=$SERVERITY_VOIP" >> /tmp/save_voip_syslog_conf.txt
        echo "filter f_voip_syslog { level($SERVERITY_VOIP) and facility($FACILITY_VOIP); };" >> /tmp/syslog-ng.conf
        
        VOIP_SYSLOG_ACTIVATE=`pidof send_voipsyslog.sh`
        if [ -z "$VOIP_SYSLOG_ACTIVATE" ]; then
            if [ -e /usr/local/bin/send_voipsyslog.sh ]; then
               /usr/local/bin/send_voipsyslog.sh&
            fi
        fi 

        VoIPLogAddress=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select serverName from RemoteLog where _ROWID_=3;"`
        VoIPLogPort=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select serverPort from RemoteLog where _ROWID_=3;"`
        if [ "$VoIPLogAddress" != "" ]; then
            echo "destination dscVoIPSyslog { udp(\""$VoIPLogAddress"\" port($VoIPLogPort)); };" >> /tmp/syslog-ng.conf
            echo "log { source(src); filter(f_voip_syslog); destination(dscVoIPSyslog); };" >> /tmp/syslog-ng.conf
        fi
    else
        killall send_voipsyslog.sh  
        echo "" > /tmp/save_voip_syslog_conf.txt
        PID=`ps | grep "tail -f -n0 /tmp/callmgr_sip_msg.log" | awk '{print $1}'`
        kill -9 $PID            
    fi

    if [ "$WebUIEnable" = "1" ]; then
        serverName=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select serverName from RemoteLog where _ROWID_=1;"`
        serverPort=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select serverPort from RemoteLog where _ROWID_=1;"`        
        if [ "$serverName" != "" ]; then
            echo "destination logserver { udp(\""$serverName"\" port($serverPort)); };" >> /tmp/syslog-ng.conf
            if [ "$RadioLogEnable" = "1" ] || [ "$VoIPLogEnable" = "1" ]; then
                if [ "$RadioLogEnable" = "1" ] && [ "$VoIPLogEnable" = "1" ]; then
                    echo "filter f_webui_syslog { not filter(f_radio_syslog) and not filter(f_voip_syslog); };" >> /tmp/syslog-ng.conf 
                elif [ "$RadioLogEnable" = "1" ]; then
                    echo "filter f_webui_syslog { not filter(f_radio_syslog); };" >> /tmp/syslog-ng.conf
                else
                    echo "filter f_webui_syslog { not filter(f_voip_syslog); };" >> /tmp/syslog-ng.conf
                fi
           
                echo "log { source(src); filter(f_webui_syslog); destination(logserver); };" >> /tmp/syslog-ng.conf
            else
                echo "log { source(src); destination(logserver); };" >> /tmp/syslog-ng.conf
            fi
        fi
    fi

    syslog-ng -f /tmp/syslog-ng.conf
#else
#    killall syslogd
#    killall syslog-ng
#    killall send_radiosyslog.sh
#    killall send_voipsyslog.sh
#    echo "" > /tmp/save_radio_syslog_conf.txt
#    echo "" > /tmp/save_voip_syslog_conf.txt
#    PID=`ps | grep "tail -f -n0 /tmp/callmgr_sip_msg.log" | awk '{print $1}'`
#    kill -9 $PID    
#fi
