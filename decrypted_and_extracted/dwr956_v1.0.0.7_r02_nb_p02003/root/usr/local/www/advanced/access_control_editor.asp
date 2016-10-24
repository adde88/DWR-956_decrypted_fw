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
//<!--
CheckInitLoginInfo(<%getuser_login();%>);
function servicechk ()
{
	var selOptVal = comboSelectedValueGet ('selPortservice');
	if (!selOptVal) return;
	switch (parseInt(selOptVal, 10))
	{
	case -1: /* Clickable for Add NEW Service */
		fieldStateChangeWr ('', '', 'AddNewServce', '');
		break;
	default:
		fieldStateChangeWr ('AddNewServce', '', '', '');
	}
}
function addCmpNamechk ()
{
	var selObjVal = comboSelectedValueGet ('selSchedule');
	if (!selObjVal) return;
	switch (parseInt(selObjVal, 10))
	{
	case -1: /* OTHER - Clickable Add New Computer */
		fieldStateChangeWr ('', '', 'addNewCmp', '');
		break;
	default:
		fieldStateChangeWr ('addNewCmp', '', '', '');
	}
}

function aclConfigAction(action)
{
	if(!CheckLoginInfo())
		return false;
	document.getElementById('ACLConfigAction').value=action;
	return true;
}


function pageLoad()
{
	var ACLConfig = <%getACLConfig();%>;
	var ACLConfigArr = ACLConfig.split("#");	
	document.getElementById("selPortservice").value=ACLConfigArr[0];
	document.getElementById("selSchedule").value = ACLConfigArr[1];
	if (ACLConfigArr[2]=='0')
		document.getElementById("status").value="Allow";
	else
		document.getElementById("status").value="Block";		
}

//--> 

</script>
</head>	

<body onload="pageLoad(); servicechk(); addCmpNamechk();">
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
		<div class="statusMsg"></div>
										
		<div class="secInfo">
			<br>You can allow or block common or custom services from being used by a computer  in the known computer list.
			<br>
			<a class="secLable1" href="access_control.asp">>> Back to Access Control page</a>        						
		</div>
		<form name="frmAclConfig" method="post" action="/goform/setACLConfig">
		<input type="hidden" name="ACLConfigAction" id="ACLConfigAction" value="">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td>Application</td>
				<td >
					<select size="1" name="service" id="selPortservice" class="configF1" onchange="return servicechk();" style="width:182px;">
						<%getServiceList();%>                 
					</select>
				</td>
				<td>
				<input type="submit" class="tblbtn_dis" value="Add Application" name="button.add.splAppsConfig" id="AddNewServce" title="Add Application" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return aclConfigAction('addService');"></td>
			</tr>
			<tr>
				<td>Computer Name</td>
				<td>
				<select size="1" name="name" class="configF1" id="selSchedule" onchange="return addCmpNamechk();" style="width:182px;">                        
						<%getHostList();%>      						
				</select>
			    </td>
				<td>
				<input type="submit" class="tblbtn_dis" value="Add Computer" name="button.addCmp.dnsKnownComputerConfig" id="addNewCmp" title="Add Computer" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return aclConfigAction('addHost');"></td>
			</tr>
			<tr>
				<td>Status</td>
				<td colspan="2">
					<select name="status" id="status" size="1" class="configF1">
						<option value="Allow">Allow</option>
						<option value="Block">Block</option>
					</select>
				</td>
			</tr>
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
					<td><input type="submit" value="Apply" class="submit" title="Apply" name="button.config.table.accessControl.-1" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="return aclConfigAction('apply');"></td>
					<td><input type="button" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>
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
