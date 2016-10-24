<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>NEW IAD</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="../style/styles.css" type="text/css" />
     <script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>

</head>

<body>
<div id="center_bg">

<!-- Main Menu start -->
<%writeTopMenu();%>
<%writeMainMenu();%>
<script language="JavaScript">menuChange("wifi_menu");</script>
<!-- Main Menu end -->

<div id="content_page">

<!-- Left Menu start -->
    <div id="left_menu_wifi" class="leftmenu_bg">
    <div>
      <ul class="leftMenu">
        <li class="">
          <a href="../wifi/wifi_clientlist.html">Wi-Fi Client List</a>
        </li>
        <li class="">
          <a href="../wifi/wifi_settings.html">Wi-Fi Settings</a>
        </li>
        <li class="">
          <a href="../wifi/wifi_acl.html" >Access Control</a>
        </li>
        <li class="">
          <a href="../wifi/wifi_clientmode.html" >Client Mode</a>
        </li>
        <li class="leftmenu_focused">
          <a href="#" >Tr-69</a>
        </li>
      </ul>
    </div>
  </div>
    <div id="left_menu_wifi_tr69"></div>
<!-- Left Menu end -->

<!-- Right Content start -->
<div id="right_page">
    <div class="right_content">
  <h1>Tr-69 Settings</h1>
  <p class="text_page_describe">(TBD)</p>
  <hr />
    <table border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 20px;">
    <tr>
      <td>
        <label for="" class="text_gray" >Device provisioning Code</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
    <tr>
      <td>
        <label for="" class="text_gray" >ACS Server URL</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="50" /></td>
    </tr>
    <tr>
      <td>
        <label for="" class="text_gray" >Username</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
    <tr>
      <td>
        <label for="" class="text_gray" >Password</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
    <tr>
      <td>
        <label for="" class="text_gray" >Connection Request Username</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
    <tr>
      <td>
        <label for="" class="text_gray" >Connection Request Password</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
    <tr>
      <td>
        <label for="" class="text_gray" >Client Certificate Password</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
  </table>

  <div style="margin:10px 0 0;">
    <label for="" class="text_gray">Enable STUN</label>
    <input type="checkbox">
  </div>
  <table border="0" cellpadding="0" cellspacing="0" style="margin:10px 0 0 20px;">
    <tr>
      <td>
        <label for="" class="text_gray" >STUN Server</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
    <tr>
      <td>
        <label for="" class="text_gray" >STUN Usename</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
    <tr>
      <td>
        <label for="" class="text_gray" >STUN Password</label></td>
      <td>
        <input class="box" id="" name="" type="text" size="20" /></td>
    </tr>
  </table>

<!-- Button start -->
    <div class="submitBg">
        <input type="button" value="Apply" class="submit" />
        <input type="submit" value="Discard" class="submit" onclick="doRedirect();" />
    </div><!-- Button end -->

  </div><!-- right_content end -->

</div><!-- right_page end -->

</div><!-- content_page end -->
</div><!-- center_bg end -->
</body>
</html>
