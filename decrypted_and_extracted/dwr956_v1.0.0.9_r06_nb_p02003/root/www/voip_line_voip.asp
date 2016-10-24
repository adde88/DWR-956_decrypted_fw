<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
	<meta http-equiv="Pragma" content="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="-1">

        <meta name="generator" content=
        "HTML Tidy, see www.w3.org" />
        <meta http-equiv="Content-Type" content=
        "text/html; charset=iso-8859-1" />
        <link rel="stylesheet" type="text/css" href="final.css" />
				<script language="JavaScript" type="text/javascript" src="validations.js"></script>
        <title></title>
		<script type="text/javascript">
			function getThePhyendptsList(theText, theValue)
{
  var newOpt = new Option(theText, theValue);
  var theSel ;
  var selLength;

  theSel = document.voipline.phyendpts2;
  selLength = theSel.length;
  theSel.options[selLength] = newOpt;
}

function getThePhyendptsList1(theText, theValue)
{
  var newOpt1 = new Option(theText, theValue);
  var theSel1 ;
  var selLength1;

  theSel1 = document.voipline.phyendpts1;
  selLength1 = theSel1.length;
  theSel1.options[selLength1] = newOpt1;
}
			function GetPhyendptsArray() {
    var PArray = new Array();
		PArray[0] = "";
    for(i=0;i<document.voipline.phyendpts2.length;i++)
    {
        PArray[i] = document.voipline.phyendpts2.options[i].text;
    }
		if(document.voipline.phyendpts2.length >0)
		{
      document.voipline.pPhyendptsString.value = PArray.join(',');	
		}
		/*alert('PArray'+ PArray.length);
		alert('PArray'+ document.voipline.pPhyendptsString.value);
		alert('length' + document.voipline.phyendpts2.length);*/
    return true;
}
			function submitVOIPLINE()
{
	if(document.voipline.linename.value == ' ' || isBlank(document.voipline.linename.value)){
			alert("Line Name should not be blank");
			return false;
	}
    GetPhyendptsArray();
    return true;
}

function remove()
{
	if(document.voipline.phyendpts2.selectedIndex <0){
		return false;
	}

	if(document.voipline.phyendpts2.length == 0)
	{
		alert('No entry exists');
		return false;
	}
	
	document.voipline.phyendpts2.options[document.voipline.phyendpts2.selectedIndex]= null;

}


function right()
{ 
  var newOpt = new Option(document.voipline.phyendpts1.value,document.voipline.phyendpts1.value)

	if(document.voipline.phyendpts1.selectedIndex <0){
		return false;
	}
 	if (document.voipline.phyendpts2.length == 0 & document.voipline.phyendpts1.value == '')
  {
  	return false;
  }
  for (i=0;i<document.voipline.phyendpts2.length;i++)
  {
    if(document.voipline.phyendpts1.value == document.voipline.phyendpts2.options[i].value)
    {
    	alert('Entry exists');
      return false;
    }
  }
  document.voipline.phyendpts2.options[document.voipline.phyendpts2.length] = newOpt;
	
  return true;

}

function updateData()
{
  if (document.voipline.phyendpts2.length == 0)
  {
    return false;
  }
  var selText = document.voipline.phyendpts2.options[document.voipline.phyendpts2.selectedIndex].text;
  var selval = document.voipline.phyendpts2.options[document.voipline.phyendpts2.selectedIndex].value;
  document.voipline.phyendpts1.value = selText;
}

function Initshow()
{
	document.voipline.phyendpts1.selectedIndex =-1;
	document.voipline.phyendpts2.selectedIndex =-1;
		 <% ifx_get_voip_sip_linestate("updateData");%>
   <% ifx_get_voip_sip_linestate("updateData1");%>	
	
   return true;
 }

		</script>
    </head>

    <body class="decBackgroundDef" onLoad="Initshow();">
    	<div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                <li><a href=
                "voip_line_voip.asp" class="selected"><span>Terminals</span></a></li>
                <li><a href="voip_line_sip.asp"><span>SIP Account</span></a></li>
				<li><a href="voip_line_callfeat.asp"><span>Calling Features</span></a></li>
				<li><a href="voip_line_codec.asp"><span>Media</span></a></li>
				<li><a href=
                "voip_line_callregister.asp"><span>Call Register</span></a></li>
				<li><a href=
                "voip_line_contactlist.asp"><span>Contact List</span></a></li>				
            </ul>
        </div>
		<br>
         
         <span class="textTitle"><%ifx_get_voip_sip_linestate("LineNo");%> &gt; Terminals</span>

        <div align="center">
            <table class="tableInput"  style="width: 70%;" summary="">
				<tr>
					<th colspan="3">Line Status</th>
					</tr>
					<tr>
						<FORM ACTION="/goform/ifx_set_voip_sip_lineadv" METHOD="POST" NAME="voipline" onSubmit="return submitVOIPLINE();">
							<input type="hidden" name="page" value="voip_line_voip.asp">
<input type="hidden" name="portChg" value="0">
<input type="hidden" name="status" value="0">
<input type="hidden" name="cvflag" value="0">
<input type="hidden" name="pPhyendptsString">
						<td>Status</td>
						<td colspan="2"><SELECT NAME="vlstatus">
<%ifx_get_voip_sip_linestate("vlstatus");%>
</SELECT></td>
					</tr>
					<tr>
						<td>Line Name</td>
						<td><input type="text" name="linename" maxlength=10 value="<%ifx_get_voip_sip_linestate("LineNo");%>"></td>
					</tr>

					<tr>
						<td>Line Registration Status</td>
						<td><%ifx_get_voip_sip_linestate("RegistrationSatus");%></td>
					</tr>
					<tr>
          	<td>Call Mode</td>
          	<td colspan="2"><SELECT NAME="vlmode">
            <%ifx_get_voip_sip_linestate("vlmode");%>
          	</SELECT></td>
          </tr>
					<tr>
          	<td>Call Intrusion</td>
          	<td colspan="2"><SELECT NAME="intrusion">
            <%ifx_get_voip_sip_linestate("intrusion");%>
          	</SELECT></td>
          </tr>

                <tr>
                    <th colspan="3">Terminals</th>
                </tr>
                <tr>
                    <td  align="right">Available Terminals</td>
                	<td class="colInput">&nbsp;</td>
                    <td>Associated Terminals</td>
                </tr>

                <tr>
                    <td align="right"><SELECT NAME="phyendpts1" size=5 style="width:150px">
										</SELECT></td>
                    <td align="center"><input type="button" size=5 value="Add" name="add" onClick="right();" />
            				<input type="button" size=5 value="Del" name="Del" onClick="remove();" /></td>
                    <td>
                    <select name="phyendpts2" size="5" onClick="updateData();" style="width:150px">
			    					</select></td>
                </tr>

				<tr>
					<td colspan="3"><br></td>
				</tr>
				<tr>
					<td colspan="3" align="right"><button type="submit">Apply</button></td>
					</tr>
            </table>
        </div>
    </body>
</html>

