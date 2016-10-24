<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="JavaScript" src="../js/textValidations.js" type="text/javascript"></script>
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

function host_list_action(action)
{	
	if(!CheckLoginInfo())
		return false;
	var host_list_arr="";
	var host_name="";
	document.getElementById('statusMsg').innerHTML="";
	document.getElementById('HostName').value="";	 
	document.getElementById('HostDelList').value="";	
	var editor_action = document.getElementById('HostTblAction');
	var secObj = document.getElementById('tblKnownComps');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;
	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				var id="hostTbl_name_"+(i-1); //default computer name/ip is lte-iad
				host_name=document.getElementById(id).innerHTML;
				host_list_arr+="'"+host_name+"',";	

				if (checkFieldExist("tblACLTable","firewallTbl_host_name_",host_name,action,"Computer Name","Access Control Service"))				
					return false;										
			}
		}
	}
	var ret=true;
	if (action=="add")
	{
		editor_action.value = "HostTblAdd";			
	}
	else if (action=="edit")
	{
		if (count > 1)
		{
			alert("Please select a row to edit.");
			ret=false;
		}
		else if (count==0)
		{
			alert("Please select a row from the list to be edited.");
			ret=false;
		}	
		else		
		{
			editor_action.value = "HostTblEdit";			
			document.getElementById('HostName').value=host_name;				
		}
	}
	else if (action=="delete")
	{
		if (count==0)
		{
			alert("Please select items from the list to be deleted.");
			ret=false;
		}
		else
		{
			editor_action.value = "HostTblDel";		
			host_list_arr=host_list_arr.substr(0,host_list_arr.length-1);
			document.getElementById('HostDelList').value=host_list_arr;				
		}
	}
	return ret;
}

</script>
</head>	

<body onload="secChkBoxSelectOrUnselectAll('tblKnownComps','umiId',null);">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("firewall_submenu","firewall_submenu_focus","known_computers","known_computers_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1">Known Computers</div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg" id="statusMsg"><%getActionResult();%></div>
		<div class="secH2">List of Known Computers</div>
		
		<div class="secInfo">
			<br>IP address associated with a known machine are displayed here.  The hostname mapping listed here is useful to identify devices on the local network.
			<br>
		</div>
		<form name="HostTblFrm" method="post" action="/goform/setHostTable">		
		<input type="hidden" id="HostTblAction" name="HostTblAction" value="">
		<input type="hidden" id="HostName" name="HostName" value="">
		<input type="hidden" id="HostDelList" name="HostDelList" value="">	

		<table id='tblACLTable' style="display:none;">	
		  <tr><td><input type="checkbox"></td></tr>
		  <tbody><%getACLTable();%></tbody> 		 
		</table>
		
		<table border="0" cellpadding="0" cellspacing="0" id='tblKnownComps' width="400px" style="table-layout: fixed;" class="specTbl">
			<tr>
				<td class="tdH" width="10%"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblKnownComps', 'umiId', this)"></td>
				<td class="tdH" width="60%">Computer Name</td>
				<td class="tdH" width="30%">IP Address</td>
			</tr>
			
			<tr>
				<td class="tdOdd"><input type="checkbox" name="dns.checkbox" id="" value="0" disabled></td>
				<td class="tdOdd"><%getLanBasic("hostname");%></td>
				<td class="tdOdd"><%getLanBasic("IpAddress");%></td>
			</tr>	
			<tbody><%getHostTable();%></tbody>  
		</table>
		<div>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="secBot">&nbsp;</td>
				</tr>
			</table>
		</div>
		<div class="submitBg">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><input type="submit" class="tblbtn" value="Add" title="Add" name="HostTblAdd" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return host_list_action('add');"></td>
					<td><input type="submit" class="tblbtn" value="Edit"  title="Edit" name="HostTblEdit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return host_list_action('edit');"></td>
					<td><input type="submit" class="tblbtn" value="Delete" title="Delete" name="HostTblDel" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return host_list_action('delete');"></td>
				</tr>
			</table>
		</div>
	</form>
	</div>
	<!-- Section End -->
</div>
<!-- contentBg End -->

</div> <!-- End of all -->
</body>
</html>
