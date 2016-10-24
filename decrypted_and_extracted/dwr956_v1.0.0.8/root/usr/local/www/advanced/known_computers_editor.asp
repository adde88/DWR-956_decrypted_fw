<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="JavaScript" src="../js/textValidations.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/ipv4AddrValidations.js" type="text/javascript"></script>
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);

function checkIpAddr (thisObj, ipStr, alertStr)
{
	var thisObjVal = thisObj.value;
	var i18n_invalidIPAddr = 'Invalid IP Address.';
	var i18n_forOctet = 'for octet ';	
	if(thisObjVal.indexOf('.') != -1)
	{
		if(ipStr == 'IP')
		{
			if( ipv4Validate (thisObj.id, 'IP', false, true, i18n_invalidIPAddr, i18n_forOctet, true) == false)
			{
				thisObj.focus();
				return false;
			}
			else
				return true;
		}
	}	
	alert(alertStr);
	thisObj.focus();
	return false;
}

function pageValidate()
{	
	if(!CheckLoginInfo())
		return false;
	var txtFieldIdArr = new Array ();	
	txtFieldIdArr[0] = "host_name,Please enter valid Computer Name";	
	txtFieldIdArr[1] = "ip_address,Please enter valid IP Address";	
	if (txtFieldArrayCheck (txtFieldIdArr) == false)		
		return false;
	if (checkCommonNameField('host_name', "Computer Name", "Only allow to input [a-z], [A-Z], [0-9], '_', '-', '.' and '@' characters.") == false) 	 
		return false; 
	var ipAddrObj = document.getElementById('ip_address');	
	if (ipAddrObj.value=="<%getLanBasic("IpAddress");%>")
	{
		alert(gettext("Please enter valid IP Address.\nRouter IP Address is not allowed."));
		return false;
	}
	if (checkIpAddr(ipAddrObj, 'IP', 'Please enter valid IP Address') == false) 
		return false;	
	return true;	
}

function pageLoad()
{
	var HostConfig = <%getHostConfig();%>;
	var HostConfigArr;
	if (HostConfig!="")
	{
		document.getElementById("host_name").disabled = true;
		HostConfigArr = HostConfig.split("#");
		document.getElementById("host_name").value=HostConfigArr[0];
		document.getElementById("ip_address").value=HostConfigArr[1];
	}
	else
	{
		document.getElementById("host_name").disabled = false;
		document.getElementById("host_name").value="";
		document.getElementById("ip_address").value="";		
	}
}
</script>
</head>	

<body onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("firewall_submenu_focus", "firewall_submenu_focus_href");leftSubMenuChange("firewall_submenu","firewall_submenu_focus","known_computers","known_computers_href");</script>
<!-- Main Menu and Submenu End -->


<!-- Add new known computer -->
<div class="contentBg">
	<div class="secH1">Known Computer Configuration</div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="secInfo">
			<br>In this section you can assign an IP address to a hostname.
			<br>
			<a class="secLable1" href="known_computers.asp">>> Back to Known Computers page</a>        			
		</div>
		<form name="frmKnownCompConfig" method="post" action="/goform/setHostConfig">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td>Computer Name</td>
				<td>
				<input type="text" name="host_name" value="" id="host_name" size="30" class="txtbox" maxlength="32">
				</td>
			</tr>
			<tr>
				<td>IP Address</td>
				<td>
				<input type="text" name="ip_address" value="" id="ip_address" size="30" class="txtbox" maxlength="15" onkeypress="return keypress_ip_format(event)">
				</td>
			</tr>
		</table>
		<div>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="blank1" height="30">&nbsp;</td>
				</tr>
			</table>
		</div>
		<div class="submitBg">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><input type="submit" value="Apply" class="submit" title="Apply" onclick="return pageValidate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>
					<td><input type="button" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>
				</tr>
			</table>
		</div>
		</form>

	</div>
	<!-- Section End -->
</div>

</div> <!-- End of all -->
</body>
</html>
