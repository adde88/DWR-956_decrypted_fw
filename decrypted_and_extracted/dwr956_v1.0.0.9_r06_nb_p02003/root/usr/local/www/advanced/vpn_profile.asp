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
function profileChk()
{
	if (get_by_id("profile").value=="ipsec")
	{

		get_by_id("ipsec_setting").style.display = "block";			
	}
	else
	{
		get_by_id("ipsec_setting").style.display = "none";
	}
}

function pageValidate()
{
	if (get_by_id("profile").value=="ipsec" &&
		get_by_id("ipsec_profile").value=="")
	{
		var msg="You cannot active ipsec due to there is no ipsec profiles.<br>";
		msg=msg+"Please go to IPSEC page to add profile.";			
		get_by_id("statusMsg").innerHTML=msg;	
		return false;
	}
	return true;
}

function loadVpnProfile()
{
	var profileConfig = <%getVpnProfile();%>;
	if (profileConfig!="")
	{
		var cfgArr = profileConfig.split("#");
		get_by_id("profile").value=	cfgArr[0];
		get_by_id("ipsec_profile").value= cfgArr[1];	
	}
	profileChk();
}
</script>
</head>	

<body onload="loadVpnProfile();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("vpn_submenu","vpn_submenu_focus","vpn_profile","vpn_profile_href");</script>
<!-- Main Menu and Submenu End -->


<!-- Add new known computer -->
<div class="contentBg">
	<div class="secH1">VPN Active Profile</div>
	<!-- Section Begin -->
	<div class="secBg">
	<div class="statusMsg" id="statusMsg"><%getActionResult();%></div>        		
	<div class="secInfo">
		<br>In this section you can set vpn active profile.
		<br>
	</div>
	
	<!-- vpn pptp/l2tp profile -->
	<div class="secH2"><script>document.write(gettext("Profile Configuration") );</script></div>
	<br>
	<form name="VpnProfile" action="/goform/setVpnProfile" method="post">  
		<table class="configTbl" cellspacing="0" cellpadding="0" border="0">		
			<tr>
				<td><script>document.write(gettext("Active :") );</script></td>
				<td>
					<select name="profile" id="profile" onchange="profileChk();">
						<option value="disable" id="disable"><script>document.write(gettext("Disable"));</script></option>
						<option value="pptp_server" id="pptp_server"><script>document.write(gettext("PPTP Server"));</script></option>
						<option value="pptp_client" id="pptp_client"><script>document.write(gettext("PPTP Client"));</script></option>
						<option value="l2tp_server" id="l2tp_server"><script>document.write(gettext("L2TP Server"));</script></option>
						<option value="l2tp_client" id="l2tp_client"><script>document.write(gettext("L2TP Client"));</script></option>							
						<option value="ipsec" id="ipsec"><script>document.write(gettext("IPSEC"));</script></option>
					</select> 
				</td>
			</tr>
		</table>
		<div id="ipsec_setting">		
		<table class="configTbl" cellspacing="0" cellpadding="0" border="0">			
			<tr>
				<td><script>document.write(gettext("IPSEC Profile :") );</script></td>
				<td>
					<select name="ipsec_profile" id="ipsec_profile">
						<%getVpnIPSecProfile();%>
					</select> 
				</td>
			</tr>	
		</table>		
		</div>
		<div class="tblButtons">
			<input type="submit" value="Apply" class="tblbtn" onclick="return pageValidate();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
			<input type="reset" value="Discard" class="tblbtn" onclick="doRedirect();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
		</div>		
	</form>  
	
	</div>
	<!-- Section End -->
</div>

</div> <!-- End of all -->
</body>
</html>

