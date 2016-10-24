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

var WPSinfo;
var WPSinfoArr;
var WPSinfo2;
var WPSinfoArr2;
var WPSinfo3;
var WPSinfoArr3;
function getWPSInfobyIdx()
{
      WPSinfo = <%getWifi(0);%>;
      WPSinfoArr = WPSinfo.split("#");
	  WPSinfo2 = <%getWifi(1);%>;
	  WPSinfoArr2 = WPSinfo2.split("#");
	  WPSinfo3 = <%getWifi(2);%>;
	  WPSinfoArr3 = WPSinfo3.split("#");

	  document.getElementById("apen1").style.display = "";
  	  document.getElementById("apen3").style.display = "none";
  
      if (WPSinfoArr[12] == "1"){
      	  document.getElementById("ap_en1").checked = true;
      }else{
          document.getElementById("ap_en1").checked = false;
      }

	  if (WPSinfoArr3[12] == "1"){
      	  document.getElementById("ap_en3").checked = true;
      }else{
          document.getElementById("ap_en3").checked = false;
      }
}

function selectSSID()
{
	var sSSID = document.getElementById("ssidOption").selectedIndex;
	if (sSSID == 0){
	  if (WPSinfoArr[12] == "1"){
      	  document.getElementById("ap_en1").checked = true;
      }else{
          document.getElementById("ap_en1").checked = false;
      }
	  document.getElementById('ssid_dummy').value = "0";	
	  document.getElementById("apen1").style.display = "";
  	  document.getElementById("apen3").style.display = "none";
	}else if (sSSID == 1){
	  if (WPSinfoArr3[12] == "1"){
      	  document.getElementById("ap_en3").checked = true;
      }else{
          document.getElementById("ap_en3").checked = false;
      }
	  document.getElementById('ssid_dummy').value = "1";
	  document.getElementById("apen1").style.display = "none";
  	  document.getElementById("apen3").style.display = "";
	}
}

function setWPSInfobyIdx()
{
  var wps_idx = document.getElementById("wps_idx").value;
  if (wps_idx == 0)
  {
	document.getElementById("div_WPS2").style.display = "none";
	document.getElementById("div_WPS1_ENABLE").style.display = "";
	document.getElementById("div_WPS2_ENABLE").style.display = "none";
  }else{
	document.getElementById("div_WPS2").style.display = "";
	document.getElementById("div_WPS1_ENABLE").style.display = "none";
	document.getElementById("div_WPS2_ENABLE").style.display = "";
  }
} 

function PBCenter(Ele)
{
	if(!CheckLoginInfo())
		return false;
  	var WPSinfo = <%getWifi(0);%>;
  	var WPSinfoArr = WPSinfo.split("#");
	var WPSinfo2 = <%getWifi(1);%>;
	var WPSinfoArr2 = WPSinfo2.split("#");
	var WPSinfo3 = <%getWifi(2);%>;
	var WPSinfoArr3 = WPSinfo3.split("#");
	
 	if(Ele.id == "PBC1") {	
      if (WPSinfoArr[12] == "1") {            //SSID1
        if(WPSinfoArr[3] == "WEP") {
    	  alert(gettext("SSID1: WPS function can not work when Security Type is WEP."));
    	  return false;
      	}
    	document.getElementById('pbc1_dummy').value="1";
    	document.wps_pbc1.action="/goform/setWPSPBC1";
    	document.wps_pbc1.submit();
      } else if (WPSinfoArr3[12] == "1"){    //SSID3
        document.getElementById('pbc1_dummy').value="3";
    	document.wps_pbc1.action="/goform/setWPSPBC1";
    	document.wps_pbc1.submit();
      } else{								 //SSID1 and SSID3 is '0'	
        alert(gettext("WPS function can not work when SSID1 and SSID3 are Disable."));
    	return false;
      }
   	} else if(Ele.id == "PBC2") {
	  if (WPSinfoArr2[12] == "1"){    		//SSID2
    	if(WPSinfoArr2[3] == "WEP")	{
		  alert(gettext("SSID2: WPS function can not work when Security Type is WEP."));
		  return false;
  		}
		document.getElementById('pbc1_dummy').value="2";
		document.wps_pbc2.action="/goform/setWPSPBC2";
		document.wps_pbc2.submit();
      } 
  	}	
  	return true;
}

function enterPinValidate(Ele)
{
	if(!CheckLoginInfo())
		return false;
    var pin_rule=/^[0-9]*$/;

	if(Ele.id == "wps_pin1")
	{
  		var PinCode = document.getElementById("pin1").value;

		if (WPSinfoArr[12] == "1") {          //SSID1
    		if(WPSinfoArr[3] == "WEP")
    		{
    		    alert(gettext("SSID1: WPS function can not work when Security Type is WEP."));
    			return false;
    		}
     		if(PinCode.length == 4 || PinCode.length == 8)
    		{
    			if(!pin_rule.test(PinCode))
    			{
    				alert(gettext("Enter PIN: Please enter 4 or 8 digits."));
    	    		return false;
    			}
    		} else {
    			alert(gettext("Enter PIN: Please enter 4 or 8 digits."));
    	    	return false;
    		}
			document.getElementById("pin1_dummy").value="1";
    		document.wps_pin1.action="/goform/setWPSPIN1";
    		document.wps_pin1.submit();
		}else if (WPSinfoArr3[12] == "1"){    //SSID3
			var PinCode = document.getElementById("pin1").value;
			
			if(WPSinfoArr[3] == "WEP")
    		{
    		    alert(gettext("SSID3: WPS function can not work when Security Type is WEP."));
    			return false;
    		}
     		if(PinCode.length == 4 || PinCode.length == 8)
    		{
    			if(!pin_rule.test(PinCode))
    			{
    				alert(gettext("Enter PIN: Please enter 4 or 8 digits."));
    	    		return false;
    			}
    		} else {
    			alert(gettext("Enter PIN: Please enter 4 or 8 digits."));
    	    	return false;
    		}
			document.getElementById("pin1_dummy").value="3";
    		document.wps_pin1.action="/goform/setWPSPIN1";
    		document.wps_pin1.submit();
		}else{
		    alert(gettext("WPS function can not work when SSID1 and SSID3 are Disable."));
    		return false;
		}
  		return true;
	}
	else if(Ele.id == "wps_pin2")
	{
  		var PinCode = document.getElementById("pin2").value;
 		if(PinCode.length == 4 || PinCode.length == 8)
		{
			if(!pin_rule.test(PinCode))
			{
				alert(gettext("Enter PIN: Please enter 4 or 8 digits."));
	    		return false;
			}
		} 
		else 
		{
			alert(gettext("Enter PIN: Please enter 4 or 8 digits."));
	    	return false;
		}
		document.wps_pin2.action="/goform/setWPSPIN2";
		document.wps_pin2.submit();
		document.wps_pin2.submit();
  		return true;
	}
}

function WPS1Disable(state)
{   
    if (WPSinfoArr3[12] == "0"){
	  document.getElementById("ap_en1").checked = state;
    }else{
      if (state == true){	
	  	alert(gettext("The SSID3 is enabled. The SSID1 cannot set to enable."));
		document.getElementById("ap_en1").checked = false;
		return false;
      }else{
      	document.getElementById("ap_en1").checked = state;  
      }
    }
}

function WPS2Disable(state)
{
    document.getElementById("ap_en2").checked = state;
}

function WPS3Disable(state)
{
    if (WPSinfoArr[12] == "0"){
	  document.getElementById("ap_en3").checked = state;
    }else{
      if (state == true){	
	  	alert(gettext("The SSID1 is enabled. The SSID3 cannot set to enable."));
		document.getElementById("ap_en3").checked = false;
		return false;
      }else{
      	document.getElementById("ap_en3").checked = state;  
      }
    }
}

function submitActionWPS1(Ele)
{
	if(!CheckLoginInfo())
		return false;
  	if(WPSinfoArr[3] == "WEP")
	{
		alert(gettext("WPS function can not work when Security Type is WEP."));
		return false;
  	}  

	var sSSID = document.getElementById("ssidOption").selectedIndex;
	if (sSSID == 0){
	  document.getElementById('ssid_dummy').value = "0";	
  	  if (document.getElementById("ap_en1").checked == false){
    	document.getElementById("ap_en1").value = "off";
  	  }else{
    	document.getElementById("ap_en1").value = "on";
  	  }
    }else if (sSSID == 1){
	  document.getElementById('ssid_dummy').value = "1";	
  	  if (document.getElementById("ap_en3").checked == false){
      	document.getElementById("ap_en3").value = "off";
      }else{
      	document.getElementById("ap_en3").value = "on";
      }
    }
  	document.AP_ENABLE.action="/goform/setWPS1Enable" ;
  	document.AP_ENABLE.submit();
  	return true;
}

function submitActionWPS2(Ele)
{
  	if(WPSinfoArr[3] == "WEP")
	{
		alert(gettext("WPS function can not work when Security Type is WEP."));
		return false;
  	} 
  	if (document.getElementById("ap_en2").checked == false)
	{
    	document.getElementById("ap_en2").value = "off";
  	}
	else
	{
    	document.getElementById("ap_en2").value = "on";
  	}  
  	document.AP2_ENABLE.action="/goform/setWPS2Enable";
  	document.AP2_ENABLE.submit();
  	return true;
}
</script>	
</head>

<body id="wifiWPSPage" onload="getWPSInfobyIdx();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftMenuChange("wifi_wps", "wifi_wps_href");</script>
<!-- Main Menu and Submenu End -->

<!-- Right Content start -->
<div class="contentBg">
  <div class="secH1"><script>document.write(gettext("Wi-Fi Protected Setup(WPS)"));</script></div>
  <div class="secBg">
  <div class="statusMsg"></div>
  <div class="secInfo"></div>
  <div class="secH2"><script>document.write(gettext("Wifi Protected Setup"));</script></div>						
  <div class="secInfo"><br><script>document.write(gettext("WPS is a standard for easy and secure setup of a wireless connection. In this section you can enable WPS for a client connection using WPA/WPA2 security."));</script><br></div>

  <!--WPS1 enable/disable start-->
  <div id="div_WPS1_ENABLE" style="display:block;">
  <form name="AP_ENABLE" method="post">
  <input type="hidden" name="wps1_dummy" value="0">  
  <input type="hidden" name="ssid_dummy" id="ssid_dummy" value="0">  
  <table cellspacing="0" class="configTbl">
    <tr id="apen1" style="display:none;">
      <td><script>document.write(gettext("Enable Wi-Fi Protected Setup (WPS)"));</script></td>
      <td><input name="ap_en1" id="ap_en1" type="checkbox" checked=false onclick="WPS1Disable(this.checked);"/></td>
    </tr>
    <tr id="apen3" style="display:none;">
      <td><script>document.write(gettext("Enable Wi-Fi Protected Setup (WPS)"));</script></td>
      <td><input name="ap_en3" id="ap_en3" type="checkbox" checked=false onclick="WPS3Disable(this.checked);"/></td>
    </tr>
    <tr>
      <td><script>document.write(gettext("SSID"));</script></td>	
      <!--td class="lbl2" id="ssidOption"><%getSSIDoptions();%></td-->
      <td><select size="1" name="ssidOption" id="ssidOption" class="configF1" onChange="selectSSID();">
		<%getSSIDoptions();%>
 	  </select></td>
    </tr>
  </table>
  <div>
    <input type="submit" id="apply_wps1" value="Apply" class="tblbtn" title="Apply" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return submitActionWPS1();">
	<input type="submit" id="reset_wps1" value="Reset" class="tblbtn" title="Reset" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="doRedirect();">
  </div>
  </form>
  </div>
  <!--WPS1 enable/disable end--> 

  <!--WPS2 enable/disable start-->
  <div id="div_WPS2_ENABLE" style="display:none;">
  <form name="AP2_ENABLE" method="post">
  <input type="hidden" name="wps2_dummy" value="0">  
  <table cellspacing="0" class="configTbl">
    <tr>
      <td><script>document.write(gettext("Enable Wi-Fi Protected Setup (WPS)"));</script></td>
      <td><input name="ap_en2" id="ap_en2" type="checkbox" checked=false onclick="WPS2Disable(this.checked);"/></td>
    </tr>
    <tr>
      <td><script>document.write(gettext("SSID"));</script></td>	
      <td class="lbl2" id="ssidOption"><%getSSIDoptions();%></td>
    </tr>           
  </table>
  <div>
    <input type="submit" id="apply_wps2" value="Apply" class="tblbtn" title="Apply" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return submitActionWPS2();">
	<input type="submit" id="reset_wps2" value="Reset" class="tblbtn" title="Reset" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="doRedirect();">
  </div>
  </form>
  </div>
  <!--WPS2 enable/disable end-->
  
  <!--SSID 1 start-->
  <div class="secH2"><script>document.write(gettext("Push Button Connect (PBC)"));</script></div>
  <div class="secInfo"><br><script>document.write(gettext("Press the WPS button on the client that supports WPS connectivity. Immediately after click the PBC button in this section to establish a wireless link to the routers AP."));</script><br></div>
  <div class="submitBg">
  <table cellspacing="0" class="configTbl">
    <form name="wps_pbc1" method="post">
      <input type="hidden" name="pbc1_dummy" id="pbc1_dummy" value="0">
      <tr><td><input type="submit" id="PBC1" name="PBC1" value="Click for PBC" class="tblbtn" title="Click for PBC" onclick="PBCenter(this);" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td></tr> 
    </form>
  </table>
  </div>
  <div class="secH2"><script>document.write(gettext("Personal Identification Number (PIN)"));</script></div>
  <div class="secInfo"><br><script>document.write(gettext("Enter the clients Personal Identification Number to establish a wireless link to this router AP."));</script><br></div>
  <div class="submitBg">
  <form name="wps_pin1" method="post">
  <input type="hidden" name="pin1_dummy" id="pin1_dummy" value="0">
  <table cellspacing="0" class="configTbl">
    <tr>
      <td><script>document.write(gettext("Client PIN"));</script></td>
      <td><input id="pin1" name="PIN1" type="text" class="configF1" maxlength="8" onkeypress="return onkeypress_number_only(event);"/></td>
    </tr> 
  </table>
  <table cellspacing="0" class="configTbl">  
    <tr><td><input type="submit" id="wps_pin1" name="WPS_PIN1" value="Via PIN" class="tblbtn" title="Via PIN" onclick="return enterPinValidate(this);" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td></tr>
  </table>
  </form>
  </div>
  <!--SSID 1 end--> 
  
  <!--SSID 2-->
  <div class="secH2" style="display:none"><script>document.write(gettext("Push Button Connect (PBC)"));</script></div>
  <div class="secInfo" style="display:none"><br><script>document.write(gettext("Press the WPS button on the client that supports WPS connectivity. Immediately after click the PBC button in this section to establish a wireless link to the routers AP."));</script><br></div>
  <div class="submitBg" style="display:none">
  <table cellspacing="0" class="configTbl">
    <form name="wps_pbc2" method="post">
      <input type="hidden" name="pbc2_dummy" value="0">
      <tr><td><input type="submit" id="PBC2" name="PBC2" value="Click for PBC" class="tblbtn" title="Click for PBC" onclick="PBCenter(this);" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td></tr> 
    </form>
  </table>
  </div>
  <div class="secH2" style="display:none"><script>document.write(gettext("Personal Identification Number (PIN)"));</script></div>
  <div class="secInfo" style="display:none"><br><script>document.write(gettext("Enter the clients Personal Identification Number to establish a wireless link to this router AP."));</script><br></div>
  <div class="submitBg" style="display:none">
  <form name="wps_pin2" method="post">
  <table cellspacing="0" class="configTbl">
    <tr>
      <td><script>document.write(gettext("Client PIN"));</script></td>
      <td><input id="pin2" name="PIN1" type="text" class="configF1" maxlength="8" onkeypress="return onkeypress_number_only(event);"/></td>
    </tr> 
  </table>
  <table cellspacing="0" class="configTbl">  
    <tr><td><input type="submit" id="wps_pin2" name="WPS_PIN2" value="Via PIN" class="tblbtn" title="Via PIN" onclick="enterPinValidate(this);" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td></tr>
  </table>
  </form>
  </div>
  <!--SSID 2 end-->  
</div>
</div>
</div>
<script type="text/javascript">
  document.getElementById('apply_wps1').value=gettext("Apply");
  document.getElementById('reset_wps1').value=gettext("Reset");
  document.getElementById('PBC1').value=gettext("Click for PBC");
  document.getElementById('wps_pin1').value=gettext("Via PIN");
  document.getElementById('apply_wps2').value=gettext("Apply");
  document.getElementById('reset_wps2').value=gettext("Reset");
  document.getElementById('PBC2').value=gettext("Click for PBC");
  document.getElementById('wps_pin2').value=gettext("Via PIN");  
</script>
</body>
</html>
