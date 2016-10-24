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
CheckInitLoginInfo(<%getuser_login();%>);

var accountid = 0;
var temp_user_name = "";
var temp_group = "";
var temp_index="";
var temp_state;
function user_validate()
{
	if(!CheckLoginInfo())
		return false;
	var user_name = document.getElementById ("user_name_display").value;
	var user_pwd = document.getElementById ("user_pwd_display").value;
	var user_group = document.getElementById ("user_group_display").value;
	var user_description = document.getElementById ("user_description_display").value;
	var user_idletime = document.getElementById ("txtTimeOut").value;

	var user_rule =/^[a-zA-Z0-9]+$/;

	if(temp_state == "edit" && (temp_index==2 || temp_index == 1))
	{
		if(document.getElementById ("user_name_display").value != temp_user_name)
		{
			alert(gettext("Default username(s) can't be edited."));
			return false;
		}
		else if(document.getElementById ("user_group_display").value != temp_group)
		{
			alert(gettext("Default group(s) can't be edited."));
			return false;
		}
		
	}
	if(document.getElementById ("user_name_display").value == ""){
		alert(gettext("User name cannot be empty"));
		document.user_account_edit.user_name_display.focus();
		return false;
	}
	if(document.getElementById ("user_pwd_display").value == ""){
		alert(gettext("User password cannot be empty"));
		document.user_account_edit.user_pwd_display.focus();
		return false;
	}
	if(!user_rule.test(user_name)){
		alert(gettext("User Name: Accept 0-9,a-z,A-Z or not accept Chinese format."));
		document.getElementById("user_name_display").focus();
		return false;
	}
	if(!user_rule.test(user_pwd)){
		alert(gettext("Password: Accept 0-9,a-z,A-Z or not accept Chinese format."));
		document.getElementById("user_pwd_display").focus();
		return false;
	}
	var newPwd = document.getElementById('user_pwd_display');
	var confirmPwd = document.getElementById('txtLoginCpwd');

	if ((!newPwd.disabled && !confirmPwd.disabled) &&
	    (newPwd.value != confirmPwd.value))
	{
	    alert (gettext("Password mismatch. Please re-enter the password."));
	    return false;
	}
	var idleTime = parseInt(document.getElementById ("txtTimeOut").value);
	if (isNaN(idleTime) || idleTime < 1 || idleTime > 999) 
	{
		alert(gettext("Please enter the Idle Timeout Value between 1-999"));
	    return false;
	}
	
	if(user_description.length>100)
	{
		alert(gettext("The maximum length of Description is 100."));
		return false;
	}

	document.getElementById ("user_name").value = user_name;
	document.getElementById ("user_pwd").value = user_pwd;
	document.getElementById ("user_group").value = user_group;
	document.getElementById ("user_description").value = user_description;
	document.getElementById ("user_idletime").value = user_idletime;
	return true;
}
function PageLoad()
{
	var UserAccount = <%getUserAccount();%>;
	var UserAccountArr;
	if (UserAccount!="")
	{
		temp_state="edit";
		UserAccountArr = UserAccount.split("#");
		temp_index = UserAccountArr[0];
		document.getElementById ("user_name_display").value = UserAccountArr[1];
		temp_user_name = UserAccountArr[1];
		document.getElementById ("user_pwd_display").value = UserAccountArr[2];
		document.getElementById ("txtLoginCpwd").value = UserAccountArr[2];
		document.getElementById ("user_description_display").value = UserAccountArr[5];
		if(UserAccountArr[3] == "admin")
			document.getElementById ("user_group_display").value = "0";
		else
			document.getElementById ("user_group_display").value = "2";
		temp_group = document.getElementById ("user_group_display").value;
		document.getElementById ("txtTimeOut").value = UserAccountArr[4];
	}
	else
	{
		temp_state="add";
	}
}
</script>	
</head>

<body onload="secChkBoxSelectOrUnselectAll ('tblusers', 'umiId', null);PageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("sys");%>
<script type="text/javascript">menuChange("sys_menu");leftMenuChange("system_user", "system_user_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg" id="sub_user">
		<div class="secH1"><script>document.write(gettext("User Configuration"));</script></div>
		<!-- Section Begin -->
		<div class="secBg">
			<div class="statusMsg"></div>
			
			<div class="secInfo">
<br><script>document.write(gettext("This page is used to create a new user or edit an existing user. The user can be assigned a group membership as well."));</script>
<br></div>
		<form name="user_account_edit" method="post" action="/goform/setUserAccount">
	    <input type="hidden" id="user_name" name="user_name" value="0">
	    <input type="hidden" id="user_pwd" name="user_pwd" value="0">
	    <input type="hidden" id="user_group" name="user_group" value="0">
	    <input type="hidden" id="user_description" name="user_description" value="0">
	    <input type="hidden" id="user_idletime" name="user_idletime" value="0">
		<table border="0" cellspacing="0" cellpadding="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Username"));</script></td>
				<td>
				<input type="text" name="user_name_display" class="configF1" id="user_name_display" value="" size="20" maxlength="32" ></td>
	<!--			onkeypress="return (numericValueCheck (event, 'abcdefghijklmnopqrstuvwxyz_-'))" onkeydown="if (event.keyCode == 9) {return checkUserName ('txtUsername', 32, true, 'Invalid Username: ', false,'');}"-->
			</tr>
			<tr>
				<td><script>document.write(gettext("Password"));</script></td>
				<td>
				<input type="password" name="user_pwd_display" class="configF1" value="" id="user_pwd_display" size="20" maxlength="32" ></td>
<!--				onkeydown="if (event.keyCode == 9) {return fieldLengthCheck ('txtpwd', 5, 32, 'Password lenght should be in between 5 - 32 characters');}"-->
			</tr>
			<tr>
				<td><script>document.write(gettext("Confirm Password"));</script></td>
				<td>
				<input type="password" name="cfmPassword" class="configF1" value="" id="txtLoginCpwd" size="20" maxlength="32" ></td>
				<!--onkeydown="if (event.keyCode == 9) {return fieldLengthCheck ('txtCpwd', 5, 32, 'Confirm Password lenght should be in between 5 - 32 characters');}"-->
			</tr>
			<tr>
				<td><script>document.write(gettext("Description"));</script></td>
				<td><textarea rows="2" id="user_description_display" class="configF1" name="description"></textarea>
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Group Membership"));</script></td>
				<td><select name="groups" id="user_group_display" multiple size="4" class="configF1">
				 	
				 	<option SELECTED value="2"><script>document.write(gettext("guest"));</script></option>
				 	
				 	<option  value="0"><script>document.write(gettext("admin"));</script></option>
				 	
				 	</select>
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Idle Timeout"));</script></td>
				<td>
				 	<input type="text" name="loginTimeout" size="15" maxlength="3" class="configF1" value="" id="txtTimeOut" onkeypress="return onkeypress_number_only(event)">
				 	<!--onkeydown="if (event.keyCode == 9) { return numericValueRangeCheck (this, '', '', 1, 999, true, '', 'minutes'); }"-->
				 	<span class="spanText"><script>document.write(gettext("minutes"));</script></span>
				</td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" id="apply_user" value="Apply" class="submit" name="" title="Apply" onclick="return user_validate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" id="reset_user" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
		</form>
	</div>
	<!-- Section End -->
</div>

</div>
 <script type="text/javascript">
	document.getElementById('apply_user').value=gettext("Apply");
	document.getElementById('reset_user').value=gettext("Reset");
 </script>

</body>
</html>

