#!/bin/sh

local IFGOGOC=gogoc
local gen_date=$(date)

create_gogoc_conf() {
  local auth_method=${GOGOC_AUTH_METHOD}
  if [ X"${auth_method}" = X"any" ]; then
    auth_method=plain
  fi
cat << EOF > /sysconfig/gw6c.conf
# gen_date=${gen_date}
userid=${GOGOC_USERID}
passwd=${GOGOC_PASSWD}
server=${GOGOC_SERVER}

auth_method=${auth_method}
host_type=router

if_prefix=br0
dns_server=
auto_retry_connect=yes
retry_delay=30
keepalive=yes
keepalive_interval=30
tunnel_mode=v6v4

gw6_dir=/sysconfig
gogoc_dir=/sysconfig

if_tunnel_v6v4=gogoc
if_tunnel_v6udpv4=tun
if_tunnel_v4v6=sit0
client_v4=auto
client_v6=auto
template=openwrt
proxy_client=no

broker_list=/sysconfig/tsp-broker-list.txt
last_server=/sysconfig/tsp-last-server.txt

log_filename=gw6c.log
log_rotation=yes
log_rotation_size=32
log_rotation_delete=no

syslog_facility=USER

log_console=3
log_stderr=0
log_file=0
log_syslog=3
EOF
}

shutdown_gogoc() {
    ifconfig ${IFGOGOC} &>/dev/null
    if [ $? -ne 0 ]; then
        echo "why no ${IFGOGOC}"
        return 0
    fi

    ifconfig ${IFGOGOC} down
    ip tunnel del ${IFGOGOC}
    sleep 1
}

