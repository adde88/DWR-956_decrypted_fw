<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
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

var temp_type;
var temp_ip;
function loadRemManPage()
{
	var RemManInfo=<%getRemoteManage();%>;
	var strArr = RemManInfo.split("#");
	if(strArr[0] == "1")
	{
		alert(gettext("The IP ranges already exist."));
	}
	if(strArr[1] == "1")
	{
		document.getElementById('chkEnable').checked=true;
	}
	else
	{
		document.getElementById('chkEnable').checked=false;
	}
	temp_type=strArr[3];
	temp_ip=strArr[2];
	document.getElementById('txtOnlyThisPC').value=strArr[2];
	document.getElementById('selAccessType').value=strArr[3];
	
}

function RemManAction(state)
{
	if(!CheckLoginInfo())
		return false;
	document.getElementById('ip_range_rowid').value="";
	var editor_action = document.getElementById('ip_range_action');

	if (state=="add")
	{
		editor_action.value = "add";			
	}
	else if (state=="edit")
	{

		var index_flag = editAllow('tblRemoteMgmt');
		if(index_flag == false)
		{
			return false;
		}
		else		
		{
			editor_action.value = "edit";			
			document.getElementById('ip_range_rowid').value=index_flag;
		}
	}
	else if (state=="delete")
	{
		if(deleteAllow1 ('tblRemoteMgmt'))
		{
			editor_action.value = "delete";
			var ip_range_check = document.getElementsByName('ip_range_ck');
			var index="";
			if(ip_range_check.length>0)
			{
				for(var i=0;i<ip_range_check.length;i++)
				{
					if(ip_range_check[i].checked)
					{
						index=index+(i+1)+"#";
					}
				}
			}
			document.getElementById('ip_range_rowid').value=index;
		}
		else
		{
			return false;
		}
	}
	return true;
}

function remoteMgmtConfCheck()
{
	var _9=document.getElementById("chkEnable");
	if(!_9)
	{
		return;
	}
	if(_9.checked)
	{
		fieldStateChangeWr("","","txtOnlyThisPC txtPort selAccessType AddIpRange EditIpRange DelIpRange","");
		remoteMgmtAccessTypeCheck();
	}
	else
	{
		fieldStateChangeWr("txtOnlyThisPC txtPort selAccessType AddIpRange EditIpRange DelIpRange","","","");
	}
}

function remoteMgmtAccessTypeCheck()
{	
	ResetIdleTime();
	var _a=comboSelectedValueGet("selAccessType");
	if(!_a)
	{
		return;
	}
	switch(parseInt(_a,10))
	{
		case 0:
			fieldStateChangeWr("AddIpRange EditIpRange DelIpRange txtOnlyThisPC","","","");
			break;
		case 1:
			fieldStateChangeWr("txtOnlyThisPC","","AddIpRange EditIpRange DelIpRange","");
			break;
		case 2:
			fieldStateChangeWr("AddIpRange EditIpRange DelIpRange","","txtOnlyThisPC","");
			break;
	}
}

function remoteMgmtValidation()
{
	if(!CheckLoginInfo())
		return false;
	var i18n_enterValidFromIP = "Please enter a valid From IP address.";
	var i18n_enterValidToIP = "Please enter a valid To IP address";
	var i18n_enterValidIP = "Please enter a valid IP Address";
	var i18n_enterValidPort = "Please enter a valid Port";
	var i18n_invalidIP = "Invalid IP Address.";
	var i18n_forOctet = "for octet ";

	var _1=new Array();
	_1[0]="txtRemoteFromAddr,"+i18n_enterValidFromIP;
	_1[1]="txtRemoteToAddr,"+i18n_enterValidToIP;
	_1[2]="txtOnlyThisPC,"+i18n_enterValidIP;
	_1[3]="txtPort,"+i18n_enterValidPort;
	if(txtFieldArrayCheck(_1)==false)
	{
		return false;
	}
	if(ipv4Validate("txtRemoteFromAddr","IP",false,true,i18n_invalidIP,i18n_forOctet,true)==false)
	{
		return false;
	}
	if(ipv4Validate("txtRemoteToAddr","IP",false,true,i18n_invalidIP,i18n_forOctet,true)==false)
	{
		return false;
	}
	if(ipv4Validate("txtOnlyThisPC","IP",false,true,i18n_invalidIP,i18n_forOctet,true)==false)
	{
		return false;
	}

	if(document.getElementById("chkEnable").checked)
	{
		document.getElementById("tempEnable").value = "1";
		document.getElementById("tempAccessType").value = document.getElementById("selAccessType").value;
		document.getElementById("tempIp").value = document.getElementById("txtOnlyThisPC").value;
	}
	else
	{
		document.getElementById("tempEnable").value = "0";
		document.getElementById("tempAccessType").value = temp_type;
		document.getElementById("tempIp").value = temp_ip;
	}
	
	
	return true;
}

</script>
</head>
<body onload="loadRemManPage();remoteMgmtConfCheck();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("sys");%>
<script type="text/javascript">menuChange("sys_menu");leftMenuChange("remote_manage", "remote_manage_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg" id="rem_manage">
	<div class="secH1"><script>document.write(gettext("Remote Management"));</script></div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
<br><script>document.write(gettext("This feature can be used to manage the box remotely from WAN side."));</script>
<br></div>
		<form name="REMOTE_MANAGEMWNT" action="/goform/setRemManage" method="post">
		<input type="hidden" name="tempEnable" id="tempEnable" value="0">
		<input type="hidden" name="tempAccessType" id="tempAccessType" value="0">
		<input type="hidden" name="tempIp" id="tempIp" value="0.0.0.0">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Enable Remote Management:"));</script></td>
				<td>
				<input type="checkbox" name="EnableRemMan" id="chkEnable" onclick="remoteMgmtConfCheck();">
			</tr>
			<tr>
				<td><script>document.write(gettext("Access Type"));</script></td>
				<td>
					<select name="RemManAccessType" class="configF1" id="selAccessType" onchange="remoteMgmtAccessTypeCheck();">
						<option  value="0"><script>document.write(gettext("All IP Addresses"));</script></option>
						<option  value="1"><script>document.write(gettext("IP Address Range"));</script></option>
						<option  value="2"><script>document.write(gettext("Only this PC"));</script></option>
					</select>
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("IP Address"));</script></td>
				<td>
					<input type="text" name="RemManIPAddress" id="txtOnlyThisPC" value="" size="20" maxlength="15" class="configF1" onkeypress="return numericValueCheck (event, '.')">
				</td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" id="apply_remote_manage" value="Apply" class="submit" title="Apply" name="" onclick="return remoteMgmtValidation ();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" id="reset_remote_manage" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
		</form>
		<!-- Multiple IP ranges Configuration  -->
		<div class="secH2"><script>document.write(gettext("Multiple IP ranges Configuration"));</script></div>
		<form name="DEL_IP_RANGE" action="/goform/setRemManageAction" method="post">
		<input type="hidden" id="ip_range_rowid" name="ip_range_rowid" value="0">
		<input type="hidden" id="ip_range_action" name="ip_range_action" value="0">
		<table border="0" cellpadding="0" cellspacing="0" id="tblRemoteMgmt">
			<tr>
				<td class="tdH"><input type="checkbox" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblRemoteMgmt', 'umiId', this)"></td>
				<td class="tdH"><script>document.write(gettext("Start IP Address"));</script></td>
				<td class="tdH"><script>document.write(gettext("End IP Address"));</script></td>
			</tr>
			<tbody>
	  			<%getIpRangeList();%>
    		</tbody>
		</table>
		<div id="tblBtns">
<!--		<input type="button" value="Add" class="tblbtn" title="Add" name="" id="AddIpRange" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="AddNewIpRange('add');">
			<input type="button" value="Edit" class="tblbtn" title="Edit" name="" id="EditIpRange" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="AddNewIpRange('edit');">
			<input type="submit" value="Delete" class="tblbtn" title="Delete" name="" id="DelIpRange" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return DeleteRemMan();">-->
			<input type="submit" value="Add" class="tblbtn" title="Add" name="" id="AddIpRange" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return RemManAction('add');">
			<input type="submit" value="Edit" class="tblbtn" title="Edit" name="" id="EditIpRange" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return RemManAction('edit');">
			<input type="submit" value="Delete" class="tblbtn" title="Delete" name="" id="DelIpRange" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return RemManAction('delete');">
		</div>
		</form>
	</div>
	<!-- Section End -->
</div>

</div><!-- all end -->
 <script type="text/javascript">
	document.getElementById('AddIpRange').value=gettext("Add");
	document.getElementById('EditIpRange').value=gettext("Edit");
	document.getElementById('DelIpRange').value=gettext("Delete");
	document.getElementById('apply_remote_manage').value=gettext("Apply");
	document.getElementById('reset_remote_manage').value=gettext("Reset");
 </script>

</body>
</html>
