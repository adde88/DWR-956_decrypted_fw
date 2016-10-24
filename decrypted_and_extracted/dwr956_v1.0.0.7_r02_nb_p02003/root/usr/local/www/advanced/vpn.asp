<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>NEW IAD</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/styles.css" type="text/css" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
var login_flag=<%getuser_login();%>;
if(login_flag=="1")
{
	window.location.href="../login.asp";
}
var account_idx=-1;
var edit_flag;
var account_list = new Object();

var l2tp_account_idx=-1;
var l2tp_edit_flag;
var l2tp_account_list = new Object();


function vpns_pptp_account_selected()
{
  var id = this.id;
  var arr = id.split("__");
  var idx = parseInt(arr[arr.length-1]);
  account_idx=idx;  
  var vpns_account_editor = document.getElementById('vpns_account_editor');
  vpns_account_editor.style.display="none";
}

function vpns_pptp_account(action)
{	
	var vpns_account_editor = document.getElementById('vpns_account_editor');
	var table = document.getElementById('vpns_pptp_user_account_table');

	if (action=="add")
	{
		vpns_account_editor.style.display="block";
		document.getElementById('vpns_pptp_username').value="";
		document.getElementById('vpns_pptp_pwd').value="";
		edit_flag = "add";
	}
	else if (action=="edit")
	{
		if (account_idx==-1)
			vpns_account_editor.style.display="none";
		else			
		{
			vpns_account_editor.style.display="block";
			var account_user="vpns_pptp_user__"+account_idx;
			var account_pwd="vpns_pptp_pwd__"+account_idx;
    		document.getElementById('vpns_pptp_username').value = document.getElementById(account_user).innerHTML.toString();
    		document.getElementById('vpns_pptp_pwd').value = document.getElementById(account_pwd).innerHTML.toString();
			edit_flag = "edit";
		}
	}	
	else if (action=="delete")
	{
		vpns_account_editor.style.display="none";
		if (account_idx>-1)
		{
			account_list.splice(account_idx,1);
			if(table!=null && table.hasChildNodes())
			{
				while(table.childNodes.length>=1)
				{
					table.removeChild(table.firstChild);
				}
			}		
			for (var i = 0; i < account_list.length; i++)
			{
				drawUserAccount(table,account_list[i].user, account_list[i].pwd,i);								
			}	
		}
	}
}

function vpns_pptp_account_validate(action)
{
	var vpns_account_editor = document.getElementById('vpns_account_editor');
	var table = document.getElementById('vpns_pptp_user_account_table');

	if (action=="apply")
	{
		vpns_account_editor.style.display="none";
		var username=document.getElementById('vpns_pptp_username').value;
		var password=document.getElementById('vpns_pptp_pwd').value;

		if (username=="" || password=="")
		{
			alert(gettext("Username and Password cannot be empty."));
			return false;
		}
		else if (!check_ascii(document.getElementById('vpns_pptp_username')))
		{
	       alert(gettext("Invalid Username! Please confirm again."));
	       return false;
		}
		if (edit_flag=="add")
		{
			var account_data = new Object();
			account_data.user = username;
			account_data.pwd = password;
			account_list.push(account_data);	

			//draw one 
			drawUserAccount(document.getElementById('vpns_pptp_user_account_table'), 
				username, password,account_list.length-1);				
		}	
		else if (edit_flag=="edit")
		{
			account_list[account_idx].user=username;
			account_list[account_idx].pwd=password;
		
			if(table!=null && table.hasChildNodes())
			{
				while(table.childNodes.length>=1)
				{
					table.removeChild(table.firstChild);
				}
			}		
			for (var i = 0; i < account_list.length; i++)
			{
				drawUserAccount(table,account_list[i].user, account_list[i].pwd,i);								
			}	
		}
	}

	if (action=="discard")
	{
		if (account_idx >= 0 && edit_flag=="edit")
		{
	        document.getElementById('vpns_pptp_username').value=account_list[account_idx].user;
			document.getElementById('vpns_pptp_pwd').value=account_list[account_idx].pwd;
		}
		else
		{
			if(account_idx>=0)
			{
				var vpns_pptp_idx = "vpns_pptp_idx__" + account_idx;
	  	    	document.getElementById(vpns_pptp_idx).checked=false;
				account_idx=-1;
			}
			document.getElementById('vpns_l2tp_username').value="";
			document.getElementById('vpns_l2tp_pwd').value="";
			
		}
		/*
		vpns_account_editor.style.display="none";
		document.getElementById('vpns_pptp_username').value="";
		document.getElementById('vpns_pptp_pwd').value="";		*/
	}	
}


function vpns_l2tp_account_selected()
{
  var id = this.id;
  var arr = id.split("__");
  var idx = parseInt(arr[arr.length-1]);
  l2tp_account_idx=idx;  
  var vpns_account_editor = document.getElementById('vpns_l2tp_account_editor');
  vpns_account_editor.style.display="none";
}

function vpns_l2tp_account(action)
{	
	var vpns_account_editor = document.getElementById('vpns_l2tp_account_editor');
	var table = document.getElementById('vpns_l2tp_user_account_table');

	if (action=="add")
	{
		vpns_account_editor.style.display="block";
		document.getElementById('vpns_l2tp_username').value="";
		document.getElementById('vpns_l2tp_pwd').value="";
		l2tp_edit_flag = "add";
	}
	else if (action=="edit")
	{
		if (l2tp_account_idx==-1)
			vpns_account_editor.style.display="none";
		else			
		{
			vpns_account_editor.style.display="block";
			var account_user="vpns_l2tp_user__"+l2tp_account_idx;
			var account_pwd="vpns_l2tp_pwd__"+l2tp_account_idx;
    		document.getElementById('vpns_l2tp_username').value = document.getElementById(account_user).innerHTML.toString();
    		document.getElementById('vpns_l2tp_pwd').value = document.getElementById(account_pwd).innerHTML.toString();
			l2tp_edit_flag = "edit";
		}
	}	
	else if (action=="delete")
	{
		vpns_account_editor.style.display="none";
		if (l2tp_account_idx>-1)
		{
			l2tp_account_list.splice(l2tp_account_idx,1);
			if(table!=null && table.hasChildNodes())
			{
				while(table.childNodes.length>=1)
				{
					table.removeChild(table.firstChild);
				}
			}		
			for (var i = 0; i < l2tp_account_list.length; i++)
			{
				drawL2TPUserAccount(table,l2tp_account_list[i].user, l2tp_account_list[i].pwd,i);								
			}	
		}
	}
}

function vpns_l2tp_account_validate(action)
{
	var vpns_account_editor = document.getElementById('vpns_l2tp_account_editor');
	var table = document.getElementById('vpns_l2tp_user_account_table');

	if (action=="apply")
	{
		vpns_account_editor.style.display="none";
		var username=document.getElementById('vpns_l2tp_username').value;
		var password=document.getElementById('vpns_l2tp_pwd').value;

		if (username=="" || password=="")			
		{		
			alert(gettext("Username and Password cannot be empty."));
			return false;
		}
		else if (!check_ascii(document.getElementById('vpns_l2tp_username')))
		{
	       alert(gettext("Invalid Username! Please confirm again."));
	       return false;
		}		
		if (l2tp_edit_flag=="add")
		{
			var account_data = new Object();
			account_data.user = username;
			account_data.pwd = password;
			l2tp_account_list.push(account_data);	

			//draw one 
			drawL2TPUserAccount(document.getElementById('vpns_l2tp_user_account_table'), 
				username, password,l2tp_account_list.length-1);							
		}	
		else if (l2tp_edit_flag=="edit")
		{
			l2tp_account_list[l2tp_account_idx].user=username;
			l2tp_account_list[l2tp_account_idx].pwd=password;
		
			if(table!=null && table.hasChildNodes())
			{
				while(table.childNodes.length>=1)
				{
					table.removeChild(table.firstChild);
				}
			}		
			for (var i = 0; i < l2tp_account_list.length; i++)
			{
				drawL2TPUserAccount(table,l2tp_account_list[i].user, l2tp_account_list[i].pwd,i);								
			}	
		}
	}

	if (action=="discard")
	{
		if (l2tp_account_idx >= 0 && l2tp_edit_flag=="edit")
		{
	        document.getElementById('vpns_l2tp_username').value=l2tp_account_list[l2tp_account_idx].user;
			document.getElementById('vpns_l2tp_pwd').value=l2tp_account_list[l2tp_account_idx].pwd;
		}
		else
		{
			if(l2tp_account_idx>=0)
			{
				var vpns_l2tp_idx = "vpns_l2tp_idx__" + l2tp_account_idx;
	  	    	document.getElementById(vpns_l2tp_idx).checked=false;
				l2tp_account_idx=-1;
			}
			document.getElementById('vpns_l2tp_username').value="";
			document.getElementById('vpns_l2tp_pwd').value="";
			
		}


		/*
		vpns_account_editor.style.display="none";
		document.getElementById('vpns_l2tp_username').value="";
		document.getElementById('vpns_l2tp_pwd').value="";		*/
	}	
}

function drawUserAccount(table, user, password, array_index)
{
	var row = document.createElement("tr");
	var col;
	var cellText;
	var input;
	row.bgColor  = "#d9d9d9";

	/* selected account */
	col = document.createElement("td");
	input = document.createElement("input");
	input.id = "vpns_pptp_idx__"+array_index;
	input.name = "vpns_pptp_idx";
	input.type = "radio";
	input.onclick = vpns_pptp_account_selected;
	col.appendChild(input);		
	row.appendChild(col);

	/* user */
	col = document.createElement("td");
	col.setAttribute("style","overflow: hidden; text-overflow: ellipsis; white-space: nowrap;");
	col.id = "vpns_pptp_user__"+array_index;
	col.name = "vpns_pptp_user__"+array_index;
	cellText = document.createTextNode(user);	
	col.appendChild(cellText);
	row.appendChild(col);
	
	/* password */
	col = document.createElement("td");
	col.setAttribute("style","overflow: hidden; text-overflow: ellipsis; white-space: nowrap;");	
	col.id = "vpns_pptp_pwd__"+array_index;
	col.name = "vpns_pptp_pwd__"+array_index;
	cellText = document.createTextNode(password);
	col.appendChild(cellText);
	row.appendChild(col);
		
	table.appendChild(row);
}

function drawL2TPUserAccount(table, user, password, array_index)
{
	var row = document.createElement("tr");
	var col;
	var cellText;
	var input;
	row.bgColor  = "#d9d9d9";

	/* selected account */
	col = document.createElement("td");
	input = document.createElement("input");
	input.id = "vpns_l2tp_idx__"+array_index;
	input.name = "vpns_l2tp_idx";
	input.type = "radio";
	input.onclick = vpns_l2tp_account_selected;
	col.appendChild(input);		
	row.appendChild(col);

	/* user */
	col = document.createElement("td");
	col.setAttribute("style","overflow: hidden; text-overflow: ellipsis; white-space: nowrap;");
	col.id = "vpns_l2tp_user__"+array_index;
	col.name = "vpns_l2tp_user__"+array_index;
	cellText = document.createTextNode(user);	
	col.appendChild(cellText);
	row.appendChild(col);
	
	/* password */
	col = document.createElement("td");
	col.setAttribute("style","overflow: hidden; text-overflow: ellipsis; white-space: nowrap;");	
	col.id = "vpns_l2tp_pwd__"+array_index;
	col.name = "vpns_l2tp_pwd__"+array_index;
	cellText = document.createTextNode(password);
	col.appendChild(cellText);
	row.appendChild(col);
		
	table.appendChild(row);
}

function loadVPNPage()
{
	//vpn passthrough
	var vpnp_pptp = <%getConf("VPNP_PPTP");%>;
	var vpnp_l2tp = <%getConf("VPNP_L2TP");%>;
	var vpnp_ipsec = <%getConf("VPNP_IPSEC");%>;

	//vpn mode
	var vpn_mode = <%getConf("VPN_MODE");%>;
	//vpns setting
	var vpns_mode = <%getConf("VPNS_MODE");%>;	
	var vpns_pptp_username = <%getConf("VPNS_PPTP_USERNAME");%>;
	var vpns_pptp_pwd = <%getConf("VPNS_PPTP_PW");%>;
	var vpns_pptp_remote_ip_range = <%getConf("VPNS_PPTP_REMOTE_IP_RANGE");%>;	
	
	var vpns_l2tp_username = <%getConf("VPNS_L2TP_USERNAME");%>;
	var vpns_l2tp_pwd = <%getConf("VPNS_L2TP_PW");%>;
	var vpns_l2tp_remote_ip_range = <%getConf("VPNS_L2TP_REMOTE_IP_RANGE");%>;
	var vpns_l2tp_mode = <%getConf("VPNS_L2TP_MODE");%>;
	
	//vpnc setting
	var vpnc_mode = <%getConf("VPNC_MODE");%>;
	var vpnc_pptp_username = <%getConf("VPNC_PPTP_USERNAME");%>;
	var vpnc_pptp_pwd = <%getConf("VPNC_PPTP_PW");%>;
	var vpnc_pptp_server = <%getConf("VPNC_PPTP_SERVER");%>;
	var vpnc_l2tp_username = <%getConf("VPNC_L2TP_USERNAME");%>;
	var vpnc_l2tp_pwd = <%getConf("VPNC_L2TP_PW");%>;
	var vpnc_l2tp_server = <%getConf("VPNC_L2TP_SERVER");%>;
	var vpnc_l2tp_mode = <%getConf("VPNC_L2TP_MODE");%>;


	/* pptp server */
	account_list = new Array();
	if (vpns_pptp_username!="" && vpns_pptp_pwd!="")
	{
	    var vpns_pptp_username_arr = vpns_pptp_username.split("#");
		var vpns_pptp_password_arr = vpns_pptp_pwd.split("#");
		var index=0;		
		for (index=0; index<vpns_pptp_username_arr.length;index++)
		{
			var account_data = new Object();
			account_data.user = vpns_pptp_username_arr[index];
			account_data.pwd = vpns_pptp_password_arr[index];
			account_list.push(account_data);
			drawUserAccount(document.getElementById('vpns_pptp_user_account_table'), 
				vpns_pptp_username_arr[index], vpns_pptp_password_arr[index],index);
		}
	}
	
	if (vpns_pptp_remote_ip_range!="")
	{
		var range_arr = vpns_pptp_remote_ip_range.split("-");
		document.getElementById('VPNS_PPTP_REMOTE_IP_START').value=range_arr[0];			
		document.getElementById('VPNS_PPTP_REMOTE_IP_END').value=range_arr[1];				
	}


	/* l2tp server */
	l2tp_account_list = new Array();
	if (vpns_l2tp_username!="" && vpns_l2tp_pwd!="")
	{
	    var vpns_l2tp_username_arr = vpns_l2tp_username.split("#");
		var vpns_l2tp_password_arr = vpns_l2tp_pwd.split("#");
		var index=0;		
		for (index=0; index<vpns_l2tp_username_arr.length;index++)
		{
			var account_data = new Object();
			account_data.user = vpns_l2tp_username_arr[index];
			account_data.pwd = vpns_l2tp_password_arr[index];
			l2tp_account_list.push(account_data);
			drawL2TPUserAccount(document.getElementById('vpns_l2tp_user_account_table'), 
				vpns_l2tp_username_arr[index], vpns_l2tp_password_arr[index],index);
		}
	}
	
	if (vpns_l2tp_remote_ip_range!="")
	{
		var range_arr = vpns_l2tp_remote_ip_range.split("-");
		document.getElementById('VPNS_L2TP_REMOTE_IP_START').value=range_arr[0];			
		document.getElementById('VPNS_L2TP_REMOTE_IP_END').value=range_arr[1];						
	}	
	
	document.getElementById('VPNC_PPTP_USERNAME').value=vpnc_pptp_username;
	document.getElementById('VPNC_PPTP_PW').value=vpnc_pptp_pwd;
	document.getElementById('VPNC_PPTP_SERVER').value=vpnc_pptp_server;
	document.getElementById('VPNC_L2TP_USERNAME').value=vpnc_l2tp_username;
	document.getElementById('VPNC_L2TP_PW').value=vpnc_l2tp_pwd;
	document.getElementById('VPNC_L2TP_SERVER').value=vpnc_l2tp_server;	
	

	//VPN Passthrough
	if (vpnp_pptp == "on")
	{
		document.getElementById('pptp_pt_on').checked = true;
		document.getElementById('pptp_pt_off').checked = false;
	}
	else
	{
		document.getElementById('pptp_pt_on').checked = false;
		document.getElementById('pptp_pt_off').checked = true;		
	}
	
	if (vpnp_l2tp == "on")
	{
		document.getElementById('l2tp_pt_on').checked = true;
		document.getElementById('l2tp_pt_off').checked = false;
	}
	else
	{
		document.getElementById('l2tp_pt_on').checked = false;
		document.getElementById('l2tp_pt_off').checked = true;		
	}
	
	if (vpnp_ipsec == "on")
	{
		document.getElementById('ipsec_pt_on').checked = true;
		document.getElementById('ipsec_pt_off').checked = false;
	}
	else
	{
		document.getElementById('ipsec_pt_on').checked = false;
		document.getElementById('ipsec_pt_off').checked = true;		
	}


	//VPN Mode Setting
	if (vpn_mode == "disable")
	{
		document.VPN_FORM.VPN_MODE.options.selectedIndex=0;
		document.getElementById('VPN_SERVER').style.display = "none";	
		document.getElementById('VPN_CLIENT').style.display = "none";	
	}
	else if (vpn_mode == "vpns")
	{
		document.VPN_FORM.VPN_MODE.options.selectedIndex=1;
		document.getElementById('VPN_SERVER').style.display = "";	
		document.getElementById('VPN_CLIENT').style.display = "none";
		if (vpns_mode=="pptp")
		{
			document.VPN_FORM.VPNS_MODE.options.selectedIndex=0;
			document.getElementById('vpns_pptp').style.display = "";	
			document.getElementById('vpns_l2tp').style.display = "none";		
		}
		else 
		{
			document.VPN_FORM.VPNS_MODE.options.selectedIndex=1;
			document.getElementById('vpns_pptp').style.display = "none";	
			document.getElementById('vpns_l2tp').style.display = "";		

			if (vpns_l2tp_mode=="l2tp")
			{
				document.VPN_FORM.VPNS_L2TP_MODE.options.selectedIndex=0;
			}
			else
			{
				document.VPN_FORM.VPNS_L2TP_MODE.options.selectedIndex=1;
			}
		
		}		
	}
	else if (vpn_mode == "vpnc")
	{
		document.VPN_FORM.VPN_MODE.options.selectedIndex=2;
		document.getElementById('VPN_SERVER').style.display = "none";	
		document.getElementById('VPN_CLIENT').style.display = "";
		if (vpnc_mode=="pptp")
		{
			document.VPN_FORM.VPNC_MODE.options.selectedIndex=0;
			document.getElementById('vpnc_pptp').style.display = "";	
			document.getElementById('vpnc_l2tp').style.display = "none";			
		}
		else 
		{
			document.VPN_FORM.VPNC_MODE.options.selectedIndex=1;
			document.getElementById('vpnc_pptp').style.display = "none";	
			document.getElementById('vpnc_l2tp').style.display = "";		
		}
		
		if (vpnc_l2tp_mode=="l2tp")
		{
			document.VPN_FORM.VPNC_L2TP_MODE.options.selectedIndex=0;
		}
		else
		{
			document.VPN_FORM.VPNC_L2TP_MODE.options.selectedIndex=1;
		}
	}

}

function submit_vpn_passthrough()
{
	document.VPN.submit();
	return true;
}

function submit_vpn_setting()
{
	//add input check for different vpn mode
	var mode = document.VPN_FORM.VPN_MODE.options.selectedIndex;
	var server_mode = document.VPN_FORM.VPNS_MODE.options.selectedIndex;
	var client_mode = document.VPN_FORM.VPNC_MODE.options.selectedIndex;
	if (mode==1) //server
	{
		var remote_start_str,remote_end_str;
		var remote_start, remote_end;		
		if (server_mode==0) //pptp
		{
			remote_start_str=document.getElementById('VPNS_PPTP_REMOTE_IP_START').value;
			remote_end_str=document.getElementById('VPNS_PPTP_REMOTE_IP_END').value;
		}
		else
		{
			remote_start_str=document.getElementById('VPNS_L2TP_REMOTE_IP_START').value;
			remote_end_str=document.getElementById('VPNS_L2TP_REMOTE_IP_END').value;
		}
		remote_start = parseInt(remote_start_str,10);
		remote_end = parseInt(remote_end_str,10); 
		
		if (remote_start_str=="")
		{
	  		alert(gettext("Remote ip start address can't be empty."));			
			return false;				
		}
		else if (remote_end_str=="")
		{
	  		alert(gettext("Remote ip end address can't be empty."));			
			return false;				
		}	
		else if (isNaN(remote_start) || isNaN(remote_end))
		{
			alert(gettext("Remote ip range should be between 240~254."));
			return false;
		}
		else if (remote_start >= remote_end)
		{	
	  		alert(gettext("Remote ip start address should be less than the end."));			
			return false;
		}		
		else if (remote_start < 240 || remote_end > 254)
		{
	  		alert(gettext("Remote ip range should be between 240~254."));			
			return false;			
		}
	}
	else if (mode==2) //client
	{
		var username;
		var serverip;
		if (client_mode==0) //pptp
		{
			username = document.getElementById('VPNC_PPTP_USERNAME');
			serverip = document.getElementById('VPNC_PPTP_SERVER');		
		}
		else 
		{
			username = document.getElementById('VPNC_L2TP_USERNAME');
			serverip = document.getElementById('VPNC_L2TP_SERVER');		
		}
		if (!check_ascii(username))
		{
	       alert(gettext("Invalid Username! Please confirm again."));
	       return false;
		}
		if (!check_ip_format(serverip))
		{
			alert(gettext("Invalid Server IP Address! Please confirm again."));
			return false;
		}			
	}
		

	var username="";
	var password="";
	var local_ip="";
	var remote_ip="";

	// pptp
	for (var i = 0; i < account_list.length; i++)
	{
		if (i==account_list.length-1)
		{
			username=username+account_list[i].user;
			password=password+account_list[i].pwd;
		}
		else
		{
			username=username+account_list[i].user+"#";
			password=password+account_list[i].pwd+"#";
		}
	}
	document.getElementById('VPNS_PPTP_USERNAME').value=username;
	document.getElementById('VPNS_PPTP_PW').value=password;
	document.getElementById('VPNS_PPTP_REMOTE_IP_RANGE').value=
	document.getElementById('VPNS_PPTP_REMOTE_IP_START').value+"-"+
	document.getElementById('VPNS_PPTP_REMOTE_IP_END').value;

	//l2tp
	local_ip="";
	remote_ip="";
	username="";
	password="";	
	for (var i = 0; i < l2tp_account_list.length; i++)
	{
		if (i==l2tp_account_list.length-1)
		{
			username=username+l2tp_account_list[i].user;
			password=password+l2tp_account_list[i].pwd;
		}
		else
		{
			username=username+l2tp_account_list[i].user+"#";
			password=password+l2tp_account_list[i].pwd+"#";
		}
	}
	document.getElementById('VPNS_L2TP_USERNAME').value=username;
	document.getElementById('VPNS_L2TP_PW').value=password;
	document.getElementById('VPNS_L2TP_REMOTE_IP_RANGE').value=
	document.getElementById('VPNS_L2TP_REMOTE_IP_START').value+"-"+
	document.getElementById('VPNS_L2TP_REMOTE_IP_END').value;
	
	document.VPN_FORM.submit();
	return true;
}

function ChangeVPN()
{
	if (document.VPN_FORM.VPN_MODE.options.selectedIndex == 0)
	{
		document.getElementById('VPN_SERVER').style.display = "none";	
		document.getElementById('VPN_CLIENT').style.display = "none";
	}
	else if (document.VPN_FORM.VPN_MODE.options.selectedIndex == 1)
	{
		document.getElementById('VPN_SERVER').style.display = "block";	
		document.getElementById('VPN_CLIENT').style.display = "none";
		var vpns_mode = <%getConf("VPNS_MODE");%>;	
		if (vpns_mode=="pptp")
		{
		  document.VPN_FORM.VPNS_MODE.options.selectedIndex=0;
		  document.getElementById('vpns_pptp').style.display = "block";	
		  document.getElementById('vpns_l2tp').style.display = "none";							
		}
		else
		{
		  document.VPN_FORM.VPNS_MODE.options.selectedIndex=1;
		  document.getElementById('vpns_pptp').style.display = "none";	
		  document.getElementById('vpns_l2tp').style.display = "block";										
		}		
	}
	else if (document.VPN_FORM.VPN_MODE.options.selectedIndex == 2)
	{
		document.getElementById('VPN_SERVER').style.display = "none";	
		document.getElementById('VPN_CLIENT').style.display = "block";

		var vpnc_mode = <%getConf("VPNC_MODE");%>;	
		if (vpnc_mode=="pptp")
		{
		  document.VPN_FORM.VPNC_MODE.options.selectedIndex=0;
		  document.getElementById('vpnc_pptp').style.display = "block";	
		  document.getElementById('vpnc_l2tp').style.display = "none";							
		}
		else
		{
		  document.VPN_FORM.VPNC_MODE.options.selectedIndex=1;
		  document.getElementById('vpnc_pptp').style.display = "none";	
		  document.getElementById('vpnc_l2tp').style.display = "block";										
		}				
	}
}

function ChangeVPNServer()
{
	if (document.VPN_FORM.VPNS_MODE.options.selectedIndex == 0) 
	{	//pptp
		document.getElementById('vpns_pptp').style.display = "";	
		document.getElementById('vpns_l2tp').style.display = "none";
	}
	else if (document.VPN_FORM.VPNS_MODE.options.selectedIndex == 1) 
	{	//l2tp
		document.getElementById('vpns_pptp').style.display = "none";	
		document.getElementById('vpns_l2tp').style.display = "";
	}
}

function ChangeVPNClient()
{
	if (document.VPN_FORM.VPNC_MODE.options.selectedIndex == 0) 
	{	//pptp
		document.getElementById('vpnc_pptp').style.display = "";	
		document.getElementById('vpnc_l2tp').style.display = "none";
	}
	else if (document.VPN_FORM.VPNC_MODE.options.selectedIndex == 1) 
	{	//l2tp
		document.getElementById('vpnc_pptp').style.display = "none";	
		document.getElementById('vpnc_l2tp').style.display = "";
	}
}

function getPINPUKCfg()
{
  var PinCfg = <%getPinConfig();%>;
  var pinArr = PinCfg.split("#");
  if (pinArr[0] == "1") {          //PIN not verified
      //document.getElementById("srclte").setAttribute("src", "../images/menu/top_menu_internet_disabled.png");
      document.getElementById("hreflte").removeAttribute("href");
  }else{
      //document.getElementById("srclte").setAttribute("src", "../images/menu/top_menu_internet.png");
      document.getElementById("hreflte").href="../internet/internet_radio.asp";
  }
  return;
}
</script>
</head>

<body onload="loadVPNPage()">
<div id="all">
<!-- Main Menu start -->
<div id="home_top">
  <ul>
    <li class="home-1"><a href="#"></a></li>
    <li class="home-2" id="home_menu"><a href="../home.asp"></a></li>
    <li class="home-3" id="lte_menu"><a id="hreflte" href="../internet/internet_radio.asp"></a></li>
    <li class="home-4" id="wifi_menu"><a href="../wifi/wifi_settings.asp"></a></li>
    <li class="home-5" id="lan_menu"><a href="../lan/lan_settings.asp"></a></li>
    <li class="home-6hover" id="adv_menu"><a href="../advanced/firewall.asp"></a></li>
    <li class="home-7" id="sys_menu"><a href="../system/system_time.asp"></a></li>
    <li class="home-9" id="voip_menu"><a href="../voip/voip_linesettings.asp"></a></li>
	<li class="home-801"></li>
	<li class="home-802" style="float:right;">      
	  <ul class="bluemenu">
        <!--<li><a href="#">Help</a></li>-->
        <li>
          <form method="post" name="top_logout_form" action="/goform/user_logout">
            <input type="hidden" name="top_logout_dummy" value="0"> 	
            <a href="#" id="top_logout" onclick="logout();">Logout</a>           
          </form>
        </li>
        <li><a href="#" onclick="doRedirect();">Refresh</a></li>
      </ul>
    </li>
  </ul>
</div>
<!-- Main Menu end -->

<script type="text/javascript">getPINPUKCfg();</script>

<!-----Left: submenu start---->
<div id="left_bg">
  <ul>
   <li class="leftbu"><a href="firewall.asp">Firewall</a></li>
   <li class="leftbu"><a href="advanced_ddns.asp">DDNS</a></li>
   <li class="leftbu"><a href="nat_general.asp">NAT</a></li>
   <li class="leftbu"><a href="advanced_staticroute.asp">Static Routing</a></li>
   <!--
   <li class="leftbu"><a href="ipv6.asp">IPv6</a></li>
   -->
   <li class="leftbuhover"><a href="vpn.asp"></a>Virtual Private Network</li>  
   <!--
   <li class="leftbu"><a href="sms_newsms.asp">Short Message</a></li>       
   -->
   <li class="leftbu"><a href="dlna.asp">DLNA</a></li>   
   <li class="leftbu"><a href="usb_storage.asp">USB Storage</a></li>       
   <li class="leftbu"><a href="QoSPolicy.asp">QoS</a></li>
  </ul>
</div>
<!-----Left: submenu end-->

<!-- Right Content start -->
<div id="content_all">
  <div id="content_bg01"><script>document.write( gettext("Virtual Private Network") );</script></div>
  <div id="content_bg02">  
  <hr noshade="noshade" color="#9E9E9E" size="1" width="660" align="left" style="margin-left:0;">
  
  <!-- vpn passthrough -->
  <div style="display:none">
  <form name="VPN" action="/goform/setVPNPassthrough" method="post">  
  <div style="margin:10px 0 0;">
    <label class="string_style" ><h1><script>document.write( gettext("VPN Passthrough") );</script></h1></label>
  </div>
  <table class="frame_space" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">	
      <tr><td width="92"><img src="../images/circle_page.gif" width="8" height="8" /style="padding:0 5px 0 15px;"><span class="string_style" ><script>document.write(gettext("PPTP:") );</script></span></td>
      <td width="215">
          <input type="radio" id="pptp_pt_on" name="VPNP_PPTP" ~cVPNP_PPTP:on~ value="on"/> <script>document.write(gettext("Enable") );</script></input>
          <input type="radio" id="pptp_pt_off" name="VPNP_PPTP" ~cVPNP_PPTP:off~ value="off"/> <script>document.write(gettext("Disable") );</script></input>
      </td></tr>
      <tr><td width="92"><label class="string_style" ><img src="../images/circle_page.gif" width="8" height="8" style="padding:0 5px 0 15px;" /><script>document.write(gettext("L2TP:") );</script></label></td>
      <td>
          <input type="radio" id="l2tp_pt_on" name="VPNP_L2TP" ~cVPNP_L2TP:on~ value="on"/> <script>document.write(gettext("Enable") );</script></input>
          <input type="radio" id="l2tp_pt_off" name="VPNP_L2TP" ~cVPNP_L2TP:off~ value="off"/> <script>document.write(gettext("Disable") );</script></input>
      </td></tr>
      <tr><td width="92"><label class="string_style" ><img src="../images/circle_page.gif" width="8" height="8" style="padding:0 5px 0 15px; /"><script>document.write(gettext("IPSec:") );</script></label></td>
      <td>
          <input type="radio" id="ipsec_pt_on" name="VPNP_IPSEC" ~cVPNP_IPSEC:on~ value="on"/> <script>document.write(gettext("Enable") );</script></input>
          <input type="radio" id="ipsec_pt_off" name="VPNP_IPSEC" ~cVPNP_IPSEC:off~ value="off"/> <script>document.write(gettext("Disable") );</script></input>
      </td></tr>    
  </table>
  <table class="frame_space" border="0" cellpadding="0" cellspacing="0" style="margin:0 0 0 0px; ">
  <tr><td>  
  <div class="Button_all" style="float:left; margin-left:0px;">
    <a class="Button" href="#" type="submit" id="btnApply" onclick="return submit_vpn_passthrough();"><span><script>document.write(gettext("Apply") );</script></span></a>
    <a class="Button" href="#" type="reset" onclick="doRedirect();"><span><script>document.write(gettext("Discard") );</script></span></a>
  </div>
  </td></tr>
  </table>
  </form>  
  <hr noshade="noshade" color="#9E9E9E" size="1" width="660" align="left" style="margin-left:0;"> 
  </div>
  
  <!-- vpn mode -->
  <form name="VPN_FORM" action="/goform/setVPN" method="post">
  <div style="margin:10px 0 0;">
    <label class="string_style" ><h1 style="float:left; padding-right:8px;"><script>document.write( gettext("VPN Mode") );</script></h1> </label>
	<select class="fill" name="VPN_MODE" id="vpn_mode" onclick="ChangeVPN();">
		<option value="disable" id="disable"><script>document.write( gettext("Disable") );</script></option>
		<option value="vpns" id="vpns"><script>document.write( gettext("Server") );</script></option>
		<option value="vpnc" id="vpnc"><script>document.write( gettext("Client") );</script></option>
	</select>        
  </div>  
  <!-- vpn server -->
  <div id="VPN_SERVER" style="display:none;">
  <table class="frame_space" width="650" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  <tr>
    <td width="187"><img src="../images/circle_page.gif" width="8" height="8" /style="padding:0 5px 0 15px;"><script>document.write( gettext("Connection Mode") );</script></td>
    <td width="461">
		<select class="fill" name="VPNS_MODE" id="vpns_mode" onclick="ChangeVPNServer();">
			<option value="pptp" id="pptp"><script>document.write( gettext("PPTP") );</script></option>
			<option value="l2tp" id="l2tp"><script>document.write( gettext("L2TP") );</script></option>
		</select>    
	</td>
  </tr>
  </table>  

  <div id="vpns_pptp" style="display:none;">
  <input type="hidden" id="VPNS_PPTP_REMOTE_IP_RANGE" name="VPNS_PPTP_REMOTE_IP_RANGE" value="">
  <input type="hidden" id="VPNS_PPTP_USERNAME" name="VPNS_PPTP_USERNAME" value="">
  <input type="hidden" id="VPNS_PPTP_PW" name="VPNS_PPTP_PW" value="">
  <table class="frame_space" width="650" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  	<tr>
  		<td valign="top" style="padding-left:50px;">  		
    		<label class="string_style" ><script>document.write(gettext("Remote IP Range"));</script> </label>
  		</td>
  		<td width="461" class="string_style">
			<input type="text" class="fill" name="VPNS_PPTP_REMOTE_IP_START" id="VPNS_PPTP_REMOTE_IP_START" value="" size="2" maxlength="3"></input>
			<span class="string_style">~</span>
			<input type="text" class="fill" name="VPNS_PPTP_REMOTE_IP_END" id="VPNS_PPTP_REMOTE_IP_END" value="" size="2" maxlength="3"></input>			
			(240~254)
  		</td>  	
  	</tr>
    <tr>
        <td valign="top" style="padding-left:50px;">
        	<label class="string_style" ><script>document.write(gettext("User Account List"));</script> </label>
        </td>  		
    </tr>   	    	
  </table>
 
  <table class="frame_gray" width="280" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 60px;">
      <tr>
        <td width="40" style="padding:0;"></td>
        <td width="120" align="left"><script>document.write(gettext("Username"));</script></td>
        <td width="120" align="left"><script>document.write(gettext("Password"));</script></td>
      </tr>
      <tbody id="vpns_pptp_user_account_table">
      </tbody>
  </table> 
  <table class="frame_space" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 60px;">
      <tr><td>
        <div class="Button_all" style="float:right; margin-right:140px;">
          <a class="Button" href="#" type="button" id="" onclick="vpns_pptp_account('add');"><span><script>document.write(gettext("Add"));</script></span></a>
          <a class="Button" href="#" type="button" id="" onclick="vpns_pptp_account('edit');"><span><script>document.write(gettext("Edit"));</script></span></a>
          <a class="Button" href="#" type="button" id="" onclick="vpns_pptp_account('delete');"><span><script>document.write(gettext("Delete"));</script></span></a>          
        </div>
      </tr></td>
  </table>   

  <div id="vpns_account_editor" name="vpns_account_editor" style="display:none;" >
  <table class="frame_space" width="650" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  	<tr>
  		<td valign="top" style="padding-left:50px;">
  			<label class="string_style" ><script>document.write(gettext("Username"));</script> </label>
  		</td width="461">
		<td><input id="vpns_pptp_username" name="vpns_pptp_username" class="box" type="text" value="" maxlength="24" size="20" onkeypress="return keypress_ascii(event)"></input></td>
	</tr>
  	<tr>
  		<td valign="top" style="padding-left:50px;">
  			<label class="string_style" ><script>document.write(gettext("Password"));</script> </label>
  		</td>
		<td width="461"><input id="vpns_pptp_pwd" name="vpns_pptp_pwd" class="box" type="text" value="" maxlength="24" size="20"></input></td>
	</tr>	
  </table>
  <table class="frame_space" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 60px;">
      <tr><td>
        <div class="Button_all" style="float:right; margin-right:140px;">
          <a class="Button" href="#" type="button" id="" onclick="vpns_pptp_account_validate('apply');"><span><script>document.write(gettext("Apply"));</script></span></a>
          <a class="Button" href="#" type="button" id="" onclick="vpns_pptp_account_validate('discard');"><span><script>document.write(gettext("Discard"));</script></span></a>
        </div>
      </tr></td>
  </table>   
  </div>
  
  </div>

  <div id="vpns_l2tp" style="display:none;">
  
  <input type="hidden" id="VPNS_L2TP_REMOTE_IP_RANGE" name="VPNS_L2TP_REMOTE_IP_RANGE" value="">
  <input type="hidden" id="VPNS_L2TP_USERNAME" name="VPNS_L2TP_USERNAME" value="">
  <input type="hidden" id="VPNS_L2TP_PW" name="VPNS_L2TP_PW" value="">
  <table class="frame_space" width="650" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  	<tr>
  		<td valign="top" style="padding-left:50px;">
  			<label class="string_style" ><script>document.write(gettext("Remote IP Range"));</script> </label>
  		</td>
  		<td width="461" class="string_style">
			<input type="text" class="fill" name="VPNS_L2TP_REMOTE_IP_START" id="VPNS_L2TP_REMOTE_IP_START" value="" size="2" maxlength="3"></input>
			<span class="text_gray">~</span>
			<input type="text" class="fill" name="VPNS_L2TP_REMOTE_IP_END" id="VPNS_L2TP_REMOTE_IP_END" value="" size="2" maxlength="3"></input>						
	  		(240~254)
  		</td>
  	</tr>
  	<tr>
  		<td valign="top" style="padding-left:50px;">
  			<label class="string_style"><script>document.write(gettext("L2TP Mode"));</script></label>
  		</td>  		
  		<td width="461">
			<select class="fill" name="VPNS_L2TP_MODE" id="VPNS_L2TP_MODE" onclick="">
				<option value="l2tp" id="vpns_l2tp"><script>document.write(gettext("Pure L2TP"));</script> </option>
				<!--				
				<option value="ipsec" id="vpns_ipsec"><script>document.write(gettext("Over IPSEC"));</script></option>
				-->
			</select> 
  		</td> 		
  	</tr>     	
    <tr>
        <td valign="top" style="padding-left:50px;">
        	<label class="string_style" ><script>document.write(gettext("User Account List"));</script> </label>
        </td>  		
    </tr>   	    	
  </table>

  <table class="frame_gray" width="280" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 60px;">
      <tr>
        <td width="40" style="padding:0;"></td>
        <td width="120" align="left"><script>document.write(gettext("Username"));</script></td>
        <td width="120" align="left"><script>document.write(gettext("Password"));</script></td>
      </tr>
      <tbody id="vpns_l2tp_user_account_table">
      </tbody>
  </table> 
  <table class="frame_space" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 60px;">
      <tr><td>
        <div class="Button_all" style="float:right; margin-right:140px;">
          <a class="Button" href="#" type="button" id="" onclick="vpns_l2tp_account('add');"><span><script>document.write(gettext("Add"));</script></span></a>
          <a class="Button" href="#" type="button" id="" onclick="vpns_l2tp_account('edit');"><span><script>document.write(gettext("Edit"));</script></span></a>
          <a class="Button" href="#" type="button" id="" onclick="vpns_l2tp_account('delete');"><span><script>document.write(gettext("Delete"));</script></span></a>          
        </div>
      </tr></td>
  </table>   

  <div id="vpns_l2tp_account_editor" name="vpns_l2tp_account_editor" style="display:none;" >
  <table class="frame_space" width="650" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  	<tr>
  		<td valign="top" style="padding-left:50px;">
  			<label class="string_style" ><script>document.write(gettext("Username"));</script> </label>
  		</td>
		<td width="461"><input id="vpns_l2tp_username" name="vpns_l2tp_username" class="fill" type="text" value="" maxlength="24" size="20" onkeypress="return keypress_ascii(event)"></input></td>
	</tr>
  	<tr>
  		<td valign="top" style="padding-left:50px;">
  			<label class="string_style" ><script>document.write(gettext("Password"));</script> </label>
  		</td>
		<td width="461"><input id="vpns_l2tp_pwd" name="vpns_l2tp_pwd" class="fill" type="text" value="" maxlength="24" size="20"></input></td>
	</tr>	
  </table>
  <table class="frame_space" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 60px;">
      <tr><td>
        <div class="Button_all" style="float:right; margin-right:140px;">
          <a class="Button" href="#" type="button" id="" onclick="vpns_l2tp_account_validate('apply');"><span><script>document.write(gettext("Apply"));</script></span></a>
          <a class="Button" href="#" type="button" id="" onclick="vpns_l2tp_account_validate('discard');"><span><script>document.write(gettext("Discard"));</script></span></a>
        </div>
      </tr></td>
  </table>     
  </div>  

  </div>
  
  </div>

  <!-- vpn client -->
  <div id="VPN_CLIENT" style="display:none;">
  <table class="frame_space" width="650" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  <tr>
    <td width="187"><img src="../images/circle_page.gif" width="8" height="8" /style="padding:0 5px 0 15px;"><script>document.write(gettext("Connection Mode"));</script></td>
    <td width="461">
		<select class="fill" name="VPNC_MODE" id="vpnc_mode" onclick="ChangeVPNClient();">
			<option value="pptp" id="pptp"><script>document.write(gettext("PPTP"));</script></option>
			<option value="l2tp" id="l2tp"><script>document.write(gettext("L2TP"));</script></option>
		</select>
	</td>
  </tr>
  </table>

  <div id="vpnc_pptp" style="display:none;">
  <table class="frame_space" width="650" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  	<tr>
  		<td valign="top" style="padding-left:50px;"><label class="string_style" ><script>document.write(gettext("Username"));</script> </label></td>
  		<td width="461"><input type="text" class="fill" name="VPNC_PPTP_USERNAME" id="VPNC_PPTP_USERNAME" value="" size="22" maxlength="24" onkeypress="return keypress_ascii(event)"></input></td>
  	</tr>
  	<tr>
  		<td valign="top" style="padding-left:50px;"><label class="string_style" ><script>document.write(gettext("Password"));</script> </label></td>
  		<td width="461"><input type="password" class="fill" name="VPNC_PPTP_PW" id="VPNC_PPTP_PW" value="" size="22" maxlength="24"></input></td>
  	</tr>
  	<tr>
  		<td valign="top" style="padding-left:50px;"><label class="string_style" ><script>document.write(gettext("Server IP Address"));</script> </label></td>  		
  		<td width="461"><input type="text" class="fill" name="VPNC_PPTP_SERVER" id="VPNC_PPTP_SERVER" value="" size="22" maxlength="15" onkeypress="return keypress_ip_format(event)"></input>
  		<span id="example_IP"><script>document.write(gettext("(XXX.XXX.XXX.XXX, eg: 192.168.20.11)"));</script></SPAN></td>
  	</tr>       
  </table>
  </div>

  <div id="vpnc_l2tp" style="display:none;">
  <table class="frame_space" width="650" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  	<tr>
  		<td valign="top" style="padding-left:50px;"><label class="string_style" ><script>document.write(gettext("Username"));</script> </label></td>
  		<td width="461"><input type="text" class="fill" name="VPNC_L2TP_USERNAME" id="VPNC_L2TP_USERNAME" value="" size="22" maxlength="24" onkeypress="return keypress_ascii(event)"></input></td>
  	</tr>
  	<tr>
  		<td valign="top" style="padding-left:50px;"><label class="string_style" ><script>document.write(gettext("Password"));</script> </label></td>
  		<td width="461"><input type="password" class="fill" name="VPNC_L2TP_PW" id="VPNC_L2TP_PW" value="" size="22" maxlength="24"></input></td>
  	</tr>
  	<tr>
  		<td valign="top" style="padding-left:50px;"><label class="string_style" ><script>document.write(gettext("Server IP Address"));</script> </label></td>  		
  		<td width="461"><input type="text" class="fill" name="VPNC_L2TP_SERVER" id="VPNC_L2TP_SERVER" value="" size="22" maxlength="15" onkeypress="return keypress_ip_format(event)"></input>
  		<span id="example_IP"><script>document.write(gettext("(XXX.XXX.XXX.XXX, eg: 192.168.20.11)"));</script></SPAN></td>
  	</tr>   
  	<tr>
  		<td valign="top" style="padding-left:50px;"><label class="string_style" ><script>document.write(gettext("L2TP Mode"));</script> </label></td>  		
  		<td width="461">
			<select class="fill" name="VPNC_L2TP_MODE" id="VPNC_L2TP_MODE">
				<option value="l2tp" id="l2tp"><script>document.write(gettext("Pure L2TP"));</script></option>
				<!--
				<option value="ipsec" id="ipsec"><script>document.write(gettext("Over IPSEC"));</script></option>
				-->
			</select> 
  		</td> 		
  	</tr>   
  	
  </table>
  </div>

  <!--
  <table border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 15px;">
  	<tr>
  		<td><label class="text_gray" ><script>document.write(gettext("Connection Status"));</script> </label></td>
  		<td></td>
  	</tr>
  	<tr>
  		<td><label class="text_gray" ><script>document.write(gettext("IP"));</script> </label></td>
  		<td></td>
  	</tr>
  </table>
  -->
  
  </div>

  
  <div class="Button_all" style="float:left; margin-left:0px;">
    <a class="Button" href="#" type="submit" id="btnApply" onclick="return submit_vpn_setting();"><span><script>document.write(gettext("Apply"));</script></span></a>
    <a class="Button" href="vpn.asp" type="reset"><span><script>document.write(gettext("Discard"));</script></span></a>
  </div>    
  </form>  

  
  </div>
</div>
</div>
</body>
</html>
