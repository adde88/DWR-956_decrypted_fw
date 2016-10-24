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

var ip_res_list_idx=-1;
function ip_res_list_action(action)
{
	if(!CheckLoginInfo())
		return false;

	var ip_res_list_arr="";
	ip_res_list_idx=-1;
	document.getElementById('IPResIdx').value="";
	var editor_action = document.getElementById('IPResAction');
	var editor_count = document.getElementById('IPResCount');
	var secObj = document.getElementById('tblReservedIPs');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;
	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				ip_res_list_idx=i; //host_list_idx starts from 1
				ip_res_list_arr+=ip_res_list_idx+",";
			}
		}
	}
	editor_count.value=count;
	var ret=true;
	if (action=="add")
	{
		editor_action.value = "IPResAdd";
	}
	else if (action=="edit")
	{
		if (count > 1)
		{
			alert(gettext("Please select a row to edit."));
			ret=false;
		}
		else if (count==0)
		{
			alert(gettext("Please select a row from the list to be edited."));
			ret=false;
		}
		else
		{
			editor_action.value = "IPResEdit";
			document.getElementById('IPResIdx').value=ip_res_list_idx;
		}
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
			editor_action.value = "IPResDel";
			ip_res_list_arr=ip_res_list_arr.substr(0,ip_res_list_arr.length-1);
			document.getElementById('IPResIdx').value=ip_res_list_arr;
		}
	}
	return ret;
}

function lan_ipreservation_init()
{
	secChkBoxSelectOrUnselectAll ('tblReservedIPs', 'umiId', null);

 var statusMsg = "";
	var err_msg = <%getDhcpReservationErrorStatus();%>;
	if (err_msg == "1")
	{
		statusMsg = gettext("The MAC address already exists.");
	} else if (err_msg == "2") {
		statusMsg = gettext("The IP address already exists.");
 }
 document.getElementById("statusMsg").innerHTML=statusMsg;
 return;
}
</script>
</head>

<body onload="lan_ipreservation_init();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("lan");%>
<script type="text/javascript">menuChange("lan_menu");leftSubMenuChange("dhcp_submenu","dhcp_submenu_focus","lan_ipreservation","lan_ipreservation_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("DHCP Reservation"));</script></div>
	<div class="secBg">
		<div class="statusMsg" id="statusMsg"></div>
		<div class="secInfo">
		<br><script>document.write(gettext("To ensure certain local network devices always receive the same IP address from the gateway's DHCP server, you can bind the LAN device's MAC address to a preferred IP address. This IP address will only be assigned to the matching MAC address."));</script>
		<br>
		</div>
  <div class="secH2"><script>document.write(gettext("List of Reserved IP Addresses"));</script></div>
  <form name="ip_reservation_list" method="post" action="/goform/setDhcpReservation">
		<input type="hidden" id="IPResAction" name="IPResAction" value="">
		<input type="hidden" id="IPResIdx" name="IPResIdx" value="">
		<input type="hidden" id="IPResCount" name="IPResCount" value="">
  <table cellpadding="0" cellspacing="0" id="tblReservedIPs">
    <tr>
      <td class="tdH"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblReservedIPs', 'umiId', this)"></td>
      <td class="tdH"><script>document.write(gettext("MAC Address"));</script></td>
      <td class="tdH"><script>document.write(gettext("IP Address"));</script></td>
    </tr>
    <tbody>
    	<%getDhcpReservationList();%>
    </tbody>
  </table>
  <br>
		<div>
			<input type="submit" value="Add" class="submit" name="IPResAdd" id="button.add" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return ip_res_list_action('add');" />
			<input type="submit" value="Edit" class="submit" name="IPResEdit" id="button.edit" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return ip_res_list_action('edit');" />
			<input type="submit" value="Delete" class="submit" name="IPResDel" id="button.delete" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return ip_res_list_action('delete');" />
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
