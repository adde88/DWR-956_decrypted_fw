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

var acl_list_idx=-1;
function checkApply()
{
	if(!CheckLoginInfo())
		return false;
	return true;
}
function acl_list_action(action)
{
	if(!CheckLoginInfo())
		return false;

	var acl_list_arr="";
	acl_list_idx=-1;
	document.getElementById('AclListIdx').value="";
	var editor_action = document.getElementById('AclListAction');
	var editor_count = document.getElementById('AclListCount');
	var secObj = document.getElementById('tblMacAddrs');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;
	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				acl_list_idx=i; //host_list_idx starts from 1
				acl_list_arr+=acl_list_idx+",";
			}
		}
	}
	editor_count.value=count;
	var ret=true;
	if (action=="add")
	{
		editor_action.value = "AclListAdd";
	}
	else if (action=="delete")
	{
		if (count==0)
		{
			alert(gettext("Please select items from the list to be deleted."));
			ret=false;
		}
		else
		{
			editor_action.value = "AclListDel";
			acl_list_arr=acl_list_arr.substr(0,acl_list_arr.length-1);
			document.getElementById('AclListIdx').value=acl_list_arr;
		}
	}
	return ret;
}

function wifi_acl_init()
{
	var ACLConfig = <%getWifiACLSetting();%>;
	var ACLConfigArr;
	if (ACLConfig != "")
	{
		ACLConfigArr = ACLConfig.split("#");
		document.getElementById("ssid").innerHTML=ACLConfigArr[0];
		document.getElementById("selACLPolicy").value=ACLConfigArr[1];
  if (ACLConfigArr[1] == "0") {
   fieldStateChangeWr ('','tblMacAddrs tblButtons','','');
  } else {
   fieldStateChangeWr ('','','','tblMacAddrs tblButtons');
  }
	}
	else
	{
		//window.location.href="../wifi/wifi_settings.asp";
		document.getElementById("ssid").innerHTML="";
		document.getElementById("selACLPolicy").value="0";

  fieldStateChangeWr ('','tblMacAddrs tblButtons','','');
		return;
	}

	secChkBoxSelectOrUnselectAll ('tblMacAddrs', 'umiId', null);

	var ACLListCount = parseInt(<%getWifiACLListCount();%>, 10);
	if (ACLListCount >= 10)
	{
		document.getElementById("button.add").style.display = "none";
	}

 var statusMsg = "";
	var err_msg = <%getMacFilteringErrorStatus();%>;
	if (err_msg == "1")
	{
		statusMsg = gettext("The MAC Filtering with the same MAC Address already exist.");
 }
 document.getElementById("statusMsg").innerHTML=statusMsg;
 return;
}
</script>
</head>

<body onload="wifi_acl_init();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftMenuChange("wifi_settings", "wifi_settings_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("MAC Filtering"));</script></div>
	<div class="secBg">
		<div class="statusMsg" id="statusMsg"></div>
		<div class="secH2"><script>document.write(gettext("MAC Filtering Configuratione"));</script></div>
		<div class="secInfo">
  <br /><script>document.write(gettext("This page allows you to configure the default Access Policy for all wireless clients.  You can choose to block or allow specific wireless clients from associating with this gateways AP with the settings on this page."));</script>
		<br /><a class="secLable1" href="wifi_settings.asp">&#187; <script>document.write(gettext("Back to Wi-Fi Settings page"));</script></a>
		<br />
		</div>
  <form name="wifi_acl_setting" method="post" action="/goform/setWifiACLSetting">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("SSID"));</script></td>
				<td id="ssid"></td>
			</tr>
			<tr>
				<td><script>document.write(gettext("ACL Policy Status"));</script></td>
				<td>
      <select size="1" class="configF1" name="selACLPolicy" id="selACLPolicy">
        <option value="0"><script>document.write(gettext("Allow Everybody"));</script></option>
        <option value="1"><script>document.write(gettext("Allow"));</script></option>
        <option value="2"><script>document.write(gettext("Deny"));</script></option>
      </select>
				</td>
			</tr>
		</table>
		<div>
			<input type="submit" value="Apply" class="submit" id="button.apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return checkApply();"/>
			<input type="button" value="Reset" class="submit" id="button.reset" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();" />
		</div>
	 </form>
  <br />
		<div class="secH2"><script>document.write(gettext("List of MAC Addresses"));</script></div>
		<div class="secInfo">
  <br /><script>document.write(gettext("The wireless access policy is applied to the list of wireless clients, identified by their MAC Addresses and computer names, listed in this section. "));</script>
		<br />
		</div>
  <form name="wifi_acl_list" method="post" action="/goform/setWifiACLList">
		<input type="hidden" id="AclListAction" name="AclListAction" value="" />
		<input type="hidden" id="AclListIdx" name="AclListIdx" value="" />
		<input type="hidden" id="AclListCount" name="AclListCount" value="" />
		<table cellpadding="0" cellspacing="0" id="tblMacAddrs">
    <tr>
      <td class="tdH"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblMacAddrs', 'umiId', this)" /></td>
      <td class="tdH"><script>document.write(gettext("MAC Address"));</script></td>
    </tr>
    <%getWifiACLList();%>
		</table>
		<div id="tblButtons">
			<input type="submit" value="Add" class="submit" name="AclListAdd" id="button.add" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return acl_list_action('add');" />
			<input type="submit" value="Delete" class="submit" name="AclListDel" id="button.delete" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return acl_list_action('delete');" />
		</div>
	 </form>

	</div>
</div>
</div>

<script type="text/javascript">
 document.getElementById('button.apply').value = gettext("Apply");
 document.getElementById('button.reset').value = gettext("Reset");
 document.getElementById('button.add').value = gettext("Add");
 document.getElementById('button.delete').value = gettext("Delete");
</script>

</body>
</html>
