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

var domain = "";
function dmzInit()
{
    var dmzConf = <%getFwDmzConf();%>;
    var strArr = dmzConf.split("#");
	var dmzIp = strArr[1].split(".");
    var IpArr = strArr[2].split(".");
    document.getElementById("dmz_domain").innerHTML = IpArr[0] + "." + IpArr[1] + "." + IpArr[2] + ".";
    domain = IpArr[0] + "." + IpArr[1] + "." + IpArr[2] + ".";
    if (strArr[0] == "1")
    {
        document.getElementById("dmz_enable").checked = true;
        document.getElementById("dmz_ip").disabled=false;
		
		document.getElementById("dmz_ip").value = dmzIp[3];
		
    }
    else
    {
        document.getElementById("dmz_enable").checked = false;
        document.getElementById("dmz_ip").disabled=true;
		document.getElementById("dmz_ip").value = "";
    }
	
	
}
function disableDmzFunc()
{
    if (document.getElementById("dmz_enable").checked == false)
    {
        document.getElementById("dmz_ip").disabled=true;
		document.getElementById('dmz_ip').value = "";
    }
    else
    {
        document.getElementById("dmz_ip").disabled=false;
    }
}
function IpValidation ()
{
	if(!CheckLoginInfo())
		return false;
    var ip_value = document.getElementById("dmz_ip").value;
	var numcheck = /^[0-9]*$/;
	if(document.getElementById("dmz_enable").checked)
	{
		if(ip_value == "")
		{
			alert(gettext("IP address can't be empty"));
			return false;
		}
	    if(!numcheck.test(ip_value))
	    {
	    	alert(gettext ("Invalid IP address format (range in 2~254)"));
	        return false;
	    }
	    if (((ip_value < 2) || (ip_value > 254)) && (document.getElementById("dmz_enable").checked == true))
	    {
	        alert(gettext ("Invalid IP address format (range in 2~254)"));
	        return false;
	    }
	}
	else
	{
		 
	}
	document.getElementById("dmz_fullip").value = domain + ip_value;
	document.dmz_conf.action="/goform/setFwDmzConf";
    document.dmz_conf.submit();
    return true;
}
</script>
</head>

<body onload="dmzInit();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("nat_submenu","nat_submenu_focus","nat_dmz","nat_dmz_href");</script>
<!-- Main Menu and Submenu End -->


<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Virtual DMZ"));</script></div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br><script>document.write(gettext("Virtual DMZ function lets you specify a DMZ host IP to Redirect request to Virtual DMZ host"));</script>
		<br>
		</div>
		<form name="dmz_conf" method="post">
		<input type="hidden" name="dmz_dummy" value="0">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Virtual DMZ (Enable/Disable)"));</script></td>
				<td>
				<input type="checkbox" id="dmz_enable" name="dmz_enable" onclick="disableDmzFunc();"/>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("IP Address of host DMZ"));</script></td>
				<td>
				<span class="text_gray" id="dmz_domain" name="dmz_domain"></span>
			      
				</td>
				<td>
					<input type="text" class="configF1" name="dmz_ip"  id="dmz_ip"  size="3"  value="" maxlength="3" onkeypress="return onkeypress_number_only(event)" >
					<!--onkeydown="if (event.keyCode == 9) {return DMZIpCheck(this);}">-->
			      <input type="hidden" name="dmz_fullip" id="dmz_fullip" value="">
				</td>
				<td></td>
			</tr>
		</table>
		<div>
			<input type="submit" id="dmz_apply" value="Apply" class="submit" title="Apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return IpValidation();">
			<input type="button" id="dmz_reset" value="Reset" class="submit" title="Reset"  onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
		</form>
	</div>
</div>
<!-- Right Content start -->
</body>
<script type="text/javascript">
	document.getElementById('dmz_apply').value=gettext("Apply");
	document.getElementById('dmz_reset').value=gettext("Reset");
</script>

</html>
