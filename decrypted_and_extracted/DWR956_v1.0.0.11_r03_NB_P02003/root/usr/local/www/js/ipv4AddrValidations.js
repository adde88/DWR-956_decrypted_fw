/* ipv4AddrValidations.js - API library for IPv4 Address Validations */

/*
* Copyright (c) 2010 TeamF1, Inc.
* All rights reserved.
*/

/*
modification history 
------------------------
*/

function nextActiveFieldGet (srcObj)
{
if (!srcObj) return null;
if ((srcObj.name).indexOf("ip4.") == 0) return null;
var currObj = null;
var formObj = srcObj.form;
var nFormElmnts = formObj.elements.length;
for (var i = 0; i < nFormElmnts; i++)
{
currObj = formObj.elements[i];
if (currObj.type != "hidden" &&
!currObj.disabled)
{
if (srcObj == currObj && i != (nFormElmnts - 1))
return formObj.elements[i+1]
}
}
return null;
}
/* 
* minVal & maxVal are the min and max values for the specified octet.
* errStr is the message that need to be displayed when the specified octet fails
* to statisfy specified values.
*/
function ipv4ByteCheck (eventObj, srcObj, minVal, maxVal, prefixStr, suffixStr)
{
if (!eventObj || !srcObj)
return false;

var i18n_invalidIP = '';
var i18n_invalidIPObj = document.getElementById('i18n_invalidIP');
if(i18n_invalidIPObj) i18n_invalidIP = i18n_invalidIPObj.value;

var i18n_eachOctet = '';
var i18n_eachOctetObj = document.getElementById('i18n_eachOctet');
if(i18n_eachOctetObj) i18n_eachOctet = i18n_eachOctetObj.value;
var charUniCode = eventObj.charCode ? eventObj.charCode : eventObj.keyCode;
/* process only 'tab', '.' keys and space*/
if (charUniCode != 9 &&
charUniCode != 110 && charUniCode != 190 &&
charUniCode != 32)
return true;
var value = srcObj.value;
/* return false if field value is empty */
if (value.length == 0)
return true;
if (!minVal) minVal = 0;
if (!maxVal) maxVal = 255;
if (!prefixStr) prefixStr = i18n_invalidIP;
if (!suffixStr) suffixStr = i18n_eachOctet;
if (!(numericValueRangeCheck (srcObj, '', '', minVal, maxVal, true, prefixStr, suffixStr)))
{
srcObj.focus ();
return false;
}
/* move focus to next active object if '.' is pressed */
if (charUniCode == 110 || charUniCode == 190 ||
charUniCode == 32)
{
var nextObj = nextActiveFieldGet (srcObj);
if (nextObj)
{
nextObj.focus ();
nextObj.select ();
}
return false;
}
return true;
}
function ipv4AddrsCheck (ipv4TblIdArr)
{
for (var i = 0; i < ipv4TblIdArr.length; ++i)
{
var result = false;
var strArr = ipv4TblIdArr[i].split(",");
if (strArr.length > 1)
{
/*
* the string will be in the following format.
* strArr[0] - IPV4 address table ID.
* strArr[1] - IPV4 address address type (IP,SM,NID).
* strArr[2] - optional/mandatory (true/false).
* strArr[3] - prefix error string.
* strArr[4] - suffix error string.
*/
result = ipv4AddrOctetsValidate (strArr[0], strArr[1],
(strArr[2] == 'true'),
true, strArr[3], strArr[4], true);
}
else
result = ipv4AddrOctetsValidate (strArr[0], 'IP', false);
if (!result) return false;
}
}
function ipv4AddrOctetsValidate 
(ipv4TblId, ipv4AddrTypeStr, optFlag, alertFlag, prefixStr, suffixStr, octetShowFlag)
{
if (!ipv4TblId) return false;
var obj = document.getElementById(ipv4TblId);
var objArr = obj.getElementsByTagName("INPUT");
if (!objArr.length) return false;
if (!ipv4AddrTypeStr) ipv4AddrTypeStr = 'IP';
return ipv4AddrFormatCheck (objArr, ipv4AddrTypeStr, optFlag, alertFlag,
prefixStr, suffixStr, octetShowFlag)
}
function ipv4AddrFormatCheck
(objArr, ipv4AddrTypeStr, optFlag, alertFlag, prefixStr, suffixStr, octetShowFlag)
{
var i18n_valueBetween = '';
var i18n_valueBetweenObj = document.getElementById('i18n_valueBetween');
if(i18n_valueBetweenObj) i18n_valueBetween = i18n_valueBetweenObj.value;

var i18n_eachOctet = '';
var i18n_eachOctetObj = document.getElementById('i18n_eachOctet');
if(i18n_eachOctetObj) i18n_eachOctet = i18n_eachOctetObj.value;

var ipOctetMinVal = 0;
var ipOctetMaxVal = 255;
var isFirstByteZero = false;
var isError = false;
var ipOctetSpecified = false;
var errMsg = '';
if (objArr[0].disabled) return true;
for (var i = 0; i < objArr.length; i++)
{
if (objArr[i].disabled) break;
ipOctetMinVal = 0;
ipOctetMaxVal = 255;
isError = false;
var value = objArr[i].value;
var errMsg = '';
if (alertFlag)
{
if (prefixStr) errMsg = prefixStr;
errMsg += " " + i18n_valueBetween + " " + ipOctetMinVal +
" - " + ipOctetMaxVal + " ";
if (suffixStr) errMsg += suffixStr;
}
if (value.length == 0)
{
if (optFlag && !ipOctetSpecified)
{
continue;
}
var j = 0;
if (i == 0)
{
/* check for full empty IP address */
for (j = i; j < objArr.length; ++j)
{
if ((objArr[j].value).length)
break;
}
}
if (errMsg)
{
var i18n_ipNotSpecified = '';
var i18n_ipNotSpecifiedObj = document.getElementById('i18n_ipNotSpecified');
if(i18n_ipNotSpecifiedObj) i18n_ipNotSpecified = i18n_ipNotSpecifiedObj.value;


if ((i == 0) && (j == objArr.length) && errMsg)
alert (i18n_ipNotSpecified + "\n" + prefixStr +
i18n_valueBetween + " " + ipOctetMinVal +
" - " + ipOctetMaxVal + " "+i18n_eachOctet);
else
{
if (octetShowFlag) errMsg += (i+1);
alert (errMsg);
}
}
objArr[i].focus ();
return false;
}
if (optFlag)
{
if (i > 0 && !ipOctetSpecified)
{
if (errMsg)
{
if (octetShowFlag) errMsg += (i+1);
alert (errMsg);
}
objArr[i].focus ();
return false;
}
ipOctetSpecified = true;
}
/* if (i == 0)
{
if (parseInt (value) == 0)
{
isFirstByteZero = true;
continue;
}
ipOctetMinVal = 1;
}
if (((i+1) == 4) && (ipv4AddrTypeStr == 'IP'))
{
if (!isFirstByteZero)
ipOctetMinVal = 1;
ipOctetMaxVal = 254;
} 
*/ 
if (((i+1) == 1) && (ipv4AddrTypeStr == 'IP'))
{
/* first octet should not exceed 223 */ 
ipOctetMaxVal = 223;
}
if (((parseInt (value) > 0) && isFirstByteZero) ||
(parseInt (value) < ipOctetMinVal || parseInt (value) > ipOctetMaxVal))
{
isError = true;
}
if (isError)
{
if (isFirstByteZero) --i;
if (alertFlag)
{
/* if (i == 0)
ipOctetMinVal = 1; */
if (prefixStr) errMsg = prefixStr;
errMsg += " " + i18n_valueBetween + " " + ipOctetMinVal +
" - " + ipOctetMaxVal + " ";
if (suffixStr) errMsg += suffixStr;
if (octetShowFlag) errMsg += (i+1);
alert (errMsg);
}
objArr[i].focus ();
return false;
}
}
return true;
}
function ipv4AddrNoZero (ipv4TblId, alertFlag, errMsg)
{
if (!ipv4TblId) return false;
var obj = document.getElementById(ipv4TblId);
var objArr = obj.getElementsByTagName("INPUT");
if (!objArr.length) return false;
var ipValue = "";
for (var i = 0; i < objArr.length; i++)
{
if (objArr[i].disabled) break;
ipValue += objArr[i].value;
}
if (parseInt (ipValue, 10) <= 0)
{
if (alertFlag)
alert (errMsg);
return false;
}
return true;
}
var subnetOctets = [0, 128, 192, 224, 240, 248, 252, 254, 255];
function checkSnetMask (snetMaskOctet, stIdx, endIdx)
{
if (isNaN (snetMaskOctet)) return true;
var errorFlag = false;
for (var i = stIdx; i <= endIdx; i++)
{
if (parseInt (snetMaskOctet,10) == subnetOctets[i])
{
errorFlag = true;
break;
}
}
return errorFlag;
}
/* Validating IP Address */
function ipv4AddrValuesCheck
(obj, objArr, ipv4AddrTypeStr, optFlag, alertFlag, prefixStr, suffixStr, octetShowFlag, tblIPAddrId)
{	
	/*	
	var i18n_invalidOctetV4 = '';
	var i18n_invalidOctetV4Obj = document.getElementById('i18n_invalidOctetV4');
	if(i18n_invalidOctetV4Obj) i18n_invalidOctetV4 = i18n_invalidOctetV4Obj.value;

	var i18n_removeLead = '';
	var i18n_removeLeadObj = document.getElementById('i18n_removeLead');
	if(i18n_removeLeadObj) i18n_removeLead = i18n_removeLeadObj.value;

	var i18n_enter255 = '';
	var i18n_enter255Obj = document.getElementById('i18n_enter255');
	if(i18n_enter255Obj) i18n_enter255 = i18n_enter255Obj.value;

	var i18n_enter0 = '';
	var i18n_enter0Obj = document.getElementById('i18n_enter0');
	if(i18n_enter0Obj) i18n_enter0 = i18n_enter0Obj.value;

	var i18n_enter0252 = '';
	var i18n_enter0252Obj = document.getElementById('i18n_enter0252');
	if(i18n_enter0252Obj) i18n_enter0252 = i18n_enter0252Obj.value;

	var i18n_enter0255 = '';
	var i18n_enter0255Obj = document.getElementById('i18n_enter0255');
	if(i18n_enter0255Obj) i18n_enter0255 = i18n_enter0255Obj.value;

	var i18n_enter0255Octet = '';
	var i18n_enter0255OctetObj = document.getElementById('i18n_enter0255Octet');
	if(i18n_enter0255OctetObj) i18n_enter0255Octet = i18n_enter0255OctetObj.value;

	var i18n_valueBetween = '';
	var i18n_valueBetweenObj = document.getElementById('i18n_valueBetween');
	if(i18n_valueBetweenObj) i18n_valueBetween = i18n_valueBetweenObj.value;

	var i18n_eachOctet = '';
	var i18n_eachOctetObj = document.getElementById('i18n_eachOctet');
	if(i18n_eachOctetObj) i18n_eachOctet = i18n_eachOctetObj.value;
	*/

	//var errDisplayField = document.getElementById ("genericErr")
	//if (errDisplayField) errDisplayField.innerHTML = "";
	var ipOctetMinVal = 0;
	var ipOctetMaxVal = 255;
	var isFirstByteZero = false;
	var isError = false;
	var ipOctetSpecified = false;
	var errMsg = '';
	var tblIPAddrId = obj.id;
	
	
	var  genErrStr="Invalid Format";
	
	if(tblIPAddrId == "lan_ip")
		genErrStr = "Invalid IP Address Format.";
	else if(tblIPAddrId == "lan_submask")
		genErrStr = "Invalid Subnet Mask Format.";
	else if(tblIPAddrId == "remote_ip")
		genErrStr = "Invalid IP Address Format.";
	
	for (var i = 0; i < objArr.length; i++)
	{
		ipOctetMinVal = 0;
		ipOctetMaxVal = 255;
		isError = false;
		var value = objArr[i];
		var errMsg = '';
		if (value != "" && isNaN (value))
		{
			/*
			errMsg += " " + i18n_invalidOctetV4 + " " + (i + 1);
			if (document.getElementById(tblIPAddrId+"Msg"))
			{
				//document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";
			}
			if (errDisplayField)
				errDisplayField.innerHTML += "*"+errMsg+"<br>";
			else
			{
				alert (errMsg);
			}
			*/
			alert(genErrStr);
			return false;
		}
		if (value.length != (parseInt (value)+"").length)
		{
			/*
			if (prefixStr) errMsg = prefixStr;
				errMsg += " " + i18n_removeLead + " " + (i + 1);
			if (document.getElementById(tblIPAddrId+"Msg"))
				document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";

			if (errDisplayField)
				errDisplayField.innerHTML += "*"+errMsg+"<br>";
			else
				alert (errMsg);
			*/
		    alert(genErrStr);
			return false;
		}
		/*
		if (alertFlag)
		{
			if (prefixStr) errMsg = prefixStr;
			if ((ipv4AddrTypeStr == 'SM' || ipv4AddrTypeStr == 'SNM') && ((i+1) == 1))
				errMsg += " " + i18n_enter255 + " ";
			else if ((ipv4AddrTypeStr == 'SM') && ((i+1) == 4))
			{
				if (objArr[i-1] != "255")
					errMsg += " " + i18n_enter0 + " ";
				else
					errMsg += " " + i18n_enter0252 + " ";
			}
		else if ((ipv4AddrTypeStr == 'SM' || ipv4AddrTypeStr == 'SNM') && ((i+1) > 1))
		{
			if (objArr[i-1] != "255")
				errMsg += " "+i18n_enter0+" ";
			else
				errMsg += " ";
		}
		else
		{
			errMsg += " " + i18n_enter0255 + " " + ipOctetMinVal +" - " + ipOctetMaxVal + " ";
		}
		*/
		if (suffixStr) errMsg += suffixStr;
		if (value.length == 0 || value.length > 3)
		{
			if (optFlag && !ipOctetSpecified)
			{
				continue;
			}
		var j = 0;
		if (i == 0)
		{
			/* check for full empty IP address */
			for (j = i; j < objArr.length; ++j)
			{
				if (objArr[j].length)
				break;
			}
		}
		if (errMsg)
		{
			if ((i == 0) && (j == objArr.length) && errMsg)
			{
				if (ipv4AddrTypeStr == 'SM' || ipv4AddrTypeStr == 'SNM')
					if (alertFlag)
					{
						/*
						errMsg = prefixStr + i18n_enter0255Octet;
						if (document.getElementById(tblIPAddrId+"Msg"))
							document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";
						
						if (errDisplayField)
							errDisplayField.innerHTML += "*"+errMsg+"<br>";
						else
							alert (errMsg);
						*/
					}
				else
					if (alertFlag)
					{
						/*
						errMsg = prefixStr + i18n_valueBetween + " " + ipOctetMinVal +" - " + ipOctetMaxVal + " " + i18n_eachOctet;
						if (document.getElementById(tblIPAddrId+"Msg"))
							document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";

						if (errDisplayField)
							//errDisplayField.innerHTML += "*"+errMsg+"<br>";
						else
							//alert (errMsg);
						*/
					}
				}	
			else
			{
				/*
				if (octetShowFlag)
				{
					var i18n_invalidOctet4Len = "";
					var i18n_invalidOctet4LenObj = document.getElementById('i18n_invalidOctet4Len');
					if(i18n_invalidOctet4LenObj) i18n_invalidOctet4Len = i18n_invalidOctet4LenObj.value;
					if (value.length > 3)
						errMsg = i18n_invalidOctet4Len + " " + (i+1);
					else
						errMsg += (i+1);
				}
				*/
				if (alertFlag)
				{
					/*
					if (document.getElementById(tblIPAddrId+"Msg"))
						document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";
					
					if (errDisplayField)
						//errDisplayField.innerHTML += "*"+errMsg+"<br>";
					else
						//alert (errMsg);
					*/
				}
			}
		}
		obj.focus ();
		alert(genErrStr);
		return false;
		}
		if (optFlag)
		{
			if (i > 0 && !ipOctetSpecified)
			{
				if (errMsg)
					{
						if (octetShowFlag) errMsg += (i+1);
							//alert (errMsg);
							if (alertFlag)
							{
								/*
								if (document.getElementById(tblIPAddrId+"Msg"))
									document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";

								if (errDisplayField)
									errDisplayField.innerHTML += "*"+errMsg+"<br>";
								else
									//alert (errMsg);
								*/
							}
					}
				obj.focus ();
				alert(genErrStr);
				return false;
			}
			ipOctetSpecified = true;
		}
		if (((i+1) == 4) && (ipv4AddrTypeStr == 'IP'))
		{
			/* last octet should not set to zero as this is network ip */
			ipOctetMinVal = 1;
			ipOctetMaxVal = 254; 
		} 
		if (((i+1) == 4) && (ipv4AddrTypeStr == 'SN'))
		{
			/* last octet should not set to zero as this is network ip */
			ipOctetMinVal = 0;
			ipOctetMaxVal = 254; 
		} 
		if (((i+1) == 1) && (ipv4AddrTypeStr == 'IP' || ipv4AddrTypeStr == 'SN'))
		{
			/* first octet should not exced 223 */ 
			ipOctetMinVal = 1;
			ipOctetMaxVal = 223;
		}
		if (ipv4AddrTypeStr == 'SM' || ipv4AddrTypeStr == 'SNM')
		{
			if ((i+1) == 1)
				isError = !checkSnetMask (value, 8, 8);
			else if (((i+1) == 4) && ipv4AddrTypeStr == 'SM')
			{
				if (objArr[i-1] != "255")
					isError = !checkSnetMask (value, 0, 0);
				else
					isError = !checkSnetMask (value, 0, 6);
			}
			else
			{
				if (objArr[i-1] != "255")
					isError = !checkSnetMask (value, 0, 0);
				else
					isError = !checkSnetMask (value, 0, 8);
			}
		}
		else
		{
			if (((parseInt (value) > 0) && isFirstByteZero) ||
				(parseInt (value) < ipOctetMinVal || parseInt (value) > ipOctetMaxVal))
			{
				isError = true;
			}
		}
		if (isError)
		{
			if (isFirstByteZero) --i;
			if (alertFlag)
			{
				/*
				if (prefixStr) errMsg = prefixStr;
				if ((ipv4AddrTypeStr == 'SM' || ipv4AddrTypeStr == 'SNM') && ((i+1) == 1))
					errMsg += " Please enter 255 ";
				else if ((ipv4AddrTypeStr == 'SM') && ((i+1) == 4))
				{
					if (objArr[i-1] != "255")
						errMsg += " " + i18n_enter0 + " ";
				else
					errMsg += " "+i18n_enter0252;
				}
				else if ((ipv4AddrTypeStr == 'SM' || ipv4AddrTypeStr == 'SNM') && ((i+1) > 1))
				{
					if (objArr[i-1] != "255")
						errMsg += " " + i18n_enter0 + " ";
					else
						errMsg += " " + i18n_enter0255 + " ";
				}
				else
				{
					errMsg += " " + i18n_valueBetween + " " + ipOctetMinVal +" - " + ipOctetMaxVal + " ";
				}
				*/
				if (suffixStr) errMsg += suffixStr;
				/*
				if (octetShowFlag) errMsg += (i+1);
				if (document.getElementById(tblIPAddrId+"Msg"))
					document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";
					* 
				if (errDisplayField)
					errDisplayField.innerHTML += "*"+errMsg+"<br>";
				else				
					alert (errMsg);
				*/
			}
			obj.focus ();
			alert(genErrStr);
			return false;
		}
	}
	/*
	if (document.getElementById(tblIPAddrId+"Msg"))
		document.getElementById(tblIPAddrId+"Msg").innerHTML = "";
	*/
	return true;
}

function ipv4Validate 
(tblIPAddrId, ipv4AddrTypeStr, optFlag, alertFlag, prefixStr, suffixStr, octetShowFlag)
{
	//var i18n_invalidSubnet = "";
	//var i18n_invalidSubnetObj = document.getElementById('i18n_invalidSubnet');
	//if(i18n_invalidSubnetObj) i18n_invalidSubnet = i18n_invalidSubnetObj.value;

	//var i18n_invalidIP = "";
	//var i18n_invalidIPObj = document.getElementById('i18n_invalidIP');
	//if(i18n_invalidIPObj) i18n_invalidIP = i18n_invalidIPObj.value;

	//var errDisplayField = document.getElementById ("genericErr")
	//if (errDisplayField) errDisplayField.innerHTML = "";
	var errStr = ""
	var genErrStr = ""
	if (prefixStr) errStr += " "
	if (ipv4AddrTypeStr == "SM"){
		//genErrStr = i18n_invalidSubnet;
		genErrStr="Invalid Subnet Mask Format";
	}
	else {
		//genErrStr = i18n_invalidIP;
		genErrStr="Invalid IP Address Format";
	}
	if (!tblIPAddrId) return false;
	var obj = document.getElementById(tblIPAddrId);
	if (!obj || obj.disabled) return true;
	if (obj.value == "" && !optFlag)
	{
		if (alertFlag)
		{
			if (document.getElementById(tblIPAddrId+"Msg"));
				//document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";
				//if (errDisplayField)
				//errDisplayField.innerHTML += "*"+genErrStr+"<br>";
			else
			{
				//alert (errStr + genErrStr);
				alert(genErrStr);
			}
		}
		obj.focus ();
		return false; 
	}
	else if (obj.value == "" && optFlag)
	{
		if (document.getElementById(tblIPAddrId+"Msg"));	
			//document.getElementById(tblIPAddrId+"Msg").innerHTML = "";
		return true;
	}
	if (obj.value.length > 15)
	{
		if (alertFlag)
		{
			if (document.getElementById(tblIPAddrId+"Msg"));
				//document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";
				//if (errDisplayField)
				//errDisplayField.innerHTML += "*"+genErrStr+"<br>";
			else
			{
				//alert (errStr + genErrStr);
				alert(genErrStr);
			}
		}
		obj.focus ();
		return false;
	}
	var objArr = obj.value.split (".");
	if (!objArr.length || objArr.length != 4)
	{	 
		if (alertFlag)
		{
			if (document.getElementById(tblIPAddrId+"Msg"));
				//document.getElementById(tblIPAddrId+"Msg").innerHTML = "*";
				//if (errDisplayField)
				//errDisplayField.innerHTML += "*"+genErrStr+"<br>";
			else
			{
				//alert (errStr + genErrStr);
				alert(genErrStr);
			}
		}
		obj.focus (); 
		return false;
	}
	return ipv4AddrValuesCheck (obj, objArr, ipv4AddrTypeStr, optFlag, alertFlag, prefixStr, suffixStr, octetShowFlag, tblIPAddrId);
}

function ipv4AddrValidate (Obj, ipv4AddrTypeStr, optFlag, alertFlag, prefixStr, suffixStr, octetShowFlag)
{
if (!Obj) return;
return ipv4Validate (Obj.id, ipv4AddrTypeStr, optFlag, alertFlag, prefixStr, suffixStr, octetShowFlag)
} 


/* Converts IP string to an int */
function getIPInt(tblName) {
    var obj = document.getElementById(tblName);
    var objArr = obj.getElementsByTagName("INPUT");
    if (!objArr.length) return false;
    octet0 =  objArr[0].value;
    octet1 =  objArr[1].value;
    octet2 =  objArr[2].value;
    octet3 =  objArr[3].value  ;

    var result = ((octet0 & 0xff) << 24) |
                 ((octet1 & 0xff) << 16) |
                 ((octet2 & 0xff) <<  8) |
                  (octet3 & 0xff);
    return result;
}

function getIPInt1(srcObjId) {
    if (!srcObjId) return false;
    var obj = document.getElementById(srcObjId);
    if (!obj) return false;
    var ipaddr = obj.value;
    var objArr = ipaddr.split (".");
    if (!objArr.length) return false;
    octet0 =  objArr[0];
    octet1 =  objArr[1];
    octet2 =  objArr[2];
    octet3 =  objArr[3];

    var result = ((octet0 & 0xff) << 24) |
                 ((octet1 & 0xff) << 16) |
                 ((octet2 & 0xff) <<  8) |
                  (octet3 & 0xff);
                  
    return result;
}

/*
 * Compares two IPs and returns
 *  +ve number if Ip1 > IP2,
 *  0 if they are equal
 *  -ve number if IP1 < IP2.
 */

function compareIP(ip1Int, ip2Int) {
    if (ip1Int > ip2Int) return 1;
    if (ip1Int < ip2Int) return -1;
    return 0;
}

function compareIPRange(ip1Int, ip2Int) {
    if ((ip2Int - ip1Int) <= 254) return 1;
    return 0;
}

function compareIPRangeById(ip1Id, ip2Id){
	var obj_1 = document.getElementById(ip1Id);
	var obj_2 = document.getElementById(ip2Id);	
	
	var objArr_1 = (obj_1.value).split (".");
	var objArr_2 = (obj_2.value).split (".");
	
	if(objArr_1[0] !=192 || objArr_1[1] !=168 ||objArr_1[2] !=0 )
	{
		alert(gettext("DHCP Range must during 192.168.0.2 to 192.168.0.254"));
		return 0;
	}
	
	if((objArr_1[0] !=objArr_2[0])|| (objArr_1[1] !=objArr_2[1]) || (objArr_1[2] !=objArr_2[2]))
	{
		alert(gettext("Invalid Starting and Stopping IP Address"));
		return 0;
	}
	else
		return 1;
	
}


/* Check an IP (host) falls in a subnet */
function isInSubnet(host, pattern, mask) {
    return (((host & mask) == (pattern & mask)) && !isBroadcastIP(host, pattern, mask)); }

/* Check if an IP (host) is a broadcast IP */
function isBroadcastIP(host, pattern, mask) {
	return ((pattern | ~mask) == host)
}

function ipAddrValueFormatCheck (ipAddr)
	{	
		
    if (!ipAddr) return false;
    var ipObjArr = ipAddr.split (".")
    if (ipObjArr.length != 4) return false;
	/* Check IP Address Octet Range */
	if (ipAddrOctetCheck (ipObjArr) == false)
		return false;
	return true;
	}
	
/* Check Domain Name*/
function domainValidate(nameId)
{	
	if (!nameId) return false;	
	var obj = document.getElementById(nameId);
	if (!obj) return false;
	var domain = obj.value;
	var objArr = domain.split (".");
	if(!objArr.length)	return false; 
		
	if(objArr.length==3  && objArr[2]=="com")
		return true;
	
	alert(gettext("Invalid Domain Format"));
	return false;
					
	}	

