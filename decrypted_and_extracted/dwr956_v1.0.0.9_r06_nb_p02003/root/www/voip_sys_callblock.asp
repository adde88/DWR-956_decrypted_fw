<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
			 <meta http-equiv="Pragma" content="no-cache">
        <meta name="generator" content=
        "HTML Tidy, see www.w3.org" />

        <title></title>
        <link rel="stylesheet" type="text/css" href="final.css" />
        <script language="JavaScript" type="text/javascript" src="validations.js"></script>
<script type="text/javascript">
	function CheckInvalidChar(s)
{
	for (i=0;i< s.length;i++)
	{
		c=s.charAt(i);
		if (c=='%') 
			return false;
	}
	return true;
}
function updateData()
{
  if (document.cbs.psel.length == 0)
  {
   return false;
  }
  var selText = document.cbs.psel.options[document.cbs.psel.selectedIndex].text;
  var selval = document.cbs.psel.options[document.cbs.psel.selectedIndex].value;
  document.cbs.callbk.value = selText;
}

        function getTheCallList(theText, theValue){
            var newOpt = new Option(theText, theValue);
            var theSel;
            var selLength;
            theSel = document.cbs.psel;
            selLength = theSel.length;
            theSel.options[selLength] = newOpt;
        }
        
        /* This function submits the changes. */
        function submitCBS(){
           	var cbs; 
            /* Get the List of Calls  */
            /*GetCallBlockArray();*/
            if (GetCallBlockArray() == false) 
                return false;
            else {
                cbs = document.getElementById("cbs");
                cbs.submit();
            }
        }
        
        /* This function is called by submitCBS() before submitting */
        function GetCallBlockArray(){
        
            var PArray = new Array();
            PArray[0] = "";
            if (document.cbs.psel.length > 10) {
                alert('Number of Entry should not exceed 10 ');
                return false;
            }
            for (i = 0; i < document.cbs.psel.length; i++) {
                PArray[i] = document.cbs.psel.options[i].text;
            }
            if (document.cbs.psel.length > 0) {
                document.cbs.pCallBlockString.value = PArray.join(',');
            }
            
            return true;
        }
        
        /* Adds an entry to CallBlock */
        function addOption_cbs(){
            var newOpt = new Option(document.cbs.callbk.value, document.cbs.callbk.value)
            if (document.cbs.callbk.value == '') {
                alert('Add an Entry first');
                return false;
            }
            if (document.cbs.psel.length > 9) {
                alert('Number of Entry should not exceed 10 ');
                return false;
            }
            if (!isValidName(document.cbs.callbk.value)) {
                alert('Invalid Call Block Entry');
                return false;
            }
            
            if (CheckInvalidChar(document.cbs.callbk.value) == false) {
                alert('% character is not allowed');
                return false;
            }
            /*if (document.cbs.psel.length == 0)
             {
             return false;
             }*/
            for (i = 0; i < document.cbs.psel.length; i++) {
                if (document.cbs.callbk.value == document.cbs.psel.options[i].value) {
                    alert('Entry exists');
                    return false;
                }
            }
            document.cbs.psel.options[document.cbs.psel.length] = newOpt;
            
        }
        
        function ModOption_cbs(){
        
            var newOpt = new Option(document.cbs.callbk.value, document.cbs.callbk.value)
            for (i = 0; i < document.cbs.psel.length; i++) {
                if (document.cbs.callbk.value == document.cbs.psel.options[i].value) {
                    alert('Entry exists');
                    return false;
                }
            }
            if (!isValidName(document.cbs.callbk.value)) {
                alert('Invalid Call Block Entry');
                return false;
            }
            
            document.cbs.psel.options[document.cbs.psel.selectedIndex] = newOpt;
        }
        
        function DelOption_cbs(){
            if (document.cbs.psel.length == 0) {
                alert('No Entry in the List');
                return false;
            }
            
            document.cbs.psel.options[document.cbs.psel.selectedIndex] = null;
        }
</script>

<script type="text/javascript">
	function FormInit(){
    	<%ifx_get_voip_sip_callbk("updateData");%>
	}
</script>
    </head>

    <body class="decBackgroundDef" onload="FormInit();">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                <li><a href="voip_sys_speeddial.asp"><span>Speed
                Dial</span></a></li>
                <li><a href="#" class="selected"><span>Call
                Block</span></a></li>
                <li><a href="voip_sys_NumPlan.asp"><span>Numbering
                Plan</span></a></li>
      <li><a href="voip_sys_fax.asp"><span>Fax over IP</span></a></li>
			<li><a href="voip_sys_Debug.asp"><span>Debug</span></a></li>
            </ul>
        </div>
        <br />
         <span class="textTitle">Miscellanous &gt; Call
        Block</span> 

        <div align="center">
            <form name="cbs" id="cbs" method="post" onsubmit=
            "return false" action=
            "/goform/ifx_set_voip_sip_callbk">
            	<!-- Added to satisfy POST Functions -->
				<input type="hidden" name="page" value="voip_sys_callblock.asp">
<input type="hidden" name="addflag" value="0">
<input type="hidden" name="delflag" value="0">
<input type="hidden" name="modflag" value="0">
<input type="hidden" name="pCallBlockString" >
<input type="hidden" name="status" value="0">
<input type="hidden" name="cvflag" value="0">

                <table class="tableInput" summary="">
                    <tr>
                        <th colspan="2">Call Block</th>
                    </tr>

                    <tr>
                        <td>Outgoing Call Block</td>

                        <td><select name="callbar">
                            <%ifx_get_voip_sip_callbk("callbar");%>
                        </select> </td>
                    </tr>

                    <tr>
                        <th colspan="2">Incoming Call Block</th>
                    </tr>

                    <tr>
                        <td>Enter the Number to Block</td>

                        <td><input type="text" maxlength="31" name=
                        "callbk" size="32" value="" /></td>
                    </tr>

                    <tr>
                        <td> </td>

                        <td><button name="add" onclick=
                        "addOption_cbs();">Add Number</button>
                        </td>
                    </tr>

                    <tr rowspan="5">
                        <td>Current Block List</td>

                        <td><select name="psel" size="5" onclick=
                        "updateData();" style="width:250px">
                        </select> </td>
                    </tr>

                    <tr>
                        <td> </td>

                        <td><button name="mod" onclick=
                        "ModOption_cbs();">Edit</button> <button
                        name="del " onclick=
                        "DelOption_cbs();">Delete</button> </td>
                    </tr>

                    <tr>
                        <td colspan="2"><br />
                         </td>
                    </tr>

                    <tr>
                        <td colspan="2" align="right"><button type=
                        "submit" onclick=
                        "return submitCBS();">Apply</button></td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>
