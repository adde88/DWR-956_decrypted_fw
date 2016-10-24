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
			<script language="JavaScript" type="text/javascript" src="validations.js"></script>
        <title></title>
<script type="text/javascript">
var regstatus=<%ltq_get_sensor("regstatuscode");%>;
var alaramcount=<%ltq_get_sensor("alaramcount");%>;

function clearReads(){
if(alaramcount <= 0)
	return false;
	document.sensorsettings.action.value="clear";
	return true;
}


function unRegisterSensor(){
	if(regstatus == 0)
	return false;

	document.sensorsettings.action.value="unreg";
		return true;
	
}

function saveSensorSettings(){
	if(document.sensorsettings.sname.value == ' ' || isBlank(document.sensorsettings.sname.value)){
			alert("Sensor Name should not be Blank");
			return false;
	}
	 if(document.sensorsettings.interval.value =='' || isBlank(document.sensorsettings.interval.value)){
        alert("Read Interval should not be  blank");
        return false;
    }

    if(isNaN(document.sensorsettings.interval.value) || document.sensorsettings.interval.value <=0 ){
        alert("Invalid Interval "+document.sensorsettings.interval.value);
      return false;
    }
		

	document.sensorsettings.action.value="save";
	document.sensorsettings.power.value=document.sensorsettings.pstatus.selectedIndex;
	return true;
}
</script>
<noscript>Your browser does not support JavaScript!</noscript>
</head>
<body class="decBackgroundDef" >
<span class="textTitle"> >>  Sensor Monitor </span>
       <div align="center"  >
			 <FORM name="sensorsettings" ACTION = "/goform/ltq_set_sensor_settings" METHOD ="POST">
			 <input type="hidden" name="page" value="voip_powersensor_view.asp">        
			 <input type="hidden" name="action" value="none">        
			 <input type="hidden" name="power" value="none">        
        <table class="tableInput" summary="Table">
         <tr id='asHTML'>
                    <th colspan="2"><%ltq_get_sensor("sname");%></th>
	 </tr>
	<tr>
 		<td>Sensor Name : </td> 
		<td><Input type="text" name="sname" value="<%ltq_get_sensor("sname");%>"> </td> 
	
	</tr>
	<tr>
 		<td>Registration status :</td> 
		<td><%ltq_get_sensor("regstatus");%></td> 
	</tr>
	<!--<tr>
 		<td>Battery status :</td> 
		<td><%ltq_get_sensor("batstatus");%></td> 
	</tr>-->
	<tr>
		<td> Power status : </td>
		<td> <select id="pstatus">
				<%ltq_get_sensor("pstatus");%>	
		      </select>	
		</td>
	 </tr>
	<tr>
	<td> Readings </td>
		<td id="powerreads"><table class="tableInfo" summary="Table">
				<tr> 
			     <th>#</th> 
			     <th>Param1</th>
			     <th>Param2</th>
			     <th>Param3</th>		
			     <th>Time Stamp</th>
			 </tr>
				<%ltq_get_sensor("alarams");%>
			<tr>
        <td colspan="5" align="center"><button type="submit" onClick="return clearReads();"> Clear </button></td>
      </tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>Switch Timer </td> 
		<td><select id="period">
			<option selected> DAILY </option>
			<option > ONCE </option>
		      </select>
		   <select id="paction">
			<option selected> --- Action --- </option>
			<option > Set ON Timer </option>
			<option > Set OFF Timer </option>
		   </select>
		</td>
	</tr>
	<tr>
		<td>Read Interval : </td> 
		<td><Input type="text" name="interval" value= <%ltq_get_sensor("readinterval");%>> Secs</td>
	</tr>
	<tr>
	</tr>
	<tr>
	</tr>
	<tr>
		<td colspan ="2" align="center">
			<button type="submit" onClick="return saveSensorSettings();"> Apply </button> &nbsp; &nbsp; &nbsp; 
			<button type="submit" onClick="return unRegisterSensor();"> UnRegister </button>
	
		</td>
	</tr>
      </table>
    </form>
    </body>
</html>

