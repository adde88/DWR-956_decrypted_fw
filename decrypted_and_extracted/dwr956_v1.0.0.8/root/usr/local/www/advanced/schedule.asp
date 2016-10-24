<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="javascript" src="../js/textValidations.js" type="text/javascript"></script>
<script language="javascript" src="../js/schedule.js" type="text/javascript"></script>
<script language="javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);
var nat_enable=<%getFwNatEnable();%>;
if(nat_enable!="1")
{
	window.location.href="../login.asp";
}

function pageLoad()
{
	var ScheduleConfig = <%getSchedule();%>;
	var ScheduleConfigArr;
	if (ScheduleConfig!="")
	{
		ScheduleConfigArr = ScheduleConfig.split("#");
		document.getElementById("txtscheduleName").value=ScheduleConfigArr[0];
		document.getElementById("txtscheduleName").disabled = true;
		document.getElementById("selTimeofDay").value=ScheduleConfigArr[1];
		document.getElementById("selDayofWeek").value=ScheduleConfigArr[9];
		document.getElementById("txtSchedStartTimeHrs").value=ScheduleConfigArr[2];
		document.getElementById("txtSchedStartTimeMns").value=ScheduleConfigArr[3];
		document.getElementById("selStartMeridian").value=parseInt(ScheduleConfigArr[4],10)?"PM":"AM";
		document.getElementById("txtSchedEndTimeHrs").value=ScheduleConfigArr[5];
		document.getElementById("txtSchedEndTimeMns").value=ScheduleConfigArr[6];
		document.getElementById("selEndMeridian").value=parseInt(ScheduleConfigArr[7],10)?"PM":"AM";			

		var selDayOfWeek = document.getElementById("selDayofWeek").value;
		var days=parseInt(ScheduleConfigArr[8],10);			
		var chkSun=Math.floor(days/64);
		var chkSat=Math.floor(days%64/32);
		var chkFri=Math.floor(days%64%32/16);
		var chkThu=Math.floor(days%64%32%16/8);
		var chkWed=Math.floor(days%64%32%16%8/4);
		var chkTue=Math.floor(days%64%32%16%8%4/2);
		var chkMon=Math.floor(days%64%32%16%8%4%2);
		if (selDayOfWeek=="3") //custom
		{
			document.getElementById("chkSun").checked=chkSun?true:false;
			document.getElementById("chkSat").checked=chkSat?true:false;
			document.getElementById("chkFri").checked=chkFri?true:false;
			document.getElementById("chkThu").checked=chkThu?true:false;
			document.getElementById("chkWed").checked=chkWed?true:false;
			document.getElementById("chkTue").checked=chkTue?true:false;
			document.getElementById("chkMon").checked=chkMon?true:false;						
		}
	}
	else
	{
		document.getElementById("txtscheduleName").value="";
		document.getElementById("selTimeofDay").value="0";
		document.getElementById("selDayofWeek").value="0";
		document.getElementById("txtscheduleName").disabled = false;
	}
}

function pageValidate()
{
	if(!CheckLoginInfo())
		return false;
	
	var i18n_enterValidSch = "Please enter valid Schedule Name.";
	var txtFieldIdArr = new Array ();
	txtFieldIdArr[0] = "txtscheduleName,"+i18n_enterValidSch;
	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;
	//if (isProblemCharArrayCheck (txtFieldIdArr) == false)
	//	return false;
 	if (checkCommonNameField('txtscheduleName', "Schedule Name") == false) {
		return false;
 	}

	if (specificDaySelectionCheck () == false)
		return false;

	/* Start : Time Validation */
	var selValue= comboSelectedValueGet ('selTimeofDay');
	if (!selValue) return;
	if (parseInt(selValue, 10) == 5)
	{
	   	if (dateValidate ('txtSchedStartTimeHrs', 'txtSchedStartTimeMns','date1Err') == false)
			return false;
		if (dateValidate ('txtSchedEndTimeHrs', 'txtSchedEndTimeMns','date2Err') == false)
			return false;
		if (!timeValidate())
			return false;
   	}

	if (timeValidate()==false)
		return false;
   	/* End : Time Validation */
	  return true;
}

</script>

</head>	

<body onload="pageLoad(); scheduleInit(); chkSelOptTmDay(); chkSelOptDayWeek();">

<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("firewall_submenu","firewall_submenu_focus","rules_for_schedule","rules_for_schedule_href");</script>
<!-- Main Menu and Submenu End -->

<!-- Right Content start -->
<div class="contentBg">
	<div class="secH1">Schedules</div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
		<form name="frmSchedule" method="post" action="/goform/setSchedule">
		<div class="secH2">Schedule Configuration</div>
		
		<div class="secInfo">
			<br>Schedules define the time frames for security policies, parental control, and other system features.
			<br>
			<a class="secLable1" href="rules_for_schedule.asp">>> Back to Rules for Schedule page</a>        									
		</div>
		<table cellspacing="0" class="configTbl">
			<tr>
				<td>Schedule Name</td>
				<td>
					<input type="text" name="name" class="configF1" value="" id="txtscheduleName" size="20" maxlength="31">
				</td>
				<td></td>
			</tr>
		</table>
		<div class="secH2">Time of Day</div>
		
		<div class="secInfo">
			<br>If desired you can specify the specific time duration for this schedule.
			<br>
		</div>
		<table cellspacing="0" class="configTbl">
			<tr>
				<td colspan="3">Do you want this schedule to be active all day or at specific times during the day?</td>
			</tr>
			<tr>
				<td>Time of Day</td>
				<td>
				<select name="time_of_day.value" size="1" id="selTimeofDay" class="configF1" onchange="chkSelOptTmDay();">
					<!-- Given Security list -->
					<option  value="0">Morning (5 AM - 12 PM )</option>
					<option  value="1">Afternoon (12 PM - 4 PM )</option>
					<option  value="2">Evenings(4 PM - 7 PM)</option>
					<option  value="3">Nights (7 PM - 12 PM)</option>
					<option  value="4">Entire Day</option>
					<option  value="5">Custom</option>
					<!-- Ending Lua loop -->
				</select> 
				</td>
				<td></td>
			</tr>
			<tr>
				<td>Start Time</td>
				<td>
				<input type="text" name="time_of_day.start_hr" class="configF1" id="txtSchedStartTimeHrs" value="" size="6" maxlength="2" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 1, 12, true, 'Invalid Start time.', 'hours');}"> 
				<span class="spanText">Hour </span>
				<input type="text" name="time_of_day.start_min" class="configF1" id="txtSchedStartTimeMns" value=""  size="6" maxlength="2" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 0, 59, true, 'Invalid Start time.', 'minutes');}"> 
				<span class="spanText">Minute </span>
				<select size="1" name="time_of_day.start_am_pm" class="configF1" id="selStartMeridian">
				<option  value="AM">AM</option>
				<option  value="PM">PM</option>
				</select></td>
				<td></td>
			</tr>
			<tr>
				<td>End Time</td>
				<td>
				<input type="text" name="time_of_day.end_hr" value="" class="configF1" id="txtSchedEndTimeHrs" value size="6" maxlength="2" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 1, 12, true, 'Invalid End time.', 'hours');}"> 
				<span class="spanText">Hour </span>
				<input type="text" name="time_of_day.end_min" class="configF1" value="" id="txtSchedEndTimeMns" value size="6" maxlength="2" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 0, 59, true, 'Invalid End time.', 'minutes');}"> 
				<span class="spanText">Minute </span>
				<select size="1" name="time_of_day.end_am_pm" class="configF1" id="selEndMeridian">
				<option  value="AM">AM</option>
				<option  value="PM">PM</option>
				</select></td>
				<td></td>
			</tr>
		</table>
		<div class="secH2">Days of Week</div>
		
		<div class="secInfo">
			<br>Schedules define the time frames for security policies, parental control, and other system features.
			<br>
		</div>		
		<table cellspacing="0" class="configTbl">
			<tr>
				<td colspan="3">Do you want this schedule to be active on all days or specific days? </td>
			</tr>
			<tr>
				<td>Days of Week</td>
				<td>
				<select name="day_of_week.value" size="1" class="configF1" id="selDayofWeek" onchange="chkSelOptDayWeek ();">
				<!-- Given Security list , , , -->
				<option  value="0">Entire Week</option>
				<option  value="1">Weekends</option>
				<option  value="2">Week Days</option>
				<option  value="3">Custom</option>
				<!-- Ending Lua loop -->
				</select> 
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="3">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tblScheduleDays">
					<tr>
						<td>
						<input type="checkbox" name="day_of_week.sunday"  value="1" id="chkSun">
						<input type="hidden" name="day_of_week.sunday" value="0">
						</td>
						<td>Sunday</td>
						<td>
						<input type="checkbox" name="day_of_week.monday"  value="1" id="chkMon">
						<input type="hidden" name="day_of_week.monday" value="0">
						</td>
						<td>Monday</td>
					</tr>
					<tr>
						<td>
						<input type="checkbox" name="day_of_week.tuesday"  value="1" id="chkTue">
						<input type="hidden" name="day_of_week.tuesday" value="0">
						</td>
						<td>Tuesday</td>
						<td>
						<input type="checkbox" name="day_of_week.wednesday"  value="1" id="chkWed">
						<input type="hidden" name="day_of_week.wednesday" value="0">
						</td>
						<td>Wednesday</td>
					</tr>
					<tr>
						<td>
						<input type="checkbox" name="day_of_week.thursday"  value="1" id="chkThu">
						<input type="hidden" name="day_of_week.thursday" value="0">
						</td>
						<td>Thursday</td>
						<td>
						<input type="checkbox" name="day_of_week.friday"  value="1" id="chkFri">
						<input type="hidden" name="day_of_week.friday" value="0">
						</td>
						<td>Friday</td>
					</tr>
					<tr>
						<td>
						<input type="checkbox" name="day_of_week.saturday"  value="1" id="chkSat">
						<input type="hidden" name="day_of_week.saturday" value="0">
						</td>
						<td>Saturday</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</td>
				</tr>
		</table>
		<div class="submitBg">
			<input type="submit" value="Apply" class="submit" title="Apply" onclick="return pageValidate(); " onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" value="Reset" class="submit" title="Reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"  onclick="scheduleInit(); chkSelOptTmDay(); chkSelOptDayWeek(); doRedirect();">
		</div>
		</form>
	</div>
	<!-- Section End -->
</div>
<!-- contentBg End -->

</div>
</body>
</html>
