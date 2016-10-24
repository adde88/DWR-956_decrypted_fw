var startTime;
var login_flag;
var idle_time;
var ADMIN_LOGIN = "0";
var GUEST_LOGIN = "2";
var INVALID_LOGIN = "1";
var ResetPage = "ResetPage";
var RedirectPage = "RedirectPage";

function doRedirect()
{
	if(CheckLoginInfo(ResetPage))
		window.location = document.location.href;
}	

function RedirectSubMenu(left_menu)
{
	if(CheckLoginInfo(RedirectPage))
		window.location = left_menu+'.asp';
}

function RedirectMainMenu(main_menu)
{
	if(CheckLoginInfo(RedirectPage))
		window.location = '../'+main_menu+'.asp';
}

Date.prototype.dateDiff = function(interval,objDate)
{
	var dtEnd = new Date(objDate);
	if(isNaN(dtEnd)) return undefined;
	switch (interval) 
	{
		case "s":
			return parseInt((dtEnd - this) / 1000);
		case "n":
			return parseInt((dtEnd - this) / 60000);
		case "h":
			return parseInt((dtEnd - this) / 3600000);
		case "d":
			return parseInt((dtEnd - this) / 86400000);
		case "w":
			return parseInt((dtEnd - this) / (86400000 * 7));
		case "m":
			return (dtEnd.getMonth()+1)+((dtEnd.getFullYear()-this.getFullYear())*12) - (this.getMonth()+1);
		case "y":
			return dtEnd.getFullYear() - this.getFullYear();
		default:
			break;
	}
}

function checkAdmin()
{
	if(login_flag == GUEST_LOGIN)
	{
		alert(gettext("Administrator privileges are required"));
		return false;
	}
	return true;
}

function CheckLoginInfo(state)
{
	var currentTime = new Date();
	//alert("diff="+startTime.dateDiff("s",currentTime)+"\n idle_time="+idle_time);
	
	if(startTime.dateDiff("s",currentTime) > idle_time*60)
	{
		alert(gettext("You have been logged out as a result of being inactive for ")+idle_time+gettext(" minutes.")+"\n"+
			gettext("Please login again then you can access the Web GUI."));
		window.location.href="../login.asp";
		return false;
	}
	startTime = new Date();
	if((state != ResetPage) && (state != RedirectPage))
		if(!checkAdmin())
			return false;
	return true;
}

function CheckInitLoginInfo(login_info)
{
	//startTime = new Date();
	var loginArr = login_info.split("#"); 
	login_flag = loginArr[0];
	idle_time = parseInt(loginArr[1],10);
	var original_time = new Date(loginArr[2]);
	var now_time = new Date(loginArr[3]);

	if((original_time.dateDiff("s",now_time) > idle_time*60) && (original_time.dateDiff("y",now_time)<2))
	{
		alert(gettext("You have been logged out as a result of being inactive for ")+idle_time+gettext(" minutes.")+"\n"+
			gettext("Please login again then you can access the Web GUI."));
		window.location.href="../login.asp";
		return false;
	}
	if(login_flag == INVALID_LOGIN)
	{
		window.location.href="../login.asp";
	}
}

function ResetIdleTime()
{
	startTime = new Date();
}

$(document).ready(function()
{
	startTime = new Date();
	//CheckLoginInfo();
});

