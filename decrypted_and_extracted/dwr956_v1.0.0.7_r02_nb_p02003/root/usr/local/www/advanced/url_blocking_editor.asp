<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="JavaScript" src="../js/textValidations.js" type="text/javascript"></script>
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>

<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
//<!--

CheckInitLoginInfo(<%getuser_login();%>);


var filter_rule = new Object();
var keyword_array=new Array();
var domain_array=new Array();

function drawOption(mySelect, optionText)
{
	var option=document.createElement("OPTION");
	var option_item=document.createTextNode(optionText);
	option.setAttribute("value",optionText);
	option.appendChild(option_item);
	mySelect.appendChild(option);
}

function checkFieldExist(optionList,fieldText,errMsg)
{
	for (var i=0; i<optionList.length; i++)
	{
		if (optionList[i].value==fieldText)
		{
			if (document.getElementById('statusMsg'))
				document.getElementById('statusMsg').innerHTML=errMsg;
			return true;
		}		
	}	
	return false;
}

function removeOption(mySelect)
{	
	var optionList=document.getElementById(mySelect);	
	var bSelect=false;
	if (optionList.getElementsByTagName("option").length==0)
	{
		var errMsg = (mySelect=="keywords") ? "Keywords" : "Domains";		
		errMsg="Available" + " " + errMsg + " " + "are blank";
		alert(errMsg);
		return false;			
	}

	for (var i=0; i<optionList.length; i++)
	{
		if (optionList[i].selected==true)
		{
			bSelect=true;
			optionList.removeChild(optionList[i]);			
		}		
	}
	if (!bSelect)
	{
		alert("Please select an item to delete.");
		return false;
	}
	
	return true;
}

function domainNameValidate()
{
	var txtFieldIdArr = new Array ();
	txtFieldIdArr[0] = "txtAdDomain,Please enter valid Domain Name";
	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;
	if (checkASCIICharField('txtAdDomain', "Add a Domain") == false)
		return false;
	if (fieldLengthCheck ('txtAdDomain', 1, 128, 'Maximum Character Limit is 128 Characters') == false)
		return false;
	var optionList=document.getElementById('domains');
	var domain=document.getElementById('txtAdDomain').value;
	if (checkFieldExist(optionList,domain,"Domain with the same name already exists"))
		return false;	
	drawOption(optionList,domain);	
	return true;
}

function keywordValidate()
{
	var txtFieldIdArr = new Array ();
	txtFieldIdArr[0] = "txtNewKeyword,Please enter valid Keyword";
	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;
	if (checkASCIICharField('txtNewKeyword', "Add a Keyword") == false)
		return false;
	if (fieldLengthCheck ('txtNewKeyword', 1, 128, 'Maximum Character Limit is 128 Characters') == false)
		return false;

	var optionList=document.getElementById('keywords');
	var keyword=document.getElementById('txtNewKeyword').value;
	if (checkFieldExist(optionList,keyword,"Keyword with the same name already exists"))
		return false;
	
	drawOption(optionList,keyword);
	return true;
}
function pageValidate ()
{
	if(!CheckLoginInfo())
		return false;
	var txtFieldIdArr = new Array ();
	txtFieldIdArr[0] = "txtcntFiltr,Please enter valid Name";
	if (txtFieldArrayCheck (txtFieldIdArr) == false)
		return false;
	
	if (checkCommonNameField('txtcntFiltr', "Filter Name") == false) 
	{
		return false;
	}
	var keywordArr = document.getElementById('keywords').getElementsByTagName("option");
	var domainArr = document.getElementById('domains').getElementsByTagName("option");
	if (keywordArr.length ==0 && domainArr.length == 0)
	{
		alert("Available Keywords and Available Domains are blank");
		return false;
	}
	for (var i=0; i < keywordArr.length; i++)
	{
		keyword_array[i]=keywordArr[i].value;
	}	
	for (var i=0; i < domainArr.length; i++)
	{
		domain_array[i]=domainArr[i].value;
	}
	
	document.getElementById('FltrRuleKeywords').value=keyword_array;
	document.getElementById('FltrRuleDomains').value=domain_array;
	document.getElementById('FltrRuleKeywordsCount').value=keyword_array.length;
	document.getElementById('FltrRuleDomainsCount').value=domain_array.length;		
	return true;
}

function pageLoad()
{
	<%getFltrRule();%>;
}
// -->
</script> 

</head>	

<body onload="pageLoad();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftSubMenuChange("firewall_submenu","firewall_submenu_focus","url_blocking","url_blocking_href");</script>
<!-- Main Menu and Submenu End -->

<div class="contentBg">
	<div class="secH1">URL&nbsp;Blocking</div>
	<!-- Section Begin -->
	<div class="secBg">		
		<div class="statusMsg" id="statusMsg"><!--Add Filter Name to add a keyword/domain.--></div>		
		
		<div class="secInfo">
			<br>The filter will look for defined keywords within the configured Internet domain.  The domain can be accessed by local network computers based on whether the defined keywords are detected and the Default Policy setting of this filter.
			<br>
			<a class="secLable1" href="url_blocking.asp">>> Back to URL Blocking page</a>        						
		</div>
		<form name="frmUrlConfig" method="post" action="/goform/setFltrRule">
		<input type="hidden" name="FltrRuleKeywords" id="FltrRuleKeywords" value="">
		<input type="hidden" name="FltrRuleDomains" id="FltrRuleDomains" value="">
		<input type="hidden" name="FltrRuleKeywordsCount" id="FltrRuleKeywordsCount" value="">
		<input type="hidden" name="FltrRuleDomainsCount" id="FltrRuleDomainsCount" value="">		
        
        <table cellspacing="0" class="configTbl">
			<tr>
				<td>Filter Name</td>				
				<td>
					<span id="cntFiltr" name="cntFiltr"></span>			
					<input id="txtcntFiltr" class="configF1" type="text" onkeydown="if (event.keyCode == 9) {return fieldLengthCheck ('txtcntFiltr', 0, 65, 'Please enter between 0 to 65 characters');}" maxlength="64" size="20" value="" name="name">					
				</td>				
			</tr>
			<tr>
				<td>Filter Policy</td>
				<td>
					<select size="1" name="type" class="configF1">
						<option value="ACCEPT">Only Block Listed Sites</option>
						<option value="DROP">Only Allow Listed Sites</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Available Keywords</td>
				<td>
					<select size="5" name="keywords" id="keywords" class="configF1 w200">
					</select>
                </td>
                
				<td class="secLable1" width="35%">
					<input type="button" value="Delete" class="tblbtn" title="Delete" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return removeOption('keywords');">
				</td>
			</tr>
			<tr>
				<td>Add a Keyword</td>
				<td>
					<input type="text" name="keywordValue" size="20" maxlength="128" class="configF1" id="txtNewKeyword" onkeydown="if (event.keyCode == 9) {return fieldLengthCheck ('txtNewKeyword', 1, 128, 'Maximum Character Limit is 128 Characters');}" />
				</td>
				<td class="secLable1" width="35%">
					<input type="button" value="Add" class="tblbtn" title="Add" onclick="return keywordValidate()" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">
				</td>
			</tr>
			<tr>
				<td>Available Domains</td>
				<td>
					<select size="5" name="domains" id="domains" class="configF1 w200">									
					</select>
                </td>
                
				<td>
					<input type="button" value="Delete"  class="tblbtn" align="center" title="Delete" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return removeOption('domains');">
				</td>
			</tr>
			<tr>
				<td>Add a Domain</td>
				<td><input type="text" name="domainName" size="20" maxlength="128" class="configF1" id="txtAdDomain" onkeypress="return alphaNumericCheck (event)|| numericValueCheck(event,'.-');" onkeydown="if (event.keyCode == 9) {return fieldLengthCheck ('txtAdDomain', 1, 128, 'Maximum Character Limit is 128 Characters');}" /></td>
				<td>
					<input type="button" value="Add" class="tblbtn" align="center" title="Add" onclick="return domainNameValidate();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'">
				</td>
			</tr>
		</table>
		<div class="submitBg">
			<input type="submit" value="Apply" class="submit" title="Apply" name="button.config.ContentFltr.urlBlocking.1" onclick="return pageValidate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
			<input type="button" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'">
		</div>
		</form>							

	</div>
	<!-- Section End -->
</div>

</div> <!-- End of all -->
</body>
</html>
