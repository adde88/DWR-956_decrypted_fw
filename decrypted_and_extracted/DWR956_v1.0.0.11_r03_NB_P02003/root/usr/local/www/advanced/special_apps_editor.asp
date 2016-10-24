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

function special_apps_validate()
{
  var port_rule =/^[0-9]{1,6}$/;
  
  if(!CheckLoginInfo())
  	return false;
  var service_name_obj = document.getElementById('applist_service_name_temp');
  if (service_name_obj.disabled == false)
  {
  	var service_name = service_name_obj.value;
    if(service_name == "")
    {
      alert(gettext("Service Name can't be empty."));
      return false;
    }
    if (checkCommonNameField('applist_service_name_temp', gettext("Service Name")) == false) return false;
    document.getElementById('applist_service_name').value = service_name;
  }
  
  var port_start = document.getElementById("applist_port_start").value;
  var port_end = document.getElementById('applist_port_end').value;

  if(port_start == "")
  {
   alert(gettext("Start Port can't be empty."));
   return false;
  }

  if(port_end == "")
  {
    alert(gettext("End Port can't be empty."));
    return false;
  }

  if (!port_rule.test(port_start)) {
    alert(gettext("Start Port: Please enter a value between 1 ~ 65534."));
    document.getElementById("applist_port_start").focus();
    return false;
  }
 
  if (!port_rule.test(port_end)) {
    alert(gettext("End Port: Please enter a value between 1 ~ 65534."));
    document.getElementById("applist_port_end").focus();
    return false;
  }

  var num_port_start = parseInt(port_start, 10);
  var num_port_end = parseInt(port_end, 10);

  if ((num_port_start < 1) || (num_port_start > 65534) || isNaN(num_port_start))
  {
    alert(gettext("Start Port should be between 1 and 65534."));
    document.getElementById("applist_port_start").focus();
    return false;
  }
  
  if ((num_port_end < 1) || (num_port_end > 65534) || isNaN(num_port_end))
  {
    alert(gettext("End Port should be between 1 and 65534."));
    document.getElementById("applist_port_end").focus();
    return false;
  }
  
  if (num_port_start > num_port_end)
  {
    alert(gettext("Start Port should be less than or equal to the End Port."));
    return false;
  }

  return true;
}

function special_apps_editor_init()
{
	var AppsInfo = <%getSpecialAppsInfo();%>;
	var AppsInfoArr;
	if (AppsInfo!="")
	{
		AppsInfoArr = AppsInfo.split("#");
  document.getElementById('applist_service_name_temp').value = AppsInfoArr[0];
  document.getElementById('applist_service_name_temp').disabled = true;
  document.getElementById('applist_protocol').value = AppsInfoArr[1];
  document.getElementById('applist_port_start').value = AppsInfoArr[2];
  document.getElementById('applist_port_end').value = AppsInfoArr[3];

  document.getElementById('applist_service_name').value = AppsInfoArr[0];
  document.getElementById('applist_isDefault').value = AppsInfoArr[4];
	}
	else
	{
  document.getElementById('applist_service_name_temp').value = "";
  document.getElementById('applist_protocol').selectedIndex = 0;
  document.getElementById('applist_port_start').value = "";
  document.getElementById('applist_port_end').value = "";

  document.getElementById('applist_service_name').value = "";
  document.getElementById('applist_isDefault').value = "0";
	}
 return;
}
</script>
</head>

<body onload="special_apps_editor_init();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("nat_submenu","nat_submenu_focus","special_apps","special_apps_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Special Applications"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br /><script>document.write(gettext("Configuring a custom application requires you to define the type of traffic and ports to use. The protocol menu will let you choose between TCP and UDP traffic for this application. Then the starting and ending port range will complete the custom application configuration, making it available for selection to create security policies."));</script>
		<br />
		</div>
  <form name="special_apps_editor" method="post" action="/goform/setSpecialAppsConfig">
  <input type="hidden" name="applist_service_name" id="applist_service_name" value="">
  <input type="hidden" name="applist_isDefault" id="applist_isDefault" value="">
		<table cellspacing="0" class="configTbl">
			<tr>
				<td><script>document.write(gettext("Service Name"));</script></td>
				<td>
				<input type="text" class="configF1" name="applist_service_name_temp" id="applist_service_name_temp" value="" maxlength="32" size="20" />
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Protocol"));</script></td>
				<td><select name="applist_protocol" id="applist_protocol" class="configF1">
      <option value="6">TCP</option>
      <option value="17">UDP</option>
      </select>
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("Start Port"));</script></td>
				<td>
				<input type="text" class="configF1" name="applist_port_start" id="applist_port_start" value="" size="20" maxlength="5" onkeypress="return onkeypress_number_only(event);" /><span class="spanText">(1~65534)</span>
				</td>
			</tr>
			<tr>
				<td><script>document.write(gettext("End Port"));</script></td>
				<td>
				<input type="text" class="configF1" name="applist_port_end" id="applist_port_end" value="" size="20" maxlength="5" onkeypress="return onkeypress_number_only(event);" /><span class="spanText">(1~65534)</span>
				</td>
			</tr>
		</table>
		<div>
			<input type="submit" id="special_apply" value="Apply" class="submit" onclick="return special_apps_validate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
			<input type="button" id="special_reset" value="Reset" class="submit" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
		</div>
	 </form>
	</div>
</div>
</div>
<script type="text/javascript">
  document.getElementById('special_apply').value=gettext("Apply");
  document.getElementById('special_reset').value=gettext("Reset");
</script>
</body>
</html>
