
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>4G Router</title>
<link rel="stylesheet" href="style/all.css" type="text/css" />
<script language="Javascript" src="js/mgmt.js" type="text/javascript"></script>
<script language="javascript" src="js/textValidations.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
//<!--
function loginValidate()
{
	var txtFieldIdArr = new Array ();
	txtFieldIdArr[0] = "txtUserName,Please enter a valid username";
	txtFieldIdArr[1] = "txtLoginPwd,Please enter a valid password";

	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;

	return true;
}

function loginInit ()
{
	var usrObj = document.getElementById ('txtUserName');
	if (!usrObj) return;
	usrObj.focus ();
}
//-->
</script>
</head>
<body onload="loginInit()">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
			<td align="center" valign="top">
				<div class="w1000">
				<!-- Main menu Start -->
				<div class="mainMenuBg">
				</div>
				<!-- Main menu End -->

					<div class="midBg">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center" valign="top">
							<div class="contentBg0_new">
							<div class="secH1_new">Web Access Login</div>
                            <form method="post" action="/goform/loginUrlFilter">
		                    <input type="hidden" name="thispage" value="urlFilterLogin.htm">
							<div class="secBg_new">
								<div class="secInfo">&nbsp;</div>
								<div class="statusMsg"><%getActionResult();%></div>
								<div align="center">
								<table cellspacing="0" class="configTbl">
									<tr>
										<td >&nbsp;</td>
										<td >&nbsp;</td>
										<td >&nbsp;</td>
									</tr>
									<tr>
   										<td>Username:</td>
										<td><input type="text" name="users.username" id="txtUserName" size="20" class="configF1" maxlength="32"></td>
										<td >&nbsp;</td>
									</tr>
									<tr>
										<td >Password:</td>
										<td ><input type="password" name="users.password" id="txtLoginPwd" size="20" class="configF1" maxlength="32"></td>
										<td >&nbsp;</td>
									</tr>
									<tr>
										<td >&nbsp;</td>
										<td >&nbsp;</td>
										<td >&nbsp;</td>
									</tr>
									</table>
									</div>
								<div class="submitBg_new">
									<input type="submit" value="Login" class="submit" title="Login" name="button.login.urlFilterLogout" onclick="return loginValidate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
								</div>
							</div>
							</form>
						</div>
						</td></tr>
						


						</table>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>

