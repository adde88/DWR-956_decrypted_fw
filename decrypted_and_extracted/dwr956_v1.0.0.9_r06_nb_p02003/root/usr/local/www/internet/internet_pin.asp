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


var pin_verify_flag = false;
var pin_status = "0";
function getPinCfg()
{
 var PinCfg = <%getPinConfig();%>;
 var pinArr = PinCfg.split("#");

 document.getElementById('goToChangePin').style.display = "none";
 document.getElementById('puk_remaining_times').style.display = "none";
 if (pinArr[0] == "1") {          //PIN not verified
		pin_status = "1";
  document.getElementById("pin_status").innerHTML = gettext("The selected PIN is enabled and not verified.");
		document.getElementById('pin_enable_on').checked = true;
		document.getElementById('pin_enable_off').checked = false;
		document.getElementById('pin_enable_on').disabled = true;
		document.getElementById('pin_enable_off').disabled = true;

	 document.getElementById('pin_verify').style.display = "block";
	 document.getElementById('pin_remaining_times').style.display = "block";
		document.getElementById('puk_verify').style.display = "none";
 } else if (pinArr[0] == "2") {   //PIN verified
  pin_status = "2";
  pin_verify_flag = true;
		document.getElementById("pin_status").innerHTML = gettext("The selected PIN is enabled and verified.");
		document.getElementById('pin_enable_on').checked = true;
		document.getElementById('pin_enable_off').checked = false;
		document.getElementById('pin_enable_on').disabled = false;
		document.getElementById('pin_enable_off').disabled = false;

	 document.getElementById('pin_verify').style.display = "none";
	 document.getElementById('pin_remaining_times').style.display = "block";
		document.getElementById('puk_verify').style.display = "none";

		document.getElementById('goToChangePin').style.display = "block";
 } else if (pinArr[0] == "3") {   //PIN protection not open
  pin_verify_flag = false;
		pin_status = "3";
  document.getElementById("pin_status").innerHTML = gettext("The selected PIN is disabled.");
		document.getElementById('pin_enable_on').checked = false;
		document.getElementById('pin_enable_off').checked = true;
		document.getElementById('pin_enable_on').disabled = false;
		document.getElementById('pin_enable_off').disabled = false

	 document.getElementById('pin_verify').style.display = "none";
	 document.getElementById('pin_remaining_times').style.display = "block";
		document.getElementById('puk_verify').style.display = "none";
 } else if (pinArr[0] == "4") {   //PIN locked, enter PUK
  pin_status = "4";
  document.getElementById("pin_status").innerHTML = gettext("PIN verification failed. Please enter PUK code to unlock.");
		document.getElementById('pin_enable_on').checked = true;
		document.getElementById('pin_enable_off').checked = false;
		document.getElementById('pin_enable_on').disabled = true;
		document.getElementById('pin_enable_off').disabled = true;

	 document.getElementById('pin_verify').style.display = "none";
	 document.getElementById('pin_remaining_times').style.display = "none";
		document.getElementById('puk_verify').style.display = "block";
		document.getElementById('puk_remaining_times').style.display = "block";
 } else if (pinArr[0] == "5") {  //SIM locked
  pin_status = "5";
  document.getElementById("pin_status").innerHTML = gettext("SIM card locked.");
		document.getElementById('pin_enable_on').checked = true;
		document.getElementById('pin_enable_off').checked = false;
		document.getElementById('pin_enable_on').disabled = true;
		document.getElementById('pin_enable_off').disabled = true;

	 document.getElementById('pin_verify').style.display = "none";
	 document.getElementById('pin_remaining_times').style.display = "none";
		document.getElementById('puk_verify').style.display = "none";
 } else {                        //SIM card not inserted
  pin_status = "6";
  if (pinArr[0] == "-1") {
   document.getElementById("pin_status").innerHTML = gettext("Device is busy. Please try again later.");
  } else {
   document.getElementById("pin_status").innerHTML = gettext("Please power off and plug in (U)SIM card. Then power on again. Or PIN is permanently blocked, please contact the provider.");
  }
		document.getElementById('pin_enable_on').checked = true;
		document.getElementById('pin_enable_off').checked = false;
		document.getElementById('pin_enable_on').disabled = true;
		document.getElementById('pin_enable_off').disabled = true;

	 document.getElementById('pin_verify').style.display = "none";
	 document.getElementById('pin_remaining_times').style.display = "none";
		document.getElementById('puk_verify').style.display = "none";
 }
 document.getElementById("tdPinTimes").innerHTML = pinArr[1];
 document.getElementById("tdPukTimes").innerHTML = pinArr[2];
 document.getElementById('tdPinTimes').style.color = "#ff0000";
 document.getElementById('tdPukTimes').style.color = "#ff0000";

 document.getElementById("PinStatus").value = pinArr[0];
 return;
}

function enterPinValidate(Ele)
{
	if(!CheckLoginInfo())
		return false;
	 var pin_puk_rule=/^[0-9]*$/;

		if(Ele == "button_pin"){
    var PinCode = document.getElementById("txtPin").value;
    if (PinCode.length < 4 || !pin_puk_rule.test(PinCode)) {
 	    alert(gettext("Enter PIN: Please enter 4 digits."));
 	    return false;
    }
	  	return true;
		} else if(Ele == "button_puk") {
			var PukCode = document.getElementById("txtPuk").value;
			var NewPinCode = document.getElementById("NewPin").value;
			var ReNewPinCode = document.getElementById("ReNewPin").value;
   if (PukCode.length < 8 || !pin_puk_rule.test(PukCode)) {
     alert(gettext("Enter PUK: Please enter 8 digits."));
     return false;
   }

			if (NewPinCode.length < 4 || !pin_puk_rule.test(NewPinCode)) {
     alert(gettext("Enter New PIN: Please enter 4 digits."));
     return false;
   }

			if (ReNewPinCode.length < 4 || !pin_puk_rule.test(ReNewPinCode)) {
      alert(gettext("Enter Confirm New PIN: Please enter 4 digits."));
      return false;
   }

   var NewPin = document.getElementById("NewPin");
			var ReNewPin = document.getElementById("ReNewPin");
			if ((!NewPin.disabled && !ReNewPin.disabled) && (NewPin.value != ReNewPin.value)){
     alert(gettext("New PIN does not match Confirm New PIN."));
     return false;
   }
   return true;
		}
}

function PINLockEnable (state)
{
 document.getElementById('goToChangePin').style.display = "none";
 document.getElementById('puk_remaining_times').style.display = "none";
	if(document.getElementById("pin_enable_on").checked != pin_verify_flag)
	{
	 document.getElementById('pin_verify').style.display = "block";
		document.getElementById('puk_verify').style.display = "none";
	}
	else
	{
	 if (pin_status == "1") //PIN not verified
		{
	 	document.getElementById('pin_verify').style.display = "block";
			document.getElementById('puk_verify').style.display = "none";
  }
		else if (pin_status == "2")  //PIN verified
		{
	 	document.getElementById('pin_verify').style.display = "none";
			document.getElementById('puk_verify').style.display = "none";
			document.getElementById('goToChangePin').style.display = "block";
  }
		else if (pin_status == "3") //PIN protection not open
		{
		 document.getElementById('pin_verify').style.display = "none";
			document.getElementById('puk_verify').style.display = "none";
	 }
		else if (pin_status == "4")   //PIN locked, enter PUK
		{
		 document.getElementById('pin_verify').style.display = "none";
		 document.getElementById('pin_remaining_times').style.display = "none";
			document.getElementById('puk_verify').style.display = "block";
			document.getElementById('puk_remaining_times').style.display = "block";
	 }
		else if (pin_status == "5")  //SIM locked
		{
		 document.getElementById('pin_verify').style.display = "none";
			document.getElementById('puk_verify').style.display = "none";
	 }
		else  //SIM card not inserted
		{
		 document.getElementById('pin_verify').style.display = "none";
			document.getElementById('puk_verify').style.display = "none";
	 }
	}
	return;
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
	<div class="secH1"><script>document.write(gettext("PIN Configuration"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br /><script>document.write(gettext("This page is for you to configure PIN code."));</script>
		<br />
		</div>
  <form name="internet_pin" method="post" action="/goform/setPinConfig">
  <input type="hidden" id="PinStatus" name="PinStatus" />
		<table cellspacing="0" class="configTbl">
   <tr>
    <td width="180"><script>document.write(gettext("PIN Status"));</script></td>
    <td id="pin_status" class="msg"></td>
   </tr>
   <tr>
    <td><script>document.write(gettext("Enable PIN Protection"));</script></td>
    <td>
      <input type="radio" id="pin_enable_on"  name="pin_enable" onclick="PINLockEnable('on');" value="on" /><script>document.write(gettext("Yes"));</script>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" id="pin_enable_off" name="pin_enable" onclick="PINLockEnable('off');" value="off" /><script>document.write(gettext("No"));</script>
    </td>
   </tr>
   <tr id="goToChangePin" style="display:none;">
    <td colspan="2">
    	<a class="secLable1" href="internet_change_pin.asp">&#187; <script>document.write(gettext("Change PIN"));</script></a>
    </td>
   </tr>
		</table>

  <div id="pin_verify" style="display:none;">
  <table cellspacing="0" class="configTbl">
   <tr>
     <td width="180"><script>document.write(gettext("PIN Verify"));</script></td>
     <td><input type="password" name="lte_pin" id="txtPin" maxlength="4" onkeypress="return onkeypress_number_only(event);" class="configF1" /></td>
   </tr>
   <tr>
     <td colspan="2">
     	<input type="submit" value="Verify" class="submit" id="button.verify" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return enterPinValidate('button_pin');" />
     	<input type="button" value="Reset" class="submit" id="button.reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();" />
     </td>
   </tr>
  </table>
  </div>

  <div id="puk_verify" style="display:none;">
  <table cellspacing="0" class="configTbl">
   <tr>
     <td width="180"><script>document.write(gettext("PUK Verify"));</script></td>
     <td><input type="password" name="lte_puk" id="txtPuk" maxlength="8" onkeypress="return onkeypress_number_only(event);" class="configF1" /></td>
   </tr>
   <tr>
     <td><script>document.write(gettext("New PIN"));</script></td>
     <td><input type="password" name="lte_pin" id="NewPin" maxlength="4" onkeypress="return onkeypress_number_only(event);" class="configF1" /></td>
   </tr>
   <tr>
     <td><script>document.write(gettext("Confirm New PIN"));</script></td>
     <td><input type="password" id="ReNewPin" maxlength="4" onkeypress="return onkeypress_number_only(event);" class="configF1" /></td>
   </tr>
   <tr>
     <td colspan="2">
     	<input type="submit" value="Verify" class="submit" id="button.verify_puk" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return enterPinValidate('button_puk');" />
     	<input type="button" value="Reset" class="submit" id="button.reset_puk" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();" />
     </td>
   </tr>
  </table>
  </div>

  <div id="pin_remaining_times" style="display:none;">
  <table cellspacing="0" class="configTbl">
   <tr>
     <td width="180"><script>document.write(gettext("PIN Remaining Times"));</script></td>
     <td id="tdPinTimes" class="msg"></td>
   </tr>
  </table>
  </div>

  <div id="puk_remaining_times" style="display:none;">
  <table cellspacing="0" class="configTbl">
   <tr>
     <td width="180"><script>document.write(gettext("PUK Remaining Times"));</script></td>
     <td id="tdPukTimes" class="msg"></td>
   </tr>
  </table>
  </div>

	 </form>
	</div>
</div>
</div>

<script type="text/javascript">
 document.getElementById('button.verify').value = gettext("Verify");
 document.getElementById('button.reset').value = gettext("Reset");
 document.getElementById('button.verify_puk').value = gettext("Verify");
 document.getElementById('button.reset_puk').value = gettext("Reset");
</script>

</body>
</html>
