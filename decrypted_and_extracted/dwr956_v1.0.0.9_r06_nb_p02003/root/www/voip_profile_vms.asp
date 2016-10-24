<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
			 <meta http-equiv="Pragma" content="no-cache">
        <meta name="generator" content=
        "HTML Tidy, see www.w3.org" />
        <meta http-equiv="Content-Type" content=
        "text/html; charset=iso-8859-1" />

        <title>Untitled Document</title>
        <link rel="stylesheet" type="text/css" href="final.css" />
		<script language="JavaScript" src="validations.js"></script>
		<script language="JavaScript" src="myParser.js"></script>
	<script language="JavaScript">
	
var etm=' The registrar expiry time must be between 100 to 32768.';	
var nm='The port number must be between 1024 to 65535.';
function updateVmsData()
{
	bStatus = !document.voicemail.VmsStatus.selectedIndex;

	document.voicemail.tempaddr.disabled   = bStatus;
	document.voicemail.VmsExpTime.disabled   = bStatus;	
}
	
function FormInit()
{
	CheckPermission_voicemail();
		updateVmsData();
		display();
}
function CheckPermission_voicemail()
{
		document.voicemail.tempaddr.disabled  	= true;
		document.voicemail.VmsExpTime.disabled  	= true;
  return true;
}



		function InitForm()
		{
			FormInit(); /* For loading voice mail server settings */
		}
	
		function submitVM()
		{
		SetAttributes();
		var bVmsStatus = document.voicemail.VmsStatus.selectedIndex;
	  var VmsIP = document.voicemail.VmsIP.value;
	 	var VmsPort = document.voicemail.VmsPort.value;
	  var bStatus;
		  
		  if ( (bVmsStatus == 1) ){
				if(isNValidRegExpTime(document.voicemail.VmsExpTime.value))
		  	{
					alert(etm);
					return false; 
				}
				if (isBlank(VmsIP) || isBlank(VmsPort))
				{
						alert('Field(s) can not be Blank');
						return false;
				}

				if (!isValidDomain(VmsIP))
				{
			  		alert('Invalid VMS Address');
						return false;
				}
				if (isNValidSIPPort(VmsPort))
				{
						alert(nm);
						return false;
				}
	}else if ( bVmsStatus == 0)
		  {
			  document.voicemail.VmsStatus.disabled = bVmsStatus;
				document.voicemail.tempaddr.disabled = bVmsStatus;
				document.voicemail.VmsExpTime.disabled = bVmsStatus;	
			
		  }

			return true;

		}
		function address_querry()
		{
		
			var temp1 = "<%ifx_get_voip_sip_Vms("VmsPtl","0");%>";
			var temp2 = "<%ifx_get_voip_sip_Vms("VmsPtl","1");%>";
			var temp3 = "<%ifx_get_voip_sip_Vms("VmsPtl","2");%>";
			if(temp1=="checked")
			{
				document.voicemail.VmsPtl.value = 0;
			}
			else if(temp2=="checked")
			{
				document.voicemail.VmsPtl.value = 1;
			}
			else if(temp3=="checked")
			{
				document.voicemail.VmsPtl.value = 2;
			}			
			document.voicemail.VmsIP.value = "<%ifx_get_voip_sip_Vms("VmsIP");%>";
			document.voicemail.VmsPort.value = "<%ifx_get_voip_sip_Vms("VmsPort");%>";
		}
		
		function SetAttributes()
			{
				var str = document.voicemail.tempaddr.value;
				var ReArray = parse(str);
				
				document.voicemail.VmsIP.value= ReArray[2];
				document.voicemail.VmsPort.value= ReArray[3];
				
				var tprotocol = ReArray[4];

				document.voicemail.VmsPtl.value=convertProto(tprotocol);
				
			}
		
		function display()
			{
				address_querry();
				var proto = convertProto_value(document.voicemail.VmsPtl.value);
			
				var tempstr = document.voicemail.VmsIP.value+":"+document.voicemail.VmsPort.value+";transport="+proto;
				
				document.voicemail.tempaddr.value = tempstr;
			}
			function convertProto_value(str)
			{
				if (str == 1) 
					return "UDP";
				else if (str == 2) 
					return "TCP";
				else if (str == 0) 
					return "Auto";
			}
	</script>
    </head>

	<BODY class="decBackgroundDef" onLoad="InitForm();">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                
                <li><a href="voip_profile_SIP.asp"><span>SIP
                Server</span></a></li>
<!-- <li><a href=
                "voip_profile_stun.htm"><span>STUN</span></a></li> -->

                <li><a href="voip_profile_ua.asp"><span>User
                Agent</span></a></li>

                <li><a href=
                "voip_profile_Media.asp"><span>Media</span></a></li>

                <li><a href="#" class="selected"><span>Voice
                Mail</span></a></li>
            </ul>
        </div>
        <br />
<span class="textTitle">Service &gt; Voice Mail</span>


        <div align="center">
		<FORM ACTION="/goform/ifx_set_voip_sip_Vms" METHOD="POST" NAME="voicemail" onsubmit="return submitVM();">
		<input type="hidden" name="page" value="voip_profile_vms.asp">
		<input type="hidden" name="status" value="0">
		<input type="hidden" name="cvflag" value="0">
            <table class="tableInput" summary="">
                <tr>
                    <th colspan="4">Voicemail</th>
                </tr>

                <tr>
                    <td>Status</td>

                    <td><select name="VmsStatus" size="1" onChange="updateVmsData();"> <%ifx_get_voip_sip_Vms("VmsStatus");%></select> </td>
                </tr>

                <tr>
                    <td>Subsrciption Time</td>

                    <td><INPUT TYPE=TEXT NAME="VmsExpTime" SIZE=5 VALUE="<% ifx_get_voip_sip_Vms("VmsExpTime");%>"> sec</td>
                </tr>

                <tr>
                    <td>Address:Port:Protocol</td>

					<td><input type="text"maxLength="128" name="tempaddr" size="32" value="" ></td>

						<INPUT TYPE="hidden" NAME="VmsIP" VALUE="">
					<INPUT TYPE="hidden" NAME="VmsPort" SIZE=5 VALUE="">
					<input type="hidden" name="VmsPtl" value="0">

				
				</tr>

                <tr>
                    <td colspan="4" align="right">
                    <button type="submit">Apply</button> </td>
                </tr>
            </table>
        </div>
    </body>
</html>

