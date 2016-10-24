/* textValidations.js - API library for text field validation */

/*
* Copyright (c) 2010 TeamF1, Inc.
* All rights reserved.
*/

/*
modification history
---------------------
*/

/********************************************************************
* isFieldEmpty - checks for empty fields
*
* This routine checks for empty fields
* return true, if field value is empty else returns false
*
* RETURNS: TRUE or FALSE
*/

function isFieldEmpty (fieldId, alertFlag, errMsg)
	{
	var obj = document.getElementById(fieldId);
	if (!obj || obj.disabled) return false;
	if (!obj.value.length)
		{
		if (alertFlag)
			alert (errMsg);
			obj.focus ();
			return true;
		}
	return false;
	}

/***********************************************************************
* txtFieldArrayCheck - checks for empty fields in given array of fields
*
* This routine checks for empty fields
* return false, if field value is empty else returns true
*
* RETURNS: TRUE or FALSE
*/

function txtFieldArrayCheck (txtFieldIdArr)
	{
	for (var i = 0; i < txtFieldIdArr.length; ++i)
		{
		var result = false;
		var strArr = txtFieldIdArr[i].split(",");
		if (strArr[0] == "txtLoginPwd") return true;
		if (strArr[0] == "txtLoginCpwd") return true;
		result = isFieldEmpty (strArr[0]);
		if (result)
			{
			if (strArr.length > 1)
				alert (strArr[1]);
			return false;
			}
		}
	return true;
	}

/***********************************************************************
* isProblemCharArrayCheck - checks for invalid characters in given array
* of fields
*
* This routine checks for invalid characters in the given text fields
* return false, if field value contains invalid characters
* else returns true
*
* RETURNS: TRUE or FALSE
*/

function isProblemCharArrayCheck (txtFieldIdArr)
	{
	for (var i = 0; i < txtFieldIdArr.length; ++i)
		{
		var result = false;
		var strArr = txtFieldIdArr[i].split(",");
		var obj = document.getElementById(strArr[0]);
		if (!obj || obj.disabled)
			continue;
		else
			{
			var errDisplayField = document.getElementById ("genericErr");
			if (errDisplayField) errDisplayField.innerHTML = "";
			if (strArr.length > 1)
				{
				var i18n_charsNotSupported = "";
				var i18n_charsNotSupportedObj = document.getElementById('i18n_charsNotSupported');
				if(i18n_charsNotSupportedObj) i18n_charsNotSupported = i18n_charsNotSupportedObj.value;

				if (obj.value.indexOf ("'") != -1 || obj.value.indexOf ("\"") != -1 || obj.value.indexOf (" ") != -1)
					{
					if (document.getElementById(strArr[0] + "Msg"))
						document.getElementById(strArr[0] + "Msg").innerHTML = "*"
					if (errDisplayField)
						errDisplayField.innerHTML = "*"+i18n_charsNotSupported+"<br>"
					else
						alert (i18n_charsNotSupported);
						obj.focus ();
						return false;
					}
				}
			}
		}
	return true;
	}

/***********************************************************************
* fieldLengthCheck - checks field value length
*
* This routine checks text field value and
* return false, if field value length exceeds max length or
* less than min length else returns true
*
* RETURNS: TRUE or FALSE
*/

function fieldLengthCheck
	(
	fieldId,
	minLen,
	maxLen,
	errMsg
	)
	{
	if (!fieldId) return false;
	var fldObj = document.getElementById(fieldId);
	if (!fldObj) return false;
	if (fldObj.disabled) return true;
	var strVal = fldObj.value;
	if (minLen && (strVal.length < minLen))
		{
		if (errMsg)
			alert (errMsg);
		fldObj.focus ();
		return false;
		}
	if (maxLen && (strVal.length > maxLen))
		{
		if (errMsg)
			alert (errMsg);
		fldObj.focus ();
		return false;
		}
	return true;
	}

/***********************************************************************
* fieldValueCompare - checks field value length and compare two values
*
* This routine checks text field value length and compare two values
* return false,
* if field value length exceeds max length (or)
* less than min length (or)
* two field values are different.
* else returns true
*
* RETURNS: TRUE or FALSE
*/

function fieldValueCompare
	(
	fieldId1,
	fieldId2,
	minLen,
	maxLen,
	errMsg
	)
	{
	if (!fieldId1 || !fieldId2) return false;
	var val1 = document.getElementById(fieldId1).value;
	if (minLen && maxLen)
		{
		if (val1.length < minLen || val1.length > maxLen)
			return false;
		}
	var val2 = document.getElementById(fieldId2).value;
	if (minLen && maxLen)
		{
		if (val2.length < minLen || val2.length > maxLen)
			return false;
		}
	if (val1 != val2)
		{
		if (errMsg)
			alert (errMsg);
		return false;
		}
	return true;
	}

/***********************************************************************
* numericValueCheck - checks for numeric values
*
* This routine checks input value and
* return true,
* if input character is a numeric value (or)
* in the exception characters list.
* else returns false
*
* RETURNS: TRUE or FALSE
*/

function numericValueCheck
	(
	eventObj,
	exceptionCharStr
	)
	{
	var charUniCode = eventObj.charCode ? eventObj.charCode : eventObj.keyCode;
	/* check for any exceptional characters */
	if (exceptionCharStr)
		{
		for (i=0; i < exceptionCharStr.length; ++i)
			if (exceptionCharStr.charCodeAt (i) == charUniCode)
				return true;
		}
	switch (charUniCode)
		{
		case 8: /* back space */
		case 9: /* tab */
		case 16: /* shift */
		/* case 37: */ /* left arrow */
		/* case 39: */ /* right arrow */
		/* case 46: */ /* delete - not supporting as in netscape it's char code is same as '.'*/
			return true;
		default:
			break;
		}
	/* allow back space */
	if (charUniCode < 48 || charUniCode > 57)
		return false;
	return true;
	}

/***********************************************************************
* numericValueRangeCheck - checks for numeric value range
*
* This routine checks numeric value range
* return true,
* if input value range in the given max and min value
* else returns false
*
* RETURNS: TRUE or FALSE
*/

function numericValueRangeCheck
	(
	srcObj,
	minLen,
	minLenErrStr,
	minVal,
	maxVal,
	errFlag,
	prefixErrStr,
	suffixErrStr
	)
	{
	var i18n_enterValBtw = "Please enter a value between ";

	if (!srcObj || srcObj.disabled) return true;
	var value = srcObj.value;
	if (isNaN (value))
		{
		if (errFlag)
			{
			var errStr = '';
			if (prefixErrStr) errStr += prefixErrStr;
			errStr += i18n_enterValBtw +
			minVal + " - " + maxVal + " ";
			if (suffixErrStr) errStr += suffixErrStr;
				alert (errStr);
			}
		srcObj.focus ();
		return false;
		}
	/* check for minimum length if specified */
	if (minLen && (value.length < minLen))
		{
		if (minLenErrStr) alert (minLenErrStr);
			srcObj.focus ();
		return false;
		}
	if ((minVal && (value < minVal)) || (maxVal && (value > maxVal)))
		{
		if (errFlag)
			{
			var errStr = '';
			if (prefixErrStr) errStr += prefixErrStr;
			errStr += i18n_enterValBtw +
			minVal + " - " + maxVal + " ";
			if (suffixErrStr) errStr += suffixErrStr;
				alert (errStr);
			}
		srcObj.focus ();
		return false;
		}
	return true;
	}


function macAddrCheck
	(
	eventObj,
	srcObj
	)
	{
	if (!eventObj || !srcObj) return false;
	var charUniCode = eventObj.charCode ? eventObj.charCode : eventObj.keyCode;
	var macAddr = srcObj.value;
	var maxBytes = (macAddr.split (":")).length;
	if (maxBytes > 6)
		return false;
	macAddr = macAddr.lastIndexOf (":") == -1 ? macAddr : macAddr.substring (macAddr.lastIndexOf (":")+1);
	if (macAddr.indexOf ("0x") == 0 || macAddr.indexOf ("0X") == 0)
		checkLen = 4;
	else
		checkLen = 2;
	switch (charUniCode)
		{
		case 58: /* : */
			if (macAddr.length == 0 || macAddr.length < (checkLen - 1))
				return false;
			if (maxBytes != 6)
				return true;
			return false;
		case 88: /* x */
		case 120: /* X */
			if (macAddr.length > 1 || macAddr.indexOf ("0") != 0)
				return false;
			return true;
		case 9: /* tab key */
			if (maxBytes != 6)
				return false;
		case 8: /* back space */
		case 37: /* left arrow */
		case 39: /* right arrow */
		case 46: /* delete */
			return true;
		}
	if (macAddr.length == checkLen && charUniCode != 58)
		{
		if (maxBytes != 6)
			srcObj.value = srcObj.value + ":";
		return false;
		}
	/* allow a - f */
	if (charUniCode >= 97 && charUniCode <= 102)
		return true;
	/* allow A - F */
	if (charUniCode >= 65 && charUniCode <= 70)
		return true;
	if (charUniCode < 48 || charUniCode > 57)
		return false;
	return true;
	}

function macFormatCheck
	(
	macAddr,
	errMsg
	)
	{
	if (!macAddr) return false;
	var macBytes = macAddr.split (":");
	if (macBytes.length != 6 || (macBytes[5].length == 0))
		{
		if (errMsg) alert (errMsg);
			return false;
		}
	return true;
	}

function macAddrVerify
	(
	eventObj,
	srcObj
	)
	{
	var i18n_invalidMacAddr = "";
	var i18n_invalidMacAddrObj = document.getElementById('i18n_invalidMacAddr');
	if(i18n_invalidMacAddrObj) i18n_invalidMacAddr = i18n_invalidMacAddrObj.value;

	if (!eventObj || !srcObj)
		return false;
	var charUniCode = eventObj.charCode ? eventObj.charCode : eventObj.keyCode;
	/* process only 'tab' */
	if (eventObj.keyCode != 9)
		return true;
	if (!(macFormatCheck (srcObj.value, i18n_invalidMacAddr)))
		{
		srcObj.focus ();
		return false;
		}
	return true;
	}

function isProblemChar
	(
	eventObj,
	problemCharStr,
	errMsg
	)
	{
	var charUniCode = eventObj.charCode ? eventObj.charCode : eventObj.keyCode;
	/* check for any problematic characters */
	if (problemCharStr)
		{
		for (i=0; i < problemCharStr.length; ++i)
			if (problemCharStr.charCodeAt (i) == charUniCode)
				{
				if (errMsg)
					{
					var i18n_enterValidChars = "";
					var i18n_enterValidCharsObj = document.getElementById('i18n_enterValidChars');
					if(i18n_enterValidCharsObj) i18n_enterValidChars = i18n_enterValidCharsObj.value;

					var i18n_charNotSupported = "";
					var i18n_charNotSupportedObj = document.getElementById('i18n_charNotSupported');
					if(i18n_charNotSupportedObj) i18n_charNotSupported = i18n_charNotSupportedObj.value;

					var i18n_charsNotSupported = "";
					var i18n_charsNotSupportedObj = document.getElementById('i18n_charsNotSupported');
					if(i18n_charsNotSupportedObj) i18n_charsNotSupported = i18n_charsNotSupportedObj.value;

					if (problemCharStr.length == 1)
						alert (i18n_enterValidChars + errMsg + "\n" + i18n_charNotSupported + String.fromCharCode(charUniCode));
					else
						alert (i18n_enterValidChars + errMsg + "\n" + i18n_charsNotSupported + problemCharStr);
					}
				return true;
				}
			}
	return false;
	}

function alphaCharCheck
	(
	eventObj,
	exceptionCharStr
	)
	{
	var isIE = (navigator.appName.indexOf ('Microsoft') != -1);
	var isNS = (navigator.appName.indexOf ('Netscape') != -1);
	var isOpera = (navigator.appName.indexOf ('Opera') != -1);
	var charUniCode = eventObj.charCode ? eventObj.charCode : eventObj.keyCode;
	//alert(charUniCode)
	/* check for any exceptional characters */
	/* check for any exceptional characters */
	if (exceptionCharStr)
		{
		for (i=0; i < exceptionCharStr.length; ++i)
			//alert(exceptionCharStr.charCodeAt (i));
			if (exceptionCharStr.charCodeAt (i) == charUniCode)
				return true;
		}
	switch (charUniCode)
		{
		case 8: /* back space */
		case 9: /* tab */
		case 16: /* shift */
			return true;
		case 35: /* End */
		case 36: /* Home */
		case 37: /* left arrow */
		case 39: /* right arrow */
			if ((isNS && eventObj.which == 0) || (isOpera && eventObj.which == 0)) return true;
				return false;
		case 46: /* delete */ /* Not able to support for Opera browser; '.' and delete keys return same value */
		//case 45: /* delete */ /* Not able to support for Opera browser; '-' and delete keys return same value */
		case 35: /* End */ /* Not able to support for Opera browser; '%' and End keys return same value */
		case 36: /* Home */ /* Not able to support for Opera browser; '$' and Home keys return same value */
			if (isNS && eventObj.which == 0) return true;
				return false;
		default:
			break;
		}
	/* allow a - z */
	if (charUniCode >= 97 && charUniCode <= 122)
		return true;
	/* allow A - Z */
	if (charUniCode >= 65 && charUniCode <= 90)
		return true;
	/* Not allow hiphen */
	if (charUniCode == 45)
		return false;
	/* allow back space */
	if (charUniCode >= 48 && charUniCode <= 57)
		return false;
	return true;
	}

function alphaNumericCheck
	(
	eventObj,
	exceptionCharStr
	)
	{
	var isIE = (navigator.appName.indexOf ('Microsoft') != -1);
	var isNS = (navigator.appName.indexOf ('Netscape') != -1);
	var isOpera = (navigator.appName.indexOf ('Opera') != -1);
	var charUniCode = eventObj.charCode ? eventObj.charCode : eventObj.keyCode;
	//alert(charUniCode)
	/* check for any exceptional characters */
	/* check for any exceptional characters */
	if (exceptionCharStr)
		{
		for (i=0; i < exceptionCharStr.length; ++i)
			//alert(exceptionCharStr.charCodeAt (i));
			if (exceptionCharStr.charCodeAt (i) == charUniCode)
				return true;
		}
	switch (charUniCode)
		{
		case 8: /* back space */
		case 9: /* tab */
		case 16: /* shift */
			return true;
		case 35: /* End */
		case 36: /* Home */
		case 37: /* left arrow */
		case 39: /* right arrow */
			if ((isNS && eventObj.which == 0) || (isOpera && eventObj.which == 0)) return true;
				return false;
		case 46: /* delete */ /* Not able to support for Opera browser; '.' and delete keys return same value */
		case 45: /* delete */ /* Not able to support for Opera browser; '-' and delete keys return same value */
		case 35: /* End */ /* Not able to support for Opera browser; '%' and End keys return same value */
		case 36: /* Home */ /* Not able to support for Opera browser; '$' and Home keys return same value */
			if (isNS && eventObj.which == 0) return true;
				return false;
		default:
			break;
		}
	/* allow A - F */
	if (charUniCode >= 97 && charUniCode <= 122)
		return true;
	/* allow A - F */
	if (charUniCode >= 65 && charUniCode <= 90)
		return true;
	/* Not allow hiphen */
	if (charUniCode == 45)
		return false;
	if (charUniCode == 46)
		return false;
	/* allow back space */
	if (charUniCode < 48 || charUniCode > 57)
		return false;
	return true;
	}

function SSIDCheck
	(
	eventObj,
	exceptionCharStr
	)
	{
	var isIE = (navigator.appName.indexOf ('Microsoft') != -1);
	var isNS = (navigator.appName.indexOf ('Netscape') != -1);
	var isOpera = (navigator.appName.indexOf ('Opera') != -1);
	var charUniCode = eventObj.charCode ? eventObj.charCode : eventObj.keyCode;
	//alert(charUniCode)
	/* check for any exceptional characters */
	/* check for any exceptional characters */
	if (exceptionCharStr)
		{
		for (i=0; i < exceptionCharStr.length; ++i)
			//alert(exceptionCharStr.charCodeAt (i));
			if (exceptionCharStr.charCodeAt (i) == charUniCode)
				return true;
		}
	switch (charUniCode)
		{
		case 8: /* back space */
		case 9: /* tab */
		case 16: /* shift */
			return true;
		case 35: /* End */
		case 36: /* Home */
		case 37: /* left arrow */
		case 39: /* right arrow */
			if ((isNS && eventObj.which == 0) || (isOpera && eventObj.which == 0)) return true;
				return false;
		case 46: /* delete */ /* Not able to support for Opera browser; '.' and delete keys return same value */
		//case 45: /* delete */ /* Not able to support for Opera browser; '-' and delete keys return same value */
		case 35: /* End */ /* Not able to support for Opera browser; '%' and End keys return same value */
		case 36: /* Home */ /* Not able to support for Opera browser; '$' and Home keys return same value */
			if (isNS && eventObj.which == 0) return true;
				return false;
		case 45:
		case 95:
			return true;
		default:
			break;
		}
	/* allow A - F */
	if (charUniCode >= 97 && charUniCode <= 122)
		return true;
	/* allow A - F */
	if (charUniCode >= 65 && charUniCode <= 90)
		return true;
	/* Not allow hiphen */
	if (charUniCode == 45)
		return false;
	/* allow back space */
	if (charUniCode < 48 || charUniCode > 57)
		return false;
	return true;
	}

function validateFQDN (fieldId)
	{
	var fqdnObj = document.getElementById (fieldId);
	if (!fqdnObj || fqdnObj.disabled) return true;
	if (fqdnObj.value.indexOf ('@') != -1 || fqdnObj.value.indexOf ('\"') != -1)
		{
		var i18n_atNotAllowed = "";
		var i18n_atNotAllowedObj = document.getElementById('i18n_atNotAllowed');
		if(i18n_atNotAllowedObj) i18n_atNotAllowed = i18n_atNotAllowedObj.value;

		var i18n_dblQAtNotAllowed = "";
		var i18n_dblQAtNotAllowedObj = document.getElementById('i18n_dblQAtNotAllowed');
		if(i18n_dblQAtNotAllowedObj) i18n_dblQAtNotAllowed = i18n_dblQAtNotAllowedObj.value;

		var i18n_dblQNotAllowed = "";
		var i18n_dblQNotAllowedObj = document.getElementById('i18n_dblQNotAllowed');
		if(i18n_dblQNotAllowedObj) i18n_dblQNotAllowed = i18n_dblQNotAllowedObj.value;


		var errorStr = i18n_atNotAllowed;
		if (fqdnObj.value.indexOf ('@') != -1 && fqdnObj.value.indexOf ('\"') != -1)
			errorStr = i18n_dblQAtNotAllowed;
		else if (fqdnObj.value.indexOf ('\"') != -1)
			errorStr = i18n_dblQNotAllowed;

		if (document.getElementById(fieldId + "Err"))
			document.getElementById(fieldId + "Err").innerHTML = errorStr;
		else
			alert (errorStr);
		return false;
		}
	if (document.getElementById(fieldId + "Err"))
		document.getElementById(fieldId + "Err").innerHTML = "";
	return true;
	}

function checkUserName(fieldId, maxLength, errorFlag, prefixMsg, emptyFlag)
	{
	var fieldObj = document.getElementById(fieldId)
	if(!fieldObj || fieldObj.disabled) return true;
	var userName = fieldObj.value;

	/* Check if user name Empty */
	if (userName == "" && emptyFlag) return true;
	else if (userName == "")
		{
		var i18n_enterValidName = "";
		var i18n_enterValidNameObj = document.getElementById('i18n_enterValidName');
		if(i18n_enterValidNameObj) i18n_enterValidName = i18n_enterValidNameObj.value;

		var errMsg = i18n_enterValidName;
		if (prefixMsg) errMsg = prefixMsg + errMsg;
		alert (errMsg);
		fieldObj.focus();
		return false;
		}

	/* Check for max length */
	if (maxLength && userName.length > maxLength)
		{
		var i18n_enterValidName = "";
		var i18n_enterValidNameObj = document.getElementById('i18n_enterValidName');
		if(i18n_enterValidNameObj) i18n_enterValidName = i18n_enterValidNameObj.value;


		var errMsg = i18n_userMaxLen + maxLength;
		if (prefixMsg) errMsg = prefixMsg + errMsg;
		alert (errMsg);
		fieldObj.focus();
		return false;
		}

	/* Check User name rules */
	for (var idx = 0; idx < userName.length; idx++)
		{
		var exceptionChars = "_-"
		var charCode = userName.charCodeAt(idx)
		if (!(charCode >= 97 && charCode <= 122 ||
			  charCode >= 48 && charCode <= 57 || charCode >= 65 && charCode <= 90 ||
		      charCode == exceptionChars.charCodeAt(0) ||
		      charCode == exceptionChars.charCodeAt(1)))
			{
			var i18n_nameAlphaNumeric = "";
			var i18n_nameAlphaNumericObj = document.getElementById('i18n_nameAlphaNumeric');
			if(i18n_nameAlphaNumericObj) i18n_nameAlphaNumeric = i18n_nameAlphaNumericObj.value;

			var errMsg = i18n_nameAlphaNumeric;
			if (prefixMsg) errMsg = prefixMsg + errMsg;
			alert (errMsg);
			fieldObj.focus();
			return false;
			}
		}

	var beginChar = userName.charCodeAt(0);
	var endChar = userName.charCodeAt(userName.length - 1);
	//alert(beginChar);
	if (beginChar == exceptionChars.charCodeAt(0) || beginChar == exceptionChars.charCodeAt(1))
		{
		var i18n_nameBeginWith = "";
		var i18n_nameBeginWithObj = document.getElementById('i18n_nameBeginWith');
		if(i18n_nameBeginWithObj) i18n_nameBeginWith = i18n_nameBeginWithObj.value;

		var errMsg = i18n_nameBeginWith;
		if (prefixMsg) errMsg = prefixMsg + errMsg;
		alert (errMsg);
		fieldObj.focus();
		return false;
		}
	if (endChar == exceptionChars.charCodeAt(0) || endChar == exceptionChars.charCodeAt(1))
		{
		var i18n_nameNotEndWith = "";
		var i18n_nameNotEndWithObj = document.getElementById('i18n_nameNotEndWith');
		if(i18n_nameNotEndWithObj) i18n_nameNotEndWith = i18n_nameNotEndWithObj.value;


		var errMsg = i18n_nameNotEndWith;
		if (prefixMsg) errMsg = prefixMsg + errMsg;
		alert (errMsg);
		fieldObj.focus();
		return false;
		}

	return true;
	}
/********************************************************************
* alphaNumericValueCheck - Used to allow only alpha numeric values in the field having specified Id
* 'fieldId' and allows exception characters
*
* RETURNS: true or false
*/

function alphaNumericValueCheck (fieldId, exceptionCharStr, prefixErrMsg)
	{
	var txtFieldObj = document.getElementById (fieldId);
	var errorDisplayObj = document.getElementById (fieldId + "Err");

	if (!txtFieldObj || txtFieldObj.disabled) return false;

	for (var idx = 0; idx < txtFieldObj.value.length; idx++)
		{
		var charUniCode = txtFieldObj.value.charCodeAt (idx);

	    /* check for any exceptional characters */
		if (exceptionCharStr)
	        {
	        var matchFound = false;
	        for (i=0; i < exceptionCharStr.length; ++i)
	        	if (exceptionCharStr.charCodeAt (i) == charUniCode) { matchFound = true; break; }

		    if (matchFound) continue;
	        }

	    switch (charUniCode)
	        {
	        case 8:  /* back space */
	        case 9:  /* tab */
	        case 16: /* shift */
	        /* case 37: */ /* left arrow */
	        /* case 39: */ /* right arrow */
	        /* case 46: */ /* delete - not supporting as in netscape it's char code is same as '.'*/
	             return true;
	        default:
	             break;
	        }
	    
	    /* allow A - F */
	    if (charUniCode >= 97 && charUniCode <= 122) continue;
	         
	    /* allow A - F */
	    if (charUniCode >= 65 && charUniCode <= 90) continue;

		/* allow 0 to 9 */
	    if (charUniCode >= 48 && charUniCode <= 57) continue;

	    var errorMsg = "";
	    if (prefixErrMsg && prefixErrMsg != "") errorMsg += prefixErrMsg;

	    var i18n_azAZ09Only = "";
		var i18n_azAZ09OnlyObj = document.getElementById('i18n_azAZ09Only');
		if(i18n_azAZ09OnlyObj) i18n_azAZ09Only = i18n_azAZ09OnlyObj.value;

		var i18n_charsAllowed = "";
		var i18n_charsAllowedObj = document.getElementById('i18n_charsAllowed');
		if(i18n_charsAllowedObj) i18n_charsAllowed = i18n_charsAllowedObj.value;


		var i18n_azAZ09Chars = "";
		var i18n_azAZ09CharsObj = document.getElementById('i18n_azAZ09Chars');
		if(i18n_azAZ09CharsObj) i18n_azAZ09Chars = i18n_azAZ09CharsObj.value;

	    if(exceptionCharStr != '')
	        errorMsg += i18n_azAZ09Only + exceptionCharStr +i18n_charsAllowed;
	    else
	        errorMsg += i18n_azAZ09Chars;

		if (errorDisplayObj) errorDisplayObj.innerHTML = errorMsg;
		else alert (errorMsg);
		txtFieldObj.focus();
		return false;
        }

    if (errorDisplayObj) errorDisplayObj.innerHTML = "";
    return true;
	}

/********************************************************************
* alphaNumericValueCheck - Used to allow only alpha numeric values in the field having specified Id
* 'fieldId' and allows exception characters
*
* RETURNS: true or false
*/

function alphaNumericValueCheckNew (fieldId)
	{
	var txtFieldObj = document.getElementById (fieldId);

	var errorMsg = "";

	var i18n_azAZ09Only = "";
	var i18n_azAZ09OnlyObj = document.getElementById('i18n_azAZ09Chars');
	if(i18n_azAZ09OnlyObj) i18n_azAZ09Only = i18n_azAZ09OnlyObj.value;


    errorMsg = i18n_azAZ09Only;

	//if (!txtFieldObj || txtFieldObj.disabled) return false;

	var isInvalid = false;
	for (var idx = 0; idx < txtFieldObj.value.length; idx++)
		{
		var charUniCode = txtFieldObj.value.charCodeAt (idx);
	    if (!((charUniCode >= 97 && charUniCode <= 122) ||
 		      (charUniCode >= 65 && charUniCode <= 90) ||
 		      (charUniCode >= 48 && charUniCode <= 57) ))
 		      {
				isInvalid = true;
				break;
 		      }
        }
	if (isInvalid)
	{
		alert (errorMsg);
		txtFieldObj.focus();
		return false;
	}
	else
		return true;
	}

/***********************************************************************
* checkHostName - checks for a valid host name
*
* This routine checks for valid host name and
* return true,
* if value is a valid host name
* else returns false
*
* RETURNS: TRUE or FALSE
*/
function checkHostName (fieldId, errorFlag, customMsg, emptyFlag)
{
	var errDisplayField = document.getElementById (fieldId + "Err");
 	if (errDisplayField) errDisplayField.innerHTML = "";
	var fieldHighliter = document.getElementById(fieldId + "Msg")
	if (fieldHighliter) fieldHighliter.innerHTML = "";
	var fieldObj = document.getElementById(fieldId)
	if(!fieldObj || fieldObj.disabled) return true;
	var hostName = fieldObj.value;
        /* Check if host name Empty */
    if (hostName == "" && emptyFlag) return true;
	else if (hostName == "")
	{
        var i18n_enterValidDomain = "";
		var i18n_enterValidDomainObj = document.getElementById('i18n_enterValidDomain');
		if(i18n_enterValidDomainObj) i18n_enterValidDomain = i18n_enterValidDomainObj.value;

        var errMsg = i18n_enterValidDomain;
        if (customMsg != "")
            errMsg = customMsg + errMsg;
        if (fieldHighliter) fieldHighliter.innerHTML = "*";

        if (errDisplayField)
            errDisplayField.innerHTML = errMsg;
        else
            alert (errMsg);
        fieldObj.focus();
        return false;
    }

 	/* Check host name rules */
   	var isInvalid = false
    for (var idx = 0; idx < hostName.length; idx++)
    {
		var exceptionChars = "-."
		var charCode = hostName.charCodeAt(idx)
		if (!((charCode >= 97 && charCode <= 122) ||
		  (charCode >= 65 && charCode <= 90) ||
		  (charCode >= 48 && charCode <= 57) ||
		   charCode == exceptionChars.charCodeAt(0) ||
		   charCode == exceptionChars.charCodeAt(1)
		 ))
		 {
			 isInvalid = true;
			 break;
		 }
    }

    if (isInvalid)
    {
        var i18n_alphanumOnlyDomain = "";
		var i18n_alphanumOnlyDomainObj = document.getElementById('i18n_alphanumOnlyDomain');
		if(i18n_alphanumOnlyDomainObj) i18n_alphanumOnlyDomain = i18n_alphanumOnlyDomainObj.value;

            var errMsg = i18n_alphanumOnlyDomain;
        if (customMsg != "")
                errMsg = customMsg + errMsg;
        if (fieldHighliter) fieldHighliter.innerHTML = "*";
        if (errDisplayField)
            errDisplayField.innerHTML = errMsg;
        else
            alert (errMsg);
	    fieldObj.focus();
        return false;
    }

    var firstChar = hostName.charCodeAt(0)
    if (!((firstChar >= 97 && firstChar <= 122) || (firstChar >= 65 && firstChar <= 90) || (firstChar >= 48 && firstChar <= 57)))
    {
        var i18n_startAlphaNumOnly = "";
		var i18n_startAlphaNumOnlyObj = document.getElementById('i18n_startAlphaNumOnly');
		if(i18n_startAlphaNumOnlyObj) i18n_startAlphaNumOnly = i18n_startAlphaNumOnlyObj.value;

        var errMsg = i18n_startAlphaNumOnly;
        if (customMsg != "")
            errMsg = customMsg + errMsg;
        if (fieldHighliter) fieldHighliter.innerHTML = "*";
        if (errDisplayField)
            errDisplayField.innerHTML = errMsg;
        else
            alert (errMsg);
        fieldObj.focus();
        return false;
    }

    var lastChar = hostName.charCodeAt(hostName.length-1)
    if (!((lastChar >= 97 && lastChar <= 122) || (lastChar >= 65 && lastChar <= 90) || (lastChar >= 48 && lastChar <= 57)))
    {
        var i18n_endAlphaNumOnly = "";
		var i18n_endAlphaNumOnlyObj = document.getElementById('i18n_endAlphaNumOnly');
		if(i18n_endAlphaNumOnlyObj) i18n_endAlphaNumOnly = i18n_endAlphaNumOnlyObj.value;

        var errMsg = i18n_endAlphaNumOnly;
        if (customMsg != "")
            errMsg = customMsg + errMsg;
        if (fieldHighliter) fieldHighliter.innerHTML = "*";
        if (errDisplayField)
            errDisplayField.innerHTML = errMsg;
        else
            alert (errMsg);
	    fieldObj.focus();
        return false;
    }
	var hostName_str = encodeURIComponent(hostName);
	var hostName_len = hostName_str.replace(/%[A-F\d]{2}/g, 'U').length;
	var hostName_replace = hostName.replace(".", "");
	if(hostName.length == hostName_replace.length)
	{
		alert(gettext('The NTP Server should include "."'));
		fieldObj.focus();
		return false;
	}
	if(hostName.substr(0, 1) == ".")
	{
		alert(gettext("The first character of NTP Server can't be \".\""));
		fieldObj.focus();
		return false;
	}
    

    return true;
}

function numericValueRangeCheck2
    (srcObj, minLen, minLenErrStr, minVal, maxVal, errFlag, prefixErrStr, suffixErrStr, errObjId)
    {
    if (!srcObj || srcObj.disabled) return true;
    var value = parseInt(srcObj.value, 10);
    var errorDisplayObj = document.getElementById(errObjId);
    /* check for minimum length if specified */
    if (minLen && (value.length < minLen))
        {
	    if (errorDisplayObj) errorDisplayObj.innerHTML = minLenErrStr
	    else alert (minLenErrStr);
	    srcObj.focus ();
        return false;
        }

    if (isNaN (value))
        {
        var errStr = '';

        var i18n_invalidNum = "";
		var i18n_invalidNumObj = document.getElementById('i18n_invalidNum');
		if(i18n_invalidNumObj) i18n_invalidNum = i18n_invalidNumObj.value;

        if (suffixErrStr) errStr += suffixErrStr;
        errStr += i18n_invalidNum;
        if (errorDisplayObj) errorDisplayObj.innerHTML = errStr;
        else alert (errStr);
        srcObj.focus ();
        return false;
        }
    if ((value < minVal) || (value > maxVal))
        {
        if (errFlag)
            {
            var errStr = '';

	        var i18n_enterValBtw1 = "";
			var i18n_enterValBtw1Obj = document.getElementById('i18n_enterValBtw1');
			if(i18n_enterValBtw1Obj) i18n_enterValBtw1 = i18n_enterValBtw1Obj.value;

            if (prefixErrStr) errStr += prefixErrStr;
            errStr += i18n_enterValBtw1 + minVal + " - " + maxVal + " ";
            if (suffixErrStr) errStr += suffixErrStr;
	        if (errorDisplayObj) errorDisplayObj.innerHTML = errStr;
	        else alert (errStr);
            }
        srcObj.focus ();
        return false;
        }
    else
    	{
        if (errorDisplayObj) errorDisplayObj.innerHTML = ""
    	}
    return true;
    }

function checkHostName1 (fieldId, errorFlag, customMsg, emptyFlag, domainFlag)
	{
	var fieldObj = document.getElementById(fieldId)
	if(!fieldObj || fieldObj.disabled) return true;
	var errDisplayField = document.getElementById(fieldId + "Err")
	var hostName = fieldObj.value;

	/* Check if host name Empty */
	if (hostName == "" && emptyFlag) return true;
	else if (hostName == "")
		{
		var i18n_enterValidHost = "";
		var i18n_enterValidHostObj = document.getElementById('i18n_enterValidHost');
		if(i18n_enterValidHostObj) i18n_enterValidHost = i18n_enterValidHostObj.value;

		var errMsg = i18n_enterValidHost;
		if (customMsg != "")
			errMsg = customMsg + errMsg;

		if (errDisplayField)
			errDisplayField.innerHTML = errMsg;
		else
			alert (errMsg);
        fieldObj.focus();
        return false;
		}

	var exceptionChars = "-"
	/* Check host name rules */
	var isInvalid = false
	for (var idx = 0; idx < hostName.length; idx++)
		{
		var charCode = hostName.charCodeAt(idx)
		if (!((charCode >= 97 && charCode <= 122) ||
		      (charCode >= 65 && charCode <= 90) ||
		      (charCode >= 48 && charCode <= 57) ||
		       charCode == exceptionChars.charCodeAt(0) ||
		       charCode == exceptionChars.charCodeAt(1)
		     ))
		     {
		     isInvalid = true;
		     break;
		     }
		}

	if (isInvalid)
		{
		var i18n_alphaNumHost = "";
		var i18n_alphaNumHostObj = document.getElementById('i18n_alphaNumHost');
		if(i18n_alphaNumHostObj) i18n_alphaNumHost = i18n_alphaNumHostObj.value;

		var errMsg =i18n_alphaNumHost;
		if (customMsg != "") errMsg = customMsg + errMsg;
		if (errDisplayField)
			errDisplayField.innerHTML = errMsg;
		else
			alert (errMsg);
        fieldObj.focus();
		return false;
		}

	var firstChar = hostName.charCodeAt(0)
	if (!((firstChar >= 97 && firstChar <= 122) || (firstChar >= 65 && firstChar <= 90)))
		{
		var i18n_startAlphaNumHost = "";
        var i18n_startAlphaNumHostObj = document.getElementById("i18n_startAlphaNumHost");
        if(i18n_startAlphaNumHostObj) i18n_startAlphaNumHost = i18n_startAlphaNumHostObj.value;

		var errMsg =i18n_startAlphaNumHost;
		if (customMsg != "")
			errMsg = customMsg + errMsg;
		if (errDisplayField)
			errDisplayField.innerHTML = errMsg;
		else
			alert (errMsg);
        fieldObj.focus();
		return false;
		}

	var lastChar = hostName.charCodeAt(hostName.length-1)
	if(domainFlag && hostName.charCodeAt(hostName.length-1) == exceptionChars.charCodeAt(1)) { }
    else if (!((lastChar >= 97 && lastChar <= 122) || (lastChar >= 65 && lastChar <= 90) || (lastChar >= 48 && lastChar <= 57)))
        {
        var i18n_endAlphaNumHost = "";
        var i18n_endAlphaNumHostObj = document.getElementById("i18n_endAlphaNumHost");
        if(i18n_endAlphaNumHostObj) i18n_endAlphaNumHost = i18n_endAlphaNumHostObj.value;

        var errMsg =i18n_endAlphaNumHost;
        if (customMsg != "")
            errMsg = customMsg + errMsg;
        if (errDisplayField)
            errDisplayField.innerHTML = errMsg;
        else
            alert (errMsg);
        fieldObj.focus();
        return false;
        }

	if (errDisplayField) errDisplayField.innerHTML = "";
	return true;
	}

function checkLANHostName(fieldId, customMsg)
{
        var el = document.getElementById(fieldId);
		if(el.value.substr(0, 1) == "-")
		{
			alert("The first character cannot be \"-\"");
			return false;
		}				
        for(var i = 0 ; i < el.value.length ; i++) {
                var ch = el.value.charCodeAt(i);
                if (!((ch >= 97 && ch <= 122) ||
                        (ch >= 65 && ch <= 90) ||
                        (ch >= 48 && ch <= 57)) && (ch != 45))
                {
                        //alert(customMsg);
						alert("The Host Name is illegal.");
                        return false;
                }
        }
        return true;
}

/* [0-9],[a-z],[A-Z], '-' */
function checkComputerNameField(fieldId, fieldTitle, fieldErrMsg, prefixMsg, postfixMsg)
{
	var pattern = /^[a-zA-Z0-9-]+$/;
	var fieldObj = document.getElementById(fieldId);
	var field = fieldObj.value;
	if (!pattern.test(field))
	{
		alert(fieldTitle + ": " + fieldErrMsg);
		fieldObj.focus();
		return false;
	}
	var exceptionChars = "-0123456789";
	var beginChar = field.charCodeAt(0);
	var endChar = field.charCodeAt(field.length - 1);
	if (beginChar == exceptionChars.charCodeAt(0)
	|| beginChar == exceptionChars.charCodeAt(1)
	|| beginChar == exceptionChars.charCodeAt(2)
	|| beginChar == exceptionChars.charCodeAt(3)
	|| beginChar == exceptionChars.charCodeAt(4)
	|| beginChar == exceptionChars.charCodeAt(5)
	|| beginChar == exceptionChars.charCodeAt(6)
	|| beginChar == exceptionChars.charCodeAt(7)
	|| beginChar == exceptionChars.charCodeAt(8)
	|| beginChar == exceptionChars.charCodeAt(9)
	|| beginChar == exceptionChars.charCodeAt(10)
	|| beginChar == exceptionChars.charCodeAt(11))
	{
		alert(fieldTitle + ": " + prefixMsg);
		fieldObj.focus();
		return false;
	}
	if (endChar == exceptionChars.charCodeAt(0))
	{
		alert(fieldTitle + ": " + postfixMsg);
		fieldObj.focus();
		return false;
	}
	return true;
} 


//field: 0 or more
function checkASCIICharField(fieldId, fieldTitle)
{
	var fieldErrMsg1 = "Only allow to input ASCII characters.";
	var fieldErrMsg2 = "Empty Space, Single Quote and Double Quote characters are not supported for this field.";
	var pattern1 = /^\s*[\x21\x23\x24\x25\x26\x28-\x7F]*$/;
	var field = document.getElementById(fieldId).value;
	if(pattern1.test(field)){
		return true;
	}
	alert(fieldTitle + ": " + fieldErrMsg1 + " " + fieldErrMsg2);
	return false;
} 
