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
        <title></title>
        <script>
            		function submitFXS()
            		{
              		document.analog.voip_line.disabled = false;
              		document.analog.number.disabled = false;
              		
									
									if (isBlank(document.analog.number.value))
              		{
                		alert('Number should not be blank ');
                		return false;
									}	
									if (isNaN(document.analog.number.value) || document.analog.number.value <=0 )
              		{
                		alert(' Invalid Number ');
                		return false;
              		}
            				return true;
								}
            
            function numline()
            {
              var num;
              num = <%ifx_get_voip_sip_analog("numlines");%>;
            
              if (num <= 1)
              {
                document.analog.voip_line.disabled = true;
              }
              else
              {
                document.analog.voip_line.disabled = false;
              }
              return true;              
            }
            
            function FormInit()
            {
              numline();
              return true;
            }
            
        </script>
    </head>

    <body class="decBackgroundDef" onLoad="FormInit();">
		<span class="textTitle">Terminals &gt; Phone </span>
		<br>
		<br>
        <div align="center">
        	<FORM name="analog" ACTION = "/goform/ifx_set_voip_sip_analog" METHOD = "POST">
			<input type="hidden" name="page" value="voip_int_phone.asp">			
            <table class="tableInput" summary="Table">
                <tr>
                    <th colspan="2">Phone</th>
                </tr>
				<tr>
					<td>Number</td>
					<td><input type="text" name="number" disabled="disabled" value="<%ifx_get_voip_sip_analog("number");%>" /></td>
					</tr>
                <tr>
                    <td>Default Line</td>

                    <td><select name="voip_line">
<%ifx_get_voip_sip_analog("defaultline");%>
</select></td>
                </tr>

                <tr>
                    <td>Echo Cancellation</td>

                    <td><select name="echoCancel"><%ifx_get_voip_sip_analog("echoCancel");%></select></td>
                </tr>

                <tr>
                    <td colspan="2" align="right">
                    <button type="submit" onClick="return submitFXS();">Apply</button> </td>
                </tr>
            </table>
			</form>
        </div>
    </body>
</html>

