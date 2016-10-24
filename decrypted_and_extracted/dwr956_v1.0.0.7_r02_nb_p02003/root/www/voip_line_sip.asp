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
		<script language="JavaScript" src="validations.js"></script>
        <title></title>
<script language="JavaScript">

function authParamCheck ()
{
if ( (isBlank(document.voipaccount.authname1.value) )) //|| isBlank(document.voipaccount.authpwd1.value )))
{
alert('Please Enter Auhtorization User Name');
return false;
}
return true;
}

function submitACCOUNT()
{     
		document.voipaccount.authname1.value = document.voipaccount.aname_acc.value;
       if ( isBlank(document.voipaccount.uname_acc.value))
        {
        alert('SIP User Name can not be Blank');
                return false;
        }
       if (!isValidName(document.voipaccount.uname_acc.value))
        {
         alert('Invalid SIP User Name');
         return false;
        }

       if (!isValidName(document.voipaccount.dname_acc.value))
        {
         alert('Invalid SIP Display Name');
         return false;
        }

  /*if (isBlank(document.voipaccount.unameMsgRet.value)  ||
     isBlank(document.voipaccount.unameMsgDep.value))
  {
    alert('Message Waiting Fields cannot be blank ');
    return false;
  }*/

if (authParamCheck() == false) return false;	
/*
 if (isBlank(document.voipaccount.realm1.value) || 
     isBlank(document.voipaccount.authname1.value)    ||
     isBlank(document.voipaccount.authpwd1.value))
{
alert('Field(s) cannot be blank or Invalid Input values');
return false;
}
*/
              
 if (!isBlank(document.voipaccount.authname1.value) && !isValidName(document.voipaccount.authname1.value))
  { 
   alert('Invalid Authorization User Name for entry 1');
   return false;
  }
 if (!isBlank(document.voipaccount.authpwd1.value) && !isValidPasswd(document.voipaccount.authpwd1.value))
  { 
   alert('Invalid Authorization Password for entry 1');
   return false;
  }



       if (!isValidName(document.voipaccount.unameMsgDep.value))
        {
         alert('Invalid Deposit User Name');
         return false;
        }

       if (!isValidName(document.voipaccount.unameMsgRet.value))
        {
         alert('Invalid Retrievel User Name');
         return false;
        }
return true;
}
/*function update_accdata()
{
		document.voipaccount.dname_acc.value="<%ifx_get_voip_sip_user("dname_acc");%>"
		document.voipaccount.uname_acc.value="<%ifx_get_voip_sip_user("uname_acc");%>"

}*/
</script>
</head>
	<body class="decBackgroundDef">
        	<div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                <li><a href=
                "voip_line_voip.asp"><span>Terminals</span></a></li>
                <li><a href="voip_line_sip.asp" class="selected"><span>SIP Account</span></a></li>
				<li><a href="voip_line_callfeat.asp"><span>Calling Features </span></a></li>
				<li><a href="voip_line_codec.asp"><span>Media</span></a></li>
				<li><a href=
                "voip_line_callregister.asp"><span>Call Register</span></a></li>
				<li><a href=
                "voip_line_contactlist.asp"><span>Contact List</span></a></li>				
            </ul>
        </div>
<br>
         
         <span class="textTitle"><%ifx_get_voip_sip_linestate("LineNo");%> &gt; SIP Account</span>

        <div align="center">
		<FORM ACTION="/goform/ifx_set_voip_sip_user" METHOD="POST" NAME="voipaccount" onsubmit= "return submitACCOUNT();" >

		<input type="hidden" name="portChg" value="0">
		<input type="hidden" name="status" value="0">
		<input type="hidden" name="cvflag" value="0">
		<input type="hidden" name="page" value="voip_line_sip.asp">
            <table class="tableInput"  style="width: 70%;" summary="">
					
				<tr>
					<th colspan="2">SIP Account</th>
					</tr>
					<tr><tr>
						<td>Display Name</td>
						<td><INPUT TYPE=TEXT maxLength="31" NAME="dname_acc" SIZE="50" value="<%ifx_get_voip_sip_user("dname_acc");%>"></td>						
						</tr>
						<td>User Name</td>
						<td><INPUT TYPE=TEXT maxLength="31" NAME="uname_acc" SIZE="50" value="<%ifx_get_voip_sip_user("uname_acc");%>"></td>						
						</tr>
						<td>Authentication Name</td>
						<td><INPUT TYPE=TEXT maxLength="31" NAME="aname_acc" SIZE="50" value="<%ifx_get_voip_sip_user("authname1");%>"></td>
						</tr>
						<td>Password</td>
						<td><INPUT TYPE=PASSWORD NAME="authpwd1" maxLength="15" SIZE="50" VALUE=""></td>						
						
						
						
						
								 <INPUT TYPE=HIDDEN NAME="authname1" maxLength="31"  value="<%ifx_get_voip_sip_user("authname1");%>"> 
								
								 <INPUT TYPE=HIDDEN NAME="realm1" SIZE=25 VALUE="<%ifx_get_voip_sip_user("realm1");%>"> 
								 
								 
								 <INPUT TYPE=HIDDEN NAME="authpwd1" maxLength="15"   VALUE="">
						
						
						
						
						</tr>
						
						<tr>
							<th colspan="2">Voice Mail</th>
							</tr>
						<tr>
						<td>Subscription Status</td>
						<td><input type="textbox" NAME="MWI" SIZE="50" value="<%ifx_get_voip_sip_user("MWI");%>"disabled ></td>						
						</tr>
						<tr>
						<td>Deposit User Name</td>
						<td><INPUT TYPE=TEXT  maxLength="31" NAME="unameMsgDep" SIZE="50" value="<%ifx_get_voip_sip_user("unameMsgDep");%>"></td>						
						</tr>
						<tr>
						<td>Retrieval User Name</td>
						<td><INPUT TYPE=TEXT  maxLength="31" NAME="unameMsgRet" SIZE="50" value="<%ifx_get_voip_sip_user("unameMsgRet");%>"></td>						
						</tr>
						
				<tr>
					<td colspan="2" align="right"><button type = "submit">Apply</button></td>
					</tr>
            </table>
			</FORM>
        </div>
    </body>
</html>

