<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name="generator" content=
        "HTML Tidy, see www.w3.org" />
        <meta http-equiv="Content-Type" content=
        "text/html; charset=iso-8859-1" />
        <link rel="stylesheet" type="text/css" href="final.css" />
        <script language="JavaScript" src="validations.js"></script> 

        <title></title>
        <script type="text/javascript">

        function getThePhyendptsList(theText, theValue)
        {
          var newOpt = new Option(theText, theValue);
          var theSel;
          var selLength;
          theSel = document.pstnline.phyendpts2;
          selLength = theSel.length;
          theSel.options[selLength] = newOpt;
        }

        function getThePhyendptsList1(theText, theValue)
        {
          var newOpt1 = new Option(theText, theValue);
          var theSel1;
          var selLength1;
          theSel1 = document.pstnline.phyendpts1;
          selLength1 = theSel1.length;
          theSel1.options[selLength1] = newOpt1;
        }                                                                              

        function GetPhyendptsArray()
        {
          var PArray = new Array();
          for(i=0;i<document.pstnline.phyendpts2.length;i++)
          {
             PArray[i] = document.pstnline.phyendpts2.options[i].text;
          }
          document.pstnline.pPhyendptsString.value = PArray.join(',');
          return true;
        }

        function remove()
        {
          if(document.pstnline.phyendpts2.selectedIndex <0)
          {
            return false;
          }
          if(document.pstnline.phyendpts2.length == 0){                                                                                                                              alert('No entry exists');
            return false;
          }
          document.pstnline.phyendpts2.options[document.pstnline.phyendpts2.selectedIndex]= null;
        }

        function right()
        {
          var newOpt = new Option(document.pstnline.phyendpts1.value,document.pstnline.phyendpts1.value)
          if(document.pstnline.phyendpts1.selectedIndex <0)
          {
            return false;
          }
          if(document.pstnline.phyendpts2.length == 0 & document.pstnline.phyendpts1.value == '')
          {
            return false;
          }
          for(i=0;i<document.pstnline.phyendpts2.length;i++)
          {
             if(document.pstnline.phyendpts1.value == document.pstnline.phyendpts2.options[i].value)
             {
               alert('Entry exists');
               return false;
             }
          }
          document.pstnline.phyendpts2.options[document.pstnline.phyendpts2.length] = newOpt;
          return true;
        }

        function UpdateData()
        {
          if(document.pstnline.phyendpts2.length == 0)
          {
            return false;
          }
          var selText = document.pstnline.phyendpts2.options[document.pstnline.phyendpts2.selectedIndex].text;
          var selval = document.pstnline.phyendpts2.options[document.pstnline.phyendpts2.selectedIndex].value;
          document.pstnline.phyendpts1.value = selText;
        }

        function Initshow()
        {
          document.pstnline.pstnstatus.disabled = true;
          document.pstnline.phyendpts1.selectedIndex =-1;
          document.pstnline.phyendpts2.selectedIndex =-1;
          <% ifx_get_voip_sip_pstn("updateData");%>
          <% ifx_get_voip_sip_pstn("updateData1");%>
          return true;
        }

        function submitPSTN()
        {
          /* Get the List of Phyendpts  */
          GetPhyendptsArray();
          return true;
        }
                                                       
        </script> 
    </head>

    <body class="decBackgroundDef" onLoad="Initshow();">
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
         <span class="textTitle"><%ifx_get_voip_sip_pstn("pstn_name")%></span>
<br>
<FORM ACTION="/goform/ifx_set_voip_sip_pstn" METHOD="POST" NAME="pstnline" onSubmit="return submitPSTN();">
<input type="hidden" name="page" value="voip_line_pstn.asp"> 
<!--<input type="hidden" name="status" value="0"> -->
<input type="hidden" name="pPhyendptsString" >
        <div align="center">
            <table class="tableInput"  style="width: 70%;" summary="">
				<tr>
					<th colspan="3">Line Status</th>
					</tr>
					<tr>
						<td>Status</td>
						<td colspan="2"><SELECT NAME="pstnstatus"><%ifx_get_voip_sip_pstn("pstnstatus");%></SELECT></td>
					</tr>
					<tr>
				<th colspan="3">Echo</th>
				</tr>
				<tr>
					<td>Echo Cancellation</td>
					<td colspan="2"><SELECT NAME="echoCancel"><%ifx_get_voip_sip_pstn("echoCancel");%></SELECT></td>
					</tr>
					<tr>
          	<td>Call Intrusion</td>
          	<td colspan="2"><SELECT NAME="intrusion">
            <%ifx_get_voip_sip_pstn("intrusion");%>
          	</SELECT></td>
          </tr>
                <tr>
                    <th colspan="3">Terminals</th>
                </tr>
			
						<tr>
							<td colspan="3"><br></td>
                <tr>
                    <td align="right">Available Terminals</td>
                	<td class="colInput">&nbsp;</td>
                    <td>Associated Terminals</td>
                </tr>

                <tr>
                    <td align="right"><SELECT NAME="phyendpts1" size="5" style="width: 100%;">
                    </SELECT></td>

                    <td align="center"><input size="5" value="Add" name="add" onclick="right();" type="button" />
                    <input size="5" value="Del" name="del" onclick="remove();" type="button" /></td>

                    <td>
                    <select name="phyendpts2" size="5" onclick="UpdateData();"  style="width: 100%;">
                    </select> </td>
                </tr>

				<tr>
					<td colspan="3"><br></td>
				</tr>
				<tr>
					<td colspan="3" align="right"><button type="submit">Apply</button></td>
					</tr>
            </table>
        </div>
      </FORM>
    </body>
</html>

