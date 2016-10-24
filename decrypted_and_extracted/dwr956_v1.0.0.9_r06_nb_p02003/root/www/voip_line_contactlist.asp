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
var maxLineEntries=0,currentLineEntries=0,maxCommonEntries=0, currentCommonEntries=0;
function deleteAllContacts()
{
  if(currentLineEntries == 0 && currentCommonEntries == 0 ){
    alert("Contact List(s) is Empty....!");
    return false;
  }
  
  document.contact.deleteall.value=1;
	document.contact.submit();
  return true;
}

function addNewContact()
{
  
  if(currentLineEntries == maxLineEntries && currentCommonEntries == maxCommonEntries){
    alert("Can't Add.....! Maximum entires Reached.....!");
  return false;
  }
  document.contact.deleteall.value=0;
  document.contact.deleteentry.value=0;
  document.contact.editcontact.value=0;
  document.contact.page.value="voip_line_contact_add.asp";
	document.contact.submit();
  return true; 
}


function setContactInfo(index,cpeid,isCommon){
  document.contact.cpeid.value=cpeid;
  document.contact.index.value=index;
  document.contact.isCommon.value = isCommon;

}



function editContactEntry(){
  if(currentLineEntries == 0 && currentCommonEntries == 0){
    alert("Contact List is Empty....!");
    return false;
 }


  if(document.contact.cpeid.value == 0 || document.contact.index.value == 0){
    alert("Please select an Entry to Edit....!");
    return false;
  }

  document.contact.deleteall.value=0;
  document.contact.deleteentry.value=0;
  document.contact.page.value="voip_line_contact_edit.asp";
  document.contact.editcontact.value=1;
	document.contact.submit();
  return true;
}
function deleteContactEntry(){
  
if(currentLineEntries == 0 && currentCommonEntries == 0){
    alert("Contact List(s) is Empty....!");
    return false;
 }
  if(document.contact.cpeid.value == 0 || document.contact.index.value == 0){
    alert("Please select an Entry to delete....!");
    return false;
  }
  document.contact.deleteall.value=0;
  document.contact.deleteentry.value=1;
	document.contact.submit();
  return true;
}

</script>
    </head>

    <body class="decBackgroundDef">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                <li><a href="voip_line_voip.asp"><span>Terminals</span></a></li>

                <li><a href="voip_line_sip.asp"><span>SIP
                Account</span></a></li>

                <li><a href="voip_line_callfeat.asp"><span>Calling Features</span></a></li>

                <li><a href="voip_line_codec.asp" 
                ><span>Media</span></a></li>
				<li><a href=
                "voip_line_callregister.asp"><span>Call Register</span></a></li>
				<li><a href=
                "voip_line_contactlist.asp" class="selected"><span>Contact List</span></a></li>				
            </ul>
        </div>
		<br>
         
         <span class="textTitle"><%ifx_get_voip_sip_linestate("LineNo");%> &gt; Contact List</span>
        <div align="center">
<FORM ACTION="/goform/ifx_set_voip_sip_contactlist" METHOD="POST" NAME="contact">
<input type="hidden" name="page" value="voip_line_contactlist.asp">
<input type="hidden" name="cvflag" value="0">
<input type="hidden" name="status" value="0">
<input type="hidden" name="userlevel" value=<%ifx_get_currentUser_authority();%>>
<input type="hidden" name="deleteall" value="0">
<input type="hidden" name="deleteentry" value="0">
<input type="hidden" name="editcontact" value="0">
<input type="hidden" name="cpeid" value="0">
<input type="hidden" name="index" value="0">
<input type="hidden" name="isCommon" value="0">
<table class="tableInfo" cellspacing="1"
                cellpadding="6" summary="">
                    <tr>
                        <th class="curveLeft">Sl.No.</th>
                        <th>First-Name</th>
      									<th>Last-Name</th>
      									<th>Phone-Number-I</th>
      									<th>Phone-Number-II</th>
                        <th class="curveRight">Action</th>
                      </tr>
      <% ifx_get_voip_sip_contact_list("cl")%>
                    <tr class="tableEmptyRow">
											<td>
											</td>
                        <td colspan="4"><button onClick="addNewContact();">Add New  </button>
      									<button onClick="deleteAllContacts();">
Delete-All  </button>
      <button onClick="deleteContactEntry();">
Delete  </button>
      <button onClick="editContactEntry();">
Edit  </button>
			<td>
			</td>
      </tr>
       </table>
</FORM>
        </div>

    </body>
</html>

