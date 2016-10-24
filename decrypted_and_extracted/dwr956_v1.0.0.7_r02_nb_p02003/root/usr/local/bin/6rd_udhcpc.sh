#!/bin/sh
if [ -z $sixrd ]; then
    return 1
else
    echo "sixrd=\"$sixrd\"" > /tmp/dhcpc_6rd.result
    return 0
fi

