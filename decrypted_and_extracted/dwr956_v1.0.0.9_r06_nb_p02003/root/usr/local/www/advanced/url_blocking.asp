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

function fltr_list_action(action)
{
	if(!CheckLoginInfo())
		return false;
	var fltr_list_arr="";
	var fltr_name="";
	document.getElementById('statusMsg').innerHTML="";	
	document.getElementById('FltrTblFltrName').value="";
	var editor_action = document.getElementById('FltrTblAction');
	var secObj = document.getElementById('tblUrlBlock');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;
	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				var id="fltrTbl_fltr_name_"+i;
				fltr_name=document.getElementById(id).innerHTML;
				fltr_list_arr+="'"+fltr_name+"',";
				if (checkFieldExist("tblParentCtrlList","profile_fltr_name_",fltr_name,action,"Filter Name","Parental Control Service"))					
					return false;				
			}
		}
	}
	var ret=true;
	if (action=="add")
	{
		editor_action.value = "FltrTblAdd";			
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
			editor_action.value = "FltrTblEdit";			
			document.getElementById('FltrTblFltrName').value=fltr_name;			
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
			editor_action.value = "FltrTblDel";		
			fltr_list_arr=fltr_list_arr.substr(0,fltr_list_arr.length-1);
			document.getElementById('FltrTblDelList').value=fltr_list_arr;
		}
	}
	return ret;
}

</script>
</head>	

<body onload="secChkBoxSelectOrUnselectAll ('tblUrlBlock','umiId',null);">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("firewall_submenu","firewall_submenu_focus","url_blocking","url_blocking_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1">URL&nbsp;Blocking</div>
	<!-- Section Begin -->
	<div class="secBg">	
		<div class="statusMsg" id="statusMsg"><%getActionResult();%></div>		
		<div class="secInfo">
			<br>This security tool allows you to block access to Internet domains that contain certain defined keywords. Up to 32 key words to check in a domain can be configured in a single filtering policy.
			<br>
		</div>
		<form method="post" action="/goform/setFltrTable">
		<input type="hidden" id="FltrTblAction" name="FltrTblAction" value="">		
		<input type="hidden" id="FltrTblFltrName" name="FltrTblFltrName" value="">
		<input type="hidden" id="FltrTblDelList" name="FltrTblDelList" value="">

		<table id='tblParentCtrlList' style="display:none;">	
		  <tr><td><input type="checkbox"></td></tr>
		  <tbody><%getUrlProfileTable();%></tbody> 		 
		</table>
		
		<table border="0" cellpadding="0" cellspacing="0" id="tblUrlBlock" width="500px" style="table-layout: fixed;" class="specTbl">
			<tr>
				<td class="tdH" width="10%"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll('tblUrlBlock', 'umiId', this)"></td>
				<td class="tdH" width="30%">Filter Name</td>
				<td class="tdH" width="30%">Keywords</td>
				<td class="tdH" width="30%">Domains</td>
			</tr>			  
			<tbody><%getFltrTable();%></tbody>
		</table>
		<div>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="blank1" height="43">&nbsp;</td>
			</tr>
		</table>
		</div>
		<div class="submitBg">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><input type="submit" value="Add"  class="tblbtn" title="Add" name="button.add.ContentFltr.urlBlockingConfig.-1"  onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return fltr_list_action('add');"></td>
					<td><input type="submit" value="Edit"  class="tblbtn" title="Edit" name="button.edit.ContentFltr.urlBlockingConfig"  onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return fltr_list_action('edit');"></td>
					<td><input type="submit" value="Delete"  class="tblbtn" title="Delete" name="button.delete.ContentFltr.urlBlocking"  onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return fltr_list_action('delete');"></td>
				</tr>
			</table>
		</div>
		</form>
	</div>
	<!-- Section End -->
</div>

</div> <!-- End of all -->
</body>
</html>
