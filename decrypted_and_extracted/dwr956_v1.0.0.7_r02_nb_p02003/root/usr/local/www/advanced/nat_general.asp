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
var nat_enable="0";
function NatEnables ()
{
    var NatEnables = <%getFwNatConf();%>;
    var strArr = NatEnables.split("#");
	nat_enable=strArr[4];
    if (strArr[4] == "1" ){
		
        document.getElementById("nat_mode").checked = true;
		document.getElementById("bridge_mode").checked = false;
        /*if (strArr[5] == "1" )
            document.getElementById("port_forwd_enable").checked = true;
        else
            document.getElementById("port_forwd_enable").checked = false;
        if (strArr[6] == "1" )
            document.getElementById("dmz_enable").checked = true;
        else
            document.getElementById("dmz_enable").checked = false;*/
    }else {
    	document.getElementById("nat_mode").checked = false;
        document.getElementById("bridge_mode").checked = true;
//        document.getElementById("port_forwd_enable").disabled=true;
//        document.getElementById("dmz_enable").disabled=true;
    }
}
function disableNatFunc(natMode)
{
	switch(natMode.value)
	{
		case "1":
            
			alert(gettext("Enabling 'NAT' will revert all inbound firewall settings to defaults."));
			document.getElementById ('nat_mode').checked = true;
			break;
		case "5":
			alert(gettext("Enabling Bridge Mode will bridge LAN and WAN traffic."));
			document.getElementById ('bridge_mode').checked = true;
			break;
    }
}
function confirmMsg()
{
	if(!CheckLoginInfo())
		return false;
	if(nat_enable=="1" && document.getElementById("nat_mode").checked == true)
	{
		window.location = document.location.href;
		return true;
	}
	else if(nat_enable=="5" && document.getElementById("bridge_mode").checked == true)
	{
		window.location = document.location.href;
		return true;
	}
	else
	{
		document.nat_gen.action="/goform/setFwNatConf";
		document.nat_gen.submit();
		return true;
	}
}

</script>
</head>

<body onload="NatEnables ()">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("nat_submenu_focus", "nat_submenu_focus_href");leftSubMenuChange("nat_submenu","nat_submenu_focus","","");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Network Address Translation (NAT)"));</script></div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
	    <div class="secInfo">
		<br><script>document.write(gettext("Network Address Translation (NAT) is a technique which allows several computers on a LAN to share an Internet connection."));</script>
		<br>
	    </div>
		<form name="nat_gen" method="post">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("NAT"));</script></td>
				<td><input type="radio" id="nat_mode" name="nat_mode" value="1" onclick="disableNatFunc (this)" >
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Bridge Mode"));</script></td>
				<td><input type="radio" id="bridge_mode" name="nat_mode"  value="5" onclick="disableNatFunc(this)">
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		
		<!--<table border="0" cellpadding="0" cellspacing="0"  class="configTbl" width="320">
		   <tr style="height:50px;"></tr>
	       <tr>
	        <td class="secH2"><script>document.write(gettext("NAT Status"));</script></td>
	       </tr>
	       <tr>
	        <td class="">
	        <table border="0" cellpadding="0" cellspacing="0" id="" width="100%">
	         <tr>
	          <td class="tdH" width="128"><script>document.write(gettext("Port Forwarding"));</script></td>
	          <td class="tdH" width="128"><script>document.write(gettext("DMZ"));</script></td>
	         </tr>
	         <tr>
	          <td class="tdOdd" width="128"><input type="checkbox" id="port_forwd_enable" name="port_forwd_enable"/></td>
	          <td class="tdOdd" width="128"><input type="checkbox" id="dmz_enable" name="dmz_enable"/></td>
	         </tr>
         
        </table>-->
		<div class="submitBg">
			<input type="submit" value="Apply" id="nat_apply" class="submit" onclick="return confirmMsg();" title="Apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" value="Reset" id="nat_reset" class="submit" title="Reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();">
		</div>
		</form>
	</div>
	<!-- Section End -->
</div>

</body>
<script type="text/javascript">
	document.getElementById('nat_apply').value=gettext("Apply");
	document.getElementById('nat_reset').value=gettext("Reset");
</script>

</html>
