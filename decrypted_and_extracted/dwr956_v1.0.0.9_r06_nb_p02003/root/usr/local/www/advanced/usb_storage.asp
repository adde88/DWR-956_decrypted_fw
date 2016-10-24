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
//<!--

CheckInitLoginInfo(<%getuser_login();%>);

var admin_pwd="";
function accountChk()
{
	var selOptVal = comboSelectedValueGet ('SAMBA_USERS');
	if (!selOptVal) return;
	switch (selOptVal)
	{
	case "all": 
		get_by_id('SAMBA_PASSWORD').value="";
		get_by_id('SAMBA_PASSWORD').disabled=true;
		break;
	default:
		get_by_id('SAMBA_PASSWORD').value=admin_pwd;
		get_by_id('SAMBA_PASSWORD').disabled=false;		
		break;
	}
}

function share_list_action(action)
{	
	if(!CheckLoginInfo())
		return false;
	var share_list_arr="";
	var share_name="";
	document.getElementById('statusMsg').innerHTML="";
	document.getElementById('ShareName').value="";	 
	document.getElementById('ShareDelList').value="";	
	var editor_action = document.getElementById('ShareTblAction');
	var secObj = document.getElementById('tblSambaShare');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;
	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				var id="shareTbl_name_"+i;
				share_name=document.getElementById(id).innerHTML;
				share_list_arr+="'"+share_name+"',";										
			}
		}
	}
	var ret=true;
	if (action=="add")
	{
		if (objArr.length > 5)
		{
			alert("There are already 5 file share.");
			ret=false;			
		}
		else
			editor_action.value = "ShareTblAdd";	
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
			editor_action.value = "ShareTblEdit";			
			document.getElementById('ShareName').value=share_name;				
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
			editor_action.value = "ShareTblDel";		
			share_list_arr=share_list_arr.substr(0,share_list_arr.length-1);
			document.getElementById('ShareDelList').value=share_list_arr;				
		}
	}
	return ret;
}

function draw_usb_storage_list(table, mount_path, file_system, total, used, available, percent, index)
{	
	var row = document.createElement("tr");
	var col;
	var cellText;

	/* mount path */
	col = document.createElement("td");
	col.align="center";
    if (index%2)
	  col.className="tdOdd";
    else
	  col.className="tdEven";	
	cellText = document.createTextNode(mount_path);	
	col.appendChild(cellText);
	row.appendChild(col);
	
	/* file system */
	col = document.createElement("td");
	col.align="center";
    if (index%2)
	  col.className="tdOdd";
    else
	  col.className="tdEven";
	cellText = document.createTextNode(file_system);	
	col.appendChild(cellText);
	row.appendChild(col);
	
	/* total */
	col = document.createElement("td");
	col.align="center";
    if (index%2)
	  col.className="tdOdd";
    else
	  col.className="tdEven";
	cellText = document.createTextNode(total);
	col.appendChild(cellText);
	row.appendChild(col);

	/* used */
	col = document.createElement("td");
	col.align="center";
    if (index%2)
	  col.className="tdOdd";
    else
	  col.className="tdEven";
	cellText = document.createTextNode(used);
	col.appendChild(cellText);
	row.appendChild(col);	

	/* available */
	col = document.createElement("td");
	col.align="center";
    if (index%2)
	  col.className="tdOdd";
    else
	  col.className="tdEven";
	cellText = document.createTextNode(available);
	col.appendChild(cellText);
	row.appendChild(col);

	/* percent */
	col = document.createElement("td");
	col.align="center";
    if (index%2)
	  col.className="tdOdd";
    else
	  col.className="tdEven";
	cellText = document.createTextNode(percent);
	col.appendChild(cellText);
	row.appendChild(col);	

	table.appendChild(row);	
}

function loadUsbPage()
{
	/* Get dlna status */
	var infoMsg="";
	var dlna_status = <%getDLNA();%>;
	if (dlna_status)
	{
		infoMsg="This page displays the USB storage information.";
		document.getElementById('usbUI').style.display = "block";
	}
	else
	{
		infoMsg="This page displays the USB storage information when DLNA Media Server is enabled.";		
		document.getElementById('usbUI').style.display = "none";	
	}
	document.getElementById('secInfo').innerHTML=gettext(infoMsg);

	/* Show Usb Storage Info */
	var usb_data=<%getUsbInfo();%>;
	var usb_table = document.getElementById('usb_storage_table');
	if(usb_table!=null && usb_table.hasChildNodes())
	{
		while(usb_table.childNodes.length>=1)
		{
			usb_table.removeChild(usb_table.firstChild);
		}
	}				
	if (usb_data=="")
	{
		draw_usb_storage_list(usb_table, "-", "-", "-", "-", "-", "-", 0);
		get_by_id('SAMBA_PASSWORD').value="";
		get_by_id('SAMBA_PASSWORD').disabled=true;
		document.getElementById("sambaShareAdd").disabled=true;
		document.getElementById("sambaShareEdit").disabled=true;
		document.getElementById("sambaShareDel").disabled=true;
		document.getElementById("sambaShareAdd").className="tblbtn_dis";
		document.getElementById("sambaShareEdit").className="tblbtn_dis";
		document.getElementById("sambaShareDel").className="tblbtn_dis";	
	}
	else
	{
		var usb_data_arr = usb_data.split("&");
		var usb_data_count = usb_data_arr.length - 1;
		for (var i=0; i<usb_data_count; i++)
		{
			var usb_field_arr = usb_data_arr[i].split("#");	
			draw_usb_storage_list(usb_table, usb_field_arr[0], usb_field_arr[1], usb_field_arr[2], usb_field_arr[3], usb_field_arr[4], usb_field_arr[5], i);		
		}	
		document.getElementById("sambaShareAdd").disabled=false;
		document.getElementById("sambaShareEdit").disabled=false;
		document.getElementById("sambaShareDel").disabled=false;	
		document.getElementById("sambaShareAdd").className="tblbtn";
		document.getElementById("sambaShareEdit").className="tblbtn";
		document.getElementById("sambaShareDel").className="tblbtn";		
	}

	//Samba Setting Info
	var sambaSetting=<%getSambaSetting();%>;
	if (sambaSetting!="")
	{
		var sambaSettingArr = sambaSetting.split("#");
		var displaySamba = (sambaSettingArr[0]=="0")? false:true;
		if (displaySamba)
			document.getElementById('sambaUI').style.display = "block";		
		else
			document.getElementById('sambaUI').style.display = "none";
		get_by_id("SAMBA_ENABLE").checked = (sambaSettingArr[1]=="0")? false:true;
		get_by_id("SAMBA_ENABLE").value=sambaSettingArr[1];
		get_by_id("SAMBA_NAME").value=sambaSettingArr[2];
		get_by_id("SAMBA_DESCR").value=sambaSettingArr[3];
		get_by_id("SAMBA_WORKGROUP").value=sambaSettingArr[4];
		get_by_id("SAMBA_USERS").value=sambaSettingArr[5];
		get_by_id("SAMBA_PASSWORD").value=sambaSettingArr[6];
		admin_pwd=sambaSettingArr[6];	
	}
	else
	{
		get_by_id("SAMBA_ENABLE").value="";
		get_by_id("SAMBA_NAME").value="";
		get_by_id("SAMBA_DESCR").value="";
		get_by_id("SAMBA_WORKGROUP").value="";
		get_by_id("SAMBA_USERS").value="";
		get_by_id("SAMBA_PASSWORD").value="";				
		admin_pwd="";
	}

	accountChk();
	secChkBoxSelectOrUnselectAll('tblSambaShare', 'umiId', null);
}

function enable_samba()
{
  if (document.getElementById("SAMBA_ENABLE").checked==true)
  {
  	document.getElementById("SAMBA_ENABLE").value = "1";
  }
  else
  {
  	document.getElementById("SAMBA_ENABLE").value = "0";	
  }
}

function pageValidate()
{
	var user_pwd_rule =/^[a-zA-Z0-9]+$/;
	if(!CheckLoginInfo())
		return false;
	if(isBlank(get_by_id("SAMBA_NAME").value))
	{
	     alert(gettext("Enter valid SAMBA Server Name"));
	     return false;
	}
	if(isSpace(get_by_id("SAMBA_NAME").value))
	{
	     alert(gettext("Enter valid SAMBA Server Name without whitespace"));
	     return false;
	}
	if(!isValidName(get_by_id("SAMBA_NAME").value) || isDecimal(get_by_id("SAMBA_NAME").value))
	{
        alert(gettext("Samba Server Name cannot have characters from the set \"<>%\^[].`+$,='#&:\t"));
        return false;
	}
	if(isBlank(get_by_id("SAMBA_DESCR").value))
	{
	     alert(gettext("Enter valid SAMBA Server Description"));
	     return false;
	}
	if(!isValidName(get_by_id("SAMBA_DESCR").value) || isDecimal(get_by_id("SAMBA_DESCR").value))
	{
        alert(gettext("Samba Server Description cannot have characters from the set \"<>%\^[].`+$,='#&:\t"));
        return false;
	}
	if(isBlank(get_by_id("SAMBA_WORKGROUP").value))
	{
	     alert(gettext("Enter valid SAMBA Server Workgroup"));
	     return false;
	}
	if(!isValidName(get_by_id("SAMBA_WORKGROUP").value) || isDecimal(get_by_id("SAMBA_WORKGROUP").value))
	{
        alert(gettext("Work Group cannot have characters from the set \"<>%\^[].`+$,='#&:\t"));
        return false;
	}
	if(get_by_id("SAMBA_USERS").value=="admin")
	{
		if (isBlank(get_by_id("SAMBA_PASSWORD").value))
		{
			alert(gettext("Enter valid User Password"));
			return false;
		}
		if(!user_pwd_rule.test(get_by_id("SAMBA_PASSWORD").value))
		{
			alert(gettext("Password: Accept 0-9,a-z,A-Z or not accept Chinese format."));			
			return false;
		}		
	}
	return true;
}
//--> 
</script>

</head>


<body onload="loadUsbPage();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("usb_submenu","usb_submenu_focus","usb_storage","usb_storage_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
<div class="secH1">USB Storage</div>
	<!-- Section Begin -->
	<div class="secBg">
	<div class="statusMsg" id="statusMsg"><%getActionResult();%></div>        	
	<div class="secInfo" id="secInfo"></div>
	<table id="usbUI" border="0" cellpadding="0" cellspacing="0" style="display:none">
	 <tr>
		<td class="tdH" width="25%">Directory</td>
		<td class="tdH" width="15%">File System</td>
		<td class="tdH" width="15%">Total</td>
		<td class="tdH" width="15%">Used</td>
		<td class="tdH" width="15%">Available</td>
		<td class="tdH" width="15%">Percent</td>
	 </tr>
	 <tbody id="usb_storage_table"></tbody>
	</table>	
	</div>

	<div id="sambaUI" style="display:none">
	<!-- Samba Setting -->
	<div class="secBg">
	<div class="secInfo">SAMBA Server Settings</div>
		<form action="/goform/setSambaSetting" method="post">	
		<table class="configTbl" cellspacing="0" cellpadding="0" border="0">		
			<tr>
				<td>Enable SAMBA</td>
				<td>
					<input type="checkbox" id="SAMBA_ENABLE" name="SAMBA_ENABLE" onclick="enable_samba();" />      
				</td>				
				<td>&nbsp;</td>
			</tr>
			<tr style="display:none">
				<td >SAMBA Server Name </td>
				<td><input type="text" name="SAMBA_NAME" class="configF1" value="" id="SAMBA_NAME" size="12"  maxlength="24" ></td>
				<td>&nbsp;</td>
			</tr>					
			<tr>
				<td >SAMBA Server Description </td>
				<td><input type="text" name="SAMBA_DESCR" class="configF1" value="" id="SAMBA_DESCR" size="12"  maxlength="24" ></td>
				<td>&nbsp;</td>
			</tr>			
			<tr>
				<td >Work Group </td>
				<td ><input type="text" name="SAMBA_WORKGROUP" class="configF1" value="" id="SAMBA_WORKGROUP" size="12"  maxlength="24" ></td>
				<td>&nbsp;</td>
			</tr>		
			<tr>
				<td>User Account</td>
				<td>
					<select size="1" name="SAMBA_USERS" id="SAMBA_USERS" class="configF1" onchange="return accountChk();" style="width:182px;">
						<%getSambaAccount();%>                 
					</select>
				</td>
				<td>&nbsp;</td>
			</tr>	
			<tr>
				<td>User Password</td>
				<td>
					<input type="text" name="SAMBA_PASSWORD" class="configF1" value="" id="SAMBA_PASSWORD" size="12"  maxlength="24" >
					<span class="spanText">(User Account all doesn't need password)</span>
				</td>
				<td>&nbsp;</td>
			</tr>				
		</table>	
		<div class="submitBg">
			<input type="submit" value="Apply" class="submit" onclick="return pageValidate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">			
			<input type="button" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>	
		</form>
	</div>
	
	<!-- Samba share table -->	
	<div class="secBg">
	<div class="secInfo">Create a share for file sharing.</div>
	<form action="/goform/setSambaShare" method="post">
		<input type="hidden" id="ShareTblAction" name="ShareTblAction" value="">
		<input type="hidden" id="ShareName" name="ShareName" value="">
		<input type="hidden" id="ShareDelList" name="ShareDelList" value="">		
		<table id="tblSambaShare" border="0" cellpadding="0" cellspacing="0">
			<tr>		 
				<td class="tdH" width="5%"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblSambaShare', 'umiId', this)"></td>
				<td class="tdH" width="20%">Share Name</td>
				<td class="tdH" width="35%">Folder Path</td>
				<td class="tdH" width="25%">Access Level</td>
				<td class="tdH" width="15%">Users</td>
			</tr>		
			<tbody id="share_list_table"><%getSambaShare();%></tbody> 			
		</table>
		<div class="tblButtons">
			<input type="submit" id="sambaShareAdd" value="Add" class="tblbtn" onclick="return share_list_action('add');" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
			<input type="submit" id="sambaShareEdit" value="Edit" class="tblbtn" onclick="return share_list_action('edit');" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
			<input type="submit" id="sambaShareDel" value="Delete" class="tblbtn" onclick="return share_list_action('delete');" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">
		</div>	
	</form>
	</div> <!-- Samba share End -->
	</div> <!-- sambaUI end -->
	
</div> 
<!-- contentBg -->


</div> <!-- all end -->
</body>
</html>
