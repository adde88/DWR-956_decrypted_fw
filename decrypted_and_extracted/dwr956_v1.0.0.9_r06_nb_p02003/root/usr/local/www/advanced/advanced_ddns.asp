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

function dnsValidate()
{
	if(!CheckLoginInfo())
		return false;
	var system_name = document.getElementById("system_name").value;
 if(system_name == "")
 {
   alert(gettext("System Name can't be empty."));
   return false;
 }
 if (checkCommonNameField('system_name', gettext("System Name")) == false) return false;

 if (checkDotChar(system_name) == false) {
   alert(gettext("Invalid System Name"));
   return false;
 }

 var domain_name = document.getElementById('domain_name').value;
 if(domain_name == "")
 {
   alert(gettext("Domain Name can't be empty."));
   return false;
 }
 if (checkCommonNameField('domain_name', gettext("Domain Name")) == false) return false;

 if (checkDotChar(domain_name) == false) {
   alert(gettext("Invalid Domain Name"));
   return false;
 }

 var dns_description = document.getElementById('description').value;
 if (dns_description.length > 0)
 {
   if(dns_description.length > 64)
   {
     alert(gettext("The maximum length of Description is 64."));
     return false;
   }
   if (checkDescriptionField('description', gettext("Description")) == false) return false;
 }
 alert(gettext("The LAN connection will disconnect. Please wait about 30 seconds and connect to the device again."));
 return true;
}

function ddnsValidate()
{
	if(!CheckLoginInfo())
		return false;
	var selDDNS = document.getElementById("selDDNSService").value;
 if (selDDNS == "none") {
  return true;
 }

	var ddns_domain_name = document.getElementById("ddns_domain_name").value;
 if(ddns_domain_name == "")
 {
   alert(gettext("Domain Name can't be empty."));
   return false;
 }
 if (checkCommonNameField('ddns_domain_name', gettext("Domain Name")) == false) return false;

 var ddns_username = document.getElementById('ddns_username').value;
 if(ddns_username == "")
 {
   alert(gettext("Username can't be empty."));
   return false;
 }
 if (checkCommonNameField('ddns_username', gettext("Username")) == false) return false;

 var ddns_password = document.getElementById('ddns_password').value;
 if(ddns_password == "")
 {
   alert(gettext("Password can't be empty."));
   return false;
 }
 if (checkCommonNameField('ddns_password', gettext("Password")) == false) return false;

 return true;
}

function pageValidate()
{
	if(!CheckLoginInfo())
		return false;
	if (dnsValidate() == false) return false;
	if (ddnsValidate() == false) return false;
	return true;
}

function ddns_select_other()
{
 document.getElementById("ddns_domain_name").disabled = false;
 document.getElementById("ddns_username").disabled = false;
 document.getElementById("ddns_password").disabled = false;
 document.getElementById("ddns_use_wildcards").disabled = false;
 document.getElementById("ddns_update_period").disabled = false;
	return;
}

function ddns_select_none()
{
 document.getElementById("ddns_domain_name").disabled = true;
 document.getElementById("ddns_username").disabled = true;
 document.getElementById("ddns_password").disabled = true;
 document.getElementById("ddns_use_wildcards").disabled = true;
 document.getElementById("ddns_update_period").disabled = true;
	return;
}

function selectDDNSService()
{
	var selDDNS = document.getElementById("selDDNSService").value;
 if (selDDNS == "none") {
   ddns_select_none();
 } else {
   ddns_select_other();
 }
 return;
}

function advanced_ddns_init()
{
 var ddnsInfo = <%getDDNSInfo();%>;
 var ddnsInfoArr = ddnsInfo.split("#");
 document.getElementById("selDDNSService").value = ddnsInfoArr[0];

 if (ddnsInfoArr[0] == "none") {
   ddns_select_none();
 } else {
   ddns_select_other();
 }
 document.getElementById("ddns_domain_name").value = ddnsInfoArr[1];
 document.getElementById("ddns_username").value = ddnsInfoArr[2];
 document.getElementById("ddns_password").value = ddnsInfoArr[3];

 if (ddnsInfoArr[4] == "1") {
   document.getElementById("ddns_use_wildcards").checked = true;
 } else {
 	 document.getElementById("ddns_use_wildcards").checked = false;
 }
 if (ddnsInfoArr[5] == "1") {
   document.getElementById("ddns_update_period").checked = true;
 } else {
 	 document.getElementById("ddns_update_period").checked = false;
 }

 return;
}

function advanced_dns_init()
{
 var dnsInfo = <%getDNSInfo();%>;
 var dnsInfoArr = dnsInfo.split("#");
 document.getElementById("system_name").value = dnsInfoArr[0];
 document.getElementById("domain_name").value = dnsInfoArr[1];
 document.getElementById("description").innerHTML = dnsInfoArr[2];
 return;
}

function checkDotChar(elem)
{
 if (elem.charCodeAt(elem.length-1) == 46)
   return false;
 return true;
}
</script>
</head>

<body onload="advanced_dns_init();advanced_ddns_init();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("advanced_ddns", "advanced_ddns_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("DNS & DynDNS"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secH2"><script>document.write(gettext("Domain Name Server (DNS) Address"));</script></div>
		<div class="secInfo">
		<br /><script>document.write(gettext("Domain Name Server (DNS), in this page you can define the system name and domain name of this gateway for DNS resolution."));</script>
  <br />
		</div>
		<form name="advanced_ddns_1" method="post" action="/goform/setDNSInfo">
  <table cellspacing="0" class="configTbl">
    <tr>
     <td><script>document.write(gettext("System Name"));</script></td>
     <td>
      <input type="text" name="system_name" id="system_name" value="" size="20" class="configF1" maxlength="32" />
     </td>
    </tr>
    <tr>
      <td><script>document.write(gettext("Domain Name"));</script></td>
      <td>
       <input type="text" name="domain_name" id="domain_name" value="" size="20" class="configF1" maxlength="32" />
      </td>
    </tr>
    <tr>
      <td><script>document.write(gettext("Description"));</script></td>
      <td><textarea name="description" id="description" rows="2" class="configF1" maxlength="64"></textarea></td>
    </tr>
  </table>
		<div>
			<input type="submit" value="Apply" class="submit" id="button.dns.apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return dnsValidate();" />
			<input type="button" value="Reset" class="submit" id="button.dns.reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();" />
		</div>
	 </form>
  <br />
  <div class="secH2"><script>document.write(gettext("DDNS (Dynamic DNS) Settings"));</script></div>
  <div class="secInfo">
  <br /><script>document.write(gettext("Dynamic DNS (DDNS) is an Internet service that allows routers with varying public IP addresses to be located using Internet domain names. To use DDNS, you must setup an account with a DDNS provider such as DynDNS.org and set the required account details on this page."));</script>
  <br />
  </div>
  <form name="advanced_ddns_2" method="post" action="/goform/setDDNSInfo">
  <table cellspacing="0" class="configTbl">
    <tr>
     <td><script>document.write(gettext("Select the Dynamic DNS Service"));</script></td>
     <td>
       <select name="selDDNSService" size="1" class="configF1" id="selDDNSService" onchange="selectDDNSService();">
         <option value="none">None</option>
         <option value="dyndns">dyndns</option>
         <option value="qdns">DDNS 3322</option>
         <option value="dlink">D-Link</option>
         <option value="noip">no-ip</option>
         <option value="dtdns">DtDNS</option>
       </select>
     </td>
    </tr>
  </table>
  <table cellspacing="0" class="configTbl">
    <tr>
     <td><script>document.write(gettext("Domain Name"));</script></td>
     <td><input type="text" name="ddns_domain_name" id="ddns_domain_name" value="" size="20" maxlength="64" class="configF1" /></td>
    </tr>
    <tr>
     <td><script>document.write(gettext("Username"));</script></td>
     <td><input type="text" name="ddns_username" id="ddns_username" value="" size="20" maxlength="64" class="configF1" /></td>
    </tr>
    <tr>
     <td><script>document.write(gettext("Password"));</script></td>
     <td><input type="password" name="ddns_password" id="ddns_password" value="" size="20" maxlength="64" class="configF1" /></td>
    </tr>
    <tr>
     <td><script>document.write(gettext("Use wildcards"));</script></td>
     <td><input type="checkbox" value="1" name="ddns_use_wildcards" id="ddns_use_wildcards"></td>
    </tr>
    <tr>
     <td><script>document.write(gettext("Update every 30 days"));</script></td>
     <td><input type="checkbox" value="1" name="ddns_update_period" id="ddns_update_period"></td>
    </tr>
  </table>
		<div>
			<input type="submit" value="Apply" class="submit" id="button.ddns.apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return ddnsValidate();" />
			<input type="reset" value="Reset" class="submit" id="button.ddns.reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();" />
		</div>
		</form>
	</div>
</div>
</div>

<script type="text/javascript">
 document.getElementById('button.dns.apply').value = gettext("Apply");
 document.getElementById('button.dns.reset').value = gettext("Reset");
 document.getElementById('button.ddns.apply').value = gettext("Apply");
 document.getElementById('button.ddns.reset').value = gettext("Reset");
</script>

</body>
</html>
