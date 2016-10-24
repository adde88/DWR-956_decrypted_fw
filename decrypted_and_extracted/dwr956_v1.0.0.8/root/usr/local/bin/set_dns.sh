#!/bin/sh

PRI_DNS=`lte_get --ip | grep "primary DNS" | cut -d: -f3`
SEC_DNS=`lte_get --ip | grep "secondary DNS" | cut -d: -f3`

echo "nameserver $PRI_DNS" > /etc/resolv.conf
echo "nameserver $SEC_DNS" >> /etc/resolv.conf
