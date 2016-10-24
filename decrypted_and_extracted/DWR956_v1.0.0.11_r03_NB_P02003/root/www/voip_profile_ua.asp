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
	<script type="text/javascript">
		function submitUSER()
{ 
  	var TinitialVal = document.sipuser.Tinitial.value;
	var TmaxVal= document.sipuser.Tmax.value;
  if(isBlank(document.sipuser.UserAgentHeader.value))
  {
    alert("User Agent Header can not be blank");
		return false;
  } 
	if (!isValidHeader(document.sipuser.UserAgentHeader.value))
  {
     alert("Invalid User Agent Header");
		return false;
	}

	if(isBlank(document.sipuser.Tinitial.value))
	{
		alert("SIP Initial Timer can not be blank");
    return false;
	}

	if(isBlank(document.sipuser.Tmax.value))
	{
		alert("SIP Timer Maximum value can not be blank");
    return false;
	}
    	    
	if (isNaN(TinitialVal)|| TinitialVal<50 || TinitialVal>1000)
	{
		alert("SIP Initial Timer must be between 50 to 1000");
		return false;
	}

	if (isNaN(TmaxVal) || TmaxVal<3200 || TmaxVal>64000)
	{
		alert("SIP Timer Maximum must be between 3200 to 64000");
		return false;
	}
    if (TmaxVal > (TinitialVal *64))
    {
			alert("SIP Timer Maximum must be less than  (64 * SIP Initial Timer)");
			return false;
    }
	return true;

}
	</script>

        <title></title>
    </head>

    <body class="decBackgroundDef">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                

                <li><a href="voip_profile_SIP.asp"><span>SIP
                Server</span></a></li>
<!-- <li><a href=
                "voip_profile_stun.htm"><span>STUN</span></a></li> -->
                <li><a href="#" class="selected"><span>User
                Agent</span></a></li>

                <li><a href=
                "voip_profile_Media.asp"><span>Media</span></a></li>

                <li><a href="voip_profile_vms.asp"><span>Voice
                Mail</span></a></li>
            </ul>
        </div>
        <br />
<span class="textTitle">Service &gt; User Agent</span>

         

        <div align="center">
        	<FORM ACTION="/goform/ifx_set_voip_sip_useragent" METHOD="POST" NAME="sipuser">
<input type="hidden" name="page" value="voip_profile_ua.asp">
<input type="hidden" name="status" value="0">
<input type="hidden" name="cvflag" value="0">
            <table class="tableInput" summary="">
                

                <tr id="ARow1">
                    <th colspan="4" class="subdivision">Advanced Options</th>
                </tr>

                <tr id="ARow2">
                    <td>Call On Hold Indication</td>

                    <td><select name="CallOnHold" size="1">  
 	     <% ifx_get_voip_sip_useragent("CallOnHold");%>
            </select></td>
                </tr>
				<tr>
                    <td>Use Compact Header</td>

                    <td><select name="hdr" size="1">  
             <% ifx_get_voip_sip_useragent("hdr");%>
            </select></td>
                </tr>

                <tr id="ARow3">
                    <td>User Agent Header</td>

                    <td colspan="2"><input type="text" maxLength="250" name="UserAgentHeader" size="20" value="<%ifx_get_voip_sip_useragent("UserAgentHeader");%>"></td>
                </tr>

                <tr id="ARow4">
                    <td>SIP Initial Timer</td>

                    <td><input type="INT" maxLength="5" name="Tinitial" size="5" value="<%ifx_get_voip_sip_param("Tinitial");%>"> ms</td>
</tr>
<tr id="ARow5">
    
                    <td>SIP Timer Maximum</td>

                    <td><input type="INT" maxLength="5" name="Tmax" size="5" value="<%ifx_get_voip_sip_param("Tmax");%>"> sec</td>
                </tr>

              
                <tr>
                    <td align="left">&nbsp;</td>

                    <td colspan="2" align="right"><br />
                     <button type="submit" onClick="return submitUSER();"><span>Apply</span></button> </td>
                </tr>
            </table>
			</form>
        </div>
    </body>
</html>

