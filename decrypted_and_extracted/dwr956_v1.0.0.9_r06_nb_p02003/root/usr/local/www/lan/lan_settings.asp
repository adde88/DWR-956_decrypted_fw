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

var dhcp_ipStart;
var dhcp_ipEnd;
var dhcp_enable;
function getLanInfo()
{
  var SubnetMask = "<%getLanBasic("SubnetMask");%>";

  switch (SubnetMask)
  {
        case "255.255.255.0":
            document.getElementById("lan_submask").selectedIndex=0;
            break;
        case "255.255.255.128":
            document.getElementById("lan_submask").selectedIndex=1;
            break;
        case "255.255.255.192":
            document.getElementById("lan_submask").selectedIndex=2;
            break;
        case "255.255.255.224":
            document.getElementById("lan_submask").selectedIndex=3;
            break;
        case "255.255.255.240":
            document.getElementById("lan_submask").selectedIndex=4;
            break;
        case "255.255.255.248":
            document.getElementById("lan_submask").selectedIndex=5;
            break;
        case "255.255.255.252":
            document.getElementById("lan_submask").selectedIndex=6;
            break;
        default:
	        break;
  }
  dhcp_ipStart = "<%getDhcpServBasic("StartIpAddress","DhcpServerBasic");%>";
  dhcp_ipEnd = "<%getDhcpServBasic("EndIpAddress","DhcpServerBasic");%>";
  dhcp_enable = <%getDhcpServBasic("Enable","DhcpServerBasic");%>;
}

function pageValidate()
{
	if(!CheckLoginInfo())
		return false;

	var lanip = document.getElementById("lan_ip").value;
	var IpArr = lanip.split(".");
	var DHCP_IpStartArr = dhcp_ipStart.split(".");
	var DHCP_IpEndArr = dhcp_ipEnd.split(".");

	var loacl_ip_rule=/^(127)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-4]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])$/;
	var ip_rule=/^(2[0-2][0-3]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-4]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])$/;

	if(lanip == "")
	{
		alert(gettext("IP Address can't be empty."));
		document.LAN_BASIC.lan_ip.focus();
		return false;
	}

	//can not input "0.0.0.0" "127.x.x.x"
	if(lanip=="0.0.0.0" || lanip=="127.0.0.0" || loacl_ip_rule.test(lanip)){
		alert("\"0.0.0.0\"...\"127.0.0.0\"...\"127.x.x.x\""+gettext(" is illegal."));
		document.LAN_BASIC.lan_ip.focus();
		return false;
	}

	//check IP is illegal
	if(!ip_rule.test(lanip)){
		alert(gettext("IP Address is illegal."));
		document.LAN_BASIC.lan_ip.focus();
		return false;
	}

	if ((IpArr[2] == "000") || (IpArr[3] == "000")){
		alert(gettext("IP Address is illegal."));
		document.LAN_BASIC.lan_ip.focus();
		return false;
	}

	if(lanip != "")
	{
		var ip = parseInt(IpArr[3],10);
		var ip_start = parseInt(DHCP_IpStartArr[3]);
		var ip_end = parseInt(DHCP_IpEndArr[3]);
		if ( ip >= ip_start && ip <= ip_end )
		{
		    alert(gettext("Device IP Address should not be between DHCP Starting Address and Ending Address."));
		    document.LAN_BASIC.lan_ip.focus();
		    return false;
		}
	}

	var lan_hostname=document.getElementById("lan_hostname").value;
	if(lan_hostname == "")
	{
		alert(gettext("Host Name can't be empty."));
		return false;
	}
	if (checkCommonNameField('lan_hostname', gettext("Host Name")) == false) return false;

 if (checkDotChar(lan_hostname) == false) {
   alert(gettext("Invalid Host Name"));
   return false;
 }

 var netmask = document.getElementById("lan_submask").selectedIndex;
 if (netmask == 1) netmask = 128;
 else if (netmask == 2) netmask = 192;
 else if (netmask == 3) netmask = 224;
 else if (netmask == 4) netmask = 240;
 else if (netmask == 5) netmask = 248;
 else if (netmask == 6) netmask = 252;
 else netmask = 0;

 if (calIPPoolRange(parseInt(IpArr[3]), netmask, parseInt(DHCP_IpStartArr[3]), parseInt(DHCP_IpEndArr[3])) == false)
 {
  if (confirm(gettext("LAN IP Address conflict with DHCP range, are you sure?"))) {
  } else {
    return false;
  }
 }
 alert(gettext("The LAN connection will disconnect. Please wait about 30 seconds and connect to the device again."));
	return true;
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

function checkDotChar(elem)
{
 if (elem.charCodeAt(elem.length-1) == 46)
   return false;
 return true;
}
</script>
</head>

<body onload="getLanInfo();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("lan");%>
<script type="text/javascript">menuChange("lan_menu");leftMenuChange("lan_settings", "lan_settings_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("LAN Settings"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br><script>document.write(gettext("In this section you can configure the TCP/IP details for the LAN. Settings on this page affect all devices connected to the router's LAN including wireless LAN clients. Note that changing the LAN IP address will require all connected LAN hosts to be in the same subnet and use the new LAN address to access this management GUI."));</script>
		<br>
		</div>
		<form name="LAN_BASIC" action="/goform/setLanInfoValue" method="post">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("IP Address"));</script></td>
				<td><input class="configF1" id="lan_ip" name="lan_ip" type="text" size="20" maxlength="15" value="<%getLanBasic("IpAddress");%>" /></td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Subnet Mask"));</script></td>
				<td>255.255.255.
     <select name="lan_submask" id="lan_submask" class="configF1">
       <option value="255.255.255.0">0
       <option value="255.255.255.128">128
       <option value="255.255.255.192">192
	      <option value="255.255.255.224">224
	      <option value="255.255.255.240">240
	      <option value="255.255.255.248">248
	      <option value="255.255.255.252">252
      </select>
     </td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Host Name"));</script></td>
				<td><input class="configF1" id="lan_hostname" name="lan_hostname" type="text" size="20" maxlength="32" value="<%getLanBasic("hostname");%>" /></td>
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
