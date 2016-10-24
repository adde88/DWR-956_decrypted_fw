#!/bin/sh

MANU_FACT=`/usr/local/bin/sqlite3 -cmd ".timeout 1000" /tmp/system.db "select vendor from system"`
echo "MANU_FACT=$MANU_FACT" >> /tmp/save_some_sysinfo.txt
MODEL_NAME=`/usr/local/bin/sqlite3 -cmd ".timeout 1000" /tmp/system.db "select name from system"`
echo "MODEL_NAME=$MODEL_NAME" >> /tmp/save_some_sysinfo.txt
FW_VER=`/usr/local/bin/sqlite3 -cmd ".timeout 1000" /tmp/system.db "select firmwareVer from system"`
echo "FW_VER=$FW_VER" >> /tmp/save_some_sysinfo.txt
