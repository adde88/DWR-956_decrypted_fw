<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
 	<title>4G Router</title>
 	<meta http-equiv="Content-Language" content="en-us" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link type="text/css" rel="stylesheet" href="../images/Wizard/reset.css" />
  <link type="text/css" rel="stylesheet" href="../images/Wizard/landingpage.css" />
  <script language="JavaScript" src="../js/mgmt.js" type="text/javascript"></script>
  <script language="JavaScript" type="text/javascript">
  //<!--
   var login_flag=<%getLoginResetToDefault();%>;
   function enterPinValidate()
   {
     var pin_puk_rule=/^[0-9]*$/;
     if (document.getElementById('hdPinStatus1').value == "4")
     {
       var PukCode = document.getElementById("txtPuk").value;
       if (PukCode.length < 8 || !pin_puk_rule.test(PukCode))
       {
        //Enter PUK: Please enter 8 digits.
        alert("Skriv inn PUK : Skriv inn 8 siffer");
        return false;
       }
     }

     var PinCode = document.getElementById("txtPin").value;
     if (PinCode.length < 4 || !pin_puk_rule.test(PinCode)) {
 	     //Enter PIN: Please enter 4 digits.
 	     alert("Skriv inn PIN : Skriv inn 4 siffer");
 	     return false;
     }
     return true;
   }

   function pinStatusEnable()
   {
	    var pinStatus = document.getElementById('hdPinStatus1').value;

	    if(pinStatus == "2" || pinStatus == "4" || pinStatus == "1")
	    {
	    } else if(pinStatus == "3") {
	      //onNextWiFi();
	      onShowDisablePIN();
	      document.getElementById('btnWifiPrevious').className="hide";
	      return;
	    } else if(pinStatus == "0") {
		     //Please power off and plug in (U)SIM card. Then power on again. Or PIN is permanently blocked, Please contact the provider.
		     alert("SIM kort mangler eller er ikke aktivert. Slå av ruteren og sett inn et aktivert SIM-kort. Slå på ruteren igjen.");
       return;
	    } else {
		     alert(gettext("Device is busy. Please try again later."));
		     return;
	    }

     var hide_pinRetryLeft = document.getElementById('hide_pinRetryLeft').value;
     var hide_pukRetryLeft = document.getElementById('hide_pukRetryLeft').value;
	    if (pinStatus == "1") //PIN enabled, not verified
	    {
		     document.getElementById('trPuk').className="hide";
		     document.getElementById('trPukTimes').className="hide";
		     document.getElementById('trPin').className="show";
		     document.getElementById('trPinTimes').className="show";
		     document.getElementById('btnVerify').className="show";
		     document.getElementById('btnVerify').name="button.verifyPIN.setupWizard";

       if (hide_pinRetryLeft == "3" || hide_pinRetryLeft == "0")
         document.getElementById('trPinStatusDisp').className="hide";
		     else
         document.getElementById('trPinStatusDisp').className="show";

       document.getElementById('trPukStatusDisp').className="hide";
       document.action_setup_pin_code.action = "/goform/setSetupWizardVerifyPIN";
       document.getElementById('thPinTimes').innerHTML="<label>" + hide_pinRetryLeft + " gjenstående forsøk<\/label>";
	    }
	    else if(pinStatus == "4") //PIN locked, enter PUK
	    {
		     document.getElementById('trPuk').className="show";
       document.getElementById('trPukTimes').className="show";
		     document.getElementById('trPin').className="show";
       //Enter New PIN
       document.getElementById('trPin_label').innerHTML="<label>Tast inn ny PIN-kode, 4 siffer<\/label>";
       document.getElementById('txtPin_href_title').outerHTML="<a id='txtPin_href_title' class='info' title='Her kan du sette en ny PIN-kode.  Ta vare på din nye  PIN-kode'><\/a>";
		     document.getElementById('trPinTimes').className="hide";
		     document.getElementById('btnVerify').className="show";
		     document.getElementById('btnVerify').name="button.verify1.setupWizard";
		     //Unlock PUK
		     document.getElementById('btnVerify').value="Lagre ny PIN";

       document.getElementById('trPinStatusDisp').className="hide";
      if (hide_pukRetryLeft == "10" || hide_pukRetryLeft == "0")
         document.getElementById('trPukStatusDisp').className="hide";
       else
         document.getElementById('trPukStatusDisp').className="show";

       document.action_setup_pin_code.action = "/goform/setSetupWizardUnblockPUK";
       document.getElementById('thPukTimes').innerHTML="<label>" + hide_pukRetryLeft + " gjenstående forsøk<\/label>";
	    }
	    else if(pinStatus == "2") //PIN enabled, verified
	    {
		     document.getElementById('trPuk').className="hide";
		     document.getElementById('trPukTimes').className="hide";
		     document.getElementById('trPin').className="show";
		     document.getElementById('trPinTimes').className="show";
		     document.getElementById('btnVerify').className="show";
		     document.getElementById('btnVerify').name="button.verifyPIN.setupWizard";

       if (hide_pinRetryLeft == "3" || hide_pinRetryLeft == "0")
         document.getElementById('trPinStatusDisp').className="hide";
		     else
         document.getElementById('trPinStatusDisp').className="show";

       document.getElementById('trPukStatusDisp').className="hide";
       document.action_setup_pin_code.action = "/goform/setSetupWizardVerifyPIN";
       document.getElementById('thPinTimes').innerHTML="<label>" + hide_pinRetryLeft + " gjenstående forsøk<\/label>";
	    }
	    else if(pinStatus == "3") //PIN disabled
	    {
		     document.getElementById('trPuk').className="hide";
		     document.getElementById('trPukTimes').className="hide";
		     document.getElementById('trPin').className="show";
		     document.getElementById('trPinTimes').className="show";
		     document.getElementById('btnVerify').className="show";
		     document.getElementById('btnVerify').name="button.config.setupWizard";

       if (hide_pinRetryLeft == "3" || hide_pinRetryLeft == "0")
         document.getElementById('trPinStatusDisp').className="hide";
		     else
         document.getElementById('trPinStatusDisp').className="show";

       document.getElementById('trPukStatusDisp').className="hide";
       document.getElementById('thPinTimes').innerHTML="<label>" + hide_pinRetryLeft + " gjenstående forsøk<\/label>";
 	   }
	    else if(pinStatus == "5") //PIN permanently blocked
	    {
		     document.getElementById('trPuk').className="hide";
		     document.getElementById('trPukTimes').className="hide";
		     document.getElementById('trPin').className="hide";
		     document.getElementById('trPinTimes').className="hide";
		     document.getElementById('btnVerify').className="hide";
		     document.getElementById('btnVerify').name="button.config.setupWizard";

       document.getElementById('trPinStatusDisp').className="hide";
       document.getElementById('trPukStatusDisp').className="hide";
	    }
	    else //PIN not initialized
	    {
		     document.getElementById('trPuk').className="hide";
		     document.getElementById('trPukTimes').className="hide";
		     document.getElementById('trPin').className="hide";
		     document.getElementById('trPinTimes').className="hide";
		     document.getElementById('btnVerify').className="hide";
		     document.getElementById('btnVerify').name="button.config.setupWizard";

       document.getElementById('trPinStatusDisp').className="hide";
       document.getElementById('trPukStatusDisp').className="hide";
	    }

	    var verifyPIN = document.getElementById('hide_pinVerifyCheck').value;
	    if (verifyPIN == "1")
	    {
       //document.getElementById('btnPinCodeNext').className="show";
			    onNextChangePin();
	    } else {
		     //document.getElementById('setup_pin_code').className = "show";
		     onShowPinCode();
	    }
   }

   function enablePinConfig()
   {
	    var goToReadyFrame = <%getSetupWizardFinish();%>;

	    if (goToReadyFrame == 1) {
		     onShowReady();
     } else {
       if(login_flag=="0")
       {
        window.location.href="../login.asp";
        return;
       }
       pinStatusEnable();
	    }
   }

   function onShowPinCode()
   {
	    document.getElementById('setup_pin_code').className="show";
	    document.getElementById('setup_change_pin').className="hide";
	    document.getElementById('setup_disable_pin').className="hide";
	    document.getElementById('setup_wifi').className="hide";
	    document.getElementById('setup_admin').className="hide";
	    document.getElementById('setup_confirm').className="hide";
	    document.getElementById('setup_ready').className="hide";

	    onCloseChangePIN();
   }

   function onNextChangePin()
   {
     var pinVal1 = document.getElementById('hdPinStatus1').value;
	    if (pinVal1 == "2")
	    {
       document.getElementById('setup_pin_code').className="hide";
       document.getElementById('setup_change_pin').className="show";
     } else if (pinVal1 == "4") {
 	     //document.getElementById('btnPinCodeNext').className="hide";
 	     onShowPinCode();
	    } else {
       //onNextWiFi();
       onShowDisablePIN();
	    }
   }

   function onPreviousPINCode()
   {
	    document.getElementById('setup_pin_code').className="show";
	    document.getElementById('setup_change_pin').className="hide";
   }

   function onNextWiFi()
   {
     onCloseChangePIN(); //Add, temp
     document.getElementById('setup_disable_pin').className="hide";
	    document.getElementById('setup_change_pin').className="hide";
	    document.getElementById('setup_wifi').className="show";
   }

   function onPreviousChangePin()
   {
	    document.getElementById('setup_change_pin').className="show";
	    document.getElementById('setup_wifi').className="hide";
   }

   function onNextAdmin()
   {
	    document.getElementById('setup_wifi').className="hide";
	    document.getElementById('setup_admin').className="show";

	    //var strPSK = document.getElementById("pskPassAscii").value;
	    var strPassword = document.getElementById("password").value;

	    if (strPassword.length == 0)
	    {
       var wifi_psk = document.getElementById('hide_pskPassAscii').value;
		     document.getElementById("password").value = wifi_psk;
		     document.getElementById("confirm_password").value = wifi_psk;
	    }
   }

   function onPreviousWiFi()
   {
	    document.getElementById('setup_wifi').className="show";
	    document.getElementById('setup_admin').className="hide";
   }

   function onNextComfirm()
   {
	    document.getElementById('setup_admin').className="hide";
	    document.getElementById('setup_confirm').className="show";

     var strSSID = document.getElementById("ssid").value;
     var strPSK = document.getElementById("pskPassAscii").value;
     var strSSID_ac = document.getElementById("ssid_ac").value;
     var strPSK_ac = document.getElementById("pskPassAscii_ac").value;
     var strPassword = document.getElementById("password").value;

     document.getElementById("confirm_ssid").innerHTML = strSSID;
     document.getElementById("confirm_psk").innerHTML = strPSK;
     document.getElementById("confirm_ssid_ac").innerHTML = strSSID_ac;
     document.getElementById("confirm_psk_ac").innerHTML = strPSK_ac;
     document.getElementById("confirm_pwd").innerHTML = strPassword;

     document.getElementById("inputdata_ssid").value = strSSID;
     document.getElementById("inputdata_psk").value = strPSK;
     document.getElementById("inputdata_ssid_ac").value = strSSID_ac;
     document.getElementById("inputdata_psk_ac").value = strPSK_ac;
     document.getElementById("inputdata_pwd").value = strPassword;
   }

   function onPreviousUser()
   {
	    document.getElementById('setup_admin').className="show";
	    document.getElementById('setup_confirm').className="hide";
   }

   function onShowReady()
   {
	    document.getElementById('setup_pin_code').className="hide";
	    document.getElementById('setup_change_pin').className="hide";
	    document.getElementById('setup_disable_pin').className="hide";
	    document.getElementById('setup_wifi').className="hide";
	    document.getElementById('setup_admin').className="hide";
	    document.getElementById('setup_confirm').className="hide";
	    document.getElementById('setup_ready').className="show";

	    onCloseChangePIN();
   }

   function changePinValidate()
   {
     var old_pin = document.getElementById("txtOldPin").value;
     if(old_pin == "")
     {
      	//Please enter the Old PIN
       alert("Skriv inn den gamle PIN-koden, 4 siffer");
       return false;
     }
     var new_pin = document.getElementById("txtNewPin").value;
     if(new_pin == "")
     {
      	//Please enter the New PIN
       alert("Tast inn ny PIN-kode, 4 siffer");
       return false;
     }
     var confirm_pin = document.getElementById("txtConfirmPin").value;
     if(confirm_pin == "")
     {
      	//Please enter Confirm New PIN
       alert("Gjenta ny PIN-kode, 4 siffer");
       return false;
     }

     var newPwd = document.getElementById('txtNewPin');
     var confirmPwd = document.getElementById('txtConfirmPin');
     if ((!newPwd.disabled && !confirmPwd.disabled) && (newPwd.value != confirmPwd.value))
     {
       //New PIN does not match Confirm New PIN.
       alert("Ikke samsvar mellom PIN-kodene");
       return false;
     }

     var pin_puk_rule=/^[0-9]*$/;

     var oldPIN = document.getElementById("txtOldPin").value;
     if (oldPIN.length < 4 || !pin_puk_rule.test(oldPIN)) {
 	    //Old PIN: Please enter 4 digits.
 	    alert("Skriv inn den gamle PIN-koden, 4 siffer");
 	    return false;
     }
     var newPIN = document.getElementById("txtNewPin").value;
     if (newPIN.length < 4 || !pin_puk_rule.test(newPIN)) {
 	    //New PIN: Please enter 4 digits.
 	    alert("Tast inn ny PIN-kode, 4 siffer");
 	    return false;
     }
     return true;
   }

   function checkPSKLetter(fieldID, showAlert)
   {
     var fieldObj = document.getElementById(fieldID);
     var fieldValue = fieldObj.value;

     if (showAlert == 0)
     {
       if (fieldValue.length < 9)
       {
       	 return false;
       }
     }

     var checkLetter = 0;
	    for (var idx = 0; idx < fieldValue.length; idx++)
     {
		     var charCode = fieldValue.charCodeAt(idx);
		     if (charCode >= 65 && charCode <= 90)
		     {
			      checkLetter = 1;
		     }
     }
     if (checkLetter == 0)
     {
     	 if (showAlert == 1) {
 	       //Password: Please enter at least one capital letter.
 	       alert("Nettverkspassord: Må ha minst en stor bokstav");
 	       fieldObj.focus();
 	     }
 	     return false;
     }
     checkLetter = 0;
	    for (var idx = 0; idx < fieldValue.length; idx++)
     {
		     var charCode = fieldValue.charCodeAt(idx);
		     if (charCode >= 97 && charCode <= 122)
		     {
			      checkLetter = 1;
		     }
     }
     if (checkLetter == 0)
     {
     	 if (showAlert == 1) {
 	       //Password: Please enter at least one small letter.
 	       alert("Nettverkspassord: Må ha minst en liten bokstav");
 	       fieldObj.focus();
 	     }
 	     return false;
     }
     checkLetter = 0;
	    for (var idx = 0; idx < fieldValue.length; idx++)
     {
		     var charCode = fieldValue.charCodeAt(idx);
		     if (charCode >= 48 && charCode <= 57)
		     {
			      checkLetter = 1;
		     }
     }
     if (checkLetter == 0)
     {
     	 if (showAlert == 1) {
 	       //Password: Please enter at least one number.
 	       alert("Nettverkspassord: Må ha minst en et tall");
 	       fieldObj.focus();
 	     }
 	     return false;
     }
	    return true;
   }

   function wifiValidate()
   {
     var wifi_ssid = document.getElementById("ssid").value;
     if(wifi_ssid == "")
     {
      	//Please enter SSID
       alert("Skriv inn nettverksnavn (SSID)");
       return false;
     }
     if (wifi_ssid.length < 1 || wifi_ssid.length > 32)
     {
      	//SSID: Please enter 1-32 characters.
      	alert("SSID: Må være mellom 1-32 tegn");
      	return false;
     }
     //Only allow to input [a-z], [A-Z], [0-9], '_', '-', '.' and '@' characters.
     if (checkCommonNameField('ssid', "SSID", "Du kan bare bruke tegnene [a-z], [A-Z], [0-9], '_', '-', '.' og '@'") == false) return false;

     var wifi_psk = document.getElementById("pskPassAscii").value;
     if(wifi_psk == "")
     {
      	//Please enter Password
       alert("Skriv inn nettverkspassord");
       return false;
     }
     if (document.getElementById("pskPassAscii").disabled == false)
     {
       //Password: Please enter at least 9 characters.
       if (wifi_psk.length < 9 || wifi_psk.length > 63)
       {
         alert("Passordet må være minst 9 tegn");
         return false;
       }
       //Password
       //Only [a-z], [A-Z], [0-9] characters are allowed
       var pwd_rule1 =/^[0-9a-zA-Z]{0,63}$/;
       if(!pwd_rule1.test(wifi_psk)){
         alert(gettext("Nettverkspassord: Kan bare benytte tegnene  [a-z], [A-Z], [0-9]"));
         return false;
       }
       if (checkPSKLetter('pskPassAscii', 1) == false)
         return false;
       if (checkSSID('ssid') == false) {
 	       //If changing password, must change SSID.
 	       alert("Om du endrer nettverkspassordet må du endre nettverksnavnet (SSID)");
         return false;
       }
     }

     var wifi_ssid_ac = document.getElementById("ssid_ac").value;
     if(wifi_ssid_ac == "")
     {
      	//Please enter SSID
       alert("Skriv inn nettverksnavn (SSID)");
       return false;
     }
     if (wifi_ssid_ac.length < 1 || wifi_ssid_ac.length > 32)
     {
      	//SSID: Please enter 1-32 characters.
      	alert("SSID: Må være mellom 1-32 tegn");
      	return false;
     }
     //Only allow to input [a-z], [A-Z], [0-9], '_', '-', '.' and '@' characters.
     if (checkCommonNameField('ssid_ac', "SSID", "Du kan bare bruke tegnene [a-z], [A-Z], [0-9], '_', '-', '.' og '@'") == false) return false;

     var wifi_psk_ac = document.getElementById("pskPassAscii_ac").value;
     if(wifi_psk_ac == "")
     {
      	//Please enter Password
       alert("Skriv inn nettverkspassord");
       return false;
     }
     if (document.getElementById("pskPassAscii_ac").disabled == false)
     {
       //Password: Please enter at least 9 characters.
       if (wifi_psk_ac.length < 9 || wifi_psk_ac.length > 63)
       {
         alert("Passordet må være minst 9 tegn");
         return false;
       }
       //Password
       //Only [a-z], [A-Z], [0-9] characters are allowed
       var pwd_rule2 =/^[0-9a-zA-Z]{0,63}$/;
       if(!pwd_rule2.test(wifi_psk_ac)){
         alert(gettext("Nettverkspassord: Kan bare benytte tegnene  [a-z], [A-Z], [0-9]"));
         return false;
       }
       if (checkPSKLetter('pskPassAscii_ac', 1) == false)
         return false;
       if (checkSSID('ssid_ac') == false) {
 	       //If changing password, must change SSID.
 	       alert("Om du endrer nettverkspassordet må du endre nettverksnavnet (SSID)");
         return false;
       }
     }

     onNextAdmin();
     return true;
   }

   function checkSSID(fieldID)
   {
	    var hide_ssid = document.getElementById("hide_"+fieldID).value;
	    var show_ssid = document.getElementById(fieldID).value;
	    if (hide_ssid != show_ssid)
	    {
		     return true;
	    } else {
		     return false;
	    }
   }

   function enablePSKKey(fieldID)
   {
     if (document.getElementById(fieldID).disabled == true)
     {
       document.getElementById(fieldID).disabled = false;
       checkPassAscii(fieldID);
     }
   }

   function userValidate()
   {
     var admin_pwd = document.getElementById("password").value;
     if(admin_pwd == "")
     {
      	//Please enter Password
       alert("Skriv inn nytt Admin passord");
       return false;
     }
     if (admin_pwd.length < 1 || admin_pwd.length > 32)
     {
      	//Password: Please enter 1-32 characters
      	alert("Admin passord: Må være mellom 1-32 tegn");
      	return false;
     }
     //Only allow to input [a-z], [A-Z], [0-9], '_', '-', '.' and '@' characters.
     if (checkCommonNameField('password', "Admin passord", "Du kan bare bruke tegnene [a-z], [A-Z], [0-9], '_', '-', '.' og '@'") == false)
       return false;

     var admin_confirm_pwd = document.getElementById("confirm_password").value;
     if(admin_confirm_pwd == "")
     {
      	//Please enter Confirm Password
       alert("Bekreft Admin passord");
       return false;
     }
     if (admin_confirm_pwd.length < 1 || admin_confirm_pwd.length > 32)
     {
      	//Confirm Password: Please enter 1-32 characters
      	alert("Bekreft Admin passord: Må være mellom 1-32 tegn");
      	return false;
     }
     //Only allow to input [a-z], [A-Z], [0-9], '_', '-', '.' and '@' characters.
     if (checkCommonNameField('confirm_password', "Bekreft Admin passord", "Du kan bare bruke tegnene [a-z], [A-Z], [0-9], '_', '-', '.' og '@'") == false)
       return false;

     var admin_pwd = document.getElementById('password');
     var admin_cfm_pwd = document.getElementById('confirm_password');
     if ((!admin_pwd.disabled && !admin_cfm_pwd.disabled) && (admin_pwd.value != admin_cfm_pwd.value))
     {
       //Password does not match Confirm Password.
       alert("Det er ikke samsvar mellom passordene");
       return false;
     }
     onNextComfirm();
     return true;
   }

   function changePlainShow()
   {
     var input1 = document.getElementById ('password').value;
     var input2 = document.getElementById ('confirm_password').value;

     if (document.getElementById('showAdminPwd').checked)
     {
       document.getElementById("password").outerHTML="<input type='text' name='password' id='password' size='25' maxlength='32' />";
       document.getElementById("confirm_password").outerHTML="<input type='text' name='confirm_password' id='confirm_password' size='25' maxlength='32' />";
     }
     else
     {
       document.getElementById("password").outerHTML="<input type='password' name='password' id='password' size='25' maxlength='32' />";
       document.getElementById("confirm_password").outerHTML="<input type='password' name='confirm_password' id='confirm_password' size='25' maxlength='32' />";
     }
     document.getElementById("password").value = input1;
     document.getElementById("confirm_password").value = input2;
   }

   function onVisitWebsite()
   {
   	 //window.close();
	    //window.location = "http://www.telenor.no/minesider";
	    window.open("http://www.telenor.no/minesider");
	    return;
   }

   function checkPassAscii(fieldID)
   {
   	//var cur_pskPassAscii = document.getElementById("pskPassAscii").value;
    if (checkPSKLetter(fieldID, 0) == false)
    {
    	 document.getElementById(fieldID+"_chk").src="../images/Wizard/incorrect.png";
      return false;
   	} else {
   		 document.getElementById(fieldID+"_chk").src="../images/Wizard/correct.png";
      return true;
    }
   }

   function onShowChangePIN()
   {
	    document.getElementById('setup_change_pin_mask').className = "show";
	    document.getElementById('setup_change_pin_popup').className = "show";
   }

   function onCloseChangePIN()
   {
	    document.getElementById('setup_change_pin_mask').className = "hide";
	    document.getElementById('setup_change_pin_popup').className = "hide";
   }

   function onShowDisablePIN()
   {
	    document.getElementById('setup_pin_code').className="hide";
	    document.getElementById('setup_change_pin').className="hide";
	    document.getElementById('setup_disable_pin').className="show";
	    document.getElementById('setup_wifi').className="hide";
	    document.getElementById('setup_admin').className="hide";
	    document.getElementById('setup_confirm').className="hide";
	    document.getElementById('setup_ready').className="hide";

	    onCloseChangePIN();
   }

   function getAllValues()
   {
     var PinCfg = <%getPinConfig();%>;
     var PinCfgArr = PinCfg.split("#");
     document.getElementById('hdPinStatus1').value = PinCfgArr[0];
     if (PinCfgArr[0] == "1" || PinCfgArr[0] == "4") //PIN not verified //PUK
     {
       document.getElementById('hide_pinVerifyCheck').value = 0;
     } else {
     	 document.getElementById('hide_pinVerifyCheck').value = 1;
     }
     document.getElementById('hide_pinRetryLeft').value = PinCfgArr[1];
     document.getElementById('hide_pukRetryLeft').value = PinCfgArr[2];

     var WiFiInfo = <%getSetupWizardWiFiInfo();%>;
     var WiFiInfoArr = WiFiInfo.split("#");
     document.getElementById('ssid').value = WiFiInfoArr[0];
     document.getElementById('pskPassAscii').value = WiFiInfoArr[1];
     document.getElementById('hide_ssid').value = WiFiInfoArr[0];
     document.getElementById('hide_pskPassAscii').value = WiFiInfoArr[1];
     document.getElementById('ssid_ac').value = WiFiInfoArr[2];
     document.getElementById('pskPassAscii_ac').value = WiFiInfoArr[3];
     document.getElementById('hide_ssid_ac').value = WiFiInfoArr[2];
     document.getElementById('hide_pskPassAscii_ac').value = WiFiInfoArr[3];

     var AdminInfo = <%getSetupWizardAdminInfo();%>;
     var AdminInfoArr = AdminInfo.split("#");
     document.getElementById('password').value = AdminInfoArr[0];
     document.getElementById('confirm_password').value = AdminInfoArr[0];

     var CurPinCode = <%getSetupWizardCurPINCode();%>;
     var CurPinCodeArr = CurPinCode.split("#");
     document.getElementById("confirm_pincode").innerHTML = CurPinCodeArr[0];
   }
  //-->
  </script>
 </head>
 <body onload="getAllValues();enablePinConfig();">
  <div class="header">
    <img src="../images/Wizard/Telenor_logo.png" height="60" />
  </div>
  <div class="content">

   <div id="setup_pin_code" class="hide">
    <div class="title">
      <!--<h2>Verify Your PIN Code</h2>-->
      <h2>Gratulerer med ny ruter for Mobilt Bredbånd fra Telenor!</h2>
      <p>Gjennom noen få steg vil vi nå klargjøre ruteren din slik at du kommer deg på nett.</p>
    </div>
    <div class="settings">
      <form name="action_setup_pin_code" method="post" action="">
      <table>
        <tr id="trPinStatusDisp" class="hide">
          <!-- You have typed the wrong PIN code. Please try again. -->
										<th colspan="2"><label>Du har tastet feil PIN kode, prøv igjen</label></th>
        </tr>
								<tr id="trPukStatusDisp" class="hide">
          <!-- You have typed the wrong PUK code. Please try again. -->
										<th colspan="2"><label>Du har tastet feil PUK kode, prøv igjen</label></th>
								</tr>
        <tr id="trPuk" class="hide">
          <!--Enter PUK-->
          <th><label>Tast inn din PUK-kode, 8 siffer</label></th>
          <td>
          	<input type="password" name="lte_puk" id="txtPuk" size="20" maxlength="8" />
          	<a class="info" title="PUK-koden finner du på brevet du mottok sammen med SIM-kortet, eller kan hentes på Telenor Mine Sider"></a>
          </td>
        </tr>
        <tr id="trPin" class="hide">
          <!--Enter PIN-->
          <th id="trPin_label"><label>Tast inn din PIN-kode, 4 siffer</label></th>
          <td>
          	<input type="password" name="lte_pin" id="txtPin" size="20" maxlength="4" />
          	<a id="txtPin_href_title" class="info" title="PIN-koden finner du på brevet du mottok sammen med SIM-kortet"></a>
          </td>
        </tr>
        <tr id="trPinTimes" class="hide">
          <!--PIN Remaining Times&nbsp;&nbsp;-->
          <th colspan="2" id="thPinTimes"><label>0 gjenstående forsøk</label></th>
        </tr>
        <tr id="trPukTimes" class="hide">
          <!--PUK Remaining Times&nbsp;&nbsp;-->
          <th colspan="2" id="thPukTimes"><label>0 gjenstående forsøk</label></th>
        </tr>
      </table>
      <div class="button bnbar">
          <!--Verify PIN-->
          <div><input type="submit" id="btnVerify" value="Godkjenn PIN" title="Godkjenn PIN" onclick="return enterPinValidate();" name="button.verifyPIN.setupWizard" class="hide" /></div>
          <!--<div><input type="button" id="btnPinCodeNext" value="Next" title="Next" onclick="onNextChangePin();" /></div>-->
      </div>
      </form>
    </div>
   </div>

   <div id="setup_change_pin" class="hide">
    <div class="title">
      <!--<h2>Change Your PIN Code</h2>-->
      <h2>Endre PIN-kode</h2>
      <p>Hvis du ønsker å opprette en personlig PIN-kode, velg 'Endre PIN'.</p>
    </div>
    <div class="settings">
      <div class="button bnbar">
          <!--<div><input type="button" value="Previous" title="Previous" onclick="onPreviousPINCode();" /></div>-->
          <!--Next-->
          <div><input type="button" value="Neste" title="Neste" onclick="onNextWiFi();" /></div>
          <!--<div><input type="button" value="Change PIN" title="Change PIN" onclick="onShowChangePIN();" /></div>-->
          <!--Change PIN-->
          <a class="des_text" onclick="onShowChangePIN();">Endre PIN</a>
      </div>
    </div>
   </div>

   <div id="setup_disable_pin" class="hide">
    <div class="title">
      <!--<h2>Verify Your PIN Code</h2>-->
      <h2>Gratulerer med ny ruter for Mobilt Bredbånd fra Telenor!</h2>
      <p>Gjennom noen få steg vil vi nå klargjøre ruteren din slik at du kommer deg på nett.</p>
    </div>
    <div class="settings">
      <div class="button bnbar">
          <div><input type="button" value="Neste" title="Neste" onclick="onNextWiFi();" /></div>
      </div>
    </div>
   </div>

   <div id="setup_wifi" class="hide">
    <div class="title">
      <!--<h2>Wi-Fi Configuration</h2>-->
      <h2>Endre nettverksnavn og passord på ditt trådløse nettverk</h2>
      <p>For at du enklere skal gjenkjenne ditt trådløse nettverk via din Mobilt Bredbåndsruter anbefaler vi at du endrer nettverksnavnet samt nettverkspassordet.</p>
    </div>
    <div class="settings">
      <table>
        <tr>
          <!--802.11n-->
          <th colspan="2"><h3>802.11n</h3></th>
        </tr>
        <tr>
          <!--SSID-->
          <th><label>Tast inn nytt nettverksnavn</label></th>
          <td>
          	<input type="text" name="ssid" id="ssid" value="" size="25" maxlength="32" onkeyup="enablePSKKey('pskPassAscii');" />
          	<a class="info" title="Nettverksnavn (også kalt SSID) er navnet på ditt trådløse nettverk.  Som standard vil det se slik ut: «Telenor4G_XXXXXX». Vi anbefaler at du endrer nettverksnavnet til noe du kjenner igjen slik at du enklere kan skille det fra andre synlige trådløse nettverk. Tillatte tegn er [a-z], [A-Z], [0-9], '_', '-', '.' og '@'."></a>
          </td>
        </tr>
        <tr>
          <!--Password-->
          <th><label>Tast inn nytt nettverkspassord</label></th>
          <td>
          	<input type="text" name="pskPassAscii" id="pskPassAscii" value="" size="25" maxlength="63" disabled onkeyup="checkPassAscii('pskPassAscii');" />
          	<img class="status_icon" src="../images/Wizard/correct.png" id="pskPassAscii_chk" />
          	<a class="info" title="Passordet må inneholde : minst 9 tegn – minst én stor bokstav, minst én liten bokstav. Tillatte tegn er [a-z], [A-Z], [0-9]. Dersom ditt passord ikke godkjennes forsøk med et annet passord."></a>
          </td>
        </tr>
        <tr>
          <!--802.11ac-->
          <th colspan="2"><h3>802.11ac</h3></th>
        </tr>
        <tr>
          <!--SSID-->
          <th><label>Tast inn nytt nettverksnavn</label></th>
          <td>
          	<input type="text" name="ssid_ac" id="ssid_ac" value="" size="25" maxlength="32" onkeyup="enablePSKKey('pskPassAscii_ac');" />
          	<a class="info" title="Nettverksnavn (også kalt SSID) er navnet på ditt trådløse nettverk.  Som standard vil det se slik ut: «Telenor4G_XXXXXX». Vi anbefaler at du endrer nettverksnavnet til noe du kjenner igjen slik at du enklere kan skille det fra andre synlige trådløse nettverk. Tillatte tegn er [a-z], [A-Z], [0-9], '_', '-', '.' og '@'."></a>
          </td>
        </tr>
        <tr>
          <!--Password-->
          <th><label>Tast inn nytt nettverkspassord</label></th>
          <td>
          	<input type="text" name="pskPassAscii_ac" id="pskPassAscii_ac" value="" size="25" maxlength="63" disabled onkeyup="checkPassAscii('pskPassAscii_ac');" />
          	<img class="status_icon" src="../images/Wizard/correct.png" id="pskPassAscii_ac_chk" />
          	<a class="info" title="Passordet må inneholde : minst 9 tegn – minst én stor bokstav, minst én liten bokstav. Tillatte tegn er [a-z], [A-Z], [0-9]. Dersom ditt passord ikke godkjennes forsøk med et annet passord."></a>
          </td>
        </tr>
      </table>
      <div class="button bnbar">
        <!--Previous-->
        <div><input type="button" value="Forrige" title="Forrige" onclick="onPreviousChangePin();" id="btnWifiPrevious" /></div>
        <!--Next-->
        <div><input type="button" value="Neste" title="Neste" onclick="return wifiValidate();" /></div>
      </div>
    </div>
   </div>

   <div id="setup_admin" class="hide">
    <div class="title">
      <!--<h2>Specify the User Password</h2>-->
      <h2>Endre passord for avanserte innstillinger på ruteren</h2>
      <p>Administratorpassordet på din Mobilt Bredbåndsruter gir deg tilgang til avanserte innstillinger. Vi anbefaler at du endrer dette.</p>
    </div>
    <div class="settings">
     <table>
        <tr>
          <!--Password-->
          <th><label>Tast inn nytt Admin passord</label></th>
          <td>
          	<input type="text" name="password" id="password" value="" size="25" maxlength="32" />
          </td>
        </tr>
        <tr>
          <!--Confirm Password-->
          <th><label>Bekreft Admin passord</label></th>
          <td>
          	<input type="text" name="confirm_password" id="confirm_password" value="" size="25" maxlength="32" />
          </td>
        </tr>
        <tr>
          <!--Show Plain Password-->
          <td colspan="2"><input type="checkbox" id="showAdminPwd" onclick="return changePlainShow();" checked="true" /><label>Vis passord</label></td>
        </tr>
     </table>
     <div class="button bnbar">
									<!--Previous-->
									<div><input type="button" value="Forrige" title="Forrige" onclick="onPreviousWiFi();" /></div>
									<!--Next-->
									<div><input type="button" value="Neste" title="Neste" onclick="return userValidate();" /></div>
     </div>
    </div>
   </div>

   <div id="setup_confirm" class="hide">
    <div class="title">
      <!--<h2>Confirm Your Settings</h2>-->
      <h2>Ditt mobile bredbåndsnett vil nå settes opp</h2>
      <p>Takk for at du valgte oss som din leverandør av Mobilt Bredbånd. Under finner du en oversikt over dine nye nettverksinnstillinger.</p>
      <b>Merk! Om du har gjort endringer i nettverksnavnet (SSID) og/eller nettverkpassord må du koble til alle trådløse enheter på nytt etter at ruteren har restartet. Når ruteren restarter vil det ta noen minutter før det nye nettverket er tilgjengelig.</b>
    </div>
      <form name="action_setup_confirm" method="post" action="/goform/setSetupWizardFinish">
      <table class="mobileinfo">
       <tr>
        <!--SSID:-->
        <th>[802.11n] Ditt nettverksnavn:</th>
        <td id="confirm_ssid"></td>
       </tr>
       <tr>
        <!--Wi-Fi Password:-->
        <th>[802.11n] Ditt nettverkspassord:</th>
        <td id="confirm_psk"></td>
       </tr>
       <tr>
        <!--SSID:-->
        <th>[802.11ac] Ditt nettverksnavn:</th>
        <td id="confirm_ssid_ac"></td>
       </tr>
       <tr>
        <!--Wi-Fi Password:-->
        <th>[802.11ac] Ditt nettverkspassord:</th>
        <td id="confirm_psk_ac"></td>
       </tr>
       <tr>
        <!--PIN Code:-->
        <th>PIN-kode for SIM-kort:</th>
        <td id="confirm_pincode"></td>
       </tr>
       <tr>
        <!--Admin Password:-->
        <th>Admin passord:</th>
        <td id="confirm_pwd"></td>
       </tr>
      </table>
      <div class="page_desc">
      <p>Etter at du har fullført husk å registrere et mobilnummer for varsling av forbruk på Telenor Mine Sider.</p>
      </div>
      <input type="hidden" id="inputdata_ssid" name="confirm_ssid" value="" />
      <input type="hidden" id="inputdata_psk" name="confirm_psk" value="" />
      <input type="hidden" id="inputdata_ssid_ac" name="confirm_ssid_ac" value="" />
      <input type="hidden" id="inputdata_psk_ac" name="confirm_psk_ac" value="" />
      <input type="hidden" id="inputdata_pwd" name="confirm_pwd" value="" />
      <div class="settings">
        <div class="button bnbar">
									<!--Previous-->
									<div><input type="button" value="Forrige" title="Forrige" onclick="onPreviousUser();" /></div>
									<!--<div><input type="submit" value="Finish" title="Finish" name="button.setupWizard.index" /></div>-->
									<!--Finish-->
									<div><input type="submit" value="Fullfør" title="Fullfør" name="button.setupWizardFinish.setupWizard" /></div>
        </div>
      </div>
      </form>
   </div>

   <div id="setup_ready" class="hide">
    <div class="title">
      <!--<h2>Ready</h2>-->
      <h2>Ditt Mobile Bredbånd kobles nå opp!</h2>
      <p>Dette kan ta noen minutter.</p>
    </div>
    <div class="page_desc">
    	 <p>Lukk og start nettleseren på nytt og du er klar for Internett.</p>
      <p><b>Husk</b> å registrere et mobilnummer for varsling av forbruk på Telenor Mine Sider.</p>
    </div>
    <input type="hidden" id="hide_action_setup_ready" value="<%setSetupWizardReady();%>" />
   </div>

  <input type="hidden" id="hdPinStatus1" value="0" />
  <input type="hidden" id="hide_pinVerifyCheck" value="0" />
  <input type="hidden" id="hide_ssid" value="" />
  <input type="hidden" id="hide_pskPassAscii" value="" />
  <input type="hidden" id="hide_ssid_ac" value="" />
  <input type="hidden" id="hide_pskPassAscii_ac" value="" />
  <input type="hidden" id="hide_pinRetryLeft" value="" />
  <input type="hidden" id="hide_pukRetryLeft" value="" />

  </div>

  <div id="setup_change_pin_mask" class="hide">
    <div class="page_mask"></div>
  </div>
  <div id="setup_change_pin_popup" class="hide">
   <div class="popup_frame">
    <div class="title">
      <!--<h2>Change Your PIN Code</h2>-->
      <h2>Endre PIN-kode</h2>
    </div>
    <div class="settings">
      <form name="action_setup_change_pin_popup" method="post" action="/goform/setSetupWizardChangePin">
      <table>
        <tr>
          <!--Old PIN-->
          <th><label>Skriv inn den gamle PIN-koden, 4 siffer</label></th>
          <td>
          	<input type="password" name="lte_OldPin" id="txtOldPin" size="20" maxlength="4" />
          </td>
        </tr>
        <tr>
          <!--New PIN-->
          <th><label>Tast inn ny PIN-kode, 4 siffer</label></th>
          <td>
          	<input type="password" name="lte_NewPin" id="txtNewPin" size="20" maxlength="4" />
          </td>
        </tr>
        <tr>
          <!--Confirm New PIN-->
          <th><label>Gjenta ny PIN-kode, 4 siffer</label></th>
          <td>
          	<input type="password" name="lte_ConfirmPin" id="txtConfirmPin" size="20" maxlength="4" />
          </td>
        </tr>
      </table>
      <div class="button bnbar">
          <!--Apply-->
          <div><input type="submit" value="OK" title="OK" onclick="return changePinValidate();" name="button.changePin.setupWizard" /></div>
          <!--Cancel-->
          <div><input type="button" value="Tilbake" title="Tilbake" onclick="onCloseChangePIN();" /></div>
      </div>
      </form>
    </div>
   </div>
  </div>

 </body>
</html>