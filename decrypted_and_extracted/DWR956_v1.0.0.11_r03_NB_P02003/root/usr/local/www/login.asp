<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
var login_status=<%getintologin();%>;

var login_flag=<%getLoginResetToDefault();%>;
if(login_flag=="1")
{
	window.location.href="http://<%getLanBasic("IpAddress");%>/setupWizard.asp";
}

function loginInit()
{
	var login_pin_status = <%getLoginPinStatus();%>;
	if (login_pin_status == "1")
	{
  alert(gettext("Please power off and plug in (U)SIM card. Then power on again. Or PIN is permanently blocked, please contact the provider."));
  return;
 } else if (login_pin_status == "-1") {
  alert(gettext("Device is busy. Please try again later."));
  return;
 }

	var usrObj = document.getElementById ('login_password');
	if (!usrObj) 
	return;
	usrObj.focus ();
}

</script>
</head>
<body onload="loginInit ();">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%;">
		<tr>
			<td align="center" valign="top">
				<div class="w1000">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center" valign="top">
							<div class="contentBg0_new">
							<div class="secH1_new">&nbsp;</div>
							<div class="login_input_bg">
								<div class="secInfo">&nbsp;</div>
								<div class="statusMsg_login"></div>
								<div align="center">
							      <form id="DEFAULT_LOGIN" name="DEFAULT_LOGIN" method="post" action="/goform/user_login">

								<table cellspacing="0" class="configTbl">
									<tr>
										<td class="login_input_text"><script>document.write(gettext("Username"));</script>&nbsp;:</td>
										<td><input type="text" value="admin" name="login_username" class="configF1" size="20" id="login_username" maxlength="32" /></td>
											
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="login_input_text"><script>document.write(gettext("Password"));</script>&nbsp;:</td>
										<td><input type="password" name="login_password" size="20" class="configF1" id="login_password" maxlength="32" /></td>
											
										<td>&nbsp;</td>
									</tr>
									<tr id="loginButton">
										<td colspan="3" class="submitBg_new">
											<input type="submit" id="login" value="Login" class="submit" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
										</td>
									</tr>
									</table>
									</form>
									</div>
							</div>
						</div>
						</td></tr>
						</table>
				</div>
			</td>
		</tr>
	</table>
 <script type="text/javascript">
	document.getElementById('login').value=gettext("Login");
	if(login_status == "0")
	{
		alert("Invalid Username or Password");
	}
 </script>
</body>
</html>
