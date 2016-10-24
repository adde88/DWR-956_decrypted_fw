<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>NEW IAD</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="../style/styles.css" type="text/css" />
	<link rel="stylesheet" href="../style/all.css" type="text/css" />
    <script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>

	<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
	<script type="text/javascript" src="../js/j_sms.js"></script>
    
<script language="javascript" type="text/javascript">
 var login_flag=<%getuser_login();%>;
 if(login_flag=="1")
 {
	window.location.href="../login.asp";
 }
function getPINPUKCfg()
{
  var PinCfg = <%getPinConfig();%>;
  var pinArr = PinCfg.split("#");
  document.getElementById("PIN_VAR").value = pinArr[0];  
  if (pinArr[0] == "1") {          //PIN not verified
      //document.getElementById("srclte").setAttribute("src", "../images/menu/top_menu_internet_disabled.png");
      document.getElementById("hreflte").removeAttribute("href");
  }else{
      //document.getElementById("srclte").setAttribute("src", "../images/menu/top_menu_internet.png");
      document.getElementById("hreflte").href="../internet/internet_radio.asp";
  }  
  return;
}
</script>

</head>

<body>
<input type="hidden" id="PIN_VAR">
<div id="all">
<!-- Main Menu start -->
<div id="home_top">
  <ul>
    <li class="home-1"><a href="#"></a></li>
    <li class="home-2" id="home_menu"><a href="../home.asp"></a></li>
    <li class="home-3" id="lte_menu"><a id="hreflte" href="../internet/internet_radio.asp"></a></li>
    <li class="home-4" id="wifi_menu"><a href="../wifi/wifi_settings.asp"></a></li>
    <li class="home-5" id="lan_menu"><a href="../lan/lan_settings.asp"></a></li>
    <li class="home-6hover" id="adv_menu"><a href="../advanced/sms_newsms.asp"></a></li>
    <li class="home-7" id="sys_menu"><a href="../system/system_time.asp"></a></li>
    <li class="home-9" id="voip_menu"><a href="../voip/voip_linesettings.asp"></a></li>
    <li class="home-801"></li>
	<li class="home-802" style="float:right;">
      <ul class="bluemenu">
        <!--<li><a href="#">Help</a></li>-->
        <li>
          <form method="post" name="top_logout_form" action="/goform/user_logout">
            <input type="hidden" name="top_logout_dummy" value="0"> 	
            <a href="#" id="top_logout" onclick="logout();">Logout</a>           
          </form>
        </li>
        <li><a href="#" onclick="doRedirect();">Refresh</a></li>
      </ul>
    </li>
  </ul>
</div>
<!-- Main Menu end -->

<script type="text/javascript">getPINPUKCfg();</script>

<!-----Left: submenu start---->
<div id="left_bg">
  <ul>
    <li class="leftbu"><a href="firewall.asp">Firewall</a></li>
    <li class="leftbu"><a href="advanced_ddns.asp">DDNS</a></li>
    <li class="leftbu"><a href="nat_general.asp">NAT</a></li>
	<li class="leftbu"><a href="advanced_staticroute.asp">Static Routing</a></li>	
	<!--
    <li class="leftbu"><a href="ipv6.asp">IPv6</a></li>
    -->
    <li class="leftbu"><a href="vpn.asp">Virtual Private Network</a></li>       
    <li class="leftbu"><a href="sms_newsms.asp">Short Message</a>
     <dl>
       <dd class="ddbu"><a href="sms_newsms.asp">New SMS</a></dd>
       <dd class="ddbu"><a href="sms_inbox.asp">Inbox</a></dd>
       <dd class="ddbu"><a href="sms_outbox.asp">Outbox</a></dd>
       <dd class="ddbuhover">Draftbox</dd>
       <dd class="ddbu"><a href="sms_simsms.asp">SMS on SIM Card</a></dd>
       <dd class="ddbu"><a href="sms_setting.asp">SIM Setting</a></dd>       
     </dl>  
    </li>
    <li class="leftbu"><a href="dlna.asp" id="app_dlna">DLNA</a></li>   
    <li class="leftbu"><a href="usb_storage.asp" id="app_usb">USB Storage</a></li>    
    <li class="leftbu"><a href="QoSPolicy.asp">QoS</a></li>
  </ul>
</div>
<!-----Left: submenu end-->
 

<!-- Right Content start -->
<div id="content_all">
  <div id="content_bg01"><script>document.write(gettext("SMS Draftbox"));</script></div>
  <div id="content_bg02">

  <div id="get_sms_draft_info">	
  <input type="button" value="Delete All" id="draft_delete_all" name="draft_delete_all" class="submit_s" style="margin:5px 10px 5px 20px" />
  <span id="short_draft_total_num"></span>/250
    <table class="listable" border="0" cellpadding="0" cellspacing="0" style="margin:0 0 40px 20px; width:680px;">
    <tr>
      <th width="40" style="padding:0;"></th>
      <th width="100"><script>document.write(gettext("Receiver"));</script></th>
      <th width=""><script>document.write(gettext("Content"));</script></th>
      <th width="60" style="border-right:1px none;"><script>document.write(gettext("Action"));</script></th>      
    </tr>
    <tbody id="sms_draft_table"></tbody>        
    </tbody>      
  </table>
  </div>
  
  </div><!-- content_bg02 end -->

</div><!-- content_all end -->

</div> <!-- all end -->

<!-- sms draft start -->
<div id="application_short_draft_mask" class="mask"></div>
<div class="pop_outline" id="application_short_draft_popup_add" style="display:none; margin-top:-219px;">
  
  <div class="popup">
  <h3><script>document.write( gettext("short message details") );</script></span></td></h3>
  <div class="popup_close"><a onclick="this.className = application_draft_popup_close();"></a></div>
  <div style="padding: 30px 40px;">
  <table width="100%" border="0" cellpadding="0">
    <tr>
      <td class="popup_text" style="margin-bottom:0; line-height:30px;"><script>document.write( gettext("sent to") );</script>&nbsp;:</td>
      <td class="Text_gray" id="draft_sent_to" ></td>
    </tr>
    <tr>
      <td colspan="2" class="popup_text" style="padding-top:15px;"><script>document.write( gettext("content") );</script>&nbsp;:</td>
    </tr>
    <tr>
      <td colspan="2">
      <textarea class="popup_box" name="draft_sent_content" id="draft_sent_content" style="height:100px; resize:none; width:400px;" readonly="readonly"></textarea></td>
    </tr>
    <tr>
      <td colspan="2" height="30">
       <input type="button" id="draft_received_delete" value="delete" class="grayBN" onclick="this.className = 'grayBN'"/></td>
    </tr>
    <tr>
      <td colspan="2">
        <hr />
        <input type="button" id="draft_received_previous" value="< previous" class="submit" />
        <input type="button" id="draft_received_next" value="next >" class="submit" />
      </td>
    </tr>
  </table>
  </div>
  </div>
</div>
<!--sms draft end -->

<!-- draft edit start -->
<div class="pop_outline" id="application_short_draft_popup_edit" style="display:none; margin-top:-219px;">
  
  <div class="popup">
  <h3><script>document.write( gettext("short message details") );</script></span></td></h3>
  <div class="popup_close"><a onclick="this.className = application_draft_edit_popup_close();"></a></div>
  <div style="padding: 30px 40px;">
  <table width="100%" border="0" cellpadding="0">
    <tr>
      <td class="popup_text" style="margin-bottom:0; line-height:30px;"><script>document.write( gettext("sent to") );</script>&nbsp;:</td>		      	
    </tr>
    <tr style="text-align:left;">
    	<td>
		<input id="sms_draft_edit_to" name="sms_draft_edit_to" style="width:400px;" type="text" maxLength="630" >
		</td>
    <tr/>
    <tr>
      <td colspan="2" class="popup_text" style="padding-top:15px;"><script>document.write( gettext("content") );</script>&nbsp;:</td>
    </tr>
    <tr>
      <td colspan="2">
      <textarea class="popup_box" 
      			name="sms_draft_edit_content" 
      			id="sms_draft_edit_content" 
      			maxLength="1000" 
      			style="height:100px; resize:none; width:400px;"
		    	onkeyup="textarea_maxlen_isMax('sms_draft_edit_content')" 
				onfocus="textarea_maxlen_disabledRightMouse()" 
				onblur="textarea_maxlen_enabledRightMouse()" 
				onkeypress="return checkMaxLength('sms_draft_edit_content',1000)"      			
      >
      </textarea>
      </td>      
    </tr>
    <tr>
      <td colspan="2">
        <hr />
        <input type="button" id="sms_draft_edit_apply" value="Apply" class="submit" />
        <input type="button" id="sms_draft_edit_cancel" value="Discard" class="submit" onclick="doRedirect();" />
      </td>
    </tr>
  </table>
  </div>
  </div>
</div>
<!-- draft edit end -->

<!-- Apply Progress -->
<div id="progressMask" class="progressMask"></div>
<div id="progressImg" class="progressImg" >
  <img src="/images/common/progress.gif" alt="Loading..." />
</div>

</body>
<script type="text/javascript">
document.getElementById('draft_delete_all').value=gettext("Delete All");	
document.getElementById('draft_received_delete').value=gettext("delete");
document.getElementById('draft_received_previous').value=gettext("< previous");
document.getElementById('draft_received_next').value=gettext("next >");
document.getElementById('sms_draft_edit_apply').value=gettext("Apply");	
document.getElementById('sms_draft_edit_cancel').value=gettext("Discard");
</script>
</html>
