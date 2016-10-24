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
				<script language="JavaScript" src="validations.js"></script>

        <title></title>
		<script type='text/javascript'>
function MakeArray(n)
{
   this.length = n
   for (i = 0;i<n;i++)
      this[i] = null;
}
			var RuleAct = new MakeArray(50);
var Prefix = new MakeArray(50);      
var MinLen  = new MakeArray(50);
var MaxLen = new MakeArray(50);      
var RemDgts  = new MakeArray(50);
var PosRem  = new MakeArray(50);
var DigIns  = new MakeArray(50);
var PosIns  = new MakeArray(50);
var DigRep  = new MakeArray(50);
var PosRep  = new MakeArray(50);

RuleAct[0] = 0;
Prefix[0] = 0;
MinLen[0] = 0;
MaxLen[0] = 0;
RemDgts[0] = 0;
PosRem[0] = 0;
DigIns[0] = 0;
PosIns[0] = 0;
DigRep[0] = 0;
PosRep[0] = 0;

RULE = 'RuleAct';
PREFIX = 'Prefix';
MAX = 'MaxLen'; // this is being set via script
MIN = 'MinLen';
REMDGTS = 'RemDgts';
POS2REM = 'PosRem';
DIGINS = 'DigIns';
POSINS = 'PosIns';
DIGREP = 'DigRep';
POSREP = 'PosRep';


TABLE_NAME = 'tblSample'; // this should be named in the HTML
ROW_BASE = 1; // first number (for display)
row_num = <%ifx_get_voip_sip_numplan("Rules");%>;

<%ifx_get_voip_sip_numplan("update");%>
<%ifx_get_voip_sip_numplan("PopulateRules");%>


function fillInRows()
{
	for (i=0;i < row_num; i++)
	{
		addRowToTable();
	}
}

function myRowObject(one, two, three, four, five, six, seven, eight, nine, ten, eleven)
{
	this.one = one; /* checkbox object*/
	this.two = two; /* Rule object*/
	this.three = three; /* input text object*/
	this.four = four; /* input text object*/
	this.five = five; /* input text object*/
	this.six = six; /* input text object*/
	this.seven = seven; /* input text object*/
	this.eight = eight; /* input text object*/
	this.nine = nine; /* input text object*/
	this.ten = ten; /* input text object*/
	this.eleven = eleven; /* input text object*/
}
			function submitNUM_PLAN()
{
	var index = 0;
	var index1 = 0;
	var index2 = 0;
  var ReturnStatus;
  var str = document.num_plan.LongTmr.value;
  var str1 = document.num_plan.ShortTmr.value;

	if(document.num_plan.LongTmr.value <2 || 
									document.num_plan.LongTmr.value >10)
	{
    alert('Long Timer value should be between 2 to 10 seconds');
		return false;
	}
  if(str.charCodeAt(0) <48 || str.charCodeAt(0) >57 || str.charCodeAt(1) <48 || str.charCodeAt(1) >57)
  {
    alert('Long Timer Value should be an integer');
    return false;
  }
        
	if(document.num_plan.ShortTmr.value <2 || 
									document.num_plan.ShortTmr.value >4)
	{
    alert('Short Timer value should be between 2 to 4 seconds');
		return false;
	}
  if(str1.charCodeAt(0) <48 || str1.charCodeAt(0) >57 || str1.charCodeAt(1) <48 || str1.charCodeAt(1) >57)
  {
    alert('Short Timer Value should be an integer');
    return false;
  }
   if(document.num_plan.LongTmr.value < document.num_plan.ShortTmr.value)
        {
    alert('Long Timer value should be greater than Short Timer value');
                return false;
        }
	for (index = 1;index <= document.num_plan.rownum.value;index++)
	{
	    Rule1 = RULE + index;
		Pre1 = PREFIX + index;
		Min1 = MIN + index;
		Max1 = MAX + index;
		RemDgts1 = REMDGTS + index;
		Pos2Rem1 = POS2REM + index;
		DigIns1 = DIGINS + index;
		PosIns1 = POSINS + index;
		DigRep1 = DIGREP + index;
		PosRep1 = POSREP + index;
	
        var Rule = document.getElementById(Rule1).value;
		var Pre = document.getElementById(Pre1).value;
		var Min = parseInt(document.getElementById(Min1).value);
		var Max = parseInt(document.getElementById(Max1).value);
		var Mint = document.getElementById(Min1).value;
		var Maxt = document.getElementById(Max1).value;
		var Remd = document.getElementById(RemDgts1).value;
		var Posrm = document.getElementById(Pos2Rem1).value;
		var Digi = document.getElementById(DigIns1).value;
		var Posi = document.getElementById(PosIns1).value;
		var Digr = document.getElementById(DigRep1).value;
		var Posrp = document.getElementById(PosRep1).value;

		if (!isValidPrefix(Pre))
  	{
		  alert('Not a valid Prefix'+index);
		  return false;
		}
		if (isNaN(Mint))
		{
		 alert('Min Len should be an integer in Rule'+index);
		 return false;
		}
        if (isNaN(Maxt))
		{
		 alert('Max Len should be an integer in Rule'+index);
		 return false;
		}
	    if (isNaN(Remd))
		{
		 alert('Rem Dgts should be an integer in Rule'+index);
		 return false;
		}
    	if (isNaN(Posrm))
		{
		 alert('Pos 2 Rem should be an integer in Rule'+index);
		 return false;
		}
	/*
    	if (isNaN(Digi))
		{
		 alert('Dig 2 Ins should be an integer in Rule'+index);
		 return false;
		}
    	if (isNaN(Posi))
		{
		 alert('Pos 2 Ins should be an integer in Rule'+index);
		 return false;
		}
    	if (isNaN(Digr))
		{
		 alert('Dig 2 Rep should be an integer in Rule'+index);
		 return false;
		}
    	if (isNaN(Posrp))
		{
		 alert('Pos 2 Rep should be an integer in Rule'+index);
		 return false;
		}
*/
		/*if (!isValidHyphenPrefix(Pre))
  	{
		  alert('The digit before Hyphen should be less than the digit after Hyphen in Prefix'+index);
		  return false;
		}*/
		if (Max < Min)
		{
			//alert('MAX'+Max);
			//alert('MIN'+Min);
		  alert('Max Length should be greater than Min Length - Rule'+index);
		  return false;
		}
		for (index1=1;index1 <= document.num_plan.rownum.value;index1++)
		{
		 Pre2 = PREFIX + index1;
		 var PreChk = document.num_plan[Pre2].value;
		 if (index1 != index)
		 {
			if (Pre == PreChk)
			{
			 alert('No two rules can have same Prefix: Rule'+index+' and Rule'+index1);
			 return false;
			}
		 }
		}
       for (index2=1;index2 <= document.num_plan.rownum.value;index2++)
		{
		 Rule2 = RULE + index2;
		 var RuleChk = document.num_plan[Rule2].value;
		 if (index2 != index)
		 {
			if (Rule == RuleChk)
			{
			 alert('No rule should come twice - Rule'+index+' and Rule'+index2);
			 return false;
			}
		 }
		}
	}

  return ReturnStatus;
}
function addRowToTable()
{
		var tbl = document.getElementById(TABLE_NAME);
		var nextRow = tbl.tBodies[0].rows.length;
		var iteration = nextRow + ROW_BASE;
	  var	num = nextRow;
		/* add the row */
		var row = tbl.tBodies[0].insertRow(num);

		if(iteration >25)
		{
			alert("Cannot ADD more. Please Modify any one of the rule.");
			return false;
		}
		/* CONFIG: This whole section can be configured
		
		// cell 0 - Checkbox */
		var cell0 = row.insertCell(0);
		var sel = document.createElement('input');
		sel.setAttribute('type', 'checkbox');
		cell0.appendChild(sel);
		
		/* cell 1 - Select */
  		var cell1 = row.insertCell(1);
 		var rule = document.createElement('select');
		var tmp = RuleAct[iteration-1];
		rule.setAttribute('name', RULE + iteration);
		rule.setAttribute('id', RULE + iteration);
  	rule.options[0] = new Option('Activate Anonymus CallBlock','0');
  	rule.options[1] = new Option('Deactivate Anonymus CallBlock','1');
  	rule.options[2] = new Option('Auto-Redial Active','2');
  	rule.options[3] = new Option('Auto-Redial DeActive','3');
  	rule.options[4] = new Option('DND Activate','4');
  	rule.options[5] = new Option('DND DeActivate','5');
  	rule.options[6] = new Option('Callwaiting Activate','6');
  	rule.options[7] = new Option('Callwaiting DeActivate','7');
  	rule.options[8] = new Option('Callwaiting Activate Per Call','8');
  	rule.options[9] = new Option('Callwaiting DeActivate Per Call','9');
  	rule.options[10] = new Option('Activate Unconditional Call Forward','10');
  	rule.options[11] = new Option('DeActivate Unconditional Call Forward','11');
  	rule.options[12] = new Option('Activate Call Forward On Busy','12');
  	rule.options[13] = new Option('DeActivate Call Forward On Busy','13');
  	rule.options[14] = new Option('Activate Call Forward On NoAnswer','14');
  	rule.options[15] = new Option('DeActivate Call Forward On NoAnswer','15');
  	rule.options[16] = new Option('Activate Caller ID Block','16');
  	rule.options[17] = new Option('DeActivate Caller ID Block','17');
  	rule.options[18] = new Option('Activate Caller ID Block Per Call','18');
  	rule.options[19] = new Option('DeActivate Caller ID Block Per Call','19');
  	/*rule.options[20] = new Option('Default Outbnd Interface to PSTN','20');
  	rule.options[21] = new Option('Default Outbnd Interface to VOIP','21');*/
  	rule.options[20] = new Option('Blind Transfer','20');
  	/*rule.options[23] = new Option('PSTN Hook Flash','23');*/
  	rule.options[21] = new Option('Call Return','21');
  	rule.options[22] = new Option('CallWaiting Reject','22');
  	rule.options[23] = new Option('VoiceMail Retrieval','23');
  	rule.options[24] = new Option('Internal General Call','24');
  	rule.options[25] = new Option('Disconnect Last Active Call','25');
  	rule.options[26] = new Option('Resume Last Active Call','26');
  	rule.options[27] = new Option('Resume NonLast Active Call','27');
  	rule.options[28] = new Option('Conference','28');
  	rule.options[29] = new Option('Speed Dial','29');
  	rule.options[30] = new Option('EXTN Dial','30');
  	/*rule.options[34] = new Option('Server Side Cfg','34');*/
  	rule.options[31] = new Option('Two Stage PSTN','31');
  	rule.options[32] = new Option('Local PSTN','32');
  	/*rule.options[37] = new Option('Local VOIP','37');
  	rule.options[38] = new Option('PSTN STD','38');
  	rule.options[39] = new Option('VoIP STD','39');
  	rule.options[40] = new Option('ISD PSTN','40');
  	rule.options[41] = new Option('ISD VOIP','41');*/
  	rule.options[33] = new Option('Emergency','33');
  	rule.options[34] = new Option('DialOut Defult','34');
  	/*rule.options[44] = new Option('Direct IP Dial','44');*/
  	rule.options[35] = new Option('FXS Delayed Hotline Activate','35');
  	rule.options[36] = new Option('FXS Delayed Hotline DeActivate','36');
		rule.options[tmp].selected = true;
    cell1.appendChild(rule);

		/* cell 2 - input text*/
		var cell2 = row.insertCell(2);
		var prefix = document.createElement('input');
		prefix.setAttribute('type', 'text');
		prefix.setAttribute('name', PREFIX + iteration);
		prefix.setAttribute('id', PREFIX + iteration);
		prefix.setAttribute('size', '5');
        prefix.setAttribute('maxLength', '41');
		prefix.setAttribute('value', Prefix[iteration-1]);
		cell2.appendChild(prefix);

		/* cell 3 - input text*/
		var cell3 = row.insertCell(3);
		var min = document.createElement('input');
		min.setAttribute('type', 'text');
		min.setAttribute('name', MIN + iteration);
		min.setAttribute('id', MIN + iteration);
		min.setAttribute('size', '5');
		min.setAttribute('maxLength', '2');
		min.setAttribute('value', MinLen[iteration-1]);
		cell3.appendChild(min);
	
	
		/* cell 4 - input text*/
		var cell4 = row.insertCell(4);
		var max = document.createElement('input');
		max.setAttribute('type', 'text');
		max.setAttribute('name', MAX + iteration);
		max.setAttribute('id', MAX + iteration);
		max.setAttribute('size', '5');
		max.setAttribute('maxLength', '2');
		max.setAttribute('value', MaxLen[iteration-1]);
		cell4.appendChild(max);

		/* cell 5 - input text*/
		var cell5 = row.insertCell(5);
		var remdgts = document.createElement('input');
		remdgts.setAttribute('type', 'text');
		remdgts.setAttribute('name', REMDGTS + iteration);
		remdgts.setAttribute('id', REMDGTS + iteration);
		remdgts.setAttribute('size', '5');
		remdgts.setAttribute('maxLength', '2');
		remdgts.setAttribute('value', RemDgts[iteration-1]);
		cell5.appendChild(remdgts);

		
		/* cell 6 - input text*/
		var cell6 = row.insertCell(6);
		var pos2rem = document.createElement('input');
		pos2rem.setAttribute('type', 'text');
		pos2rem.setAttribute('name', POS2REM + iteration);
		pos2rem.setAttribute('id', POS2REM + iteration);
		pos2rem.setAttribute('size', '5');
		pos2rem.setAttribute('maxLength', '2');
		pos2rem.setAttribute('value', PosRem[iteration-1]); 
		cell6.appendChild(pos2rem);

		/* cell 7 - input text*/
		//var cell7 = row.insertCell(7);
		var digins = document.createElement('input');
		digins.setAttribute('type', 'hidden');
		digins.setAttribute('name', DIGINS + iteration);
		digins.setAttribute('id', DIGINS + iteration);
		digins.setAttribute('size', '5');
		digins.setAttribute('maxLength', '2');
		digins.setAttribute('value', DigIns[iteration-1]);
		cell6.appendChild(digins);

		/* cell 8 - input text*/
		//var cell8 = row.insertCell(8);
		var posins = document.createElement('input');
		posins.setAttribute('type', 'hidden');
		posins.setAttribute('name', POSINS + iteration);
		posins.setAttribute('id', POSINS + iteration);
		posins.setAttribute('size', '5');
		posins.setAttribute('maxLength', '2');
		posins.setAttribute('value', PosIns[iteration-1]);
		cell6.appendChild(posins);
		
		/* cell 9 - input text*/
		//var cell9 = row.insertCell(9);
		var digrep = document.createElement('input');
		digrep.setAttribute('type', 'hidden');
		digrep.setAttribute('name', DIGREP + iteration);
		digrep.setAttribute('id', DIGREP + iteration);
		digrep.setAttribute('size', '5');
		digrep.setAttribute('maxLength', '2');
		digrep.setAttribute('value', DigRep[iteration-1]);
		cell6.appendChild(digrep);

		/* cell 10 - input text*/
		//var cell10 = row.insertCell(10);
		var posrep = document.createElement('input');
		posrep.setAttribute('type', 'hidden');
		posrep.setAttribute('name', POSREP + iteration);
		posrep.setAttribute('id', POSREP + iteration);
		posrep.setAttribute('size', '5');
		posrep.setAttribute('maxLength', '2');
		posrep.setAttribute('value', PosRep[iteration-1]);
		cell6.appendChild(posrep);
		
/*		<%ifx_get_voip_sip_numplan("increment");%> */
		
		/* Pass in the elements you want to reference later
		// Store the myRow object in each row*/
		row.myRow = new myRowObject(sel, rule, prefix, min, max, remdgts, pos2rem, digins, posins, digrep, posrep);
	  document.num_plan.rownum.value = iteration;
}
function deleteChecked()
{
		var checkedObjArray = new Array();
		var cCount = 0;
	
		var tbl = document.getElementById(TABLE_NAME);
		for (var i=0; i<tbl.tBodies[0].rows.length; i++) {
			if (tbl.tBodies[0].rows[i].myRow && tbl.tBodies[0].rows[i].myRow.one.getAttribute('type') == 'checkbox' && tbl.tBodies[0].rows[i].myRow.one.checked) {
				checkedObjArray[cCount] = tbl.tBodies[0].rows[i];
				cCount++;
			}
		}
		if (checkedObjArray.length > 0) {
			var rIndex = checkedObjArray[0].sectionRowIndex;
			deleteRows(checkedObjArray);
			reorderRows(tbl, rIndex);
		}
	}


function reorderRows(tbl, startingIndex)
{
		if (tbl.tBodies[0].rows[startingIndex]) {
			var count = startingIndex + ROW_BASE;
			for (var i=startingIndex; i<tbl.tBodies[0].rows.length; i++) {
			
				tbl.tBodies[0].rows[i].myRow.two.name = RULE + count; 

				tbl.tBodies[0].rows[i].myRow.three.name = PREFIX + count; 
				
				var tempVal3 = tbl.tBodies[0].rows[i].myRow.three.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.three.value = tempVal3[0]; 

				tbl.tBodies[0].rows[i].myRow.four.name = MIN + count; 
				
				var tempVal4 = tbl.tBodies[0].rows[i].myRow.four.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.four.value = tempVal4[0]; 
				
				tbl.tBodies[0].rows[i].myRow.five.name = MAX + count; 
				
				var tempVal5 = tbl.tBodies[0].rows[i].myRow.five.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.five.value = tempVal5[0];

				tbl.tBodies[0].rows[i].myRow.six.name = REMDGTS + count; 
				
				var tempVal6 = tbl.tBodies[0].rows[i].myRow.six.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.six.value = tempVal6[0]; 

				tbl.tBodies[0].rows[i].myRow.seven.name = POS2REM + count;
				
				var tempVal7 = tbl.tBodies[0].rows[i].myRow.seven.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.seven.value = tempVal7[0]; 

				tbl.tBodies[0].rows[i].myRow.eight.name = DIGINS + count; 
				
				var tempVal8 = tbl.tBodies[0].rows[i].myRow.eight.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.eight.value = tempVal8[0]; 

				tbl.tBodies[0].rows[i].myRow.nine.name = POSINS + count; 
				
				var tempVal9 = tbl.tBodies[0].rows[i].myRow.nine.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.nine.value = tempVal9[0]; 
				
				tbl.tBodies[0].rows[i].myRow.ten.name = DIGREP + count; 
				
				var tempVal10 = tbl.tBodies[0].rows[i].myRow.ten.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.ten.value = tempVal10[0];

				tbl.tBodies[0].rows[i].myRow.eleven.name = POSREP + count; 
				
				var tempVal11 = tbl.tBodies[0].rows[i].myRow.eleven.value.split(' '); 
				tbl.tBodies[0].rows[i].myRow.eleven.value = tempVal11[0]; 
			
				count++;
			}
		}
	}


function deleteRows(rowObjArray)
{
		for (var i=0; i<rowObjArray.length; i++) {
			var rIndex = rowObjArray[i].sectionRowIndex;
			rowObjArray[i].parentNode.deleteRow(rIndex);
			document.num_plan.rownum.value--;
		}
	}
		</script>
    </head>

    <body class="decBackgroundDef" onload="fillInRows();">
        <div id="tabContainer">
            <span class="tabBorder"> </span> 

            <ul id="tabInv">
                <li><a href="voip_sys_speeddial.asp"><span>Speed
                Dial</span></a></li>
                <li><a href=
                "voip_sys_callblock.asp"><span>Call Block</span></a></li>
                <li><a href="#" class="selected"><span>Numbering
                Plan</span></a></li>
                <li><a href="voip_sys_fax.asp"><span>Fax over IP</span></a></li>
                <li><a href=
                "voip_sys_Debug.asp"><span>Debug</span></a></li>
            </ul>
        </div>
        <br />
<span class="textTitle">System &gt; Numbering Plan</span>       
   

        <div align="center"><FORM ACTION="/goform/ifx_set_voip_sip_numplan" METHOD="POST" NAME="num_plan" onSubmit="return submitNUM_PLAN();">
<input type="hidden" name="page" value="voip_sys_NumPlan.asp">
<input type="hidden" name="status" value="0">
<input type="hidden" name="rownum">
<input type="hidden" name="cvflag" value="0">
            Long Timer:    <input type="text" name="LongTmr" size="5" maxlength="2" value="<%ifx_get_voip_sip_numplan("LongTmr");%>"> sec
            Short Timer:   <input type="text" name="ShortTmr" size="5" maxlength="2" value="<%ifx_get_voip_sip_numplan("ShortTmr");%>"> sec
            <br />
             
			
            <table id="tblSample" class="tableInput" cellspacing="0" summary=
            "Table">
						<thead>
                <tr>
                    <th>Select</th>

                    <th>Rule</th>

                    <th>Prefix</th>

                    <th>Min Len</th>

                    <th>Max Len</th>

                    <th>Rem Dgts</th>

                    <th>Pos to Rem</th>

                </tr>
					</thead>
	<tbody></tbody>
               
					<tfoot>
                <tr>
                    <td align="left" colspan="12"><button onclick="addRowToTable();" type=
                    "button">Add</button><button onclick=
                    "deleteChecked();" type="button">Delete</button> </td>
                </tr>

                <tr>
                    <td align="right" colspan="12">
                    <button type="submit">Apply</button>    
                    </td>
                </tr>
</tfoot>
            </table>
			</form>
        </div>
    </body>
</html>

