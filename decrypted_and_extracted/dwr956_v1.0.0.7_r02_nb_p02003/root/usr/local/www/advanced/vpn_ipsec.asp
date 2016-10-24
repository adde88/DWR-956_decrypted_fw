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
var login_flag="0";
if(login_flag=="1")
{
	window.location.href="../login.asp";
}


function ipsec_list_action(action)
{	
	var profileConfig = <%getVpnProfile();%>;
	var vpn_mode="";
	var ipsec_active_profile = "";
	if (profileConfig!="")
	{
		var cfgArr = profileConfig.split("#");
		vpn_mode = cfgArr[0];
		ipsec_active_profile = cfgArr[1];	
	}

	
	var ipsec_list_idx=-1;
	var ipsec_list_arr="";
	var ipsec_profile_name="";
	document.getElementById('IPSecTblIdx').value="";
	var editor_action = document.getElementById('IPSecTblAction');
	var secObj = document.getElementById('tblIPSec');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;
	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				ipsec_list_idx=i; 	
				ipsec_list_arr+=ipsec_list_idx+",";
				var id="ipsec_name_"+i;
				ipsec_profile_name=document.getElementById(id).innerHTML;

				if (vpn_mode=="ipsec" && ipsec_active_profile==ipsec_profile_name)
				{
					if (action=="edit")
						get_by_id("statusMsg").innerHTML="The active profile"+" "+ipsec_active_profile+" "+"cannot be edited.\n";
					else if (action=="delete")
						get_by_id("statusMsg").innerHTML="The active profile"+" "+ipsec_active_profile+" "+"cannot be deleted.\n";						
					return false;
				}
			}
		}
	}
	var ret=true;
	if (action=="add")
	{
		editor_action.value = "IPSecTblAdd";			
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
			editor_action.value = "IPSecTblEdit";			
			document.getElementById('IPSecTblIdx').value=ipsec_list_idx;
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
			editor_action.value = "IPSecTblDel";		
			ipsec_list_arr=ipsec_list_arr.substr(0,ipsec_list_arr.length-1);
			document.getElementById('IPSecTblIdx').value=ipsec_list_arr;
		}
	}
	return ret;
}

function chkNAT()
{
  if (get_by_id("nat_traversal").checked==true)
  {
  	get_by_id("nat_traversal").value = "on";
	get_by_id("keep_alive").disabled=false;
  }
  else
  {
  	get_by_id("nat_traversal").value = "off";	
	get_by_id("keep_alive").disabled=true;
	get_by_id("keep_alive").value="";
  }
}

function nat_validate()
{
	if (get_by_id("keep_alive").disabled==false)
	{
		var keep_alive=parseInt(get_by_id("keep_alive").value,10);
		if (keep_alive<1 || keep_alive>60)
		{
			alert(gettext("Enter valid Keep Alive time"));
			get_by_id("statusMsg").innerHTML=gettext("Enter valid Keep Alive time");
			return false;
		}
	}
	return true;
}

function pageLoad()
{
	var NatConfig=<%getVpnNAT();%>;
	if (NatConfig!="")
	{
		var NatConfigArr = NatConfig.split("#");

		get_by_id("nat_traversal").checked = (NatConfigArr[0]=="on")? true:false;
		chkNAT();
		get_by_id("keep_alive").value = NatConfigArr[1];
	}
	
}
</script>
</head>	

<body onload="secChkBoxSelectOrUnselectAll('tblIPSec','umiId',null); pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("vpn_submenu","vpn_submenu_focus","vpn_ipsec","vpn_ipsec_href");</script>
<!-- Main Menu and Submenu End -->


<div class="contentBg">
	<div class="secH1">VPN IPSEC</div>	
	<!-- Section Begin -->
	<div class="secBg">
	<div class="statusMsg" id="statusMsg"><%getActionResult();%></div>
	<div class="secInfo">
		<br>A list of all configured ipsec profiles is displayed here.  
		<br>
	</div>
	
	<div class="secH2">NAT Traversal</div>
	<form method="post" action="/goform/setVpnNAT">
	<input type="hidden" name="vpn_dummy" value="0">  	
	<table class="configTbl" border="0" cellpadding="0" cellspacing="0" >
		<tr>
			<td><script>document.write(gettext("NAT Traversal") );</script></td>
			<td><input type="checkbox" name="nat_traversal" id="nat_traversal" onclick="chkNAT();"></td>
			<td><script>document.write(gettext("Keep Alive") );</script></td>
			<td><input id="keep_alive" name="keep_alive" class="txtbox" type="text" value="" maxlength="24" size="15">seconds [1-60]</td>							
			<td><input type="submit" value="Apply" onclick="return nat_validate();" class="submit" title="Apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>			
			<td></td>
			<td></td>
		</tr>
	</table>
	</form>
	<br><br>
	
	<form method="post" action="/goform/setVpnIPSecTable">
		<input type="hidden" id="IPSecTblAction" name="IPSecTblAction" value="">
		<input type="hidden" id="IPSecTblIdx" name="IPSecTblIdx" value="">			
		<table border="0" cellpadding="0" cellspacing="0" id="tblIPSec" style="table-layout: fixed;" class="specTbl">
		 <tr>
		  <td class="tdH" width="10%"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" onclick="secChkBoxSelectOrUnselectAll ('tblIPSec', 'umiId', this)"></td>	  
		  <td class="tdH" width="15%">Name</td>
		  <td class="tdH" width="30%">Local Network</td>
		  <td class="tdH" width="30%">Remote Network</td>
		  <td class="tdH" width="15%">Remote Security Gateway</td>
		 </tr>
		 <tbody><%getVpnIPSecTable();%></tbody> 		 
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
		   <td><input type="submit" class="tblbtn" value="Add" title="Add" name="IPSecTblAdd" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return ipsec_list_action('add');"></td>
		   <td><input type="submit" class="tblbtn" value="Edit" title="Edit" name="IPSecTblEdit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return ipsec_list_action('edit');"></td>
		   <td><input type="submit" class="tblbtn" value="Delete" title="Delete" name="IPSecTblDel" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return ipsec_list_action('delete');"></td>
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

