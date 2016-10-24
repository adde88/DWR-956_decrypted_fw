<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../images/Wizard/reset.css" />
<link type="text/css" rel="stylesheet" href="../images/Wizard/landingpage.css" />
<script lainguage="javascript" type="text/javascript">
var count=20;
var counter=setInterval(displayRebootMsg, 1000);
function displayRebootMsg()
{
	var chart = document.getElementById("countdown");
	chart.innerHTML = "Remaining Time:" + "&nbsp;&nbsp;" + count + "&nbsp;&nbsp;" + "seconds";
 count=count-1;
 if (count <= 0)
 {
   clearInterval(counter);
   window.location.href="../setupWizard.asp";
   return;
	}
}
</script>
</head>

<body>
  <div class="header">
    <img src="../images/Wizard/Telenor_logo.png" height="60" />
  </div>
  <div class="content">
   <div id="setup_wait">
    <div class="title">
      <h2>Status Message</h2>
    </div>
    <div class="settings">
     <table>
       <tr>
         <th>Processing...</th>
       </tr>
       <tr>
         <th id="countdown"></th>
       </tr>
     </table>
    </div>
   </div>
  </div>
</body>
</html>
