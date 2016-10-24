<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>NEW IAD</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="../style/styles.css" type="text/css" />
</head>
<script language="javascript" type="text/javascript">
function getTR69Info()
{
  var TR69Enable = "<%getTR69Enable();%>";
	  
  if (TR69Enable == "1"){
	document.getElementById("tr69_en").checked = true;
  }else{
	document.getElementById("tr69_en").checked = false;
  }
}
function getTR69Data()
{
  var TR69Data = "<%getTR69Data();%>";
	  
  if (TR69Data == "usb0"){
	document.getElementById("interface_set").selectedIndex = 0;
  }else if (TR69Data == "usb1"){
	document.getElementById("interface_set").selectedIndex = 1;
  }
}
function TR69Disable(state)
{   
  document.getElementById("tr69_en").checked = state;
}

function submitActionTR69()
{
  if (document.getElementById("tr69_en").checked == false){
     document.getElementById("tr69_en").value = "off";
  }else{
     document.getElementById("tr69_en").value = "on";
	 if (document.getElementById("acsURL").value == ""){
	 	alert("Please input ACS server URL");
		return false;
	 }
  }  
  document.lan_basic.action="/goform/setCWMPSettings";
  return true;
}

</script>

<body id="TR69Page" onload="getTR69Info();getTR69Data();">
<div id="center_bg">

<!-- Main Menu start -->
<%writeTopMenu();%>
<%writeMainMenu();%>
<script language="JavaScript">menuChange("sys_menu");</script>
<!-- Main Menu end -->

<div id="content_page">

<!-- Left Menu start -->
    <div id="left_menu_super" class="leftmenu_bg">
    <div>
      <ul class="leftMenu">
        <li class="leftmenu_focused">
          <a href="#">Tr-69</a>
        </li>
      </ul>
    </div>
  </div>
    <div id="left_menu_tr69"></div>
<!-- Left Menu end -->

<!-- Right Content start -->
<div id="right_page">
<div class="right_content">
  <h1>Tr-69 Settings</h1>
  <!--p class="text_page_describe">(TBD)</p-->
  <hr/>
  <form name="lan_basic" method="post">
    <table border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 20px;">
      <tr><td>
        <label for="" class="text_gray">Enable</label>
        <input name="tr69_en" id="tr69_en" type="checkbox" style="margin-left:10px;" checked=false onclick="TR69Disable(this.checked);"/>
      </td></tr>
      <tr>
        <td><label for="provisioningCode" class="text_gray" >Device provisioning Code</label></td>
        <td><input class="box" id="provisioningCode" name="provisioningCode" type="text" size="20" value="<%getCWMPSettings("provisioningCode");%>"/></td>
      </tr>
      <tr>
        <td><label for="acsURL" class="text_gray" >ACS Server URL</label></td>
        <td><input class="box" id="acsURL" name="acsURL" type="text" size="50" value="<%getCWMPSettings("acsURL");%>"/></td>
      </tr>
      <tr>
        <td><label for="username" class="text_gray" >Username</label></td>
        <td><input class="box" id="username" name="username" type="text" size="20" value="<%getCWMPSettings("username");%>" /></td>
      </tr>
      <tr>
        <td><label for="password" class="text_gray" >Password</label></td>
        <td><input class="box" id="password" name="password" type="text" size="20" value="<%getCWMPSettings("password");%>" /></td>
      </tr>
      <tr>
        <td><label for="cruUsername" class="text_gray" >Connection Request Username</label></td>
        <td><input class="box" id="cruUsername" name="cruUsername" type="text" size="20" value="<%getCWMPSettings("cruUsername");%>" /></td>
      </tr>
      <tr>
        <td><label for="cruPassword" class="text_gray" >Connection Request Password</label></td>
        <td><input class="box" id="cruPassword" name="cruPassword" type="text" size="20" value="<%getCWMPSettings("cruPassword");%>" /></td>
      </tr>
      <tr>
        <td><label for="certPassword" class="text_gray" >Client Certificate Password</label></td>
        <td><input class="box" id="certPassword" name="certPassword" type="text" size="20" value="<%getCWMPSettings("certPassword");%>" /></td>
      </tr>
    </table>

    <div style="margin:10px 0 0;">
      <label for="" class="text_gray">Enable STUN</label>
      <input type="checkbox">
    </div>
    
    <table border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 20px;">
      <tr>
        <td><label for="stunURL" class="text_gray" >STUN Server</label></td>
        <td><input class="box" id="stunURL" name="stunURL" type="text" size="20" value="<%getCWMPSettings("stunURL");%>" /></td>
      </tr>
      <tr>
        <td><label for="stunUsername" class="text_gray" >STUN Usename</label></td>
        <td><input class="box" id="stunUsername" name="stunUsername" type="text" size="20" value="<%getCWMPSettings("stunUsername");%>" /></td>
      </tr>
      <tr>
        <td><label for="stunPassword" class="text_gray" >STUN Password</label></td>
        <td><input class="box" id="stunPassword" name="stunPassword" type="text" size="20" value="<%getCWMPSettings("stunPassword");%>" /></td>
      </tr>
    </table>

    <div style="margin:10px 0 0;">
    <table><tr>
      <td><label class="text_gray">Interface Setting</label></td>
      <td><select class="box" name="interface_set" id="interface_set" style="width:180px;">
        <option value="usb0">USB 0</option>
        <option value="usb1">USB 1</option>
      </select></td>
    </tr></table>
    </div>

    <div style="margin:10px 0 0;">
    <table><tr>
      <td><label class="text_gray">Port</label></td>
      <td><input class="box" id="port" name="port" type="text" size="10" value="<%getPort();%>"/></td>
    </tr></table>
    </div>

    <!-- Button start -->
    <div class="submitBg">
      <input type="submit" value="Apply" class="Apply" onclick="return submitActionTR69(this);"/>
      <input type="reset" value="Discard" class="submit" onclick="doRedirect();"/>
    </div>
    <!-- Button end -->
  </form>
  </div><!-- right_content end -->
</div><!-- right_page end -->
</div><!-- content_page end -->
</div><!-- center_bg end -->
</body>
</html>
