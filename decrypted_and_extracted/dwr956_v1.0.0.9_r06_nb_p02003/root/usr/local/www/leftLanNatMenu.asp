<div id="left_bg">
  <ul>
   <li class="leftbu" id="lan_clientlist"><a href="#" onclick="RedirectSubMenu('lan_clientlist');" id="lan_clientlist_href"><script>document.write(gettext("Device List"));</script></a></li>
   <li class="leftbu" id="lan_settings"><a href="#" onclick="RedirectSubMenu('lan_settings');" id="lan_settings_href"><script>document.write(gettext("LAN Settings"));</script></a></li>
   <li class="leftbu" id="dhcp_submenu_focus"><a href="#" onclick="RedirectSubMenu('lan_dhcpserver');" id="dhcp_submenu_focus_href"><script>document.write(gettext("DHCP"));</script></a></li>
     <dl style="display:none;" id="dhcp_submenu">
      <dd class="ddbu" id="lan_dhcpserver"><a href="#" onclick="RedirectSubMenu('lan_dhcpserver');" id="lan_dhcpserver_href">&#45;<script>document.write(gettext("Basic"));</script></a></dd>
      <dd class="ddbu" id="lan_ipreservation"><a href="#" onclick="RedirectSubMenu('lan_ipreservation');" id="lan_ipreservation_href">&#45;<script>document.write(gettext("DHCP Reservation"));</script></a></dd>
     </dl>
  </ul>
</div>
