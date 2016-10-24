#!/bin/sh
# Note : Dette vil dekryptere firmware filene til D-link DWR-956
# Skrevet av: Andreas Nilsen - adde88@gmail.com
# 18.05.2016
#

test -e ./$1 ||
{
	echo "\No firmware selected! Abort!!"
	exit 0
}

BRANCH=$2
echo "\nBranch = $BRANCH"
TempFW=${BRANCH}-fullimage.img

if [ "$BRANCH" = "P01001" ]; then
	KEY=97331723P01001
elif [ "$BRANCH" = "P01002" ]; then
	KEY=97331723P01002
elif [ "$BRANCH" = "P01003" ]; then
	KEY=97331723P01003
elif [ "$BRANCH" = "P02001" ]; then
	KEY=97331723P02001
elif [ "$BRANCH" = "P02002" ]; then
	KEY=97331723P02002
elif [ "$BRANCH" = "P02003" ]; then
	KEY=97331723P02003
else
	echo "\Ukjent branch!"
	exit 0
fi

echo $KEY > ./${BRANCH}_KEY
openssl enc -d -des -k ./${BRANCH}_KEY -in ./$1 -out ./$TempFW &&
echo "\nFirmware dekryptert: "$TempFW
rm -f ./${BRANCH}_KEY
exit 0