<div class="mainMenuBg1"></div>
<div class="mainMenuBg2">
 <table width="1000" border="0" cellspacing="0" cellpadding="0">
  <tr>
   <td width="230" height="121"><img src="../images/menu/Top_Logo.jpg" width="230" height="121" /></td>
   <td width="42" height="121"><img src="../images/menu/Top_Menu_Left.jpg" width="42" height="121" /></td>
   <td width="728" height="121" style="background:url(../images/menu/Top_BG.png) no-repeat;">
    <table border="0" cellspacing="0" cellpadding="0">
     <tr>
      <td width="60" height="121" id="home_menu" class="topMenuTd_Home">
       <a href="#" onclick="RedirectMainMenu('home');" id="home_menu_href" class="topMenuTd_Home_Href">
        <img src="../images/menu/Top_Menu_Home.png" border="0" id="home_menu_img" class="topMenuTd_Home_Img" />
        <script>document.write(gettext("Home"));</script>
       </a>
      </td>
      <td width="27" class="mainMenuBg2_bg"></td>
      <td width="60" id="lte_menu" class="topMenuTd_Internet">
       <a href="#" onclick="RedirectMainMenu('internet/internet_status');" id="lte_menu_href" class="topMenuTd_Internet_Href">
        <img src="../images/menu/Top_Menu_Internet.png" border="0" id="lte_menu_img" class="topMenuTd_Internet_Img" />
        <script>document.write(gettext("Internet"));</script>
       </a>
      </td>
      <td width="27" class="mainMenuBg2_bg"></td>
      <td width="60" id="wifi_menu" class="topMenuTd_Wifi">
       <a href="#" onclick="RedirectMainMenu('wifi/wifi_clientlist');" id="wifi_menu_href" class="topMenuTd_Wifi_Href">
        <img src="../images/menu/Top_Menu_Wifi.png" border="0" id="wifi_menu_img" class="topMenuTd_Wifi_Img" />
        <script>document.write(gettext("Wi-Fi"));</script>
       </a>
      </td>
      <td width="27" class="mainMenuBg2_bg"></td>
      <td width="60" id="lan_menu" class="topMenuTd_Lan">
       <a href="#" onclick="RedirectMainMenu('lan/lan_clientlist');" id="lan_menu_href" class="topMenuTd_Lan_Href">
        <img src="../images/menu/Top_Menu_Lan.png" border="0" id="lan_menu_img" class="topMenuTd_Lan_Img" />
        <script>document.write(gettext("LAN"));</script>
       </a>
      </td>
      <td width="27" class="mainMenuBg2_bg"></td>

      <td width="60" id="adv_menu" class="topMenuTd_Advanced">
      	<!-- if natStatus == "5" then go to ../advanced/nat_general.asp -->

       <a href="#" onclick="RedirectMainMenu('advanced/nat_general');" id="adv_menu_href" class="topMenuTd_Advanced_Href">
        <img src="../images/menu/Top_Menu_Advanced.png" border="0" id="adv_menu_img" class="topMenuTd_Advanced_Img" />
        <script>document.write(gettext("Advanced"));</script>
       </a>
      </td>
      <td width="27" class="mainMenuBg2_bg"></td>
      <td width="60" id="sys_menu" class="topMenuTd_System">
       <a href="#" onclick="RedirectMainMenu('system/system_time');" id="sys_menu_href" class="topMenuTd_System_Href">
        <img src="../images/menu/Top_Menu_System.png" border="0" id="sys_menu_img" class="topMenuTd_System_Img" />
        <script>document.write(gettext("System"));</script>
       </a>
      </td>
      <td width="67" height="121"><img src="../images/menu/Top_Menu_Right.png" width="67" height="121" /></td>

      <td width="87">&nbsp;</td>
      <td width="79" height="121" align="left" valign="top" style="background:url(../images/menu/Top_Right_Bg.jpg) no-repeat;">
        <table width="79" border="0" cellspacing="0" cellpadding="0">
           <tr><td height="10"></td></tr>
           <tr>
            <td height="25">
              <a class="Top_TopBar" id="helpLink" href="#"><script>document.write(gettext("Help"));</script></a>
            </td>
           </tr>
           <tr>
            <td height="25">
              <form method="post" name="top_logout_form" action="/goform/user_logout">
                <input type="hidden" name="top_logout_dummy" value="0" />
                <a class="Top_TopBar" href="#" id="top_logout" onclick="logout();"><script>document.write(gettext("Logout"));</script></a>
              </form>
            </td>
           </tr>
           <tr>
            <td height="25"><a class="Top_TopBar" href="#" onclick="doRedirect();"><script>document.write(gettext("Refresh"));</script></a></td>
           </tr>
         </table>
       </td>

     </tr>
    </table>
   </td>
  </tr>
 </table>
</div>

<script language="javascript" type="text/javascript">
var path_name = window.location.pathname;
var file_name = path_name.substring(path_name.lastIndexOf("/")+1, path_name.indexOf(".")) + ".htm";
var help_link = "../help/help_" + file_name;
document.getElementById('helpLink').href="JavaScript:pop(\'" + help_link + "\')";
</script>
