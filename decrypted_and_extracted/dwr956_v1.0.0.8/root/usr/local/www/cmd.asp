<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html><head><title>System command</title>

<link rel="stylesheet" href="/style/normal_ws.css" type="text/css">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script language="JavaScript" type="text/javascript">

function formCheck()
{
	if( document.SystemCommand.command.value == ""){
		alert("Please specify a command.");
		return false;
	}

	return true;
}

function setFocus()
{
	document.SystemCommand.password.focus();
}
</script>

</head>
<body onload="setFocus()">
<table class="body"><tr><td>
<h1 id="syscommandTitle">System Command</h1>
<p id="syscommandIntroduction"> Run a system command as root: </p>
<form method="post" name="SystemCommand" action="/goform/SystemCommand">
<table border="1" cellpadding="2" cellspacing="1" width="95%">
<tbody><tr>
  <td class="title" colspan="2" id="syscommandSysCommand">System command: </td>
</tr>
<tr>
 <td class="head" id="userVerifyPassword">Password:</td>
	<td><input type="password" name="password" size="30" maxlength="32" /></td>
</tr>
<tr>
 <td class="head" id="syscommandCommand">Command:</td>
	<td><input type="text" name="command" size="30" maxlength="256" /></td>
</tr>
<tr><td colspan="2">
  <textarea style="font-size: 8pt;" cols="63" rows="20" readonly="1">
<% showSystemCommandASP(); %>
  </textarea>
</td></tr>
</table>
<input value="Apply" id="syscommandApply" name="SystemCommandSubmit" onclick="return formCheck()" type="submit" />
</form>
<br />
<form method="post" name="clearSystemCommand" action="/goform/clearSystemCommand">
<input value="Clear" id="syscommandCancel" name="clear" type="submit" />
</form>
<br />
<form method="post" name="repeatLastSystemCommand" action="/goform/repeatLastSystemCommand">
<input value="Repeat Last Command" id="repeatLastCommand" name="repeatLastCommand" type="submit" />
</form>
<br />
</td></tr></table>
</body></html>
