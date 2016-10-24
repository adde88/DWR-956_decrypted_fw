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
var ap_list_idx = -1;

function pressButton(state)
{
	if(!CheckLoginInfo())
		return false;
	var ap_list_arr="";
	ap_list_idx=-1;
	document.getElementById('WiFiIdx').value="";
	var editor_action = document.getElementById('WiFiAction');
	var editor_count = document.getElementById('WiFiCount');
	var secObj = document.getElementById('tblWiFiSetting');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;

	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				ap_list_idx=i; //host_list_idx starts from 1	
				ap_list_arr+=ap_list_idx+",";
			}
		}
	}
	editor_count.value=count;
	var ret=true;
    if ((state == "edit")) {
		if (count > 1){
			alert("Please select one row to edit.");
			ret=false;
		} else if (count==0){
			alert("Please select a row from the list to be edited.");
			ret=false;
		} else {
			editor_action.value = "WiFiEdit";			
			document.getElementById('WiFiIdx').value=ap_list_idx;
		}
    }else if (state=="ssid") {
	  if (count > 1){
	  	alert("Please select one row to set schedule.");
		ret=false;
	  }else if (count==0)	{
        alert("Please select a row from the list to set schedule.");
		ret=false;
	  }	else {
		editor_action.value = "WiFiSSID";		
	    document.getElementById('WiFiIdx').value=ap_list_idx;
	  }	
	}else if (state=="acl") {
	  if (count > 1){
	  	alert("Please select one row to set ACL.");
	  	ret=false;
	  }else if (count==0)	{
        alert("Please select a row from the list to set acl.");
		ret=false;
	  }	else {
		editor_action.value = "WiFiAcl";		
	    document.getElementById('WiFiIdx').value=ap_list_idx;
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
	secChkBoxSelectOrUnselectAll ('tblWiFiSetting',null);
}

</script>	
</head>	

<body id="wifibasicPage" onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftMenuChange("wifi_settings", "wifi_settings_href");</script>
<!-- Main Menu and Submenu End -->

 <div class="contentBg" >
   <div class="secH1"><script>document.write(gettext("Wi-Fi Settings"));</script></div>
   <div class="secBg">
   <div class="statusMsg"></div>
   <div class="secInfo"></div>
   <div class="secH2"><script>document.write(gettext("List of Available Access Points"));</script></div>						
   <div class="secInfo"><br><script>document.write(gettext("The status of the available Access Points are displayed here."));</script><br></div>
    <form name="wifi_setting" method="post" action="/goform/setWiFiAP" > 
    <input type="hidden" id="WiFiAction" name="WiFiAction" value="">
  	<input type="hidden" id="WiFiIdx" name="WiFiIdx" value="">
  	<input type="hidden" id="WiFiCount" name="WiFiCount" value="">
    <!--AP List-->
	<table cellspacing="0" id="tblWiFiSetting" width="670px" style="table-layout: fixed;" class="specTbl">
      <tr>
        <td class="tdH" width="6%"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" title="Select All" onclick="secChkBoxSelectOrUnselectAll ('tblWiFiSetting', this)"></td>
      	<td class="tdH" width="12%">Status</td>
      	<td class="tdH" width="20%">SSID</td>
      	<td class="tdH" width="12%">Broadcast</td>
      	<td class="tdH" width="13%">Security</td>
      	<td class="tdH" width="13%">Active Time</td>
      	<td class="tdH" width="12%">Start Time</td>
      	<td class="tdH" width="12%">Stop Time</td>
      </tr>
      <%getWiFiAP();%>
    </table>  
  	<!--Button Start-->
	<div>
		<input type="submit" id="edit_wifi" value="Edit" class="tblbtn" title="Edit" name="WiFiEdit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return pressButton('edit');">
		<input type="submit" id="ssid_wifi" value="SSID Schedule" class="tblbtn" title="SSID Schedule" name="WiFiSSID" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return pressButton('ssid');">
		<input type="submit" id="acl_wifi" value="ACL" class="tblbtn" title="ACL" name="WiFiAcl" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return pressButton('acl');">
	</div>
	<!--Button End-->
	</form>
   </div>
 </div>
</div>
<script type="text/javascript">
	document.getElementById('edit_wifi').value=gettext("Edit");
	document.getElementById('ssid_wifi').value=gettext("SSID Schedule");
	document.getElementById('acl_wifi').value=gettext("ACL");
</script>
</body>
</html>
