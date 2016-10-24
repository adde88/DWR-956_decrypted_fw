<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="..//style/styles.css" type="text/css" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script lainguage="javascript" type="text/javascript">
var count=20;
var counter;
setTimeout(function () {autoRefresh_progress()},1000);
function autoRefresh_progress()
{
  counter=setInterval(displayRebootMsg, 1000); 
}

function displayRebootMsg()
{
	var chart = document.getElementById("countdown");
	chart.innerHTML = 'Wi-Fi processing.....<br/>Remaining Time:&nbsp;' + count + '&nbsp;&nbsp;seconds';
    count=count-1;
    if (count <= 0)
    {
       clearInterval(counter);
	   window.location.href="wifi_advsettings.asp";
       return;
	}
}
</script>
</head>

<body>
  <hr/>
  <div id="fullpagemsg_bg"></div>
  <div id="PercentBar" class="msg_outline" style="margin-top:-50px; ">
      <div id="RebootMsg" class="msg_outline" style="margin-top:-50px; display:block;">
	    <div id="countdown" class="msg_container" style="line-height:62px; text-align:center;">
          Wi-Fi processing.....<br/>Remaining Time:&nbsp;20&nbsp;&nbsp;seconds
	    </div>
	  </div>
  </div>
</body>
</html>
