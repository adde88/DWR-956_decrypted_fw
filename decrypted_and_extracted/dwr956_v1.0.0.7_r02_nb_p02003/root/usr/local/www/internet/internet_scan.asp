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


function getNetworkSelMode()
{
    var SelMode = <%getNetworkSelMode();%>;

    if (SelMode == "auto")
    {
    	document.getElementById("networkModeAuto").checked=true;
    } else if (SelMode == "manual") {
    	document.getElementById("networkModeManual").checked=true;
    }

    changeRegType(SelMode);

    return;
}

/*Network Provider*/
function changeRegType(field)
{
    switch(field)
    {
      case "auto":
       document.getElementById('selModeAuto').style.display = "block";
       document.getElementById('providerScan').style.display = "none";
       document.getElementById('show_isp_list').style.display = "none";
       document.getElementById('show_isp_list_frame').style.display = "none";
       break;
      case "manual":
       document.getElementById('selModeAuto').style.display = "none";
       document.getElementById('providerScan').style.display = "block";
       document.getElementById('show_isp_list').style.display = "block";
       document.getElementById('show_isp_list_frame').style.display = "block";
       break;
    }
    return;
}

function onClickScan()
{
	if(!CheckLoginInfo())
		return false;
   	 var msg = "Suggest to disconnect internet first, otherwise the scanning may be incorrect.";
   	 if(confirm(msg)) {
      if (/msie/i.test(navigator.userAgent)){ //ie
        document.getElementById("providerScanClick").click();
      } else {
        var elem = document.createEvent('MouseEvent');
        elem.initEvent('click', false, false);
        setTimeout(document.getElementById("providerScanClick").dispatchEvent(elem),100);
      }
   	  //document.getElementById('providerScan').style.display = "none";
   	 }
     return;
}

function checkApply()
{
	if(!CheckLoginInfo())
		return false;
	return true;
}
</script>
</head>

<body onload="getNetworkSelMode();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("lte");%>
<script type="text/javascript">menuChange("lte_menu");leftMenuChange("internet_scan", "internet_scan_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Network Scan"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br /><script>document.write(gettext("This page will scan for nearby network providers."));</script>
		<br />
		<script>document.write(gettext("Please wait for a while for each scan."));</script>
		</div>
		<form name="NETWORK_SCAN" action="/goform/setNetworkSelMode" method="post">
		<table cellspacing="0" class="configTbl">
			<tr>
    	<td width="234"><script>document.write(gettext("4G Network Selection Method"));</script></td>
    	<td width="74"><input type="radio" name="providerRegMethod" id="networkModeAuto" value="auto" checked onclick="changeRegType('auto');"/><script>document.write(gettext("Auto"));</script></td>
    	<td width="392"><input type="radio" name="providerRegMethod" id="networkModeManual" value="manual" onclick="changeRegType('manual');" /><script>document.write(gettext("Manual"));</script></td>
			</tr>
		</table>
		<div>
			<input type="submit" value="Apply" class="submit" onclick="return checkApply();" name="applySelType" id="selModeAuto" style="display:block" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
			<input type="button" value="Scan Networks" class="submit" name="applySelType" id="providerScan" style="display:none" onclick="onClickScan();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" />
		</div>
		</form>

		<table cellspacing="0" class="configTbl" id="show_isp_list" style="margin:30px 0 20px; display:none;">
  	  <tr><td><a href="internet_isplist.asp" target="show_isp_list_frame" id="providerScanClick" style="display:none"></a></td></tr>
  	  <tr><td><iframe src="../transparent.htm" name="show_isp_list_frame" id="show_isp_list_frame" height="400" width="550" frameborder="0" scrolling="no" allowTransparency="true" style="display:none;"></iframe></td></tr>
		</table>

	</div>
</div>
</div>

<script type="text/javascript">
 document.getElementById('selModeAuto').value = gettext("Apply");
 document.getElementById('providerScan').value = gettext("Scan Networks");
</script>

</body>
</html>
