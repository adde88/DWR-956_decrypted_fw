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

function pageValidate()
{
	var ret_msg="";
	var username=get_by_id('username').value;
	var password=get_by_id('password').value;

	if (username=="" || password=="")
	{
		ret_msg=gettext("Username and Password cannot be empty.");
	}
	else if (!check_ascii(get_by_id('username')))
	{
	   ret_msg=gettext("Invalid Username! Please confirm again.");
	}	
	if (ret_msg!="")
	{
		get_by_id("statusMsg").innerHTML=ret_msg;	
		return false;
	}
	return true;	
}

function pageLoad()
{
	var UserAccount = <%getVpnUser();%>;
	var UserAccountArr;
	if (UserAccount!="")
	{
		UserAccountArr = UserAccount.split("#");

		if (UserAccountArr.length >=3)
		{
			get_by_id("username").value=UserAccountArr[1];
			get_by_id("password").value=UserAccountArr[2];
		}
		else
		{
			
		}

		if (get_by_id("backPage"))
		{
			if (UserAccountArr[0]=="VpnPPTPUserAccount") 
			{
				get_by_id("backPage").href="vpn_pptp.asp";	
				get_by_id("backPage").innerHTML=gettext(">> Back to PPTP page");
				leftSubMenuChange("vpn_submenu","vpn_submenu_focus","vpn_pptp","vpn_pptp_href");				
			}
			else if (UserAccountArr[0]=="VpnL2TPUserAccount") 
			{
				get_by_id("backPage").href="vpn_l2tp.asp";		
				get_by_id("backPage").innerHTML=gettext(">> Back to L2TP page");
				leftSubMenuChange("vpn_submenu","vpn_submenu_focus","vpn_l2tp","vpn_l2tp_href");				
			}
		}
	
	}
	else
	{
		get_by_id("username").value="";
		get_by_id("password").value="";		
	}	
	

}
</script>
</head>	

<body onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");</script>
<!-- Main Menu and Submenu End -->


<div class="contentBg">
	<div class="secH1">VPN User Account</div>

	<!-- Section Begin -->
	<div class="secBg">
	<div class="statusMsg" id="statusMsg"><%getActionResult();%></div>        				
	<div class="secInfo">
		<br>In this section you can add/edit vpn user account.
		<br>
		<a id="backPage" class="secLable1" href=""></a>        			
	</div>
		<form name="" method="post" action="/goform/setVpnUser">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td>Username</td>
				<td>
				<input id="username" name="username" class="txtbox" type="text" value="" maxlength="24" size="30" onkeypress="return keypress_ascii(event)">			
				</td>
			</tr>
			<tr>
				<td>Password</td>
				<td>
				<input id="password" name="password" class="txtbox" type="text" value="" maxlength="24" size="30">											
				</td>
			</tr>
		</table>
		<div>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="blank1" height="30">&nbsp;</td>
				</tr>
			</table>
		</div>
		<div class="submitBg">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><input type="submit" value="Apply" class="submit" title="Apply" onclick="return pageValidate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>
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

