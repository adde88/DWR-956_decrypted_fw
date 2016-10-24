<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>NEW IAD</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);

var ip_rule_V6=/^([\da-fA-F]{1,4}:){6}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^::([\da-fA-F]{1,4}:){0,4}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:):([\da-fA-F]{1,4}:){0,3}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){2}:([\da-fA-F]{1,4}:){0,2}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){3}:([\da-fA-F]{1,4}:){0,1}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){4}:((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){7}[\da-fA-F]{1,4}$|^:((:[\da-fA-F]{1,4}){1,6}|:)$|^[\da-fA-F]{1,4}:((:[\da-fA-F]{1,4}){1,5}|:)$|^([\da-fA-F]{1,4}:){2}((:[\da-fA-F]{1,4}){1,4}|:)$|^([\da-fA-F]{1,4}:){3}((:[\da-fA-F]{1,4}){1,3}|:)$|^([\da-fA-F]{1,4}:){4}((:[\da-fA-F]{1,4}){1,2}|:)$|^([\da-fA-F]{1,4}:){5}:([\da-fA-F]{1,4})?$|^([\da-fA-F]{1,4}:){6}:$/;
var ip_rule=/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;


function v6Type()
{
	var v6type = document.IPV6_FORM.IPV6_TYPE.value;

	document.getElementById("ipv6_table").style.display = "";
	document.getElementById("ipv6_lan").style.display = "";	
	document.getElementById("ipv6_dns").style.display = "";
	document.getElementById("ipv6_network").style.display = "";
	if (v6type == "static_dual")
	{
		
		document.getElementById("ipv6_wan").style.display = "";
		document.getElementById("wan_ipv6addr").style.display = "";
		document.getElementById("dyna_wan_ipv6addr").style.display = "none";
		document.getElementById("wan_ipv6prefix").style.display = "";
		document.getElementById("wan_ipv6gw").style.display = "";
		document.getElementById("pppoev6").style.display = "none";		
		document.getElementById("ip6in4").style.display = "none";
		document.getElementById("ip6to4").style.display = "none";
		document.getElementById("ip6rd").style.display = "none";		
		document.getElementById("dhcppd").style.display = "none";
		document.getElementById("lan_globalipv6").style.display = "none";
		document.getElementById("v6dns").style.display = "none";
		document.getElementById("ip6in4_gogoc").style.display = "none";
		
		ip6dslite();
	}
	else if (v6type == "dyna_dual")
	{		
		document.getElementById("ipv6_wan").style.display = "";
		document.getElementById("wan_ipv6addr").style.display = "none";
		document.getElementById("dyna_wan_ipv6addr").style.display = "";
		document.getElementById("wan_ipv6prefix").style.display = "none";
		document.getElementById("wan_ipv6gw").style.display = "none";
		document.getElementById("pppoev6").style.display = "none";		
		document.getElementById("ip6in4").style.display = "none";		
		document.getElementById("ip6to4").style.display = "none";
		document.getElementById("ip6rd").style.display = "none";		
		document.getElementById("dhcppd").style.display = "";
		document.getElementById("lan_globalipv6").style.display = "";
		document.getElementById("v6dns").style.display = "";
		document.getElementById("ip6in4_gogoc").style.display = "none";

		ip6dslite();
	}
	else if (v6type == "pppoe")
	{	
		document.getElementById("ipv6_wan").style.display = "none";
		document.getElementById("wan_ipv6addr").style.display = "none";
		document.getElementById("dyna_wan_ipv6addr").style.display = "none";
		document.getElementById("wan_ipv6prefix").style.display = "none";
		document.getElementById("wan_ipv6gw").style.display = "none";
		document.getElementById("pppoev6").style.display = "";		
		document.getElementById("ip6in4").style.display = "none";		
		document.getElementById("ip6to4").style.display = "none";
		document.getElementById("ip6rd").style.display = "none";		
		document.getElementById("dhcppd").style.display = "";
		document.getElementById("lan_globalipv6").style.display = "";
		document.getElementById("v6dns").style.display = "";
		document.getElementById("ip6in4_gogoc").style.display = "none";
	}
	else if (v6type == "6in4")
	{	
		document.getElementById("ipv6_wan").style.display = "none";
		document.getElementById("ipv6_wan").style.display = "none";
		document.getElementById("wan_ipv6addr").style.display = "none";
		document.getElementById("dyna_wan_ipv6addr").style.display = "none";
		document.getElementById("wan_ipv6prefix").style.display = "none";
		document.getElementById("wan_ipv6gw").style.display = "none";
		document.getElementById("pppoev6").style.display = "none";		
		document.getElementById("ip6in4").style.display = "";		
		document.getElementById("ip6to4").style.display = "none";
		document.getElementById("ip6rd").style.display = "none";
		document.getElementById("dhcppd").style.display = "none";
		document.getElementById("lan_globalipv6").style.display = "none";
		document.getElementById("v6dns").style.display = "none";
		document.getElementById("ip6in4_gogoc").style.display = "none";
	}
	else if (v6type == "6to4")
	{		
		document.getElementById("ipv6_wan").style.display = "none";
		document.getElementById("wan_ipv6addr").style.display = "none";
		document.getElementById("dyna_wan_ipv6addr").style.display = "none";
		document.getElementById("wan_ipv6prefix").style.display = "none";
		document.getElementById("wan_ipv6gw").style.display = "none";
		document.getElementById("pppoev6").style.display = "none";		
		document.getElementById("ip6in4").style.display = "none";		
		document.getElementById("ip6to4").style.display = "";
		document.getElementById("ip6rd").style.display = "none";		
		document.getElementById("dhcppd").style.display = "none";
		document.getElementById("lan_globalipv6").style.display = "";
		document.getElementById("v6dns").style.display = "none";
		document.getElementById("ip6in4_gogoc").style.display = "none";
	}
	else if (v6type == "6rd")
	{		
		document.getElementById("ipv6_wan").style.display = "none";
		document.getElementById("wan_ipv6addr").style.display = "none";
		document.getElementById("dyna_wan_ipv6addr").style.display = "none";
		document.getElementById("wan_ipv6prefix").style.display = "none";
		document.getElementById("wan_ipv6gw").style.display = "none";
		document.getElementById("pppoev6").style.display = "none";		
		document.getElementById("ip6in4").style.display = "none";		
		document.getElementById("ip6to4").style.display = "none";
		document.getElementById("ip6rd").style.display = "";		
		document.getElementById("dhcppd").style.display = "none";
		document.getElementById("lan_globalipv6").style.display = "";
		document.getElementById("v6dns").style.display = "none";
		document.getElementById("ip6in4_gogoc").style.display = "none";
	}
	else if (v6type == "gogoc")
	{
		document.getElementById("ipv6_wan").style.display = "none";
		document.getElementById("ipv6_wan").style.display = "none";
		document.getElementById("wan_ipv6addr").style.display = "none";
		document.getElementById("dyna_wan_ipv6addr").style.display = "none";
		document.getElementById("wan_ipv6prefix").style.display = "none";
		document.getElementById("wan_ipv6gw").style.display = "none";
		document.getElementById("pppoev6").style.display = "none";		
		document.getElementById("ip6in4").style.display = "none";		
		document.getElementById("ip6to4").style.display = "none";
		document.getElementById("ip6rd").style.display = "none";
		document.getElementById("dhcppd").style.display = "none";
		document.getElementById("lan_globalipv6").style.display = "none";
		document.getElementById("v6dns").style.display = "none";		
		document.getElementById("ip6in4_gogoc").style.display = "";		
	}
}
function IPV6_Undisplay()
{
	document.getElementById("ipv6_table").style.display = "none";
	document.getElementById("ipv6_wan").style.display = "none";	
	document.getElementById("wan_ipv6addr").style.display = "none";
	document.getElementById("dyna_wan_ipv6addr").style.display = "none";
	document.getElementById("wan_ipv6prefix").style.display = "none";
	document.getElementById("wan_ipv6gw").style.display = "none";
	document.getElementById("pppoev6").style.display = "none";		
	document.getElementById("ip6in4").style.display = "none";		
	document.getElementById("ip6to4").style.display = "none";	
	document.getElementById("ip6rd").style.display = "none";
	document.getElementById("ipv6_lan").style.display = "none";	
	document.getElementById("dhcppd").style.display = "none";
	document.getElementById("lan_globalipv6").style.display = "none";	
	document.getElementById("ipv6_dns").style.display = "none";
	document.getElementById("v6dns").style.display = "none";
	document.getElementById("ipv6_network").style.display = "none";	
	document.getElementById("ip6in4_gogoc").style.display = "none";
}
function v6Enable(ele)
{		
	switch(ele.value)
    {
        case "off": 
			document.IPV6_FORM.IPV6_ENABLE.value="off";
			IPV6_Undisplay();
			break;
		case "on": 
			document.IPV6_FORM.IPV6_ENABLE.value="on";
			v6Type();
			break;
	}	
}

function ip6dslite()
{
	if (document.IPV6_FORM.DSLITE.options.selectedIndex == 0)
	{
		document.getElementById("dsl_cgnv6").style.display = "";
		document.getElementById("dsl_cgnv4").style.display = "";
		document.getElementById("b4_addr").style.display = "";
	}
	else
	{
		document.getElementById("dsl_cgnv6").style.display = "none";
		document.getElementById("dsl_cgnv4").style.display = "none";
		document.getElementById("b4_addr").style.display = "none";
	}
}

function ip6rdConfig(ele)
{
	switch(ele.value)
    {
        case "dhcp": 
			document.getElementById("ip6rdprefix").style.display = "none";
			document.getElementById("ip6rdprefixlen").style.display = "none";			
			document.getElementById("ip6rdrelay").style.display = "none";
			break;
		case "static": 
			document.getElementById("ip6rdprefix").style.display = "";
			document.getElementById("ip6rdprefixlen").style.display = "";			
			document.getElementById("ip6rdrelay").style.display = "";
			break;
	}	
}

function pppoev6addr(ele)
{
	switch(ele.value)
    {
        case "dynamic": 
			document.getElementById("pppoe_v6addr_dyn").style.display = "";
			document.getElementById("pppoe_v6addr").style.display = "none";
			break;
		case "static": 
			document.getElementById("pppoe_v6addr_dyn").style.display = "none";
			document.getElementById("pppoe_v6addr").style.display = "";
			break;
	}	
}

function lanv6dhcppd(ele)
{
	switch(ele.value)
    {
        case "on": 
			document.getElementById('lan_ipv6addr').disabled=true;
			document.getElementById('ap_ipaddr_v6').disabled=true;
			document.getElementById("lan_globalipv6").style.display = "";
			break;
		case "off": 
			document.getElementById('lan_ipv6addr').disabled=false;
			document.getElementById('ap_ipaddr_v6').disabled=false;
			document.getElementById("lan_globalipv6").style.display = "none";
			break;
	}	
}

function lanv6DNS(ele)
{
	switch(ele.value)
    {
        case "on": 
			document.getElementById('wan_ipv6pridns').disabled=true;
			document.getElementById('wan_ipv6secdns').disabled=true;
			document.getElementById('WAN_IPV6PRIDNS_input').disabled=true;
			document.getElementById('WAN_IPV6SECDNS_input').disabled=true;	
			break;
		case "off": 
			document.getElementById('wan_ipv6pridns').disabled=false;
			document.getElementById('wan_ipv6secdns').disabled=false;
			document.getElementById('WAN_IPV6PRIDNS_input').disabled=false;
			document.getElementById('WAN_IPV6SECDNS_input').disabled=false;			
			break;
	}	
}

function lanv6Config(ele)
{
	switch(ele.value)
    {
        case "off": 
			document.getElementById('lan_v6_type_sel').disabled=true;
			document.getElementById('lan_dhcpv6start').disabled=true;
			document.getElementById('LAN_DHCPV6START_input').disabled=true;
			document.getElementById('lan_dhcpv6end').disabled=true;
			document.getElementById('LAN_DHCPV6END_input').disabled=true;
			document.getElementById('ra_lifetime').disabled=true;
			document.getElementById('RA_LIFETIME_input').disabled=true;
			break;
		case "on": 
			document.getElementById('lan_v6_type_sel').disabled=false;
			document.getElementById('lan_dhcpv6start').disabled=false;
			document.getElementById('LAN_DHCPV6START_input').disabled=false;
			document.getElementById('lan_dhcpv6end').disabled=false;
			document.getElementById('LAN_DHCPV6END_input').disabled=false;
			document.getElementById('ra_lifetime').disabled=false;
			document.getElementById('RA_LIFETIME_input').disabled=false;
			break;
	}	
}

function lanv6Type()
{
	if (document.IPV6_FORM.LAN_V6_TYPE.options.selectedIndex == 2)
	{
		document.getElementById("lan_dhcpv6start").style.display = "";
		document.getElementById("lan_dhcpv6end").style.display = "";
	}
	else
	{
		document.getElementById("lan_dhcpv6start").style.display = "none";
		document.getElementById("lan_dhcpv6end").style.display = "none";
	}
}

function gogocAuth(ele)
{
	switch(ele.value)
    {
        case "anonymous": 
			document.getElementById('GOGOC_USERID').disabled=true;
			document.getElementById('GOGOC_PASSWD').disabled=true;
			break;
		case "any": 
			document.getElementById('GOGOC_USERID').disabled=false;
			document.getElementById('GOGOC_PASSWD').disabled=false;		
			break;
	}	
}

function loadIPV6Page()
{
	var v6_sw = <%getConf("IPV6_ENABLE");%>;
	var dslite_sw = <%getConf("DSLITE");%>;
	var v6rd_conf = <%getConf("IP6RD_CONFIG");%>;
	var pppoe_conf = <%getConf("PPPOE_ADDR");%>;
	var dhcppd_sw = <%getConf("DHCPPD_ENABLE");%>;
	var v6dns_sw = <%getConf("LAN_V6_DNS");%>;
	var lanv6_conf = <%getConf("LAN_V6_CONFIG");%>;
	var lanv6_type = <%getConf("LAN_V6_TYPE");%>;
	var gogoc_auth = <%getConf("GOGOC_AUTH_METHOD");%>;
	var ipv6_type = <%getConf("IPV6_TYPE");%>;
	
	if (v6_sw == "off")
	{
		document.IPV6_FORM.IPV6_ENABLE.value="off";
		document.getElementById('ipv6_on').checked = false;
		document.getElementById('ipv6_off').checked = true;
		IPV6_Undisplay();
	}
	else if (v6_sw == "on")
	{
		document.IPV6_FORM.IPV6_ENABLE.value="on";
		document.getElementById('ipv6_on').checked = true;
		document.getElementById('ipv6_off').checked = false;		
		document.IPV6_FORM.IPV6_TYPE.value=ipv6_type;
		v6Type();				
	}

	document.IPV6_FORM.IPV6_TYPE.value = ipv6_type;
	document.IPV6_FORM.LAN_V6_TYPE.value = lanv6_type;
	document.IPV6_FORM.IP6RD_CONFIG.value = v6rd_conf;
	
	document.IPV6_FORM.LAN_DHCPV6START.value = <%getConf("LAN_DHCPV6START");%>;
	document.IPV6_FORM.LAN_DHCPV6END.value = <%getConf("LAN_DHCPV6END");%>;		
	document.IPV6_FORM.AP_IPADDR_V6.value = <%getConf("AP_IPADDR_V6");%>;
	document.IPV6_FORM.PREFIX_LEN_V6.value = <%getConf("PREFIX_LEN_V6");%>;
	document.IPV6_FORM.WAN_IPV6PRIDNS.value = <%getConf("WAN_IPV6PRIDNS");%>;
	document.IPV6_FORM.WAN_IPV6SECDNS.value = <%getConf("WAN_IPV6SECDNS");%>;
	document.IPV6_FORM.RA_LIFETIME.value = <%getConf("RA_LIFETIME");%>;
	document.IPV6_FORM.WAN_IPV6ADDR.value = <%getConf("WAN_IPV6ADDR");%>;
	document.IPV6_FORM.WAN_IPV6GW.value = <%getConf("WAN_IPV6GW");%>;
	document.IPV6_FORM.WAN_IPV6PREFIX.value = <%getConf("WAN_IPV6PREFIX");%>;
	document.IPV6_FORM.DSL_CGNV6.value = <%getConf("DSL_CGNV6");%>;
	document.IPV6_FORM.DSL_CGNV4.value = <%getConf("DSL_CGNV4");%>;
	document.IPV6_FORM.B4_ADDR.value = <%getConf("B4_ADDR");%>;
	document.IPV6_FORM.PPPOE_V6ADDR.value = <%getConf("PPPOE_V6ADDR");%>;
	document.IPV6_FORM.WAN_USER.value = <%getConf("WAN_USER");%>;
	document.IPV6_FORM.WAN_PWD.value = <%getConf("WAN_PWD");%>;
	document.IPV6_FORM.IP6IN4REMOTEIP4.value = <%getConf("IP6IN4REMOTEIP4");%>;
	document.IPV6_FORM.IP6IN4REMOTEIP6.value = <%getConf("IP6IN4REMOTEIP6");%>;
	document.IPV6_FORM.IP6IN4LOCALIP6.value = <%getConf("IP6IN4LOCALIP6");%>;
	document.IPV6_FORM.IP6TO4RELAY.value = <%getConf("IP6TO4RELAY");%>;
	document.IPV6_FORM.IP6RDPREFIX.value = <%getConf("IP6RDPREFIX");%>;
	document.IPV6_FORM.IP6RDPREFIXLEN.value = <%getConf("IP6RDPREFIX_LEN");%>;
	document.IPV6_FORM.IP6RDRELAY.value = <%getConf("IP6RDRELAY");%>;
	var lanv6_prefix=<%getIPv6DynamicConf("lanv6prefix");%>;		
	document.getElementById('lanv6prefix_start').innerHTML = lanv6_prefix;
	document.getElementById('lanv6prefix_end').innerHTML = lanv6_prefix;
	document.IPV6_FORM.GOGOC_SERVER.value = <%getConf("GOGOC_SERVER");%>;
	document.IPV6_FORM.GOGOC_AUTH_METHOD.value = gogoc_auth;
	if (gogoc_auth == "anonymous")
	{
		document.getElementById('gogoc_auth_anonymous').checked = true;
		document.getElementById('gogoc_auth_any').checked = false;
	}
	else if (gogoc_auth == "any")
	{
		document.getElementById('gogoc_auth_anonymous').checked = false;
		document.getElementById('gogoc_auth_any').checked = true;		
	}	
	document.IPV6_FORM.GOGOC_USERID.value = <%getConf("GOGOC_USERID");%>;
	document.IPV6_FORM.GOGOC_PASSWD.value = <%getConf("GOGOC_PASSWD");%>;
	
	if (pppoe_conf == "dynamic")
	{
		document.getElementById("pppoe_v6addr_dyn").style.display = "";
		document.getElementById("pppoe_v6addr").style.display = "none";
		document.getElementById('pppoe_dyna').checked = true;
		document.getElementById('pppoe_static').checked = false;			
	}
	else if (pppoe_conf == "static")
	{
		document.getElementById("pppoe_v6addr_dyn").style.display = "none";
		document.getElementById("pppoe_v6addr").style.display = "";	
		document.getElementById('pppoe_dyna').checked = false;
		document.getElementById('pppoe_static').checked = true;			
	}
		
	if (dhcppd_sw == "on")
	{
		document.getElementById('lan_ipv6addr').disabled=true;
		document.getElementById('ap_ipaddr_v6').disabled=true;	
		document.getElementById('dhcppd_on').checked = true;
		document.getElementById('dhcppd_off').checked = false;			
	}
	else if (dhcppd_sw == "off")
	{
		document.getElementById('lan_ipv6addr').disabled=false;
		document.getElementById('ap_ipaddr_v6').disabled=false;										
		document.getElementById('dhcppd_on').checked = false;
		document.getElementById('dhcppd_off').checked = true;						
	}
	if (v6dns_sw == "on")
	{
		document.getElementById('wan_ipv6pridns').disabled=true;
		document.getElementById('wan_ipv6secdns').disabled=true;
		document.getElementById('WAN_IPV6PRIDNS_input').disabled=true;
		document.getElementById('WAN_IPV6SECDNS_input').disabled=true;	
		document.getElementById('lanv6dns_on').checked = true;
		document.getElementById('lanv6dns_off').checked = false;
	}
	else if (v6dns_sw == "off")
	{
		document.getElementById('wan_ipv6pridns').disabled=false;
		document.getElementById('wan_ipv6secdns').disabled=false;
		document.getElementById('WAN_IPV6PRIDNS_input').disabled=false;
		document.getElementById('WAN_IPV6SECDNS_input').disabled=false;	
		document.getElementById('lanv6dns_on').checked = false;
		document.getElementById('lanv6dns_off').checked = true;
	}
	if (lanv6_conf == "off")
	{ 			
		document.getElementById('lan_v6_type_sel').disabled=true;
		document.getElementById('lan_dhcpv6start').disabled=true;
		document.getElementById('LAN_DHCPV6START_input').disabled=true;
		document.getElementById('lan_dhcpv6end').disabled=true;
		document.getElementById('LAN_DHCPV6END_input').disabled=true;
		document.getElementById('ra_lifetime').disabled=true;
		document.getElementById('RA_LIFETIME_input').disabled=true;	
		document.getElementById('lanv6config_on').checked = false;
		document.getElementById('lanv6config_off').checked = true;
	}
	else if (lanv6_conf == "on")
	{
		document.getElementById('lan_v6_type_sel').disabled=false;
		document.getElementById('lan_dhcpv6start').disabled=false;
		document.getElementById('LAN_DHCPV6START_input').disabled=false;
		document.getElementById('lan_dhcpv6end').disabled=false;
		document.getElementById('LAN_DHCPV6END_input').disabled=false;
		document.getElementById('ra_lifetime').disabled=false;
		document.getElementById('RA_LIFETIME_input').disabled=false;				
		document.getElementById('lanv6config_on').checked = true;
		document.getElementById('lanv6config_off').checked = false;			
	}			
	if (v6rd_conf == "dhcp")
	{
		document.getElementById("ip6rdprefix").style.display = "none";
		document.getElementById("ip6rdprefixlen").style.display = "none";
		document.getElementById("ip6rdrelay").style.display = "none";
		document.getElementById('ip6rd_dhcp').checked = true;
		document.getElementById('ip6rd_static').checked = false;			
	}
	else if (v6rd_conf == "static")
	{
		document.getElementById("ip6rdprefix").style.display = "";
		document.getElementById("ip6rdprefixlen").style.display = "";		
		document.getElementById("ip6rdrelay").style.display = "";	
		document.getElementById('ip6rd_dhcp').checked = false;
		document.getElementById('ip6rd_static').checked = true;				
	}		
	if (gogoc_auth == "anonymous")
	{
		document.getElementById('GOGOC_USERID').disabled=true;
		document.getElementById('GOGOC_PASSWD').disabled=true;		
	}
	else if (gogoc_auth == "any")
	{
		document.getElementById('GOGOC_USERID').disabled=false;
		document.getElementById('GOGOC_PASSWD').disabled=false;			
	}

	if (dslite_sw == "on")
		document.IPV6_FORM.DSLITE.options.selectedIndex = 0;
	else if (dslite_sw == "off")	
		document.IPV6_FORM.DSLITE.options.selectedIndex = 1;
	ip6dslite();			
	
	if (lanv6_type == "stateless")
	{
		document.IPV6_FORM.LAN_V6_TYPE.options.selectedIndex = 0;
	}
	else if (lanv6_type == "stateless_dhcp")
	{
		document.IPV6_FORM.LAN_V6_TYPE.options.selectedIndex = 1;
	}
	else if (lanv6_type == "stateful")
	{
		document.IPV6_FORM.LAN_V6_TYPE.options.selectedIndex = 2;
	}
	lanv6Type();	

	var ipv6_wanip = <%getIPv6DynamicConf("ipv6wanip");%>;
	document.getElementById('wan_ipv6wanip').innerHTML = ipv6_wanip;
	document.getElementById('pppoe_ipv6wanip').innerHTML = ipv6_wanip;
	document.getElementById('localip4_wanip').innerHTML = <%getIPv6DynamicConf("wanip");%>;
	document.getElementById('ip6to4addr_ipv6wanip').innerHTML = ipv6_wanip;
	document.getElementById('lanipv6global').innerHTML = <%getIPv6DynamicConf("lanipv6global");%>;
	document.getElementById('lanipv6link').innerHTML = <%getIPv6DynamicConf("lanipv6link");%>;
	
}

function Checkv6TypeRule()
{
	var v6type=document.IPV6_FORM.IPV6_TYPE.value;
	var wan_ipv6=document.IPV6_FORM.WAN_IPV6ADDR.value;
	var wan_ipv6gw=document.IPV6_FORM.WAN_IPV6GW.value;
	var dslv6=document.IPV6_FORM.DSL_CGNV6.value;
	var dslv4=document.IPV6_FORM.DSL_CGNV4.value;
	var dslb4=document.IPV6_FORM.B4_ADDR.value;
	
	var pppoeipv6=document.IPV6_FORM.PPPOE_V6ADDR.value;

	var ip6in4remv4=document.IPV6_FORM.IP6IN4REMOTEIP4.value;
	var ip6in4remv6=document.IPV6_FORM.IP6IN4REMOTEIP6.value;
	var ip6in4localv6=document.IPV6_FORM.IP6IN4LOCALIP6.value;
	
	var pppoeipv6=document.IPV6_FORM.PPPOE_V6ADDR.value;
	
	var ip6to4relay=document.IPV6_FORM.IP6TO4RELAY.value;
	
	var ip6rdpre=document.IPV6_FORM.IP6RDPREFIX.value;
	var ip6rdprelen=document.IPV6_FORM.IP6RDPREFIXLEN.value;
	var ip6rdrelay=document.IPV6_FORM.IP6RDRELAY.value;
	
	var msg;
	
	if (v6type == "static_dual" || v6type == "dyna_dual")
	{		
		if(wan_ipv6!="")
		{
			if(!ip_rule_V6.test(wan_ipv6))
			{
				msg=gettext("IPv6 Address")+ " " + wan_ipv6 +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.WAN_IPV6ADDR.focus();
				return false;
			}
		}
		if(wan_ipv6gw!="")
		{
			if(!ip_rule_V6.test(wan_ipv6gw))
			{
				msg=gettext("IPv6 Gateway Address")+ " " + wan_ipv6gw +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.WAN_IPV6GW.focus();
				return false;
			}
		}
		if(dslv6!="")
		{
			if(!ip_rule_V6.test(dslv6))
			{
				msg=gettext("CGN IPv6 Address")+ " " + dslv6 +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.DSL_CGNV6.focus();
				return false;
			}
		}
		if(dslv4!="")
		{
			if(!ip_rule.test(dslv4))
			{
				msg=gettext("CGN IPv4 Address")+ " " + dslv4 +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.DSL_CGNV4.focus();
				return false;
			}
		}
		if(dslb4!="")
		{
			if(!ip_rule.test(dslb4))
			{
				msg=gettext("B4 IPv4 Address:")+ " " + dslb4 +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.B4_ADDR.focus();
				return false;
			}
		}	
	}
	else if (v6type == "pppoe")
	{
		if(pppoeipv6!="")
		{
			if(!ip_rule_V6.test(pppoeipv6))
			{
				msg=gettext("IPv6 Address")+ " " + pppoeipv6 +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.PPPOE_V6ADDR.focus();
				return false;
			}
		}
	}
	else if (v6type == "6in4")
	{
		if(ip6in4remv4!="")
		{
			if(!ip_rule.test(ip6in4remv4))
			{
				msg=gettext("Remote IPv4 Address")+ " " + ip6in4remv4 +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.IP6IN4REMOTEIP4.focus();
				return false;
			}
		}
		if(ip6in4remv6!="")
		{
			if(!ip_rule_V6.test(ip6in4remv6))
			{
				msg=gettext("Remote IPv6 Address")+ " " + ip6in4remv6 +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.IP6IN4REMOTEIP6.focus();
				return false;
			}
		}
		if(ip6in4localv6!="")
		{
			if(!ip_rule_V6.test(ip6in4localv6))
			{
				msg=gettext("Local IPv6 Address")+ " " + ip6in4localv6 +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.IP6IN4LOCALIP6.focus();
				return false;
			}
		}	
	}
	else if (v6type == "6to4")
	{
		if(ip6to4relay!="")
		{
			if(!ip_rule.test(ip6to4relay))
			{
				msg=gettext("6to4 Relay")+ " " + ip6to4relay +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.IP6TO4RELAY.focus();
				return false;
			}
		}
	}
	else if (v6type == "6rd")
	{
		if(ip6rdpre!="")
		{
			if(!ip_rule_V6.test(ip6rdpre))
			{
				msg=gettext("6rd IPv6 Prefix")+ " " + ip6rdpre +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.IP6RDPREFIX.focus();
				return false;
			}
		}
		if(ip6rdprelen!="")
		{
			var prelen=parseInt(ip6rdprelen,10);
			if (prelen<3 || prelen>64)
			{
				msg=gettext("6rd IPv6 Prefix Length should be between 3 and 64.");
				alert(msg);	
				document.IPV6_FORM.IP6RDPREFIXLEN.focus();
				return false;
			}				
		}
		if(ip6rdrelay!="")
		{
			if(!ip_rule.test(ip6rdrelay))
			{
				msg=gettext("6rd Relay")+ " " + ip6rdrelay +" " +gettext("invalid!");
				alert(msg);
				document.IPV6_FORM.IP6RDRELAY.focus();
				return false;
			}
		}		
	}
	return true;
}

function Checkv6LanRule()
{
	// check lan ip
	var lanv6=document.IPV6_FORM.AP_IPADDR_V6.value;	

	if(lanv6!="")
	{
		if(!ip_rule_V6.test(lanv6))
		{
			msg=gettext("LAN IPv6 Address")+ " " + lanv6 +" " +gettext("is invalid!");
			alert(msg);
			document.IPV6_FORM.AP_IPADDR_V6.focus();
			return false;
		}
	}	
	
	// check lan prefix length
	var lanprefix_len=document.IPV6_FORM.PREFIX_LEN_V6.value;
	var number_rule=/^[0-9]*$/;
	
	if((!number_rule.test(lanprefix_len))||(lanprefix_len==""))
	{
		alert(gettext("LAN prefix length should be number."));
		document.IPV6_FORM.PREFIX_LEN_V6.focus();
		return false;
	}
		
	lanprefix_len = parseInt(lanprefix_len, 10);
	
	if((lanprefix_len<64)||(lanprefix_len>112))
	{
		alert(gettext("LAN prefix length should be between 64 and 112."));
		document.IPV6_FORM.PREFIX_LEN_V6.focus();
		return false;
	}

	return true;
}

function Checkv6DNSRule()
{
	var dnsv6pri=document.IPV6_FORM.WAN_IPV6PRIDNS.value;	
	var dnsv6sec=document.IPV6_FORM.WAN_IPV6SECDNS.value;	

	if(dnsv6pri!="")
	{
		if(!ip_rule_V6.test(dnsv6pri))
		{
			msg=gettext("Primary IPv6 DNS Server")+ " " + dnsv6pri +" " +gettext("invalid!");
			alert(msg);
			document.IPV6_FORM.WAN_IPV6PRIDNS.focus();
			return false;
		}
	}	
	if(dnsv6sec!="")
	{
		if(!ip_rule_V6.test(dnsv6sec))
		{
			msg=gettext("Secondary IPv6 DNS Server")+ " " + dnsv6sec +" " +gettext("invalid!");
			alert(msg);
			document.IPV6_FORM.WAN_IPV6SECDNS.focus();
			return false;
		}
	}	
	return true;
}

function Checkv6NetworkRule()
{
	var v6_conf_off=document.getElementById('lanv6config_off').checked;
	if (v6_conf_off==true)
		return true;

	// check the range of stateful dhcp
	var startip=document.IPV6_FORM.LAN_DHCPV6START.value;
	var endip=document.IPV6_FORM.LAN_DHCPV6END.value;	
	if(startip=="")
	{
		alert(gettext("LAN IPv6 start Address should not be empty!!!"));
		document.IPV6_FORM.LAN_DHCPV6START.focus();
		return false;
	}
	
	if(endip=="")
	{
		alert(gettext("LAN IPv6 end Address should not be empty!!!"));
		document.IPV6_FORM.LAN_DHCPV6END.focus();
		return false;
	}
	/*
	startip= <%getConf("AP_IPADDR_V6_PREFIX");%> + document.IPV6_FORM.LAN_DHCPV6START.value;
	endip=<%getConf("AP_IPADDR_V6_PREFIX");%> + document.IPV6_FORM.LAN_DHCPV6END.value;
	*/
	startip= <%getConf("AP_IPADDR_V6_PREFIX");%> + document.IPV6_FORM.LAN_DHCPV6START.value;
	endip=<%getConf("AP_IPADDR_V6_PREFIX");%> + document.IPV6_FORM.LAN_DHCPV6END.value;
	
	if(!ip_rule_V6.test(startip))
	{
		msg=gettext("LAN IPv6 start Address") + " " + startip + " " + gettext("invalid!");
		alert(msg);
		document.IPV6_FORM.LAN_DHCPV6START.focus();
		return false;
	}	
	
	if(!ip_rule_V6.test(endip))
	{
		msg=gettext("LAN IPv6 end Address") + " " + endip + " " + gettext("invalid!");
		alert(msg);
		document.IPV6_FORM.LAN_DHCPV6END.focus();
		return false;
	}
	
	// check RA lifetime
	var ra_lifetime=document.IPV6_FORM.RA_LIFETIME.value;
	var number_rule=/^[0-9]*$/;
	
	if((!number_rule.test(ra_lifetime))||(ra_lifetime==""))
	{
		alert(gettext("Router advertisement lifetime should be number."));
		document.IPV6_FORM.RA_LIFETIME.focus();
		return false;
	}
		
	ra_lifetime = parseInt(ra_lifetime, 10);
	
	if((ra_lifetime<60))
	{
		alert(gettext("Router advertisement lifetime should not be less than 60 minutes."));
		document.IPV6_FORM.RA_LIFETIME.focus();
		return false;
	}
	
	return true;
}

function CheckRule()
{
	var msg;
	var v6_enable=document.IPV6_FORM.IPV6_ENABLE.value;
	var v6type = document.IPV6_FORM.IPV6_TYPE.value;
	var out_if_sel = <%getConf("OUT_IF_SEL");%>;

	//don't need to check any value.
	if (v6_enable=="off") 
	{
		document.IPV6_FORM.submit();
		return true;
	}
	
	if(out_if_sel == "usb0")
	{
		if (v6type == "static_dual" || v6type == "pppoe")
		{
			msg=gettext("Please first choose WAN mode!");
			alert(msg);
			return false;
		}
	}
	
	if(!Checkv6TypeRule()) return false;
	if(!Checkv6LanRule()) return false;
	if(!Checkv6DNSRule()) return false;
	if(!Checkv6NetworkRule()) return false;

	return true;
}

</script>
</head>

<body onload="loadIPV6Page()">
<div id="all">
<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("ipv6", "ipv6_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
<div class="secH1">IPv6</div>
<!-- Section Begin -->
<div class="secBg">
	<div class="statusMsg"><%getActionResult();%></div>
	<form method="post" name="IPV6_FORM" action="/goform/setIPv6">  
	<table border="0" cellpadding="0" cellspacing="0" class="configTbl">
		<tr>
			<td>
				<div class="secH2"><script>document.write( gettext("IPv6 Settings:") );</script></div>									
			</td>
			<td>
				<input type="radio" id="ipv6_on" name="IPV6_ENABLE" ~cIPV6_ENABLE:on~ value="on" onclick="v6Enable(this);"/><script>document.write( gettext("on") );</script>
				<input type="radio" id="ipv6_off" name="IPV6_ENABLE" ~cIPV6_ENABLE:off~ value="off" onclick="v6Enable(this);"/><script>document.write( gettext("off") );</script>
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>			
	
	<!-- ipv6 connection type -->
	<div id="ipv6_table" style="display:none">	
	<div class="secH2"><script>document.write( gettext("IPv6 CONNECTION TYPE") );</script></div>
	<br>
	<table cellspacing="0" class="configTbl">
		<tr>
			<td><script>document.write( gettext("IPv6 Connection") );</script></td>
			<td>
				<select class="fill" name="IPV6_TYPE" id="ipv6_type" onclick="v6Type();">
					<!--<option ~sIPV6_TYPE:static_dual~ value="static_dual" id="static_dual" >Static IPv6</option>-->
					<option ~sIPV6_TYPE:dyna_dual~ value="dyna_dual" id="dyna_dual" ><script>document.write( gettext("Autoconfiguration (SLAAC/DHCPv6)") );</script></option>
					<option ~sIPV6_TYPE:pppoe~ value="pppoe" id="pppoe" ><script>document.write( gettext("PPPoE") );</script></option>
					<option ~sIPV6_TYPE:6in4~ value="6in4" id="6in4" ><script>document.write( gettext("IPv6 in IPv4 Tunnel") );</script></option>
					<option ~sIPV6_TYPE:gogoc~ value="gogoc" id="gogoc"><script>document.write( gettext("IPv6 in IPv4 Tunnel (gogoc)") );</script></option>
					<option ~sIPV6_TYPE:6to4~ value="6to4" id="6to4" ><script>document.write( gettext("6to4") );</script></option>
					<option ~sIPV6_TYPE:6rd~ value="6rd" id="6rd" ><script>document.write( gettext("6rd") );</script></option>
				</select>			
			</td>
			<td></td>
		</tr>
	</table>
	<br><br>
	</div>
			
	<!-- ipv6 wwan -->
	<div id="ipv6_wan" style="display:none">
	<div class="secH2"><script>document.write( gettext("WAN IPv6 ADDRESS SETTINGS") );</script></div>	
	<br>		
	<table cellspacing="0" class="configTbl">
		<tr id="wan_ipv6addr" style="display:none">
			<td><script>document.write( gettext("IPv6 Address") );</script></td>
			<td>
				<input type="text" name="WAN_IPV6ADDR" size="42" maxlength="40" value="" />
			</td>
			<td></td>
		</tr>
		<tr id="dyna_wan_ipv6addr" style="display:none">
			<td><script>document.write( gettext("IPv6 Address") );</script></td>
			<!--
			<td>~`/usr/www/cgi-bin/getWAN ipv6wanip`~<td>
			-->
			<td id="wan_ipv6wanip"></td>
			<td></td>
		</tr>
		<tr id="wan_ipv6prefix" style="display:none">
			<td><script>document.write( gettext("Subnet Prefix Length") );</script></td>
			<td><input type="text" name="WAN_IPV6PREFIX" size="5" maxlength="3" value="" /></td>
			<td></td>			
		</tr>
		<tr id="wan_ipv6gw" style="display:none">	
		  	<td><script>document.write( gettext("Default Gateway") );</script></td>
			<td><input type="text" name="WAN_IPV6GW" size="42" maxlength="40" value="" /></td>		 			
			<td></td>
		</tr>
				
		<tr id="dslite_sel">
		  <td><script>document.write( gettext("Enable DS-Lite") );</script></td>
		  <td>
		    <select name="DSLITE" class="fill" id="dslite" onclick="ip6dslite();">
				<option ~sDSLITE:on~ value="on" id="on" ><script>document.write( gettext("on") );</script></option>
				<option ~sDSLITE:off~ value="off" id="off" ><script>document.write( gettext("off") );</script></option>
	      	</select>
	      </td>
	      <td></td>
		</tr>
		  		
		<tr id="dsl_cgnv6" style="display:none">
			<td><script>document.write( gettext("CGN IPv6 Address (AFTR)") );</script></td>
			<td><input type="text" name="DSL_CGNV6" size="42" maxlength="40" value="" /></td>
			<td></td>
		</tr>
		<tr id="dsl_cgnv4" style="display:none">
			<td><script>document.write( gettext("CGN IPv4 Address (AFTR)") );</script></td>
			<td><input type="text" name="DSL_CGNV4" size="22" maxlength="20" value="" /></td>
			<td></td>
		</tr>
		<tr id="b4_addr" style="display:none">
			<td><script>document.write( gettext("B4 IPv4 Address") );</script></td>
			<td><input type="text" name="B4_ADDR" size="22" maxlength="20" value="" /></td>
			<td></td>
		</tr>		
	</table>
	<br><br>
	</div>

	<div id="pppoev6" style="display:none">
	<div class="secH2"><script>document.write( gettext("PPPoE SETTINGS") );</script></div>		
	<br>
	<table cellspacing="0" class="configTbl">	
		<tr>
			<td><script>document.write( gettext("Address Mode") );</script></td>
			<td>
				<input type="radio" id="pppoe_dyna" name="PPPOE_ADDR" value="dynamic" onclick="pppoev6addr(this);" /><script>document.write( gettext("Dynamic IP") );</script>
				<input type="radio" id="pppoe_static" name="PPPOE_ADDR" value="static" onclick="pppoev6addr(this);" /><script>document.write( gettext("Static IP") );</script>							
			</td>
			<td></td>
		</tr>		
		<tr id="pppoe_v6addr_dyn">
			<td><script>document.write( gettext("IPv6 Address") );</script></td>			
			<!--
			<td>~`/usr/www/cgi-bin/getWAN ipv6wanip`~<td>
			-->			
			<td id="pppoe_ipv6wanip"></td>
			<td></td>
		</tr>
		
		<tr id="pppoe_v6addr" style="display:none">
			<td><script>document.write( gettext("IPv6 Address") );</script></td>
			<td><input type="text" id="PPPOE_V6ADDR_input" name="PPPOE_V6ADDR" size="40" maxlength="40" value="" /></td>
			<td></td>			
		</tr>
		<tr id="wan_user">
			<td><script>document.write( gettext("Username") );</script></td>
			<td><input class="fill" type="text" name="WAN_USER" size="40" maxlength="20" value="" /></td>			
			<td></td>
		</tr>
		<tr id="wan_pwd">
			<td><script>document.write( gettext("Password") );</script></td>
			<td><input class="fill" type="password" name="WAN_PWD" size="40" maxlength="20" value="" /></td>
			<td></td>
		</tr>		
	</table>
	<br><br>	
	</div>		
	
	<div id="ip6in4" style="display:none">
	<div class="secH2"><script>document.write( gettext("IPv6 in IPv4 TUNNEL SETTINGS") );</script></div>			
	<br>
	<table cellspacing="0" class="configTbl">		
		<tr id="ip6in4remoteip4">
			<td><script>document.write( gettext("Remote IPv4 Address") );</script></td>
			<td><input class="fill" type="text" name="IP6IN4REMOTEIP4" size="40" maxlength="20" value="" /></td>			
			<td></td>			
		</tr>
		<tr id="ip6in4remoteip6">
			<td><script>document.write( gettext("Remote IPv6 Address") );</script></td>
			<td><input class="fill" type="text" name="IP6IN4REMOTEIP6" size="40" maxlength="20" value="" /></td>								
			<td></td>				
		</tr>
		<tr id="localip4">
			<td><script>document.write( gettext("Local IPv4 Address") );</script></td>
			<!--
			<td>~`/usr/www/cgi-bin/getWAN wanip`~<td>
			-->
			<td id="localip4_wanip"></td>
			<td></td>	
		</tr>
		<tr id="ip6in4localip6">
			<td><script>document.write( gettext("Local IPv6 Address") );</script></td>
			<td><input class="fill" type="text" name="IP6IN4LOCALIP6" size="40" maxlength="40" value="" /></td>
			<td></td>	
		</tr>
	</table>
	<br><br>	
	</div>		

	<div id="ip6in4_gogoc" style="display:none">
	<div class="secH2"><script>document.write( gettext("GOGOC SETTINGS") );</script></div>				
	<br>
	<table cellspacing="0" class="configTbl">		
		<tr>
			<td><script>document.write( gettext("Server Address") );</script></td>
			<td>
				<input class="fill" type="text" name="GOGOC_SERVER" size="40" maxlength="64" value="" />
			</td>
			<td></td>	
		</tr>
		<tr>
		    <td colspan="2" valign="middle"><input type="radio" id="gogoc_auth_anonymous" name="GOGOC_AUTH_METHOD" value="anonymous" onclick="gogocAuth(this);" style="vertical-align:middle;"> <script>document.write( gettext("Connect Anonymously") );</script></td>		  
		    <td></td>
		<tr>
		<tr>
		    <td colspan="2" valign="middle"><input type="radio" id="gogoc_auth_any" name="GOGOC_AUTH_METHOD" value="any" onclick="gogocAuth(this);" style="vertical-align:middle;"> <script>document.write( gettext("Connect Using the Following Credentials") );</script>	</td>
		    <td></td>		    
		</tr>			
		<tr>
			<td><script>document.write( gettext("User Name") );</script></td>
			<td><input class="fill" type="text" name="GOGOC_USERID" id="GOGOC_USERID" size="40" maxlength="20" value="" /></td>			
			<td></td>	
		</tr>
		<tr>
			<td><script>document.write( gettext("Password") );</script></td>
			<td><input class="fill" type="text" name="GOGOC_PASSWD" id="GOGOC_PASSWD" size="40" maxlength="20" value="" /></td>			
			<td></td>	
		</tr>		

	</table>
	<br><br>	
	</div>		
	
	<div id="ip6to4" style="display:none">
	<div class="secH2"><script>document.write( gettext("6to4 SETTINGS") );</script></div>					
	<br>
	<table cellspacing="0" class="configTbl">		
		<tr id="ip6to4addr">
			<td><script>document.write( gettext("6to4 Address") );</script></td>
			<!--
			<td>~`/usr/www/cgi-bin/getWAN ipv6wanip`~<td>
			-->
			<td id="ip6to4addr_ipv6wanip"></td>
			<td></td>	
		</tr>
		<tr id="ip6to4relay">
			<td><script>document.write( gettext("6to4 Relay") );</script></td>
			<td>
				<input class="fill" type="text" name="IP6TO4RELAY" size="40" maxlength="20" value="" disabled="true" />
			</td>
			<td></td>	
		</tr>
	</table>
	<br><br>	
	</div>		

	<!-- 6rd settings -->
	<div id="ip6rd" style="display:none">
	<div class="secH2"><script>document.write( gettext("6RD SETTINGS") );</script></div>						
	<br>
	<table cellspacing="0" class="configTbl">		
        <tr>
            <td><script>document.write( gettext("6rd method") );</script></td>
            <td>					
        	  <input type="radio" id="ip6rd_dhcp" name="IP6RD_CONFIG" value="dhcp" onclick="ip6rdConfig(this);" />DHCP
        	  <input type="radio" id="ip6rd_static" name="IP6RD_CONFIG" value="static" onclick="ip6rdConfig(this);" />Static		
            </td>
            <td></td>
        </tr>	
		<tr id="ip6rdprefix" style="display:none">
			<td><script>document.write( gettext("6rd IPv6 Prefix") );</script></td>
			<td><input class="fill" type="text" name="IP6RDPREFIX" size="42" maxlength="40" value="" /></td>
			<td></td>			
		</tr>
		<tr id="ip6rdprefixlen" style="display:none">
			<td><script>document.write( gettext("6rd IPv6 Prefix Length") );</script></td>
			<td><input class="fill" type="text" name="IP6RDPREFIXLEN" size="2" maxlength="2" value="" /></td>
			<td></td>
		</tr>		
		<tr id="ip6rdaddr">
			<td><script>document.write( gettext("6rd Address") );</script></td>
			<!--
			<td>~`/usr/www/cgi-bin/getWAN ipv6wanip`~<td>
			-->
			<td id="ip6rdaddr_ipv6wanip"></td>
			<td></td>
		</tr>
		<tr id="ip6rdrelay" style="display:none">
			<td><script>document.write( gettext("6rd Relay") );</script></td>
			<td><input class="fill" type="text" name="IP6RDRELAY" size="22" maxlength="20" value="" /></td>
			<td></td>
		</tr>
	</table>
	<br><br>	
	</div>		

	<div id="ipv6_lan" style="display:none">
	<div class="secH2"><script>document.write( gettext("LAN IPv6 ADDRESS SETTINGS") );</script></div>							
	<br>
	<table cellspacing="0" class="configTbl">		
        <tr id="dhcppd" style="display:none">
          <td><script>document.write( gettext("Enable DHCP-PD") );</script></td>
          <td>					
  		    <input type="radio" id="dhcppd_on" name="DHCPPD_ENABLE" ~cDHCPPD_ENABLE:on~ value="on" onclick="lanv6dhcppd(this);" /><script>document.write( gettext("on") );</script>
  		    <input type="radio" id="dhcppd_off" name="DHCPPD_ENABLE" ~cDHCPPD_ENABLE:off~ value="off" onclick="lanv6dhcppd(this);" /><script>document.write( gettext("off") );</script>							
          </td>
          <td></td>
        </tr>
				
		<tr id="lan_ipv6addr">
			<td><script>document.write( gettext("LAN IPv6 Address") );</script> </td>
			<td>				
				<input type="text" class="fill" id="ap_ipaddr_v6" name="AP_IPADDR_V6" size="42" maxlength="40" value="" />
			</td>			
			<td></td>
		</tr>				
				
		<tr id="lan_prefixlen" style="display:none">
			<td><script>document.write( gettext("LAN Prefix Length") );</script> </td>
			<td>
				<input type="text" id="prefix_len_v6" name="PREFIX_LEN_V6" size="5" maxlength="3" value="" />				
			</td>
			<td></td>
		</tr>
		<tr id="lan_globalipv6" style="display:none">
			<td><script>document.write( gettext("LAN IPv6 Global Address") );</script> </td>
			<!--
			<td>~`/usr/www/cgi-bin/getWAN lanipv6global`~<td>
			-->
			<td id="lanipv6global"></td>
			<td></td>
		</tr>	
		<tr id="lan_linklocalipv6">
			<td><script>document.write( gettext("LAN IPv6 Link-Local Address") );</script> </td>
			<!--
			<td>~`/usr/www/cgi-bin/getWAN lanipv6link`~<td>
			-->
			<td id="lanipv6link"></td>
			<td></td>
		</tr>	
	</table>
	<br><br>
	</div>		
		
	<div id="ipv6_dns" style="display:none">
	<div class="secH2"><script>document.write( gettext("IPv6 DNS SETTINGS") );</script></div>								
	<br>
	<table cellspacing="0" class="configTbl">		
		<div id="v6dns" style="display:none">
		<tr>
		  <td colspan="2" valign="middle">
		  	<input type="radio" id="lanv6dns_on" name="LAN_V6_DNS" ~cLAN_V6_DNS:on~ value="on" onclick="lanv6DNS(this);" style="vertical-align:middle;" /> 
		  		<script>document.write( gettext("Obtain IPv6 DNS servers automatically") );</script>
		  </td>		  
		  <td></td>
		<tr>
		<tr>
		  <td colspan="2" valign="middle">
		  	<input type="radio" id="lanv6dns_off" name="LAN_V6_DNS" ~cLAN_V6_DNS:off~ value="off" onclick="lanv6DNS(this);" style="vertical-align:middle;" /> 
		  		<script>document.write( gettext("Use the following IPv6 DNS servers") );</script>
		  </td>
		  <td></td>		  
		</tr>		
		</div>
			
		<tr id="wan_ipv6pridns">
		  <td>
		  	<script>document.write( gettext("Primary IPv6 DNS Server") );</script>
		  </td>
		  <td>
		    <input name="WAN_IPV6PRIDNS" type="text" class="fill" id="WAN_IPV6PRIDNS_input" value="" size="40" />
		   </td>
		   <td></td>
		</tr>
		<tr id="wan_ipv6secdns">
		  <td>
		  	<script>document.write( gettext("Secondary IPv6 DNS Servers") );</script>
		  </td>
		  <td>
		  	<input name="WAN_IPV6SECDNS" type="text" class="fill" id="WAN_IPV6SECDNS_input" value="" size="40" />
		  </td>
		  <td></td>
		</tr>					
	</table>
	<br><br>	
	</div>				
		
	<div id="ipv6_network" style="display:none">
	<div class="secH2"><script>document.write( gettext("ADDRESS AUTOCONFIGURATION SETTINGS") );</script></div>									
	<br>
	<table cellspacing="0" class="configTbl">		
        <tr>
          <td colspan="2">
          	<script>document.write( gettext("Enable automatic IPv6 address assignment") );</script>
          </td>
          <td>					
  		  <input type="radio" id="lanv6config_on" name="LAN_V6_CONFIG" ~cLAN_V6_CONFIG:on~ value="on" onclick="lanv6Config(this);" /><script>document.write( gettext("on") );</script>
  		  <input type="radio" id="lanv6config_off" name="LAN_V6_CONFIG" ~cLAN_V6_CONFIG:off~ value="off" onclick="lanv6Config(this);" /><script>document.write( gettext("off") );</script>							
          </td>
        </tr>		
		<tr id="lan_v6_type_sel">
          <td colspan="2">
          	<script>document.write( gettext("Autoconfiguration Type") );</script>
          </td>			
		  <td>
			<select class="fill" name="LAN_V6_TYPE" id="lan_v6_type" onclick="lanv6Type();">
				<option ~sLAN_V6_TYPE:stateless~ value="stateless" id="stateless" ><script>document.write( gettext("Stateless Autoconfiguration") );</script></option>
				<option ~sLAN_V6_TYPE:stateless_dhcp~ value="stateless_dhcp" id="stateless_dhcp" ><script>document.write( gettext("Stateless DHCPv6") );</script></option>
				<option ~sLAN_V6_TYPE:stateful~ value="stateful" id="stateful" ><script>document.write( gettext("Stateful DHCPv6") );</script></option>
			</select>		    
		  </td>		  
		</tr>		
		
		<tr id="lan_dhcpv6start" style="display:none">
			<td colspan="2"><script>document.write( gettext("IPv6 Address Range (Start)") );</script> </td>
			<!--
			<td class="content_body" >~`/usr/www/cgi-bin/getWAN lanv6prefix`~ <input type="text" id="LAN_DHCPV6START_input" name="LAN_DHCPV6START" value="~~LAN_DHCPV6START~" maxlength="4" size="6" /></td>
			-->
			<td>
				<span id="lanv6prefix_start"></span>
				<input type="text" id="LAN_DHCPV6START_input" name="LAN_DHCPV6START" value="" maxlength="4" size="6" />
			</td>	
		</tr>
		<tr id="lan_dhcpv6end" style="display:none">
			<td colspan="2"><script>document.write( gettext("IPv6 Address Range (End)") );</script> </td>
			<!--
			<td class="content_body" >~`/usr/www/cgi-bin/getWAN lanv6prefix`~ <input type="text" id="LAN_DHCPV6END_input" name="LAN_DHCPV6END" value="~~LAN_DHCPV6END~" maxlength="4" size="6" /></td>
			-->
			<td>
				<span id="lanv6prefix_end"></span>
				<input type="text" id="LAN_DHCPV6END_input" name="LAN_DHCPV6END" value="" maxlength="4" size="6" />
			</td>								
		</tr>		
		
		<tr id="ra_lifetime" style="display:none">
			<td colspan="2"><script>document.write( gettext("Router Advertisement Lifetime") );</script></td>
			<td>				
				<input class="fill" type="text" id="RA_LIFETIME_input" name="RA_LIFETIME" size="6" maxlength="4" value="" /><span class="explain"><script>document.write( gettext("(minutes)") );</script></span>
			</td>			
		</tr>				
	</table>
	<br><br>	
	</div>			
		
   <div class="submitBg">
   	<input type="submit" value="Apply" name="btnApply" onclick="return CheckRule();" class="submit" title="Apply" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
   	<input type="button" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
   </div>  
  </form> 
</div>
<!-- Section End -->
</div>
</div>

</body>
</html>
