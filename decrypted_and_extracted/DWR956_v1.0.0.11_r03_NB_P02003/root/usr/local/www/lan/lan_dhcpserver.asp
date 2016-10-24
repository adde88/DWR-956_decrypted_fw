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

var router_ip="<%getLanBasic("IpAddress");%>";
var router_ip_arr = router_ip.split(".");
var router_ip_arr3 = parseInt(router_ip_arr[3],10);
var router_mask = "<%getLanBasic("SubnetMask");%>";
var router_mask_arr = router_mask.split(".");
var router_mask_arr3 = parseInt(router_mask_arr[3],10);
function pageValidate()
{
	if(!CheckLoginInfo())
		return false;

	var num_devices=document.getElementById("num_devices").value;
	var dhcp_ip_start=document.getElementById('dhcp_ip_start').value;

	if(num_devices == "")
	{
		alert(gettext("DHCP range can't be empty."));
		return false;
	}

	if(dhcp_ip_start == "")
	{
		alert(gettext("DHCP Start IP Address can't be empty."));
		return false;
	}

	var ip_range = parseInt(num_devices, 10);
	var ip_start = parseInt(dhcp_ip_start, 10);

	if ((ip_range < 1) || (ip_range > 254) || isNaN(ip_range))
	{
	   alert(gettext("DHCP range should be between 1 and 254."));
	   document.getElementById("num_devices").focus();
	   return false;
	}

	if ((ip_start < 1) || (ip_start > 254) || isNaN(ip_start))
	{
	   alert(gettext("DHCP Start IP Address should be between 1 and 254."));
	   document.getElementById("dhcp_ip_start").focus();
	   return false;
	}

	if ((ip_start + ip_range - 1) <= 254)
	{
	} else {
	   alert(gettext("Invalid DHCP IP Pool. DHCP Start IP Address plus DHCP range then minus 1 should be no more than 254."));
	   return false;
	}

	if ((router_ip_arr3 >= ip_start) && (router_ip_arr3 <= (ip_start + ip_range - 1)))
	{
		alert(gettext("DHCP IP Address range should not contain device IP Address."));
		return false;
	}

 if (calIPPoolRange(router_ip_arr3, router_mask_arr3, ip_start, (ip_start + ip_range - 1)) == false)
 {
  if (confirm(gettext("DHCP range conflicts with LAN IP Address, are you sure?"))) {
  } else {
    return false;
  }
 }
 alert(gettext("The LAN connection will disconnect. Please wait about 30 seconds and connect to the device again."));
	return true;
}

function DHCPserverInit()
{
  var EnValue = <%getDhcpServBasic("Enable","DhcpServerBasic");%>;
  var StartIpAddress = "<%getDhcpServBasic("StartIpAddress","DhcpServerBasic");%>";
  var IpStart = StartIpAddress.split(".");
  document.getElementById('num_devices').value = <%getDhcpServBasic("Range","DhcpServerBasic");%>;

		if (IpStart[3] == "0")
    document.getElementById("dhcp_ip_start").value = "";
  else
    document.getElementById("dhcp_ip_start").value = IpStart[3];

  if(EnValue == 0)
		{
			document.getElementById("num_devices").disabled = true;
			document.getElementById("dhcp_ip_start").disabled = true;
		} else if(EnValue == 1) {
			document.getElementById("num_devices").disabled = false;
			document.getElementById("dhcp_ip_start").disabled = false;
		}
		return;
}

function calIPPoolRange(ipaddr, netmask, pool_s, pool_e)
{
 var x = ipaddr.toString(2);
 var y = netmask.toString(2);
 var z = parseInt(x, 2) & parseInt(y, 2);

 if ((((z+1) <= pool_s) && (pool_s <= pool_e) && (pool_e <= (z+(255-netmask)-1)))
  || ((pool_s <= (z+1)) && ((z+1) <= (z+(255-netmask)-1)) && ((z+(255-netmask)-1) <= pool_e)))
 {
 	return true;
 } else {
 	return false;
 }
}
</script>
</head>
<body onload="DHCPserverInit();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("lan");%>
<script type="text/javascript">menuChange("lan_menu");leftSubMenuChange("dhcp_submenu","dhcp_submenu_focus","lan_dhcpserver","lan_dhcpserver_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Basic"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secH2"><script>document.write(gettext("IPv4 Address Distribution"));</script></div>
		<div class="secInfo">
		<br><script>document.write(gettext("The local network has a DHCP server to offer IP address leased to connected devices. The range defined here will apply to wired and wireless clients in your local network."));</script>
		<br>
		</div>
		<form name="dhcp_server" action="/goform/setDhcpServBasic" method="post">
		<table cellspacing="0" class="configTbl">
			<tr>
    	<td><script>document.write(gettext("Specify the number of devices/computers in your network"));</script></td>
    	<td>
    		<input type="text" class="configF1" id="num_devices" name="num_devices" size="6" maxlength="3" onkeypress="return onkeypress_number_only(event)" />
    	</td>
			</tr>
   <tr>
     <td><script>document.write(gettext("Start IP distribution from"));</script></td>
     <td>
      <%getLanIpPrefix();%>
      <input class="configF1" type="text" id="dhcp_ip_start" name="dhcp_ip_start" size="2" maxlength="3" onkeypress="return onkeypress_number_only(event)" />
     </td>
   </tr>
		</table>
		<div>
			<input type="submit" value="Apply" class="submit" title="Apply" id="button.apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return pageValidate();" />
			<input type="button" value="Reset" class="submit" title="Reset" id="button.reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();" />
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
