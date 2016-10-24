<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="JavaScript" src="../js/textValidations.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/ipv4AddrValidations.js" type="text/javascript"></script>
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="../js/j_common.js"></script>

<script language="javascript" type="text/javascript">
CheckInitLoginInfo(<%getuser_login();%>);
var QosEditInfo=<%getQosEditInfo();%>;
var QosEditArr = QosEditInfo.split("#");
var AppsName = <%getSpecialAppsName();%>;
var appsNameArr = AppsName.split("#");
var length = appsNameArr.length;
var ServiceName = <%getServiceName();%>;
var serviceNameArr = ServiceName.split("#");
var ServiceTraffic = <%getServiceTraffic();%>;
var serviceTrafficArr = ServiceTraffic.split("#");
var ServiceContent = <%getServiceContent();%>;
var serviceContentArr = ServiceContent.split("#");
var row = 0;
var count = 0;
var id = 0;
function qos_edit_init()
{
	if (QosEditInfo == ""){  //Add
		document.getElementById('qosAvailableProfile').selectedIndex = 0;
		document.getElementById('qosService').selectedIndex = 0;
		document.getElementById('qosTraffic').selectedIndex=0;
		document.getElementById('qosIP').value = "";
		document.getElementById('qosDSCP').value = "";
       	fieldStateChangeWr ('qosDSCP','','qosIP','');
	}else{					//Edit
    	var profileOption = parseInt(QosEditArr[0], 10)-1;
    	document.getElementById('qosAvailableProfile').selectedIndex = profileOption;
    
    	for(row = 0; row < length; row += 1){
      	  if (appsNameArr[row] == QosEditArr[1]){
    	    document.getElementById('qosService').selectedIndex=row;
      	  }  
      	}
    	
    	if(QosEditArr[2]=="IP"){
        	document.getElementById('qosTraffic').selectedIndex=0;
    		fieldStateChangeWr ('qosDSCP','','qosIP','');
    		document.getElementById('qosIP').value=QosEditArr[3];
    	}else if(QosEditArr[2]=="DSCP"){
        	document.getElementById('qosTraffic').selectedIndex=1;
    		fieldStateChangeWr ('qosIP','','qosDSCP','');
    		document.getElementById('qosDSCP').value=QosEditArr[3];
    	}
	}
}

function AddNewServerApply()
{
	if(!CheckLoginInfo())
		return false;
	document.getElementById('editflag').value="addService";
	return true;
}

function optionCheck()
{
	var selValue = comboSelectedValueGet('qosTraffic');
	if (!selValue) return;
	switch (selValue)
	{
      case "IP":	/* Service / IP */
      	fieldStateChangeWr ('qosDSCP','','qosIP','');
      	break;
      case "DSCP": /*DSCP Value */
      	fieldStateChangeWr ('qosIP','','qosDSCP','');
      	break;
	}
}

function qos_edit_validate()
{
	if(!CheckLoginInfo())
		return false;
	var txtFieldIdArr = new Array ();
    txtFieldIdArr[0] = "selProfile,Please add profile first..";
    txtFieldIdArr[1] = "txtIpAddr,Please enter a valid IP Address";
    txtFieldIdArr[2] = "txtMacAddr,Please enter a valid MAC address";
	var traffic=document.getElementById('qosTraffic');

    if (txtFieldArrayCheck (txtFieldIdArr) == false){
	  	return false;
    }
	
	if (ipv4Validate ('qosIP', 'IP', false, true,"Invalid IP Address.", "for octet ", true) == false){
      	return false;
	}  

	var dscpObj = document.getElementById('qosDSCP');
	if (!dscpObj.disabled){
		if(numericValueRangeCheck (dscpObj, "", "DSCP", 0, 63, true, "Invalid DSCP value:", "") == false){
			return false;
		}	
	}

if (QosEditInfo == ""){  //Add	
	for (var i=0; i < serviceNameArr.length; i++)
    {
      var name = document.getElementById('qosService').value;
	  var type = document.getElementById('qosTraffic').value;
	  var content = "";
	  if(type == "IP"){
		content = document.getElementById('qosIP').value;
      }else if(type == "DSCP"){
      	if (document.getElementById('qosDSCP').value == ""){
		  alert(gettext("Invalid DSCP value: Please enter a value between 0-63."));
		  return false;	
      	}else{	
		  content = document.getElementById('qosDSCP').value;
      	}  
      }
	  if (serviceNameArr[i]==name){  					 //Service
	  	if (serviceTrafficArr[i]==type){    			 //Type
			if(serviceContentArr[i]==content){			 //Content
			  count++;
			}
	  	}
      }
    }
}else{
	id = parseInt(QosEditArr[4], 10)-1;
	for (var i=0; i < serviceNameArr.length; i++)
    {
      var name = document.getElementById('qosService').value;
	  var type = document.getElementById('qosTraffic').value;
	  var content = "";
	  if(type == "IP"){
		content = document.getElementById('qosIP').value;
      }else if(type == "DSCP"){
		if (document.getElementById('qosDSCP').value == ""){
		  alert(gettext("Invalid DSCP value: Please enter a value between 0-63."));			
		  return false;	
      	}else{	
		  content = document.getElementById('qosDSCP').value;
      	}  
      }
	  if (serviceNameArr[i]==name){  					 //Service
	  	if (serviceTrafficArr[i]==type){    			 //Type
			if(serviceContentArr[i]==content){			 //Content
			  if (id == i){
			  	count=0;
			  }else{	
			    count++;
			  }	
			}
	  	}
      }
	}
}	

  	if (count > 0){
  	  alert("The Service is duplicate.");
	  //document.getElementById("qosService").focus();
	  window.location.href="QoSPolicy.asp";
	  return false;
  	}
	
	document.getElementById('editflag').value="apply";
	return true;
}

</script>
</head>

<body onload="qos_edit_init()">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("adv");%>
<script type="text/javascript">menuChange("adv_menu");leftMenuChange("QoSPolicy", "QoSPolicy_href");</script>
<!-- Main Menu and Submenu End -->

<!-- Right Content start -->
<div class="contentBg">
  <div class="secH1"><script>document.write(gettext("Bandwidth Profile Configuration"));</script></div>
  <div class="secBg">  
  <div class="secInfo"></div>
  <div class="secH2"><script>document.write(gettext("Traffic Selector Configuration"));</script></div>
  <form method="post" action="/goform/setQosEdit">
  <input type="hidden" name="editflag" id="editflag" value="edit">
  <div style="display:block;" id="qos_add" name="qos_add" style="margin:10px 0 0 15px;">
    <div class="statusMsg"></div>
    <table class="configTbl" cellspacing="0">
      <tr>
	    <td><script>document.write(gettext("Available Profiles"));</script></td>
		<td><select size="1" name="qosAvailableProfile" id="qosAvailableProfile" class="configF1">
		  <option value=1><script>document.write(gettext("Urgent"));</script></option>
		  <option value=2><script>document.write(gettext("High"));</script></option>
		  <option value=3><script>document.write(gettext("Medium"));</script></option>
		  <option value=4><script>document.write(gettext("Low"));</script></option>
		  </select>
		</td>
 	  </tr>
 	  <tr>
		<td><script>document.write(gettext("Service"));</script></td>
		<td><select size="1" name="qosService" id="qosService" class="configF1">
		<%getQosServiceOptions();%>
 	    </select></td>
		<td><input type="submit" class="tblbtn" value="Add Application" name="button.add.qosProfileConfig" id="AddNewServce" title="Add Application" onclick="return AddNewServerApply();" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'"></td>
  	  </tr>
  	  <tr>
		<td><script>document.write(gettext("Traffic Selector Match Type"));</script></td>
		<td><select size="1" name="qosTraffic" class="configF1" id="qosTraffic" onchange="optionCheck();">
		  <option value="IP">IP</option>
		  <option value="DSCP">DSCP</option>
		</select></td>
	  </tr>
	  <tr>
		<td><script>document.write(gettext("IP Address"));</script></td>
		<td><input type="text" name="qosIP" value="" size="20" class="configF1" id="qosIP" onkeypress="return numericValueCheck (event, '.')" onkeydown="if (event.keyCode == 9) { return ipv4AddrValidate (this, 'IP', false, true, 'Invalid IP Address.', 'for octet ', true); }"></td>
	  </tr>
	  <tr>
		<td><script>document.write(gettext("DSCP Value"));</script></td>
		<td><input type="text" name="qosDSCP" value="" size="20" class="configF1" id="qosDSCP" onkeypress="return numericValueCheck (event)" onkeydown="if (event.keyCode == 9) {return numericValueRangeCheck (this, '', '', 1, 4096, true, 'Invalid DSCP value:', '');}"></td>
	  </tr>
    </table>      
    <div>
      <td><input type="submit" id="qos_edit_apply" value="Apply" class="submit" title="Apply" onclick="return qos_edit_validate();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>
	  <td><input type="button" id="qos_edit_reset" value="Reset" class="submit" title="Reset" onclick="doRedirect();" onmouseover="this.className = 'submitHover'" onmouseout="this.className = 'submit'"></td>
	</div>
  </div>
  </form>
</div>
</div>
</div>
<script type="text/javascript">
  document.getElementById('AddNewServce').value=gettext("Add Application");
  document.getElementById('qos_edit_apply').value=gettext("Apply");
  document.getElementById('qos_edit_reset').value=gettext("Reset");
</script>
</body>
</html>
