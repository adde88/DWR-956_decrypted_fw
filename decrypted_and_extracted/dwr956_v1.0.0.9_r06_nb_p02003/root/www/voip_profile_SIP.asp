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
		<script language="JavaScript" type="text/javascript" src="myParser.js"></script>
		<script type="text/javascript">
		nm='The port number must be between 1024 to 65535.';
		etm=' The registrar expiry time must be between 100 to 32768.';
		function submitSERVER()
{
    var bProxyStatus = document.sipserver.profstatus.selectedIndex;; //document.sipserver.ProxyStatus.selectedIndex;
		if(bProxyStatus != 1)
					return true;
	
	  document.sipserver.ProxyStatus.value=bProxyStatus ;
		var ProxyReturn=parse(document.sipserver.ProxyFull.value)
    var ProxyIP = ProxyReturn[2];
    var ProxyPort = ProxyReturn[3];
    document.sipserver.ProxyIP.value=ProxyIP;
		document.sipserver.ProxyPort.value=ProxyPort;
		document.sipserver.ProxyPtl.value=convertProto(ProxyReturn[4]);
	
    var bRegStatus = document.sipserver.profstatus.selectedIndex;; //document.sipserver.RegStatus.selectedIndex;
		document.sipserver.RegStatus.value=bRegStatus ;
    var RegReturn=parse(document.sipserver.RegFull.value)
    var Reg2Return=parse(document.sipserver.BackupRegFull.value)
    var RegIP = RegReturn[2];
    var BackupRegIP = Reg2Return[2];
    var RegPort = RegReturn[3];
    var BackupRegPort = Reg2Return[3];
    if (BackupRegIP == "NULL"){
       BackupRegIP = "";
    }
		document.sipserver.RegIP.value=RegIP;
		document.sipserver.BackupRegIP.value=BackupRegIP;
		document.sipserver.RegPort.value=RegPort;
		document.sipserver.BackupRegPort.value=BackupRegPort;
		document.sipserver.RegPtl.value=convertProto(RegReturn[4]);
		document.sipserver.BackupRegProto.value=convertProto(Reg2Return[4]);
    var RegExpTime = document.sipserver.RegExpTime.value;
	
		var OutbndReturn=parse(document.sipserver.OutBoundFull.value);
		var OutbndProxyIP = OutbndReturn[2];
    var OutbndProxyPort = OutbndReturn[3];
			
		if(OutbndProxyIP == "NULL"){
			document.sipserver.OutbndProxyIP.value="";
			OutbndProxyIP="";
		}
		else	
			document.sipserver.OutbndProxyIP.value=OutbndProxyIP;

		if(OutbndProxyPort == "NULL" || OutbndProxyPort == 0){
			document.sipserver.OutbndProxyPort.value="0";
			OutbndProxyPort="";
		}
		else
			document.sipserver.OutbndProxyPort.value=OutbndProxyPort;
    
		var ReturnStatus = true;
    var bStatus;

	/*alert(bProxyStatus);*/
   	if ( (bProxyStatus == 1)&&
        (isBlank(ProxyIP) || isBlank(ProxyPort)))
	{
        alert('Field(s) can not be Blank');
		ReturnStatus = false;
	}
   	if ( (bRegStatus == 1 )&& 
        (isBlank(RegIP) || isBlank(RegPort) || 
        isBlank(RegExpTime)))
	{
        alert('Field(s) can not be Blank');
		ReturnStatus = false;
	}

	if ( (bProxyStatus == 1)&& (!isValidDomain(ProxyIP) ))
	{
	  alert('Invalid Proxy Server Address');
		ReturnStatus = false;
		return false;
	}
 
	if (((bProxyStatus == 1 ) && 
        isNValidSIPPort(ProxyPort))
                        ||
        (( bRegStatus == 1 ) &&    
	    isNValidSIPPort(RegPort))
                        ||
      (( bRegStatus == 1 ) &&    
      (!isBlank(BackupRegIP)) &&
	    isNValidSIPPort(BackupRegPort))
    )
	{
		alert(nm);
		ReturnStatus = false;
	}
  /* if (((!isBlank(OutbndProxyIP)) &&
	(isBlank(OutbndProxyPort)))||
	((isBlank(OutbndProxyIP)) &&
	(!isBlank(OutbndProxyPort))))
	{
	 alert('Either Outbound Proxy IP or Port is blank');
	 return false;
	}
*/
    if ((!isBlank(OutbndProxyIP)) &&
	(!isValidDomain(OutbndProxyIP)))
	{
	 alert('Invalid Outbound Proxy Address');
	 return false;
	}
	
    if ((!isBlank(OutbndProxyPort)) &&
	(isNValidSIPPort(OutbndProxyPort)))
	{
	 alert(nm);
	 return false;
	}
  	if ((bRegStatus == 1 ) && 
        isNValidRegExpTime(RegExpTime))
  	{
    	alert(etm);
	  	ReturnStatus = false; 
	}
  if ((bRegStatus == 1 )&& (!isValidDomain(RegIP) ))
	{
	  alert('Invalid Primary Registrar Server Address');
		ReturnStatus = false;
		return false;
	}
  if ((bRegStatus == 1 ) && (!isBlank(BackupRegIP)) && (!isValidDomain(BackupRegIP) ))
	{
	  alert('Invalid Secondary Registrar Server Address');
		return false;
	}
 
  
    /* Enable all disabled fields owing to extarction of disabled 
     * field values at back end ( CGI function )
     */
    /* Proxy */
    if ( bProxyStatus == 0 && ReturnStatus == true)
    {
        //document.sipserver.ProxyStatus.disabled = bProxyStatus;
	    //document.sipserver.ProxyIP.disabled = bProxyStatus;
	    document.sipserver.ProxyFull.disabled   = bProxyStatus;	
	    //document.sipserver.ProxyPtl[0].disabled = bProxyStatus;
	    //document.sipserver.ProxyPtl[1].disabled = bProxyStatus;
	    //document.sipserver.ProxyPtl[2].disabled = bProxyStatus;
    }

    /* Registrar */
    if ( bRegStatus == 0 && ReturnStatus == true)
    {
        //document.sipserver.RegStatus.disabled = bRegStatus;
        document.sipserver.RegExpTime.disabled = bRegStatus;
		document.sipserver.RegFull.disabled = bRegStatus;
		document.sipserver.BackupRegFull.disabled = bRegStatus;
        //document.sipserver.RegIP.disabled   = bRegStatus;
        //document.sipserver.RegPort.disabled   = bRegStatus;
        //document.sipserver.RegPtl[0].disabled = bRegStatus;
        //document.sipserver.RegPtl[1].disabled = bRegStatus;
        //document.sipserver.RegPtl[2].disabled = bRegStatus;
        //document.sipserver.WellKnownSource.disabled = 1;
    }
	
		// User Agent Part	
		SipReturn=parse(document.sipserver.domainFull.value);
		document.sipserver.domain_name.value=SipReturn[2];
		document.sipserver.SipServerPort.value=SipReturn[3];
		document.sipserver.ptl.value=convertProto(SipReturn[4]);

		if((isBlank(document.sipserver.SipServerPort.value) ||
	    isBlank(document.sipserver.domain_name.value)))
  {
    alert('Field(s) can not be blank');
		return false;
  }

	if (!isValidDomain(document.sipserver.domain_name.value) )
	{
	  alert('Invalid Domain Name');
		ReturnStatus = false;
		return false;
	}
  if(isBlank(document.sipserver.SipServerPort.value))
  {
    alert('field(s) can not be blank');
		ReturnStatus = false;
  } 

	if (isNValidSIPPort(document.sipserver.SipServerPort.value))
	{
	  alert(nm);
		ReturnStatus = false;
	}


	return ReturnStatus;

}
		</script>
		<script type="text/javascript">
		function changeState(){
		var bProfileStatus = document.sipserver.profstatus.selectedIndex;
		document.sipserver.ProxyStatus.value=bProfileStatus;
		document.sipserver.RegStatus.value=bProfileStatus;
		bStatus=!bProfileStatus;
		document.sipserver.ProxyFull.disabled = bStatus;
		document.sipserver.RegExpTime.disabled = bStatus;
		document.sipserver.RegFull.disabled = bStatus;
		document.sipserver.BackupRegFull.disabled = bStatus;
		document.sipserver.OutBoundFull.disabled = bStatus;
		document.sipserver.domainFull.disabled = bStatus;
		document.sipserver.RegRtryTimeOut.disabled = bStatus;
	
	var Str="<%ifx_get_voip_sip_server("ProxyPtlQuery");%>";	
	document.sipserver.ProxyPtl.value=convertProto(Str);
	var ipStr=(document.sipserver.ProxyIP.value !=null)?document.sipserver.ProxyIP.value:""; 
		document.sipserver.ProxyFull.value =ipStr +":"+ document.sipserver.ProxyPort.value + ";transport="+Str;
		
	 	Str="<%ifx_get_voip_sip_server("ProxyPtlQuery");%>";	
		document.sipserver.RegPtl.value=convertProto(Str);
	 ipStr=(document.sipserver.RegIP.value != null)?document.sipserver.RegIP.value:""; 
		document.sipserver.RegFull.value = ipStr + ":" + document.sipserver.RegPort.value + ";transport="+Str;
	
	 ipStr=(document.sipserver.OutbndProxyIP.value != null)?document.sipserver.OutbndProxyIP.value:""; 
		document.sipserver.OutBoundFull.value = ipStr + ":" +document.sipserver.OutbndProxyPort.value;
		Str="<%ifx_get_voip_sip_server("ptl");%>";
		document.sipserver.ptl.value=convertProto(Str);

	 ipStr=(document.sipserver.domain_name.value != null)?document.sipserver.domain_name.value:""; 
		document.sipserver.domainFull.value=ipStr+":"+document.sipserver.SipServerPort.value +";transport="+Str; 
						
	Str="<%ifx_get_voip_sip_server("BackupRegProtoQuery");%>";
	document.sipserver.BackupRegProto.value=convertProto(Str);
	 ipStr=(document.sipserver.BackupRegIP.value != null)?document.sipserver.BackupRegIP.value:""; 
		document.sipserver.BackupRegFull.value=ipStr+":"+document.sipserver.BackupRegPort.value +";transport="+Str; 
}
		</script>

        <title></title>
    </head>

    <body class="decBackgroundDef" onLoad="changeState();">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                
                <li><a href="#" class="selected"><span>SIP
                Server</span></a></li>
<!--<li><a href=
                "voip_profile_stun.htm"><span>STUN</span></a></li> -->

                <li><a href="voip_profile_ua.asp"><span>User
                Agent</span></a></li>

                <li><a href=
                "voip_profile_Media.asp"><span>Media</span></a></li>

                <li><a href="voip_profile_vms.asp"><span>Voice
                Mail</span></a></li>
            </ul>
        </div>
        <br />
<span class="textTitle">Service &gt; SIP Server</span>

        <div align="center">
            <table class="tableInput" summary="">
            	<tr>
                    <th colspan="5">Service Status</th>
                </tr>

                <tr>
                	
                    <td>Status</td>

                    <td>

	<form action="/goform/ifx_set_voip_sip_server" method="post" name="sipserver" onSubmit="return submitSERVER();"> 
<input type="hidden" name="page" value="voip_profile_SIP.asp">
<input type="hidden" name="portChg" value="0">
<input type="hidden" name="status" value="0">
<input type="hidden" name="cvflag" value="0">                    	
<select name="profstatus" onChange="return changeState();">
<%ifx_get_voip_sip_profstate("profstatus");%>
</select>
</td>
                </tr>
				
                <tr>
                    <th colspan="5">Proxy</th>
                </tr>
                <tr>
                	<input type="hidden" name="page" value="voip_profile_SIP.asp">
						
					<input type="hidden" name="ProxyStatus" value="<%ifx_get_voip_sip_server("ProxyStatusQuery1");%>">
					<input type="hidden" name="ProxyIP" value="<%ifx_get_voip_sip_server("ProxyIP");%>">
					<input type="hidden" name="ProxyPort" value="<%ifx_get_voip_sip_server("ProxyPort");%>">
					<input type="hidden" name="ProxyPtl" value="0">
                    <td>Address:Port:Protocol</td>
                    <td><input type="text" name="ProxyFull"
                    value=" "  /> </td>

                </tr>

                <tr>
                    <th colspan="5">Registrar</th>
                </tr>
				<input type="hidden" name="RegStatus" value="<%ifx_get_voip_sip_server("RegStatusQuery");%>" />
				<input type="hidden" name="RegIP" value="<%ifx_get_voip_sip_server("RegIP");%>" />
				<input type="hidden" name="BackupRegIP" value="<%ifx_get_voip_sip_server("BackupRegIP");%>" />
				<input type="hidden" name="RegPort" value="<%ifx_get_voip_sip_server("RegPort");%>" />
				<input type="hidden" name="BackupRegPort" value="<%ifx_get_voip_sip_server("BackupRegPort");%>" />
				<input type="hidden" name="RegPtl" value="0" />
				<input type="hidden" name="BackupRegProto" value="0" />
                <tr>
                    <td>Registration Time</td>

                    <td><input type="text" maxLength="6" name="RegExpTime" value="<%ifx_get_voip_sip_server("RegExpTime");%>" size="6"> sec</td>
                </tr>
				<tr>
					<td>Retry Timer (from SIP protcol)</td>
					<td><input type="text" maxLength="5" name="RegRtryTimeOut" size="5" value="<%ifx_get_voip_sip_server("RegRetryTime");%>"> sec</td>
					</tr>

                <tr>
                    <td>Address:Port:Protocol (Primary Registrar)</td>

                    <td><input name="RegFull" 
                    value="" type="text" /> </td>
                </tr>
                <tr>
                    <td>Address:Port:Protocol (Secondary Registrar)</td>

                    <td><input name="BackupRegFull" 
                    value="" type="text" /> </td>
                </tr>
                <tr>
                    <th colspan="5">Outbound Proxy</th>
                </tr>
				
<input type="hidden" name="OutbndProxyIP" value="<%ifx_get_voip_sip_server("OutbndProxyIP");%>" />
<input type="hidden" name="OutbndProxyPort" value="<%ifx_get_voip_sip_server("OutbndProxyPort");%>" />
                                <tr>
                    <td>Address:Port:Protocol</td>

                    <td><input type="text" name="OutBoundFull" 
                    value=""  /> 
					</td>
					
</tr>
<tr>
                    <th colspan="4">Domain</th>
                </tr>
<input type="hidden" name="domain_name" value="<%ifx_get_voip_sip_server("domain_name");%>">
<input type="hidden" maxLength="5" name="SipServerPort" size="5" value="<%ifx_get_voip_sip_server("SipServerPort");%>">
<input type="hidden" name="ptl" value="0">
                <tr>
                    <td>Domain Name:Port:Protocol</td>
										
                    <td>
<input name="domainFull" type="text"  
                    value=""  /> </td>
</tr>
				<tr>
					<td colspan="2" align="right"><button type="submit">Apply</button></td>
				</form>
				</tr>
            </table>
            
        </div>
    </body>
</html>

