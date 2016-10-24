#!/bin/sh /etc/rc.common

START=992

start() 
{
#temp sol : put the wifi AC intial script here
    [ -e /usr/local/bin/wifiACInit ]  && /usr/local/bin/wifiACInit
}



