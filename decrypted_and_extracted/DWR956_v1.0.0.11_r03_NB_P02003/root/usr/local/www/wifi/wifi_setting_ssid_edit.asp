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
var WiFiSSIDEditInfo = <%getWiFiSSIDEditInfo();%>;
var WiFiSSIDEditArr = WiFiSSIDEditInfo.split("#");
var edit_flag=0;
if (WiFiSSIDEditInfo=="") edit_flag=0; //Add
else edit_flag=1; //Edit

function pageLoad()
{
	if (WiFiSSIDEditInfo == ""){  //Add
		document.getElementById('scheduleStatus').checked = false;
		document.getElementById('scheduleName').value = "";
		document.getElementById('startHour').value = "";
		document.getElementById('startMinute').value = ""
		document.getElementById('startMeridian').selectedIndex = 0;
		document.getElementById('stopHour').value = "";
		document.getElementById('stopMinute').value = ""
		document.getElementById('stopMeridian').selectedIndex = 0;
		
		document.getElementById('org_scheduleStatus').value="0";
	}else{					     //Edit
	    if (WiFiSSIDEditArr[1] == "0")
		  document.getElementById('scheduleStatus').checked = false;
		else
		  document.getElementById('scheduleStatus').checked = true;
		document.getElementById('scheduleName').value = WiFiSSIDEditArr[0];
		document.getElementById('startHour').value = WiFiSSIDEditArr[2];
		document.getElementById('startMinute').value = WiFiSSIDEditArr[3];
		if (WiFiSSIDEditArr[4] == "0")
		  document.getElementById('startMeridian').selectedIndex = 0;
		else
		  document.getElementById('startMeridian').selectedIndex = 1;
		document.getElementById('stopHour').value = WiFiSSIDEditArr[5];
		document.getElementById('stopMinute').value = WiFiSSIDEditArr[6];
		if (WiFiSSIDEditArr[7] == "0")
		  document.getElementById('stopMeridian').selectedIndex = 0;
		else
		  document.getElementById('stopMeridian').selectedIndex = 1;

		document.getElementById('WiFiName').value=WiFiSSIDEditArr[0];
		
		document.getElementById('org_scheduleStatus').value=WiFiSSIDEditArr[1];
	}
}

function checkActive()
{
  if (document.getElementById('scheduleStatus').checked == true){
  	alert(gettext("Set the active time of schedule to enable, all the active time of other schedule rules are disabled."));
  }
}

function checkWIFIssidEdit()
{
	if(!CheckLoginInfo())
		return false;
   var WiFiNameIsSel = <%getWiFiNameIsSel();%>;
   var WiFiNameIsSelArr = WiFiNameIsSel.split("#");
   var length = WiFiNameIsSelArr.length;
   var row = 0;
   var name = document.getElementById("scheduleName").value;
   var name_rule =/^[a-zA-Z0-9-_@\.]+$/;

   var meridian1 = document.getElementById('startMeridian').value;
   var meridian2 = document.getElementById('stopMeridian').value;
   var hr1 = parseInt (document.getElementById('startHour').value, 10);
   var hr2 = parseInt (document.getElementById('stopHour').value, 10);
   var min1 = parseInt (document.getElementById('startMinute').value,10);
   var min2 = parseInt (document.getElementById('stopMinute').value,10);
   var min = min2 - min1;

   var time_rule =/^[0-9]{0,3}$/;	
   
   if (name == ""){
   	 alert(gettext("Schedule Name: please input [a-z], [A-Z], [0-9], '_', '-', '.' and '@' characters."));
     document.getElementById("scheduleName").focus();
     return false;
   }

   if (edit_flag==0){
     for(row = 0; row < length; row += 1){
  	  if (WiFiNameIsSelArr[row] == name){
	    alert("The schedule name is duplicated, can't be used.");	
	    return false;
  	  }  
     }
   }   

   if(!name_rule.test(name)){
     alert(gettext("Schedule Name: Only allow to input [a-z], [A-Z], [0-9], '_', '-', '.' and '@' characters."));
     document.getElementById("scheduleName").focus();
     return false;
   }

   //Start Time
   if (document.getElementById('startHour').value == ""){
   	 alert(gettext("Start Hour: please input value between 1-12."));
     document.getElementById("startHour").focus();
     return false;
   }

   if (!time_rule.test(hr1)) {
   	  alert(gettext("Start Hour: please input value between 1-12."));
   	  document.getElementById("startHour").focus();
      return false;
   }
   
   if ((hr1 < 1) ||(hr1 > 12)) {
   	alert("Start Hour: please input value between 1-12.");
	document.getElementById("startHour").focus();
	return false;
   }

   if (document.getElementById('startMinute').value == ""){
   	 alert(gettext("Start Minute: please input value between 0-59."));
     document.getElementById("startMinute").focus();
     return false;
   }

   if (!time_rule.test(min1)) {
   	  alert(gettext("Start Minute: please input value between 0-59."));
   	  document.getElementById("startMinute").focus();
      return false;
   }

   if (min1 > 59){
   	 alert(gettext("Start Minute: please input value between 0-59."));
     document.getElementById("startMinute").focus();
	return false;
   }	
  
   //Stop Time
   if (document.getElementById('stopHour').value == ""){
   	 alert(gettext("Stop Hour: please input value between 1-12."));
     document.getElementById("stopHour").focus();
     return false;
   }

   if (!time_rule.test(hr2)) {
   	  alert(gettext("Stop Hour: please input value between 1-12."));
   	  document.getElementById("stopHour").focus();
      return false;
   }
   
   if ((hr2 < 1)||(hr2 > 12)) {
   	alert("Stop Hour: please input value between 1-12.");
	document.getElementById("stopHour").focus();
	return false;
   }

   if (document.getElementById('stopMinute').value == ""){
   	 alert(gettext("Stop Minute: please input value between 0-59."));
     document.getElementById("stopMinute").focus();
     return false;
   }

   if (!time_rule.test(min2)) {
   	  alert(gettext("Stop Minute: please input value between 0-59."));
   	  document.getElementById("stopMinute").focus();
      return false;
   }

   if (min2 > 59){
   	 alert(gettext("Stop Minute: please input value between 0-59."));
     document.getElementById("stopMinute").focus();
	 return false;
   }

   if( meridian1 == meridian2 ){
     if(hr1 == hr2){
       if(min1 >= min2) {
   	     alert("Start Minute should be less than Stop Minute.");
     	 return false;
       }else{
         if (min < 5){
		   alert("Stop Time should be more than Start Time at least 5 minutes.");
		   document.getElementById('stopMinute').focus();
     	   return false;	
	   	 }
       }
     } else if(hr1>hr2){
       if (hr1 != 12) {
         alert("Start Hour should be less than Stop Hour.");
     	 return false;
       }
     } else {  //hr1 < hr2
       if (meridian1 == "0"){  //AM 12:00 = 00:00, PM 12:00 = 24:00
	   	 if (hr2==12){ 
	   	   hr2 = 0;
	   	 }  
       }
       var Time1 = hr1*60 + min1;
	   var Time2 = hr2*60 + min2;
	   var Time = Time2 - Time1;
	   if(Time2<Time1){
	   	 var msg=gettext("AM 12:") + min2 + gettext(" is 00:") + min2 + gettext(". The Start time should be less than Stop time.") ;
         alert(msg);
		 return false;
       }
	   if (Time < 5){
		   alert("Stop Time should be more than Start Time at least 5 minutes.");
		   document.getElementById('stopMinute').focus();
     	   return false;	
	   }
     }
   } else if (meridian1 == "1" && meridian2 == "0") {
    	alert("The Start Meridian should be less than Stop Meridian.");
    	return false;
   }

   return true;
}
</script>	
</head>	

<body id="wifiEdit" onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftMenuChange("wifi_settings", "wifi_settings_href");</script>
<!-- Main Menu and Submenu End -->

 <div class="contentBg">
    <div class="secH1"><script>document.write(gettext("Wi-Fi Settings Schedules Configuration"));</script></div>
    <div class="secBg">
    <div class="statusMsg"></div>
    <div class="secInfo"><br><script>document.write(gettext("In this section you can add a schedule rule to enable/disable wireless functionality."));</script>
                         <br><a href="wifi_settings.asp" class="secLable1">&#187; <script>document.write(gettext("Back to Wi-Fi Settings page"));</script></a>
    </div>
    <form method="post" action="/goform/setWiFiSSIDEdit">
    <input type="hidden" id="WiFiName" name="WiFiName" value="" />
    <input type="hidden" id="org_scheduleStatus" name="org_scheduleStatus" value="" />
    <table cellspacing="0" id="WiFissidEditTable" class="configTbl">
      <tr>
        <td><script>document.write(gettext("Active Time"));</script></td>
        <td><input type="checkbox" name="scheduleStatus" id="scheduleStatus" onclick="checkActive();"></td>
	  </tr>
	  <tr>
        <td><script>document.write(gettext("Schedule Name"));</script></td>
        <td><input class="configF1" type="text" name="scheduleName" id="scheduleName" size="20" maxlength="32" /></td>
      </tr>
      <tr>
      <td><script>document.write(gettext("Start Time"));</script></td>
      <td>
        <input type="text" name="startHour" id="startHour" size="5" class="configF1" maxlength="2" onkeypress="return onkeypress_number_only(event);" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck2(this, '', '', 1, 12, true, 'Invalid hours','','date1Err');}"><span class="spanText"><script>document.write(gettext("hours"));</script></span>
        <input type="text" name="startMinute" id="startMinute" size="5" class="configF1" maxlength="2" onkeypress="return onkeypress_number_only (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck2(this, '', '', 0, 59, true, 'Invalid minutes','','date1Err');}"><span class="spanText"><script>document.write(gettext("minutes"));</script></span>
        <select size="1" name="startMeridian" class="configF1" id="startMeridian">
          <option value="0"><script>document.write(gettext("AM"));</script></option>
          <option value="1"><script>document.write(gettext("PM"));</script></option>
        </select></td>
      <td id="date1Err1">&nbsp;</td>
      </tr>
      <tr>
      <td><script>document.write(gettext("Stop Time"));</script></td>
      <td>
        <input type="text" name="stopHour" id="stopHour" size="5" class="configF1" maxlength="2" onkeypress="return onkeypress_number_only (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck2(this, '', '', 1, 12, true, 'Invalid hours','','date2Err');}"><span class="spanText"><script>document.write(gettext("hours"));</script></span>
        <input type="text" name="stopMinute" id="stopMinute" size="5" class="configF1" maxlength="2" onkeypress="return onkeypress_number_only (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck2(this, '', '', 0, 59, true, 'Invalid minutes','','date2Err');}"><span class="spanText"><script>document.write(gettext("minutes"));</script></span>
        <select size="1" name="stopMeridian" class="configF1" id="stopMeridian">
      	  <option value="0"><script>document.write(gettext("AM"));</script></option>
      	  <option value="1"><script>document.write(gettext("PM"));</script></option>
      </select></td>
      <td id="date2Err2">&nbsp;</td>
      </tr>
    </table>
    <!--Button Start-->
	<div>
	  <input type="submit" id="edit_apply" value="Apply" class="tblbtn" title="Apply" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return checkWIFIssidEdit();">
	  <input type="reset" value="Reset" class="submit" id="button.reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();"/>
	</div>
	<!--Button End-->
	</form>
   </div>
 </div>
</div>
<script type="text/javascript">
  document.getElementById('edit_apply').value=gettext("Apply");
  document.getElementById('edit_reset').value=gettext("Reset");
</script>
</body>
</html>
