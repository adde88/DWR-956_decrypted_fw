<html>
<head>
<meta http-equiv="refresh" content="10">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="final.css" type="text/css">
<link rel="stylesheet" href="csshorizontalmenu.css" type="text/css">
<title>GR-909 Line Testing</title>
<script language="JavaScript">

function submitF()
{
	/*	window.open('gr909lt_timer.asp', 'TestResult', 'toolbar=0,status=0,menubar=0,scrollbars=1,resizable=1,width=530,height=400,left=150,top=150');*/
	document.tF0.submit();
  return true;
}

/*function InitPage()
{
	if(testStatus = 1)
	{
		alert('Test is still Pending');
		
	}	
}*/
function Initshow()
{

	if(document.tF0.status.value == "PENDING"){
		document.getElementById("statuslabel").innerHTML="<B> Result : </B> Please wait..!,Test in Progress...";			
		document.getElementById("LineTest").style.visibility = 'hidden';
		//document.getElementById("TestStop").style.visibility = 'visible';
		//document.tF0.LineTest.disabled=1;
		//document.tF0.TestStop.disabled=0;
	}else if(document.tF0.status.value == "PASSED"){
		document.getElementById("statuslabel").innerHTML="<B> Result : </B> <font color=\"green\" size=4>PASS</font>";			
		document.getElementById("LineTest").style.visibility = 'visible';
		//document.getElementById("TestStop").style.visibility = 'hidden';
		//document.tF0.LineTest.disabled=0;
		//document.tF0.TestStop.disabled=1;
	}else if(document.tF0.status.value == "FAILED"){
		   document.getElementById("statuslabel").innerHTML="<B> Result : </B><font color=\"red\" size=4>FAILED</font>";			
			document.getElementById("LineTest").style.visibility = 'visible';
			//document.getElementById("TestStop").style.visibility = 'hidden';
		  // document.tF0.LineTest.disabled=0;
			// document.tF0.TestStop.disabled=1;
	}else {
			 document.getElementById("statuslabel").innerHTML="";
			document.getElementById("LineTest").style.visibility = 'visible';
			//document.getElementById("TestStop").style.visibility = 'hidden';
			 //document.tF0.LineTest.disabled=0;
			 //document.tF0.TestStop.disabled=1;
	}

  document.testres.hpt_ac_r2g.disabled =1;	
  document.testres.hpt_ac_t2g.disabled =1;	
  document.testres.hpt_ac_t2r.disabled =1;	
  document.testres.hpt_dc_r2g.disabled =1;	
  document.testres.hpt_dc_t2g.disabled =1;	

  document.testres.femf_ac_r2g.disabled =1;	
  document.testres.femf_ac_t2g.disabled =1;	
  document.testres.femf_ac_t2r.disabled =1;	
  document.testres.femf_dc_r2g.disabled =1;	
  document.testres.femf_dc_t2g.disabled =1;	

  
  document.testres.rft_r2g.disabled =1;	
  document.testres.rft_t2g.disabled =1;	
  document.testres.rft_t2r.disabled =1;	

  document.testres.roh_t2r_l.disabled =1;	

  document.testres.rit_res.disabled =1;	
}

function StopTest(){
	//alert("Stoping the Test...\n");
  document.tF0.stopstatus.value=1;	
	document.tF0.submit();
  return true;
}

</script>
</head>
<body class="decBackgroundDef" onLoad="Initshow();">
<form name="tF0" method="post" action="/goform/ifx_set_gr909lt_testcfg">
<input type="hidden" name="page" value="gr909lt_test.asp"> 
<input type="hidden" name="status" value=<% ifx_get_gr909lt_testresult("status");%>>
<input type="hidden" name="stopstatus" value="0">
<input type="hidden" name="cvflag" value="0">
<FIELDSET style="width:730px;">
<table border="0" cellspacing="1" cellpadding="5" width="80%">
  <tr align="left">
	<td valign="top">
	  <p><span class="decBold">GR-909 Line Testing</span></p>
	</td>
  </tr>      
  <tr align="left">
	<td width="35%" colspan="2">
	  <p>
	  <br>GR-909 is one of the standards to perform the line testing.</br> 
          <br>GR-909 linetesting allows the user to perform tests on the analog line. These tests are done when no call session is processed on this specific analog line.</br>
	  </p>
	  <p></p>
	</td>
  </tr>
</table>
<table align="center" border="0" cellspacing=1 cellpadding=1 width="70%" bordercolordark="#000000">
	<tr >
		<td>&nbsp;</td>
	</tr>
	<tr >
		<td align="center">
			<table border="0" bordercolordark="#000000">		
				<tr>
 					<td width="70%">FXS line for Line Testing</td>
				 		<td align="center" width="30%">
				   		<select name="fxslineid" size="1">
						  <% ifx_get_gr909lt_testcfg("fxslineid");%>
				   		</select>
				   	</td>
        </tr>
      </table>
    </td>
	</tr>
</table>

				<tr >
					<td>&nbsp;</td>
				</tr>
				<tr >
					<td>&nbsp;</td>
				</tr>
<table width="80%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<div align="left">
  	    <input type="button" value="Execute the Test " name="LineTest" id="LineTest" style="visibility: visible;" onClick="return submitF();">&nbsp;
  	   <!-- <input type="button" value="Stop the Test " name="TestStop" id="TestStop" style="visibility: hidden;"  onClick="return StopTest();">&nbsp; -->
			</div>
		</td>
		<td id="statuslabel" name="statuslabel"> </td>
	</tr>
</table>
</FIELDSET>
</form>

<FORM ACTION=" " METHOD="POST" NAME="testres">
<input type="hidden" name="page" value="gr909lt_test.asp"> 
<FIELDSET style="width:730px;">

				<tr>
					<td align="center"><span class="decBold"><H3>&nbsp;&nbsp;Test Status &nbsp;&nbsp;<% ifx_get_gr909lt_testresult("status");%>&nbsp;&nbsp;</H3></span></td>
				</tr>
				<tr >
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td align="center"><span class="decBold">&nbsp;<% ifx_get_gr909lt_testresult("channelnum");%>&nbsp;&nbsp;&nbsp;</span></td>
				</tr>
				<tr >
					<td>&nbsp;</td>
				</tr>
<tr >
	<td align="center">
  	<table class="tableInput" border="1" bordercolordark="#000000" width="95%">	
  		<tr>
 		 		<th width="75%">Test</th>
  			<th>Result</th>
			</tr>
			<tr>
        <th align="center">Hazardous Potential Test</th>
			</tr>
			<tr>
				<td>
					HPT AC Ring Wire to GND Value. [Vrms] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20" name="hpt_ac_r2g" size=15 value="<%ifx_get_gr909lt_testresult("hpt_ac_r2g");%>">
				</td>
			</tr>
			<tr>
				<td>
					HPT AC Tip Wire to GND Value. [Vrms] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="hpt_ac_t2g" size=15 value="<%ifx_get_gr909lt_testresult("hpt_ac_t2g");%>">
				</td>
			</tr>
			<tr>
				<td>
					HPT AC Tip Wire to Ring Value. [Vrms] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="hpt_ac_t2r" size=15 value="<%ifx_get_gr909lt_testresult("hpt_ac_t2r");%>">
				</td>
			</tr>
			<tr>
				<td>
					HPT DC Ring Wire to GND Value. [V] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="hpt_dc_r2g" size=15 value="<%ifx_get_gr909lt_testresult("hpt_dc_r2g");%>">
				</td>
			</tr>
			<tr>
				<td>
					HPT DC Tip Wire to GND Value. [V] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="hpt_dc_t2g" size=15 value="<%ifx_get_gr909lt_testresult("hpt_dc_t2g");%>">
				</td>
			</tr>

			<tr>
        <th>Foreign Electromotive Forces Test</th>
			</tr>
     <tr>
				<td>
					FEMF AC Ring Wire to GND Value. [Vrms] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20" name="femf_ac_r2g" size=15 value="<%ifx_get_gr909lt_testresult("femf_ac_r2g");%>">
				</td>
			</tr>
			<tr>
				<td>
					FEMF AC Tip Wire to GND Value. [Vrms] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="femf_ac_t2g" size=15 value="<%ifx_get_gr909lt_testresult("femf_ac_t2g");%>">
				</td>
			</tr>
			<tr>
				<td>
					FEMF AC Tip Wire to Ring Value. [Vrms] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="femf_ac_t2r" size=15 value="<%ifx_get_gr909lt_testresult("femf_ac_t2r");%>">
				</td>
			</tr>
			<tr>
				<td>
					FEMF DC Ring Wire to GND Value. [Ohm] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="femf_dc_r2g" size=15 value="<%ifx_get_gr909lt_testresult("femf_dc_r2g");%>">
				</td>
			</tr>
			<tr>
				<td>
					FEMF DC Tip Wire to GND Value. [Ohm] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="femf_dc_t2g" size=15 value="<%ifx_get_gr909lt_testresult("femf_dc_t2g");%>">
				</td>
			</tr>
			<tr bgcolor="violet">
        <th align="center">Resistive Faults Test</th>
			</tr>
      <tr>
				<td>
					RFT Ring Wire to GND Value. [Ohm] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20" name="rft_r2g" size=15 value="<%ifx_get_gr909lt_testresult("rft_r2g");%>">
				</td>
			</tr>
			<tr>
				<td>
					RFT Tip Wire to GND Value. [Ohm] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="rft_t2g" size=15 value="<%ifx_get_gr909lt_testresult("rft_t2g");%>">
				</td>
			</tr>
			<tr>
				<td>
					RFT Tip Wire to Ring Value. [Vrms] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20"	name="rft_t2r" size=15 value="<%ifx_get_gr909lt_testresult("rft_t2r");%>">
				</td>
			</tr>

      <tr>
        <th align="center">Receiver Off-Hook Test</th>
			</tr>
      <tr>
				<td>
				  Roh Tip Wire to Ring Wire Value for low Voltage.	[Ohm] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20" name="roh_t2r_l" size=15 value="<%ifx_get_gr909lt_testresult("roh_t2r_l");%>">
				</td>
			</tr>
<!--
      <tr>
				<td>
				  Roh Tip Wire to Ring Wire Value for high Voltage.	[Ohm] &nbsp;
				</td>
				<td>
				  <input type ="INT" maxLength="20" name="roh_t2r_h" size=15 value="<%ifx_get_gr909lt_testresult("roh_t2r_h");%>">
				</td>
			</tr>
-->
      <tr>
        <th align="center">Ringer Impedance Test</th>
			</tr>
      <tr>
				<td>
				  Rit value. [Ohm] &nbsp; 
				</td>
				<td>
				  <input type ="INT" maxLength="20" name="rit_res" size=15 value="<%ifx_get_gr909lt_testresult("rit_res");%>">
				</td>
			</tr>

    </table>
	</td>          						
</tr>     

</FIELDSET>
</body>
</html>



