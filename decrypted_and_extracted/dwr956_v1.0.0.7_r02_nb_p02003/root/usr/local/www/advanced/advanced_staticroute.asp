<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

var nat_enable=<%getFwNatEnable();%>;
if(nat_enable!="1")
{
	window.location.href="../login.asp";
}
var starout_list_idx = -1;
function AddEdit(state)
{
	if(!CheckLoginInfo())
		return false;
	var starout_list_arr="";
	starout_list_idx=-1;
	document.getElementById('StaRouteIdx').value="";
	var editor_action = document.getElementById('StaRouteAction');
	var editor_count = document.getElementById('StaRouteCount');
	var secObj = document.getElementById('tblStaRouteList');
	var objArr = secObj.getElementsByTagName("INPUT");
	var count=0;

	for (var i=0; i < objArr.length; i++)
	{
		if (objArr[i].type == 'checkbox' && !objArr[i].disabled && objArr[i].name!="imgSelectAllChk")
		{
			if (objArr[i].checked==true)
			{
				count++;
				starout_list_idx=i; //host_list_idx starts from 1	
				starout_list_arr+=starout_list_idx+",";
			}
		}
	}
	editor_count.value=count;
	var ret=true;
    if (state == "add") {
    	editor_action.value = "StaticRouteAdd";
    }else if ((state == "edit")) {
		if (count > 1){
			alert("Please select one row to edit.");
			ret=false;
		} else if (count==0){
			alert("Please select a row from the list to be edited.");
			ret=false;
		} else {
			editor_action.value = "StaticRouteEdit";			
			document.getElementById('StaRouteIdx').value=starout_list_idx;
		}
    }else if (state=="delete") {
	  if (count==0)	{
        alert("Please select items from the list to be deleted.");
		ret=false;
	  }	else {
		editor_action.value = "StaticRouteDel";		
	    starout_list_arr=starout_list_arr.substr(0,starout_list_arr.length-1);
	    document.getElementById('StaRouteIdx').value=starout_list_arr;
	  }	
	}
	return ret;
}

function secChkBoxSelectOrUnselectAll(sectionId, chkObj)
{
	if (!sectionId) return;
	secObj = document.getElementById(sectionId);
	if (!secObj) return;
	objArr = secObj.getElementsByTagName("INPUT");
	if (!objArr) return;
	if (chkObj)
	{
		for (i=0; i < objArr.length; i++)
		{
			if (objArr[i].type == 'checkbox' && !objArr[i].disabled)
			{
				if (chkObj.id == "imgSelectAll")
					objArr[i].checked = true;
				else if (chkObj.id == "imgUnCheckAll")
					objArr[i].checked = false;
			}
		}
		/* Change icon */		
		if (chkObj.id == "imgSelectAll")
		{
			chkObj.id = "imgUnCheckAll";
			chkObj.title = "Deselect All";
		}
		else if (chkObj.id == "imgUnCheckAll")
		{
			chkObj.id = "imgSelectAll"
			chkObj.title = "Select All"
		}		
	}
	else
	{
		for (i=0; i < objArr.length; i++)
		{
			if (objArr[i].type == 'checkbox' && !objArr[i].disabled)
			{
				objArr[i].checked = false;
			}
		}	
	}		
	return; 
}

function pageLoad()
{
	secChkBoxSelectOrUnselectAll ('tblStaRouteList',null);
}
</script>
</head>

<body onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("advanced_staticroute", "advanced_staticroute_href");</script>
<!-- Main Menu and Submenu End -->

<!-- Right Content start -->
<div class="contentBg">
  <div class="secH1"><script>document.write(gettext("Static Routing"));</script></div>
  <div class="statusMsg"></div>					
  <div class="secBg">
  <div class="secInfo"><br><script>document.write(gettext("This page displays the list of static routes defined on this gateway that manage traffic from the local network."));</script><br></div>
  <!--Route table-->
  <form name="StaRouteForm" method="post" action="/goform/setStaRouteTable">
  <input type="hidden" id="StaRouteAction" name="StaRouteAction" value="">
  <input type="hidden" id="StaRouteIdx" name="StaRouteIdx" value="">
  <input type="hidden" id="StaRouteCount" name="StaRouteCount" value="">
  <table cellspacing="0" id="tblStaRouteList" class="specTbl">
    <tr>
      <td class="tdH"><input type="checkbox" name="imgSelectAllChk" id="imgSelectAll" title="Select All" onclick="secChkBoxSelectOrUnselectAll ('tblStaRouteList', this)"></td>
      <td class="tdH"><script>document.write(gettext("Name"));</script></td>
	  <td class="tdH"><script>document.write(gettext("Destination Network"));</script></td>
      <td class="tdH"><script>document.write(gettext("IP Subnet Mask"));</script></td>
	  <td class="tdH"><script>document.write(gettext("Network"));</script></td>
	  <td class="tdH"><script>document.write(gettext("Gateway"));</script></td>
    </tr>
    <tbody>
      <%getStaRout();%>
    </tbody> 
    <input type="hidden" id="starout_rowid_del" name="starout_rowid_del" value="0"/>
  </table>
  <!-- Button start -->
  <div>
    <input type="submit" id="sta_add" class="tblbtn" value="Add" title="Add" name="StaticRouteAdd" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return AddEdit('add');">
	<input type="submit" id="sta_edit" class="tblbtn" value="Edit"  title="Edit" name="StaticRouteEdit" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return AddEdit('edit');">
	<input type="submit" id="sta_del" class="tblbtn" value="Delete" title="Delete" name="StaticRouteDel" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return AddEdit('delete');">
  </div>
  <!-- Button end -->
  </form>
  </div>
</div>
</div>
<script type="text/javascript">
  document.getElementById('sta_add').value=gettext("Add");
  document.getElementById('sta_edit').value=gettext("Edit");
  document.getElementById('sta_del').value=gettext("Delete");
</script>
</body>
</html>
