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

function applist_op_check(state)
{
	if(!CheckLoginInfo())
		return false;
 var host_list_idx = -1;
 var countDefault=0;
	var app_list_arr="";
	host_list_idx=-1;
	document.getElementById('AppListIdx').value="";
	var editor_action = document.getElementById('AppListAction');
	var editor_count = document.getElementById('AppListCount');
	var secObj = document.getElementById('tblAppList');
	var objArr = secObj.getElementsByTagName("INPUT");
	var AppsIsDefault = <%getSpecialAppsIsDefault();%>;
  	var AppsIsDefaultArr = AppsIsDefault.split("#");
	var count=0;

	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				host_list_idx=i; //host_list_idx starts from 1
				app_list_arr+=host_list_idx+",";
				if (AppsIsDefaultArr[i-1]=="1"){//Count Is Default
					countDefault++;
				}
			}
		}
	}
	editor_count.value=count;
	var ret=true;
	if (state=="add")
	{
		editor_action.value = "AppListTblAdd";
	}else if (state == "edit"){
    	if (count > 1){
			alert(gettext("Please select one row to edit."));
			ret=false;
		} else if (count==0){
			alert(gettext("Please select a row from the list to be edited."));
			ret=false;
		} else {
			editor_action.value = "AppListTblEdit";
			document.getElementById('AppListIdx').value=host_list_idx;
		}
    }else if (state=="delete"){
	  if (count==0)	{
        alert(gettext("Please select items from the list to be deleted."));
		ret=false;
	  }	else {
		if (countDefault==0){
			editor_action.value = "AppListTblDel";
		    app_list_arr=app_list_arr.substr(0,app_list_arr.length-1);
		    document.getElementById('AppListIdx').value=app_list_arr;
		} else {
			alert(gettext("The selections have default application can't be deleted."));
			ret=false;
		}
	  }
	}
	return ret;
}

function pageLoad()
{
	secChkBoxSelectOrUnselectAll ('tblAppList', 'speId', null);

 var statusMsg = "";
	var err_msg = <%getSpecialAppsErrorStatus();%>;
	if (err_msg == "1")
	{
		statusMsg = gettext("The Special Applications with the same Service Name already exist.");
	} else if (err_msg == "2") {
		statusMsg = gettext("The Service Name is in use, disable/delete Access Control rule first.");
	} else if (err_msg == "3") {
		statusMsg = gettext("The Service Name is in use, disable/delete QoS Settings rule first.");
	} else if (err_msg == "4") {
  statusMsg = gettext("The Service Name is in use, disable/delete Port Forwarding rule first.");
 }
 document.getElementById("statusMsg").innerHTML=statusMsg;
 return;
}
</script>
</head>

<body onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("nat_submenu","nat_submenu_focus","special_apps","special_apps_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Special Applications"));</script></div>
	<div class="secBg">
		<div class="statusMsg" id="statusMsg"></div>
		<div class="secInfo">
		<br /><script>document.write(gettext("While common applications use known TCP/UDP ports, many custom or uncommon applications require traffic to be sent through the firewall. This section allows you to define the traffic type and static ports for a unique application and then create security policies for this user-defined application."));</script>
		<br />
		</div>
  <div class="secH2"><script>document.write(gettext("List of Services"));</script></div>
		<br />
  <form name="AppListForm" method="post" action="/goform/setAppListTable">
  <input type="hidden" id="AppListAction" name="AppListAction" value="">
  <input type="hidden" id="AppListIdx" name="AppListIdx" value="">
  <input type="hidden" id="AppListCount" name="AppListCount" value="">
  <table cellspacing="0" id="tblAppList" width="500px" style="table-layout: fixed;" class="specTbl">
  <tr>
    <td class="tdH" width="10%"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblAppList', 'speId', this)"></td>
    <td class="tdH" width="45%"><script>document.write(gettext("Service Name"));</script></td>
    <td class="tdH" width="15%"><script>document.write(gettext("Protocol"));</script></td>
    <td class="tdH" width="15%"><script>document.write(gettext("Start Port"));</script></td>
    <td class="tdH" width="15%"><script>document.write(gettext("End Port"));</script></td>
  </tr>
  <tbody>
  <%getSpecialAppsList();%>
  </tbody>
		</table>
		<div>
   <input type="submit" class="tblbtn" value="Add" id="button.add" name="AppListTblAdd" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return applist_op_check('add');" />
   <input type="submit" class="tblbtn" value="Edit" id="button.edit" name="AppListTblEdit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return applist_op_check('edit');" />
   <input type="submit" class="tblbtn" value="Delete" id="button.delete" name="AppListTblDel" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return applist_op_check('delete');" />
		</div>
	 </form>
	</div>
</div>
</div>

<script type="text/javascript">
 document.getElementById('button.add').value = gettext("Add");
 document.getElementById('button.edit').value = gettext("Edit");
 document.getElementById('button.delete').value = gettext("Delete");
</script>

</body>
</html>
