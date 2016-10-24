<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
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
	var securityMode = <%getSecurityConfig();%>;

	if (securityMode == 1)
	{
	    document.getElementById('rdbbasicSecurityHigh').checked = true;
		document.getElementById('rdbbasicSecurityMedium').checked = false;
		document.getElementById('rdbbasicSecurityLow').checked = false;
	}
	else if (securityMode == 2)
	{
	    document.getElementById('rdbbasicSecurityHigh').checked = false;
		document.getElementById('rdbbasicSecurityMedium').checked = true;
		document.getElementById('rdbbasicSecurityLow').checked = false;		
	}
	else 
	{
	    document.getElementById('rdbbasicSecurityHigh').checked = false;
		document.getElementById('rdbbasicSecurityMedium').checked = false;
		document.getElementById('rdbbasicSecurityLow').checked = true;				
	}	
}

function checkApply()
{
	if(!CheckLoginInfo())
		return false;
	return true;
}
</script>
</head>	

<body onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("firewall_submenu_focus", "firewall_submenu_focus_href");leftSubMenuChange("firewall_submenu","firewall_submenu_focus","","");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1">Firewall</div>
	<!-- Section Begin -->
	<form name="frmSecurityLevelConfig" method="post" action="/goform/setSecurityConfig">
	<div class="secBg">
		<div class="statusMsg"><%getActionResult();%></div>
		<div class="secInfo">
			<br>This page displays the firewall security setting of the gateway.  At Maximum Security, all incoming requests from the Internet are blocked by default and the router allows limited Internet destined traffic from leaving the local network. In the Typical Security level, all incoming requests from the Internet are still blocked by default but the computers on the local network can access the Internet without restrictions.  The No Security setting opens the firewall for all traffic to and from the Internet.
			<br>
		</div>
		<div class="secH2">Security Mode Configuration</div>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tdH">Security Level</td>
				<td class="tdH">Requests from the Internet<br>(Incoming Traffic)</td>
				<td class="tdH">Requests from the local network<br>(Outgoing Traffic)</td>
			</tr>
			<tr>
				<td  class="tdOdd"><input type="radio" name="mode"  value="1" id="rdbbasicSecurityHigh"></td>
				<td  class="tdOdd" rowspan="2">Blocked - No access to local network from Internet, except as configured in the Port Forwarding.</td>
				<td  class="tdOdd" rowspan="2">Limited - Only commonly used services, such as FTP, HTTP, HTTPS, DNS, POP, TELNET, IMAP, SMTP, etc.</td>
			</tr>
			<tr>
				<td class="tdOdd">Maximum Security</td>
			</tr>
			<tr>
				<td class="tdEven"><input type="radio" name="mode"  value="2" id="rdbbasicSecurityMedium"></td>
				<td class="tdEven" rowspan="2">Blocked - No access to local network from Internet, except as configured in the Port Forwarding.</td>
				<td class="tdEven" rowspan="2">Unrestricted - All services are permitted, except as configured in the Access Control screen.</td>
			</tr>
			<tr>
				<td class="tdEven">Typical Security</td>
			</tr>
			<tr>
				<td  class="tdOdd"><input type="radio" name="mode"  value="3" id="rdbbasicSecurityLow"></td>
				<td class="tdOdd" rowspan="2">Unrestricted - Permits full access from Internet to local network; all connection attempts permitted.</td>
				<td class="tdOdd" rowspan="2">Unrestricted - All services are permitted, except as configured in the Access Control screen.</td>
			</tr>
			<tr>
				<td class="tdOdd">No Security</td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" value="Apply" name="button.config.firewall" onclick="return checkApply();" class="submit" title="Apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
	</div>
	</form>
	<!-- Section End -->
</div>


</div> <!-- End of all -->
</body>
</html>
