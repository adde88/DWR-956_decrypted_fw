<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name="generator" content=
        "HTML Tidy, see www.w3.org" />
        <meta http-equiv="Content-Type" content=
        "text/html; charset=iso-8859-1" />
        <link rel="stylesheet" type="text/css" href="final.css" />
<script language="JavaScript" type="text/javascript" src="validations.js"></script>
        <title></title>
       
        <script type="text/javascript">
	
	function numTypeCheck(paramName, paramValue){
			if(paramName ==''){
        alert(paramName + " should not be blank");
        return false;
    }

    if(isNaN(paramValue) || paramValue <0 ){
        alert("Invalid value for "+paramName);
      return false;
    }
	return true;
	}
				
			function submitMisc(){


				if(document.misc.unotify.checked == true){
					document.misc.unotify.value=1;
				}else {
					document.misc.unotify.value=0;
					}

				if(document.misc.supression.checked == true){
					document.misc.supression.value=1;
				}else {
					document.misc.supression.value=0;
					}

				if(document.misc.clkmaster.checked == true){
					document.misc.clkmaster.value=1;
				}else {
					document.misc.clkmaster.value=0;
					}
				if(document.misc.FxoEn.checked == true){
					document.misc.FxoEn.value=1;
				}else {
					document.misc.FxoEn.value=0;
					}



				if(numTypeCheck("Scalling Factor",document.misc.sfactor.value) == false)
					return false;
							
				if(numTypeCheck("Initial size",document.misc.initsize.value) == false)
					return false;
		
				if(numTypeCheck("Maximum size",document.misc.maxsize.value) == false)
					return false;
				
				if(numTypeCheck("Minimum size",document.misc.minsize.value) == false)
					return false;
				
			if(numTypeCheck("Dial Tone Duration",document.misc.dtonedur.value) == false)
					return false;
			
			if(numTypeCheck("Session Expire Duration",document.misc.sessexpires.value) == false)
					return false;
			
			if(numTypeCheck("Max Dial Digit",document.misc.diallen.value) == false)
					return false;

					return true;
			}
        </script>
    </head>

    <body class="decBackgroundDef">
    	
		<span class="textTitle">Voip/Dect &gt; Miscelenious </span>
		<br>
		<br>
	
        <div align="center">
        	<FORM name="misc" ACTION = "/goform/ifx_set_voip_sip_misc" METHOD ="POST"> 
<input type="hidden" name="page" value="voip_misc.asp">
<input type="hidden" name="RegVal" value="0">
            <table class="tableInfo" summary="Table">
                <tr>
                    <th colspan="2">Configuration</th>
                </tr>
				<tr>
					<td>Unsolicited Notify</td>
					<td><input type="checkbox" name="unotify" value="1" <%ifx_get_voip_sip_misc("unotify");%>></td>
				</tr>
				<tr>
					<td>Silence Supression</td>
					<td><input type="checkbox" name="supression" value="1" <%ifx_get_voip_sip_misc("supression");%>></td>
				</tr>
				<tr>
          <td>Clock Master</td>
          <td><input type="checkbox" name="clkmaster" value="1" <%ifx_get_voip_sip_misc_new("clkmaster");%>></td>
        </tr>
				<tr>
					<td>Jitter Buffer Type</td>
					<td><select name="jbuffer" size="1"> <%ifx_get_voip_sip_misc_new("jbuffer");%> </select></td>
				</tr>
				<tr>
					<td>Scalling Factor</td>
					<td><input type="text" name="sfactor" size="8" value=<%ifx_get_voip_sip_misc_new("sfactor");%> ></td>
				</tr>
				<tr>
					<td>Initial Size</td>
					<td><input type="text" name="initsize" size="8" value=<%ifx_get_voip_sip_misc_new("initsize");%> ></td>
				</tr>
				<tr>
					<td>Maximum Size</td>
					<td><input type="text" name="maxsize" size="8" value=<%ifx_get_voip_sip_misc_new("maxsize");%> ></td>
				</tr>
				<tr>
					<td>Minimum Size</td>
					<td><input type="text" name="minsize" size="8" value=<%ifx_get_voip_sip_misc_new("minsize");%> ></td>
				</tr>
				<tr>
					<td>Dial Tone Duration</td>
					<td><input type="text" name="dtonedur" size="8" value=<%ifx_get_voip_sip_misc("dtonedur");%> > (in Secs)</td>
				</tr>
				<tr>
					<td>Session Expire Duration</td>
					<td><input type="text" name="sessexpires" size="8" value=<%ifx_get_voip_sip_misc("sessexpires");%> > (in Secs)</td>
				</tr>
				<tr>
					<td>Dial Digit Length </td>
					<td><input type="text" name="diallen" size="8" value=<%ifx_get_voip_sip_misc_new("diallen");%> > </td>
				</tr>
					<tr>
					<td>Fxo Enable(Needs reboot)</td>
          <td><input type="checkbox" name="FxoEn" value=1 <%ifx_get_voip_sip_misc("FxoEn");%>></td>
				</tr>
					
                <tr>
                    <td colspan="2" align="right">
                    <button type="submit" onClick="return submitMisc();">Apply</button> </td>
                </tr>
            </table>
			</form>
        </div>
    </body>
</html>

