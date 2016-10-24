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
		<script language="JavaScript" type="text/javascript" src="validations.js"></script>
		
		<script language="JavaScript">

function delAllCall()
{
	document.call_reg.misscall.value = 0;
  document.call_reg.dialcall.value = 0;
  document.call_reg.recvcall.value = 0;
  document.call_reg.delall.value = 1;
  document.call_reg.submit(); 
  return true;
}


function delMissCall()
{
	document.call_reg.misscall.value = 1;
  document.call_reg.dialcall.value = 0;
  document.call_reg.recvcall.value = 0;
  document.call_reg.delall.value = 0;
  document.call_reg.submit(); 
  return true;
}

function delDialCall()
{
	document.call_reg.misscall.value = 0;
  document.call_reg.dialcall.value = 1;
  document.call_reg.recvcall.value = 0;
  document.call_reg.delall.value = 0;
  document.call_reg.submit(); 
  return true;
}

function delRecvCall()
{
	document.call_reg.misscall.value = 0;
  document.call_reg.dialcall.value = 0;
  document.call_reg.recvcall.value = 1;
  document.call_reg.delall.value = 0;
  document.call_reg.submit(); 
  return true;
}



</script>
    </head>

    <body class="decBackgroundDef">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">                                                                                                                                          
                <li><a href=                                                                                                                                          
                "voip_line_pstn.asp" class="selected"><span>Terminals</span></a></li>                                                                                 
        <li><a href=                                                                                                                                                  
                "pstn_line_callregister.asp"><span>Call Register</span></a></li>                                                                                      
        <li><a href=                                                                                                                                                  
                "pstn_line_contactlist.asp"><span>Contact List</span></a></li>                                                                                        
            </ul>                                              
        </div>
		<br>
         
         <span class="textTitle"><%ifx_get_voip_sip_pstn("pstn_name")%> &gt; Call Register</span>
        <div align="center">
<FORM ACTION="/goform/ifx_set_voip_sip_cr" METHOD="POST" NAME="call_reg">
<input type="hidden" name="page" value="pstn_line_callregister.asp">
<input type="hidden" name="userlevel" value=<%ifx_get_currentUser_authority();%>>
<input type="hidden" name="misscall" value="0">
<input type="hidden" name="dialcall" value="0">
<input type="hidden" name="recvcall" value="0">
<input type="hidden" name="delall" value="0">
 <table class="tableInfo">
 <tr>
 <th colspan="4" class="curveLeft"><span class="cellWrapper"><img src="images/RightCurve.png" alt=""></span>Call Register</th>
 </tr>
         <tr class="callregister">
           <td align="center">
 &nbsp;&nbsp;&nbsp;&nbsp;Missed Call<BR>
 [Date/Time: Destination]</td>
           <td align="center">
 &nbsp;&nbsp;&nbsp;&nbsp;Received Call<BR>
 [Date/Time: Destination]</td>
           <td align="center">
 &nbsp;&nbsp;&nbsp;&nbsp;Dialed Call<BR>
 [Date/Time: Destination]</td>
         </tr>
         <%ifx_get_voip_sip_cr("cr");%>
    <tr>
    	 <td><button onClick="delMissCall();">Delete</button></td>
       <td><button onClick="delRecvCall();">Delete</button></td>
       <td><button onClick="delDialCall();">Delete</button></td>
		</tr>
       </table>
       <table class="tableInfo">
		<tr  class="tableEmptyRow" >
      <td colspan="3"><button class="buttonLarge" onClick="delAllCall();">Delete All </button></td>
			</td>
     </tr>
       </table>
	</FORM>
     </div>
    </body>
</html>

