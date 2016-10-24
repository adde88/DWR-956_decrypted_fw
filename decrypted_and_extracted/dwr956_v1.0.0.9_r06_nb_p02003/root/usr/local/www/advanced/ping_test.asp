<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>4G Router</title>
	<meta http-equiv="Content-Language" content="en-us" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="../style/all.css" type="text/css" />
	<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
	<script type="text/javascript" src="../js/j_ping.js"></script>	
    <script type="text/javascript" src="../js/mgmt.js"></script>
        
	<script language="javascript" type="text/javascript">
		var login_flag=<%getuser_login();%>;
		if(login_flag=="1")
		{
			window.location.href="../login.asp";
		}
		var nat_enable=<%getFwNatEnable();%>;
		if(nat_enable!="1")
		{
			window.location.href="../login.asp";
		}

	
	</script>


</head>


<body onload="loadPingTestPage();">

<div id="all">
<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("ping_test", "ping_test_href");</script>
<!-- Main Menu and Submenu End -->

<!-- Right Content start -->
<div class="contentBg">
<div class="secH1"><script>document.write(gettext("Ping Test"));</script></div>
<!-- Section Begin -->
<div class="secBg">
	<div class="statusMsg"><%getActionResult();%></div>
	<div class="secInfo"><script>document.write(gettext("Ping Test is used to send Ping packets to test if a computer is on the Internet."));</script></div>
  
	<div id="maincontent">
    <!-- === BEGIN MAINCONTENT === -->
	<div>
		<form id="PING_FORM" name="PING_FORM" method="post">
		<input type="hidden" id="host_name" name="host_name" value="">		    

		<!-- IPv4 table -->
		<div class="secH2"><script>document.write(gettext("Ping Test"));</script></div>     		
		<table cellSpacing=1 cellPadding=1 width=525 border=0>
		      <tr>
		        <td style="padding: 0 20px 0 25px;">IP Address</td>
		        <td height="20" valign="top">
		          <div id="ping_list" style="display:none"></div>		          
		          <input type="text" id="ping_host" name="ping_host" size=30 maxlength=63>
		          &nbsp;&nbsp;&nbsp;&nbsp;
		          <input type="button" name="ping" id="ping" value="Ping">
		          <input type="button" name="stop" id="stop" value="Stop">
		        </td>
		      </tr>		
		</table>

		<!-- IPv6 table -->
		<div class="secH2"><script>document.write(gettext("IPv6 Ping Test"));</script></div>     				
		<table cellSpacing=1 cellPadding=1 width=525 border=0>
			<tr>
				<td style="padding: 0 20px 0 25px;">IP Address</td>
				<td height="20" valign="top">
					<div id="ping_list" style="display:none"></div>					
					<input type="text" id="ping6_host" name="ping6_host" size=30 maxlength=63>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" name="ping6" id="ping6" value="Ping">
					<input type="button" name="stop6" id="stop6" value="Stop">
				</td>
			</tr>
		</table>
		
		</form>		
	</div>

	<!-- Ping Result -->
	<div class="secH2"><script>document.write(gettext("Ping Result"));</script></div>     		
	<div class="box" style="padding: 0 20px 0 25px;">	
		<span id="ping_check_progress_field"></span>
	</div>                    
	
  </div><!-- secBg end -->
</div> <!-- contentBg end -->
</div> <!-- all end -->
</body>
</html>
