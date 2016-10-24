
function isDebugMode()
{	
   return false;
}

function trim_string(str)
{
    var trim = str + "";
    trim = trim.replace(/^\s*/, "");
    return trim.replace(/\s*$/, "");
} 

function get_by_id(id){
	with(document)
	{
		return getElementById(id);
	}
} 

var ping_url;
var ping_tx_count;
var ping_rx_count;
var rtt_min;
var rtt_max;
var rtt_avg;
var rtt_tot;
var host_name;
var stop_now;
var progress;
var ping_ipv6;

function loadPingTestPage()
{
	progress = get_by_id("ping_check_progress_field");
	progress.innerHTML = gettext("Enter a host name or IP address above and click 'Ping'");
	get_by_id("ping_host").focus();
	rtt_min = 10000;
	rtt_max = 0;
	rtt_avg = 0;
	rtt_tot = 0;

	get_by_id("ping").disabled = false;
	get_by_id("stop").disabled = false;
	get_by_id("ping6").disabled = false;
	get_by_id("stop6").disabled = false;	
}

/*
* update_stats()
*/
function update_stats(reply_time)
{
	ping_rx_count++;
	var rtt = reply_time * 1;
	if (rtt > rtt_max) {
	rtt_max = rtt;
	}
	if (rtt < rtt_min) {
	rtt_min = rtt;
	}
	rtt_tot += rtt;
	rtt_avg = parseInt(rtt_tot / ping_rx_count, 10);
}
/*
* display_stats()
*/
function display_stats()
{
	progress.innerHTML += "User stopped<br/>";
	progress.innerHTML += "Pings sent: " + ping_tx_count + "<br/>";
	progress.innerHTML += "Pings received: " + ping_rx_count + "<br/>";
	progress.innerHTML += "Pings lost: " + (ping_tx_count - ping_rx_count)
	+ " (" + parseInt((100 - ((ping_rx_count / ping_tx_count) * 100)) + "", 10)
	+ "% loss)<br/>";
	if (ping_rx_count != 0) {
	progress.innerHTML += "Shortest ping time (in milliseconds): " + rtt_min + "<br/>";
	progress.innerHTML += "Longest ping time (in milliseconds): " + rtt_max + "<br/>";
	progress.innerHTML += "Average ping time (in milliseconds): " + rtt_avg + "<br/>";
	}
	ping_tx_count = 0;
	ping_rx_count = 0;
	rtt_min = 10000;
	rtt_max = 0;
	rtt_avg = 0;
	rtt_tot = 0;
	get_by_id("ping").disabled = false;
	get_by_id("stop").disabled = false;
	get_by_id("ping6").disabled = false;
	get_by_id("stop6").disabled = false;
}

function process_start(ipv6_type)
{
	stop_now = 0;
	if (ipv6_type == 0)
		host_name = trim_string(get_by_id("ping_host").value);
	else
		host_name = trim_string(get_by_id("ping6_host").value);
	if (host_name == "") {
		alert(gettext("Please enter either a Host Name or an IP Address"));
		return false;
	}
	process_clean();
	get_by_id("ping").disabled = true;
	get_by_id("ping6").disabled = true;
	
	if (ipv6_type == 0) {
		get_by_id("stop").disabled = false;
		get_by_id("stop6").disabled = true;
	}
	else {
		get_by_id("stop").disabled = true;
		get_by_id("stop6").disabled = false;
	}
	ping_tx_count = 1;
	ping_rx_count = 0;
 
	ping_ipv6=ipv6_type?"1":"0";
	
	GetPingData('get_ping_info',host_name,ping_ipv6);
}

function ping_repeat()
{
	ping_tx_count++;
	GetPingData('get_ping_info',host_name,ping_ipv6);		
}

function process_stop()
{
	stop_now = 1;
	get_by_id("stop").disabled = true;
	get_by_id("stop6").disabled = true;
}

function process_clean()
{
	document.getElementById("ping_list").innerHTML = "";
	progress.innerHTML = "";
}

function GetPingResult(ping_info)
{
	var reply_time;
	var ttl;						
	var refresh_time;
	
	if(typeof(ping_info) == "undefined") //for response error
	{
		reply_time = "-1";
		ttl = "0";
	}
	else
	{
		reply_time = ping_info.reply_time;
		ttl = ping_info.ttl;
	}

	if (reply_time == "-1" || reply_time == "")
	{
		progress.innerHTML += "No response from host, retrying..." + "<br>";
		refresh_time=2000;
	}
	else 
	{ 
		update_stats(reply_time);
		progress.innerHTML += "Response from " + host_name + " received in " + reply_time + " milliseconds. " +
		"TTL = " + ttl + "<br>";
		refresh_time=1000;
	}
	if (stop_now == 0) 
	{
		window.setTimeout("ping_repeat();", refresh_time);
	}
	else 
	{
		display_stats();
	}					
	
}

function GetPingData(item, hostname, ipv6_type)
{
	var targetUrl = isDebugMode() ? '/testdata/get_application_status.json' : '/cgi-bin/gui.cgi' ;
	var senddata = { "action" : item, "args" : { "hostname" : hostname, "ipv6_type" : ipv6_type}};

	$.ajax({
		type: 'POST',
		url: targetUrl,
		timeout : 2000, // 2 seconds
		contentType: 'json',
		dataType: 'json',
		data: $.toJSON(senddata),
		beforeSend : function () 
		{
			if(isDebugMode()) { alert("Sending apply JSON: \n" + $.toJSON(senddata)); }			
		},
		error: function(xhr, textStatus, errorThrown) {		
			if (item=="get_ping_info")
				GetPingResult();				
		},
		success: function(msg, textStatus, xhr) {
			if (xhr.status) {					
				if (msg == null)
				{					
					alert(gettext("Failed to get pin data.\nResponse is null."));
				}
				else				
				{	
					if (item=="get_ping_info")
						GetPingResult(msg.ping_info);						
				}									
			}				
		}
	});
	targetUrl = null;
}
$(document).ready(function()
{
	$('#ping').die();
	$('#ping').live('click', function(){		 
		process_start(0);
	});

	$('#stop').die();
	$('#stop').live('click', function(){
		process_stop();		
	});

	$('#ping6').die();
	$('#ping6').live('click', function(){		 
		process_start(1);
	});

	$('#stop6').die();
	$('#stop6').live('click', function(){
		process_stop();		
	});	
});

