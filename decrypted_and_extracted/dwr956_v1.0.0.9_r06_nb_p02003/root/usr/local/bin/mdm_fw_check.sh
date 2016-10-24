# /bin/sh
getFWUPStatus()
{
	FWUP_STATUS=`lte_get --download-status | grep Status | cut -d '=' -f2 | cut -d ',' -f1`
	while [ -z "$FWUP_STATUS" ]
	do
	    sleep 3
		FWUP_STATUS=`lte_get --download-status`
		echo "$FWUP_STATUS" >> /tmp/mdm_upgrade.tmp	
		if [ "$FWUP_STATUS" = "Error: lte_daemon not running." ]; then
	        return
		else
		    FWUP_STATUS=`echo $FWUP_STATUS | grep Status | cut -d '=' -f2 | cut -d ',' -f1`
		fi
	done
	echo "$FWUP_STATUS" >> /tmp/mdm_upgrade.tmp
}

getFWUPStatus
if [ "$FWUP_STATUS" != -1 ]; then
    echo "Dual image version"
	if [ "$FWUP_STATUS" = 2 ]; then
	  sync
	  echo 1 > /tmp/MDM_UPFW_STATUS
	  
	  lte_set --ums 0
	  sleep 2
	  retry=0
	  while [ ! -e /tmp/mdm_upgrade_command_start ]
	  do
	    retry=$(( $retry + 1 ))
	    sleep 3
	    lte_set --ums 0
	  done
	  rm /tmp/mdm_upgrade_command_start
	  retry=0
	  while [ ! -e /tmp/mdm_upgrade_command_end ]
	  do
	    retry=$(( $retry + 1 ))
	    sleep 3
	  done
	  rm /tmp/mdm_upgrade_command_end
	
	  sleep 1
	  getFWUPStatus
	  while [ "$FWUP_STATUS" = 2 ]
	  do
	    sleep 3
		getFWUPStatus
	  done
	  rm -rf /tmp/modem_fw/
	  mkdir  /tmp/modem_fw/
	  mkdir  /tmp/modem_fw/LOG/
	  echo 0 > /tmp/MDM_UPFW_STATUS
	else
	  echo 1 > /tmp/MDM_UPFW_STATUS
	fi
    return
fi

echo "========== Modem FW Check START =========="

FW_IMG_ZIP="$1"
UNZIP_DIR=/tmp/modem_fw
FWDIR=/tmp/modem_fw/SCAQDBZ
UPFW_STATUS=/tmp/MDM_UPFW_STATUS
UPFW_STATE=/tmp/MDM_UPFW_STATE
PRODUCT_ID_PATH=/sys/devices/platform/ifxusb_hcd/usb2/2-1/idProduct
D15_PRODUCT_ID=9011
D15_3RMNET_PRODUCT_ID=900f
D16_PRODUCT_ID=9046
DL_MODE_PRODUCT_ID=900e

PRODUCT_ID=`cat $PRODUCT_ID_PATH`
echo "FW Direction : $FW_IMG_ZIP"

test -e $FWDIR && rm -rf $FWDIR
mkdir -p $FWDIR

test -e $UPFW_STATUS && rm -f $UPFW_STATUS

echo "Start to check MDM FW"
echo 1 > $UPFW_STATUS
echo 12 > $UPFW_STATE

echo "========== Unzip Modem FW =========="
tar -zxvf $FW_IMG_ZIP -C $UNZIP_DIR


if [ $PRODUCT_ID = $D15_PRODUCT_ID ] || [ $PRODUCT_ID = $DL_MODE_PRODUCT_ID ] || [ $PRODUCT_ID = $D15_3RMNET_PRODUCT_ID ]; then
	if [ $PRODUCT_ID = $D15_PRODUCT_ID ]; then 
		echo "Modem Module : D15"
	else
		echo "Modem module is under download mode!"
	fi

	echo "========== Check necessary files START =========="
	if [ -z $FWDIR ]; then 
		echo "ERROR! Empty FW direction."
		echo 2 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/finish.txt ]; then
		echo "finish.txt exist"
	else
		echo "ERROR! Missing file : finish.txt"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/amss.mbn ]; then
		echo "amss.mbn exist"
	else
	    echo "ERROR! Missing file : amss.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
	    exit 0
	fi

	if [ -e "$FWDIR"/dbl.mbn ]; then
	        echo "dbl.mbn exist"
	else
		echo "ERROR! Missing file : dbl.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/dsp1.mbn ]; then
	        echo "dsp1.mbn exist"
	else
		echo "ERROR! Missing file : dsp1.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/dsp2.mbn ]; then
	        echo "dsp2.mbn exist"
	else
		echo "ERROR! Missing file : dsp2.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/fsbl.mbn ]; then
	        echo "fsbl.mbn exist"
	else
		echo "ERROR! Missing file : fsbl.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/osbl.mbn ]; then
	        echo "osbl.mbn exist"
	else
		echo "ERROR! Missing file : osbl.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/partition.mbn ]; then
	        echo "partition.mbn exist"
	else
		echo "ERROR! Missing file : partition.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/ENPRG9x00.hex ]; then
	        echo "ENPRG9x00.hex exist"
	else
		echo "ERROR! Missing file : ENPRG9x00.hex"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/NPRG9x00.hex ]; then
	        echo "NPRG9x00.hex exist"
	else
		echo "ERROR! Missing file : NPRG9x00.hex"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi
	
	if [ -e "$FWDIR"/qcn_update.qcn ]; then
		echo "qcn_update.qcn exist"
		qcn_update=1
	else
		echo "qcn_update.qcn NOT exist"
		qcn_update=0
	fi
	
	echo "========== Check necessary files PASS =========="

	##========== assign fw information file ==========
	size_info="$FWDIR""/finish.txt"

	echo "========== Getting size info from finish.txt START =========="
	ENPRG_info=`cat $size_info | grep "ENPRG" |awk '{print $5}'`
	echo "ENPRG=$ENPRG_info"

	NPRG_info=`cat $size_info | grep "NPRG"| grep -v "ENPRG"|awk '{print $5}'`
	echo "NPRG=$NPRG_info"

	partition_info=`cat $size_info | grep "partition" |awk '{print $5}'`
	echo "partition=$partition_info"

	dbl_info=`cat $size_info | grep "dbl" |awk '{print $5}'`
	echo "dbl=$dbl_info"

	osbl_info=`cat $size_info | grep "osbl" |awk '{print $5}'`
	echo "osbl=$osbl_info"

	fsbl_info=`cat $size_info | grep "fsbl" |awk '{print $5}'`
	echo "fsbl=$fsbl_info"

	amss_info=`cat $size_info | grep "amss" |awk '{print $5}'`
	echo "amss=$amss_info"

	dsp1_info=`cat $size_info | grep "dsp1" |awk '{print $5}'`
	echo "dsp1=$dsp1_info"

	dsp2_info=`cat $size_info | grep "dsp2" |awk '{print $5}'`
	echo "dsp2=$dsp2_info"

	if [ $qcn_update -eq 1 ]; then
		qcn_info=`cat $size_info | grep "qcn_update" |awk '{print $5}'`
		echo "qcn=$qcn_info"
	fi
	
	echo "========== Getting size info from finish.txt END =========="

	echo "========== Compare files size START =========="
	if [ -n "$ENPRG_info" ]; then
	   ENPRG_local=`ls -al $FWDIR/ENPRG* |awk '{print $5}'`
	   echo "ENPRG_info=$ENPRG_info, ENPRG_local=$ENPRG_local"
	   if [ ${ENPRG_info} -eq ${ENPRG_local} ]; then
	      echo "ENPRG match"
	   else
	      echo "ENPRG NOT Match, break out"
	      echo 4 > $UPFW_STATUS
	      echo 21 > $UPFW_STATE
	      exit 0
	   fi
	fi

	if [ -n "$NPRG_info" ]; then
	   NPRG_local=`ls -al $FWDIR/NPRG* |awk '{print $5}'`
	   echo "NPRG_info=$NPRG_info, NPRG_local=$NPRG_local"
	   if [ ${NPRG_info} -eq ${NPRG_local} ]; then
	       echo "NPRG match"
	   else
	       echo "NPRG NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$partition_info" ]; then
	   partition_local=`ls -al $FWDIR/partition* |awk '{print $5}'`
	   echo "partition_info=$partition_info, partition_local=$partition_local"
	   if [ ${partition_info} -eq ${partition_local} ]; then
	       echo "partition match"
	   else
	       echo "partition NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$dbl_info" ]; then
	   dbl_local=`ls -al $FWDIR/dbl* |awk '{print $5}'`
	   echo "dbl_info=$dbl_info, dbl_local=$dbl_local"
	   if [ ${dbl_info} -eq ${dbl_local} ]; then
	       echo "dbl match"
	   else
	       echo "dbl NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$osbl_info" ]; then
	   osbl_local=`ls -al $FWDIR/osbl* |awk '{print $5}'`
	   echo "osbl_info=$osbl_info, osbl_local=$osbl_local"
	   if [ ${osbl_info} -eq ${osbl_local} ]; then
	       echo "osbl match"
	   else
	       echo "osbl NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$fsbl_info" ]; then
	   fsbl_local=`ls -al $FWDIR/fsbl* |awk '{print $5}'`
	   echo "fsbl_info=$fsbl_info, fsbl_local=$fsbl_local"
	   if [ ${fsbl_info} -eq ${fsbl_local} ]; then
	       echo "fsbl match"
	   else
	       echo "fsbl NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$amss_info" ]; then
	   amss_local=`ls -al $FWDIR/amss* |awk '{print $5}'`
	   echo "amss_info=$amss_info, amss_local=$amss_local"
	   if [ ${amss_info} -eq ${amss_local} ]; then
	       echo "amss match"
	   else
	       echo "amss NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$dsp1_info" ]; then
	   dsp1_local=`ls -al $FWDIR/dsp1* |awk '{print $5}'`
	   echo "dsp1_info=$dsp1_info, dsp1_local=$dsp1_local"
	   if [ ${dsp1_info} -eq ${dsp1_local} ]; then
	       echo "dsp1 match"
	   else
	       echo "dsp1 NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$dsp2_info" ]; then
	   dsp2_local=`ls -al $FWDIR/dsp2* |awk '{print $5}'`
	   echo "dsp2_info=$dsp2_info, dsp2_local=$dsp2_local"
	   if [ ${dsp2_info} -eq ${dsp2_local} ]; then
	       echo "dsp2 match"
	   else
	       echo "dsp2 NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ $qcn_update -eq 1 ]; then
		if [ -n "$qcn_info" ]; then
		   qcn_local=`ls -al $FWDIR/qcn* |awk '{print $5}'`
		   echo "qcn_info=$qcn_info, qcn_local=$qcn_local"
		   if [ ${qcn_info} -eq ${qcn_local} ]; then
		       echo "qcn match"
		   else
		       echo "qcn NOT Match, break out"
		       echo 4 > $UPFW_STATUS
		       echo 21 > $UPFW_STATE
		       exit 0
		   fi
		fi
	fi	
	echo "========== Compare files size END =========="
	
elif [ $PRODUCT_ID = $D16_PRODUCT_ID ]; then

	echo "Modem Module : D16"
	echo "========== Check necessary files START =========="
	if [ -z $FWDIR ]; then 
		echo "ERROR! Empty FW direction."
		echo 2 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/finish.txt ]; then
		echo "finish.txt exist"
	else
		echo "ERROR! Missing file : finish.txt"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi


	if [ -e "$FWDIR"/dsp1.mbn ]; then
	        echo "dsp1.mbn exist"
	else
		echo "ERROR! Missing file : dsp1.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/dsp2.mbn ]; then
	        echo "dsp2.mbn exist"
	else
		echo "ERROR! Missing file : dsp2.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

# Woody 2013-06-04 : add dsp3.mbn for D16 module
	if [ -e "$FWDIR"/dsp3.mbn ]; then
	        echo "dsp3.mbn exist"
	else
		echo "ERROR! Missing file : dsp3.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/partition.mbn ]; then
	        echo "partition.mbn exist"
	else
		echo "ERROR! Missing file : partition.mbn"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/NPRG9x15.hex ]; then
	        echo "NPRG9x15.hex exist"
	else
		echo "ERROR! Missing file : NPRG9x15.hex"
		echo 3 > $UPFW_STATUS
		echo 21 > $UPFW_STATE
		exit 0
	fi

	if [ -e "$FWDIR"/qcn_update.qcn ]; then
		echo "qcn_update.qcn exist"
		qcn_update=1
	else
		echo "qcn_update.qcn NOT exist"
		qcn_update=0
	fi
	echo "========== Check necessary files PASS =========="

	##========== assign fw information file ==========
	size_info="$FWDIR""/finish.txt"

	echo "========== Getting size info from finish.txt START =========="

	NPRG_info=`cat $size_info | grep "NPRG"| grep -v "ENPRG"|awk '{print $5}'`
	echo "NPRG=$NPRG_info"

	partition_info=`cat $size_info | grep "partition" |awk '{print $5}'`
	echo "partition=$partition_info"

	dsp1_info=`cat $size_info | grep "dsp1" |awk '{print $5}'`
	echo "dsp1=$dsp1_info"

	dsp2_info=`cat $size_info | grep "dsp2" |awk '{print $5}'`
	echo "dsp2=$dsp2_info"

# Woody 2013-06-04 : add dsp3.mbn for D16 module
	dsp3_info=`cat $size_info | grep "dsp3" |awk '{print $5}'`
	echo "dsp3=$dsp3_info"

	if [ $qcn_update -eq 1 ]; then
		qcn_info=`cat $size_info | grep "qcn_update" |awk '{print $5}'`
		echo "qcn=$qcn_info"
	fi
	
	echo "========== Getting size info from finish.txt END =========="

	echo "========== Compare files size START =========="
	if [ -n "$NPRG_info" ]; then
	   NPRG_local=`ls -al $FWDIR/NPRG* |awk '{print $5}'`
	   echo "NPRG_info=$NPRG_info, NPRG_local=$NPRG_local"
	   if [ ${NPRG_info} -eq ${NPRG_local} ]; then
	       echo "NPRG match"
	   else
	       echo "NPRG NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$partition_info" ]; then
	   partition_local=`ls -al $FWDIR/partition* |awk '{print $5}'`
	   echo "partition_info=$partition_info, partition_local=$partition_local"
	   if [ ${partition_info} -eq ${partition_local} ]; then
	       echo "partition match"
	   else
	       echo "partition NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$dsp1_info" ]; then
	   dsp1_local=`ls -al $FWDIR/dsp1* |awk '{print $5}'`
	   echo "dsp1_info=$dsp1_info, dsp1_local=$dsp1_local"
	   if [ ${dsp1_info} -eq ${dsp1_local} ]; then
	       echo "dsp1 match"
	   else
	       echo "dsp1 NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

	if [ -n "$dsp2_info" ]; then
	   dsp2_local=`ls -al $FWDIR/dsp2* |awk '{print $5}'`
	   echo "dsp2_info=$dsp2_info, dsp2_local=$dsp2_local"
	   if [ ${dsp2_info} -eq ${dsp2_local} ]; then
	       echo "dsp2 match"
	   else
	       echo "dsp2 NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi

# Woody 2013-06-04 : add dsp3.mbn for D16 module
	if [ -n "$dsp3_info" ]; then
	   dsp3_local=`ls -al $FWDIR/dsp3* |awk '{print $5}'`
	   echo "dsp3_info=$dsp3_info, dsp3_local=$dsp3_local"
	   if [ ${dsp3_info} -eq ${dsp3_local} ]; then
	       echo "dsp3 match"
	   else
	       echo "dsp3 NOT Match, break out"
	       echo 4 > $UPFW_STATUS
	       echo 21 > $UPFW_STATE
	       exit 0
	   fi
	fi
	
	if [ $qcn_update -eq 1 ]; then
		if [ -n "$qcn_info" ]; then
		   qcn_local=`ls -al $FWDIR/qcn* |awk '{print $5}'`
		   echo "qcn_info=$qcn_info, qcn_local=$qcn_local"
		   if [ ${qcn_info} -eq ${qcn_local} ]; then
		       echo "qcn match"
		   else
		       echo "qcn NOT Match, break out"
		       echo 4 > $UPFW_STATUS
		       echo 21 > $UPFW_STATE
		       exit 0
		   fi
		fi
	fi
	
	echo "========== Compare files size END =========="
else
	echo "ERROR!! Unknown Module ID, Stop checking!!"
	echo 5 > $UPFW_STATUS
	echo 21 > $UPFW_STATE
	exit 0
fi


rm -rf $FW_IMG_ZIP
echo 0 > $UPFW_STATUS
echo 21 > $UPFW_STATE
echo "========== Modem FW Check END =========="
