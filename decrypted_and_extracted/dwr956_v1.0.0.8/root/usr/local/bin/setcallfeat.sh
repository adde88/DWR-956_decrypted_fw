#!/bin/sh

#This script is to set call feature in rc.conf

display_usage() {
	echo -e "usage: setcallfeat.sh feature [line_number] [input]"
	echo " feature = 1 : Caller ID enable/disable"
	echo " feature = 2 : Call waiting enable/disable"
	echo " feature = 3 : Inter Digit Timeout in second (input) for gerenal setting (no line number)"
	echo " feature = 4 : VAD enable/disable"
	echo " ex: setcallfeat.sh 1 1 => read caller ID status of Line1"
	echo " ex: setcallfeat.sh 1 1 0 => set caller ID to disable of Line1" 
	echo " ex: setcallfeat.sh 3 4 => set Inter digit timeout to 4s"
	echo " ex: setcallfeat.sh 4 1 => turn on VAD"
}

if [ $# -lt 1 ]
then
	display_usage
	exit 1
fi

CONF=/ramdisk/flash/rc.conf
DB_LOG="/tmp/setcallfeat.log"

if [ ! -f $DB_LOG ]
then
   touch $DB_LOG
fi

#CallID feature    
if [ $1 -eq 1 ]
then
	date >> $DB_LOG
	echo callID feature >> $DB_LOG
    
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

	#No input value => Read                                       
	if [ -z $3 ]
	then
		OUT="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
		echo $OUT
		exit 1
	else
		echo write callID feature to $3 >> $DB_LOG
		if [ $3 -eq 0 ]; then
			#Disable callID is not displaying CID.
			NUM=0  
		elif [ $3 -eq 1 ]; then
			#Enable callID is displaying CID.
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
		echo SAVE STR = $SAVE >> $DB_LOG
		sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 
		savecfg.sh
		rm -f /tmp/rc_conf_lock
		exit 1
	fi
	#end of [ -z $3 ]
	exit 1
fi
#end of [ $1 -eq 1 ]    

#Call waiting feature
if [ $1 -eq 2 ]
then
	date >> $DB_LOG
	echo Call waiting feature >> $DB_LOG
    
	if [ $2 -eq 1 ]; then
		NUM=0  
	elif [ $2 -eq 2 ]; then
		NUM=1
	else
		display_usage
		exit 1
	fi		
	                                        
	STR=LineCallFeat_"$NUM"_EnableCallWaiting=                              
	#echo $STR

	#No input value => Read                                       
	if [ -z $3 ]
	then
		OUT="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
		echo $OUT
		exit 1
	else
		echo Write Call waiting feature to $3 >> $DB_LOG
		if [ $3 -eq 0 ]; then
			#Disable call waiting
			NUM=0  
		elif [ $3 -eq 1 ]; then
			#Enable call waiting
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
		echo SAVE STR = $SAVE >> $DB_LOG
		sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 
		savecfg.sh
		rm -f /tmp/rc_conf_lock
		exit 1
	fi
	#end of [ -z $3 ]
	exit 1
fi
#end of [ $1 -eq 2 ] 


#Inter digit timeour
if [ $1 -eq 3 ]
then
	date >> $DB_LOG
	echo Inter digit timeout feature >> $DB_LOG
    		                                        
	STR="NumberingPlan_0_ShortTmr="                              
	#echo $STR

	#No input value => Read                                       
	if [ -z $2 ]
	then
		OUT="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
		echo $OUT
		exit 1
	else
		
		if [ $2 -lt 1 -o $2 -gt 10 ]; then
			echo Timeout should be 1~10
			exit 1
		fi		
		
		echo Set inter digit timeout to $2 >> $DB_LOG
		
		while [ -f /tmp/rc_conf_lock ]
		do
		  #echo locked
			sleep 1
		done
		touch /tmp/rc_conf_lock
		
		SAVE="$STR"'"'"$2"'"'
		echo SAVE STR = $SAVE >> $DB_LOG
		sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 
		
		STR="NumberingPlan_0_LongTmr="                              
		SAVE="$STR"'"'"$2"'"'
		echo SAVE STR = $SAVE >> $DB_LOG
		sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF
		
		savecfg.sh
		rm -f /tmp/rc_conf_lock
		exit 1
	fi
	#end of [ -z $2 ]
	exit 1
fi
#end of [ $1 -eq 3 ] 

#VAD
if [ $1 -eq 4 ]
then
	date >> $DB_LOG
	echo VAD feature >> $DB_LOG
    		                                        
	STR="Misc_0_SilenceSupp="                              
	#echo $STR

	#No input value => Read                                       
	if [ -z $2 ]
	then
		OUT="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
		echo $OUT
		exit 1
	else		
		if [ $2 -eq 0 ]; then
			#Disable VAD
			NUM=0  
		elif [ $2 -eq 1 ]; then
			#Enable VAD
			NUM=1
		else
			display_usage
			exit 1
		fi	
		
		echo Set VAD to $2 >> $DB_LOG
		
		while [ -f /tmp/rc_conf_lock ]
		do
		  #echo locked
			sleep 1
		done
		touch /tmp/rc_conf_lock
		
		SAVE="$STR"'"'"$NUM"'"'
		echo SAVE STR = $SAVE >> $DB_LOG
		sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 
		
		savecfg.sh
		rm -f /tmp/rc_conf_lock
		exit 1
	fi
	#end of [ -z $2 ]
	exit 1
fi
#end of [ $1 -eq 4 ]
