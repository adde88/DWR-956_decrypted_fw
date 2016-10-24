<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/textValidations.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/ipv4AddrValidations.js" type="text/javascript"></script>
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
var portforwarding_status=<%getPortFwdStatus();%>;
if(portforwarding_status == "1")
{
	alert(gettext("The Service name and IP address already exist."));
}
function PortForwardingAction(state)
{
	if(!CheckLoginInfo())
		return false;
	document.getElementById('port_rowid').value="";
	var editor_action = document.getElementById('port_action');

	if (state=="add")
	{
		editor_action.value = "add";
	}
	else if (state=="edit")
	{

		var index_flag = editAllow('tblPortMapping');
		
		if(index_flag == false)
		{
			return false;
		}
		else		
		{
			editor_action.value = "edit";
			var port_forward_check = document.getElementsByName('port_forward_ck');
			var index="";
			if(port_forward_check.length>0)
			{
				for(var i=0;i<port_forward_check.length;i++)
				{
					if(port_forward_check[i].checked)
					{
						index=i;
						break;
					}
				}
			}
			document.getElementById('port_rowid').value=(index+1);
		}
	}
	else if (state=="delete")
	{
		if(deleteAllow1 ('tblPortMapping'))
		{
			editor_action.value = "delete";
			var port_forward_check = document.getElementsByName('port_forward_ck');
			var index="";
			if(port_forward_check.length>0)
			{
				for(var i=0;i<port_forward_check.length;i++)
				{
					if(port_forward_check[i].checked)
					{
						index=index+(i+1)+"#";
					}
				}
			}
			document.getElementById('port_rowid').value=index;
		}
		else
		{
			return false;
		}
	}
	return true;
}

</script>
</head>

<body onload="">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("nat_portforwarding", "nat_portforwarding_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg" id="main_forwarding">
	<div class="secH1">Port Forwarding</div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
			<br>Port Forwarding can be used to translate the port of common services to a custom port inside your local network.  This page displays all the port forwarding rules configured on the gateway.
			<br>
		</div>
		<div class="secH2">List of Port Forwarding Services</div>
		<form name="port_fwd_del" action="/goform/setPortFwdAction" method="post">
		<input type="hidden" id="port_rowid" name="port_rowid" value="0">
		<input type="hidden" id="port_action" name="port_action" value="0">
		<table border="0" cellpadding="0" cellspacing="0" id="tblPortMapping" width="550px" style="table-layout: fixed;" class="specTbl">
			<tr>
				<td class="tdH" width="10%"><input type="checkbox" id="imgSelectAll" title="Select All" onclick="secChkBoxSelectOrUnselectAll ('tblPortMapping', 'umiId', this)"></td>
				<td class="tdH" width="45%">Service</td>
				<td class="tdH" width="25%">IP Address</td>
				<td class="tdH" width="20%">Port Translation</td>
			</tr>
			<tbody>
      			<%getPortFwdList();%>
    		</tbody>
		</table>								
		<div>
			<input type="submit" value="Add" class="tblbtn" title="Add" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return PortForwardingAction('add');">
			<input type="submit" value="Edit" class="tblbtn" title="Edit" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return PortForwardingAction('edit');">
			<input type="submit" value="Delete" class="tblbtn" title="Delete" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return PortForwardingAction('delete');">
		</div>
		</form>									
	</div>
	<!-- Section End -->
</div>

</div>
</body>
</html>
