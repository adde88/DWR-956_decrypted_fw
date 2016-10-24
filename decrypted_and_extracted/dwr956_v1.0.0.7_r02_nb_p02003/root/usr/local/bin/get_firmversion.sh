now_kernel=`uboot_env --get --name kernelname`
#now_kernel="1233445"
if [ $now_kernel == "kernel" ]; then
uboot_env --get --name part1_version;
else
uboot_env --get --name part2_version;
fi


#kernel
#v0.0.0.7

