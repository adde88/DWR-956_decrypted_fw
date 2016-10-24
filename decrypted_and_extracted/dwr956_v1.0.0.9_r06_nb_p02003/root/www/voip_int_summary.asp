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
		<script type="text/javascript">
        var selected = 0;
        function navigate(){
            //alert("as:"+document.exa.phone.selectedIndex);
            if (selected > 6) {
                document.analog.FxsId.value = selected-6;
                document.analog.submit();
                //document.location = "voip_int_phone.asp";
            }
            else {
                document.dect.DectId.value = selected;
                document.dect.submit();
                //document.location = "voip_int_dect.asp";
            }
        }
		</script>
    </head>

    <body class="decBackgroundDef">
        <div>
            <span class="textTitle">Terminals</span>
        </div>
        <br />
         

        <div align="center">
        	
        <form name="dect" method="post" action="/goform/ifx_set_voip_sip_dectno">
            <input type="hidden" name="page" value="voip_int_dect.asp"><input type="hidden" name="DectId">
        </form>
        <form name="analog" method="post" action="/goform/ifx_set_voip_sip_fxsno">
            <input type="hidden" name="page" value="voip_int_phone.asp"><input type="hidden" name="FxsId">
        </form>
			
                <table class="tableInfo" cellspacing="1"
                cellpadding="6" summary="">
                    <tr>
                        <th class="curveLeft">S.No.</th>
                        <th>Number</th>
						<th>Type</th>
						<th>Default Line</th>
                        <th>Status</th>
                        <th class="curveRight">Action</th>
                    </tr>
<!-- Sample Set of Values
                    <tr>
                        <td>1</td>

                        <td>1001</td>
						
                        <td>Phone</td>
						
						<td>Line 1</td>
						
						<td>N/A</td>

                        <td class="colInput"><input type="radio" name="phone" value="1" checked="checked" onclick="selected=0"/>                                                                                                                                                    
                         </td>
                    </tr>
-->			
<%ifx_get_voip_sip_dect("dect");%>
	<%ifx_get_voip_sip_analog("fxs");%>
	
                    <tr class="tableEmptyRow">
                        <td colspan="6"> </td>
                    </tr>
                    <tr class="tableEmptyRow">
                        <td colspan="6" class="alignRight"><button type=
                        "button" onclick=
                        "javascript: navigate();">
                        Edit</button></td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>

