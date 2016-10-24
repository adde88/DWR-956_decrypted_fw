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
var user_status = <%getUserStatus();%>;
if(user_status == "1")
{
	alert(gettext("The Username already exist."));
}
function NewUserAction(state)
{
	if(!CheckLoginInfo())
		return false;
	document.getElementById('account_rowid').value="";
	var editor_action = document.getElementById('account_action');

	if (state=="add")
	{
		editor_action.value = "add";			
	}
	else if (state=="edit")
	{

		var index_flag = editAllow('tblusers');
		if(index_flag == false)
		{
			return false;
		}
		else		
		{
			editor_action.value = "edit";
			var account_check = document.getElementsByName('account_ck');
			var index="";
			if(account_check.length>0)
			{
				for(var i=0;i<account_check.length;i++)
				{
					if(account_check[i].checked)
					{
						index=i;
						break;
					}
				}
			}
			document.getElementById('account_rowid').value=(index+1);
		}
	}
	else if (state=="delete")
	{
		if(deleteAllow1 ('tblusers'))
		{
			editor_action.value = "delete";
			var account_check = document.getElementsByName('account_ck');
			var index="";
			if(account_check.length>0)
			{
				for(var i=0;i<account_check.length;i++)
				{
					if(account_check[i].checked)
					{
						if(i<=1)
						{
							alert(gettext("Default user(s) can't be deleted."));
							return false;
						}
						index=index+(i+1)+"#";
					}
				}
			}
			document.getElementById('account_rowid').value=index;
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

<body onload="secChkBoxSelectOrUnselectAll ('tblusers', 'umiId', null)">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("sys");%>
<script type="text/javascript">menuChange("sys_menu");leftMenuChange("system_user", "system_user_href");</script>
<!-- Main Menu and Submenu End -->


<div class="contentBg" id="main_user">
	<div class="secH1"><script>document.write(gettext("Users"));</script></div>
	<!-- Section Begin -->
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
			<br><script>document.write(gettext("This page displays the  list of available users that can access this gateways management UI. A configured user can add, delete and edit other users."));</script>
			<br></div>
		<div class="secH2"><script>document.write(gettext("Web pages management UI Users"));</script></div>
		<form name="user_account_del" method="post" action="/goform/setUserAccountAction">
		<input type="hidden" id="account_rowid" name="account_rowid" value="0">
		<input type="hidden" id="account_action" name="account_action" value="0">
		<table cellpadding="0" cellspacing="0" id="tblusers" width="550px" style="table-layout: fixed;" class="specTbl">
			<tr>
				<td class="tdH" width="10%">
				<input type="checkbox" id="imgSelectAll" title="Select All" onclick="secChkBoxSelectOrUnselectAll ('tblusers', 'umiId', this)"></td>
				<td class="tdH" width="20%"><script>document.write(gettext("Name"));</script></td>
				<td class="tdH" width="30%"><script>document.write(gettext("Group Membership"));</script></td>
				<td class="tdH" width="40%"><script>document.write(gettext("Description"));</script></td>
			</tr>
			<tbody>
	  			<%getUserAccountList();%>
    		</tbody>
		</table>
		<div>
			<input type="submit" id="add_user" value="Add" class="tblbtn" title="Add" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return NewUserAction('add');">
			<input type="submit" id="edit_user" value="Edit" class="tblbtn" title="Edit" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return NewUserAction('edit');">
			<input type="submit" id="delete_user" value="Delete" class="tblbtn" title="Delete" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return NewUserAction('delete');">
		</div>
		</form>
	</div>
	<!-- Section End -->
</div>

</div>
 <script type="text/javascript">
	document.getElementById('add_user').value=gettext("Add");
	document.getElementById('edit_user').value=gettext("Edit");
	document.getElementById('delete_user').value=gettext("Delete");
 </script>
</body>
</html>
