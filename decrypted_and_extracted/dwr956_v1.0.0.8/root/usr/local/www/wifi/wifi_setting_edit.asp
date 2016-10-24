<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script language="Javascript" src="../js/common.js" type="text/javascript"></script>

<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);
var wlan = "";

function getWifiInit()
{
	var wifiInfo=<%getWiFiEdit();%>;
	var WifiArr = wifiInfo.split("#");

	//WLAN ID
	wlan = WifiArr[14];  //SSID1, SSID2, SSID3

	//SSID Enabled
	if ( WifiArr[0] == "0")
		document.getElementById("SSIDenable").checked = false;
	else 
		document.getElementById("SSIDenable").checked = true;
	
	//SSID
	document.getElementById("ssid1").value=WifiArr[1];
	
	//BroadCast
	if ( WifiArr[2] == "0")
		document.getElementById("bssid_en1").checked = false;
	else 
		document.getElementById("bssid_en1").checked = true;

	if ((WifiArr[14] == "1")||(WifiArr[14] == "2")){
	  document.getElementById("security1").style.display = "";
  	  document.getElementById("security3").style.display = "none";
	  //Security
	  var WifiEnc = WifiArr[3];
      switch (WifiEnc) {
    		case "OPEN":
    		 document.getElementById("enc_idx1").selectedIndex=0;
    		 break;
    		case "WEP":
    		 document.getElementById("enc_idx1").selectedIndex=1;
    		 break;
    		case "WPA":
    		 document.getElementById("enc_idx1").selectedIndex=2;
    		 break;
    		case "WPA2":
    		 document.getElementById("enc_idx1").selectedIndex=3;
    		 break;
    		case "WPAWPA2":
    		 document.getElementById("enc_idx1").selectedIndex=4;
    		 break;
    		default:
    		 break;
      }
	  encgroup();
	}else if ((WifiArr[14] == "3")||(WifiArr[14] == "4")){
	  document.getElementById("security1").style.display = "none";
  	  document.getElementById("security3").style.display = "";
	  //Security
	  var WifiEnc = WifiArr[3];
      switch (WifiEnc) {
    		case "OPEN":
    		 document.getElementById("enc_idx3").selectedIndex=0;
    		 break;
    		case "WPA":
    		 document.getElementById("enc_idx3").selectedIndex=1;
    		 break;
    		case "WPA2":
    		 document.getElementById("enc_idx3").selectedIndex=2;
    		 break;
    		case "WPAWPA2":
    		 document.getElementById("enc_idx3").selectedIndex=3;
    		 break;
    		default:
    		 break;
      }
	  encgroup3();
	}
	
	//PSK key and WEP password
	document.getElementById("pskascii1").value=WifiArr[4];
	document.getElementById("wepkey01").value=WifiArr[5];

	//Beacon Interval
	document.getElementById("wifi_interval").value=WifiArr[10];

	//RTS Threshold
	document.getElementById("wifi_rts").value=WifiArr[11];

	//Fragmentation Threshold
	document.getElementById("wifi_frag").value=WifiArr[12];
}

function encgroup()
{
		var encIdx1 = document.getElementById("enc_idx1").value;
		document.getElementById("div_WPA1").style.display = "none";
		document.getElementById("div_WEP1").style.display = "none";

		if (encIdx1 == "OPEN")
		{
			document.getElementById("div_WPA1").style.display = "none";
			document.getElementById("div_WEP1").style.display = "none";
		} else if (encIdx1 == "WEP") {
			document.getElementById("div_WPA1").style.display = "none";
			document.getElementById("div_WEP1").style.display = "block";
		} else {
			document.getElementById("div_WPA1").style.display = "block";
			document.getElementById("div_WEP1").style.display = "none";
		}
}

function encgroup3()
{
		var encIdx3 = document.getElementById("enc_idx3").value;
		document.getElementById("div_WPA1").style.display = "none";
		document.getElementById("div_WEP1").style.display = "none";

		if (encIdx3 == "OPEN")
		{
			document.getElementById("div_WPA1").style.display = "none";
			document.getElementById("div_WEP1").style.display = "none";
		} else {
			document.getElementById("div_WPA1").style.display = "block";
			document.getElementById("div_WEP1").style.display = "none";
		}
}

function PasswordPlain1Disable(state)
{
  var pwd1 = document.getElementById("pskascii1").value;
  if(state == true){
    document.getElementById("pskascii1").outerHTML=
     "<input class='box' id='pskascii1' name='pskascii1' type='text' size='20' maxlength='64' />";
  } else {
    document.getElementById("pskascii1").outerHTML=
    "<input class='box' id='pskascii1' name='pskascii1' type='password' size='20' maxlength='64' />";
  }
  document.getElementById("pskascii1").value = pwd1;
}

function PasswordWEP1Disable(state)
{
  var pwd1 = document.getElementById("wepkey01").value;
  if(state == true){
    document.getElementById("wepkey01").outerHTML=
         "<input class='box' id='wepkey01' name='wepkey01' type='text' size='20' maxlength='26' />";
  } else {
    document.getElementById("wepkey01").outerHTML=
         "<input class='box' id='wepkey01' name='wepkey01' type='password' size='20' maxlength='26' />";
  }
  document.getElementById("wepkey01").value = pwd1;
}

function checkWIFIEdit()
{
   if(!CheckLoginInfo())
		return false;
   var ssid1 = document.getElementById("ssid1").value;
   var pwd1 = document.getElementById("pskascii1").value;
   var code_rule =/^[0-9a-zA-Z\_\-\.]{0,32}$/;
   var pwd_rule1 =/^[0-9a-zA-Z]{0,63}$/;
   var pwd_rule2 =/^[0-9a-fA-F]{0,64}$/;
   var wep_key1 = document.getElementById("wepkey01").value;
   var wep_rule1 = /^[0-9a-zA-Z]{5}$/;
   var wep_rule2 = /^[0-9a-zA-Z]{13}$/;
   var wep_rule3 = /^[0-9a-fA-F]{10}$/;
   var wep_rule4 = /^[0-9a-fA-F]{26}$/;
   var wifiActFlag=<%getwifiActFlag();%>;

   if (document.getElementById("SSIDenable").checked == true){
     if(wifiActFlag == "1"){
	 	alert(gettext("Conflict with the scheduled Rule."));
		document.getElementById("SSIDenable").checked = false;
		document.getElementById("SSIDenable").focus();
		return false;
     }
   } else if (document.getElementById("SSIDenable").checked == false){
     if(wifiActFlag == "1"){
	 	alert(gettext("Conflict with the scheduled Rule."));
		document.getElementById("SSIDenable").checked = true;
		document.getElementById("SSIDenable").focus();
		return false;
     }
   }	 
   
   if (wlan == "1"){
     if (!COMPS.WIFI.onsubmit_ssid(document.getElementById("ssid1"), "AP 1")){
       return false;
     }
   }else if (wlan == "2"){
   	 if (!COMPS.WIFI.onsubmit_ssid(document.getElementById("ssid1"), "AP 2")){
       return false;
     }
   }else if (wlan == "3"){
   	 if (!COMPS.WIFI.onsubmit_ssid(document.getElementById("ssid1"), "AP 3")){
       return false;
     }
   }else if (wlan == "4"){
   	 if (!COMPS.WIFI.onsubmit_ssid(document.getElementById("ssid1"), "AP 4")){
       return false;
     }
   }
  
   if(!code_rule.test(ssid1)){
     alert(gettext("SSID: Accept 0-9,a-z,A-Z,\'_-.\' or not accept Chinese format."));
     document.getElementById("ssid1").focus();
     return false;
   }

if ((wlan == "1")||(wlan == "2")){  
   var ap1_sec_type = document.getElementById("enc_idx1").value;
   if (ap1_sec_type == "WEP"){
     if (!COMPS.WIFI.onsubmit_wep(document.getElementById("wepkey01"), "AP 1", "1")){
       return false;
     }
  
  	   if(wep_key1.length == 5){
       if(!wep_rule1.test(wep_key1)){
         alert(gettext("WEP: 5 charts accept only 0-9,a-z,A-Z."));
         document.getElementById("wepkey01").focus();
         return false;
       }
     }else if(wep_key1.length == 13){
       if(!wep_rule2.test(wep_key1)){
         alert(gettext("WEP: 13 charts accept only 0-9,a-z,A-Z."));
         document.getElementById("wepkey01").focus();
         return false;
       }
     }else if(wep_key1.length == 10){
     	 if(!wep_rule3.test(wep_key1)){
         alert(gettext("WEP: 10 charts accept only 0-9,a-f,A-F."));
         document.getElementById("wepkey01").focus();
         return false;
       }
     }else if(wep_key1.length == 26){
       if(!wep_rule4.test(wep_key1)){
         alert(gettext("WEP: 26 charts accept only 0-9,a-f,A-F."));
         document.getElementById("wepkey01").focus();
         return false;
       }
     }else{
       alert(gettext("ASCII: 5 or 13 0-9, a-z, A-Z charts. Hex: 10 or 26 0-9, a-f, A-F charts."));
       document.getElementById("wepkey01").focus();
       return false;
     }
     
   } 
   else if (ap1_sec_type == "WPA" || ap1_sec_type == "WPA2" || ap1_sec_type == "WPAWPA2")
   {
     if(pwd1.length < 8 || pwd1.length > 64){
       alert(gettext("The input should be Hex 64 charts or Ascii 8~63 charts"));
  	   document.getElementById("pskascii1").focus();
       return false;
     }else if(pwd1.length > 7 && pwd1.length < 64){
       if(!pwd_rule1.test(pwd1)){
         alert(gettext("Password: Accept only 0-9,a-z,A-Z."));
         document.getElementById("pskascii1").focus();
         return false;
       }
     }else if(pwd1.length > 63){
       if(!pwd_rule2.test(pwd1)){
         alert(gettext("Password: Accept only 0-9,a-f,A-F."));
         document.getElementById("pskascii1").focus();
         return false;
       }
     }
   }
   else if (ap1_sec_type == "OPEN")
   {
     if (document.getElementById("SSIDenable").checked == true){
	   alert(gettext("Warning: The Wi-Fi network will be activated in OPEN mode with no password or encryption protection."));	
     }  
   }
} else if ((wlan == "3")||(wlan == "4")){
   var ap3_sec_type = document.getElementById("enc_idx3").value;
   if (ap3_sec_type == "WPA" || ap3_sec_type == "WPA2" || ap3_sec_type == "WPAWPA2")
   {
     if(pwd1.length < 8 || pwd1.length > 64){
       alert(gettext("The input should be Hex 64 charts or Ascii 8~63 charts"));
  	   document.getElementById("pskascii1").focus();
       return false;
     }else if(pwd1.length > 7 && pwd1.length < 64){
       if(!pwd_rule1.test(pwd1)){
         alert(gettext("Password: Accept only 0-9,a-z,A-Z."));
         document.getElementById("pskascii1").focus();
         return false;
       }
     }else if(pwd1.length > 63){
       if(!pwd_rule2.test(pwd1)){
         alert(gettext("Password: Accept only 0-9,a-f,A-F."));
         document.getElementById("pskascii1").focus();
         return false;
       }
     }
   }
   else if (ap3_sec_type == "OPEN")
   {
     if (document.getElementById("SSIDenable").checked == true){
	   alert(gettext("Warning: The Wi-Fi network will be activated in OPEN mode with no password or encryption protection."));	
     }  
   }
}  
   
   //Advanced Configuration check
   var sBeacon = document.getElementById("wifi_interval").value;
   var sthreshold = document.getElementById("wifi_rts").value;
   var sFrag = document.getElementById("wifi_frag").value;
   var sthreshold_rule =/^[0-9]{3,5}$/;	
   var sfrag_rule =/^[0-9]{3,5}$/;	
   var sbeacon_rule =/^[0-9]{2,5}$/;	
   if (sBeacon == "") {
      alert(gettext("Beacon Interval: Please enter a value between 20 ~ 1000."));
      document.getElementById("wifi_interval").focus();
      return false;
   }
   
   if (sthreshold == "") {
   	alert(gettext("RTS Threshold: Please input value between 256 ~ 2346."));
   	document.getElementById("wifi_rts").focus();
   	return false;
   } 

   if (sFrag == "") {
   	alert(gettext("Fragmentation Threshold: Please enter a value between 257 ~ 2346."));
   	document.getElementById("wifi_frag").focus();
   	return false;
   } 

   if (!sbeacon_rule.test(sBeacon)) {
   	alert(gettext("Beacon Interval: Please enter a value between 20 ~ 1000."));
   	document.getElementById("wifi_interval").focus();
    return false;
   }
   
   if (!sthreshold_rule.test(sthreshold)) {
   	alert(gettext("RTS Threshold: Please enter a value between 256 ~ 2346."));
   	document.getElementById("wifi_rts").focus();
    return false;
   }
   
   if (!sfrag_rule.test(sFrag)) {
   	alert(gettext("Fragmentation Threshold: Please enter a value between 257 ~ 2346."));
   	document.getElementById("wifi_frag").focus();
    return false;
   }

   sBeacon = parseInt(sBeacon, 10);
   sthreshold = parseInt(sthreshold, 10);
   sFrag = parseInt(sFrag, 10);
   
   if ((sBeacon < 20) || (sBeacon > 1000)) {
   	alert(gettext("Beacon Interval: Please enter a value between 20 ~ 1000."));
   	document.getElementById("wifi_interval").focus();
    return false;
   }

   if ((sthreshold < 256) || (sthreshold > 2346)) {
   	alert(gettext("RTS Threshold: Please enter a value between 256 ~ 2346."));
   	document.getElementById("wifi_rts").focus();
       return false;
   }

   if ((sFrag < 257) || (sFrag > 2346)) {
   	alert(gettext("Fragmentation Threshold: Please enter a value between 257 ~ 2346."));
   	document.getElementById("wifi_frag").focus();
    return false;
   }
   
   return true;
}
</script>	
</head>	

<body id="wifiEdit" onload="getWifiInit();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftMenuChange("wifi_settings", "wifi_settings_href");</script>
<!-- Main Menu and Submenu End -->

 <div class="contentBg">
    <div class="secH1"><script>document.write(gettext("Wi-Fi Settings Configuration"));</script></div>
    <div class="secBg">
    <div class="statusMsg"></div>
    <div class="secInfo"><br>&nbsp;&nbsp;<a href="wifi_settings.asp" class="secLable1">&#187; <script>document.write(gettext("Back to Wi-Fi Settings page"));</script></a></div>
    <form name="wifi_setting_edit" action="/goform/setWiFiEdit" method="post">
    <div class="secH2"><script>document.write(gettext("Wireless Configuration"));</script></div>	
    <br/>
    <table class="configTbl" cellspacing="0" >
      <tr>
		<td width="150"><script>document.write(gettext("Enable SSID"));</script></td>
        <td><input type="checkbox" name="SSIDenable" id="SSIDenable"/></td>
      </tr>
  	  <tr>
    	<td><script>document.write(gettext("SSID"));</script></td>
    	<td><input class="configF1" id="ssid1" name="ssid1" type="text" maxlength="32" size="20"/></td>
  	  </tr>
  	  <tr>
    	<td><script>document.write(gettext("Broadcast SSID"));</script></td>
    	<td><input type="checkbox" name="bssid_en1" id="bssid_en1"/></td>
  	  </tr>
      <tr id="security1" style="display:none;">
    	<td><script>document.write(gettext("Security"));</script></td>
    	<td><select name="enc_idx1" id="enc_idx1" onChange="encgroup();" class="configF1">
            <option value="OPEN"><script>document.write(gettext("OPEN"));</script></option>
			<option value="WEP"><script>document.write(gettext("WEP Personal"));</script></option>
			<option value="WPA"><script>document.write(gettext("WPA Personal"));</script></option>
			<option value="WPA2"><script>document.write(gettext("WPA2 Personal"));</script></option>
			<option value="WPAWPA2"><script>document.write(gettext("WPA+WPA2"));</script></option>  
        </select></td>
  	  </tr>
  	  <tr id="security3" style="display:none;">
    	<td><script>document.write(gettext("Security"));</script></td>
    	<td><select name="enc_idx3" id="enc_idx3" onChange="encgroup3();" class="configF1">
            <option value="OPEN"><script>document.write(gettext("OPEN"));</script></option>
			<option value="WPA"><script>document.write(gettext("WPA Personal"));</script></option>
			<option value="WPA2"><script>document.write(gettext("WPA2 Personal"));</script></option>
			<option value="WPAWPA2"><script>document.write(gettext("WPA+WPA2"));</script></option>  
        </select></td>
  	  </tr>
  	</table>
  	<!--WPA, WPA2, WPA+WPA2-->
    <div id="div_WPA1" style="display:block;">
    <table class="configTbl" cellspacing="0">
      <tr>
      	<td width="150"><script>document.write(gettext("Password:"));</script></td>
      	<td><input class="configF1" id="pskascii1" name="pskascii1" type="password" size="20"/>
      	<script>document.write(gettext("Note: 8 to 63-digits ASCII,or 64-digits HEX."));</script></td>
      </tr>
      <tr>
      	<td><script>document.write(gettext("Show Plain Password:"));</script></td>
        <td><input type="checkbox" id="plain1" name="plain1" onclick="PasswordPlain1Disable(this.checked);" style="margin-left:10px;"></td>      	
      </tr>
    </table>
    </div>
    <!--WPA, WPA2, WPA+WPA2 end-->

	<!--WEP-->
    <div id="div_WEP1" style="display:none;">
    <table class="configTbl" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td width="150"><script>document.write(gettext("Password:"));</script></td>
      	<td><input class="configF1" id="wepkey01" name="wepkey01" type="password" size="20" />
      	<script>document.write(gettext("Note: 5 or 13-digits ASCII,or 10 or 26-digits HEX."));</script></td>
      </tr>
      <tr>
        <td><script>document.write(gettext("Show Plain Password:"));</script></td>
        <td><input type="checkbox" onclick="PasswordWEP1Disable(this.checked);" style="margin-left:10px;"></td>
      </tr>
    </table>
    </div>
    <!--WEP end-->
    <div class="secInfo"></div>
    <div class="secH2">Advanced Configuration</div>	
    <br />
    <table class="configTbl" cellspacing="0" >
      <tr>
		<td><script>document.write(gettext("Beacon Interval"));</script></td>
        <td><input type="text" class="configF1" id="wifi_interval" name="wifi_interval" maxlength="4" size="6" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 20, 1000, true, '', '');}"></td>
        <td>&nbsp;<script>document.write(gettext("(Between 20~1000)"));</script></td>
      </tr>
  	  <tr>
    	<td class="lbl1"><script>document.write(gettext("RTS Threshold"));</script></td>
    	<td class="lbl2"><input type="text" class="configF1" id="wifi_rts" name="wifi_rts" maxlength="4" size="6" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 256, 2346, true, '', '');}"></td>
    	<td>&nbsp;<script>document.write(gettext("(Between 256~2346)"));</script></td>      
  	  </tr>
  	  <tr>
    	<td class="lbl1"><script>document.write(gettext("Fragmentation Threshold"));</script></td>
    	<td class="lbl2"><input type="text" class="configF1" id="wifi_frag" name="wifi_frag" maxlength="4" size="6" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 257, 2346, true, '', '');}"></td>
    	<td>&nbsp;<script>document.write(gettext("(Between 257~2346)"));</script></td>  
  	  </tr>
    </table>
    <!--Button Start-->
    <div>
	  <input type="submit" value="Apply" class="submit" id="button.apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return checkWIFIEdit();" />
	  <input type="reset" value="Reset" class="submit" id="button.reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();"/>
	</div>
	<!--Button End-->
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
