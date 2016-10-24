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
		<script language="JavaScript" type="text/javascript" src="validations.js"></script>
		<script language="JavaScript">

/* Fill data */ 
var ARateMgn = new Array(3);      
var ABitRate  = new Array(3);
var AMaxBuf  = new Array(3);
var AMaxDgram  = new Array(3);
var AErrCorrec  = new Array(3);

ARateMgn[0] = 0;
ABitRate[0] = 0;
AMaxBuf[0]= 0;
AMaxDgram[0]=0;
AErrCorrec[0]=0;
<%ifx_get_voip_sip_fax_init("PopulateArray");%>
			
function submitRTP()
{
  var DSCPMark = document.rtp.DSCPMark.value;

  if (isBlank(document.rtp.sport.value)) 
  {
      alert('RTP/RTCP Start port can not be blank');
		  return false;
  }

  if(isBlank(document.rtp.eport.value) )	
  {
      alert('RTP/RTCP End port can not be blank');
		  return false;
  }
	if (isNValidRtpPort(document.rtp.sport.value)
		|| isNValidRtpPort(document.rtp.eport.value))
	{
		alert("The Start/End port number must be between 1024 to 65535");
		return false;
	}

	if ( document.rtp.sport.value >= document.rtp.eport.value)
	{
 		alert('RTP/RTCP End port should be greater than the Start port');
  	return false;
  }

	if ( (document.rtp.eport.value - document.rtp.sport.value)<=4)
	{
 		alert('Difference between EndPort and StartPort should be more than 4');
  	return false;
  }
	if (isNaN(DSCPMark) || DSCPMark < 0 || DSCPMark > 64)
	{
		alert('RTP DSCP Marking must be between 0 to 64');
		return false;
	}
	var SIPDSCPMark = document.rtp.SIPDSCPMark.value;
	if (isNaN(SIPDSCPMark)|| SIPDSCPMark < 0 || SIPDSCPMark > 64)
	{
		alert('SIP DSCP Marking must be between 0 to 64');
		return false;
	}
if(document.rtp.payload.disabled == false) {
	if(isBlank(document.rtp.payload.value)){
						alert('DTMF Payload value can not be blank');
						return false;
	}	
	
	if(isNaN(document.rtp.payload.value)){
						alert('Invalid DTMF Payload value');
						return false;
	}
	if(document.rtp.payload.value <= 95 || document.rtp.payload.value >= 128){
						alert('Invalid DTMF Payload value should between 96-127 ');
						return false;
	}

}else{
	document.rtp.payload.disabled = false;
}	
	
	return submitFAX();

}

function ProtoCh()
{
  if (document.rtp.ptl.selectedIndex == 0)
  { 
     document.rtp.bitRate.value=ABitRate[1];
     document.rtp.maxbuf.value=AMaxBuf[1];
     document.rtp.maxData.value=AMaxDgram[1];
     document.rtp.maxbuf.disabled=true;
     document.rtp.maxData.disabled=true;
     document.rtp.ecRed.disabled=true;
     document.rtp.ecFec.disabled=true;
     //document.rtp.rateMgn.selectedIndex=ARateMgn[1]-1;
     document.rtp.rateMgn.selectedIndex=0;
  }
  else
  {  
     document.rtp.bitRate.value=ABitRate[2];
     document.rtp.maxbuf.value=AMaxBuf[2];
     document.rtp.maxData.value=AMaxDgram[2];
     document.rtp.maxbuf.disabled=false;
     document.rtp.maxData.disabled=false;
     document.rtp.ecRed.disabled=false;
     document.rtp.ecFec.disabled=false;
		 if(AErrCorrec[2] == 1)
		 {
       document.rtp.ecRed.checked=true;
		 }
		 else
		 {
       document.rtp.ecFec.checked=true;
		 }
     //document.rtp.rateMgn.selectedIndex=ARateMgn[2]-1;
     document.rtp.rateMgn.selectedIndex=1;
  }

	return true;
}

function submitFAX()
{
  /*if (!validatePort())
  {
    return false;	
  }*/

 	if(isNaN(document.rtp.bitRate.value) || (document.rtp.bitRate.value < 0) || (document.rtp.bitRate.value > 14400))
  {
   alert('Max Bit Rate should be a number between 0 to 14400');
   return false;
  }
  if((document.rtp.ptl.selectedIndex == 1) && (!((document.rtp.maxbuf.value == 0) || (document.rtp.maxbuf.value == 512) || (document.rtp.maxbuf.value == 1024) || (document.rtp.maxbuf.value == 2048) || (document.rtp.maxbuf.value == 4096))))
    {
           alert('UDP Max Buffer Size should be zero or a number in power of 2 and between 512 and 4096');
           return false;
        }
        
  if((document.rtp.ptl.selectedIndex == 1) && (!(((document.rtp.maxData.value >=214)
  && (document.rtp.maxData.value <= 512)) || (document.rtp.maxData.value == 0))))
    {
         alert('UDP Max Datagram Size should be zero or a number between 214 and 512');
         return false;
    }

  document.rtp.maxbuf.disabled=false;
  document.rtp.maxData.disabled=false;
  document.rtp.ecRed.disabled=false;
  document.rtp.ecFec.disabled=false;
  return true;
}

function ChangeDTMF()
{
	var selType = document.rtp.dtmf.selectedIndex;

  if( selType == 1)
  {
    document.rtp.payload.disabled = false;
  }
  else
  {
    document.rtp.payload.disabled = true;
  }
}

function InitForm()
{
	
	if( ARateMgn[1] != 1)
//	if(AMaxDgram[2] != 0 && AMaxBuf[2] !=0 )
		document.rtp.ptl.selectedIndex=1;
	else
		document.rtp.ptl.selectedIndex=0;

	ChangeDTMF();/* For voicemedia settings */
/*  alert('Init 3');*/
		
  ProtoCh(); /*For fax settings */

}
</script>
    </head>

    <body class="decBackgroundDef" onLoad="InitForm();">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
               

                <li><a href="voip_profile_SIP.asp"><span>SIP
                Server</span></a></li>
				<!--
 <li><a href=
                "voip_profile_stun.htm"><span>STUN</span></a></li> -->
                <li><a href="voip_profile_ua.asp"><span>User
                Agent</span></a></li>

                <li><a href="#" class=
                "selected"><span>Media</span></a></li>

                <li><a href="voip_profile_vms.asp"><span>Voice
                Mail</span></a></li>
            </ul>
        </div>
        <br />
<span class="textTitle">Service &gt; Media</span>


        <div align="center">
            <table class="tableInput" summary="">
            	<FORM ACTION="/goform/ifx_set_voip_sip_rtp" METHOD="POST" NAME="rtp" >
<input type="hidden" name="page" value="voip_profile_Media.asp">
<input type="hidden" name="status" value="0">
<input type="hidden" name="cvflag" value="0">
                <tr>
                    <th colspan="4">RTP/RTCP</th>
                </tr>

                <tr>
                    <td>Start Port</td>

                    <td><input type="text" name="sport" size="5" value="<%ifx_get_voip_sip_rtp("sport");%>" /> </td>
</tr>
<tr>
                    <td>End Port</td>

                    <td><input type="text" name="eport" size="5" value="<%ifx_get_voip_sip_rtp("eport");%>" /> </td>
                </tr>

                

                <tr>
                    <th colspan="4" class="subdivision">Fax</th>
                </tr>

                <tr>
                    <td>Transport Protocol</td>

                    <td><select name="ptl" size="1" onChange="ProtoCh();">
             <option value=0>TCP</option>
             <option value=1>UDP</option>
        </select></td></td>
</tr>

                <tr>
                    <td>Rate Management</td>

                    <td><select name="rateMgn" size="1">
             <option value="1" selected="selected">TCF_LOCAL</option>
             <option value="2">TCF_TRANSFERRED</option>
             </select></td>
                </tr>

                <tr>
                    <td>Max Bit Rate</td>

                    <td><input type="int" maxLength="10" name="bitRate" size="10" value="" /></td>
</tr>

                <tr>
                    <td>UDP Error Correction</td>

                    <td><input type="checkbox" name="ecRed" value="1" >Redundancy&nbsp; &nbsp;<input type="checkbox" name="ecFec" value="2">FEC</td>
                </tr>

                <tr>
                    <td>UDP Max Buffer Size</td>

                    <td><input type="int" maxLength="5" name="maxbuf" size="5" value="" /></td>
</tr>

                <tr>
                    <td>UDP Max Datagram Size</td>

                    <td><input type="int" maxLength="5" name="maxData" size="5" value="" /></td>
                </tr>

                <tr>
                    <th colspan="4" class="subdivision">DTMF</th>
                </tr>

                <tr>
                    <td>DTMF Digit Exchange Mode</td>

                    <td><select name="dtmf" size="1" onChange="ChangeDTMF();">
 	    			<% ifx_get_voip_sip_media("dtmf");%>
            	</select></td>
                </tr>

                <tr>
                    <td>DTMF Digit Exchange
                    Payload</td>

                    <td><input type="text" name="payload" value="<% ifx_get_voip_sip_media("payload");%>" size="4" /></td>
                </tr>
				<tr>
					<th colspan="2">QoS</th>
					</tr>
					
<tr id="ARow8">
    
                    <td>DSCP Marking for SIP</td>

                    <td><input type="text" maxLength="5" name="SIPDSCPMark" size="5" value="<%ifx_get_voip_sip_param("DSCPMark");%>"></td>
					
                </tr>
				<tr>
                    <td>DSCP Marking for RTP/RTCP</td>

                    <td><input type="text" name="DSCPMark" size="5" value="<%ifx_get_voip_sip_rtp("DSCPMark");%>" /> </td>
                </tr>
				
				<tr>
					<td align="right" colspan="2"><button type="submit" onClick="return submitRTP();">Apply</button></td>
				</tr>
				</form>
            </table>
           
             
        </div>
    </body>
</html>

