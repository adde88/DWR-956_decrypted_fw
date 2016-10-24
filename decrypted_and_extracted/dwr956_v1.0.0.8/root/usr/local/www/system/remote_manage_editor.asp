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

function pageValidate ()
{
	if(!CheckLoginInfo())
		return false;
	var txtFieldIdArr = new Array (); 
	txtFieldIdArr[0] = "txtStartIP,Please enter a valid MAC Address in the form XX:XX:XX:XX:XX:XX";
	txtFieldIdArr[1] = "txtEndIP,Please enter a valid IP Address";
	
	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;

	if (isProblemCharArrayCheck (txtFieldIdArr) == false)
		return false; 

	if (ipv4Validate ('txtStartIP', 'IP', false, true,"Invalid IP Address.", "for octet ", true) == false)
		return false;
    
	if (ipv4Validate ('txtEndIP', 'IP', false, true,"Invalid IP Address.", "for octet ", true) == false)
		return false;
	var startIP = document.getElementById("txtStartIP").value;
	var endIP = document.getElementById("txtEndIP").value;
	var startIPArr = startIP.split(".");
	var endIPArr = endIP.split(".");
	if((startIPArr[0]!=endIPArr[0])||(startIPArr[1]!=endIPArr[1])||(startIPArr[2]!=endIPArr[2]))
	{
		alert(gettext("Start IP and End IP should be in an IP range."));
		return false;
	}
	else if( (parseInt(startIPArr[3], 10)) > (parseInt(endIPArr[3], 10)) )
	{
		alert(gettext("Start IP is larger than End IP."));
		return false;
	}
	return true;
}

function pageLoad()
{
	var IpRange = <%getIpRange();%>;
	var IpRangeArr;
	if (IpRange!="")
	{
		IpRangeArr = IpRange.split("#");
		document.getElementById("txtStartIP").value=IpRangeArr[0];
		document.getElementById("txtEndIP").value=IpRangeArr[1];
	}
}
</script>
</head>
<body onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("sys");%>
<script type="text/javascript">menuChange("sys_menu");leftMenuChange("remote_manage", "remote_manage_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg" id="rem_manage_add">
	<div class="secH1"><script>document.write(gettext("Multiple IP ranges Configuration"));</script></div>
	<form name="SET_IP_RANGE" action="/goform/setIpRange" method="post">
	<input type="hidden" name="editflag" id="editflag" value="add">
	<input type="hidden" id="remote_ip_rowid_edit" name="remote_ip_rowid_edit" value="0">
	<!-- Section Begin -->
	<div class="secBg">
		
		<div class="secInfo">
<br></div>
		<div class="statusMsg"></div>
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Start IP Address"));</script></td>
				<td><input type="text" name="startIP" class="configF1" value="0.0.0.0" id="txtStartIP" size="20" maxlength="15" onkeypress="return numericValueCheck (event, '.')" onkeydown="if (event.keyCode == 9) { return ipv4AddrValidate (this, 'IP', true, true, 'Invalid IP Address.', 'for octet ', true); }">
				</td>
				<td>&nbsp;</td>
			</tr>									
			<tr>
				<td><script>document.write(gettext("End IP Address"));</script></td>
				<td><input type="text" name="endIP" class="configF1" value="0.0.0.0" id="txtEndIP" size="20" maxlength="15" onkeypress="return numericValueCheck (event, '.')" onkeydown="if (event.keyCode == 9) { return ipv4AddrValidate (this, 'IP', true, true, 'Invalid IP Address.', 'for octet ', true); }">
				</td>
				<td>&nbsp;</td>
			</tr>
			<!--<input type="hidden" value="" name="id">-->
		</table>
		<div class="submitBg">
			<input type="submit" id="apply_ip_range" value="Apply" class="submit" title="Apply" name="" onclick="return pageValidate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" id="reset_ip_range" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
		</form>
	</div>
	</div>

</div><!-- all end -->
 <script type="text/javascript">
	document.getElementById('apply_ip_range').value=gettext("Apply");
	document.getElementById('reset_ip_range').value=gettext("Reset");
 </script>

</body>
</html>

