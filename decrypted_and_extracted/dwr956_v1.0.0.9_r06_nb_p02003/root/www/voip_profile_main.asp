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
    </head>

    <body class="decBackgroundDef">
        <div>
            <span class="textTitle">Service</span>
        </div>
        <br />
         

        <div align="center">
            <form method="post" action="">
                <table class="tableInfo" summary="" style="width:70%;">
                    <tr>
                        <th colspan="4" class="curveLeft"><span class=
                    "cellWrapper"><img alt="" src=
                    "images/RightCurve.png" /></span>Summary</th>
                    </tr>

					<tr>
                        <td>Status</td>

                        <td><%ifx_get_voip_sip_profstate("profstatusquery");%></td>
                        
                    </tr>
					<tr>
                        <td>Proxy Address</td>

                        <td> <%ifx_get_voip_sip_server("ProxyStatusQuery");%>:<%ifx_get_voip_sip_server("ProxyIP");%>:<%ifx_get_voip_sip_server("ProxyPort");%>;transport=<%ifx_get_voip_sip_server("ProxyPtlQuery");%></td>
                    </tr>
					<tr>
                        <td>Registrar Address</td>

                        <td><%ifx_get_voip_sip_server("RegIP");%>:<%ifx_get_voip_sip_server("RegPort");%>;transport=<%ifx_get_voip_sip_server("RegPtlQuery");%></td>
                        
                    </tr>
										<tr>
                        <td>Voice Mail</td>
                        <td><%ifx_get_voip_sip_Vms("VmsStatusQuery");%></td>
                    </tr>								


                    <tr class="tableEmptyRow">
                        <td colspan="4"> </td>
                    </tr>

                    <tr class="tableEmptyRow">
                        <td colspan="4" class="alignRight"><button type=
                        "button" onclick=
                        "document.location='voip_profile_SIP.asp'">
                        Edit</button></td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>

