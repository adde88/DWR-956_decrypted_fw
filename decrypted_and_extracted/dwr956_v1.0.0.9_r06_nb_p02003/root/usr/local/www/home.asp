<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<link rel="stylesheet" href="../style/home.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>

<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);

function getPINPUKInfo()
{
 var PinCfg = <%getPinConfig();%>;
 var pinArr = PinCfg.split("#");
 if (pinArr[0] == "1") //PIN not verified
 {
  document.getElementById('home_hint_message').style.display = "block";
  document.getElementById("pin_status_info").innerHTML = gettext("The PIN is enabled and not verified.");
 } else if (pinArr[0] == "4") { //puk
  document.getElementById('home_hint_message').style.display = "block";
  document.getElementById("pin_status_info").innerHTML = gettext("The PIN verification failed.");
 } else {
  document.getElementById('home_hint_message').style.display = "none";
 }
 return;
}

var radio_interference = "none";
var signal_level = "0";
function InternetInfoDisplay1(NwInfoArr)
{
 //Internet: Carrier
	if (NwInfoArr[0] == "Registered") {
   document.getElementById("wan_carrier").innerHTML=NwInfoArr[2];
   document.getElementById("wan_carrier").title=NwInfoArr[2];
 } else {
   document.getElementById("wan_carrier").innerHTML="Unknown";
 }

	//Internet: Network
	radio_interference = NwInfoArr[4];

 signal_level = NwInfoArr[3];
 if (NwInfoArr[3] == "1") {
   document.getElementById("signal").setAttribute("src", "../images/home/signalPoor.png");
   document.getElementById("percent").innerHTML="&nbsp;&nbsp;20%";
 } else if (NwInfoArr[3] == "2") {
   document.getElementById("signal").setAttribute("src", "../images/home/signalWeak.png");
   document.getElementById("percent").innerHTML="&nbsp;&nbsp;40%";
 } else if (NwInfoArr[3] == "3") {
   document.getElementById("signal").setAttribute("src", "../images/home/signalMid.png");
   document.getElementById("percent").innerHTML="&nbsp;&nbsp;60%";
 } else if (NwInfoArr[3] == "4") {
   document.getElementById("signal").setAttribute("src", "../images/home/signalMid.png");
   document.getElementById("percent").innerHTML="&nbsp;&nbsp;80%";
 } else if (NwInfoArr[3] == "5") {
   document.getElementById("signal").setAttribute("src", "../images/home/signalFull.png");
   document.getElementById("percent").innerHTML="&nbsp;&nbsp;100%";
 } else {
   document.getElementById("signal").setAttribute("src", "../images/home/noSignal.png");
   document.getElementById("percent").innerHTML="&nbsp;&nbsp;0%";
 }

 //Internet: Roaming
 if (NwInfoArr[1] == "Roaming") {
 	document.getElementById("wan_roaming").innerHTML="Yes";
 } else if (NwInfoArr[1] == "Home") {
 	document.getElementById("wan_roaming").innerHTML="No";
 } else {
 	document.getElementById("wan_roaming").innerHTML="Unknown";
 }
 return;
}

function InternetInfoDisplay2(NwInfoArr, NatMode)
{
 if (NwInfoArr[0] == "connected") {
  document.getElementById("wan_internet_img").src="../images/home/Home_Internet_GreenCircle.png";
 } else {
  document.getElementById("wan_internet_img").src="../images/home/Home_Internet_RedCircle.png";
 }

 if (NatMode == "5") {
   document.getElementById("wan_ip").innerHTML="0.0.0.0";
   document.getElementById("wan_dns").innerHTML="0.0.0.0";
   document.getElementById("wan_gateway").innerHTML="0.0.0.0";
   document.getElementById("wan_sub_mask").innerHTML="0.0.0.0";
 } else {
   //Internet: IP Address
   if (NwInfoArr[1])
     document.getElementById("wan_ip").innerHTML=NwInfoArr[1];
   else
     document.getElementById("wan_ip").innerHTML="0.0.0.0";
   //Internet: DNS server
   if (NwInfoArr[4])
     document.getElementById("wan_dns").innerHTML=NwInfoArr[4];
   else
     document.getElementById("wan_dns").innerHTML="0.0.0.0";
   //Internet: Gateway
   if (NwInfoArr[2])
     document.getElementById("wan_gateway").innerHTML=NwInfoArr[2];
   else
     document.getElementById("wan_gateway").innerHTML="0.0.0.0";
   //Internet: Sub mask
   if (NwInfoArr[3])
     document.getElementById("wan_sub_mask").innerHTML=NwInfoArr[3];
   else
     document.getElementById("wan_sub_mask").innerHTML="0.0.0.0";
 }

 document.getElementById('wan_network_type_2g').src="../images/home/Home_Internet_GrayCircle.png";
 document.getElementById('wan_network_type_3g').src="../images/home/Home_Internet_GrayCircle.png";
 document.getElementById('wan_network_type_4g').src="../images/home/Home_Internet_GrayCircle.png";
 var wan_network_type = "none";
 if (radio_interference == "GSM") {
  wan_network_type = "wan_network_type_2g";
 } else if (radio_interference == "UMTS") {
		wan_network_type = "wan_network_type_3g";
 } else if (radio_interference == "LTE") {
		wan_network_type = "wan_network_type_4g";
 }

 if (NwInfoArr[0] == "connected") {
   if (wan_network_type != "none") {
     if (signal_level == "5") {
       document.getElementById(wan_network_type).src="../images/home/Home_Internet_GreenCircle.png";
     } else if (signal_level == "4" || signal_level == "3" || signal_level == "2" || signal_level == "1") {
       document.getElementById(wan_network_type).src="../images/home/Home_Internet_YellowCircle.png";
     } else {
       document.getElementById(wan_network_type).src="../images/home/Home_Internet_RedCircle.png";
     }
   }
 } else {
   if (wan_network_type != "none") {
     document.getElementById(wan_network_type).src="../images/home/Home_Internet_RedCircle.png";
   }
 }

 return;
}

function getInternetInfo()
{
 var NetworkInfo1 = <%getHomeInternetInfo1();%>;
 var NwInfoArr1 = NetworkInfo1.split("#");
 InternetInfoDisplay1(NwInfoArr1);

 var NetworkInfo2 = <%getHomeInternetInfo2();%>;
 var NwInfoArr2 = NetworkInfo2.split("#");

 var nat_mode = <%getFwNatEnable();%>;
 InternetInfoDisplay2(NwInfoArr2, nat_mode);

 return;
}

function getSysInfo()
{
 var SysInfo = <%getSysInfo();%>;
 var SysArr = SysInfo.split("#");
 document.getElementById("sys_name").innerHTML=SysArr[0];
 document.getElementById("sys_name").title=SysArr[0];
 var Sw_Ver = "";
 var Sw_Ver_Obj = SysArr[1].split("_");
 if (Sw_Ver_Obj.length > 2) {
   Sw_Ver = Sw_Ver_Obj[1];
 } else {
   Sw_Ver = SysArr[1];
 }
 document.getElementById("sw_ver").innerHTML=Sw_Ver;
 document.getElementById("sw_ver").title=Sw_Ver;
 return;
}

function getWiFiInfo()
{
 var WiFiInfo = <%getWiFiInfo();%>;
 var WiFiArr = WiFiInfo.split("#");

	var WifiRadio = <%getHomeWiFiRadio();%>;
	var RadioArr = WifiRadio.split("#");

 document.getElementById("ssid1").innerHTML=WiFiArr[0];
 document.getElementById("ssid1").title=WiFiArr[0];
	if (WiFiArr[1] == "WPAWPA2"){
		document.getElementById("ssid1_encry").innerHTML="WPA+WPA2";
	}else{
		document.getElementById("ssid1_encry").innerHTML=WiFiArr[1];
	}

 document.getElementById("ssid2").innerHTML=WiFiArr[2];
 document.getElementById("ssid2").title=WiFiArr[2];
	if (WiFiArr[3] == "WPAWPA2"){
		document.getElementById("ssid2_encry").innerHTML="WPA+WPA2";
	}else{
		document.getElementById("ssid2_encry").innerHTML=WiFiArr[3];
	}

 document.getElementById("ssid3").innerHTML=WiFiArr[4];
 document.getElementById("ssid3").title=WiFiArr[4];
	if (WiFiArr[5] == "WPAWPA2"){
		document.getElementById("ssid3_encry").innerHTML="WPA+WPA2";
	}else{
		document.getElementById("ssid3_encry").innerHTML=WiFiArr[5];
	}

 document.getElementById("ssid4").innerHTML=WiFiArr[6];
 document.getElementById("ssid4").title=WiFiArr[6];
	if (WiFiArr[7] == "WPAWPA2"){
		document.getElementById("ssid4_encry").innerHTML="WPA+WPA2";
	}else{
		document.getElementById("ssid4_encry").innerHTML=WiFiArr[7];
	}

	if (RadioArr[0] == "0"){
		document.getElementById("wifi_channel_11n").innerHTML="Auto";
	}else{
		document.getElementById("wifi_channel_11n").innerHTML=RadioArr[0];
	}

	if (RadioArr[1] == "0"){
		document.getElementById("wifi_channel_11ac").innerHTML="Auto";
	}else{
		document.getElementById("wifi_channel_11ac").innerHTML=RadioArr[1];
	}

 return;
}

function LanInfoDisplay1(LanArr)
{
 if (LanArr[1] == "connected") {
 	if (LanArr[0] == 1000) {
 		document.getElementById('lan1').src="../images/home/Home_Internet_GreenCircle.png";
 	} else {
 		document.getElementById('lan1').src="../images/home/Home_Internet_YellowCircle.png";
 	}
 } else {
 	document.getElementById('lan1').src="../images/home/Home_Internet_GrayCircle.png";
 }

 if (LanArr[3] == "connected") {
 	if (LanArr[2] == 1000) {
 		document.getElementById('lan2').src="../images/home/Home_Internet_GreenCircle.png";
 	} else {
 		document.getElementById('lan2').src="../images/home/Home_Internet_YellowCircle.png";
 	}
 } else {
 	document.getElementById('lan2').src="../images/home/Home_Internet_GrayCircle.png";
 }

 if (LanArr[5] == "connected") {
 	if (LanArr[4] == 1000) {
 		document.getElementById('lan3').src="../images/home/Home_Internet_GreenCircle.png";
 	} else {
 		document.getElementById('lan3').src="../images/home/Home_Internet_YellowCircle.png";
 	}
 } else {
 	document.getElementById('lan3').src="../images/home/Home_Internet_GrayCircle.png";
 }

 if (LanArr[7] == "connected") {
 	if (LanArr[6] == 1000) {
 		document.getElementById('lan4').src="../images/home/Home_Internet_GreenCircle.png";
 	} else {
 		document.getElementById('lan4').src="../images/home/Home_Internet_YellowCircle.png";
 	}
 } else {
 	document.getElementById('lan4').src="../images/home/Home_Internet_GrayCircle.png";
 }
 return;
}

function getLanInfo()
{
 //LAN Setting
 var LanInfo = <%getLanInfo();%>;
 var LanArr = LanInfo.split("#");
 LanInfoDisplay1(LanArr);

	//DHCP Pool
	var dhcp_ipStart = "<%getDhcpServBasic("StartIpAddress","DhcpServerBasic");%>";
	var dhcp_ipEnd = "<%getDhcpServBasic("EndIpAddress","DhcpServerBasic");%>";
	var IpStart = dhcp_ipStart.split(".");
	var IpEnd = dhcp_ipEnd.split(".");
	var pool_start = 0;
	var pool_end = 0;

	if (IpStart[3] == "0")
  		pool_start = "0";
	else
  		pool_start = IpStart[3];

	if (IpEnd[3] == "0")
  		pool_end = "0";
	else
  		pool_end = IpEnd[3];

	document.getElementById("dhcp_pool").innerHTML = pool_start + "~" + pool_end;

	//LAN Sub Mask
	document.getElementById("lan_sub_mask").innerHTML = "<%getLanBasic("SubnetMask");%>";

 return;
}

function timeCount(str, id_name)
{
    var zero = "0";
    var arr = str.split(":");
    var day = arr[0];
    var hour = arr[1];
    var mini  = arr[2];
    var sec  = arr[3];

    if ((day == 0 && hour == 0 && mini == 0 && sec == 0) || str == "") {
      document.getElementById(id_name).innerHTML = "0 Day, 00:00:00";
      document.getElementById(id_name).title = "0 Day, 00:00:00";
      return;
    }

    sec++;
    if (sec >= 60) {
        mini++;
        sec -= 60;
    }

    if (sec < 10) {
        sec = zero.concat(parseInt(sec));
    }

    if (mini >= 60) {
        hour++;
        mini -= 60;
    }

    if (mini < 10) {
        mini = zero.concat(parseInt(mini));
    }

    if (hour < 10) {
        hour = zero.concat(parseInt(hour));
    }

    if (hour >= 24) {
        day++;
        hour -= 24;
    }

    if (hour < 10) {
        hour = zero.concat(parseInt(hour));
    }

    var new_time = "";
    if (day <= 1) {
      new_time = day + " Day, " + hour + ":" + mini + ":" + sec;
    } else {
      new_time = day + " Days, " + hour + ":" + mini + ":" + sec;
    }
    document.getElementById(id_name).innerHTML = new_time;
    document.getElementById(id_name).title = new_time;

    var new_time_2 = day + ":" + hour + ":" + mini + ":" + sec + ":" + day;
    var newstr = "timeCount(\"" + new_time_2 + "\", \"" + id_name + "\")";

    setTimeout(newstr, 1000);
}

var timerId = null;
function homeStatusRefresh()
{
	setTimeout(function () { get_wifi_total_clients(); }, 100);
 setTimeout(function () { autoRefresh_home_info(); }, 30000);
	return;
}
</script>
</head>

<body onload="getPINPUKInfo();getInternetInfo();getSysInfo();getWiFiInfo();getLanInfo();homeStatusRefresh();">
<div id="home_all">

<!-- Main Menu Start -->
<%writeMainMenu();%>
<script type="text/javascript">menuChange("home_menu");</script>
<!-- Main Menu End -->

		<!-- Content-Home start -->
		<div id="home_main_page">
			<div id="home_main_page_background">

			<!-- Content-System start -->
			<div id="home_system_content">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="122" class="system_table_icon"><img src="../images/home/Home_4G_RouterIcon.png" border="0" />
							<ul id="home_content_system">
								<li><span class="home_content_list_title"><script>document.write(gettext("System Name"));</script>: </span><span class="home_content_list_text" title="" id="sys_name"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("System Uptime"));</script>: </span><span class="home_content_list_text" title="" id="sys_uptime"><%getSysTime();%></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("HW Version"));</script>: </span><span class="home_content_list_text" id="hw_ver">A1</span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("SW Version"));</script>: </span><span class="home_content_list_text" title="" id="sw_ver"></span></li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
			<!-- Content-System end -->

			<!-- Content-LTE start -->
			<div id="home_lte_content">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="home_internet_table_icon" valign="top"><a href="../internet/internet_status.asp"><img src="../images/home/Home_InternetIcon.png" border="0" /></a></td>
						<td class="home_internet_table_content_background">
							<ul class="home_content_internet_list">
								<li><img src="../images/home/noSignal.png" border="0" id="signal" /><span style="font-size: 18pt;" id="percent"></span></li>
								<li><img src="../images/home/Home_Content_Internet_Line.png" border="0" /></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Internet"));</script>: </span><img src="../images/home/Home_Internet_RedCircle.png" border="0" id="wan_internet_img" /></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Network"));</script>: </span><img src="../images/home/Home_Internet_GrayCircle.png" border="0" id="wan_network_type_2g" /><span class="home_content_list_text">&nbsp;&nbsp;2G&nbsp;&nbsp;</span><img src="../images/home/Home_Internet_GrayCircle.png" border="0" id="wan_network_type_3g" /><span class="home_content_list_text">&nbsp;&nbsp;3G&nbsp;&nbsp;</span><img src="../images/home/Home_Internet_GrayCircle.png" border="0" id="wan_network_type_4g" /><span class="home_content_list_text">&nbsp;&nbsp;4G</span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Carrier"));</script>: </span><span class="home_content_list_text" title="" id="wan_carrier"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Roaming"));</script>: </span><span class="home_content_list_text" id="wan_roaming"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Connection Time"));</script>: </span><span class="home_content_list_text" title="" id="internet_uptime"><%getHomeInternetInfo3();%></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("IP Address"));</script>: </span><span class="home_content_list_text" id="wan_ip"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Subnet Mask"));</script>: </span><span class="home_content_list_text" id="wan_sub_mask"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("DNS Server"));</script>: </span><span class="home_content_list_text" id="wan_dns"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Gateway"));</script>: </span><span class="home_content_list_text" id="wan_gateway"></span></li>
							</ul>
						</td>
					</tr>
				</table>
			</div>

			<div id="line_lte">
				<table border="0" cellpadding="0" cellspacing="0"><tr><td class="line_lte_image"><img src="../images/home/Home_Internet_LeftLine.png" border="0" /></td></tr></table>
			</div>
			<!-- Content-LTE end -->

			<!-- Content-WIFI start -->
			<div id="line_wifi">
				<table border="0" cellpadding="0" cellspacing="0"><tr><td class="line_wifi_image"><img src="../images/home/Home_WiFi_RightLine.png" border="0" /></td></tr></table>
			</div>

			<div id="home_wifi_content">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr><td class="home_wifi_table_icon" valign="top"><a href="../wifi/wifi_clientlist.asp"><img src="../images/home/Home_WiFiIcon.png" border="0" /></a></td>
						<td class="home_internet_table_content_background">
							<ul class="home_content_internet_list">
								<li><span class="home_content_list_title"><script>document.write(gettext("SSID 1"));</script>: </span><span class="home_content_list_text" title="" id="ssid1"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Security"));</script>: </span><span class="home_content_list_text" id="ssid1_encry"></span></li>
								<li>&nbsp;</li>
								<li><span class="home_content_list_title"><script>document.write(gettext("SSID 2"));</script>: </span><span class="home_content_list_text" title="" id="ssid2"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Security"));</script>: </span><span class="home_content_list_text" id="ssid2_encry"></span></li>
								<li>&nbsp;</li>
								<li><span class="home_content_list_title"><script>document.write(gettext("SSID 3"));</script>: </span><span class="home_content_list_text" title="" id="ssid3"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Security"));</script>: </span><span class="home_content_list_text" id="ssid3_encry"></span></li>
								<li>&nbsp;</li>
								<li><span class="home_content_list_title"><script>document.write(gettext("SSID 4"));</script>: </span><span class="home_content_list_text" title="" id="ssid4"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Security"));</script>: </span><span class="home_content_list_text" id="ssid4_encry"></span></li>
								<li>&nbsp;</li>
								<li><span class="home_content_list_title"><script>document.write(gettext("2.4GHz Channel"));</script>: </span><span class="home_content_list_text" id="wifi_channel_11n"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("5GHz Channel"));</script>: </span><span class="home_content_list_text" id="wifi_channel_11ac"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Total Clients"));</script>: </span><span class="home_content_list_text" id="total_client"><script>document.write(gettext("scanning"));</script></span></li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
			<!-- Content-WIFI end -->

			<!-- Content-LAN start -->
			<div id="home_lan_content">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr><td class="home_table_icon" valign="top"><a href="../lan/lan_clientlist.asp"><img src="../images/home/Home_LANIcon.png" border="0" /></a></td>
						<td class="home_table_content_background">
							<ul class="home_content_list">
								<li><img id="lan1" src="../images/home/Home_Internet_GrayCircle.png" border="0" />&nbsp;&nbsp;<span class="home_content_list_title">LAN 1</span></li>
								<li><img id="lan2" src="../images/home/Home_Internet_GrayCircle.png" border="0" />&nbsp;&nbsp;<span class="home_content_list_title">LAN 2</span></li>
								<li><img id="lan3" src="../images/home/Home_Internet_GrayCircle.png" border="0" />&nbsp;&nbsp;<span class="home_content_list_title">LAN 3</span></li>
								<li><img id="lan4" src="../images/home/Home_Internet_GrayCircle.png" border="0" />&nbsp;&nbsp;<span class="home_content_list_title">LAN 4</span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("Subnet Mask"));</script>: </span><span class="home_content_list_text" id="lan_sub_mask"></span></li>
								<li><span class="home_content_list_title"><script>document.write(gettext("DHCP Pool"));</script>: </span><span class="home_content_list_text" id="dhcp_pool"></span></li>
							</ul>
						</td>
					</tr>
				</table>
			</div>

			<div id="line_lan">
					<table border="0" cellpadding="0" cellspacing="0"><tr><td class="line_lan_image"><img src="../images/home/Home_LAN_RightLine.png" border="0" /></td></tr></table>
			</div>
			<!-- Content-LAN end -->

   <div id="home_hint_message" style="display:none;">
     <p id="pin_status_info" style="font-weight:bold; font-size:18px;"></p>
   </div>

			</div> <!-- home_main_page_background end -->

			<div id="home_copyright"></div>
		</div> <!-- home_main_page end -->

</div>

<script type="text/javascript">
timeCount(document.getElementById('sys_uptime').innerHTML, 'sys_uptime');
timeCount(document.getElementById('internet_uptime').innerHTML, 'internet_uptime');

function autoRefresh_home_info()
{
	var ajax = createAjax();

	if (timerId) {
	  clearTimeout(timerId);
	}

 ajax.open('GET', "get_home_info.asp?time="+ new Date(), true);
 ajax.send(null);
	ajax.onreadystatechange = function ()
	{
  if (ajax.readyState == 4)
		{
   if (ajax.status == 200)
			{
    var data = eval('(' + ajax.responseText + ')');
    if (data)
				{
      var result = data.split("~");
      InternetInfoDisplay1(result[0].split("#"));
      InternetInfoDisplay2(result[1].split("#"), result[4]);
      document.getElementById("total_client").innerHTML=result[2];
      LanInfoDisplay1(result[3].split("#"));
      timerId = setTimeout(function () { autoRefresh_home_info(); }, 30000);
    }
   }
  }
 }
}

function get_wifi_total_clients()
{
	var ajax = createAjax();
 ajax.open('GET', "get_wifi_total_clients.asp?time="+ new Date(), true);
 ajax.send(null);
	ajax.onreadystatechange = function ()
	{
  if (ajax.readyState == 4)
		{
   if (ajax.status == 200)
			{
    var data = eval('(' + ajax.responseText + ')');
    if (data)
				{
      document.getElementById("total_client").innerHTML=data;
    }
   }
  }
 }
}
</script>

</body>
</html>
