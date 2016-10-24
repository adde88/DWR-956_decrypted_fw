<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="csshorizontalmenu.css" />
<link rel="stylesheet" href="final.css" type="text/css">
<script language="JavaScript" type="text/javascript" src="validations.js"></script>
<title>Edit contact</title>
<script type="text/javascript">
var ListNames = new Array();
<%ifx_get_voip_sip_contact_list("populatelist");%>
</script>

<script type="text/javascript">
	function cancelChanges()
	{
		document.contact.editcancel.value=1;
		return true;
			
	}

function saveChanges()
	{
    	var i;        

		if(document.contact.firstname.value == '' || isBlank(document.contact.firstname.value)){
			alert("First Name should not be Blank");
			return false;
		}		
	
	if(!isValidName(document.contact.firstname.value)){
            alert("Please enter the valid First name");
            return false;
    }


	
		if(document.contact.lastname.value == '' || isBlank(document.contact.lastname.value)){
			alert("Last Name should not be Blank");
			return false;
		}

	if(!isValidName(document.contact.lastname.value)){
            alert("Please enter the valid Last name");
            return false;
    }

  //var checkName=document.contact.lastname.value;
  var checkName=document.contact.firstname.value + ':' + document.contact.lastname.value ;
                for(i = 0; i < ListNames.length; i++){
                                if(ListNames[i].toString() == checkName.toString() ){
                                        //alert("Entry "+ checkName +" Already exist's ");
                                        alert("Entry \""+ document.contact.firstname.value +' '+ document.contact.lastname.value+"\" Already exist's ");

																					return false;
                                }
                }

	if(document.contact.contactnum.value =='' || isBlank(document.contact.contactnum.value)){
        alert("Phone Number-I should not be  blank");
        return false;
    }

  var contactNumber=document.contact.contactnum.value;
    if(isNaN(contactNumber) || contactNumber <=0 ){
        alert("Invalid Phone Number-I "+contactNumber);
      return false;
    }
  var contactNumber2=document.contact.contactnum2.value;
    if(!(isBlank(document.contact.contactnum2.value)) && (isNaN(contactNumber2) || contactNumber2 <=0) ){
        alert("Invalid Phone Number-II "+contactNumber2);
      return false;
    }


		document.contact.saveedit.value=1;
		return true; 
}

</script>
		
    </head>

    <body class="decBackgroundDef">
        <div>
			    <span class="textTitle"><%ifx_get_voip_sip_linestate("LineNo");%> &gt; Edit Contact </span>
        </div>
        <br/>
	<FORM ACTION="/goform/ifx_set_voip_sip_contactlist" METHOD="POST" NAME="contact">
	<input type="hidden" name="page" value="voip_line_contactlist.asp">
	<input type="hidden" name="cvflag" value="0">
	<input type="hidden" name="status" value="0">
	<input type="hidden" name="saveedit" value="0">
	<input type="hidden" name="editcancel" value="0">
	<input type="hidden" name="userlevel" value=<%ifx_get_currentUser_authority();%>>
        <div>
            <table align="left" >
                <tr><td>First-Name</td> <Td > <Input type="text" maxlength="31" name="firstname" value=<% ifx_get_voip_sip_contact_entry("firstname");%>> </td > </TR>
		<tr><td>Last-Name</th ><Td align="left"> <Input type="text" maxlength="31" name="lastname" value=<% ifx_get_voip_sip_contact_entry("lastname");%>> </td> </TR> 
		<tr><td>Phone-Number-I</td><Td align="left"> <Input type="text" maxlength="31" name="contactnum" value=<% ifx_get_voip_sip_contact_entry("contactnum");%>> </td > </TR> 
		<tr><td>Phone-Number-II</td><Td align="left"> <Input type="text" maxlength="31" name="contactnum2" value=<% ifx_get_voip_sip_contact_entry("contactnum2");%>> </td > </TR> 
		     <tr class="tableEmptyRow">
                        <td class="alignRight">
                         <A class="button" href="javascript:document.contact.submit();" onClick="return saveChanges();">Save </a> </td>
			 <td class="alignRight">
			<A class="button" href="javascript:document.contact.submit();" onClick="return cancelChanges();">Cancel </a></td>
		   </tr>
                  </table>
	</FORM>
</div>
    </body>
</html>
