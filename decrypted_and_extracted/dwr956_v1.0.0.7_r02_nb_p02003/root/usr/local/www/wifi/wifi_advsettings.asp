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

function initWifiInfo()
{
  var WifiRadio = <%getWifiRadio();%>;
  var RadioArr = WifiRadio.split("#");
  var Mode = RadioArr[0];
  var Channel = RadioArr[1];
  var Width = RadioArr[2];
  var Band = RadioArr[3];
  var Transmit = RadioArr[4];

  Channel = parseInt(Channel, 10);

  //Mode
  switch (Mode)
  {
  	case "b":
       document.getElementById("wifi_mode").selectedIndex=0;
       break;
    case "g":
       document.getElementById("wifi_mode").selectedIndex=1;
       break;
    case "bgn":
	   document.getElementById("wifi_mode").selectedIndex=2;
       break;		   
    default:
	   break;
  }

  if((Mode == "b") || (Mode == "g") || (Mode == "bg")){   //b, g, bg
  	document.getElementById("wifi_channel0").selectedIndex = Channel;
  	document.getElementById("width1").style.display = "";
	document.getElementById("width2").style.display = "none";
	document.getElementById("wifiband").style.display = "";
	document.getElementById("wifi_band").disabled=true;

	document.getElementById("band").style.display = "";
	document.getElementById("band_above").style.display = "none";
	document.getElementById("band_below").style.display = "none";
  }else{                                //others
    document.getElementById("width1").style.display = "none";
	document.getElementById("width2").style.display = "";
	if (Width == 20)
    {
       document.getElementById("wifi_channel0").selectedIndex = Channel;
       document.getElementById("wifi_width2").selectedIndex=0;

	   document.getElementById("wifiband").style.display = "";
	   document.getElementById("wifi_band").disabled=true;

	   document.getElementById("band").style.display = "";
	   document.getElementById("band_above").style.display = "none";
	   document.getElementById("band_below").style.display = "none";
     }else{
       document.getElementById("wifiband").style.display = "";  
	   document.getElementById('wifi_band').disabled=false;
       document.getElementById("wifi_width2").selectedIndex=1;
	   document.getElementById("band").style.display = "none";
	   if( Band  == "0"){
	   	 document.getElementById("wifi_channel1").selectedIndex=Channel; 
		 document.getElementById("wifi_band").selectedIndex=0;
		 document.getElementById("band").style.display = "none";
	   	 document.getElementById("band_above").style.display = "";
	     document.getElementById("band_below").style.display = "none";
       } else {
         if(Channel != 0){ Channel = Channel - 4; }    
		 document.getElementById("wifi_channel2").selectedIndex=Channel; 
		 document.getElementById("wifi_band").selectedIndex=1;
		 document.getElementById("band").style.display = "none";
		 document.getElementById("band_above").style.display = "none";
		 document.getElementById("band_below").style.display = "";
       }
  	}	   
  }

  //Transmit power
  switch (Transmit)
  {
  	case "0":
       document.getElementById("wifi_transmit_power").selectedIndex=0;
       break;
    case "-1":
       document.getElementById("wifi_transmit_power").selectedIndex=1;
       break;
    case "-3":
       document.getElementById("wifi_transmit_power").selectedIndex=2;
       break;
    default:
	   break;
  }
}

function initWifiAP()
{
  var WifiInfo = <%getWifi(0);%>;
  var WifiArr = WifiInfo.split("#");

  document.getElementById("wifi_interval").value=WifiArr[10];
  document.getElementById("wifi_threshold").value=WifiArr[11];
}

function selectMode()
{
  var sMode = document.getElementById("wifi_mode").selectedIndex;
  var sWidth = document.getElementById("wifi_width2").selectedIndex; 
  var sBand = document.getElementById("wifi_band").selectedIndex; 
  if((sMode == 0) || (sMode == 1)){  //b, g, bg
  	document.getElementById("width1").style.display = "";
	document.getElementById("width2").style.display = "none";

	document.getElementById("wifiband").style.display = "";
	document.getElementById("wifi_band").disabled=true;

	document.getElementById("band").style.display = "";
	document.getElementById("band_above").style.display = "none";
	document.getElementById("band_below").style.display = "none";
  }else{                            //others
    document.getElementById("width1").style.display = "none";
	document.getElementById("width2").style.display = "";
	if (sWidth == 0){  //20MHz            
 
	  document.getElementById("wifiband").style.display = "";
	  document.getElementById("wifi_band").disabled=true;

      document.getElementById("band").style.display = "";
      document.getElementById("band_above").style.display = "none";
      document.getElementById("band_below").style.display = "none";
	}else{	           //20/40MHz
		document.getElementById("wifiband").style.display = "";
		document.getElementById("wifi_band").disabled=false;
	  if(sBand == 0){        //Above
		document.getElementById("band").style.display = "none";	
        document.getElementById("band_above").style.display = "";
        document.getElementById("band_below").style.display = "none";
      }else{                 //Below
        document.getElementById("band").style.display = "none";
	    document.getElementById("band_above").style.display = "none";
        document.getElementById("band_below").style.display = "";	    
	  }
	}	
  }
}

function selectWidth()
{
  var sWidth = document.getElementById("wifi_width2").selectedIndex; 
  var sBand = document.getElementById("wifi_band").selectedIndex; 
  document.getElementById("width1").style.display = "none";
  document.getElementById("width2").style.display = "";
  if (sWidth == 0){  //20MHz            

	  document.getElementById("wifiband").style.display = "";
	  document.getElementById("wifi_band").disabled=true;

      document.getElementById("band").style.display = "";
      document.getElementById("band_above").style.display = "none";
      document.getElementById("band_below").style.display = "none";
  }else{	         //20/40MHz
  	  document.getElementById("wifiband").style.display = "";
	  document.getElementById("wifi_band").disabled=false;
	  document.getElementById("band").style.display = "none";	
	  if(sBand == 0){        //Above
        document.getElementById("band_above").style.display = "";
        document.getElementById("band_below").style.display = "none";
      }else{                 //Below
	    document.getElementById("band_above").style.display = "none";
        document.getElementById("band_below").style.display = "";	    
	  }
  }
}

function selectBand()
{
  var sBand = document.getElementById("wifi_band").selectedIndex;
  if(sBand == 0){  //Above
  	document.getElementById("band").style.display = "none";
    document.getElementById("band_above").style.display = "";
    document.getElementById("band_below").style.display = "none";
  }else{           //Below
    document.getElementById("band").style.display = "none";
    document.getElementById("band_above").style.display = "none";
    document.getElementById("band_below").style.display = "";	    
  }
}

function checkWIFIAdvSettings()
{
	if(!CheckLoginInfo())
		return false;

	document.wifi_setting.action="/goform/setWifiRadio";
	document.wifi_setting.submit();
    return true;

  	//var sBeacon = document.getElementById("wifi_interval").value;
    //var sthreshold = document.getElementById("wifi_threshold").value;
    //var sthreshold_rule =/^[0-9]{3,5}$/;	
    //if (sthreshold == "") {
    //	alert(gettext("Please input value between 100 ~ 61952."));
    //	document.getElementById("wifi_threshold").focus();
    //	return false;
    //} 
  
    //if (sBeacon == "") {
    //   alert(gettext("Please input 100 multiple between 100 ~ 1000."));
    //   document.getElementById("wifi_interval").focus();
    //   return false;
    //}

    //if (!sthreshold_rule.test(sthreshold)) {
    //	alert(gettext("Please input value between 100 ~ 61952."));
    //	document.getElementById("wifi_threshold").focus();
    //  return false;
    //}
  
    //if ((sthreshold < 100) || (sthreshold > 61952)) {
    //	alert(gettext("Please input value between 100 ~ 61952."));
    //	document.getElementById("wifi_threshold").focus();
    //   return false;
    //}
    
    //if (sBeacon < 1001)
	//{
    //	if((!(sBeacon%100)) && sBeacon>0)
	//	{
    //  		document.wifi_setting.action="/goform/setWifiRadio";
	//		document.wifi_setting.submit();
    //  		return true;
    //	} 
	//	else 
	//	{
    //  		alert(gettext("Please input 100 multiple between 100 ~ 1000."));
	//  		document.getElementById("wifi_interval").focus();
	//  		return false;
    //	}
  	//} else {
    //	alert(gettext("Please input 100 multiple between 100 ~ 1000."));
	//	document.getElementById("wifi_interval").focus();
	//	return false;
  	//}
}
</script>	
</head>	

<body id="wifiAdvPage" onload="initWifiInfo();initWifiAP();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftSubMenuChange("wifi_submenu", "wifi_advsettings","wifi_802.11n","wifi_802.11n_href");</script>
<!-- Main Menu and Submenu End -->

 <div class="contentBg">
   <div class="secH1"><script>document.write(gettext("Wi-Fi Advanced"));</script></div>
   <div class="secBg">
   <div class="secInfo"><br><script>document.write(gettext("Specify advanced configuration settings for the gateways radio from this page."));</script></br></div>
    <form name="wifi_setting" method="post">
    <table class="configTbl" cellpadding="0">
      <tr>
    	<td><script>document.write(gettext("Mode"));</script></td>
    	<td><select name="wifi_mode" size="1" class="configF1"  id="wifi_mode" onChange="selectMode();">
          <option value="b"><script>document.write(gettext("b only"));</script></option>
          <option value="g"><script>document.write(gettext("g only"));</script></option>
          <option value="bgn"><script>document.write(gettext("b/g/n mode"));</script></option>
      	</select></td>
      </tr>
  	  <tr id="width1" style="display:none;">
      <td><script>document.write(gettext("Channel Spacing"));</script></td>
      <td><select class="configF1" name="wifi_width1" id="wifi_width1" size="1">
          <option value="20"><script>document.write(gettext("20 MHz"));</script></option>
      </select></td>      
      </tr>
  	  <tr id="width2" style="display:none;">
      <td><script>document.write(gettext("Channel Spacing"));</script></td>
      <td><select class="configF1" name="wifi_width2" id="wifi_width2" size="1" onChange="selectWidth();">
          <option value="20"><script>document.write(gettext("20 MHz"));</script></option>
          <option value="2040"><script>document.write(gettext("20/40 MHz"));</script></option>
        </select></td>      
      </tr>
  	  <tr id="wifiband" style="display:none;">
      <td><script>document.write(gettext("Control Side Band"));</script></td>
      <td><select class="configF1" name="wifi_band" id="wifi_band" size="1" onChange="selectBand();">
          <option value="0"><script>document.write(gettext("Above"));</script></option>
          <option value="1"><script>document.write(gettext("Below"));</script></option>
      </select></td>      
      </tr>
  	  <tr id="band" style="display:none;">
      <td><script>document.write(gettext("Channel"));</script></td>
      <td>
        <select class="configF1" name="wifi_channel0" id="wifi_channel0" size="1">
          <option value="0"><script>document.write(gettext("Auto"));</script></option>
          <option value="1"><script>document.write(gettext("Channel"));</script> 1</option>
		  <option value="2"><script>document.write(gettext("Channel"));</script> 2</option>
		  <option value="3"><script>document.write(gettext("Channel"));</script> 3</option>
		  <option value="4"><script>document.write(gettext("Channel"));</script> 4</option>
		  <option value="5"><script>document.write(gettext("Channel"));</script> 5</option>
		  <option value="6"><script>document.write(gettext("Channel"));</script> 6</option>
		  <option value="7"><script>document.write(gettext("Channel"));</script> 7</option>
		  <option value="8"><script>document.write(gettext("Channel"));</script> 8</option>
		  <option value="9"><script>document.write(gettext("Channel"));</script> 9</option>
		  <option value="10"><script>document.write(gettext("Channel"));</script> 10</option>
		  <option value="11"><script>document.write(gettext("Channel"));</script> 11</option>
		  <option value="12"><script>document.write(gettext("Channel"));</script> 12</option>
		  <option value="13"><script>document.write(gettext("Channel"));</script> 13</option>
        </select></td>      
    </tr>    
  	  <tr id="band_above" style="display:none;">
      <td><script>document.write(gettext("Channel"));</script></td>
      <td>
        <select class="configF1" name="wifi_channel1" id="wifi_channel1" size="1">
          <option value="0"><script>document.write(gettext("Auto"));</script></option>
          <option value="1"><script>document.write(gettext("Channel"));</script> 1</option>
		  <option value="2"><script>document.write(gettext("Channel"));</script> 2</option>
		  <option value="3"><script>document.write(gettext("Channel"));</script> 3</option>
		  <option value="4"><script>document.write(gettext("Channel"));</script> 4</option>
		  <option value="5"><script>document.write(gettext("Channel"));</script> 5</option>
		  <option value="6"><script>document.write(gettext("Channel"));</script> 6</option>
		  <option value="7"><script>document.write(gettext("Channel"));</script> 7</option>
		  <option value="8"><script>document.write(gettext("Channel"));</script> 8</option>
		  <option value="9"><script>document.write(gettext("Channel"));</script> 9</option>
        </select></td>      
    </tr>    
    <tr id="band_below" style="display:none;">
      <td><script>document.write(gettext("Channel"));</script></td>
      <td>
        <select class="configF1" name="wifi_channel2" id="wifi_channel2" size="1">
          <option value="0"><script>document.write(gettext("Auto"));</script></option>
          <option value="5"><script>document.write(gettext("Channel"));</script> 5</option>
		  <option value="6"><script>document.write(gettext("Channel"));</script> 6</option>
		  <option value="7"><script>document.write(gettext("Channel"));</script> 7</option>
		  <option value="8"><script>document.write(gettext("Channel"));</script> 8</option>
		  <option value="9"><script>document.write(gettext("Channel"));</script> 9</option>
		  <option value="10"><script>document.write(gettext("Channel"));</script> 10</option>
		  <option value="11"><script>document.write(gettext("Channel"));</script> 11</option>
		  <option value="12"><script>document.write(gettext("Channel"));</script> 12</option>
		  <option value="13"><script>document.write(gettext("Channel"));</script> 13</option>
        </select></td>      
    </tr>
    <tr style="display:none;">
      <td><script>document.write(gettext("Beacon Interval"));</script></td>
      <td><input class="configF1" type="text" name="wifi_interval" id="wifi_interval" onkeypress="return onkeypress_number_only(event)" maxlength="4"/></td>
      <td>&nbsp;<script>document.write(gettext("(100 multiple between 100~1000)"));</script></td>      
    </tr>
    <tr style="display:none;">
      <td><script>document.write(gettext("RTS Threshold"));</script></label></td>
      <td><input class="configF1" type="text" name="wifi_threshold" id="wifi_threshold" onkeypress="return onkeypress_number_only(event)" maxlength="5"/></td>      
      <td>&nbsp;<script>document.write(gettext("(Between 100~61952)"));</script></td>      
    </tr>
    <tr style="display:none;">
      <td><script>document.write(gettext("Fragmentation Threshold"));</script></td>
      <td><input class="configF1" type="text" /></td>      
    </tr>      
    <tr>
      <td><script>document.write(gettext("Transmit Power"));</script></td>
      <td>
        <select class="configF1" name="wifi_transmit_power" id="wifi_transmit_power" size="1">
          <option value="0">100%</option>
          <option value="-1">75%</option>
		  <option value="-3">50%</option>
        </select></td>      
    </tr>
    </table>   
	<div>
	  <input type="submit" id="adv_apply" value="Apply" class="tblbtn" title="Apply" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return checkWIFIAdvSettings();">
	  <input type="submit" id="adv_reset" value="Reset" class="tblbtn" title="Reset" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="doRedirect();">
	</div>
   </form> 
   </div>
 </div>
</div>
<script type="text/javascript">
	document.getElementById('adv_apply').value=gettext("Apply");
	document.getElementById('adv_reset').value=gettext("Reset");
</script>
</body>
</html>
