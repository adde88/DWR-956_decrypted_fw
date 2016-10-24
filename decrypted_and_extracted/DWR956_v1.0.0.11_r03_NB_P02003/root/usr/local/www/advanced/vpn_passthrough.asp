<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="JavaScript" src="../js/textValidations.js" type="text/javascript"></script>
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">

function loadVPNPassthrough()
{
	var vpn_pt = <%getVPNPT();%>;
	var vpn_pt_arr = vpn_pt.split("#");

	var vpnp_pptp = vpn_pt_arr[0];
	var vpnp_l2tp = vpn_pt_arr[1];
	var vpnp_ipsec = vpn_pt_arr[2];

	document.getElementById('pptp_pt_on').checked = (vpnp_pptp=="1") ? true:false;
	document.getElementById('pptp_pt_off').checked = (vpnp_pptp=="1") ? false:true;
	document.getElementById('l2tp_pt_on').checked = (vpnp_l2tp=="1") ? true:false;
	document.getElementById('l2tp_pt_off').checked = (vpnp_l2tp=="1") ? false:true;
	document.getElementById('ipsec_pt_on').checked = (vpnp_ipsec=="1") ? true:false;
	document.getElementById('ipsec_pt_off').checked = (vpnp_ipsec=="1") ? false:true;
}
</script>
</head>	

<body onload="loadVPNPassthrough();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("vpn_submenu","vpn_submenu_focus","vpn_passthrough","vpn_passthrough_href");</script>
<!-- Main Menu and Submenu End -->


<!-- Add new known computer -->
<div class="contentBg">
	<div class="secH1">VPN Passthrough</div>
	<!-- Section Begin -->
	<div class="secBg">
	<div class="statusMsg"><%getActionResult();%></div>        		
	<div class="secInfo">
		<br>In this section you can set vpn passthrough.
		<br>
	</div>

	<!-- vpn passthrough -->
	<form name="VPN" action="/goform/setVPNPT" method="post">  
		<table class="configTbl" cellspacing="0" cellpadding="0" border="0">		
			<tr>
				<td><script>document.write(gettext("PPTP:") );</script></td>
				<td>
				  <input type="radio" id="pptp_pt_on" name="VPNP_PPTP" value="on"/> <script>document.write(gettext("Enable") );</script></input>
				  <input type="radio" id="pptp_pt_off" name="VPNP_PPTP" value="off"/> <script>document.write(gettext("Disable") );</script></input>
				</td>
			</tr>
		  	<tr>
		  		<td><script>document.write(gettext("L2TP:") );</script></td>
				<td>
					<input type="radio" id="l2tp_pt_on" name="VPNP_L2TP" value="on"/> <script>document.write(gettext("Enable") );</script></input>
					<input type="radio" id="l2tp_pt_off" name="VPNP_L2TP" value="off"/> <script>document.write(gettext("Disable") );</script></input>
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("IPSec:") );</script></td>
				<td>
				  <input type="radio" id="ipsec_pt_on" name="VPNP_IPSEC" value="on"/> <script>document.write(gettext("Enable") );</script></input>
				  <input type="radio" id="ipsec_pt_off" name="VPNP_IPSEC" value="off"/> <script>document.write(gettext("Disable") );</script></input>
				</td>
			</tr>    
		</table>
		<div class="tblButtons">
			<input type="submit" value="Apply" class="tblbtn" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
			<input type="reset" value="Discard" class="tblbtn" onclick="doRedirect();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
		</div>		
	</form>  

	</div>
	<!-- Section End -->
</div>

</div> <!-- End of all -->
</body>
</html>

