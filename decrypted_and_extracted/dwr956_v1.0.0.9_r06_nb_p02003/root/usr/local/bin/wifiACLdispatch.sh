#!/bin/sh

echo "ACL control dispatcher...."

[ -e /usr/local/bin/wifiACL.sh ]  && /usr/local/bin/wifiACL.sh
[ -e /usr/local/bin/wifiACACL.sh ]  && /usr/local/bin/wifiACACL.sh
