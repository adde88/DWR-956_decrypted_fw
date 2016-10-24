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
var nat_enable=<%getFwNatEnable();%>;
if(nat_enable!="1")
{
	window.location.href="../login.asp";
}

var portid = 0;
var click_flag="";
var temp_service;
var temp_ip;
var temp_port;
var temp_enable;
var ip_rule=/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;

function setPortEditRowId(id)
{
    var port_ck_id = "port_ck_" + id;
    if( document.getElementById(port_ck_id).checked)
    {
        portid=id;
        document.getElementById('port_rowid_del').value=id;
        document.getElementById('port_rowid_edit').value=id;
    }
    else
    {
        portid=0;
        document.getElementById('port_rowid_del').value=0;
        document.getElementById('port_rowid_edit').value=id;
    }
}

function PortForwardInit()
{
	var PortFwd = <%getPortFwd();%>;
	var PortFwdArr;
	if (PortFwd!="")
	{
		PortFwdArr = PortFwd.split("#");
	    document.getElementById('selPortservice').value = PortFwdArr[0];
		document.getElementById('txtIPAddr').value = PortFwdArr[1];
		if(PortFwdArr[2] == "1")
			document.getElementById('chkEnbPort').checked=true;
		else
			document.getElementById('chkEnbPort').checked=false;
		document.getElementById('txtport1').value = PortFwdArr[3];
	}
	else
	{
		
	}
}

function servicechk()
{
    var selOptVal = comboSelectedValueGet ('selPortservice');
    if (!selOptVal) return;
    switch (parseInt(selOptVal, 10))
    {
        case -1: /* Clickable for Add NEW Service */
            fieldStateChangeWr ('', '', 'AddNewServce', '');
            break;
        default:
            fieldStateChangeWr ('AddNewServce', '', '', '');
    }
}

function pageValidate ()
{
	if(!CheckLoginInfo())
		return false;
	if (numericValueRangeCheck (document.getElementById ('txtport1'), '', '', 1, 65535, true, 'Invalid Port Range.', '') == false)
		return false;
	var ipAddrObj = document.getElementById('txtIPAddr');
	if (checkIpAddr (ipAddrObj, 'IP', "Please enter valid IP Address") == false ) return false;
	if(document.getElementById('selPortservice').value == "-1")
	{
		alert(gettext("Failed to add rule. Please select service from provided list or if you have selected other for service, add a service by clicking Add Application."));
		return false;
	}
	return true;
}

function checkIpAddr (thisObj, ipStr, alertStr)
{
	var thisObjVal = thisObj.value;
	var i18n_invalidIPAddr = 'Invalid IP Address.';
	var i18n_forOctet = 'for octet ';
	var i18n_invalidSubnet = 'Invalid Subnet Mask.';
	
	if(thisObjVal.indexOf('.') != -1)
	{
		if(ipStr == 'IP')
		{
			if( ipv4Validate (thisObj.id, 'IP', false, true,i18n_invalidIPAddr, i18n_forOctet, true) == false)
			{
				thisObj.focus();
				return false;
			}
			else
				return true;
		}
	}	
	alert(gettext(alertStr));
	thisObj.focus();
	return false;
}

function chkEnbport()
{
	if (document.getElementById('chkEnbPort').checked)
	{
		fieldStateChangeWr ('','','txtport1','');
	}
	else
	{
		fieldStateChangeWr ('txtport1','','','');
	}
}

function RedirectToSpecialApp()
{
	if(document.getElementById('selPortservice').value == "-1")
	{
		window.location.href="special_apps_editor.asp";
	}
}

</script>
</head>

<body onload="PortForwardInit();chkEnbport();servicechk();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("nat_portforwarding", "nat_portforwarding_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg" id="sub_forwarding">
	<div class="secH1">Port Forwarding</div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
			<br>This page allows you to to use a custom port for services run on local network computers.  The rules configured here allow this service to bypass the default security mode.
			<br>
		</div>
		<form name="port_fwd" method="post" action="/goform/setPortFwd">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td>Service</td>
                <td>
                    <select size="1" name="service" id="selPortservice" class="configF1" onchange="return servicechk();" style="width:182px;">
                    <%getSpecialAppsServiceName();%>
				</select>
				</td>
				<td>
				<input type="button" class="tblbtn" value="Add Application" name="" onclick="RedirectToSpecialApp();" id="AddNewServce" title="Add Application" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">
				</td>
			</tr>
			<tr>
				<td>IP Address</td>
				<td>
				<input type="text" name="ip_address" value="" id="txtIPAddr" size="30" class="txtbox" maxlength="39" >
<!--				onkeypress="return numericValueCheck (event, 'ABCDEFabcdef:.')" onkeydown="if (event.keyCode == 9) {return checkIpAddr (this, 'IP', '$| trStrings["20216"] or 'i18nHTMLMissing' |$'); }">-->
			   </td>				    														
			</tr>
			<tr>
				<td>Enable Port Translation</td>
				<td><input type="checkbox" name="enable_port_translation"  id="chkEnbPort" value="1" onclick="return chkEnbport();">
				<td></td>
			</tr>
			<tr>
				<td>Port</td>
				<td><input type="text" name="port" value="" size="5" class="configF1" id="txtport1" maxlength="5" /></td>
<!--				onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 1, 65535, true, '$| trStrings["20111"] or 'i18nHTMLMissing' |$:', '');}" /></td>-->
				<td></td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" value="Apply" class="submit" title="Apply" name="" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return pageValidate ();">
			<input type="button" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
		</form>
	</div>
	<!-- Section End -->
</div>
</div>
</body>
</html>

