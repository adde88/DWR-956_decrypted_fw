#!/bin/sh
# Note : This script should be ran at /tmp directory.
#echo "Start to run ap_fw_upgrade.sh"

test -e /tmp/$1 ||
{
	echo "FW not exist! ABORT!!"
	exit 0
}

BRANCH=`version.sh | grep Branch | awk -F: '{print $2}' | awk -F- '{print $1}'`
echo "Branch = $BRANCH"
EngUpgrade=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select EngUpgrade from ApFwUpgrade;"`
CheckResult=/tmp/ap_fw_check
TempFW=fullimage.img
UpgradeTarget=/tmp/ap_fw_target
BranchNum=6
CheckRun=6


if [ "$BRANCH" = "P01001" ]; then
	KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P01001_KEY from ApFwUpgrade;"`
	offset=0
elif [ "$BRANCH" = "P01002" ]; then
	KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P01002_KEY from ApFwUpgrade;"`
	offset=1
elif [ "$BRANCH" = "P01003" ]; then
	KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P01003_KEY from ApFwUpgrade;"`
	offset=2
elif [ "$BRANCH" = "P02001" ]; then
	KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P02001_KEY from ApFwUpgrade;"`
	offset=3
elif [ "$BRANCH" = "P02002" ]; then
	KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P02002_KEY from ApFwUpgrade;"`
	offset=4
elif [ "$BRANCH" = "P02003" ]; then
	KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P02003_KEY from ApFwUpgrade;"`
	offset=5
else
	echo "Unknown branch! Device will be upgraded in EngUpgrade Mode!"
	EngUpgrade=1
	offset=0
fi

echo 2 > $CheckResult
if [ "$EngUpgrade" = "1" ]; then
	echo " Engineer Upgrade : Don't care Branch, always try to download the FW."
#try to decrypt the FW
	count=$offset
	BranchNum=$(( $BranchNum + $offset ))
	while [ $count -lt $BranchNum ]
	do
		TMP=$(( $count % $CheckRun ))
		if [ "$TMP" = "0" ]; then
			P01001_KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P01001_KEY from ApFwUpgrade;"`
			echo "$P01001_KEY" > /tmp/P01001_KEY
			KEY_FILE=./P01001_KEY
		elif [ "$TMP" = "1" ]; then
			P01002_KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P01002_KEY from ApFwUpgrade;"`
			echo "$P01002_KEY" > /tmp/P01002_KEY
			KEY_FILE=./P01002_KEY
		elif [ "$TMP" = "2" ]; then
			P01003_KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P01003_KEY from ApFwUpgrade;"`
			echo "$P01003_KEY" > /tmp/P01003_KEY
			KEY_FILE=./P01003_KEY
		elif [ "$TMP" = "3" ]; then
			P02001_KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P02001_KEY from ApFwUpgrade;"`
			echo "$P02001_KEY" > /tmp/P02001_KEY
			KEY_FILE=./P02001_KEY
		elif [ "$TMP" = "4" ]; then
			P02002_KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P02002_KEY from ApFwUpgrade;"`
			echo "$P02002_KEY" > /tmp/P02002_KEY
			KEY_FILE=./P02002_KEY
		elif [ "$TMP" = "5" ]; then
			P02003_KEY=`sqlite3 -cmd ".timeout 1000" /tmp/system.db "select P02003_KEY from ApFwUpgrade;"`
			echo "$P02003_KEY" > /tmp/P02003_KEY
			KEY_FILE=./P02003_KEY
		fi

		openssl enc -d -des -k $KEY_FILE -in ./$1 -out ./$TempFW &&
		{
			echo "AP FW Check PASS!!"
			echo 0 > $CheckResult
			#do upgrade command here
#			/etc/rc.d/invoke_upgrade.sh /tmp/$TempFW fullimage 1 saveenv reboot &
			echo 1 > $UpgradeTarget
			exit 0
		}||
		{
			rm -f /tmp/$TempFW
		}
		count=$(( $count + 1 ))
	done

#	echo "AP FW check failed! Stop upgrade process!"
#	echo 1 > $CheckResult
	echo "Encrypted image check failed!! Try to upgrade none encrypted image."
	echo 0 > $CheckResult
#	/etc/rc.d/invoke_upgrade.sh /tmp/$1 fullimage 1 saveenv reboot &
	echo 0 > $UpgradeTarget
else
	echo " End-User Upgrade : Based on Branch to check if FW correct."
# create the KEY of current branch
	echo $KEY > /tmp/${BRANCH}_KEY
	openssl enc -d -des -k ./${BRANCH}_KEY -in ./$1 -out ./$TempFW && 
	{
		echo "AP FW Check PASS!!"
		echo 0 > $CheckResult
		#do upgrade command here
#		/etc/rc.d/invoke_upgrade.sh /tmp/$TempFW fullimage 1 saveenv reboot &
		echo 1 > $UpgradeTarget
	}||
	{
		echo "AP FW check failed! Stop upgrade process!"
		echo 1 > $CheckResult
		rm -f /tmp/$TempFW
	}	
fi
