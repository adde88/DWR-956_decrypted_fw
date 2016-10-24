/* schedule.js - API library for schedule configuration */

/*
* Copyright (c) 2010 TeamF1, Inc.
* All rights reserved.
*/

/*
modification history
------------------------
*/

function scheduleFormValidate()
{
	var i18n_enterSchName = "Please enter a valid Schedule Name";
	var i18n_invalidHoursStart = "Invalid start time for schedule. Enter valid hour between 1 and 12";
	var i18n_invalidStartTime = "Invalid start time for schedule.";
	var i18n_hours = "hours";
	var i18n_invalidMinsStart = "Invalid start time for schedule. Enter valid minutes between 0 and 59";
	var i18n_mins = "minutes";
	var i18n_invalidHoursEnd = "Invalid end time for schedule. Enter valid hour between 1 and 12";
	var i18n_invalidEndTime = "Invalid end time for schedule.";
	var i18n_invalidMinsEnd = "Invalid end time for schedule. Enter valid minutes between 0 and 59";

	//check schedule name
	var txtFieldIdArr = new Array ();
	txtFieldIdArr[0] = "txtscheduleName," +i18n_enterSchName;
	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;

	//check schedule time field
	var obj = null;
	var time = 0;
	/* get and validate start hours */
	objSt = document.getElementById('txtSchedStartTimeHrs');
	if (numericValueRangeCheck (objSt , 1, i18n_invalidHoursStart, 1, 12, true, i18n_invalidStartTime, i18n_hours) == false)
		return false;
	/* get and validate start minutes */
	objSm = document.getElementById('txtSchedStartTimeMns');
	if (numericValueRangeCheck (objSm , 1, i18n_invalidMinsStart, 0, 59, true, i18n_invalidStartTime, i18n_mins) == false)
		return false;
	/* get and validate end hours */
	objEt = document.getElementById('txtSchedEndTimeHrs');
	if (numericValueRangeCheck (objEt , 1, i18n_invalidHoursEnd, 1, 12, true, i18n_invalidEndTime, i18n_hours) == false)
		return false;
	/* get and validate end hours */
	objEm = document.getElementById('txtSchedEndTimeMns');
	if (numericValueRangeCheck (objEm , 1, i18n_invalidMinsEnd, 0, 59, true, i18n_invalidEndTime, i18n_mins) == false)
		return false;

	
	return true;
}

function numObj (id, minLen, minVal, maxVal, errMsg)
{
	this.id = id;
	this.minLen = minLen;
	this.minVal = minVal;
	this.maxVal = maxVal;
	this.errMsg = errMsg;
}

function dateValidate (hoursId, minId, errObjId)
{
	var i18n_invalidHours112 = "Invalid Hours: Please enter a value between 1 - 12";
	var i18n_invalidMins059 = "Invalid Minutes: Please enter a value between 0 - 59";

	var dtVarObj = new Array ();
	dtVarObj[0] = new numObj(hoursId, 1, 1, 12, i18n_invalidHours112);
	dtVarObj[1] = new numObj(minId, 1, 0, 59, i18n_invalidMins059);
	var idObj = null;
	for (var idx = 0; idx < dtVarObj.length; ++idx)
	{
		idObj = document.getElementById (dtVarObj[idx].id);
		if (!idObj || idObj.disabled) continue;
		if ((idObj.value.length < dtVarObj[idx].minLen) ||
			(parseInt (idObj.value, 10) < dtVarObj[idx].minVal) ||
			((dtVarObj[idx].maxVal != 0) && (parseInt (idObj.value, 10) > dtVarObj[idx].maxVal)))
			{
			if (document.getElementById(errObjId))
				document.getElementById(errObjId).innerHTML = dtVarObj[idx].errMsg
			else
				alert (dtVarObj[idx].errMsg);
			idObj.focus ();
			return false;
		}
	}
	//document.getElementById(errObjId).innerHTML = "";
	return true;
}

function timeValidate()
{
    var meridian1 = document.getElementById('selStartMeridian').value;
    var meridian2 = document.getElementById('selEndMeridian').value;

    var i18n_endLessStart = "End hour cannot be less than the start hour";
	var i18n_endHrsNextDay = "End Time hours cannot extend to next day";
	
	var hr1 = parseInt (document.getElementById('txtSchedStartTimeHrs').value, 10);
	var hr2 = parseInt (document.getElementById('txtSchedEndTimeHrs').value, 10);
	var min1 = parseInt (document.getElementById('txtSchedStartTimeMns').value,10);
	var min2 = parseInt (document.getElementById('txtSchedEndTimeMns').value,10);
	if (isNaN(hr1))
	{
		alert("Invalid Start time. Please enter a value between 1 - 12 hours.");
		return false;
	}
	else if (isNaN(hr2))
	{	
		alert("Invalid End time. Please enter a value between 1 - 12 hours.");
		return false;
	}
	else if (isNaN(min1))
	{
		alert("Invalid Start time. Please enter a value between 0 - 59 minutes.");		
		return false;
	}
	else if (isNaN(min2))
	{
		alert("Invalid End time. Please enter a value between 0 - 59 minutes.");
		return false;		
	}	
		
    if( meridian1 == meridian2 )
    {		
		if(hr1==hr2)
		{
			if(min1 >= min2)
			{
				alert("Please check minutes");
				return false;
			}
		}
		else if(hr1>hr2)
		{
			if (hr1 != 12)
			{
				alert(i18n_endLessStart);
				return false;
			}
		}
    }
    else if (meridian1 == 'PM' && meridian2 == 'AM')
    {
    	alert(i18n_endHrsNextDay);
    	return false;
    }
	return true;
}

function specificDaySelectionCheck()
{
	var i18n_selDaysOnSch = "Please select day(s) on which this schedule should apply.";
	var selValue= comboSelectedValueGet ('selDayofWeek');
	if (!selValue) return;
	if (parseInt(selValue, 10) == 3)
	{
		if (document.getElementById('chkSun').checked ||
		    document.getElementById('chkMon').checked ||
		    document.getElementById('chkTue').checked ||
		    document.getElementById('chkWed').checked ||
		    document.getElementById('chkThu').checked ||
		    document.getElementById('chkFri').checked ||
		    document.getElementById('chkSat').checked)
			return true;
		else
		{
			errMag = i18n_selDaysOnSch;
			if (document.getElementById ('errMsg'))
				document.getElementById ('errMsg').innerHTML = errMag;
			else
				alert (errMag);
			return false;
		}
	}
	return true;
}

function scheduleDayOptCheck ()
{
  var selValue= radioCheckedValueGet ('Schedules.allDays');
  if (!selValue) return;
  switch (parseInt(selValue, 10))
  {
  	case 0:/* specific day */
	  	fieldStateChangeWr ('','','chkSun chkMon chkTue chkWed chkThu chkFri chkSat','');
	  	break;
  	case 1:/* all day */
	  	fieldStateChangeWr ('chkSun chkMon chkTue chkWed chkThu chkFri chkSat','','','');
	  	break;
  }
}

function scheduleTimeOptCheck ()
{
  var selValue= radioCheckedValueGet ('Schedules.AllDay');
  if (!selValue) return;
  switch (parseInt(selValue, 10))
  {
	case 0:/* specific times */
		fieldStateChangeWr ('','','','tblScheduleTime');
		break;
	case 1:/* all day */
		fieldStateChangeWr ('','tblScheduleTime','','');
		break;
  }
}

function scheduleInit ()
{
  scheduleDayOptCheck ();
  scheduleTimeOptCheck ();
}

function chkSelOptTmDay ()
{
  var selectedValue = comboSelectedValueGet('selTimeofDay');
  if (!selectedValue) return;  
  if (selectedValue=="0")
  { //5AM-12PM
	document.getElementById("txtSchedStartTimeHrs").value="5";
	document.getElementById("txtSchedStartTimeMns").value="0";
	document.getElementById("selStartMeridian").value="AM";
	document.getElementById("txtSchedEndTimeHrs").value="12";
	document.getElementById("txtSchedEndTimeMns").value="0";
	document.getElementById("selEndMeridian").value="PM";			  
  }
  else if (selectedValue=="1")
  { //12PM-4PM
	document.getElementById("txtSchedStartTimeHrs").value="12";
	document.getElementById("txtSchedStartTimeMns").value="0";
	document.getElementById("selStartMeridian").value="PM";
	document.getElementById("txtSchedEndTimeHrs").value="4";
	document.getElementById("txtSchedEndTimeMns").value="0";
	document.getElementById("selEndMeridian").value="PM";	  
  }
  else if (selectedValue=="2")
  { //4PM-7PM
	document.getElementById("txtSchedStartTimeHrs").value="4";
	document.getElementById("txtSchedStartTimeMns").value="0";
	document.getElementById("selStartMeridian").value="PM";
	document.getElementById("txtSchedEndTimeHrs").value="7";
	document.getElementById("txtSchedEndTimeMns").value="0";
	document.getElementById("selEndMeridian").value="PM";	  	
  }
  else if (selectedValue=="3")
  { //7PM-12PM
	document.getElementById("txtSchedStartTimeHrs").value="7";
	document.getElementById("txtSchedStartTimeMns").value="0";
	document.getElementById("selStartMeridian").value="PM";
	document.getElementById("txtSchedEndTimeHrs").value="12";
	document.getElementById("txtSchedEndTimeMns").value="0";
	document.getElementById("selEndMeridian").value="PM";	  
  }
  else if (selectedValue=="4")
  { //Entire Day
	document.getElementById("txtSchedStartTimeHrs").value="0";
	document.getElementById("txtSchedStartTimeMns").value="0";
	document.getElementById("selStartMeridian").value="AM";
	document.getElementById("txtSchedEndTimeHrs").value="12";
	document.getElementById("txtSchedEndTimeMns").value="0";
	document.getElementById("selEndMeridian").value="PM";	  
  }  
  
  switch (parseInt(selectedValue,10))
  {
	case 0:/* Morning (5 AM - 12 PM ) */
	case 1:/* Afternoon (12 PM - 4 PM ) */
	case 2: /* Evenings(4 PM - 7 PM) */
	case 3: /* Nights (7 PM - 12 PM) */
	case 4: /* Entire Day */
	fieldStateChangeWr ('txtSchedStartTimeHrs txtSchedStartTimeMns selStartMeridian txtSchedEndTimeHrs txtSchedEndTimeMns selEndMeridian', '', '', '');
	break;
	case 5:/* custom */
	fieldStateChangeWr ('', '', 'txtSchedStartTimeHrs txtSchedStartTimeMns selStartMeridian txtSchedEndTimeHrs txtSchedEndTimeMns selEndMeridian', '');
	break;
  }
}

function chkSelOptDayWeek()
{
	var selectedValue = comboSelectedValueGet('selDayofWeek');
	if (!selectedValue) return;
	if (selectedValue=="0") //entire week
	{
		document.getElementById("chkSun").checked=true;
		document.getElementById("chkSat").checked=true;
		document.getElementById("chkFri").checked=true;
		document.getElementById("chkThu").checked=true;
		document.getElementById("chkWed").checked=true;
		document.getElementById("chkTue").checked=true;
		document.getElementById("chkMon").checked=true;
	}
	else if (selectedValue=="1") //weekends
	{
		document.getElementById("chkSat").checked=true;
		document.getElementById("chkSun").checked=true;	
		document.getElementById("chkFri").checked=false;
		document.getElementById("chkThu").checked=false;
		document.getElementById("chkWed").checked=false;
		document.getElementById("chkTue").checked=false;
		document.getElementById("chkMon").checked=false;		
	}
	else if (selectedValue=="2") //week days
	{
		document.getElementById("chkSat").checked=false;
		document.getElementById("chkSun").checked=false;		
		document.getElementById("chkFri").checked=true;
		document.getElementById("chkThu").checked=true;
		document.getElementById("chkWed").checked=true;
		document.getElementById("chkTue").checked=true;
		document.getElementById("chkMon").checked=true;		
	}
		
	switch (parseInt(selectedValue,10))
	{
		case 0:/* Entire Week */
		case 1:/* Weekends */
		case 2: /* Week Days */
		fieldStateChangeWr ('chkSun chkMon chkTue chkWed chkThu chkFri chkSat', '', '', '');
		break;
		case 3:/* custom */
		fieldStateChangeWr ('', '', 'chkSun chkMon chkTue chkWed chkThu chkFri chkSat', '');
		break;
	}
}

