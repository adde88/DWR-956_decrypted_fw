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
var resText = "";
var delay = -1;
var timerId = null;
var statusMsgObj = null;
var count=120;
var counter;


function progressBarCall ()
{
	tblObj = document.getElementById ('tblProgress');
	tblObj.bgColor = "#76a8bf";
	if (ie)
	{
		nCells = (tblObj.cells).length;
	}
	else if (ns)
	{
		tdObjs = document.getElementsByName ('tblTdProgress');
		nCells = tdObjs.length;
	}
	autoRefreshProgressBar ();
}

function autoRefreshProgressBar ()
{
	if (timerId)
		clearTimeout(timerId)

	if (progressPercentage < 50) 
	{
		if(ie)
			tblObj.cells[progressPercentage].bgColor = progressBgColor;
		else if (ns)
			tdObjs[progressPercentage].bgColor = progressBgColor;
		progressPercentage++;
		if(document.getElementById('lblStatusMsgProgress'))
			document.getElementById('lblStatusMsgProgress').innerHTML = "<span class=\"spanText\"><b>Writing firmware</b></span>";
		timerId = setTimeout ("autoRefreshProgressBar ()", 1200);
	} 
	else 
	{
		if (timerId)
			clearTimeout(timerId)
		if(document.getElementById('fw_progress_reboot'))
		{
			document.getElementById('fw_progress_reboot').style.display = "block";
			document.getElementById('fw_progress').style.display = "none";
		}
		displayRebootMsg();
//		counter=setTimeout("", 1000);
	}
}
function displayRebootMsg()
{
	if(document.getElementById("lblStatusMsg"))
	{
		var chart = document.getElementById("lblStatusMsg");
		if(count<=1)
			chart.innerHTML = 'Router will be up in ' + count + ' Second';
		else
			chart.innerHTML = 'Router will be up in ' + count + ' Seconds';
		count=count-1;
		if (count <= 0)
		{
			clearTimeout(counter);
			window.location.href="../login.asp";	
			return;
		}
		counter=setTimeout("displayRebootMsg()", 1000);
	}
}

