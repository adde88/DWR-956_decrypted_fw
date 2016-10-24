<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/textValidations.js" type="text/javascript"></script>

<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);
var GlobalTime = new Date();
var IntervalId;
function checkTime(i)
{
	if (i<10)
	{
		i="0" + i;
	}
	return i;
}

function ModifyTimeFormat(stime)
{
    var time_array = stime.split(" ");
    var date_array = time_array[4].split(":");
	var hour = parseInt(date_array[0],10);
	var minute = parseInt(date_array[1],10);
	var second = parseInt(date_array[2],10)+1;

	if ((second/60)>=1)
	{
		second = 0;
		minute = minute + 1;
	}

	if ((minute/60)>=1)
	{
		minute = 0;
		hour = hour + 1;
	}

    time_array[4] = checkTime(hour) + ":" + checkTime(minute) + ":" + checkTime(second);

    document.getElementById('cur_time').textContent =time_array[0] + " " +
                                                    time_array[1] + " " +
                                                    time_array[2] + " " +
                                                    time_array[3] + " " +
                                                    time_array[4] + " " +
                                                    time_array[5];

	hour=null;
	minute=null;
	second=null;
}

function UPdateCurrentTime()
{
    var strtime = document.getElementById('cur_time').innerHTML.toString();
    ModifyTimeFormat(strtime);
    IntervalId = window.setTimeout("UPdateCurrentTime()", 1000);
}

function SysTimeInit()
{
    var ntpCfg = <%getNTPConfig();%>
    var ntpArr = ntpCfg.split("#");
    var ntp_mode = ntpArr[0];

    if (ntp_mode == "1")
    {	
		document.getElementById("rdbAutoTime").checked = true;
		document.getElementById("rdbManualTime").checked = false;
		document.getElementById("time_zone").disabled=false;
		document.getElementById("chkDayLight").disabled=false;
		document.getElementById("ntp_server").disabled=false;
		document.getElementById("txtServer2Info").disabled=false;
		document.getElementById("txtServer3Info").disabled=false;
		document.getElementById("txtYear").disabled=true;
		document.getElementById("txtMonth").disabled=true;
		document.getElementById("txtDate").disabled=true;
		document.getElementById("txtHr").disabled=true;
		document.getElementById("txtMin").disabled=true;
		document.getElementById("txtSec").disabled=true;
    } else {
		document.getElementById("rdbAutoTime").checked = false;
		document.getElementById("rdbManualTime").checked = true;
		document.getElementById("time_zone").disabled=true;
		document.getElementById("chkDayLight").disabled=true;
		document.getElementById("ntp_server").disabled=true;
		document.getElementById("txtServer2Info").disabled=true;
		document.getElementById("txtServer3Info").disabled=true;
		document.getElementById("txtYear").disabled=false;
		document.getElementById("txtMonth").disabled=false;
		document.getElementById("txtDate").disabled=false;
		document.getElementById("txtHr").disabled=false;
		document.getElementById("txtMin").disabled=false;
		document.getElementById("txtSec").disabled=false;
    }

    var ntp_server = ntpArr[2];
    var ntp_interval = parseInt(ntpArr[3]);
    document.getElementById("ntp_server").value = ntp_server;
	document.getElementById("txtServer2Info").value=ntpArr[4];
	document.getElementById("txtServer3Info").value=ntpArr[5];
	if(ntpArr[6] == "0")
		document.getElementById("chkDayLight").checked = false;
	else
		document.getElementById("chkDayLight").checked = true;
    //IntervalId = window.setTimeout("UPdateCurrentTime()", 1000);
}

function timeSettingCheck()
{
	ResetIdleTime();
	if(document.getElementById("rdbAutoTime").checked)
	{
		document.getElementById("time_zone").disabled=false;
		document.getElementById("chkDayLight").disabled=false;
		document.getElementById("ntp_server").disabled=false;
		document.getElementById("txtServer2Info").disabled=false;
		document.getElementById("txtServer3Info").disabled=false;
		document.getElementById("txtYear").disabled=true;
		document.getElementById("txtMonth").disabled=true;
		document.getElementById("txtDate").disabled=true;
		document.getElementById("txtHr").disabled=true;
		document.getElementById("txtMin").disabled=true;
		document.getElementById("txtSec").disabled=true;
	}
	else
	{
		document.getElementById("time_zone").disabled=true;
		document.getElementById("chkDayLight").disabled=true;
		document.getElementById("ntp_server").disabled=true;
		document.getElementById("txtServer2Info").disabled=true;
		document.getElementById("txtServer3Info").disabled=true;

		document.getElementById("txtYear").disabled=false;
		document.getElementById("txtMonth").disabled=false;
		document.getElementById("txtDate").disabled=false;
		document.getElementById("txtHr").disabled=false;
		document.getElementById("txtMin").disabled=false;
		document.getElementById("txtSec").disabled=false;
	}
}

function timeZoneValidate()
{
	if(!CheckLoginInfo())
		return false;
	var i18n_validTimeServer = "Please enter a valid time-server name or IP address for server";
	
	var txtFieldIdArr = new Array (); 
	txtFieldIdArr[0] = "ntp_server,"+i18n_validTimeServer+"1";
	txtFieldIdArr[1] = "txtServer2Info,"+i18n_validTimeServer+"2";
	txtFieldIdArr[2] = "txtServer3Info,"+i18n_validTimeServer+"3";

	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;

	if (isProblemCharArrayCheck (txtFieldIdArr) == false)
		return false;
		
    var i18n_ipaddrDomain = "Invalid NTP Server.";//"Invalid IP Address/Domain name";

    if (checkHostName ('ntp_server', true, i18n_ipaddrDomain, false) == false)
        return false; 
   
    if (checkHostName ('txtServer2Info', true, i18n_ipaddrDomain, false) == false) 
        return false;

    if (checkHostName ('txtServer3Info', true, i18n_ipaddrDomain, false) == false) 
        return false;

	if(document.getElementById('rdbManualTime').checked)
	{
		var obj = document.getElementById('txtYear');
		if(obj && !obj.disabled)
		{
			if (yearCheck(obj) == false)
			return false;
		}

		obj = document.getElementById('txtMonth');
		if(obj && !obj.disabled)
		{
			if (monthCheck(obj) == false)
			return false;
		}

		obj = document.getElementById('txtDate');
		if(obj && !obj.disabled)
		{
			if (dateCheck(obj) == false)
			return false;
		}

		obj = document.getElementById('txtHr');
		if(obj && !obj.disabled)
		{
			if (hoursCheck(obj) == false)
			return false;
		}

		obj = document.getElementById('txtMin');
		if(obj && !obj.disabled)
		{
			if (minutsCheck(obj) == false)
			return false;
		}

		obj = document.getElementById('txtSec');
		if(obj && !obj.disabled)
		{
			if (secondsCheck(obj) == false)
			return false;
		}
		var offset = new Date().getTimezoneOffset();
    	var timezone = 0 - offset;
		var cursynctime;
		cursynctime = "\"" + document.getElementById('txtYear').value +
			"-" + document.getElementById('txtMonth').value +
			"-" + document.getElementById('txtDate').value + 
			" " + document.getElementById('txtHr').value +
			":" + document.getElementById('txtMin').value +
			":" + document.getElementById('txtSec').value +
			"\""; 
		document.getElementById("pc_time").value= cursynctime;
	    document.getElementById("pc_time").textContent= cursynctime;
	    document.getElementById("pc_time").text= cursynctime;
	    document.getElementById("pc_timezone").value=timezone.toString();
	    document.getElementById("pc_timezone").textContent= timezone.toString();

	}

	return true;
}

</script>
</head>

<body id="SysTimePage" onload="SysTimeInit();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("sys");%>
<script type="text/javascript">menuChange("sys_menu");leftMenuChange("system_time", "system_time_href");</script>
<!-- Main Menu and Submenu End -->


<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Time Settings"));</script></div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br><script>document.write(gettext("Network Time Protocol (NTP) is a protocol that is used to synchronize computer clock time in a network of computers.  This page allows setting the date, time and NTP servers.  Accurate time across a network is important for logging, scheduled upgrade and scheduled policies."));</script>
		<br></div>
		<!--<form name="frmTimeZone" method="post" action="platform.cgi">-->
		<form name="ntp_setting" action="/goform/setNTPConfig" method="post">
     		<input name="ntp_dummy" type="hidden" id="ntp_dummy" value=""/>
		<table border="0" cellpadding="0" cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Current Time"));</script></td>
				<td>
				<span id="cur_time"><%getCurrTime();%></span>
         		<input name="pc_time" type="hidden" id="pc_time" value=""/>
        	 	<input name="pc_timezone" type="hidden" id="pc_timezone" value="">
				
				</td>
			</tr>
			<tr>
				<td align="right">
				<input type="radio" name="auto" id="rdbAutoTime" value="1" onclick="timeSettingCheck();"></td>
				<td><script>document.write(gettext("Automatically get date and time"));</script></td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Time Zone"));</script></td>
				<td>
				<select name="time_zone" size="1" class="configF1" id="time_zone" >
         			<%getTimezone();%>
         			</select></td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Enable Daylight Saving"));</script></td>
				<td>
				<input type="checkbox" name="chkDayLight" id="chkDayLight">
				<input type="hidden" name="daylight_savings_flag" value="0"></td>
			</tr>
			
			<tr>
				<td><script>document.write(gettext("NTP Server1"));</script></td>
				<td>
				<input type="text" name="ntp_server" value="" id="ntp_server" class="configF1" size="20" maxlength="64" ></td>
				<!--onkeypress="return (alphaNumericCheck(event) || numericValueCheck (event, '.-'))" onkeydown="if (event.keyCode == 9) { return (ipv4AddrValidate (this, 'IP', false, false, '$| trStrings["20084"] or 'i18nHTMLMissing' |$', '$| trStrings["20056"] or 'i18nHTMLMissing' |$', true) || validateFQDN(this.id)); }"-->
			</tr>
			<tr>
				<td><script>document.write(gettext("NTP Server2"));</script></td>
				<td>
				<input type="text" name="ntp_server_2" value="" id="txtServer2Info" class="configF1" size="20" maxlength="64"></td>
			</tr>
			<tr>
				<td><script>document.write(gettext("NTP Server3"));</script></td>
				<td>
				<input type="text" name="ntp_server_3" value="" id="txtServer3Info" class="configF1" size="20" maxlength="64"></td>
			</tr>
			<tr>
				<td align="right">
				<input type="radio" name="auto" id="rdbManualTime" value="0" onclick="timeSettingCheck();"></td>
				<td><script>document.write(gettext("Configure date and time manually"));</script></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
				<table border="0" cellpadding="0" cellspacing="0" id="tblManTime" width="100%">
					<tr>
						<td align="center"><script>document.write(gettext("Year"));</script></td>
						<td align="center">&nbsp;</td>
						<td align="center"><script>document.write(gettext("Month"));</script></td>
						<td align="center">&nbsp;</td>
						<td align="center"><script>document.write(gettext("Day"));</script></td>
						<td align="center">&nbsp;</td>
						<td align="center"><script>document.write(gettext("Hour"));</script></td>
						<td align="center">&nbsp;</td>
						<td align="center"><script>document.write(gettext("Min"));</script></td>
						<td align="center">&nbsp;</td>
						<td align="center"><script>document.write(gettext("Sec"));</script></td>
					</tr>
					<tr>
						<td align="center">
						<input type="text" id="txtYear" class="configF1" name="year" size="4" value="" maxlength="4" onkeypress="return onkeypress_number_only (event)" ></td>
						<td align="center">/</td>
						<td align="center">
						<input type="text" id="txtMonth" class="configF1" name="month" size="4" value="" maxlength="2" onkeypress="return onkeypress_number_only (event)" ></td>
						<td align="center">/</td>
						<td align="center">
						<input type="text" id="txtDate" class="configF1" name="day" size="2" value="" maxlength="2" onkeypress="return onkeypress_number_only (event)" ></td>
						<td align="center">-</td>
						<td align="center">
						<input type="text" id="txtHr" class="configF1" name="hour" size="2" value="" maxlength="2" onkeypress="return onkeypress_number_only (event)" ></td>
						<td align="center">:</td>
						<td align="center">
						<input type="text" id="txtMin" class="configF1" name="minute" size="2" value="" maxlength="2" onkeypress="return onkeypress_number_only (event)" ></td>
						<td align="center">:</td>
						<td align="center">
						<input type="text" id="txtSec" class="configF1" name="second" size="2" value="" maxlength="2" onkeypress="return onkeypress_number_only (event)" ></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" id="apply_time" value="Apply" class="submit" title="Apply" name="" onclick="return timeZoneValidate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" id="reset_time" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
		</form>
	</div>
	<!-- Section End -->
</div>
</div>
 <script type="text/javascript">
	document.getElementById('apply_time').value=gettext("Apply");
	document.getElementById('reset_time').value=gettext("Reset");
 </script>

</body>
</html>
