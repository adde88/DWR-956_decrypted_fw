/* progressBar.js - API library for progress bar management functions */

/*
* Copyright (c) 2010 TeamF1, Inc.
* All rights reserved.
*/

/*
modification history
------------------------
*/

var ie = (navigator.appName.indexOf ('Microsoft') != -1);
var ns = (navigator.appName.indexOf ('Netscape') != -1);
var nCells = 0;
var cellIdx = 0;
var tblObj = null;
var tdObjs = null;
var probableImageUploadTime = 1;
var delay = 0;
var upgradeStarted = false;
var progressBgColor = "#00529B";
var progressPercentage = 0;
var timerId = null;
var resText = "" ;
var progressInterval = 1000;
var progressAt = 0;
var count=0;
var counter;
var temp_count=0;
var message_counter=0;
function createAjax() 
{
    var xmlHttp = null;
    if (typeof XMLHttpRequest != "undefined") 
	{
        xmlHttp = new XMLHttpRequest();
    } 
	else if (window.ActiveXObject) 
	{
        var aVersions = ["Msxml2.XMLHttp.5.0", "Msxml2.XMLHttp.4.0", "Msxml2.XMLHttp.3.0", "Msxml2.XMLHttp", "Microsoft.XMLHttp"];
        for (var i = 0; i < aVersions.length; i++) 
		{
            try 
			{
                xmlHttp = new ActiveXObject(aVersions[i]);
                break;
            } 
			catch (e) 
			{}
        }
    }
    return xmlHttp;
}
function upgradeLteProgressShow (animationDelay)
{
 var i18n_yourBrowserNotSuppAjax = "Your browser does not support AJAX!";
 var i18n_resettingModelAlert= "Resetting 4G module. Do not power off!!";
 var i18n_moduleUpgrade = "4G Module Firmware Upgrade";

 if (timerId)
   clearTimeout(timerId);

 var request = null;
 if (typeof XMLHttpRequest != "undefined") {
   request = new XMLHttpRequest();
 } else if (window.ActiveXObject) {
   var aVersions = ["Msxml2.XMLHttp.5.0", "Msxml2.XMLHttp.4.0", "Msxml2.XMLHttp.3.0", "Msxml2.XMLHttp", "Microsoft.XMLHttp"];
   for (var i = 0; i < aVersions.length; i++) {
     try {
       request = new ActiveXObject(aVersions[i]);
       break;
     } catch (e) {
       window.status = i18n_yourBrowserNotSuppAjax;
       return false;
     }
   }
 }

	document.getElementById('lblStatusMsgLte').innerHTML = "<span class=\"spanText\"><b>" + i18n_moduleUpgrade + "</b></span>";

	if (progressAt == 50)
	{
		alert(i18n_resettingModelAlert);
		document.getElementById('upgrade_module').style.display="none";
		document.getElementById('module_upgrage_status').style.display="block";
		timerId=setTimeout(function () {autoRefresh_progress()},5000);

   		return;
	}

 if(ie)
  tblObj.cells[progressAt].bgColor = progressBgColor;
 else if (ns)
  tdObjs[progressAt].bgColor = progressBgColor;

	progressAt++;

	timerId = setTimeout ("upgradeLteProgressShow ()", 100);
}

//function
function lteProgressBarCall ()
{
	tblObj = document.getElementById ('tblProgressLte');
 tblObj.bgColor = "#76a8bf";
	if (ie)
	{
		nCells = (tblObj.cells).length;
	}
	else if (ns)
	{
		tdObjs = document.getElementsByName ('tblTdProgressLte');
		nCells = tdObjs.length;
	}

	upgradeLteProgressShow ();
}

function get_lte_daemon_status()
{
	temp_count++;
	var ajax = createAjax();
  	ajax.open('GET', "get_LTE_daemon_status.asp?time="+ new Date(), true);
  	ajax.send(null);
  	ajax.onreadystatechange = function ()
	{
    	if (ajax.readyState == 4)
		{
      		if (ajax.status == 200) 
			{
				var result = ajax.responseText;
				var Arr = result.split('"');
				var daemon_status=parseInt(Arr[1]);
				if(daemon_status>0)
				{
					clearTimeout(message_counter);
					clearTimeout(counter);
					window.location.href="system_fw_upgrade.asp";
				}
        	}
    	}
  	}
	counter = setTimeout(function () {get_lte_daemon_status()},10000);
	/*if(temp_count==5)
	{
		clearTimeout(counter);
		window.location.href="system_fw_upgrade.asp";
	}*/
}


function displayRebootMsg()
{
	//window.location.href="system_fw_upgrade.asp";
	document.getElementById('upgrade_module').style.display="none";
	document.getElementById('module_upgrage_status').style.display="none";
	document.getElementById('module_reboot').style.display="block";
	if(temp_count==0)
	{
		temp_count++;
		counter = setTimeout(function () {get_lte_daemon_status()},20000);
	}
	if(document.getElementById("lblStatusMsg"))
	{
		var chart = document.getElementById("lblStatusMsg");
		if(count%3==0)
			chart.innerHTML = 'Please wait...  ';
		else if(count%3==1)
			chart.innerHTML = 'Please wait.... ';
		else 
			chart.innerHTML = 'Please wait.....';
		count++;
		message_counter=setTimeout("displayRebootMsg()", 2000);
	}
}

function autoRefresh_progress()
{
  var ajax = createAjax();
  ajax.open('GET', "getFwMDMpercent.asp?time="+ new Date(), true);
  ajax.send(null);
  ajax.onreadystatechange = function (){
    if (ajax.readyState == 4){
      if (ajax.status == 200) {

		 var result = ajax.responseText;
        document.getElementById('mdm_progressing').innerHTML = "Progressing: " + result;
        if(timerId)
			clearTimeout(timerId);
		if (result < 101)
		{          
          if (result == 100)
		  {
	        document.getElementById('mdm_message').innerHTML="4G module upgrade complete";
			alert("4G module upgrade complete.");
			timerId=setTimeout(function () {displayRebootMsg()}, 2000);
          } 
		  else if(result == 0)
		  {
		  	document.getElementById('mdm_message').innerHTML="Starting upgrade 4G module firmware";
		    timerId=setTimeout(function () {autoRefresh_progress()}, 5000);
		  }
		  else 
		  {
		  	document.getElementById('mdm_message').innerHTML="Writing 4G module firmware";
            timerId=setTimeout(function () {autoRefresh_progress()}, 5000);
          }  
        }
        else
		{
          if (result == 201)
		  {
            document.getElementById("mdm_message").innerHTML="Error: Unknown product ID. Please contact your service provider."; 
          }
		  else if (result == 202)
		  {
            document.getElementById("mdm_message").innerHTML="Error: Download failed.";
            
          }
		  else if (result == 203)
		  {
            document.getElementById("mdm_message").innerHTML="Error: Unknown upgrade failed. Please contact your service provider.";
          }
		  else if (result == 105)
		  {
		  	document.getElementById("mdm_message").innerHTML="Error: Cannot open upgrade file. Please try again or contact your service provider.";
		  }
        }
      }
    }
  }
}