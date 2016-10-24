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
			var selected=0;
			function navigate(){
				if(selected == 0){
						alert("Please select a line to Edit\n");
				}
				else if(selected == 1){
				 document.line_adv.LineId.value ="4";
				 	document.line_adv.page.value="voip_line_pstn.asp";
					document.line_adv.submit();
				 }
				 else{
							document.line_adv.LineId.value = selected-1;
							document.line_adv.submit();
							//parent.main3.location='voip_line_voip.asp';
				 }
        
			}
			function deleteLine(){
			if(selected > 1){
			
			if(selected-1 == 1){
						alert("Can't Delete the Default Line");
				}
				else{
							document.delline.line_num.value= selected-1;
							document.delline.submit();
				}
			}
			else if(selected == 1){
				alert("Cannot delete PSTN Line");
			}else{
				alert("Please slect a line to delete");
			}
	}
		</script>
    </head>

    <body class="decBackgroundDef">
        <div>
            <span class="textTitle">Line</span>
        </div>
        <br />
         

        <div align="center">
                <table class="tableInfo" cellspacing="1"
                cellpadding="6" summary="">
                    <tr>
                        <th class="curveLeft">S.No.</th>
                        <th>Line Name</th>
						
						<th>Status</th>
                        <th class="curveRight">Edit</th>
                    </tr>
<form name="line_adv" action="/goform/ifx_set_voip_sip_lineno" method="post">
<input type="hidden" name="page" value="voip_line_voip.asp">
<input type="hidden" name="LineId" value="">
<tr>
<td>1</td>
<td><%ifx_get_voip_sip_pstn("pstn_name")%></td>
<td><%ifx_get_voip_sip_pstn("pstn_stat")%></td>
<td><input type="radio" name="lineselect" onclick="selected=1" />
</tr>
					<%ifx_get_voip_sip_createline();%>
</form>
<FORM METHOD="POST" ACTION="/goform/ifx_set_voip_sip_delline" name="delline">
<input type="hidden" name="page" value="voip_line_summary.asp">
<input type="hidden" name="line_num" value="" />
</form>
                    <tr class="tableEmptyRow">
                        <td colspan="6"> </td>
                    </tr>
                    <tr class="tableEmptyRow">
                        <td colspan="6" class="alignRight">
												 <button type="button" onClick="javascript: document.location.href='page_addline.asp'">Add</button> 
													<button type="button" onclick="javascript: navigate();">Edit</button>
													<button type="button" onClick="javascript: deleteLine();">Delete</button>
												</td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>

