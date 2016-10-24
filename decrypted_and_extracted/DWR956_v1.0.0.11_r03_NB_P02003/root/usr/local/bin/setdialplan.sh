#!/bin/sh

#This script is to set call feature in rc.conf

#CONF=/mnt/data/rc.conf
CONF=/ramdisk/flash/rc.conf

#Debug log
DB_LOG="/tmp/setdialplan.log"
OUT_FILE="/tmp/read_dialplan"
#Fixed Dialplan to feature code functions.
FIXDP=15


date > $DB_LOG

if [ $# -eq 0 ]
then
	echo read dialplan >> $DB_LOG
	rm -f $OUT_FILE
	
	STR="NumPlanRules_Count="
	CUR_CNT="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
	NUM=$FIXDP

	#Skip the last one
	CUR_CNT=`expr $CUR_CNT - 1`
	
	while [ $NUM -lt $CUR_CNT ]
	do
		STR="NumPlanRules_"$NUM"_DigIns="
		INT_DIG="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
		STR="NumPlanRules_"$NUM"_Prefix="
		DP_STR="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
		
		if [ -z "$INT_DIG" ]
		then
			OUT_DP="$OUT_DP""$DP_STR"";"	
		else
			#echo insert digit
			DP_STR="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"		
			OUT_DP="$OUT_DP""<""$INT_DIG"">""$DP_STR"";"
		fi
	NUM=`expr $NUM + 1` 
	done

	echo $OUT_DP >> $DB_LOG
	echo -n $OUT_DP > $OUT_FILE		
	exit 1
fi 


#Update/write dialplan

echo Input String $1 >> $DB_LOG
CNT="$(echo $1 | awk -F";" '{print NF}')"
#echo $CNT

IN_STR="$1"

STR="NumPlanRules_Count="
#Current Count
CUR_CNT="$(awk -F'"' '/'$STR'/{ print $2 }' $CONF)"
#echo $CUR_CNT

FINAL_CNT=`expr $FIXDP + $CNT`
#echo $FINAL_CNT

#File lock
while [ -f /tmp/rc_conf_lock ]
	do
	#echo locked
	sleep 1
done
touch /tmp/rc_conf_lock


#Update final count number
STR="NumPlanRules_Count="
SAVE="$STR"'"'"$FINAL_CNT"'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 

STR="NumberingPlan_0_NoOfRules="
SAVE="$STR"'"'"$FINAL_CNT"'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 

NEXT_CNT=`expr $FINAL_CNT + 1`
STR="NumPlanRules_nextCpeId="
SAVE="$STR"'"'"$NEXT_CNT"'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 

NUM=1
while [ $NUM -le  37 ]
	do
		if [ $NUM -le $FINAL_CNT ]
		then
			SAVE_CIP="$SAVE_CIP""$NUM"","
		else
			SAVE_CIP="$SAVE_CIP""0"","
		fi
	NUM=`expr $NUM + 1`
done
SAVE_CIP="$SAVE_CIP""0"
STR="NumPlanRules_CpeId="
SAVE="$STR"'"'"$SAVE_CIP"'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF 


if [ $FINAL_CNT -lt $CUR_CNT ]
then
	#Remove surplus/old diaplan	
	NUM=$FINAL_CNT		 
	while [ $NUM -lt $CUR_CNT ]
	do
		STR=NumPlanRules_"$NUM"_
		#echo Remove $STR >> $DB_LOG
		sed -i '/\(^'"$STR"'\).*/d' $CONF 
		#echo $NUM
		NUM=`expr $NUM + 1`
	done
fi 


replace() {
#echo replce $NUM

SAVE_CIP=`expr $CPEID + 1`
STR="NumPlanRules_"$CPEID"_cpeId="
SAVE="$STR"'"'"$SAVE_CIP"'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

STR="NumPlanRules_"$CPEID"_pcpeId="
SAVE="$STR"'"1"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

#Temp remove this item for speeding up
#STR="NumPlanRules_"$CPEID"_Rule="
#SAVE="$STR"'"34"'
#echo SAVE STR = $SAVE >> $DB_LOG
#sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

STR="NumPlanRules_"$CPEID"_Prefix="
INS_DIG="xxxx"
if [ $LAST -eq 1 ]
then
echo Last one add default >> $DB_LOG
SAVE="$STR"'""'
else
	PNUM=`expr $NUM + 1`
	PREFIX="$(echo $IN_STR | awk -F";" '{ print $'$PNUM' }')"
	
	#Have > mark
	H_MARK="$(echo $PREFIX | grep ">" )"
#	echo Mark $H_MARK

	if [ -z "$H_MARK" ]
	then
		SAVE="$STR"'"'"$PREFIX"'"'
	else
		PREFIX="$(echo $H_MARK | awk -F">" '{ print $2 }')"
		INS_DIG="$(echo $H_MARK | awk -F">" '{ print $1 }' | sed 's/<//' )"
#		echo $PREFIX
		SAVE="$STR"'"'"$PREFIX"'"'
#		echo $INS_DIG
	fi	
fi

echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

STR="NumPlanRules_"$CPEID"_MinLen="
if [ $LAST -eq 1 ]
then
#echo Last one add default
SAVE="$STR"'"3"'
else
SAVE="$STR"'"'0'"'
fi
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

STR="NumPlanRules_"$CPEID"_MaxLen="
if [ $LAST -eq 1 -o "$INS_DIG" != "xxxx" ]
then
#echo Last one add default
SAVE="$STR"'"25"'
else
SAVE="$STR"'"'0'"'
fi
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

#Temp remove this item for speeding up
#STR="NumPlanRules_"$CPEID"_RemDgts="
#SAVE="$STR"'"'0'"'
#echo SAVE STR = $SAVE >> $DB_LOG
#sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

#Temp remove this item for speeding up
#STR="NumPlanRules_"$CPEID"_Pos2Rem="
#SAVE="$STR"'"'0'"'
#echo SAVE STR = $SAVE >> $DB_LOG
#sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

STR="NumPlanRules_"$CPEID"_DigIns="
if [ "$INS_DIG" == "xxxx" ]
then
SAVE="$STR"'"''"'
else
SAVE="$STR"'"'"$INS_DIG"'"'
echo SAVE $SAVE
fi
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

STR="NumPlanRules_"$CPEID"_PosIns="
SAVE="$STR"'"'0'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

#Temp remove this item for speeding up
#STR="NumPlanRules_"$CPEID"_DigRep="
#SAVE="$STR"'"'0'"'
#echo SAVE STR = $SAVE >> $DB_LOG
#sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

#Temp remove this item for speeding up
#STR="NumPlanRules_"$CPEID"_PosRep="
#SAVE="$STR"'"'0'"'
#echo SAVE STR = $SAVE >> $DB_LOG
#sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

#Temp remove this item for speeding up
#STR="NumPlanRules_"$CPEID"_DialTone="
#SAVE="$STR"'"'3'"'
#echo SAVE STR = $SAVE >> $DB_LOG
#sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

#Temp remove this item for speeding up
#STR="NumPlanRules_"$CPEID"_FacArg="
#SAVE="$STR"'"'IFX_DP_DIALDEFAULT_DEF_IF'"'
#echo SAVE STR = $SAVE >> $DB_LOG
#sed -i 's|\(^'"$STR"'\).*|\'"$SAVE"'|' $CONF

}

insert() {

	#echo here
	LAST_CPEID=`expr $CPEID - 1`
	STR="NumPlanRules_"$LAST_CPEID"_FacArg="
	echo $STR
	LINE="$(grep -n "$STR" "$CONF"  | awk -F":" '{ print $1 }' )"
#	echo LINE $LINE
  
  LINE=`expr $LINE + 1`

SAVE_CIP=`expr $CPEID + 1`
STR="NumPlanRules_"$CPEID"_cpeId="
SAVE="$STR"'"'"$SAVE_CIP"'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_pcpeId="
SAVE="$STR"'"1"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`
STR="NumPlanRules_"$CPEID"_Rule="
SAVE="$STR"'"34"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_Prefix="
INS_DIG="xxxx"
if [ $LAST -eq 1 ]
then
echo Last one add default
SAVE="$STR"'""'
else
	PNUM=`expr $NUM + 1`
	PREFIX="$(echo $IN_STR | awk -F";" '{ print $'$PNUM' }')"
	
	#Have > mark
	H_MARK="$(echo $PREFIX | grep ">" )"
	echo $H_MARK
		
	if [ -z "$H_MARK" ]
	then
		SAVE="$STR"'"'"$PREFIX"'"'
	else
		PREFIX="$(echo $H_MARK | awk -F">" '{ print $2 }')"
		INS_DIG="$(echo $H_MARK | awk -F">" '{ print $1 }' | sed 's/<//' )"
		echo $PREFIX
		SAVE="$STR"'"'"$PREFIX"'"'
		echo $INS_DIG
	fi	
fi

echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_MinLen="
if [ $LAST -eq 1 ]
then
#echo Last one add default
SAVE="$STR"'"3"'
else
SAVE="$STR"'"'0'"'
fi
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_MaxLen="
if [ $LAST -eq 1 -o "$INS_DIG" != "xxxx" ]
then
#echo Last one add default
SAVE="$STR"'"25"'
else
SAVE="$STR"'"'0'"'
fi
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_RemDgts="
SAVE="$STR"'"'0'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_Pos2Rem="
SAVE="$STR"'"'0'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_DigIns="
if [ "$INS_DIG" == "xxxx" ]
then
SAVE="$STR"'"''"'
else
SAVE="$STR"'"'"$INS_DIG"'"'
echo SAVE $SAVE
fi
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_PosIns="
SAVE="$STR"'"'0'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_DigRep="
SAVE="$STR"'"'0'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_PosRep="
SAVE="$STR"'"'0'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_DialTone="
SAVE="$STR"'"'3'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

LINE=`expr $LINE + 1`

STR="NumPlanRules_"$CPEID"_FacArg="
SAVE="$STR"'"'IFX_DP_DIALDEFAULT_DEF_IF'"'
echo SAVE STR = $SAVE >> $DB_LOG
sed -i ''"$LINE"'i\'"$SAVE"'' $CONF

}

#Update new dialplan
NUM=0
LAST=0
while [ $NUM -lt $CNT ]
do
	#echo $NUM
	CPEID=`expr $FIXDP + $NUM`
	
	#Check if this is last one.
  NEXT=`expr $NUM + 1` 
  if [ $NEXT -eq $CNT ]
  then
  	LAST=1
  fi	
	
	#Check if replace or insert operation.
	if [ $CPEID -lt $CUR_CNT ]
	then
		replace
	else
		insert
	fi
	
	NUM=`expr $NUM + 1` 
done

#Save rc.conf
savecfg.sh

#Remove file lock
rm -f /tmp/rc_conf_lock
