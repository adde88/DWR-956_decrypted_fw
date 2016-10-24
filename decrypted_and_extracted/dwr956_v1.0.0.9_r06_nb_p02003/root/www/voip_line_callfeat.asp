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

        <title></title>
		<script type="text/javascript">
			function MakeArray(n)
{
   this.length = n
   for (i = 0;i<n;i++)
      this[i] = null;
}

var AFwdStatus = new MakeArray(7);      
var AAddtype  = new MakeArray(7);
var ADname  = new MakeArray(7);
var AUname  = new MakeArray(7);
var ACall  = new MakeArray(7);
var APort  = new MakeArray(7);
var Aptl  = new MakeArray(7);
var ON=1,OFF=0;
AFwdStatus[0] = 0;
AAddtype[0] = 0;
ADname[0]="";
AUname[0]="";
ACall[0]="";
APort[0]="";
Aptl[0]=0;

<%ifx_get_voip_sip_phone("PopulateArray");%>
  
			nm='The port number must be between 1024 to 65535.';
function changeForwards(){
					if(document.callfeatures.callforward.selectedIndex == ON){
                document.callfeatures.full1.disabled = true;
                document.callfeatures.full2.disabled = true;
                document.callfeatures.full3.disabled = true;
								return;
						}else{
						if (document.callfeatures.fwdStatus1.selectedIndex == ON) 
                document.callfeatures.full1.disabled = false;
            if (document.callfeatures.fwdStatus2.selectedIndex == ON) 
                document.callfeatures.full2.disabled = false;
            if (document.callfeatures.fwdStatus3.selectedIndex == ON) 
                document.callfeatures.full3.disabled = false;
						}
}

        function submitCALLFEATURES(){
            var Temp;
            if (isPSTN(document.callfeatures.full1.value)) {
                document.callfeatures.addtype1.value = 1;
                document.callfeatures.uname1.value = document.callfeatures.full1.value;
                document.callfeatures.calladdr1.value = 0;
                document.callfeatures.portNo1.value = 0;
            }else{
								document.callfeatures.addtype1.value = 2;
								Temp=parse(document.callfeatures.full1.value);
							 	document.callfeatures.uname1.value = Temp[0]; 
                document.callfeatures.calladdr1.value = Temp[2];
                document.callfeatures.portNo1.value = Temp[3];
}
			
            if (isPSTN(document.callfeatures.full2.value)) {
                document.callfeatures.addtype2.value = 1;
                document.callfeatures.uname2.value = document.callfeatures.full2.value;
                document.callfeatures.calladdr2.value = 0;
                document.callfeatures.portNo2.value = 0;
            }else{
			document.callfeatures.addtype2.value = 2;
			Temp=parse(document.callfeatures.full2.value);
							 	document.callfeatures.uname2.value = Temp[0]; 
                document.callfeatures.calladdr2.value = Temp[2];
                document.callfeatures.portNo2.value = Temp[3];

}
			
            if (isPSTN(document.callfeatures.full3.value)) {
                document.callfeatures.addtype3.value = 1;
                document.callfeatures.uname3.value = document.callfeatures.full3.value;
                document.callfeatures.calladdr3.value = 0;
                document.callfeatures.portNo3.value = 0;
            }else{
			document.callfeatures.addtype3.value = 2;
			Temp=parse(document.callfeatures.full3.value);
							 	document.callfeatures.uname3.value = Temp[0]; 
                document.callfeatures.calladdr3.value = Temp[2];
                document.callfeatures.portNo3.value = Temp[3];
}
			
        
            if ((document.callfeatures.fwdStatus1.selectedIndex!=0 && isNValidSIPPort(document.callfeatures.portNo1.value)) && (document.callfeatures.fwdStatus2.selectedIndex!=0 && isNValidSIPPort(document.callfeatures.portNo2.value)) && (document.callfeatures.fwdStatus3.selectedIndex!=0 && isNValidSIPPort(document.callfeatures.portNo3.value))) {
                alert(nm);
                return false;
            }
            
            if (document.callfeatures.fwdStatus1.selectedIndex != 0 &&
            document.callfeatures.addtype1.value != 1 &&
            isBlank(document.callfeatures.calladdr1.value)) {
                alert('CALL FWD Address cannot be blank');
                return false;
            }
            
            if (document.callfeatures.fwdStatus2.selectedIndex != 0 &&
            document.callfeatures.addtype2.value != 1 &&
            isBlank(document.callfeatures.calladdr2.value)) {
                alert('CALL FWD Address cannot be blank');
                return false;
            }
            
            if (document.callfeatures.fwdStatus3.selectedIndex != 0 &&
            document.callfeatures.addtype3.value != 1 &&
            isBlank(document.callfeatures.calladdr2.value)) {
                alert('CALL FWD Address cannot be blank');
                return false;
            }
            
            if (document.callfeatures.fwdStatus1.selectedIndex != 0 &&
            document.callfeatures.addtype1.value == 1 &&
            isBlank(document.callfeatures.uname1.value)) {
                alert('User Name cannot be blank');
                return false;
            }
            if (document.callfeatures.fwdStatus2.selectedIndex != 0 &&
            document.callfeatures.addtype2.value == 1 &&
            isBlank(document.callfeatures.uname2.value)) {
                alert('User Name cannot be blank');
                return false;
            }
            if (document.callfeatures.fwdStatus3.selectedIndex != 0 &&
            document.callfeatures.addtype3.value == 1 &&
            isBlank(document.callfeatures.uname3.value)) {
                alert('User Name cannot be blank');
                return false;
            }
			
            /* Same validation for Unconditional,No Answer and Busy if selected */
            /* Forward Status ON and IP Address is selected */
			/*
            if (document.callfeatures.fwdStatus.selectedIndex != 0 &&
            document.callfeatures.addtype.value == 0 &&
            !validateIP(document.callfeatures.calladdr.value)) {
                alert('Invalid IP address');
                return false;
            }
			*/
            /* Forward Status ON and TEL number is selected */
            if (document.callfeatures.fwdStatus1.selectedIndex != 0 &&
            document.callfeatures.addtype1.value == 1 &&
            !isNAN(document.callfeatures.uname1.value)) {
                alert('Invalid Tel no');
                return false;
            }
            if (document.callfeatures.fwdStatus2.selectedIndex != 0 &&
            document.callfeatures.addtype2.value == 1 &&
            !isNAN(document.callfeatures.uname2.value)) {
                alert('Invalid Tel no');
                return false;
            }
            if (document.callfeatures.fwdStatus3.selectedIndex != 0 &&
            document.callfeatures.addtype3.value == 1 &&
            !isNAN(document.callfeatures.uname3.value)) {
                alert('Invalid Tel no');
                return false;
            }
            /* Forward Status ON and SIP address is selected */
            if (document.callfeatures.fwdStatus1.selectedIndex != 0 &&
            ((document.callfeatures.callforward.selectedIndex == 0)&&(document.callfeatures.addtype1.value == 2 &&
            !isValidDomain(document.callfeatures.calladdr1.value)))) {
                alert('Invalid SIP Address');
                return false;
            }
            if (document.callfeatures.fwdStatus2.selectedIndex != 0 &&
            ((document.callfeatures.callforward.selectedIndex == 0)&&(document.callfeatures.addtype2.value == 2 &&
            !isValidDomain(document.callfeatures.calladdr2.value)))) {
                alert('Invalid SIP Address');
                return false;
            }
            if (document.callfeatures.fwdStatus3.selectedIndex != 0 &&
            ((document.callfeatures.callforward.selectedIndex == 0)&&(document.callfeatures.addtype3.value == 2 &&
            !isValidDomain(document.callfeatures.calladdr3.value)))) {
                alert('Invalid SIP Address');
                return false;
            }
			
            if ((document.callfeatures.fwdRing.disabled == false) && (isNaN(document.callfeatures.fwdRing.value))) {
                alert('Forward Ring Count should be an integer ');
                return false;
            }
            
            if (document.callfeatures.fwdStatus2.selectedIndex != 0 &&
            (document.callfeatures.fwdRing.value < 1 ||
            document.callfeatures.fwdRing.value > 10)) {
                alert('Number of ring counts can have values b/w 1 to 10 ');
                return false;
            }
            
            /*if (document.callfeatures.fwdRing.value < 1 || document.callfeatures.fwdRing.value > 10) {
                alert('Forward Ring Count should be b/w 1 to 10 ');
                return false;
            }
            
            if ((document.callfeatures.fwdStatus.selectedIndex != 0 &&
             document.callfeatures.fwd.selectedIndex == 1 )&&
             (document.callfeatures.fwdRing.value < 1 ||
             document.callfeatures.fwdRing.value >10))
             {
             alert('Number of ring counts can have values b/w 1 to 10 ');
             return false;
             }*/
            
            if ((document.callfeatures.fwdStatus1.selectedIndex == 1) &&
            (isBlank(document.callfeatures.uname1.value))) {
                alert('Forward Number should not be blank');
                return false;
            }
            if ((document.callfeatures.fwdStatus2.selectedIndex == 1) &&
            (isBlank(document.callfeatures.uname2.value))) {
                alert('Forward Number should not be blank');
                return false;
            }
            if ((document.callfeatures.fwdStatus3.selectedIndex == 1) &&
            (isBlank(document.callfeatures.uname3.value))) {
                alert('Forward Number should not be blank');
                return false;
            }
            
            if ((document.callfeatures.fwdStatus1.selectedIndex == 1) &&
            (!isValidName(document.callfeatures.uname1.value))) {
                alert('Invalid Forward Number');
                return false;
            }
            if ((document.callfeatures.fwdStatus2.selectedIndex == 1) &&
            (!isValidName(document.callfeatures.uname2.value))) {
                alert('Invalid Forward Number');
                return false;
            }	
            if ((document.callfeatures.fwdStatus3.selectedIndex == 1) &&
            (!isValidName(document.callfeatures.uname3.value))) {
                alert('Invalid Forward Number');
                return false;
            }					
            if (check_CF() == false) 
                return false;
            
            document.callfeatures.fwdRing.disabled = false;
				//if, voice mail is on
         if (document.callfeatures.callforward.selectedIndex == ON){
							document.callfeatures.uname1.value=0;
        			document.callfeatures.calladdr1.value=0;
        			document.callfeatures.portNo1.value=0;
							document.callfeatures.uname2.value=0;
        			document.callfeatures.calladdr2.value=0;
        			document.callfeatures.portNo2.value=0;
						  document.callfeatures.uname3.value=0;
        		  document.callfeatures.calladdr3.value=0;
        		  document.callfeatures.portNo3.value=0;
					} 
					 //document.callfeatures.uname.disabled = false;
            
            return true;
        }
		function check_CF()
{
 var bCFtoVmsStatus = document.callfeatures.callforward.selectedIndex;
 var seltype = (document.callfeatures.fwdStatus1.selectedIndex || document.callfeatures.fwdStatus2.selectedIndex || document.callfeatures.fwdStatus3.selectedIndex);   
 
  if ((document.callfeatures.callforward.disabled == false) && (bCFtoVmsStatus == 1) && (seltype == 0))
    {
         alert('Voice Mail is ON! Please enable the selected Call Forwarding Type to enable Call Forward to it');
         document.callfeatures.callforward.selectedIndex = 0;
         //document.callfeatures.uname.value = "";
         return false;
      }
        
 return true;
}
        function updateForwarding(){
            var seltype1 = document.callfeatures.fwdStatus1.selectedIndex;
            var seltype2 = document.callfeatures.fwdStatus2.selectedIndex;
            var seltype3 = document.callfeatures.fwdStatus3.selectedIndex;
            if (seltype1 == 0 || document.callfeatures.callforward.selectedIndex == 1) {
                document.callfeatures.full1.disabled = true;
            }
            else {
                document.callfeatures.full1.disabled = false;
            }
            if (seltype2 == 0 || document.callfeatures.callforward.selectedIndex == 1) {
                document.callfeatures.full2.disabled = true;
            }
            else {
                document.callfeatures.full2.disabled = false;
            }
            if (seltype3 == 0 || document.callfeatures.callforward.selectedIndex == 1) {
                document.callfeatures.full3.disabled = true;
            }
            else {
                document.callfeatures.full3.disabled = false;
            }
            if (document.callfeatures.fwdStatus2.selectedIndex != 1) 
                document.callfeatures.fwdRing.disabled = true;
           else
							document.callfeatures.fwdRing.disabled = false;
 
            return true;
        }


function ChangeFwdType()
{     
        document.callfeatures.fwdStatus1.selectedIndex=AFwdStatus[1];
        document.callfeatures.addtype1.value=AAddtype[1];

        document.callfeatures.uname1.value=AUname[1];
        document.callfeatures.calladdr1.value=ACall[1];
        document.callfeatures.portNo1.value=APort[1];
		document.callfeatures.full1.value=AUname[1]+"@"+ACall[1]+":"+APort[1];
      

        document.callfeatures.fwdStatus2.selectedIndex=AFwdStatus[2];
        document.callfeatures.addtype2.value=AAddtype[2];
  
        document.callfeatures.uname2.value=AUname[2];
        document.callfeatures.calladdr2.value=ACall[2];
        document.callfeatures.portNo2.value=APort[2];
		document.callfeatures.full2.value=AUname[2]+"@"+ACall[2]+":"+APort[2];

		
		    document.callfeatures.fwdStatus3.selectedIndex=AFwdStatus[3];
        document.callfeatures.addtype3.value=AAddtype[3];

        document.callfeatures.uname3.value=AUname[3];
        document.callfeatures.calladdr3.value=ACall[3];
        document.callfeatures.portNo3.value=APort[3];
		    document.callfeatures.full3.value=AUname[3]+"@"+ACall[3]+":"+APort[3];
		 /*if (document.callfeatures.callforward.selectedIndex == 1){
				 document.callfeatures.full1.disabled=true;
				 document.callfeatures.full2.disabled=true;
				 document.callfeatures.full3.disabled=true;
			}*/
     return true;
}


function Initshow()
{
  ChangeFwdType(); 
	updateForwarding();
   
 return true;
 }


		</script>
    </head>

    <body class="decBackgroundDef" onLoad="Initshow();" >
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                <li><a href="voip_line_voip.asp"><span>Terminals</span></a></li>

                <li><a href="voip_line_sip.asp"><span>SIP
                Account</span></a></li>

                <li><a href="voip_line_callfeat.asp" class=
                "selected"><span>Calling Features</span></a></li>

                <li><a href=
                "voip_line_codec.asp"><span>Media</span></a></li>
				<li><a href=
                "voip_line_callregister.asp"><span>Call Register</span></a></li>
				<li><a href=
                "voip_line_contactlist.asp"><span>Contact List</span></a></li>
            </ul>
        </div>
		<br>
         
         <span class="textTitle"><%ifx_get_voip_sip_linestate("LineNo");%> &gt; Call Options</span>

        <div align="center">
            <table class="tableInput" style="width: 70%;" summary=
            "">
			<FORM ACTION="/goform/ifx_set_voip_sip_phone" METHOD="POST" NAME="callfeatures" onSubmit="return submitCALLFEATURES();">
<input type="hidden" name="page" value="voip_line_callfeat.asp">
<input type="hidden" name="portChg" value="0">
<input type="hidden" name="status" value="0">
<input type="hidden" name="cvflag" value="0">
                <tr>
                    <th colspan="2">Call Options</th>
                </tr>

                <tr>
                    <td>Caller ID Suppression</td>

                    <td><SELECT NAME="callid">	
							<%ifx_get_voip_sip_phone("callid");%>
							</SELECT></td>
</tr>
<tr>
                    <td>Do Not Disturb</td>

                    <td><SELECT NAME="dnd">				
							<%ifx_get_voip_sip_phone("dnd");%>
</SELECT></td>
                </tr>

                <tr>
                    <td>Call Waiting</td>

                    <td><SELECT NAME="callwaiting">												
							<%ifx_get_voip_sip_phone("callwaiting");%>
							</SELECT></td>
</tr>
<tr>
                    <td>Anonymous Call Block</td>

                    <td><SELECT NAME="anoncallblock">		
							<%ifx_get_voip_sip_phone("anoncallblock");%>
</SELECT></td>
                </tr>

                <tr>
                    <td>Message Waiting Indication</td>

                    <td><SELECT NAME="EnMwi">
							<%ifx_get_voip_sip_phone("EnMwi");%>
							</SELECT></td>
</tr>
<tr>
	<th colspan="2">Call Forward</th>
</tr>
<tr>
                    <td>Ring Count</td>

                    <td><INPUT TYPE=TEXT NAME="fwdRing" SIZE=10 value="<%ifx_get_voip_sip_phone("fwdRing");%>"></td>
                </tr>

<tr>
                    <td>Voice Mail</td>

                    <td><SELECT NAME="callforward" onchange="changeForwards();">
							<%ifx_get_voip_sip_phone("callforward");%>
</SELECT></td>
                </tr>
                <tr>
                    <td>Unconditional</td>
					<input type="hidden" maxLength="31" name="uname1"  size="16" />
<input type="hidden" name="calladdr1" size="16" />
<input type="hidden" name="portNo1" size="16" />
<input type="hidden" name="addtype1" size="16" />


                    <td><select name="fwdStatus1" onchange=
                    "updateForwarding();">
                        <option value="0">
                            OFF
                        </option>

                        <option value="1">
                            ON
                        </option>
                    </select>&nbsp;&nbsp;&nbsp;	Address <input disabled="disabled" maxlength="31"
                    name="full1" size="16" type="TEXT" /></td>
				
                <tr>
                    <td>No Answer</td>
					<input type="hidden" maxLength="31" name="uname2"  size="16" />
<input type="hidden" name="calladdr2" size="16" />
<input type="hidden" name="portNo2" size="16" />
<input type="hidden" name="addtype2" size="16" />

                    <td><select name="fwdStatus2" onchange=
                    "updateForwarding();">
                        <option value="0">
                            OFF
                        </option>

                        <option value="1">
                            ON
                        </option>
                    </select>&nbsp;&nbsp;&nbsp;	Address <input disabled="disabled" maxlength="31"
                    name="full2" size="16" type="TEXT" /></td>
				
                <tr>
                    <td>Busy</td>
					<input type="hidden" maxLength="31" name="uname3"  size="16" />
<input type="hidden" name="calladdr3" size="16" />
<input type="hidden" name="portNo3" size="16" />
<input type="hidden" name="addtype3" size="16" />

                    <td><select name="fwdStatus3" onchange=
                    "updateForwarding();">
                        <option value="0">
                            OFF
                        </option>
                        <option value="1">
                            ON
                        </option>
                    </select>&nbsp;&nbsp;&nbsp;	Address <input disabled="disabled" maxlength="31"
                    name="full3" size="16" type="TEXT" /></td>
</tr>
                <tr>
                    <td colspan="2" align="right">
                    <button type="submit">Apply</button></td>
                </tr>
            </table>
					</FORM>
        </div>
    </body>
</html>

