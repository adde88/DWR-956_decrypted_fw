var RULE = 'Rule';
var PREFIX = 'Prefix';
var MAX = 'MaxLen'; // this is being set via script
var MIN = 'MinLen';
var REMDGTS = 'RemDgts';
var POS2REM = 'Pos2Rem';
var TABLE_NAME = 'tblSample'; // this should be named in the HTML
var ROW_BASE = 1; // first number (for display)
var hasLoaded = false;

/*window.onload=fillInRows;

function fillInRows()
{
	hasLoaded = true;
	addRowToTable();
	addRowToTable();
}
*/
// CONFIG:
// myRowObject is an object for storing information about the table rows
function myRowObject(one, two, three, four, five, six, seven)
{
	num_plan.one = one; // checkbox object
	num_plan.two = two; // Rule object
	num_plan.three = three; // input text object
	num_plan.four = four; // input text object
	num_plan.five = five; // input text object
	num_plan.six = six; // input text object
	num_plan.seven = seven; // input text object
}

/*
 * addRowToTable
 * Inserts at row 'num', or appends to the end if no arguments are passed in. Don't pass in empty strings.
 */
function addRowToTable(num)
{
	if (hasLoaded) {
		alert("Add Row entered");
		var tbl = document.getElementById(TABLE_NAME);
		var nextRow = tbl.tBodies[0].rows.length;
		var iteration = nextRow + ROW_BASE;
		if (num == null) { 
			num = nextRow;
		} else {
			iteration = num + ROW_BASE;
		}
		
		// add the row
		var row = tbl.tBodies[0].insertRow(num);
		
		// CONFIG: requires classes named classy0 and classy1
		row.className = 'classy' + (iteration % 2);
	
		// CONFIG: This whole section can be configured
		
		// cell 0 - Checkbox
		var cell0 = row.insertCell(0);
		var sel = document.createElement('input');
		sel.setAttribute('type', 'checkbox');
		cell0.appendChild(sel);
		
		// cell 1 - Select
  		var cell1 = row.insertCell(1);
 		var rule = document.createElement('select');
		rule.setAttribute('name', RULE + iteration);
  		rule.options[0] = new Option('Act', 'value1');
  		rule.options[1] = new Option('Deact', 'value2');
		rule.options[2] = new Option('Act-Deact', 'value3');
  		cell1.appendChild(rule);

		// cell 2 - input text
		var cell2 = row.insertCell(2);
		var prefix = document.createElement('input');
		prefix.setAttribute('type', 'text');
		prefix.setAttribute('name', PREFIX + iteration);
		prefix.setAttribute('size', '5');
		prefix.setAttribute('value', <%ifx_get_voip_sip_numplan(PREFIX + iteration);%>);
		cell2.appendChild(prefix);


		// cell 3 - input text
		var cell3 = row.insertCell(3);
		var min = document.createElement('input');
		min.setAttribute('type', 'text');
		min.setAttribute('name', MIN + iteration);
		min.setAttribute('size', '5');
		min.setAttribute('value', <%ifx_get_voip_sip_numplan(MIN + iteration);%>);
		cell3.appendChild(min);
		
		// cell 4 - input text
		var cell4 = row.insertCell(4);
		var max = document.createElement('input');
		max.setAttribute('type', 'text');
		max.setAttribute('name', MAX + iteration);
		max.setAttribute('size', '5');
		max.setAttribute('value', <%ifx_get_voip_sip_numplan(MAX + iteration);%>);
		cell4.appendChild(max);

		// cell 5 - input text
		var cell5 = row.insertCell(5);
		var remdgts = document.createElement('input');
		remdgts.setAttribute('type', 'text');
		remdgts.setAttribute('name', REMDGTS + iteration);
		remdgts.setAttribute('size', '5');
		remdgts.setAttribute('value', <%ifx_get_voip_sip_numplan(REMDGTS + iteration);%>);
		cell5.appendChild(remdgts);

		
		// cell 6 - input text
		var cell6 = row.insertCell(6);
		var pos2rem = document.createElement('input');
		pos2rem.setAttribute('type', 'text');
		pos2rem.setAttribute('name', POS2REM + iteration);
		pos2rem.setAttribute('size', '5');
		pos2rem.setAttribute('value', <%ifx_get_voip_sip_numplan(POS2REM + iteration);%>);
		cell6.appendChild(pos2rem);

		<%ifx_get_voip_sip_numplan("increment");%>
		
		// Pass in the elements you want to reference later
		// Store the myRow object in each row
		row.myRow = new myRowObject(sel, rule, prefix, min, max, remdgts, pos2rem);
	}
}

// CONFIG: this entire function is affected by myRowObject settings
// If there isn't a checkbox in your row, then this function can't be used.
function deleteChecked()
{
	if (hasLoaded) {
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
}

function reorderRows(tbl, startingIndex)
{
	if (hasLoaded) {
		if (tbl.tBodies[0].rows[startingIndex]) {
			var count = startingIndex + ROW_BASE;
			for (var i=startingIndex; i<tbl.tBodies[0].rows.length; i++) {
			
				// CONFIG: next line is affected by myRowObject settings
				tbl.tBodies[0].rows[i].myRow.two.name = RULE + count; // select

				// CONFIG: next line is affected by myRowObject settings
				tbl.tBodies[0].rows[i].myRow.three.name = PREFIX + count; // input text
				
				// CONFIG: next line is affected by myRowObject settings
				var tempVal3 = tbl.tBodies[0].rows[i].myRow.three.value.split(' '); // for debug purposes
				tbl.tBodies[0].rows[i].myRow.three.value = tempVal3[0]; // for debug purposes

				// CONFIG: next line is affected by myRowObject settings
				tbl.tBodies[0].rows[i].myRow.four.name = MIN + count; // input text
				
				// CONFIG: next line is affected by myRowObject settings
				var tempVal4 = tbl.tBodies[0].rows[i].myRow.four.value.split(' '); // for debug purposes
				tbl.tBodies[0].rows[i].myRow.four.value = tempVal4[0]; // for debug purposes
				
				// CONFIG: next line is affected by myRowObject settings
				tbl.tBodies[0].rows[i].myRow.five.name = MAX + count; // input text
				
				// CONFIG: next line is affected by myRowObject settings
				var tempVal5 = tbl.tBodies[0].rows[i].myRow.five.value.split(' '); // for debug purposes
				tbl.tBodies[0].rows[i].myRow.five.value = tempVal5[0]; // for debug purposes

				// CONFIG: next line is affected by myRowObject settings
				tbl.tBodies[0].rows[i].myRow.six.name = REMDGTS + count; // input text
				
				// CONFIG: next line is affected by myRowObject settings
				var tempVal6 = tbl.tBodies[0].rows[i].myRow.six.value.split(' '); // for debug purposes
				tbl.tBodies[0].rows[i].myRow.six.value = tempVal6[0]; // for debug purposes

				// CONFIG: next line is affected by myRowObject settings
				tbl.tBodies[0].rows[i].myRow.seven.name = POS2REM + count; // input text
				
				// CONFIG: next line is affected by myRowObject settings
				var tempVal7 = tbl.tBodies[0].rows[i].myRow.seven.value.split(' '); // for debug purposes
				tbl.tBodies[0].rows[i].myRow.seven.value = tempVal7[0]; // for debug purposes

				// CONFIG: requires class named classy0 and classy1
				tbl.tBodies[0].rows[i].className = 'classy' + (count % 2);
				
				count++;
			}
		}
	}
}

function deleteRows(rowObjArray)
{
	if (hasLoaded) {
		for (var i=0; i<rowObjArray.length; i++) {
			var rIndex = rowObjArray[i].sectionRowIndex;
			rowObjArray[i].parentNode.deleteRow(rIndex);
			<%ifx_get_voip_sip_numplan("decrement");%>;
		}
	}
}

function openInNewWindow(frm)
{
	// open a blank window
	var aWindow = window.open('', 'TableAddRowNewWindow',
	'scrollbars=yes,menubar=yes,resizable=yes,toolbar=no,width=400,height=400');
	
	// set the target to the blank window
	frm.target = 'TableAddRowNewWindow';
	
	// submit
	frm.submit();

	
}
