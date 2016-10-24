#!/bin/sh

display_usage() {
	echo -e "usage: setclir.sh arguments line_number [input]"
	echo " 1 : Read CLIR setting for line_number"
	echo " 2 : Write CLIR enable(1)/disable(0) for line_number"
}
                                 
if [ $# -le 1 ]
then
	display_usage
	exit 1
fi
    
if [ $2 -eq 1 ]; then
	NUM=0  
elif [ $2 -eq 2 ]; then
	NUM=1
else
	display_usage
	exit 1
fi		
	                                
STR=LineCallFeat_"$NUM"_EnableCid=                              
#echo $STR

CONF=/ramdisk/flash/rc.conf
                                       
if [ $1 -eq 1 ]
then
OUT="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
if [ $OUT -eq 1 ]; then
	echo 0
elif [ $OUT -eq 0 ]; then
	echo 1
else
  echo "Error value"
	exit 1
fi
exit 1
fi

if [ $1 -eq 2 ]
then

if [ $# -le 2 ]
then
	display_usage
	exit 1
fi

if [ $3 -eq 1 ]; then
#CLIR enable is not displaying CID.
	NUM=0  
elif [ $3 -eq 0 ]; then
#CLIR disable is displaying CID.
	NUM=1
else
	display_usage
	exit 1
fi

while [ -f /tmp/rc_conf_lock ]
do
  #echo locked
	sleep 1
done
touch /tmp/rc_conf_lock

SAVE="$STR"'"'"$NUM"'"'
#echo $SAVE
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 
savecfg.sh
rm -f /tmp/rc_conf_lock
exit 1
fi
