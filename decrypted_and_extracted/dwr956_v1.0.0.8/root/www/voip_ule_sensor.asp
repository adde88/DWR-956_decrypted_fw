<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
	 <meta http-equiv="Pragma" content="no-cache">    
    <meta name="generator" content=
        "HTML Tidy, see www.w3.org" />
        <meta http-equiv="Content-Type" content=
        "text/html; charset=iso-8859-1" />
       <link rel="stylesheet" type="text/css" href="final.css" />
        <title></title>
<script type="text/javascript">
function getQuery(thisVariable) {
 var theQueryString = window.location.search.substring(1);
 var variableArray = theQueryString.split("&");
 for (i=0; i < variableArray.length; i++) {
  var variableRetrieved = variableArray[i].split("=");
  if (variableRetrieved[0] == thisVariable) {
   return variableRetrieved[1];
  }
 }
}

var devicetype = getQuery('type');

function navigatepage(){
		if(devicetype != "" && devicetype != null && devicetype != undefined){
				document.sensor.sentype.value=devicetype;
				if(devicetype == 3)	
						document.sensor.page.value="voip_ule_power_sensors.asp";
			}else
				document.sensor.sentype.value=1;
		
		document.sensor.submit();
}
</script>
<noscript>your browser does not support javascript!</noscript>
 </head>
    <body class="decbackgrounddef" onload="navigatepage();">
		<b> please wait....!! </b>
	<form name="sensor" action = "/goform/ltq_set_sensortype" method ="post">
			 <input type="hidden" name="page" value="voip_ule_sensors_main.asp">        
			 <input type="hidden" name="sentype" value="smoke">        
	</form>
    </body>
</html>

