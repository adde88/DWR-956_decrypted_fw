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


var PinCfg = <%getPinConfig();%>;
var pinArr = PinCfg.split("#");
//1:PIN not verified, 2:PIN protection not open, 4:PIN locked, enter PUK, 5:SIM locked, 6:SIM card not inserted
if (pinArr[0] != "2") {
 window.location.href="../internet/internet_pin.asp";
}

function getPinCfg()
{
 document.getElementById("pin_remaining_times").innerHTML = pinArr[1];
 document.getElementById('pin_remaining_times').style.color = "#ff0000";
 return;
}

function changePinValidate()
{
	if(!CheckLoginInfo())
		return false;
	var pin_puk_rule=/^[0-9]*$/;
	var oldPIN = document.getElementById("OldPin").value;
	if (oldPIN.length < 4 || !pin_puk_rule.test(oldPIN)) {
		alert(gettext("Old PIN: Please enter 4-8 digits."));
		return false;
	}

	var newPIN = document.getElementById("NewPin").value;
	if (newPIN.length < 4 || !pin_puk_rule.test(newPIN)) {
		alert(gettext("New PIN: Please enter 4-8 digits."));
		return false;
	}

	var confirmPIN = document.getElementById('ConfirmPin').value;
	if (confirmPIN.length < 4 || !pin_puk_rule.test(confirmPIN)) {
		alert(gettext("Confirm New PIN: Please enter 4-8 digits."));
		return false;
	}

	var newPwd = document.getElementById('NewPin');
	var confirmPwd = document.getElementById('ConfirmPin');
	if ((!newPwd.disabled && !confirmPwd.disabled) && (newPwd.value != confirmPwd.value))
	{
		alert(gettext("New PIN does not match Confirm New PIN."));
		return false;
	}

	return true;
}
</script>
</head>

<body onload="getPinCfg();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("lte");%>
<script type="text/javascript">menuChange("lte_menu");leftMenuChange("internet_pin", "internet_pin_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("PIN Change"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br /><script>document.write(gettext("You can change pin code in this page."));</script>
		&nbsp;&nbsp;<a class="secLable1" href="internet_pin.asp">&#187; <script>document.write(gettext("Back to PIN Configuration"));</script></a>
		<br />
		</div>
		<form name="internet_change_pin" method="post" action="/goform/setChangePin">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Old PIN"));</script></td>
				<td>
				<input type="password" name="lte_OldPin" id="OldPin" value="" size="20" maxlength="4" class="configF1" />
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("New PIN"));</script></td>
				<td>
				<input type="password" name="lte_NewPin" id="NewPin" value="" size="20" maxlength="4" class="configF1" />
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Confirm New PIN"));</script></td>
				<td>
				<input type="password" name="lte_ConfirmPin" id="ConfirmPin" value="" size="20" maxlength="4" class="configF1" />
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("PIN Remaining Times"));</script></td>
				<td class="msg" id="pin_remaining_times"></td>
			</tr>
		</table>
		<div>
			<input type="submit" value="Apply" class="submit" id="button.apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return changePinValidate();" />
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
