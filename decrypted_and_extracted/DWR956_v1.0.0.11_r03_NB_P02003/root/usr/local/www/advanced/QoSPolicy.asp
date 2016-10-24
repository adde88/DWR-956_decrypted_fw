<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html>
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
var nat_enable=<%getFwNatEnable();%>;
if(nat_enable!="1")
{
	window.location.href="../login.asp";
}

function SessionValidate()
{
	if(!CheckLoginInfo())
		return false;
	var obj = document.getElementById('txtSessions').value;
	var i18n_enterValidSession = "Invalid Value. The Limit Sessions cannot be empty.";
	var i18n_enterValidSessionObj = document.getElementById('i18n_invalidNum');
	if(i18n_enterValidSessionObj) i18n_enterValidSession = i18n_enterValidSessionObj.value;

	var limit_rule =/^[0-9]{1,5}$/;	

	if (!limit_rule.test(obj)) {
   	  alert(gettext("Limit Sessions: Please enter a value between 1 ~ 4096."));
   	  document.getElementById("txtSessions").focus();
      return false;
    }

	obj = parseInt(obj, 10);

	if ((obj < 1) || (obj > 4096)) {
      alert(gettext("Limit Sessions: Please enter a value between 1 ~ 4096."));
      document.getElementById("txtSessions").focus();
      return false;
    }
    /*if(obj){
    	if (obj.value == "")
    	{
    		alert (i18n_enterValidSession);
    		return false;
    	}
    
    	if (numericValueRangeCheck(obj, '', '', 1, 4096, true, 'Invalid Value.', '.') == false)
    	{
    		return false;
    	}
    }*/

	return true;
}

function BandWidthEnableCheck(state)
{
	document.getElementById("BandWidthEnable").checked = state;
	if (document.getElementById("BandWidthEnable").checked == true){
    	document.getElementById("BandWidthEnable").value = "on";
		//BandWidth DL
    	document.getElementById('QOS_THROUGHPUT_DL').disabled = false;
    	document.getElementById('QOS_HIGHEST_DL').disabled = false;
    	document.getElementById('QOS_HIGH_DL').disabled = false;
    	document.getElementById('QOS_NORMAL_DL').disabled = false;
    	document.getElementById('QOS_LOW_DL').disabled = false;
       	//BandWidth UL
    	document.getElementById('QOS_THROUGHPUT_UL').disabled = false;
    	document.getElementById('QOS_HIGHEST_UL').disabled = false;
    	document.getElementById('QOS_HIGH_UL').disabled = false;
    	document.getElementById('QOS_NORMAL_UL').disabled = false;
    	document.getElementById('QOS_LOW_UL').disabled = false;
       	//Priority
        document.getElementById("QOS_DEFAULT").disabled = false;
  	}else{
  		document.getElementById("BandWidthEnable").value = "off";
		//BandWidth DL
    	document.getElementById('QOS_THROUGHPUT_DL').disabled = true;
    	document.getElementById('QOS_HIGHEST_DL').disabled = true;
    	document.getElementById('QOS_HIGH_DL').disabled = true;
    	document.getElementById('QOS_NORMAL_DL').disabled = true;
    	document.getElementById('QOS_LOW_DL').disabled = true;
       	//BandWidth UL
    	document.getElementById('QOS_THROUGHPUT_UL').disabled = true;
    	document.getElementById('QOS_HIGHEST_UL').disabled = true;
    	document.getElementById('QOS_HIGH_UL').disabled = true;
    	document.getElementById('QOS_NORMAL_UL').disabled = true;
    	document.getElementById('QOS_LOW_UL').disabled = true;
       	//Priority
        document.getElementById("QOS_DEFAULT").disabled = true;
  	}
}

function SessionLimitEnableCheck(state)
{
	document.getElementById("SessionLimitEnable").checked = state;
	if (document.getElementById("SessionLimitEnable").checked == true){
    	document.getElementById("SessionLimitEnable").value = "on";
  	}else{
  		document.getElementById("SessionLimitEnable").value = "off";
  	}
}

function checkBWApply()
{
  if(!CheckLoginInfo())
		return false;
  var msg;
  var input_rule=/^[0-9]*$/;

  if (document.getElementById("BandWidthEnable").checked == false){
      document.getElementById("BandWidthEnable").value = "off";
      //document.BtnApply.onClick();
  }else{
      document.getElementById("BandWidthEnable").value = "on";

	  var ul_total = document.BandwidthManageForm.QOS_THROUGHPUT_UL.value;
      var dl_total = document.BandwidthManageForm.QOS_THROUGHPUT_DL.value;
      var ul_highest = document.BandwidthManageForm.QOS_HIGHEST_UL.value;
      var dl_highest = document.BandwidthManageForm.QOS_HIGHEST_DL.value;
      var ul_high = document.BandwidthManageForm.QOS_HIGH_UL.value;
      var dl_high = document.BandwidthManageForm.QOS_HIGH_DL.value;
      var ul_normal = document.BandwidthManageForm.QOS_NORMAL_UL.value;
      var dl_normal = document.BandwidthManageForm.QOS_NORMAL_DL.value;
      var ul_low = document.BandwidthManageForm.QOS_LOW_UL.value;
      var dl_low = document.BandwidthManageForm.QOS_LOW_DL.value;
    
      if (ul_total == ""){
        msg=gettext("The upload throughput should not be null.");
        alert(msg);
        return false;
      }else if (dl_total == ""){
         msg=gettext("The download throughput should not be null.");
         alert(msg);
         return false;
      }else if (ul_highest == ""){
         msg=gettext("The urgent upload throughput should not be null.");
         alert(msg);
         return false;
      }else if (dl_highest == ""){
         msg=gettext("The urgent download throughput should not be null.");
         alert(msg);
         return false;
      }else if (ul_high == ""){
         msg=gettext("The high upload throughput should not be null.");
         alert(msg);
         return false;
      }else if ( dl_high == ""){
         msg=gettext("The high download throughput should not be null.");
         alert(msg);
         return false;
      }else if (ul_normal == ""){
         msg=gettext("The medium upload throughput should not be null.");
         alert(msg);
         return false;
      }else if (dl_normal == ""){
         msg=gettext("The medium download throughput should not be null.");
         alert(msg);
         return false;
      }else if (ul_low == ""){
         msg=gettext("The low upload throughput should not be null.");
         alert(msg);
         return false;
      }else if (dl_low == ""){
         msg=gettext("The low download throughput should not be null.");
         alert(msg);
         return false;
      }
    
      if(!input_rule.test(ul_total)){
    		msg=gettext("The upload throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_THROUGHPUT_UL.focus();
    		return false;
      }else if(!input_rule.test(dl_total)){
    		msg=gettext("The download throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_THROUGHPUT_DL.focus();
    		return false;
      }else if(!input_rule.test(ul_highest)){
    		msg=gettext("The urgent upload throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_HIGHEST_UL.focus();
    		return false;
      }else if(!input_rule.test(dl_highest)){
    		msg=gettext("The urgent download throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_HIGHEST_DL.focus();
    		return false;
      }else if(!input_rule.test(ul_high)){
    		msg=gettext("The high upload throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_HIGH_UL.focus();
    		return false;
      }else if(!input_rule.test(dl_high)){
    		msg=gettext("The high download throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_HIGH_DL.focus();
    		return false;
      }else if(!input_rule.test(ul_normal)){
    		msg=gettext("The medium upload throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_NORMAL_UL.focus();
    		return false;
      }else if(!input_rule.test(dl_normal)){
    		msg=gettext("The medium download throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_NORMAL_DL.focus();
    		return false;
      }else if(!input_rule.test(ul_low)){
    		msg=gettext("The low upload throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_LOW_UL.focus();
    		return false;
      }else if(!input_rule.test(dl_low)){
    		msg=gettext("The low download throughput should be number.");
    		alert(msg);
    		document.BandwidthManageForm.QOS_LOW_DL.focus();
    		return false;
      }
    
      ul_total = parseInt(ul_total, 10);
      dl_total = parseInt(dl_total, 10);
      ul_highest = parseInt(ul_highest, 10);
      dl_highest = parseInt(dl_highest, 10);
      ul_high = parseInt(ul_high, 10);
      dl_high = parseInt(dl_high, 10);
      ul_normal = parseInt(ul_normal, 10);
      dl_normal = parseInt(dl_normal, 10);
      ul_low = parseInt(ul_low, 10);
      dl_low = parseInt(dl_low, 10);

	  //Total UL/DL more than 10.
      if (ul_total < 10){
        msg = gettext("The upload throughput should be greater than 10 KByte/s.");
        alert(msg);
        return false;
      }  
      if (dl_total < 10){
        msg = gettext("The download throughput should be greater than 10 KByte/s.");
        alert(msg);
        return false;
      }

	  //UL/DL more than 10.  
      if ((ul_highest < 10) || (ul_highest > ul_total)){
        if (ul_highest > ul_total){
          msg = gettext("The urgent upload throughput should be less than the total upload throughput.");
          alert(msg);
          return false;
        }else{
          msg = gettext("The urgent upload throughput should be greater than 10 KByte/s.");
          alert(msg);
          return false;
        }  
      }else if ((ul_high < 10)||(ul_high > ul_total)){
        if (ul_high > ul_total){
          msg = gettext("The high upload throughput should be less than the total upload throughput.");
          alert(msg);
          return false;
        }else{ 
          msg = gettext("The high upload throughput should be greater than 10 KByte/s.");
          alert(msg);
          return false;
        }  
      }else if ((ul_normal < 10)|| (ul_normal > ul_total)){
        if (ul_normal > ul_total){
          msg = gettext("The medium upload throughput should be less than the total upload throughput.");
          alert(msg);
          return false;
        }else{
          msg = gettext("The medium upload throughput should be greater than 10 KByte/s.");
          alert(msg);
          return false;
        }  
      }else if ((ul_low < 10)||(ul_low > ul_total)){
        if (ul_low > ul_total){
          msg = gettext("The low upload throughput should be less than the total upload throughput.");
          alert(msg);
          return false;
        }else{
          msg = gettext("The low upload throughput should be greater than 10 KByte/s.");
          alert(msg);
          return false;
        }  
      }
    
      if ((dl_highest < 10)||(dl_highest > dl_total)){
        if (dl_highest > dl_total){
          msg = gettext("The urgent download throughput should be less than the total download throughput.");
          alert(msg);
          return false;
        }else{
          msg = gettext("The urgent download throughput should be greater than 10 KByte/s.");
          alert(msg);
          return false;
        }  
      }else if ((dl_high < 10)|| (dl_high > dl_total)){
        if (dl_high > dl_total){
          msg = gettext("The high download throughput should be less than the total download throughput.");
          alert(msg);
          return false;
        }else{ 
          msg = gettext("The high download throughput should be greater than 10 KByte/s.");
          alert(msg);
          return false;
        }  
      }else if ((dl_normal < 10)||(dl_normal > dl_total)){
        if (dl_normal > dl_total){
          msg = gettext("The medium download throughput should be less than the total download throughput.");
          alert(msg);
          return false;
        }else {
          msg = gettext("The medium download throughput should be greater than 10 KByte/s.");
          alert(msg);
          return false;
        }  
      }else if ((dl_low < 10)||(dl_low > dl_total)){
        if (dl_low > dl_total){
          msg = gettext("The low download throughput should be less than the total download throughput.");
          alert(msg);
          return false;
        }else{
          msg = gettext("The low download throughput should be greater than 10 KByte/s.");
          alert(msg);
          return false;
        }  
      }
  }

  document.BandwidthManageForm.action="/goform/setBandWidthManage";
  document.BandwidthManageForm.submit();
  return true;
}

var qos_list_idx = -1;
function qos_list_op_check(state)
{
	if(!CheckLoginInfo())
		return false;
	var qos_list_arr="";
	qos_list_idx=-1;
	document.getElementById('QosIdx').value="";
	var editor_action = document.getElementById('QosAction');
	var editor_count = document.getElementById('QosCount');
	var secObj = document.getElementById('tblBwMgmtProfiles');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;

	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				qos_list_idx=i; //host_list_idx starts from 1	
				qos_list_arr+=qos_list_idx+",";
			}
		}
	}
	editor_count.value=count;
	var ret=true;
    if (state == "add") {
    	editor_action.value = "QoSAdd";
    }else if ((state == "edit")) {
		if (count > 1){
			alert("Please select one row to edit.");
			ret=false;
		} else if (count==0){
			alert("Please select a row from the list to be edited.");
			ret=false;
		} else {
			editor_action.value = "QoSEdit";			
			document.getElementById('QosIdx').value=qos_list_idx;
		}
    }else if (state=="delete") {
	  if (count==0)	{
        alert("Please select items from the list to be deleted.");
		ret=false;
	  }	else {
		editor_action.value = "QoSDel";		
	    qos_list_arr=qos_list_arr.substr(0,qos_list_arr.length-1);
	    document.getElementById('QosIdx').value=qos_list_arr;
	  }	
	}
	return ret;
}

function secChkBoxSelectOrUnselectAll(sectionId, chkObj)
{
	if (!sectionId) return;
	secObj = document.getElementById(sectionId);
	if (!secObj) return;
	objArr = secObj.getElementsByTagName("INPUT");
	if (!objArr) return;
	if (chkObj)
	{
		for (i=0; i < objArr.length; i++)
		{
			if (objArr[i].type == 'checkbox' && !objArr[i].disabled)
			{
				if (chkObj.id == "imgSelectAll")
					objArr[i].checked = true;
				else if (chkObj.id == "imgUnCheckAll")
					objArr[i].checked = false;
			}
		}
		/* Change icon */		
		if (chkObj.id == "imgSelectAll")
		{
			chkObj.id = "imgUnCheckAll";
			chkObj.title = "Deselect All";
		}
		else if (chkObj.id == "imgUnCheckAll")
		{
			chkObj.id = "imgSelectAll"
			chkObj.title = "Select All"
		}		
	}
	else
	{
		for (i=0; i < objArr.length; i++)
		{
			if (objArr[i].type == 'checkbox' && !objArr[i].disabled)
			{
				objArr[i].checked = false;
			}
		}	
	}		
	return; 
}

function pageLoad()
{
	secChkBoxSelectOrUnselectAll ('tblBwMgmtProfiles',null);
	var QosInfo=<%getQosInfo();%>;
	var QosArr=QosInfo.split("#");
	var Priority_Def=parseInt(QosArr[13], 10);

	document.getElementById('txtSessions').value=QosArr[0];
	if(QosArr[1] == "1"){
		BandWidthEnableCheck(true);
	}else{
		BandWidthEnableCheck(false);
	}

	if(QosArr[2] == "1"){
		SessionLimitEnableCheck(true);
	}else{
		SessionLimitEnableCheck(false);
	}

    //BandWidth DL
	document.getElementById('QOS_THROUGHPUT_UL').value=QosArr[3];
	document.getElementById('QOS_HIGHEST_UL').value=QosArr[4];
	document.getElementById('QOS_HIGH_UL').value=QosArr[5];
	document.getElementById('QOS_NORMAL_UL').value=QosArr[6];
	document.getElementById('QOS_LOW_UL').value=QosArr[7];

	//BandWidth UL
	document.getElementById('QOS_THROUGHPUT_DL').value=QosArr[8];
	document.getElementById('QOS_HIGHEST_DL').value=QosArr[9];
	document.getElementById('QOS_HIGH_DL').value=QosArr[10];
	document.getElementById('QOS_NORMAL_DL').value=QosArr[11];
	document.getElementById('QOS_LOW_DL').value=QosArr[12];

	//Priority
	if (Priority_Def == 1){
      document.getElementById("QOS_DEFAULT").value = "1";
    }else if(Priority_Def ==2){
      document.getElementById("QOS_DEFAULT").value = "2";
    }else if(Priority_Def ==3){
      document.getElementById("QOS_DEFAULT").value = "3";
    }else if(Priority_Def ==4){
      document.getElementById("QOS_DEFAULT").value = "4";
    }else if(Priority_Def ==5){
      document.getElementById("QOS_DEFAULT").value = "5";
    }
}

</script>
</head>
<body onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("QoSPolicy", "QoSPolicy_href");</script>
<!-- Main Menu and Submenu End -->

<!-- Right Content start -->
<div class="contentBg">
  <div class="secH1"><script>document.write(gettext("QoS Settings"));</script></div>
  <div class="secBg"> 
  <div class="statusMsg"></div>
  <div class="secInfo"></div>
<!-- Session Limit -->
  <div class="secH2"><script>document.write(gettext("Sessions Limit"));</script></div>
  <form name="sessionLimitForm" method="post" action="/goform/setSessionLimit">
  <table border="0" cellpadding="0" cellspacing="0" class="configTbl">
  	<tr>
  	  <td><script>document.write(gettext("Limit Sessions"));</script></td>
  	  <td>
  		<input type="text" name="sessions" id="txtSessions" class="configF1" value="512" size="20" maxlength="4">
  		<span class="spanText">(1~4096)</span></td>
  	  <td>&nbsp;</td>
  	</tr>
  	<tr>
  	  <td><script>document.write(gettext("Enable Session Limit"));</script></td>
  	  <td><input type="checkbox" name="SessionLimitEnable" id="SessionLimitEnable" checked=false onclick="SessionLimitEnableCheck(this.checked);"/></td>
  	</tr>
  </table>
  <div>
  	<input type="submit" id="session_apply" value="Apply" class="submit" title="Apply" onclick="return SessionValidate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
  	<input type="button" id="session_reset" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
  </div>
  </form>
<!-- Session Limit -->

<!--Bandwidth Management-->
  <div class="statusMsg"></div>
  <div class="secH2"><script>document.write(gettext("Bandwidth Management"));</script></div>
  <form name="BandwidthManageForm" method="post">
  <table border="0" cellpadding="0" cellspacing="0" class="configTbl">
    <tr>
  	  <td><script>document.write(gettext("Enable Bandwidth Management"));</script></td>
  	  <td><input type="checkbox" name="BandWidthEnable" id="BandWidthEnable" checked=false onclick="BandWidthEnableCheck(this.checked);"/></td>
  	</tr>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" class="configTbl">
    <tr>
      <td><script>document.write(gettext("Throughput"));</script></td>
      <td>UL</td>
      <td><INPUT type="text" id="QOS_THROUGHPUT_UL" name="QOS_THROUGHPUT_UL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;</td>
      <td>DL</td>
      <td><INPUT type="text" id="QOS_THROUGHPUT_DL" name="QOS_THROUGHPUT_DL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;&nbsp;(UL, DL&nbsp;>&nbsp;10KByte/s)</td>
    </tr>
    <tr>
      <td><script>document.write(gettext("Urgent Priority"));</script></td>
      <td>UL</td>
      <td><INPUT type="text" id="QOS_HIGHEST_UL" name="QOS_HIGHEST_UL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;</td>
      <td>DL</td>
      <td><INPUT type="text" id="QOS_HIGHEST_DL" name="QOS_HIGHEST_DL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;&nbsp;(UL, DL&nbsp;>&nbsp;10KByte/s)</td>
    </tr>
    <tr>
      <td><script>document.write(gettext("High Priority"));</script></td>
      <td>UL</td>
      <td><INPUT type="text" id="QOS_HIGH_UL" name="QOS_HIGH_UL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;</td>
      <td>DL</td>
      <td><INPUT type="text" id="QOS_HIGH_DL" name="QOS_HIGH_DL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;&nbsp;(UL, DL&nbsp;>&nbsp;10KByte/s)</td>
    </tr>
    <tr>
      <td><script>document.write(gettext("Medium Priority"));</script></td>
      <td>UL</td>
      <td><INPUT type="text" id="QOS_NORMAL_UL" name="QOS_NORMAL_UL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;</td>
      <td>DL</td>
      <td><INPUT type="text" id="QOS_NORMAL_DL" name="QOS_NORMAL_DL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;&nbsp;(UL, DL&nbsp;>&nbsp;10KByte/s)</td>
    </tr>
    <tr>
      <td><script>document.write(gettext("Low Priority"));</script></td>
      <td>UL</td>
      <td><INPUT type="text" id="QOS_LOW_UL" name="QOS_LOW_UL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;</td>
      <td>DL</td>
      <td><INPUT type="text" id="QOS_LOW_DL" name="QOS_LOW_DL" class="text2" style="text-align:right" size = "10" maxlength="8" value=""></td>
      <td>KByte/s</td>
      <td>&nbsp;&nbsp;(UL, DL&nbsp;>&nbsp;10KByte/s)</td>
    </tr>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" class="configTbl">
    <tr><td><script>document.write(gettext("Default:"));</script></td>
    <td><select id="QOS_DEFAULT" name="QOS_DEFAULT">
      <option value=1><script>document.write(gettext("Urgent"));</script></option>
      <option value=2><script>document.write(gettext("High"));</script></option>
      <option value=3><script>document.write(gettext("Medium"));</script></option>
      <option value=4><script>document.write(gettext("Low"));</script></option>
      <option value=5><script>document.write(gettext("No Limit"));</script></option>
    </select></td></tr>
  </table>
  <div>
    <input type="submit" id="BtnApply" name="BtnApply" value="Apply" class="submit" title="Apply" onclick="checkBWApply();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
  	<input type="button" id="BtnReset" name="BtnReset" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
  </div>
  </form>
<!--Bandwidth Management--> 

<!-- Interface Download/Upload bandwidth show-->
<!--
  <div class="statusMsg"></div>
  <div class="secH2"><script>document.write(gettext("WAN Configuration"));</script></div>
  <table border="0" cellpadding="0" cellspacing="0" id="tblWanConfig">
  	<tr>
  	  <td class="tdH"><script>document.write(gettext("WAN Interface"));</script></td>
  	  <td class="tdH"><script>document.write(gettext("Upstream Bandwidth in Kbps"));</script></td>
  	  <td class="tdH"><script>document.write(gettext("Downstream Bandwidth in Kbps"));</script></td>
  	</tr>
  	<tr>
  	  <td class="tdOdd">LTE-WAN</td>
  	  <td class="tdOdd">60000</td>
  	  <td class="tdOdd">105000</td>
  	</tr>
  </table>
-->  
<!--Interface Download/Upload bandwidth show-->

<!-- Bandwidth Queue Configuration-->
<!--
  <div class="statusMsg"></div>
  <div class="secH2"><script>document.write(gettext("Bandwidth Queue Configuration"));</script></div>
  <table border="0" cellpadding="0" cellspacing="0" id="tblBwMgmtConfig">
  	<tr>
 	  <td class="tdH"><script>document.write(gettext("Priority"));</script></td>
  	  <td class="tdH"><script>document.write(gettext("Downstream Bandwidth in Kbps"));</script></td>
  	</tr>
  	<tr>
  	  <td class="tdOdd"><script>document.write(gettext("Urgent"));</script></td>
  	  <td class="tdOdd">30000</td>
  	</tr>
   	<tr>
  	  <td class="tdEven"><script>document.write(gettext("High"));</script></td>
  	  <td class="tdEven">20000</td>
  	</tr>
  	<tr>
  	  <td class="tdOdd"><script>document.write(gettext("Medium"));</script></td>
  	  <td class="tdOdd">10000</td>
  	</tr>
  	<tr>
	  <td class="tdEven"><script>document.write(gettext("Low"));</script></td>
  	  <td class="tdEven">10000</td>
  	</tr>
  </table>
-->
<!-- Bandwidth Queue Configuration-->	

<!-- Bandwidth Profiles-->	
  <div class="statusMsg"></div>
  <div class="secH2"><script>document.write(gettext("Bandwidth Profiles"));</script></div>
  <div class="secInfo">
    <br>The packet would be set the priority accroding to the 'Rule' content. If more than one rule content matched, would be set the latest matched rule. To every packet, only one rule is effective at the same time.
	<br>
  </div>
  <form name="QoSPolicyForm" method="post" action="/goform/setQoSTable"> 
  <input type="hidden" id="QosAction" name="QosAction" value="">
  <input type="hidden" id="QosIdx" name="QosIdx" value="">
  <input type="hidden" id="QosCount" name="QosCount" value="">
  <table border="0" cellpadding="0" cellspacing="0" id="tblBwMgmtProfiles">
    <tr>
   	  <td class="tdH"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" title="Select All" onclick="secChkBoxSelectOrUnselectAll ('tblBwMgmtProfiles', this)"></td>
      <td class="tdH"><script>document.write(gettext("Name"));</script></td>
      <td class="tdH"><script>document.write(gettext("Rule"));</script></td>
      <td class="tdH"><script>document.write(gettext("Priority"));</script></td>
    </tr>
    <tbody><%getQosBandwidthProfiles();%></tbody>
  </table>
  <div>
    <input type="submit" id="qos_add" class="tblbtn" value="Add" title="Add" name="QoSAdd" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return qos_list_op_check('add');">
	<input type="submit" id="qos_edit" class="tblbtn" value="Edit"  title="Edit" name="QoSEdit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return qos_list_op_check('edit');">
	<input type="submit" id="qos_del" class="tblbtn" value="Delete" title="Delete" name="QoSDel" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return qos_list_op_check('delete');">
  </div>
  </form>
</div>
</div>
</div>
<script type="text/javascript">
  document.getElementById('session_apply').value=gettext("Apply");
  document.getElementById('session_reset').value=gettext("Reset");
  document.getElementById('BtnApply').value=gettext("Apply");
  document.getElementById('BtnReset').value=gettext("Reset");
  document.getElementById('qos_add').value=gettext("Add");
  document.getElementById('qos_edit').value=gettext("Edit");
  document.getElementById('qos_del').value=gettext("Delete");
</script>
</body>
</html>
