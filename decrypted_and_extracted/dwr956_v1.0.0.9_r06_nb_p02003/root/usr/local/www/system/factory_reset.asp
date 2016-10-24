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

function submitAction()
{
	if(!CheckLoginInfo())
		return false;
	var FAC_RESET = document.getElementById("FAC_RESET").selectedIndex;
	if(FAC_RESET == 0)
	{
		return deviceReboot();	
	}
	else if(FAC_RESET == 1)
	{
  	    return factory_reset ();
	}
	return false;
}
function deviceReboot()
{
	var Objdevice = confirm(gettext("The Device is going for a reboot.\n") + gettext("Click OK to continue else click Cancel to abort."));
	if (Objdevice)
	{
		//alert(gettext("Device will be rebooted !"));
		document.RESETFORM.action="/goform/sysReboot" ;
		document.RESETFORM.submit();
	}
	else
	{
		//alert(gettext("Device rebooting Cancelled!"));
	}
	return Objdevice;
}
function factory_reset()
{
	var factrst = confirm(gettext("The device is being reset to Factory Settings. All your configurations will be lost.\n") + gettext("Click OK to continue else click Cancel to abort."));

	if (factrst)
	{
		
		//alert(gettext("Reverting to Factory Settings !"));
		document.RESETFORM.action="/goform/factoryReset";
		document.RESETFORM.submit();
	}
	else
	{
		//alert(gettext("factory reset Cancelled !"));
	}

	return factrst;
}
</script>
</head>

<body>
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("sys");%>
<script type="text/javascript">menuChange("sys_menu");leftMenuChange("factory_reset", "factory_reset_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Reboot & Reset"));</script></div>
	<form method="post" name="RESETFORM">	
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>		
		<div class="secInfo">
			<br><script>document.write(gettext("On clicking the button to reboot the device, you will see a  countdown timer through the reboot period.  At the end of the timer the login page of the browser will be shown."));</script>
			<br>
		</div>
		<table border="0" cellpadding="0" cellspacing="0" class="configTbl">
			<tr>
				<td>
					<select name="FAC_RESET" size="1" id="FAC_RESET" class="configF1">
						<option value="0"><script>document.write(gettext("Reboot"));</script></option>
      <option value="1"><script>document.write(gettext("Revert to Factory Reset Configurations"));</script></option>
					</select>
				</td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" id="fac_reset_apply" title="Apply" value="Apply" class="submit" onclick="return submitAction();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">
	document.getElementById('fac_reset_apply').value=gettext("Apply");
</script>

</body>
</html>
