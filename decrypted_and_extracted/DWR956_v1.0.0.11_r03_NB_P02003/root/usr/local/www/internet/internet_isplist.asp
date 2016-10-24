<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
 <title>4G Router</title>
 <meta http-equiv="Pragma" content="no-cache">
 <meta http-equiv="Cache-Control" content="no-cache">
 <meta http-equiv="Expires" content="0">
 <meta http-equiv="Content-Language" content="en-us" />
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 <link rel="stylesheet" href="../style/all.css" type="text/css" />
 <script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
 <script language="javascript" type="text/javascript">
   var timerId = null;
   function loadpage()
   {
	   var ajax = createAjax();
	   if (timerId) {
	     clearTimeout(timerId);
	   }
    ajax.open('GET', "internet_isplist_reload.asp?time="+ new Date(), true);
    ajax.send(null);
	   ajax.onreadystatechange = function ()
	   {
     if (ajax.readyState == 4)
		   {
      if (ajax.status == 200)
			   {
       window.location = "internet_show_isplist.asp";
      }
     }
    }
   }
   timerId = setTimeout(function () { loadpage(); }, 1000);
 </script>
</head>

<body style="background-color:transparent">
 <div id="show_msg" style="display:block;">
  <p align="left"><span class="statusMsg"><script>document.write(gettext("Scanning maybe need several minutes, please wait..."));</script></span></p>
 </div>
</body>
</html>
