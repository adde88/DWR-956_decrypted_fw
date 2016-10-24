<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/textValidations.js" type="text/javascript"></script>   
<script language="JavaScript" src="../js/ipv4AddrValidations.js" type="text/javascript"></script>

<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);

var enable_log = null;

function chkbuttonEnable ()
{
	if (document.getElementById('chkEnblLog').checked)
	{
		fieldStateChangeWr ('','','selFacility','');
	}
	else
	{
		fieldStateChangeWr ('selFacility','','','');
	}
}

var ip_rule=/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
function SysLogInit()
{
    var remotelog = <%getRemoteLog();%>;
	var syslog = <%getSysLog();%>;
    var remoteArr = remotelog.split("#");
    var remote_enable = remoteArr[0];
	var syslogArr = syslog.split("#");

    if (remote_enable == "1")
    {
        document.getElementById("remote_log_enable").checked = true;
        document.getElementById("remote_ip").disabled = false;
    } 
	else 
	{
        document.getElementById('remote_log_enable').checked = false;
        document.getElementById('remote_ip').disabled = true;
    }
    document.getElementById("remote_ip").value = remoteArr[1];

 enable_log = syslogArr[0];
	if(syslogArr[0] == "1")
	{
		document.getElementById("chkEnblLog").checked = true;
        document.getElementById("selFacility").disabled = false;
  setTimeout(function () { View_Logs(); }, 1000);
	}
	else
	{
		document.getElementById("chkEnblLog").checked = false;
        document.getElementById("selFacility").disabled = true;
	}
	document.getElementById("selFacility").value = syslogArr[1];
}

function ChkSrvLogState()
{
    var RemSysChecked = document.getElementById('remote_log_enable').checked;

    if(RemSysChecked)
    {
        document.getElementById('remote_ip').disabled = false;
    } else {
        document.getElementById('remote_ip').disabled = true;
    }
}	
function fnApply()
{
	if(!CheckLoginInfo())
		return false;
	var txtFieldIdArr = new Array();
	txtFieldIdArr[0] = "lan_hostname, Invalid Host Name Format";
	txtFieldIdArr[1] = "lan_ip, Invalid IP address Format";
	txtFieldIdArr[2] = "lan_submask, Invalid Subnet Mask Format";

	if (txtFieldArrayCheck(txtFieldIdArr) == false)
		return false;
	 
	if(document.getElementById('remote_ip').value=="")
	{
		alert(gettext("IP address should not be empty."));
		return false;
	}
	else
	{
		if (ipv4Validate("remote_ip", "IP", false, true, "", "", true) == false) 
		{
			return false;
		}
	}
	document.getElementById("temp_remote_ip").value=document.getElementById("remote_ip").value
	
	return true;
}

function downloadfile()
{
	if(!CheckLoginInfo())
		return false;
    var filename;
    var url = '/backup_log/';
    for( var index=0 ; index<document.getElementById("sellog").options.length ; index++ )
    {
            if (document.getElementById("sellog").options[index].selected == true)
            {
		if (document.getElementById("sellog").options.length == 0)
			break;

                    filename = document.getElementById("sellog").options[index].value;
		url = url + filename;
		window.open(url,'Download');
                    break;
            }
    }
}

function submitCheck()
{
	if(!CheckLoginInfo())
		return false;
	if(document.getElementById("chkEnblLog").checked)
	{
		document.getElementById("temp_enable_logging").value = "1";
	}
	else
	{
		document.getElementById("temp_enable_logging").value = "0";
	}
	return true;
}

function checkEventLog(state)
{
	if (enable_log == "1") {
	if(state == "refresh")
	{
		if(!CheckLoginInfo("ResetPage"))
			return false;
		setTimeout(function () { View_Logs(); }, 1000);
	}
	else
	{
		if(!CheckLoginInfo())
		return false;
		document.getElementById("getEventLog").value="";
	}
 }
	return true;
}

</script>
</head>

<body onload="SysLogInit();chkbuttonEnable();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("sys");%>
<script type="text/javascript">menuChange("sys_menu");leftMenuChange("remote_log", "remote_log_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("System Logs"));</script></div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg" id="infoMsg" style="visibility:hidden"></div>
		<form name="SYSLOG" action="/goform/setRemoteLog" method="post">

        <div class="secH2"><script>document.write(gettext("System Logs"));</script></div>
		<div class="secInfo"></div>
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Enable Logging"));</script></td>
				<td><input type="checkbox" name="enable_logging" id="chkEnblLog"  value="on" onclick="return chkbuttonEnable();" />
				<input type="hidden" name="temp_enable_logging" id="temp_enable_logging" value="0" /></td>
				<td></td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Log Category"));</script></td>
				<td>
       <select name="facility" size="1" class="configF1" id="selFacility">
         <option value="1"><script>document.write(gettext("All"));</script></option>
         <option value="2"><script>document.write(gettext("Internet"));</script></option>
         <option value="3"><script>document.write(gettext("WiFi"));</script></option>
         <option value="4"><script>document.write(gettext("Firewall"));</script></option>
         <option value="5"><script>document.write(gettext("Applications"));</script></option>
         <option value="6"><script>document.write(gettext("LAN"));</script></option>
       </select>
				</td>
				<td></td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" id="apply_sys_log" value="Apply" class="submit" onclick="return submitCheck();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
			<input type="button" id="reset_sys_log" value="Reset" class="submit" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
		</div>
		</form>
	 <br />
		<div class="secH2"><script>document.write(gettext("View Logs"));</script></div>
		<br />
		<table cellspacing="0" class="configTbl">
			<tr>
			<td>
     <textarea rows="10" name="getEventLog" id="getEventLog" cols="80" class="configF1">
     </textarea>
   </td>
		</tr>
		</table>
		<div class="submitBg">
			<input type="button" id="refresh_log" value="Refresh Log" onclick="return checkEventLog('refresh');" class="submit" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
			<input type="button" id="clear_log" value="Clear Log" onclick="return checkEventLog('clear');" class="submit" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
		</div>
		<br />
  <div class="secH2"><script>document.write(gettext("Download tar log files"));</script></div>
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Select file "));</script></td>
				<td>
					<select name="logfiles" size="1" id="sellog">
					<% getSystemBackupLog(); %>
					</select>
				</td>
				<td>
					<div class="submitBg">
					<input type="button" id="download" value="Download" class="submit" onclick="downloadfile()" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
					</div>
				</td>
			</tr>
		</table>
		<br />
		<div class="secH2"><script>document.write(gettext("Remote Logging"));</script></div>
		<br />
		<form name="syslog_setting" action="/goform/setSysLog" method="post">
		<input type="hidden" id="temp_remote_ip" name="temp_remote_ip" value="">
		<table border="0" cellpadding="0" cellspacing="0" class="configTbl">
					<tr>
				<td><script>document.write(gettext("Enable Remote Logging"));</script></td>
				<td>
				<input type="checkbox" name="remote_log_enable" value="on" id="remote_log_enable" onclick="ChkSrvLogState()" />
				</td>
			    </tr>
			    <tr>
				<td><script>document.write(gettext("IP Address"));</script></td>
				<td><input type="text" name="remote_ip" value="" id="remote_ip" size="30" class="configF1" maxlength="15" /></td>
				<!--onkeypress="return numericValueCheck (event, '.')" onkeydown="if (event.keyCode == 9) { return ipv4AddrValidate (this, 'IP', true, true, '$| trStrings["20084"] or 'i18nHTMLMissing' |$', '$| trStrings["20056"] or 'i18nHTMLMissing' |$', true); }"-->
				</tr>
				</table>
		<div class="submitBg">
			<input type="submit" id="apply_remote_logging" value="Apply" class="submit" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return fnApply();" />
			<input type="button" id="reset_remote_logging" value="Reset" class="submit" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
		</div>
		</form>
</div>
</div>
</div>
 <script type="text/javascript">
	document.getElementById('apply_remote_logging').value=gettext("Apply");
	document.getElementById('reset_remote_logging').value=gettext("Reset");
	document.getElementById('apply_sys_log').value=gettext("Apply");
	document.getElementById('reset_sys_log').value=gettext("Reset");
	document.getElementById('download').value=gettext("Download");
	document.getElementById('refresh_log').value=gettext("Refresh Log");
	document.getElementById('clear_log').value=gettext("Clear Log");

function View_Logs()
{
	var ajax = createAjax();

 ajax.open('GET', "get_view_logs.asp?time="+ new Date(), true);
 ajax.send(null);
	ajax.onreadystatechange = function ()
	{
  if (ajax.readyState == 4)
		{
   if (ajax.status == 200)
			{
    var data = ajax.responseText;
    if (data)
				{
      document.getElementById("getEventLog").value=data;
    }
   }
  }
 }
}
 </script>

</body>
</html>
