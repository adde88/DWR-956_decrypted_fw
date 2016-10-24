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
function pageValidate()
{
	if(!CheckLoginInfo())
		return false;
	var mac_rule = /[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}/;
	var acl_mac_address = document.getElementById("aclMacAddress").value;
	if(acl_mac_address == "")
	{
		alert(gettext("MAC Address can't be empty."));
		return false;
	}
	if(!mac_rule.test(acl_mac_address))
	{
   var msg = acl_mac_address + " " + gettext("format is illegal.");
		alert(msg);
		document.wifi_acl_editor.aclMacAddress.focus();
		return false;
	}

	return true;
}

function wifi_acl_editor_init()
{
	var ACLConfig = <%getWifiACLConfig();%>;
	if (ACLConfig == "-1")
	{
			//window.location.href="../wifi/wifi_settings.asp";
			return;
	}
	document.getElementById("aclMacAddress").value="";
}
</script>
</head>

<body onload="wifi_acl_editor_init();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftMenuChange("wifi_settings", "wifi_settings_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("MAC Filter Configuration"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br /><a class="secLable1" href="wifi_settings.asp">&#187; <script>document.write(gettext("Back to Wi-Fi Settings page"));</script></a>
		<br />
		</div>
  <form name="wifi_acl_editor" method="post" action="/goform/setWifiACLConfig">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("MAC Address"));</script></td>
				<td>
				<input type="text" name="aclMacAddress" id="aclMacAddress" value="" size="20" maxlength="17" class="configF1" />
				</td>
			</tr>
		</table>
		<div>
			<input type="submit" value="Apply" class="submit" id="button.apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return pageValidate();" />
			<input type="button" value="Reset" class="submit" id="button.reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();" />
		</div>
	 </form>
	</div>
</div>
</div>

<script type="text/javascript">
 document.getElementById('button.apply').value = gettext("Apply");
 document.getElementById('button.reset').value = gettext("Reset");
</script>

</body>
</html>
