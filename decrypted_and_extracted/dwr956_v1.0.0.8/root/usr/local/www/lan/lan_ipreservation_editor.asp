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

	var mac_addr=document.getElementById("mac_address");
	var ip_addr=document.getElementById('ip_address');

	var mac_rule=/[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}/;
	var ip_rule=/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
	var ip_check_rule=/^((\d)|(([1-9])\d)|(1\d\d)|(2(([0-4]\d)|5([0-5]))))\.((\d)|(([1-9])\d)|(1\d\d)|(2(([0-4]\d)|5([0-5]))))\.((\d)|(([1-9])\d)|(1\d\d)|(2(([0-4]\d)|5([0-5]))))\.((\d)|(([1-9])\d)|(1\d\d)|(2(([0-4]\d)|5([0-5]))))$/;
	if(mac_addr.value == "")
	{
		alert(gettext("MAC address can't be empty."));
		return false;
	} else {
		if(!mac_rule.test(mac_addr.value)){
			var msg = mac_addr.value+ " " + gettext("format is illegal.");
			alert(msg);
			return false;
		}
	}
	if(ip_addr.value == "")
	{
		alert(gettext("IP address can't be empty."));
		return false;
	}
	else
	{
		if(!ip_rule.test(ip_addr.value))
		{
			var msg = ip_addr.value+ " " + gettext("format is illegal.");
			alert(msg);
			return false;
		}
		if(!ip_check_rule.test(ip_addr.value))
		{
			var msg = ip_addr.value+ " " + gettext("format is illegal.");
			alert(msg);
			return false;
		}
	}

	return true;
}

function lan_ipreservation_editor_init()
{
	var IpRelConfig = <%getDhcpReservationConfig();%>;
	var IpRelConfigArr;
	if (IpRelConfig!="")
	{
		IpRelConfigArr = IpRelConfig.split("#");
		document.getElementById("mac_address").value=IpRelConfigArr[0];
		document.getElementById("ip_address").value=IpRelConfigArr[1];
	}
	else
	{
		document.getElementById("mac_address").value="";
		document.getElementById("ip_address").value="";
	}
	return;
}
</script>
</head>

<body onload="lan_ipreservation_editor_init();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("lan");%>
<script type="text/javascript">menuChange("lan_menu");leftSubMenuChange("dhcp_submenu","dhcp_submenu_focus","lan_ipreservation","lan_ipreservation_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("DHCP Reservation Configuration"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br><script>document.write(gettext("In this section you can bind the local computers MAC address to a preferred IP address. The configured rule is displayed in the Reserved IP table. This will ensure that whenever this computer is connected to the local network it will be assigned this IP address from this gateway."));</script>
		<br>
		<a class="secLable1" href="lan_ipreservation.asp">&#187; <script>document.write(gettext("Back to DHCP Reservation page"));</script></a>
		</div>
  <form name="ip_reservation_list" method="post" action="/goform/setDhcpReservationConfig">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("MAC Address"));</script></td>
				<td>
				<input type="text" name="mac_address" value="" id="mac_address" size="20" class="configF1" maxlength="17">
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("IP Address"));</script></td>
				<td>
				<input type="text" name="ip_address" value="" id="ip_address" size="20" class="configF1" maxlength="15" onkeypress="return keypress_ip_format(event)">
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
