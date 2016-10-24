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
function FormInit_t38()
{
	document.t38.oldAsn.selectedIndex = <%ifx_get_voip_sip_t38("oldAsn");%>;
}
function submitT38()
{
  if(isNaN(document.t38.nsx.value) || document.t38.nsx.value < 0 )
  {
   alert('NSX Size should be an +ve integer');
   return false;
  }

  if(isNaN(document.t38.nsxinfo.value) || document.t38.nsxinfo.value < 0 )
  {
   alert('NSX InfoField should be an +ve integer');
   return false;
  }

if(isNaN(document.t38.wtime.value) || document.t38.wtime.value < 0)
  {
   alert('Data Wait Time should be an +ve integer');
   return false;
  }
  if(isNaN(document.t38.hrPkt.value) || document.t38.hrPkt.value < 0)
  {
   alert('UDP High Rate Error Recovery Packets should be an +ve integer');
   return false;
  }
  if(isNaN(document.t38.lrPkt.value) || document.t38.lrPkt.value < 0)
  {
   alert('UDP Low Rate Error Recovery Packets should be an +ve integer');
   return false;
  }

  if(isNaN(document.t38.priPkt.value) || document.t38.priPkt.value < 0 )
  {
   alert('UDP Prior Packets for FEC should be an +ve integer');
   return false;
  }
  return true;
}
</script>
    </head>

    <body class="decBackgroundDef" onLoad="FormInit_t38();">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                <li><a href="voip_sys_speeddial.asp"><span>Speed
                Dial</span></a></li>
                <li><a href=
                "voip_sys_callblock.asp"><span>Call Block</span></a></li>
                <li><a href="voip_sys_NumPlan.asp"><span>Numbering
                Plan</span></a></li>
						<li><a href="#" class="selected"><span>Fax over IP</span></a></li>
             <li><a href="voip_sys_Debug.asp"><span>Debug</span></a></li>

<!--                <li><a href="voip_sys_callregister.htm"><span>Call
                Register</span></a></li>
-->			
            </ul>
        </div>
        <br />
<span class="textTitle">System &gt; Fax Over IP</span>       

        <div align="center">
            <table class="tableInput" summary="Table">
            	<form name="t38" method="post" action="/goform/ifx_set_voip_sip_t38" onsubmit="return submitT38();">
							<input type="hidden" name="page" value="voip_sys_fax.asp">
                <tr>
                    <th colspan="2">Fax over IP</th>
                </tr>
				  <tr>
    	 <td>Fax Interface</td>
		  <td>		  
            <select name="port" size="1">                
						<%ifx_get_voip_sip_misc("port");%>
            </select>             
         </td>            
		 </tr>

                <tr>
    	 <td>Old ASN.1 </td>
		  <td>		  
            <select name="oldAsn" size="1">                
             <option value="0" selected="selected">OFF</option>
             <option value="1">ON</option>
            </select>            
         </td>            
		 </tr>
		 <tr>        
    	 <td>NSX(Non Standard Functions) Size </td>

    	 <td>
    	   <input type="INT" maxLength="5" name="nsx" size="6" value="<%ifx_get_voip_sip_t38("nsx");%>">
         </td>
        </tr>
  <tr>
    	 <td>NSX(Non Standard Functions) Info </td>
    	 <td>
    	   <input type="INT" maxLength="6" name="nsxinfo" size="6" value="<%ifx_get_voip_sip_t38("nsxinfo");%>">
         </td>
		 </tr>
		 <tr>
    	 <td>Data Wait Time </td>
    	 <td>
    	   <input type="INT" maxLength="5" name="wtime" size="6" value="<%ifx_get_voip_sip_t38("wtime");%>"> ms
         </td>
        </tr>
        <tr>
    	 <td>UDP High Rate Error Recovery Packets </td>

    	 <td>
    	   <input type="INT" maxLength="5" name="hrPkt" size="6" value="<%ifx_get_voip_sip_t38("hrPkt");%>">
         </td>
		 </tr>
		 <tr>
    	 <td>UDP Low Rate Error Recovery Packets </td>
    	 <td>
    	    <input type="INT" maxLength="5" name="lrPkt" size="6" value="<%ifx_get_voip_sip_t38("lrPkt");%>">
         </td>
        </tr>        
        <tr>

    	 <td>UDP Prior Packets for FEC </td>
    	 <td>
    	   <input type="INT" maxLength="5" name="priPkt" size="6" value="<%ifx_get_voip_sip_t38("priPkt");%>">
         </td>
		 </tr>
		 <tr>
    	 <td>T38 Connection </td>
    	 <td>
            <input type="radio" name="perCon" value="1" <%ifx_get_voip_sip_t38("perCon","1");%>>UDP&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="perCon" value="2" <%ifx_get_voip_sip_t38("perCon","2");%>>TCP&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="perCon" value="3" <%ifx_get_voip_sip_t38("perCon","3");%>>UDP_TCP&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" name="perCon" value="4" <%ifx_get_voip_sip_t38("perCon","4");%>>TCP_UDP&nbsp;&nbsp;&nbsp;&nbsp; 
       </td>
        </tr>
		<tr>
			<td colspan="2"><br></td>
			</tr>
<tr>
	<td colspan="2" align="right"><button type="submit">Apply</button></td>
</tr>
            </table>
            <br />
             <!--
                                                        <div class="inputbuttons">
                                                            <button>Apply</button>
                                                            <button>Cancel</button>
                                                        </div>  
                                                        -->
        </div>
    </body>
</html>

