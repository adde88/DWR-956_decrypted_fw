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

function pageValidate()
{
	var ret_msg="";
	var saTime=parseInt(get_by_id("sa_lifetime").value,10);
	var ipsecTime=parseInt(get_by_id("ipsec_lifetime").value,10);	
	if(isBlank(get_by_id("name").value))
	{
		ret_msg=gettext("Enter valid Name");
	}	
	else if(isBlank(get_by_id("remote_security_gateway").value))
	{
		ret_msg=gettext("Enter valid Remote Security Gateway");
	}
	else if(isBlank(get_by_id("remote_network_ipaddr").value))
	{
		ret_msg=gettext("Enter valid Remote IP Address");
	}
	else if (!check_ip_format(get_by_id("remote_network_ipaddr")))
	{
		ret_msg=gettext("Enter valid Remote IP Address");
	}		
	else if (isBlank(get_by_id("remote_network_netmask").value))
	{
		ret_msg=gettext("Enter valid Remote Network Subnet");		
	}
	else if(isBlank(get_by_id("preshared_key").value))
	{
		ret_msg=gettext("Enter valid Pre-Shared Key");
	}
	else if(isBlank(get_by_id("sa_lifetime").value))
	{
		ret_msg=gettext("Enter valid SA Lifetime");
	}
	else if(isBlank(get_by_id("ipsec_lifetime").value))
	{
		ret_msg=gettext("Enter valid IPSEC Lifetime");
	}	
	else if (isNaN(saTime) || saTime<5 || saTime>1500)
	{
		ret_msg=gettext("Enter valid SA Lifetime");
	}
	else if (isNaN(ipsecTime) || ipsecTime<5 || ipsecTime>1500)
	{
		ret_msg=gettext("Enter valid IPSEC Lifetime");
	}
	else if (saTime<ipsecTime)
	{
		ret_msg=gettext("SA Lifetime should be greater than IPSec lifetime");
	}

	if (ret_msg!="")
	{
		get_by_id("statusMsg").innerHTML=ret_msg;
		alert(ret_msg);
		return false;
	}
	return true;
}

function loadVpnIPSEC()
{	
<%getVpnIPSec();%>;
}
</script>
</head>	

<body onload="loadVpnIPSEC();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("vpn_submenu","vpn_submenu_focus","vpn_ipsec","vpn_ipsec_href");</script>
<!-- Main Menu and Submenu End -->


<div class="contentBg">
	<div class="secH1">VPN IPSEC</div>	
	<div class="secBg">
	<div class="statusMsg" id="statusMsg"><%getActionResult();%></div>  
	<div class="secInfo">
		<br>In this section you can edit ip sec profile.
		<br>
		<a class="secLable1" href="vpn_ipsec.asp">>> Back to Vpn IPSEC page</a>        			
	</div>	
	</div>

	<div class="secBg">
	<form action="/goform/setVpnIPSec" method="post"> 		
		<div class="secH2">IPSEC Settings</div>
		<table class="configTbl" cellspacing="0" cellpadding="0" border="0">		
			<tr>
				<td><script>document.write(gettext("Name") );</script></td>
				<td><input id="name" name="name" class="txtbox" type="text" value="" maxlength="24" size="15" onkeypress="return keypress_ascii(event)"></td>
				<td colspan="4"></td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Remote Security Gateway") );</script></td>
				<td><input id="remote_security_gateway" name="remote_security_gateway" class="txtbox" type="text" value="" maxlength="24" size="15"></td>
				<td colspan="4"></td>
			</tr> 
		  	<tr>
		  		<td><script>document.write(gettext("Remote Network Subnet") );</script></td>
				<td><input id="remote_network_ipaddr" name="remote_network_ipaddr" class="txtbox" type="text" value="" maxlength="15" size="15" onkeypress="return keypress_ip_format(event)"></td>
				<td>/</td>
				<td>
					<input id="remote_network_netmask" name="remote_network_netmask" class="txtbox" type="text" value="" maxlength="2" size="2">
					<span>Ex:192.168.0.0/24</span>			
				</td>
				<td colspan="2"></td>
			</tr>					
			<tr>
				<td><script>document.write(gettext("Pre-Shared Key") );</script></td>
				<td><input id="preshared_key" name="preshared_key" class="txtbox" type="text" value="" maxlength="24" size="15"></td>
				<td colspan="4"></td>
			</tr> 					
		</table>
		<br><br>
		
		<div class="secH2">Phase 1</div>
		<table class="configTbl" cellspacing="0" cellpadding="0" border="0">
			<tr>
		  		<td><script>document.write(gettext("Mode") );</script></td>
		  		<td>
					<select size="1" class="configF1" id="mode" name="mode">
						<option value="main">Main</option>	
						<option value="aggressive">Aggressive</option>	
					</select>
				</td>
				<td colspan="4"></td>
			</tr>
			<tr>
		  		<td><script>document.write(gettext("Encryption Algorithm") );</script></td>
				<td>
					<select size="1" class="configF1" id="phase1_encryption_algorithm" name="phase1_encryption_algorithm">
						<option value="des">DES</option>
						<option value="3des">3DES</option>
						<option value="aes128">AES-128</option>
						<option value="aes192">AES-192</option>
						<option value="aes256">AES-256</option>						
					</select>				
				</td>
				<td><script>document.write(gettext("Integrity Algorithm") );</script></td>
				<td>
					<select size="1" class="configF1" id="phase1_integrity_algorithm" name="phase1_integrity_algorithm">
						<option value="md5">MD5</option>
						<option value="sha1">SHA1</option>
					</select>					
				</td>
				<td colspan="2"></td>			
			</tr>
			<tr>
		  		<td><script>document.write(gettext("DH Group") );</script></td>
				<td>
					<select size="1" class="configF1" id="phase1_dh_group" name="phase1_dh_group">
						<option value="modp768">MODP768</option>
						<option value="modp1024">MODP1024</option>
						<option value="modp1536">MODP1536</option>
						<option value="modp2048">MODP2048</option>						
					</select>				
				</td>
				<td><script>document.write(gettext("SA Lifetime") );</script></td>
				<td><input id="sa_lifetime" name="sa_lifetime" class="txtbox" type="text" value="" maxlength="24" size="15">min(s)[5-15000]</td>				
				<td colspan="2"></td>			
			</tr>			
		</table>
		<br><br>
		
		<div class="secH2">Phase 2</div>
		<table class="configTbl" cellspacing="0" cellpadding="0" border="0">
			<tr>
		  		<td><script>document.write(gettext("Encryption Algorithm") );</script></td>
				<td>
					<select size="1" class="configF1" id="phase2_encryption_algorithm" name="phase2_encryption_algorithm">
						<option value="des">DES</option>
						<option value="3des">3DES</option>
						<option value="aes128">AES-128</option>
						<option value="aes192">AES-192</option>
						<option value="aes256">AES-256</option>						
					</select>				
				</td>
				<td><script>document.write(gettext("Integrity Algorithm") );</script></td>
				<td>
					<select size="1" class="configF1" id="phase2_integrity_algorithm" name="phase2_integrity_algorithm">
						<option value="md5">MD5</option>
						<option value="sha1">SHA1</option>
					</select>					
				</td>
				<td colspan="2"></td>			
			</tr>
			<tr>
		  		<td><script>document.write(gettext("DH Group") );</script></td>
				<td>
					<select size="1" class="configF1" id="phase2_dh_group" name="phase2_dh_group">
						<option value="none">None</option>
						<option value="modp768">MODP768</option>
						<option value="modp1024">MODP1024</option>
						<option value="modp1536">MODP1536</option>
						<option value="modp2048">MODP2048</option>												
					</select>				
				</td>
				<td><script>document.write(gettext("IPSEC Lifetime") );</script></td>
				<td><input id="ipsec_lifetime" name="ipsec_lifetime" class="txtbox" type="text" value="" maxlength="24" size="15">min(s)[5-15000]</td>				
				<td colspan="2"></td>			
			</tr>			
		</table>		
		<div class="tblButtons">
			<input type="submit" value="Apply" class="tblbtn" onclick="return pageValidate();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
			<input type="reset" value="Discard" class="tblbtn" onclick="doRedirect();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
		</div>		
	</form>  
	</div>

</div>

</div> <!-- End of all -->
</body>
</html>

