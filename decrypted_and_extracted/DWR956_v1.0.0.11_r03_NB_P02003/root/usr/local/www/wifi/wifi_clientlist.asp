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

function checkApply()
{
	if(!CheckLoginInfo())
		return false;
	return true;
}
</script>
</head>

<body>
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftMenuChange("wifi_clientlist", "wifi_clientlist_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Device List"));</script></div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br /><script>document.write(gettext("Please press [Update] to obtain the device connection list."));</script>
		<br />
		</div>
		<table border="0" cellpadding="0" cellspacing="0">
   <tr>
     <td class="tdH">&nbsp;<script>document.write(gettext("Host Name (if any)"));</script></td>
     <td class="tdH">&nbsp;<script>document.write(gettext("IP Address"));</script></td>
     <td class="tdH">&nbsp;<script>document.write(gettext("MAC Address"));</script></td>
   </tr>
   <%getWiFiClients();%>
		</table>
		<div>
			<form action="/goform/updateClientList" method="post">
   <input type="hidden" name="clientlist" value="0" />
   <input type="hidden" name="url_clientlist" value="wifi" />
			<input type="submit" class="submit" value="Update" id="button.update" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return checkApply();" />
		 </form>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
 document.getElementById('button.update').value = gettext("Update");
</script>

</body>
</html>
