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


var timerId = null;
var apn1_status;
function InternetStatusInit()
{
	var WanInfo = <%getWanStatistics();%>;
 var WanArr = WanInfo.split("#");

 InternetStatusDisplay(WanArr);

 setTimeout(function () { autoRefresh_internet_info(); }, 10000);

	return;
}

function InternetStatusDisplay(WanArr)
{
	//Network Status:: APN1
	if(WanArr[0] == -1)
		document.getElementById("apn1_tx_packets").innerHTML="0";
	else
  document.getElementById("apn1_tx_packets").innerHTML=WanArr[0];

	if(WanArr[1] == -1)
		document.getElementById("apn1_tx_bytes").innerHTML="0";
	else
  document.getElementById("apn1_tx_bytes").innerHTML=WanArr[1];

	if(WanArr[2] == -1)
  document.getElementById("apn1_tx_errors").innerHTML="0";
	else
  document.getElementById("apn1_tx_errors").innerHTML=WanArr[2];

	if(WanArr[3] == -1)
	 document.getElementById("apn1_tx_overflows").innerHTML="0";
	else
  document.getElementById("apn1_tx_overflows").innerHTML=WanArr[3];

 if(WanArr[4] == -1)
		document.getElementById("apn1_rx_packets").innerHTML="0";
	else
  document.getElementById("apn1_rx_packets").innerHTML=WanArr[4];

	if(WanArr[5] == -1)
		document.getElementById("apn1_rx_bytes").innerHTML="0";
	else
  document.getElementById("apn1_rx_bytes").innerHTML=WanArr[5];

	if(WanArr[6] == -1)
  document.getElementById("apn1_rx_errors").innerHTML="0";
	else
  document.getElementById("apn1_rx_errors").innerHTML=WanArr[6];

	if(WanArr[7] == -1)
  document.getElementById("apn1_rx_overflows").innerHTML="0";
	else
  document.getElementById("apn1_rx_overflows").innerHTML=WanArr[7];

	//* APN1 Status *//
	//Registration state
 document.getElementById("apn1_status").innerHTML=WanArr[8];
 if(WanArr[8] == "Registered") {
   //Signal Strength
   document.getElementById("apn1_signals").innerHTML=WanArr[9] + " dBm";
   //Network Name
   document.getElementById("apn1_network_name").innerHTML=WanArr[10];
   //Mobile Country Code(MCC)
   document.getElementById("apn1_mcc").innerHTML=WanArr[11];
   //Mobile Network Code(MNC)
   document.getElementById("apn1_mnc").innerHTML=WanArr[12];
   //Cell ID
   if (WanArr[13] == "-1")
     document.getElementById("apn1_cell_id").innerHTML="";
   else
     document.getElementById("apn1_cell_id").innerHTML=WanArr[13];
   //RSSI
   document.getElementById("apn1_rssi").innerHTML=WanArr[14];
   //Radio Interference
   document.getElementById("apn1_radio_interference").innerHTML=WanArr[15];
 } else {
   //Signal Strength
   document.getElementById("apn1_signals").innerHTML="-128 dBm";
   //Network Name
   document.getElementById("apn1_network_name").innerHTML="None";
   //Mobile Country Code(MCC)
   document.getElementById("apn1_mcc").innerHTML="";
   //Mobile Network Code(MNC)
   document.getElementById("apn1_mnc").innerHTML="";
   //Cell ID
   document.getElementById("apn1_cell_id").innerHTML="";
   //RSSI
   document.getElementById("apn1_rssi").innerHTML="1,(128,0)";
   //Radio Interference
   document.getElementById("apn1_radio_interference").innerHTML="None";
 }

	if(WanArr[8] == "Registered")
		apn1_status = true;
	else
		apn1_status = false;

	return;
}
</script>
</head>

<body onload="InternetStatusInit();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("lte");%>
<script type="text/javascript">menuChange("lte_menu");leftMenuChange("internet_status", "internet_status_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1"><script>document.write(gettext("Status"));</script></div>
	<div class="secBg">
		<div class="statusMsg"></div>
		<div class="secInfo">
		<br><script>document.write(gettext("This page shows port statistics for 4G."));</script>
		<br>
		</div>
  <div class="secH2"><script>document.write(gettext("Network Status"));</script></div>
  <table border="0" cellpadding="0" cellspacing="0" width="654">
    <tr>
      <td class="tdH" width="45%"><script>document.write(gettext("4G Device Name"));</script></td>
      <td class="tdH" width="55%"><script>document.write(gettext("APN1"));</script></td>
    </tr>
    <tr>
      <td class="tdH"><script>document.write(gettext("Registration State"));</script></td>
      <td class="tdEven" id="apn1_status"></td>
    </tr>
    <tr>
      <td class="tdH"><script>document.write(gettext("Radio Interference"));</script></td>
      <td class="tdEven" id="apn1_radio_interference"></td>
    </tr>
    <tr>
      <td class="tdH"><script>document.write(gettext("RSSI"));</script></td>
      <td class="tdEven" id="apn1_rssi"></td>
    </tr>
    <tr>
      <td class="tdH"><script>document.write(gettext("Signal Strength"));</script></td>
      <td class="tdEven" id="apn1_signals"></td>
    </tr>
    <tr>
      <td class="tdH"><script>document.write(gettext("Network Name"));</script></td>
      <td class="tdEven" id="apn1_network_name"></td>
    </tr>
    <tr>
      <td class="tdH"><script>document.write(gettext("Mobile Country Code(MCC)"));</script></td>
      <td class="tdEven" id="apn1_mcc"></td>
    </tr>
    <tr>
      <td class="tdH"><script>document.write(gettext("Mobile Network Code(MNC)"));</script></td>
      <td class="tdEven" id="apn1_mnc"></td>
    </tr>
    <tr>
      <td class="tdH"><script>document.write(gettext("Cell ID"));</script></td>
      <td class="tdEven" id="apn1_cell_id"></td>
    </tr>
  </table>
  <br /><br />
  <div class="secH2"><script>document.write(gettext("Transmit"));</script></div>
  <table border="0" cellpadding="0" cellspacing="0" width="654">
    <tr>
      <td class="tdH" width="20%"><script>document.write(gettext("4G Device Name"));</script></td>
      <td class="tdH" width="20%"><script>document.write(gettext("Tx Packets"));</script></td>
      <td class="tdH" width="20%"><script>document.write(gettext("Tx Errors"));</script></td>
      <td class="tdH" width="20%"><script>document.write(gettext("Tx Overflows"));</script></td>
      <td class="tdH" width="20%"><script>document.write(gettext("Tx Bytes"));</script></td>
    </tr>
    <tr>
      <td class="tdOdd">APN1</td>
      <td id="apn1_tx_packets" class="tdOdd"></td>
      <td id="apn1_tx_errors" class="tdOdd"></td>
      <td id="apn1_tx_overflows" class="tdOdd"></td>
      <td id="apn1_tx_bytes" class="tdOdd"></td>
    </tr>
  </table>
  <br /><br />
  <div class="secH2"><script>document.write(gettext("Receive"));</script></div>
  <table border="0" cellpadding="0" cellspacing="0" width="654">
    <tr>
      <td class="tdH" width="20%"><script>document.write(gettext("4G Device Name"));</script></td>
      <td class="tdH" width="20%"><script>document.write(gettext("Rx Packets"));</script></td>
      <td class="tdH" width="20%"><script>document.write(gettext("Rx Errors"));</script></td>
      <td class="tdH" width="20%"><script>document.write(gettext("Rx Overflows"));</script></td>
      <td class="tdH" width="20%"><script>document.write(gettext("Rx Bytes"));</script></td>
    </tr>
    <tr>
      <td class="tdOdd">APN1</td>
      <td id="apn1_rx_packets" class="tdOdd"></td>
      <td id="apn1_rx_errors" class="tdOdd"></td>
      <td id="apn1_rx_overflows" class="tdOdd"></td>
      <td id="apn1_rx_bytes" class="tdOdd"></td>
    </tr>
  </table>
  <br />
		<div>
			<input type="button" value="Refresh" class="submit" title="Refresh" id="button.refresh" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'" onclick="doRedirect();" />
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
function autoRefresh_internet_info()
{
	var ajax = createAjax();

	if (timerId) {
	  clearTimeout(timerId);
	}

 ajax.open('GET', "get_Internet_info.asp?time="+ new Date(), true);
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
       var WanArr = data.split("#");
       InternetStatusDisplay(WanArr);

	      if(apn1_status == false)
	      {
         timerId = setTimeout(function () { autoRefresh_internet_info(); }, 30000);
	      }
	      else
	      {
		       timerId = setTimeout(function () { autoRefresh_internet_info(); }, 10000);
	      }
    }
   }
  }
 }
}
</script>

</body>
</html>
