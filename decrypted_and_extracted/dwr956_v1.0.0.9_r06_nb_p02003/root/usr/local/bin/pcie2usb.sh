#!/bin/sh
if [ -d /dev/bus/usb/003 ]; then
        echo "pass"
else
        echo "fail"
fi        
