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
var dynpt='Dynamic payload type should be integer and b/w 96 to 127';
var dynptoverlap='Dynamic Payload Type can not be same for different codecs.';

function Initshow()
{
   DisableFwNotSupdCodec();
   PopulatePriorityCodecList();
   return true;
}

function PopulatePriorityCodecList()
{
	var PrCodecList = new Array();
	var index = 0;

    /* Get priority codec list in form of array */
    <% ifx_get_voip_sip_codec("psel");%>

    /* populate priority Codec List */
    for( var i in PrCodecList)
    {
        updatePriorityCodec( PrCodecList[i]);
    }

    return true;
}


function addOption(theText, theValue)
{
    var newOpt = new Option(theText, theValue);
    var theSel ;
    var selLength;

    theSel = document.codec.psel;
    selLength = theSel.length;
    theSel.options[selLength] = newOpt;
}

function deleteChecked( fieldName )
{
    var i;

    if(document.codec.psel.length>0)
    {
        for(i=0;i<document.codec.psel.length;i++)
        {
            if(document.codec.psel.options[i].value == fieldName)
            {
                document.codec.psel.options[i] = null;
                break;
            }
        }
    }
}

function updatePriorityCodec(fieldName)
{
    /*<% ifx_get_voip_sip_codec("g711_alawp",1);%>
    <% ifx_get_voip_sip_codec("g711_ulawp",1);%>
    <% ifx_get_voip_sip_codec("g723p",1);%>
    <% ifx_get_voip_sip_codec("g729_8p",1);%>
    <% ifx_get_voip_sip_codec("g726_16p",1); %>
    <% ifx_get_voip_sip_codec("g726_24p",1); %>
    <% ifx_get_voip_sip_codec("g726_32p",1); %>
    <% ifx_get_voip_sip_codec("g726_40p",1); %>
    <% ifx_get_voip_sip_codec("g722_64p",1); %>
    <% ifx_get_voip_sip_codec("t38p",1); %>*/

if(fieldName == "g711_alaw")
{
		if (document.codec.g711_alaw.checked == true)
		{
				 document.codec.pframe_g711_alaw.disabled = false;
				 addOption("G711_ALAW","g711_alaw");
		}
	else
	{
			document.codec.pframe_g711_alaw.disabled = true;
 			deleteChecked("g711_alaw");
	}
}

    if(fieldName == "g711_ulaw")
	{
	if (document.codec.g711_ulaw.checked == true)
{
 document.codec.pframe_g711_ulaw.disabled = false;
 addOption("G711_ULAW","g711_ulaw");
}
else
{
document.codec.pframe_g711_ulaw.disabled = true;
 deleteChecked("g711_ulaw");
}
}

    if(fieldName == "g723")
{
if (document.codec.g723.checked == true)
{
document.codec.pframe_g723.disabled = false;
 document.codec.p723list.disabled = false;
 document.codec.p723list.selectedIndex = 0;
 addOption("G723","g723");
}
else
{
document.codec.pframe_g723.disabled = true;
document.codec.p723list.disabled = true;
deleteChecked("g723");
}
}

    if(fieldName == "g729_8")
{
if(document.codec.g729_8.checked == true)
{
 document.codec.pframe_g729_8.disabled = false;
 addOption("G729_8","g729_8");
}
else
{
 document.codec.pframe_g729_8.disabled = true;
deleteChecked("g729_8");
}
}

    if(fieldName == "g726_16")
{
if(document.codec.g726_16.checked == true)
{
 document.codec.pframe_g726_16.disabled = false;
 document.codec.dynpt_g726_16.disabled = false;
 addOption("G726_16","g726_16");
}
else
{
 document.codec.pframe_g726_16.disabled = true;
document.codec.dynpt_g726_16.disabled = true;
deleteChecked("g726_16");
}
}
if(fieldName == "g726_24")
{
if(document.codec.g726_24.checked == true)
{
 document.codec.pframe_g726_24.disabled = false;
 document.codec.dynpt_g726_24.disabled = false;
 addOption("G726_24","g726_24");
}
else
{
 document.codec.pframe_g726_24.disabled = true;
document.codec.dynpt_g726_24.disabled = true;
deleteChecked("g726_24");
}
}

    if(fieldName == "g726_32")
{
if(document.codec.g726_32.checked == true)
{
 document.codec.pframe_g726_32.disabled = false;
 document.codec.dynpt_g726_32.disabled = false;
 addOption("G726_32","g726_32");
}
else
{
 document.codec.pframe_g726_32.disabled = true;
document.codec.dynpt_g726_32.disabled = true;
deleteChecked("g726_32");
}
}

    if(fieldName == "g726_40")
{
if(document.codec.g726_40.checked == true)
{
 document.codec.pframe_g726_40.disabled = false;
 document.codec.dynpt_g726_40.disabled = false;
 addOption( "G726_40","g726_40");
}
else
{
 document.codec.pframe_g726_40.disabled = true;
document.codec.dynpt_g726_40.disabled = true;
deleteChecked("g726_40");
}
}

if(fieldName == "g722_64")
{
if(document.codec.g722_64.checked == true)
{
 document.codec.pframe_g722_64.disabled = false;
 addOption( "G722_64","g722_64");
}
else
{
 document.codec.pframe_g722_64.disabled = true;
deleteChecked("g722_64");
}
}

if(fieldName == "t38")
{
ChangeT38();
}


}

function DisableFwNotSupdCodec()
{
	<% ifx_get_FirmwareSupportedCodecs_vmapi(); %>
   return true;
}
</script>


<script language="JavaScript">
function SetChecked()
{
		if ((document.codec.g711_alaw.disabled == false) && ( document.codec.g711_alaw.checked == false))
	{
		 document.codec.g711_alaw.checked = true;
  document.codec.pframe_g711_alaw.disabled = false;
 addOption("G711_ALAW","g711_alaw");
}
	if ((document.codec.g711_ulaw.disabled == false) && ( document.codec.g711_ulaw.checked == false))
	{
		document.codec.g711_ulaw.checked = true;
 document.codec.pframe_g711_ulaw.disabled = false;
 addOption("G711_ULAW","g711_ulaw");
}
	if ((document.codec.g723.disabled == false) && ( document.codec.g723.checked == false))
	{
		document.codec.g723.checked = true;
 document.codec.pframe_g723.disabled = false;
 addOption("G723","g723");
 document.codec.p723list.disabled = false;
}
	if ((document.codec.g729_8.disabled == false) && ( document.codec.g729_8.checked == false))
	{
		document.codec.g729_8.checked = true;
 document.codec.pframe_g729_8.disabled = false;
addOption("G729_8","g729_8");
}
	if ((document.codec.g722_64.disabled == false) && ( document.codec.g722_64.checked == false))
	{
		document.codec.g722_64.checked = true;
 document.codec.pframe_g722_64.disabled = false;
addOption( "G722_64","g722_64");
}
	if ((document.codec.t38.disabled == false) && ( document.codec.t38.checked == false))
	{
		document.codec.t38.checked = true;
 ChangeT38();
}
	if ((document.codec.g726_16.disabled == false) && ( document.codec.g726_16.checked == false))
	{
		document.codec.g726_16.checked = true;
 document.codec.pframe_g726_16.disabled = false;
document.codec.dynpt_g726_16.disabled = false;
addOption("G726_16","g726_16");
}
	if ((document.codec.g726_24.disabled == false) && ( document.codec.g726_24.checked == false))
	{
		document.codec.g726_24.checked = true;
 document.codec.pframe_g726_24.disabled = false;
document.codec.dynpt_g726_24.disabled = false;
addOption("G726_24","g726_24");
}
	if ((document.codec.g726_32.disabled == false) && ( document.codec.g726_32.checked == false))
	{
		document.codec.g726_32.checked = true;
 		document.codec.pframe_g726_32.disabled = false;
 		document.codec.dynpt_g726_32.disabled = false;
 		addOption("G726_32","g726_32");
	}
	if ((document.codec.g726_40.disabled == false) && ( document.codec.g726_40.checked == false))
	{
		document.codec.g726_40.checked = true;
 		document.codec.pframe_g726_40.disabled = false;
		document.codec.dynpt_g726_40.disabled = false;
		addOption( "G726_40","g726_40");
}
 <%ifx_SelectT38CheckBoxes_vmapi()%>

}

function moveUp()
{
            var ind;
    if(document.codec.psel.length>0)
    {
        var i;
        var selectedText = new Array();
        var selectedValues = new Array();

        /* Error: Atleast one item should be selected before pressing button */
        for(i=0;i<document.codec.psel.length;i++)
        {
            if( document.codec.psel.options[i].selected == false )
            {
                cnt = i;
            }
            else
            {
                break;
            }
        }
        if( cnt == document.codec.psel.length-1 )
        {
            alert('Atleast one entry of the Priority Codec List should be selected');
            return true;
        }

        for(i=0;i<document.codec.psel.length;i++)
        {
            if(document.codec.psel.options[i].selected &&(i>0))
            {
                ind = i;
            }
            else if( document.codec.psel.options[i].selected
                && (i == 0))
            {
                document.codec.psel.options[0].selected = true;
                return true;
            }
            selectedText[i] = document.codec.psel.options[i].text;
            selectedValues[i] = document.codec.psel.options[i].value;
        }

        var tmpText = selectedText[ind-1];
        var tmpVal = selectedValues[ind-1];

        selectedText[ind-1] = selectedText[ind];
        selectedValues[ind-1] = selectedValues[ind];
        selectedText[ind] = tmpText;
        selectedValues[ind] = tmpVal;
        document.codec.psel.length = 0;

        for (var i1 = 0; i1 < selectedText.length; ++i1)
        {
            document.codec.psel.options[document.codec.psel.length] =
                    new Option(selectedText[i1], selectedValues[i1]);
        }
        document.codec.psel.options[ind-1].selected = true;
    }
     return true;
}


function moveDown()
{
    if(document.codec.psel.length>0)
    {
        var i;
        var selectedText = new Array();
        var selectedValues = new Array();
        var cnt;

        /* Error: Atleast one item should be selected before pressing button */
        for(i=0;i<document.codec.psel.length;i++)
        {
            if( document.codec.psel.options[i].selected == false )
            {
                cnt = i;
            }
            else
            {
                break;
            }
        }
        if( cnt == document.codec.psel.length-1 )
        {
            alert('Atleast one entry of the Priority Codec List should be selected');
            return true;
        }

        for(i=0;i<document.codec.psel.length;i++)
        {
            var ind;
            if(document.codec.psel.options[i].selected &&
                (i < document.codec.psel.length-1))
            {
                ind = i;
            }
            else if( document.codec.psel.options[i].selected
                && (i == document.codec.psel.length-1 ))
            {
                document.codec.psel.options[document.codec.psel.length-1].
                    selected = true;
                return true;
            }

            selectedText[i] = document.codec.psel.options[i].text;
            selectedValues[i] = document.codec.psel.options[i].value;
        }

        var tmpText = selectedText[ind+1];
        var tmpVal = selectedValues[ind+1];
        selectedText[ind+1] = selectedText[ind];
        selectedValues[ind+1] = selectedValues[ind];
        selectedText[ind] = tmpText;
        selectedValues[ind] = tmpVal;
        document.codec.psel.length = 0;

        for (var i1 = 0; i1 < selectedText.length; ++i1)
        {
            document.codec.psel.options[document.codec.psel.length] =
                    new Option(selectedText[i1], selectedValues[i1]);
        }
        document.codec.psel.options[ind+1].selected = true;
    }
     return true;
}

function ChangeT38()
{
	<%ifx_get_T38ChangeFunction_vmapi()%>
}

function DynPayload_onblur( CodecFlavour )
{
	var bwidth_Field=0 ,Dtmf_Field=0 , DynPayload_Field_16=0,
		DynPayload_Field_24=0,DynPayload_Field_32=0,
		DynPayload_Field_40=0;DynPayload_Field_29=0
    var flag = false;

	bwidth_Field = document.codec.bwidth;
	DynPayload_Field_16 = document.codec.dynpt_g726_16;
	DynPayload_Field_24 = document.codec.dynpt_g726_24;
	DynPayload_Field_32 = document.codec.dynpt_g726_32;
	DynPayload_Field_40 = document.codec.dynpt_g726_40;
	//DynPayload_Field_29 = document.codec.dynpt_g729_e;

	if( CodecFlavour == 29)
	{
        if(isNaN(DynPayload_Field_29.value)|| 
			isDecimal(DynPayload_Field_29.value))
        {
            flag=true;
        }
		if (
			( DynPayload_Field_29.value < 96 || DynPayload_Field_29.value > 127)
										&&
            !(isNaN( bwidth_Field.value))
                              &&
      	    !(Dtmf_Field.value < 96 || Dtmf_Field.value > 127)
										&&
			!(DynPayload_Field_16.value < 96 || DynPayload_Field_16.value > 127)
										&&
			!(DynPayload_Field_24.value < 96 || DynPayload_Field_24.value > 127)
										&&
			!(DynPayload_Field_32.value < 96 || DynPayload_Field_32.value > 127)
										&&
			!(DynPayload_Field_40.value < 96 || DynPayload_Field_40.value > 127)
		)
		{
            flag=true;
		}

        if( flag == true)
        {
			alert(dynpt);
			DynPayload_Field_29.focus();
			DynPayload_Field_29.select();
        }
	}

	
	if( CodecFlavour == 16)
	{
        if(isNaN(DynPayload_Field_16.value)|| 
			isDecimal(DynPayload_Field_16.value))
        {
            flag=true;
        }
		if (
			( DynPayload_Field_16.value < 96 || DynPayload_Field_16.value > 127)
										&&
            !(isNaN( bwidth_Field.value))
                              &&
      	    !(Dtmf_Field.value < 96 || Dtmf_Field.value > 127)
										&&
			!(DynPayload_Field_29.value < 96 || DynPayload_Field_29.value > 127)
										&&
			!(DynPayload_Field_24.value < 96 || DynPayload_Field_24.value > 127)
										&&
			!(DynPayload_Field_32.value < 96 || DynPayload_Field_32.value > 127)
										&&
			!(DynPayload_Field_40.value < 96 || DynPayload_Field_40.value > 127)
		)
		{
            flag=true;
		}

        if( flag == true)
        {
			alert(dynpt);
			DynPayload_Field_16.focus();
			DynPayload_Field_16.select();
        }
	}
	
	else if( CodecFlavour == 24)
	{
        if(isNaN(DynPayload_Field_24.value)|| 
			isDecimal(DynPayload_Field_24.value))
        {
            flag=true;
        }

		if (
			( DynPayload_Field_24.value < 96 || DynPayload_Field_24.value > 127)
										&&
            !(isNaN( bwidth_Field.value))
                              &&
          	!(Dtmf_Field.value < 96 || Dtmf_Field.value > 127)
										&&
					!(DynPayload_Field_29.value < 96 || DynPayload_Field_29.value > 127)
										&&
        	!(DynPayload_Field_16.value < 96 || DynPayload_Field_16.value > 127)
										&&
        	!(DynPayload_Field_32.value < 96 || DynPayload_Field_32.value > 127)
										&&
            !(DynPayload_Field_40.value < 96 || DynPayload_Field_40.value > 127)
		)

		{
            flag=true;
		}

        if( flag == true)
        {
			alert(dynpt);
			DynPayload_Field_24.focus();
			DynPayload_Field_24.select();
        }
}	
	else if( CodecFlavour == 32)
	{
        if(isNaN(DynPayload_Field_32.value)||
			isDecimal(DynPayload_Field_32.value))
        {
            flag=true;
        }

		if (
			( DynPayload_Field_32.value < 96 || DynPayload_Field_32.value > 127)
										&&
            !(isNaN( bwidth_Field.value))
                              &&
          	!(Dtmf_Field.value < 96 || Dtmf_Field.value > 127)
										&&
					!(DynPayload_Field_29.value < 96 || DynPayload_Field_29.value > 127)
										&&
        	!(DynPayload_Field_16.value < 96 || DynPayload_Field_16.value > 127)
										&&
           	!(DynPayload_Field_24.value < 96 || DynPayload_Field_24.value > 127)
										&&
        	!(DynPayload_Field_40.value < 96 || DynPayload_Field_40.value > 127)
		)
		{
            flag=true;
		}

        if( flag == true)
        {
			alert(dynpt);
			DynPayload_Field_32.focus();
			DynPayload_Field_32.select();
        }
	}
	

	else if( CodecFlavour == 40)
	{
        if(isNaN(DynPayload_Field_40.value)||
			isDecimal(DynPayload_Field_40.value))
        {
            flag=true;
        }

		if (
			( DynPayload_Field_40.value < 96 || DynPayload_Field_40.value > 127)
										&&
            !(isNaN( bwidth_Field.value))
                              &&
          	!(Dtmf_Field.value < 96 || Dtmf_Field.value > 127)
										&&
					!(DynPayload_Field_29.value < 96 || DynPayload_Field_29.value > 127)
										&&
        	!(DynPayload_Field_24.value < 96 || DynPayload_Field_24.value > 127)
										&&
        	!(DynPayload_Field_32.value < 96 || DynPayload_Field_32.value > 127)
										&&
        	!(DynPayload_Field_16.value < 96 || DynPayload_Field_16.value > 127)
		)
		{
            flag=true;
		}

        if( flag == true)
        {
			alert(dynpt);
			DynPayload_Field_40.focus();
			DynPayload_Field_40.select();
        }
	}
}

function GetPriorityCodecArray() {

    var PArray = new Array();
    for(i=0;i<document.codec.psel.length;i++)
    {
        PArray[i] = document.codec.psel.options[i].text;
    }
    document.codec.pCodecString.value = PArray.join(',');	
    return true;
}


function submitCODEC()
{
	var ReturnStatus = true;
	var Dtmf_Field=0 , DynPayload_Field_16=0,DynPayload_Field_24=0,
		DynPayload_Field_32=0, DynPayload_Field_40=0;

    /* Get the sorted Codecs as per priority */
    GetPriorityCodecArray();

    /* Validation of fields */
	DynPayload_Field_16 = document.codec.dynpt_g726_16;
	DynPayload_Field_24 = document.codec.dynpt_g726_24;
	DynPayload_Field_32 = document.codec.dynpt_g726_32;
	DynPayload_Field_40 = document.codec.dynpt_g726_40;

	if (document.codec.userlevel.value != 0)
	{
		alert(aum);
		ReturnStatus = false;
	}


	if (
		( (document.codec.g726_16.checked == true) &&
			(document.codec.dynpt_g726_16.value < 96 ||
			document.codec.dynpt_g726_16.value > 127) )
								||
		((document.codec.g726_24.checked == true) &&
			(document.codec.dynpt_g726_24.value < 96 ||
         document.codec.dynpt_g726_24.value > 127))
								||
		((document.codec.g726_32.checked == true) &&
		(document.codec.dynpt_g726_32.value < 96 ||
         document.codec.dynpt_g726_32.value > 127))
								||
		((document.codec.g726_40.checked == true) &&
		(document.codec.dynpt_g726_40.value < 96 ||
         document.codec.dynpt_g726_40.value > 127))

		)
	{
		alert(dynpt);
		ReturnStatus = false;
	}

	if(
	((DynPayload_Field_16.value == DynPayload_Field_24.value ) &&
		(document.codec.g726_16.checked == true )&&
		(document.codec.g726_24.checked == true))
								||
	((DynPayload_Field_16.value == DynPayload_Field_32.value ) &&
		(document.codec.g726_16.checked == true )&&
		(document.codec.g726_32.checked == true))
								||
	((DynPayload_Field_16.value == DynPayload_Field_40.value ) &&
		(document.codec.g726_16.checked == true )&&
		(document.codec.g726_40.checked == true))
								||
	(( DynPayload_Field_24.value == DynPayload_Field_32.value )&&
		(document.codec.g726_24.checked == true )&&
		(document.codec.g726_32.checked == true))
								||
	(( DynPayload_Field_24.value == DynPayload_Field_40.value ) &&
		(document.codec.g726_24.checked == true )&&
		(document.codec.g726_40.checked == true ))
								||
	(( DynPayload_Field_32.value == DynPayload_Field_40.value ) &&
		(document.codec.g726_32.checked == true) &&
		(document.codec.g726_40.checked == true ))
	)
	{
		alert(dynptoverlap);
		ReturnStatus = false;
	}

	if(
	(( Dtmf_Field.value == DynPayload_Field_16.value ) &&
		(document.codec.g726_16.checked == true ))
								||
	(( Dtmf_Field.value == DynPayload_Field_24.value ) &&
		(document.codec.g726_24.checked == true ))
								||
	(( Dtmf_Field.value == DynPayload_Field_32.value ) &&
		(document.codec.g726_32.checked == true ))
								||
	(( Dtmf_Field.value == DynPayload_Field_40.value ) &&
		(document.codec.g726_40.checked == true ))
	)
	{
		
		ReturnStatus = false;
	}

    if(document.codec.psel.length == 0)
    {
		alert('Atleast one codec should be configured');
		return false;
    }
    if((document.codec.psel.length == 1)&&(document.codec.t38.checked == true))
    {
		alert('Atleast one voice codec should be configured');
		return false;
    }
    if((document.codec.t38.checked == true)&&(document.codec.psel.options[document.codec.psel.length - 1].value != "t38"))
    {
		alert('t38 codec should be configured at last priority');
		return false;
    }
	return ReturnStatus;
}

</script>
</head>

    <body class="decBackgroundDef" onLoad="Initshow();">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                <li><a href="voip_line_voip.asp"><span>Terminals</span></a></li>

                <li><a href="voip_line_sip.asp"><span>SIP
                Account</span></a></li>

                <li><a href="voip_line_callfeat.asp"><span>Calling Features</span></a></li>

                <li><a href="voip_line_codec.asp" class=
                "selected"><span>Media</span></a></li>
				<li><a href=
                "voip_line_callregister.asp"><span>Call Register</span></a></li>
				<li><a href=
                "voip_line_contactlist.asp"><span>Contact List</span></a></li>				
            </ul>
        </div>
		<br>
         
         <span class="textTitle"><%ifx_get_voip_sip_linestate("LineNo");%> &gt; Media</span>
        <div align="center">
        	<FORM ACTION="/goform/ifx_set_voip_sip_codec" METHOD="POST" NAME="codec" onSubmit="return submitCODEC();">
<input type="hidden" name="page" value="voip_line_codec.asp">
<input type="hidden" name="cvflag" value="0">
<input type="hidden" name="status" value="0">
<input type="hidden" name="pCodecString" >
<input type="hidden" name="userlevel" value=<%ifx_get_currentUser_authority();%>>
            <table class="tableInput" style="width: 70%;" summary=
            "">
                <tr>
                    <th colspan="2">Codec</th>
                </tr>
<!-- 
                <tr>
                    <td>Preferred G723 Encoding</td>

                    <td><select>
                        <option>
                            XXX
                        </option>

                        <option>
                            XXX
                        </option>
                    </select> </td>
                </tr>
-->
                <tr>
                    <td>Codec Priority</td>

                    <td><select name="psel" size="10" style="width: 120px;">
			</select></td>
                </tr>

                <tr>
                    <td> </td>

                    <td><input type="button" name="up" value="UP" onClick="moveUp();" />
            <input type="button" name="down" value="DOWN" onClick="moveDown();" /></td>
                </tr>
            </table>

            <table class="tableInput" style="width: 70%;">
                <tr>
                    <th>Codec</th>

                    <th>Enabled</th>

                    <th>Frame Size</th>
                    <th style="width: 100px;">Dynamic Payload Type</th>
                </tr>
                <%ifx_get_voip_sip_codec("g711_alaw","1");%>
				<%ifx_get_voip_sip_codec("g711_ulaw","1");%>
			    <%ifx_get_voip_sip_codec("g723","1");%>
			    <%ifx_get_voip_sip_codec("g729_8","1");%>
				<%ifx_get_voip_sip_codec("g726_16","1");%>
				<%ifx_get_voip_sip_codec("g726_24","1");%>
				<%ifx_get_voip_sip_codec("g726_32","1");%>
				<%ifx_get_voip_sip_codec("g726_40","1");%>
			    <%ifx_get_voip_sip_codec("g722_64","1");%>
				<%ifx_get_voip_sip_codec("t38","1");%>
				<tr>
					<td><a href="javaScript:SetChecked()">
Check All</a></td>
				</tr>
				
                <tr>
                    <td colspan="4" align="right">
                    <button type="submit">Apply</button></td>
                </tr>
            </table>
			</form>
        </div>
    </body>
</html>

