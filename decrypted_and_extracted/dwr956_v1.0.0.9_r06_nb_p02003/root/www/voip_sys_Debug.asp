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
        <div id="tabContainer">
            <span class="tabBorder"> </span> 
	           <ul id="tabInv">
                <li><a href="voip_sys_speeddial.asp"><span>Speed
                Dial</span></a></li>
                <li><a href=
                "voip_sys_callblock.asp"><span>Call Block</span></a></li>
                <li><a href="voip_sys_NumPlan.asp"><span>Numbering
                Plan</span></a></li>
								<li><a href="voip_sys_fax.asp"><span>Fax over IP</span></a></li>
                <li><a href="#" class=
                "selected"><span>Debug</span></a></li>
            </ul>
        </div>
        <br />
<span class="textTitle">System &gt; Debug</span>

         

        <div align="center">
            <table class="tableInput" summary="Table">
            	<FORM ACTION="/goform/ifx_set_voip_sip_debug " METHOD="POST" NAME="ds">
<input type="hidden" name="page" value="voip_sys_Debug.asp">
<input type="hidden" name="status" value="0">
<input type="hidden" name="cvflag" value="0">
                <tr>
                    <th colspan="3">Debug</th>
                </tr>

                <tr>
                    <td> </td>

                    <td>Debug Type</td>

                    <td>Debug Level</td>
                </tr>

                <tr>
                    <td>Call Manager</td>

                    <td><SELECT NAME = "AppDT"> <%ifx_get_voip_sip_debug("AppDT");%>  </SELECT></td>

                    <td><SELECT NAME = "AppDL"> <%ifx_get_voip_sip_debug("AppDL");%> </SELECT></td>
                </tr>

                <tr>
                    <td>Media Manager</td>

                    <td><SELECT NAME = "MmDT"> <%ifx_get_voip_sip_debug("MmDT");%>  </SELECT></td>

                    <td><SELECT NAME = "MmDL"> <%ifx_get_voip_sip_debug("MmDL");%> </SELECT></td>
                </tr>

                <tr>
                    <td>Agents</td>

                    <td><SELECT NAME = "AgentDT"> <%ifx_get_voip_sip_debug("AgentDT");%>  </SELECT></td>

                    <td><SELECT NAME = "AgentDL"> <%ifx_get_voip_sip_debug("AgentDL");%> </SELECT></td>
                </tr>

                <tr>
                    <td>VMAPI</td>

                    <td><SELECT NAME = "CmDT"> <%ifx_get_voip_sip_debug("CmDT");%> </SELECT></td>

                    <td><SELECT NAME = "CmDL"> <%ifx_get_voip_sip_debug("CmDL");%> </SELECT></td>
                </tr>

                <tr>
                    <td>RTP</td>

                    <td><SELECT NAME = "RtpDT"> <%ifx_get_voip_sip_debug("RtpDT");%> </SELECT></td>

                    <td><SELECT NAME = "RtpDL"> <%ifx_get_voip_sip_debug("RtpDL");%> </SELECT></td>
                </tr>

                <tr>
                    <td>SIP</td>

                    <td><SELECT NAME = "SipDT"> <%ifx_get_voip_sip_debug("SipDT");%></SELECT></td>

                    <td><SELECT NAME = "SipDL"> <%ifx_get_voip_sip_debug("SipDL");%></SELECT></td>
                </tr>

                <%ifx_get_voip_sip_debug("fax");%>

                <tr>
                    <td> </td>
                </tr>

                <tr>
                    <td align="right" colspan="3">
                    <button type="submit">Apply</button>
                    </td>
                </tr>
				</form>
            </table>
            <br />
             <!--
                                                        <div class="inputbuttons">
                                                            <button>Apply</button>
                                                            <button>Cancel</button>
                                                        </div>  
                                                        -->
        </div>
    </body>
</html>

