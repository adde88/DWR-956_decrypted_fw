#!/bin/sh
vol_name=`uboot_env --get --name kernelname`

if [ "$vol_name" = "kernel" ]; then
    version=`uboot_env --get --name part1_version`
elif [ "$vol_name" = "kernelb" ]; then
    version=`uboot_env --get --name part2_version`
else
    version=`uboot_env --get --name part1_version`
fi

echo $version
