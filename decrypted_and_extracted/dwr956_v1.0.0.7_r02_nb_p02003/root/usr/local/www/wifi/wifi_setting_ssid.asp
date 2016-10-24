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
var WiFiNameIsSel = <%getWiFiNameIsSel();%>;
var WiFiNameIsSelArr = WiFiNameIsSel.split("#");
var WiFiStatusIsTrue = <%getWiFiStatusIsTrue();%>;
var WiFiStatusIsTrueArr = WiFiStatusIsTrue.split("#");
var wifi_list_idx = -1;
function pageLoad()
{
	secChkBoxSelectOrUnselectAll ('tblWiFiSSID',null);
}

function wifi_op_check(state)
{
	if(!CheckLoginInfo())
		return false;
	var wifi_list_arr="";
	var wifi_list_name_arr="";
	wifi_list_idx=-1;
	document.getElementById('WiFiIdx').value="";
	var editor_action = document.getElementById('WiFiAction');
	var editor_count = document.getElementById('WiFiCount');
	var secObj = document.getElementById('tblWiFiSSID');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0, statusCount=0;
	var num = "";

	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				wifi_list_idx=i; //host_list_idx starts from 1	
				wifi_list_arr+=wifi_list_idx+",";

				//Wi-Fi SSID selected name.
				var str = WiFiNameIsSelArr[wifi_list_idx-1];
				wifi_list_name_arr+=WiFiNameIsSelArr[wifi_list_idx-1]+",";

				//Wi-Fi SSID rule status is active count.
				if (WiFiStatusIsTrueArr[wifi_list_idx-1]=='1')
					statusCount++
			}
		}
	}
	editor_count.value=count;
	var ret=true;
    if (state == "add") {
		if (objArr.length-1 == 5){
			alert("The schedule max count is 5.");
			ret=false;
		}	
		editor_action.value = "WiFiAdd";
    }else if ((state == "edit")) {
		if (count > 1){
			alert("Please select one row to edit.");
			ret=false;
		} else if (count==0){
			alert("Please select a row from the list to be edited.");
			ret=false;
		} else {
			editor_action.value = "WiFiEdit";			
			document.getElementById('WiFiIdx').value=wifi_list_idx;
		}
    }else if (state=="delete") {
	  if (count==0)	{
        alert("Please select items from the list to be deleted.");
		ret=false;
	  }	else {
	  	if (statusCount > 0){
		  alert("Schedule rule selected to delete is in use.");
		  ret=false;	
	  	}else{	
		  editor_action.value = "WiFiDel";		
	      wifi_list_arr=wifi_list_arr.substr(0,wifi_list_arr.length-1);
	      document.getElementById('WiFiIdx').value=wifi_list_arr;
		  //wifi_list_name_arr=wifi_list_name_arr.substr(0,wifi_list_name_arr.length-1);
		  document.getElementById('WiFiName').value=wifi_list_name_arr;
	  	}
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
</script>	
</head>	

<body id="wifiSSIDPage" onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftMenuChange("wifi_settings", "wifi_settings_href");</script>
<!-- Main Menu and Submenu End -->

 <div class="contentBg">
   <div class="secH1"><script>document.write(gettext("Wi-Fi Settings Schedules"));</script></div>
   <div class="secBg">
   <div class="statusMsg"></div>
   <div class="secInfo"></div>
   <div class="secH2"><script>document.write(gettext("List of Available Access Points"));</script></div>						
   <div class="secInfo"><br><script>document.write(gettext("In this section you can configure the schedule rule(s) to enable/disable wireless functionality of the device."));</script>
                        <br>&nbsp;&nbsp;<a href="wifi_settings.asp" class="secLable1">&#187; <script>document.write(gettext("Back to Wi-Fi Settings page"));</script></a>
   </div>
   <form name="wifi_setting_ssid" method="post" action="/goform/setWifiSSID" > 
   <input type="hidden" id="WiFiAction" name="WiFiAction" value="">
   <input type="hidden" id="WiFiIdx" name="WiFiIdx" value="">
   <input type="hidden" id="WiFiCount" name="WiFiCount" value="">
   <input type="hidden" id="WiFiName" name="WiFiName" value="">
   <div class="secH2"><script>document.write(gettext("List of Available Schedule rules"));</script></div>
    <!--AP List-->
	<table cellspacing="0" id="tblWiFiSSID" class="specTbl">
      <tr>
        <td class="tdH"><input type="checkbox" id="imgSelectAll" name="imgSelectAllChk" title="Select All" onclick="secChkBoxSelectOrUnselectAll ('tblWiFiSSID', this)"></td>
        <td class="tdH"><script>document.write(gettext("Schedule Name"));</script></td>
        <td class="tdH"><script>document.write(gettext("Start Time"));</script></td>
        <td class="tdH"><script>document.write(gettext("End Time"));</script></td>
        <td class="tdH"><script>document.write(gettext("Schedule Status"));</script></td>
      </tr>
      <%getWiFiSSID();%>
    </table>  
  	<!--Button Start-->
	<div>
		<input type="submit" id="add_ssid" value="Add" class="tblbtn" title="Add" name="WiFiAdd" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return wifi_op_check('add');">
		<input type="submit" id="edit_ssid" value="Edit" class="tblbtn" title="Edit" name="WiFiEdit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return wifi_op_check('edit');">
		<input type="submit" id="delete_ssid" value="Delete" class="tblbtn" title="Delete" name="WiFiDel" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return wifi_op_check('delete');">
	</div>
	<!--Button End-->
	</form>
   </div>
 </div>
</div>
<script type="text/javascript">
	document.getElementById('add_ssid').value=gettext("Add");
	document.getElementById('edit_ssid').value=gettext("Edit");
	document.getElementById('delete_ssid').value=gettext("Delete");
</script>
</body>
</html>
