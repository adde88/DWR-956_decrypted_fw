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


function vpn_list_action(action)
{	
	var vpn_list_arr="";
	var vpn_list_idx=-1;
	document.getElementById('VpnTblIdx').value="";
	document.getElementById('statusMsg').innerHTML="";	
	var editor_action = document.getElementById('VpnTblAction');
	var secObj = document.getElementById('tblVpn');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;
	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{				
				count++;
				vpn_list_idx=i; 	
				vpn_list_arr+=vpn_list_idx+",";				
			}
		}
	}
	var ret=true;
	var ret_msg="";
	if (action=="add")
	{
		editor_action.value = "VpnTblAdd";			
	}
	else if (action=="edit")
	{
		if (count > 1)
		{
			ret_msg=gettext("Please select a row to edit.");
		}
		else if (count==0)
		{
			ret_msg=gettext("Please select a row from the list to be edited.");
		}	
		else		
		{
			editor_action.value = "VpnTblEdit";			
			document.getElementById('VpnTblIdx').value=vpn_list_idx;			
		}
	}
	else if (action=="delete")
	{
		if (count==0)
		{
			ret_msg=gettext("Please select items from the list to be deleted.");
		}
		else
		{
			editor_action.value = "VpnTblDel";		
			vpn_list_arr=vpn_list_arr.substr(0,vpn_list_arr.length-1);
			document.getElementById('VpnTblIdx').value=vpn_list_arr;			
		}
	}
	if (ret_msg!="" && get_by_id("statusMsg"))
	{
		get_by_id("statusMsg").innerHTML = ret_msg;
		return false;
	}
	return true;
}

function vpns_pptp_validate()
{
	var remote_start_str,remote_end_str;
	var remote_start, remote_end;		
	remote_start_str=document.getElementById('VPNS_PPTP_REMOTE_IP_START').value;
	remote_end_str=document.getElementById('VPNS_PPTP_REMOTE_IP_END').value;
	remote_start = parseInt(remote_start_str,10);
	remote_end = parseInt(remote_end_str,10); 
	var ret_msg="";
	if (remote_start_str=="")
	{
		ret_msg=gettext("Remote ip start address can't be empty.");
	}
	else if (remote_end_str=="")
	{
		ret_msg=gettext("Remote ip end address can't be empty.");
	}	
	else if (isNaN(remote_start) || isNaN(remote_end))
	{
		ret_msg=gettext("Remote ip range should be between 240~254.");
	}
	else if (remote_start >= remote_end)
	{	
		ret_msg=gettext("Remote ip start address should be less than the end.");
	}		
	else if (remote_start < 240 || remote_end > 254)
	{
		ret_msg=gettext("Remote ip range should be between 240~254.");
	}
	if (ret_msg!="")
	{
		get_by_id("statusMsg").innerHTML=ret_msg;
		return false;
	}		
	return true;
}

function vpnc_pptp_validate()
{
	var username = get_by_id('VPNC_PPTP_USERNAME');
	var password = get_by_id('VPNC_PPTP_PW');
	var serverip = get_by_id('VPNC_PPTP_SERVER');	
	var ret_msg="";

	if (username.value=="" || password.value=="")
	{
		ret_msg=gettext("Username and Password cannot be empty.");
	}	
	else if (!check_ascii(username))
	{
	   ret_msg=gettext("Invalid Username! Please confirm again.");
	}
	else if (!check_ip_format(serverip))
	{
		ret_msg=gettext("Invalid Server IP Address! Please confirm again.");
	}
	if (ret_msg!="")
	{
		get_by_id("statusMsg").innerHTML=ret_msg;
		return false;
	}		
	return true;	
}

function loadVpnPPTP()
{
	var vpn_config = <%getVpnPPTP();%>;
	if (vpn_config!="")
	{
		var vpn_config_arr = vpn_config.split("#");
		var range_arr = vpn_config_arr[0].split("-");
		get_by_id("VPNS_PPTP_REMOTE_IP_START").value=range_arr[0];
		get_by_id("VPNS_PPTP_REMOTE_IP_END").value=range_arr[1];	
		get_by_id('VPNC_PPTP_USERNAME').value=vpn_config_arr[1];
		get_by_id('VPNC_PPTP_PW').value=vpn_config_arr[2];
		get_by_id('VPNC_PPTP_SERVER').value=vpn_config_arr[3];	
	}
	secChkBoxSelectOrUnselectAll('tblVpn', 'umiId', null);	
}
</script>
</head>	

<body onload="loadVpnPPTP();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("vpn_submenu","vpn_submenu_focus","vpn_pptp","vpn_pptp_href");</script>
<!-- Main Menu and Submenu End -->


<div class="contentBg">
	<div class="secH1">VPN PPTP</div>

	<!-- pptp server start -->
	<div class="secBg">
	<div class="statusMsg" id="statusMsg"><%getActionResult();%></div>        			
	<div class="secInfo">
		<br>In this section you can set vpn pptp server.
		<br>
	</div>

	<form name="VPN_PPTP" action="/goform/setVpnServerPPTP" method="post">  
		<table border="0" cellpadding="0" cellspacing="0">      
	  	<tr>
	  		<td><script>document.write(gettext("Remote IP Range"));</script>
	  		</td>
	  		<td>
				<input type="text" class="fill" name="VPNS_PPTP_REMOTE_IP_START" id="VPNS_PPTP_REMOTE_IP_START" value="" size="2" maxlength="3"></input>
				<span>~</span>
				<input type="text" class="fill" name="VPNS_PPTP_REMOTE_IP_END" id="VPNS_PPTP_REMOTE_IP_END" value="" size="2" maxlength="3"></input>			
				(240~254)
	  		</td>  	
	  	</tr>  	    	
	  </table>
      <div class="tblButtons">
      	<input type="submit" value="Apply" class="tblbtn" onclick="return vpns_pptp_validate();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
      	<input type="reset" value="Discard" class="tblbtn" onclick="doRedirect();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
      </div>  		  	  
   </form>

	<div class="secInfo">
		<br><script>document.write(gettext("User Account List"));</script>
	</div>
	<form method="post" action="/goform/setVpnUserTbl">	
		<input type="hidden" id="VpnType" name="VpnType" value="pptp">
		<input type="hidden" id="VpnTblAction" name="VpnTblAction" value="">
		<input type="hidden" id="VpnTblIdx" name="VpnTblIdx" value="">				
		<table border="0" cellpadding="0" cellspacing="0" id="tblVpn">
			<tr>
				<td class="tdH"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblVpn', 'umiId', this)"></td>
				<td class="tdH"><script>document.write(gettext("Username"));</script></td>
				<td class="tdH"><script>document.write(gettext("Password"));</script></td>				
			</tr>
			<tbody><%getVpnUserTbl("pptp");%></tbody>			
		</table>
		<div>
			<input type="submit" class="tblbtn" value="Add" title="Add" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return vpn_list_action('add');"></td>
			<input type="submit" class="tblbtn" value="Edit"  title="Edit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return vpn_list_action('edit');"></td>
			<input type="submit" class="tblbtn" value="Delete" title="Delete" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return vpn_list_action('delete');"></td>			
		</div>
	</form>      
	</div>
	<!-- pptp server end -->

	<!-- pptp client start -->
	<div class="secBg">
	<div class="secInfo">		
		<br>In this section you can set vpn pptp client.
		<br>
	</div>
      <form name="VPN_CLIENT_PPTP" action="/goform/setVpnClientPPTP" method="post">
       	  <table class="configTbl" cellspacing="0" cellpadding="0" border="0">		  		  
		  	<tr>
		  		<td><script>document.write(gettext("Username"));</script></td>
		  		<td><input type="text" class="fill" name="VPNC_PPTP_USERNAME" id="VPNC_PPTP_USERNAME" value="" size="22" maxlength="24" onkeypress="return keypress_ascii(event)"></input></td>
		  	</tr>
		  	<tr>
		  		<td><script>document.write(gettext("Password"));</script></td>
		  		<td><input type="text" class="fill" name="VPNC_PPTP_PW" id="VPNC_PPTP_PW" value="" size="22" maxlength="24"></input></td>
		  	</tr>
		  	<tr>
		  		<td><script>document.write(gettext("Server IP Address"));</script></td>  		
		  		<td><input type="text" class="fill" name="VPNC_PPTP_SERVER" id="VPNC_PPTP_SERVER" value="" size="22" maxlength="15" onkeypress="return keypress_ip_format(event)"></input>
		  		<span id="example_IP"><script>document.write(gettext("(XXX.XXX.XXX.XXX, eg: 192.168.20.11)"));</script></SPAN></td>
		  	</tr>       
		  </table>    
	      <div class="tblButtons">
	      	<input type="submit" value="Apply" class="tblbtn" onclick="return vpnc_pptp_validate();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
	      	<input type="reset" value="Discard" class="tblbtn" onclick="doRedirect();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">			
	      </div>  		  
	  </form>  
	</div>
	<!-- pptp client end -->
</div>

</div> <!-- End of all -->
</body>
</html>

