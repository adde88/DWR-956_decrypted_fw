<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

function UpnpPortInit()
{
	var enabled = <%getUpnpPortEnable();%>;
	if (enabled == 1) {
	  document.getElementById('enable_upnp').checked = true;
	} else {
	  document.getElementById('enable_upnp').checked = false;
	}
}

function setRefresh()
{
	if(!CheckLoginInfo("ResetPage"))
		return false;
	document.upnp_list.action="/goform/setUpnpListRefresh";
	document.upnp_list.submit();
	return true;	
}

function setClear()
{
	if(!CheckLoginInfo())
		return false;
	document.upnp_list.action="/goform/setUpnpListClear";
	document.upnp_list.submit();
	return true;	
}

function checkApply()
{
	if(!CheckLoginInfo())
		return false;
	return true;
}
</script>
</head>

<body onload="UpnpPortInit();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("nat_submenu","nat_submenu_focus","upnp_port","upnp_port_href");</script>
<!-- Main Menu and Submenu End -->
<div class="contentBg">
<div class="secH1">UPnP Port Mapping</div>
<!-- Section Begin -->
	<div class="secBg">
	<div class="statusMsg"></div>
	<div class="secH2">UPnP Settings</div>
  
	
	<form name="upnp_setting" method="post" action="/goform/setUpnpEnable">
		<input type="hidden" name="enable_upnp__dummy" />
		<table border="0" cellpadding="0" cellspacing="0" class="configTbl">
			<tr>
				<td>&nbsp;</td>
				<td><input type="checkbox" id="enable_upnp" name="enable_upnp">
				<input type="hidden" name="table.enable" value="0">
				</td>
				<br>
				<td>Turn UPnP On</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" value="Apply" class="submit" title="Apply" onclick="return checkApply();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
	</form>
	<table border="0" cellpadding="0" cellspacing="0" class="configTbl">
		<tr>
			<td class="secBot">&nbsp;</td>
		</tr>
	</table>

	<div class="secH2">UPnP Portmap Table</div>
	<form name="upnp_list" action="/goform/setUpnpList" method="post">
	<input type="hidden" name="upnp_list_dummy" value="0">
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="secMid">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td class="tdH">Active</td>
					<td class="tdH">Protocol</td>
					<td class="tdH">Internal Port</td>
					<td class="tdH">External Port</td>
					<td class="tdH">IP Address</td>
				</tr>
				<tbody><%getUpnpPortList();%></tbody>  
			</table>
			</td>
		</tr>
		<tr>
			<td class="secBot">&nbsp;</td>
		</tr>
		<tr>
			<td>
				<div class="submitBg">
				<form method="post" action="platform.cgi">
					<input type="hidden" name="thispage" value="upnpPortMapping.htm">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="submit" value="Refresh Table" class="submit" title="Refresh Table" onclick="return setRefresh();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>
							<td><input type="submit" value="Clear Table" class="submit" title="Clear Table" onclick="return setClear();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>							
						</tr>
					</table>
				</form>
				</div>
			</td>
		</tr>
		<!--
		<tr>
		<td class="blank1" height="48">&nbsp;</td>
		</tr>
		-->
	</table>
	</form>
</div>
<!-- Section End -->
</div>
<!-- Content Bg End -->



</div><!-- all end -->
</body>
</html>
