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

function submitSensorListSettings(){
		if(document.sensorlist.allon.checked == true)
				document.sensorlist.allon.value=1;

		/*if(document.sensorlist.talaram.checked == true)
				document.sensorlist.talaram.value=1;*/
	return true;
}


function submitSensorSettings(){
	
	if( document.smokesensor.cpeid.value == 0){
		alert("Please select Sensor to Monitor.");
		return false;
	}

	return true;
}
function setSensorInfo(cpeid){

document.sensor.cpeid.value = cpeid;

}
</script>
<noscript>Your browser does not support JavaScript!</noscript>
</head>
<body class="decBackgroundDef" >
<span class="textTitle"> >> <%ltq_get_sensorlist("sensortype");%></span>
       <div align="center"  >
			 <FORM name="sensorlist" ACTION = "/goform/ltq_set_sensorlist" METHOD ="POST">
			 <input type="hidden" name="page" value="voip_ule_power_sensors.asp">        
			 <input type="hidden" name="pstatus" id="pstatus" value="0">        
        <table class="tableInput" summary="Table">
         <tr id='asHTML'>
                    <th colspan="2">General settings</th>
	 				</tr>
<!-- <tr>
		<td>Preset Number: </td> 
		<td><Input type="text" name="psetnum" value="<%ltq_get_sensorlist("psetnum");%>"> </td> 
	 </tr>-->
		<tr>
			<td> All Power ON </td>
			<td> <Input type="checkbox" name="allon" value="0" <%ltq_get_sensorlist("allon");%> > </td>
		</tr>
	<!--<tr>
		<td> Tone Alaram </td>
		<td> <Input type="checkbox" name="talaram" value="0" <%ltq_get_sensorlist("talaram");%> > </td>
	</tr> -->
	<tr>
		<td colspan="2" align="right"><button type="submit" onClick="return submitSensorListSettings();"> Apply </button></td>
	</tr>
      </table>
  </form>
	<FORM name="sensor" ACTION = "/goform/ltq_set_sensorid" METHOD ="POST">   
			 <input type="hidden" name="page" value="voip_powersensor_view.asp">        
			 <input type="hidden" name="cpeid" value="0">        
	<table class="tableInfo" summary="Table">
         <tr>
    <th>#ID</td>
		<th>Sensor Name</th>
		<th>Registeration status</th>
		<th>Power status</th>
		<th>Action</th>
	</tr>
  	<%ltq_get_sensorlist("all");%>
	<tr>
		<td colspan="5" align="center"><button type="submit" onClick="return submitSensorSettings();"> Monitor </button></td>
	</tr>
   </table>
</form>
    </body>
</html>

