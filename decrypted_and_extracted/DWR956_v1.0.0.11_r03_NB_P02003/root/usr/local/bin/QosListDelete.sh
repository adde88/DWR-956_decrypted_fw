#! /bin/sh
# WLD6_QoS
# QoSListDelete

CONFIG_FILE=/mnt/data/QoS/QoS_Rule

iptables -t mangle -F QoS_UL
iptables -t mangle -F QoS_DL

DelIdx=$(($1))"c"
sed -i "$DelIdx #" $CONFIG_FILE

chmod +x $CONFIG_FILE
$CONFIG_FILE

# Woody : NO need to redirect to WLD6 QoS web page
# ./QoSPolicy