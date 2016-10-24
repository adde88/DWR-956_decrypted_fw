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

var acl_list_idx=-1;
function acl_list_action(action)
{	
	if(!CheckLoginInfo())
		return false;
	var acl_list_arr="";
	acl_list_idx=-1;
	document.getElementById('ACLTblIdx').value="";
	var editor_action = document.getElementById('ACLTblAction');
	var secObj = document.getElementById('tblAccessCtrl');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;
	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				acl_list_idx=i; 	
				acl_list_arr+=acl_list_idx+",";
			}
		}
	}
	var ret=true;
	if (action=="add")
	{
		editor_action.value = "ACLTblAdd";			
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
			editor_action.value = "ACLTblEdit";			
			document.getElementById('ACLTblIdx').value=acl_list_idx;
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
			editor_action.value = "ACLTblDel";		
			acl_list_arr=acl_list_arr.substr(0,acl_list_arr.length-1);
			document.getElementById('ACLTblIdx').value=acl_list_arr;
		}
	}
	return ret;
}
</script>
</head>	

<body onload="secChkBoxSelectOrUnselectAll('tblAccessCtrl','umiId',null);">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("firewall_submenu","firewall_submenu_focus","access_control","access_control_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1">Access&nbsp;Control</div>
	<!-- Section Begin -->
	<div class="secBg">
	<div class="statusMsg"><%getActionResult();%></div>
	<div class="secH2">Access&nbsp;Control</div>

	<div class="secInfo">
		<br>A list of all configured filtering rules is displayed here.  Filtering rules for computers indicate whether a defined application is specifically allowed or blocked for use for that computer.
		<br>
	</div>
	<form method="post" action="/goform/setACLTable">
		<input type="hidden" id="ACLTblAction" name="ACLTblAction" value="">
		<input type="hidden" id="ACLTblIdx" name="ACLTblIdx" value="">		
		<table border="0" cellpadding="0" cellspacing="0" id="tblAccessCtrl" width="450px" style="table-layout: fixed;" class="specTbl">
		 <tr>
		  <td class="tdH" width="10%"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblAccessCtrl', 'umiId', this)"></td>
		  <td class="tdH" width="35%">Application</td>
		  <td class="tdH" width="35%">Computer Name</td>
		  <td class="tdH" width="20%">Status</td>
		 </tr>
		 <tbody><%getACLTable();%></tbody> 		 
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
		   <td><input type="submit" class="tblbtn" value="Add" title="Add" name="ACLTblAdd" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return acl_list_action('add');"></td>
		   <td><input type="submit" class="tblbtn" value="Edit" title="Edit" name="ACLTblEdit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return acl_list_action('edit');"></td>
		   <td><input type="submit" class="tblbtn" value="Delete" title="Delete" name="ACLTblDel" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return acl_list_action('delete');"></td>
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
