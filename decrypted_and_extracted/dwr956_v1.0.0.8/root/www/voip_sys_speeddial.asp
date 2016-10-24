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
		var maxAddrBookEntries=0;
		nm='The port number must be between 1024 to 65535.';

			function FormInit()
			{
					updateData_sd();
					return true;
			}
			
		</script>
		<script language="JavaScript">

			function MakeArray(n)
			{
				//allow new array to be made below...
				this.length = n
				for (i = 0;i<n;i++) 
				   this[i] = null;
			}
			var loc = new MakeArray(1); 
			var field  = new MakeArray(loc.length);	
			var AUName = new MakeArray(loc.length);		// User name
			var ADName = new MakeArray(loc.length);		// Display name	
			var AAddr  = new MakeArray(loc.length);
			var APort  = new MakeArray(loc.length);
			var ADial  = new MakeArray(loc.length);
			var AVad   = new MakeArray(loc.length);
			var AAddrType = new MakeArray(loc.length);			
			var ACallType = new MakeArray(loc.length);			
			var Aaddrproto = new MakeArray(loc.length);	
			var orgUser;	
			
		</script>
		<script language="JavaScript">
		
			function check(s)
			{
			 if (!isValidName(document.sd.uname.value))
				   {
					alert('Invalid User Name');
					return false;
				   }

			  if (!isValidName(document.sd.dname.value))
				   {
					alert('Invalid Display Name');
					return false;
				   }
			return true;
			}		

			function updateAddr_sd()
			{
			   var seltype = document.sd.addrtype.value;
			   if (seltype != 1)
			   {
				  document.sd.uname.disabled = false;
				  document.sd.dname.disabled = false;
				  document.sd.tempaddr.disabled = false;

			   }
			   else
			   {
				  document.sd.uname.disabled = false;
				  document.sd.dname.disabled = false;
				  document.sd.tempaddr.disabled = true;

			   }
			}
			
			function getTheCallList(theText, theValue)
			{
				var newOpt = new Option(theText, theValue);
				var theSel ;
				var selLength;

				theSel = document.cbs.psel;
				selLength = theSel.length;
				theSel.options[selLength] = newOpt;
			}

			function delCheck()
			{
			 if ((document.sd.dial.value == '') || (document.sd.uname.value == ''))
			   {
				   alert('Speed Dial list is empty');
					   return false;
			   }
			}			

			function AddF_sd()
			{
				if(maxAddrBookEntries == document.sd.addrEntries.length ){
							alert("Can't Add...!! Max Entries reached");
							return false;
				} 
				SetAttributes();
				if (dataCheck() == false){
					return false;
				}
				document.sd.addflag.value = 1;
				if (checkDialCode("1")== false) {
						return false;
				}
				if (check("1")== false){
						 return false;
				}
				document.sd.modflag.value = 0;
				document.sd.delflag.value = 0;
				document.sd.submit();	
				return true;
			}
			
			function ModifyF_sd()
			{
				if (dataCheck() == false){
					 return false;	
				}
				document.sd.modflag.value = 1;
				if (checkDialCode("1") == false){
					 return false;
				}
				if (check("1")== false) {
								return false;
				}
				document.sd.delflag.value = 0;
				document.sd.addflag.value = 0;
				//alert('In Modify uname' + document.sd.uname.value);
				SetAttributes();
				document.sd.submit();	
				return true;
			}
			function convertProto(str){

				if (str == "UDP") 
					return 1;
				else if (str == "TCP") 
					return 2;
				else if (str == "Auto") 
					return 0;
			}
			function convertProto_value(str){

				if (str == 1) 
					return "UDP";
				else if (str == 2) 
					return "TCP";
				else if (str == 0) 
					return "Auto";
			}
			function display()
			{
				var proto = convertProto_value(document.sd.addrproto.value);
			
				var tempstr = document.sd.addr.value+":"+document.sd.port.value+";transport="+proto;
				
				document.sd.tempaddr.value = tempstr;
			}
			
			function SetAttributes()
			{
				var str = document.sd.tempaddr.value;
				var ReArray = parse(str);
				
				document.sd.addr.value= ReArray[2];
				document.sd.port.value= ReArray[3];
				
				var tprotocol = ReArray[4];

				document.sd.addrproto.value=convertProto(tprotocol);
				
			}
			
			function DelF_sd()
			{
				if (document.sd.addrEntries.length  == 0)
				{
					alert('No Entry');
					return false;
				}
				if ( delCheck() == false) return false;
				if (dataCheck() == false) return false;	
				document.sd.delflag.value = 1;
				document.sd.addflag.value = 0;
				document.sd.modflag.value = 0;
  			document.sd.delallflag.value = 0;
				document.sd.submit();
				return true;
			}

		function DelAllF_sd()
	{
    if ( delCheck() == false) return false;
  	document.sd.delallflag.value = 1;
  	document.sd.delflag.value = 0;
  	document.sd.addflag.value = 0;
  	document.sd.modflag.value = 0;
  	document.sd.submit();
  return true;
}

			function updateData_sd()
			{

				var want = document.sd.addrEntries.selectedIndex;
				// Get current username data
				orgUser = document.sd.uname.value;
				//Add those value to  make Web Browser display correctly without "onChange" 
			
				<%ifx_get_voip_sip_addrbook("updateData");%>

				var num = field[want];
				//changes the different fields based on Entry index
				document.sd.addrEntries.selectedIndex = want;
				document.sd.addr.value= AAddr[num];
				document.sd.dname.value= ADName[num];
				document.sd.uname.value= AUName[num];
				document.sd.port.value= APort[num];
				document.sd.addrproto.value=Aaddrproto[num];
				<%ifx_get_voip_sip_addrbook("ADial");%>
				<%ifx_get_voip_sip_addrbook("DisVad");%>

				if ( AAddrType[num] == 1 || AAddrType[num] == 0)
				{
					document.sd.addrtype.value =1;
				}
				else
				{
					document.sd.addrtype.value =AAddrType[num];
				}
				//if ( AAddrType[want] == 2)
				//{
				//document.sd.addr.disabled = true;
				//}
				document.sd.calltype.selectedIndex = ACallType[num];
				updateAddr_sd();
				updateCallType_sd();	
				display();
			}
			function updateCallType_sd()
			{
			   var selcalltype = document.sd.calltype.selectedIndex;
			   if (selcalltype == 0)
			   {

				  document.sd.uname.disabled = false;
				  document.sd.dname.disabled = false;
				  document.sd.tempaddr.disabled = true;
			   }
			   else if(selcalltype == 1)
			   {

				 document.sd.uname.disabled = false;
				 document.sd.dname.disabled = false;
				 if(document.sd.addrtype.value == 2)
				 {
				   document.sd.tempaddr.disabled = true;
				 }
				 else
				 {
				   document.sd.tempaddr.disabled = false;
				 }
			   }
			   else 
			   {
				 document.sd.uname.disabled = false;
				 document.sd.dname.disabled = false;
				 document.sd.tempaddr.disabled = true;
			   }
			}
			
			function dataCheck()
			{
			  var seltype = document.sd.addrtype.value-1;
			  if (seltype != 1)
			  {
				if(isNValidSIPPort(document.sd.port.value))
				{
					alert(nm);
				   return false;
				}
			  }
			 
				if (document.sd.dial.value == '')
			  {
				alert('Please enter the Dial Code');
				return false;
			  }
			  
			  if (!isValidName(document.sd.dname.value))
			  {
				alert('Invalid Display Name');
				return false;
			  }

			  /* If CallType is VOIP */ 
				if (document.sd.calltype.selectedIndex == 1)
				{
					/* For IP address and SIP address */
					if((document.sd.addrtype.value-1) != 1)
					{	
					if((document.sd.addr.value == '') ||(document.sd.uname.value == ''))
					{
					alert('Please enter the Caller Address and User name both');
					return false;
					}
				  if(!isValidName(document.sd.uname.value))
				  {
					alert('Invalid User Name');
					return false;
				  }

					}
					/* For TEL number */
					else
				  {	
				  if(document.sd.uname.value == '')
				  {
					alert('Please enter UserName/Tel No');
					return false;
				  }
				  if(isNaN(document.sd.uname.value))
				  {
					alert('Invalid Tel No');
					return false;
				  }

					}
				}

				/* If CallType is PSTN or EXTN */
			  if ((document.sd.calltype.selectedIndex != 1) 
								 && 
				 (document.sd.uname.value == ''))
			  {
				  alert('Please enter UserName/Tel No');
				  return false;
			  }

				if ((document.sd.calltype.selectedIndex != 1) 
								 && 
				 isNaN(document.sd.uname.value))
			  {
				  alert('Invalid Tel Number');
				  return false;
			  }

				/* If CallType is VOIP */
				if (document.sd.calltype.selectedIndex == 1) 
				{
					/* Space validation for User name */
				  if (isSpace(document.sd.uname.value))
				{
				  alert('Space is not allowed');
				  return false;
				}
				  /* SIP Address */
				  if ((seltype == 2) && !isValidDomain(document.sd.addr.value))
				  {
					 alert('Invalid IP/Domain Address');
					  return false;
				  }
				  /* TEL number */
			/*
					else if ((seltype == 1) && isNAN(document.sd.addr.value))
				  {
					alert('Invalid Tel No');
					  return false;
				  }
			*/
				  /* IP Address */
					else if ((seltype == 0) && !isValidDomain(document.sd.addr.value))
				  {
					alert('Invalid IP/Domain Address');
					  return false;
				  }
				}
			  return true;
			}
			
/*  checkDialCode  */
			function checkDialCode(s)
			{
			  var flag = document.sd.addrEntries.selectedIndex;
				var str = document.sd.dial.value;
				if(isNaN(str))
				{
				alert('Dial Code should be an integer');
				return false;
				}
			 if (str.length < 2 )
					{
					  alert('Dial Code Length should be atleat 2 digits');
					  return false;
					}


			  if (document.sd.addrEntries.length  != 0)
			  {
				  for (i = 0;i< document.sd.addrEntries.length;i++)
				{
					if (document.sd.dial.value == ADial[i])
					{
					  if (!(document.sd.modflag.value == s & (document.sd.dial.value == ADial[flag])))
					  {
						alert('Dial Code exists');
						return false;
					  }
					}
				  }
			  }
			  else 
			  {
				alert('No Entry');
			  }
			}		
		
		</script>	
    </head>
	<body class="decBackgroundDef" onLoad="FormInit();">
				<div id="tabContainer">
					<span class="tabBorder"> </span> 

					<ul id="tabInv">
						<li><a href="#sd" class="selected"><span>Speed
						Dial</span></a></li>
						<li><a href=
						"voip_sys_callblock.asp"><span>Call Block</span></a></li>
						<li><a href="voip_sys_NumPlan.asp"><span>Numbering
						Plan</span></a></li>
		<li><a href="voip_sys_fax.asp"><span>Fax over IP</span></a></li>
						<li><a href=
						"voip_sys_Debug.asp"><span>Debug</span></a></li>
					</ul>
				</div>
				<br />
		<span class="textTitle">System &gt; Speed Dial</span>       
   

        <div align="center">
			<FORM ACTION="/goform/ifx_set_voip_sip_addrbook" METHOD="POST" NAME="sd">
			<input type="hidden" name="addflag" value="0">
			<input type="hidden" name="modflag" value="0">
			<input type="hidden" name="delflag" value="0">
			<input type="hidden" name="delallflag" value="0">
		<input type="hidden" name="page" value="voip_sys_speeddial.asp">
            <table class="tableInput" summary="">
				<%ifx_get_voip_sip_addrbook("PortSelection");%>
                <tr>
                    <th colspan="2">Speed Dial</th>
                </tr>

                <tr>
                    <td>List of entries:</td>
                </tr>
					
                <tr>
                    <td>
                    </td>

					<td align="left"> <select name="addrEntries" size="5" onClick="updateData_sd();" style="width:300px">             
						<option value="0" selected>1 -- </option>
						<option value="1">2 -- </option>                
						<option value="2">3 -- </option>
						<option value="3">4 -- </option>
						<option value="4">5 -- </option>
						</select>
					 </td>
                </tr>

                <tr>
                    <td>
                    </td>

                    <td>
						<button type="button" value=" Modify " name="modify" onClick="ModifyF_sd();">Modify</button>
						<button type="button" value=" Delete " name="del" onClick="DelF_sd();">Delete</button> 
						<button type="button" value=" Delete All " name="delall" onClick="DelAllF_sd();">Delete All</button> 
					</td>
                </tr>

                <tr>
                    <th colspan="2">New Entry</th>
                </tr>

                <tr>
				    <td>Dial Code</td>
 
					<%ifx_get_voip_sip_addrbook("DialCode");%>
                </tr>
				 <tr>
                    <td>Display Name</td>

                    <td><input maxlength="31" size="32" name="dname" type="text" /> </td>
                </tr>

                <tr>
                    <td>Address Type</td>

                    <td><select name="calltype" size="1" onChange="updateCallType_sd();">
                        <option value="0" selected="selected">
                            PSTN
                        </option>

                        <option value="1">
                            VOIP
                        </option>
                    </select> </td>
                </tr>

               

                <tr>
                    <td>User Name/Number</td>

                    <td><input maxlength="31" size="32" value="" name="uname" type="text" /> </td>
                </tr>

               

                <tr>
                    <td>Caller Address
					<td>
					<input type="text"maxLength="128" name="tempaddr" size="32" value="" >
					
					<input type="hidden"maxLength="128" name="addr" size="9" value=""> 
					<input type="hidden" maxLength="5" name="port" size="3" value="5060">
					<input type="hidden" name="addrproto" size="1" value="0">         
					
					<input type="hidden" name="addrtype" size="1" value="1">      
					
				    </td>
				</tr>
                <tr>
                    <td>
                    </td>
                    <td colspan="2"><button type="button" value="   Add   " name="add" onClick="return AddF_sd();">Add</button> </td>
                </tr>
				<%ifx_get_voip_sip_addrbook("VADTAG");%>
            </table>
			
        </div>
		</FORM>
    </body>
</html>

