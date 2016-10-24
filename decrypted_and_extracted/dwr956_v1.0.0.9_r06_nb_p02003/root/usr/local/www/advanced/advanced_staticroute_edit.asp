<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script language="Javascript" src="../js/common.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);
var StaticRouteInfo=<%getStaticRouteInfo();%>;
var StaticRouteArr = StaticRouteInfo.split("#");
var StaticRouteName=<%getStaticRouteName();%>;
var StaticRouteNameArr = StaticRouteName.split("#");
var count = 0;

var NetworkInfo = <%getHomeInternetInfo2();%>;
var NwInfoArr = NetworkInfo.split("#");
var LanGatewayStartIP = <%getLANGatewayStartIP();%>;
var LanGatewayEndIP = <%getLANGatewayEndIP();%>;
var InternetGatewayStartIP = <%getInternetGatewayStartIP();%>;
var InternetGatewayEndIP = <%getInternetGatewayEndIP();%>;

function static_route_edit_init()
{
    if (StaticRouteInfo == ""){  //Add
    	document.getElementById('starout_name').value = "";
    	document.getElementById('starout_dest_net').value = "";
        document.getElementById('starout_dest_msk').value = "";
        document.getElementById('starout_network').selectedIndex = 0;
    	document.getElementById('starout_lcl_gw').value = "";
	}else{						//Edit
    	document.getElementById('starout_name').value = StaticRouteArr[0];
    	document.getElementById('starout_dest_net').value=StaticRouteArr[1];
        document.getElementById('starout_dest_msk').value=StaticRouteArr[2];
    	if(StaticRouteArr[3] == "Default")
          document.getElementById('starout_network').selectedIndex=0;
    	else if (StaticRouteArr[3] == "WAN1")
    	  document.getElementById('starout_network').selectedIndex=1;
    	document.getElementById('starout_lcl_gw').value=StaticRouteArr[4];
	}
}

function sta_rout_validate()
{
	if(!CheckLoginInfo())
		return false;
  document.getElementById('editflag').value='edit';
  var ip_rule=/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
  var netmask_rule=/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
  var gw_rule=/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-4]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])$/;
  var user_rule =/^[a-zA-Z0-9]+$/;
  var gateway = document.getElementById("starout_lcl_gw").value;
  var gatewayArr = gateway.split(".");
  var gatewayValue = gatewayArr[3];
  gatewayValue = parseInt(gatewayValue, 10);
  var LanGatewayStartIPArr = LanGatewayStartIP.split(".");
  var LanGatewayEndIPArr = LanGatewayEndIP.split(".");
  var InternetGatewayStartIPArr = InternetGatewayStartIP.split(".");
  var InternetGatewayEndIPArr = InternetGatewayEndIP.split(".");
  var LanGateway=LanGatewayStartIPArr[0]+"."+LanGatewayStartIPArr[1]+"."+LanGatewayStartIPArr[2];
  var InternetGateway=InternetGatewayStartIPArr[0]+"."+InternetGatewayStartIPArr[1]+"."+InternetGatewayStartIPArr[2];
  var gatewayFront=gatewayArr[0]+"."+gatewayArr[1]+"."+gatewayArr[2];
  if(document.getElementById ("starout_name").value == "")
  {
      alert(gettext("Please enter a valid name for the static route to be added."));
      return false;
  } else {
  	if(!user_rule.test(document.getElementById ("starout_name").value)) {
  		alert(gettext("Name: Accept 0-9,a-z,A-Z or not accept Chinese format."));
  		document.getElementById("starout_name").focus();
  		return false;
  	}
  }
  
  if(document.getElementById ("starout_dest_net").value == "") {
      alert(gettext("Enter valid Destination Address."));
      return false;
  } else {
  	if(!ip_rule.test(document.getElementById ("starout_dest_net").value)){
  		alert(gettext("Destination Address is invalid."));
  		document.getElementById("starout_dest_net").focus();
  		return false;
  	}
  }
  
  if(document.getElementById ("starout_dest_msk").value == ""){
      alert(gettext("Enter valid Subnet Mask."));
      return false;
  } else {
  	if(!netmask_rule.test(document.getElementById ("starout_dest_msk").value)) {
  		alert(gettext ("Destination Subnet Mask is invalid."));
  		document.getElementById("starout_dest_msk").focus();
  		return false;
  	}
  }
  
  if(document.getElementById ("starout_lcl_gw").value != "") 
  {
	if(!gw_rule.test(document.getElementById ("starout_lcl_gw").value))
	{
  		alert(gettext ("Local Gateway is invalid."));
  		document.getElementById("starout_lcl_gw").focus();
  		return false;
  	}
	
	//Network Type
	var NetworkType = document.getElementById("starout_network").value;
	if (NetworkType == "Default")
	{
		if(gatewayFront!=LanGateway)
		{
			alert(gettext ("Local Gateway is invalid."));
  		    document.getElementById("starout_lcl_gw").focus();
  		    return false;
		}
	  	if((gatewayValue >= parseInt(LanGatewayEndIPArr[3], 10))||(gatewayValue <= parseInt(LanGatewayStartIPArr[3], 10)))
		{
			alert(gettext ("Local Gateway is invalid."));
  		    document.getElementById("starout_lcl_gw").focus();
  		    return false;
	  	}	
	}
	else if (NetworkType == "WAN1")
	{
		if (NwInfoArr[1])
		{
			if(gatewayFront!=InternetGateway)
		{
			alert(gettext ("Local Gateway is invalid."));
  		    document.getElementById("starout_lcl_gw").focus();
  		    return false;
		}
		 	if((gatewayValue >= parseInt(InternetGatewayEndIPArr[3], 10))||(gatewayValue <= parseInt(InternetGatewayStartIPArr[3], 10)))
			{
				alert(gettext ("Local Gateway is invalid."));
	  		    document.getElementById("starout_lcl_gw").focus();
	  		    return false;
	  	  	}
		}
		else	
		{
			alert(gettext ("Local Gateway is invalid."));
  		    document.getElementById("starout_lcl_gw").focus();
  		    return false;
		}
	}	
  }
  else
  {
  	
  }
  
  if (StaticRouteInfo == ""){    //Add
    for (var i=0; i < StaticRouteNameArr.length; i++)
    {
  	  var name = document.getElementById('starout_name').value;
  	  if (StaticRouteNameArr[i]==name){  
  	    count++;
  	  }
    }
  
    if (count > 0){
      alert("The static route name is duplicate.");
	  document.getElementById('starout_name').value = "";
      document.getElementById('starout_dest_net').value = "";
      document.getElementById('starout_dest_msk').value = "";
      document.getElementById('starout_network').selectedIndex = 0;
      document.getElementById('starout_lcl_gw').value = "";
  	  document.getElementById("starout_name").focus();
	  window.location.href="../advanced/advanced_staticroute.asp";
  	  return false;
    }
  }	

  return true;
}

</script>
</head>

<body onload="static_route_edit_init()">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("advanced_staticroute", "advanced_staticroute_href");</script>
<!-- Main Menu and Submenu End -->

<!-- Right Content start -->
<div class="contentBg">
  <div class="secH1"><script>document.write(gettext("Static Routing"));</script></div>
  <div class="secBg">  
  <div class="secInfo"><br><script>document.write(gettext("Use this page to create static routes for the gateway. Be sure to enter a destination address, subnet mask, gateway and metric for each configured static route."));</script></br></div>
  <form method="post" action="/goform/setStaticRouteEdit">
  <input type="hidden" name="editflag" id="editflag" value="edit">
  <table class="configTbl" cellspacing="0">
    <tr>
      <td><script>document.write(gettext("Route Name"));</script></td>
      <td><input id="starout_name" name="starout_name" type="text" class="configF1" maxlength="24" value="" size="20"/></td>
    </tr>
    <tr>
      <td><script>document.write(gettext("Destination Network"));</script></td>
      <td><input id="starout_dest_net" name="starout_dest_net" type="text" class="configF1" maxlength="17" value="" size="20"/></td>
    </tr>   
    <tr>
      <td><script>document.write(gettext("IP Subnet Mask"));</script></td>
      <td><input id="starout_dest_msk" name="starout_dest_msk" type="text" class="configF1" maxlength="17" value="" size="20"/></td>
    </tr> 
    <tr>
      <td><script>document.write(gettext("Network"));</script></td>
      <td><select size="1" id="starout_network" name="starout_network" class="configF1">
        <option value="Default"><script>document.write(gettext("LAN Default"));</script></option>
		<option value="WAN1"><script>document.write(gettext("Internet"));</script></option>
	  </select></td>
    </tr>
    <tr>
      <td><script>document.write(gettext("Local Gateway"));</script></td>
      <td><input id="starout_lcl_gw" name="starout_lcl_gw" type="text" class="configF1" maxlength="17" value="" size="20"/></td>
    </tr>
    </table>   
    <div class="submitBg">
	  <input type="submit" id="sta_edit_apply" value="Apply" class="submit" title="Apply" onclick="return sta_rout_validate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
	  <input type="button" id="sta_edit_reset" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
	</div>
  </form>
</div>
</div>
</div>
<script type="text/javascript">
  document.getElementById('sta_edit_apply').value=gettext("Apply");
  document.getElementById('sta_edit_reset').value=gettext("Reset");
</script>
</body>
</html>
