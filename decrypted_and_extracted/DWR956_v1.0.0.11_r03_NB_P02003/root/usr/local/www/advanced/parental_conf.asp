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
//<!--

CheckInitLoginInfo(<%getuser_login();%>);

var nat_enable=<%getFwNatEnable();%>;
if(nat_enable!="1")
{
	window.location.href="../login.asp";
}

function chkSessionval ()
{
	var txtsstObj = document.getElementById ('txtSsTime');
	var txtInaObj = document.getElementById('txtInacty');
	var txtsstObjVal = parseInt(txtsstObj.value,10);
	var txtInaObjVal = parseInt(txtInaObj.value,10);

	if(txtInaObjVal > txtsstObjVal)
	{
		alert("Inactivity Timeout value should be less than or equal to Session Timeout value.");
		txtInaObj.focus();
		return false;
	}
	return true;
}

function pageValidate ()
{
	if(!CheckLoginInfo())
		return false;
	if (fieldLengthCheck ('txtPconfName', 0, 32, 'Please Enter below 32 characters')==false)
		return false;
	
	if (fieldLengthCheck ('txtPconfDesc', 0, 128, 'Please Enter below 128 characters')==false)
		return false;	

	var txtFieldIdArr = new Array ();
	txtFieldIdArr[0] = "txtPconfName,Please Enter valid Name";
	txtFieldIdArr[1] = "txtSsTime,Please Enter valid Session TimeOut value";
	txtFieldIdArr[2] = "txtInacty,Please Enter valid Inactivity TimeOut value";

	var sessTimeObj = document.getElementById ('txtSsTime');
	if (numericValueRangeCheck (sessTimeObj, '', '', 1, 999, true, 'Invalid Session Timeout: ', 'minutes.') == false)
		return false;
	var inactivityObj = document.getElementById ('txtInacty');
	if (numericValueRangeCheck (inactivityObj, '', '', 1, 999, true, 'Invalid Inactivity Timeout: ', 'minutes.') == false)
		return false;

	if (document.getElementById('chkEnbFilterCnt').checked && 
		document.getElementById('selOptFlCnt').value=="")
	{
		alert(gettext("Please select a Filter Content"));
		return false;
	}
	if (document.getElementById('chkEnbRIAT').checked && 
		document.getElementById('selOptInternet').value=="")
	{
		alert(gettext("Please select an Internet Access Schedule"));
		return false;
	}	
		
	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;

	if (checkCommonNameField('txtPconfName', "Profile Name") == false)
		return false;

	//if (isProblemCharArrayCheck (txtFieldIdArr) == false)
	//	return false;

	if (chkSessionval() == false)
		return false;

	if (checkASCIICharField('txtPconfDesc', "Description") == false)
		return false;

	return true;
}

function filterCntCheck ()
{
	var enable_filter = document.getElementById('chkEnbFilterCnt');
	var filterCount = document.getElementById('selOptFlCnt').getElementsByTagName("option").length;	
	if (enable_filter.checked && filterCount==0)
	{
		enable_filter.checked = false;
		alert(gettext("Please add Filter Content in URL Blocking page"));
		return false;
	}
	if (enable_filter.checked==true)
		enable_filter.value="1";
	else
		enable_filter.value="0";		
	depFieldCheck ('chkEnbFilterCnt', true, '', '', 'selOptFlCnt', '');
	depFieldCheck ('chkEnbFilterCnt', false, 'selOptFlCnt', '', '', '');
}

function intAccessCheck()
{
	var enable_schedule=document.getElementById('chkEnbRIAT');
	var scheduleCount = document.getElementById('selOptInternet').getElementsByTagName("option").length;		
	if (enable_schedule.checked && scheduleCount==0)
	{
		enable_schedule.checked = false;
		alert(gettext("Please add Internet Access Schedule in Rules for Schedule page"));
		return false;		
	}
	if (enable_schedule.checked==true)
		enable_schedule.value="1";
	else
		enable_schedule.value="0";
	depFieldCheck ('chkEnbRIAT', true, '', '', 'selOptInternet', '');
	depFieldCheck ('chkEnbRIAT', false, 'selOptInternet', '', '', '');
}

function pageLoad()
{
	var UrlProfileConfig = <%getUrlProfileConfig();%>;
	var UrlProfileConfigArr;
	if (UrlProfileConfig!="")
	{
		UrlProfileConfigArr = UrlProfileConfig.split("#");
		document.getElementById("txtPconfName").value=UrlProfileConfigArr[0];
		document.getElementById("txtPconfName").disabled = true;
		document.getElementById("txtPconfDesc").value=UrlProfileConfigArr[1];
		document.getElementById("pctrl.group").value=UrlProfileConfigArr[2];
		document.getElementById("chkEnbFilterCnt").value=UrlProfileConfigArr[3];
		if (document.getElementById("chkEnbFilterCnt").value=='1')
			document.getElementById("chkEnbFilterCnt").checked=true;
		document.getElementById("selOptFlCnt").value=UrlProfileConfigArr[4];
		document.getElementById("chkEnbRIAT").value=UrlProfileConfigArr[5];		
		if (document.getElementById("chkEnbRIAT").value=='1')
			document.getElementById("chkEnbRIAT").checked=true;
		document.getElementById("selOptInternet").value=UrlProfileConfigArr[6];
		document.getElementById("txtSsTime").value=UrlProfileConfigArr[7];
		document.getElementById("txtInacty").value=UrlProfileConfigArr[8];		
	}
	else
	{
		document.getElementById("txtPconfName").disabled = false;
		document.getElementById("txtPconfName").value="";
		document.getElementById("txtPconfDesc").value="";
		document.getElementById("pctrl.group").value="admin";
		document.getElementById("chkEnbFilterCnt").value="0";		
		//document.getElementById("selOptFlCnt").value="0";
		document.getElementById("chkEnbRIAT").value="0";
		//document.getElementById("selOptInternet").value="0";
		document.getElementById("txtSsTime").value="";
		document.getElementById("txtInacty").value="";			
	}
}
//-->
</script>

</head>	

<body onload="pageLoad(); filterCntCheck(); intAccessCheck();">

<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("firewall_submenu","firewall_submenu_focus","rules_for_schedule","rules_for_schedule_href");</script>
<!-- Main Menu and Submenu End -->

<!-- Right Content start -->
<div class="contentBg">
	<div class="secH1">Parental Control Profile Configuration</div>
	<form name="frmParCtrlConfig" method="post" action="/goform/setUrlProfileConfig">
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>		
		<div class="secInfo">
			<br>The profile consists of the identifier (Profile Name), a short description for what it does, and also the group of computers on the local network to which it applies.  Content filtering will allow you to define internet content to block for the group.  You can also define the time of the day when Internet access is disabled for the group. Be sure to set the system time for this schedule to be effective.
			<br>
			<a class="secLable1" href="rules_for_schedule.asp">>> Back to Rules for Schedule page</a>        												
		</div>
		<div class="secH2">Parental Control Profile Configuration</div>
		<table border="0" cellpadding="0" cellspacing="0" id="tblBwMgmtConfig" class="configTbl">
			<tr>
				<td>Profile Name</td>
				<td><input type="text" name="pctrl.name" id="txtPconfName" size="20" class="configF1" value="" maxlength="31" ></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Description</td>
				<td>
					<textarea rows="2" cols="22" id="txtPconfDesc" name="pctrl.descr" class="configF1" maxlength="128"></textarea></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Group</td>
				<td>
				<select name="pctrl.group" id="pctrl.group" class="configF1" size="1">				    
				    <option value="admin">admin</option>				    
				    <option value="guest">guest</option>				    
				</select>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Enable Content Filtering</td>
				<td>
					<input type="checkbox" name="pctrl.enable_filter_content"  value="0" id="chkEnbFilterCnt" onclick="filterCntCheck()">				
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Filter Content</td>
				<td>
					<select name="pctrl.filter_content" class="configF1" size="1" id="selOptFlCnt" style="width:245;">
						<%getFltrList();%>									
					</select>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Restrict Internet Access Time</td>
				<td>
					<input type="checkbox" name="pctrl.restrict_internet_access"  value="0" id="chkEnbRIAT" onclick="intAccessCheck()">
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Internet Access Schedule</td>
				<td>
					<select name="pctrl.schedule" class="configF1" size="1" id="selOptInternet" style="width:245;">
						<%getScheduleTable("parental");%>				
				    </select>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Session Timeout</td>
				<td><input type="text" name="pctrl.session_timeout" value="" id="txtSsTime" size="5" class="configF1" maxlength="3" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 1, 999, true, 'Invalid Session Timeout: ', 'minutes');}">
				<span class="spanText">minutes</span>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Inactivity Timeout</td>
				<td><input type="text" name="pctrl.inactivity" value="" id="txtInacty" size="5" class="configF1" maxlength="3" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 1, 999, true, 'Invalid Inactive Timeout: ', 'minutes');}">
				<span class="spanText">minutes</span>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" value="Apply" class="submit" name="button.config.parentalConf.schedules.-1" title="Apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return pageValidate()">
			<input type="button" value="Reset" class="submit" title="Reset" onclick="filterCntCheck (); intAccessCheck (); doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
	</div>
	</form>
	<!-- Section End -->
</div>
<!-- contentBg End -->



</div>
</body>
</html>
