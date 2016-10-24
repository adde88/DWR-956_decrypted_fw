var branch = "dora";

var new_sms_send_list = new Object();
var sms_inbox_list = new Object();
var sms_outbox_list = new Object();
var sim_sms_list = new Object();
var sms_draft_list = new Object();
var new_sms_draft_list = new Object();

var temp_inbox_index;
var temp_outbox_index;
var temp_inbox_index;
var temp_sim_sms_index;
var temp_draft_index;

var sim_sms_new_incoming;
var sim_sms_ready=false;
var sim_sms_ready_count=0;
var sms_send_status;
var disable_sms_menu=false;
var temp_draft_count=0;
var temp_outbox_count=0;

var sim_status="not inserted";
var pin1_status="not initialized";

function isDebugMode()
{	
   return false;
}

function doRedirect()
{
    window.location = document.location.href;
}

function redirectToPage(url)
{
	window.location = url;
}

function textarea_maxlen_isMax( text )
{
	var textarea = document.getElementById(text);
	var max_length = textarea.maxLength;
	if(textarea.value.length > max_length)
	{
  		textarea.value = textarea.value.substring(0, max_length);
	}	
}

function textarea_maxlen_disabledRightMouse ()
{
	document.oncontextmenu = function ()
	{
		return false; 
	}	
}

function textarea_maxlen_enabledRightMouse()
{
	document.oncontextmenu = null;
}

function checkMaxLength(description_val, max_val)
{
	if(document.getElementById(description_val).value.length > max_val)
	{
		document.getElementById(description_val).value = document.getElementById(description_val).value.substr(0, max_val);
		return false;
	}
	return true;
}

function RedirectToInbox()
{
	if (branch=="dora")
		window.location = "../advanced/sms_inbox.asp";
	else
		window.location = "../applications/sms_inbox.asp";
}

function RedirectToOutbox()
{
	if (branch=="dora")
		window.location = "../advanced/sms_outbox.asp";
	else
		window.location = "../applications/sms_outbox.asp";
}

function RedirectToSIMSMS()
{
	if (branch=="dora")
		window.location = "../advanced/sms_simsms.asp";
	else
		window.location = "../applications/sms_simsms.asp";
}

function RedirectToDraft()
{
	if (branch=="dora")
		window.location = "../advanced/sms_draft.asp";
	else
		window.location = "../applications/sms_draft.asp";
}

function application_inbox_popup(index)
{
	var mask = document.getElementById('application_short_inbox_mask');
	var popup = document.getElementById('application_short_inbox_popup_add');
	mask.style.display = "block";
	popup.style.display = "block";
	$(function(){LoadSMSInfo('get_sms_inbox_records', true, sms_inbox_list[index].idx, sms_inbox_list[index].idx);})
	temp_inbox_index = index;
}

function application_inbox_popup_close()
{
	var mask = document.getElementById('application_short_inbox_mask');
	var popup = document.getElementById('application_short_inbox_popup_add');
	mask.style.display = "none";
	popup.style.display = "none";
	RedirectToInbox();
}

function inbox_popup_one(inbox_info, index)
{
	if(typeof(inbox_info.errno) != "undefined" && inbox_info.errno != 0)
	{
		alert(inbox_info.errmsg);
	}
	else
	{
	 	if (inbox_info.records.length > 0) 
		{
	 		for (var i = 0; i < inbox_info.records.length; i++)
	 		{	
				if(inbox_info.records[i].name == "")
				{
					$("#inbox_received_from").text(inbox_info.records[i].number);
				}
				else
				{
					$("#inbox_received_from").text(inbox_info.records[i].name);
				}
				$("#inbox_received_time").text(inbox_info.records[i].time);
				$("#inbox_received_content").val(inbox_info.records[i].content);
				
				if(inbox_info.records[i].new_sms)
				{
					SendSMSData
					({
						"action":"set_sms_inbox_read", 
						"args":
						{
							"idx":inbox_info.records[i].idx
					    }
					}, null);
				}
	 		}
		}
	}
}

function application_outbox_popup(index)
{
	var mask = document.getElementById('application_short_outbox_mask');
	var popup = document.getElementById('application_short_outbox_popup_add');
	mask.style.display = "block";
	popup.style.display = "block";
	$(function(){LoadSMSInfo('get_sms_outbox_records', true, sms_outbox_list[index].idx, sms_outbox_list[index].idx);})	
	temp_outbox_index = index;
}

function application_outbox_popup_close()
{
	var mask = document.getElementById('application_short_outbox_mask');
	var popup = document.getElementById('application_short_outbox_popup_add');
	mask.style.display = "none";
	popup.style.display = "none";
	RedirectToOutbox();
}

function outbox_popup_one(outbox_info, index)
{
	if(typeof(outbox_info.errno) != "undefined" && outbox_info.errno != 0)
	{
		alert(outbox_info.errmsg);
	}
	else
	{
	 	if (outbox_info.records.length > 0) 
		{
	 		for (var i = 0; i < outbox_info.records.length; i++)
	 		{
	 			var temp_outbox_name = ""; //display detail
	 			for(var j=0;j<outbox_info.records[i].sendto.length;j++)
				{
					
					if(outbox_info.records[i].sendto[j].name != "")
						temp_outbox_name = temp_outbox_name + outbox_info.records[i].sendto[j].name + "; ";
					else
						temp_outbox_name = temp_outbox_name + outbox_info.records[i].sendto[j].number + "; ";
				}
	 			$("#outbox_sent_to").text(temp_outbox_name);
				$("#outbox_sent_time").text(outbox_info.records[i].time);
				$("#outbox_sent_content").text(outbox_info.records[i].content);
				temp_outbox_name = null;
	 		}
	 	}
	}
}

function application_sms_popup(index)
{
	var mask = document.getElementById('application_short_sms_mask');
	var popup = document.getElementById('application_short_sms_popup_add');
	mask.style.display = "block";
	popup.style.display = "block";
	$(function(){LoadSMSInfo('get_sms_sim_records', true, sim_sms_list[index].idx, sim_sms_list[index].idx);})
	temp_sim_sms_index = index;
}

function application_sms_popup_close()
{
	var mask = document.getElementById('application_short_sms_mask');
	var popup = document.getElementById('application_short_sms_popup_add');
	mask.style.display = "none";
	popup.style.display = "none";
	RedirectToSIMSMS();
}

function sim_sms_popup_one(sms_info, index)
{
	if(typeof(sms_info.errno) != "undefined" && sms_info.errno != 0)
	{
		$().toastmessage('showNoticeToast', gettext(sms_info.errmsg));		
	}
	else
	{
	 	if (sms_info.records.length > 0) 
		{
	 		for (var i = 0; i < sms_info.records.length; i++)
	 		{		
				if (sms_info.records[i].idx==index)
	 			{
					if (typeof(sms_info.records[i].sms_sent)!="undefined" &&
						sms_info.records[i].sms_sent)
					{	//outbox
						$("#sim_sms_from_txt").text(gettext("sent to"));
						$("#sim_sms_time_txt").text(gettext("sent time"));				
					}	 			
					else 
					{	//inbox
						$("#sim_sms_from_txt").text(gettext("from"));
						$("#sim_sms_time_txt").text(gettext("received time"));													
					}
						
					$("#sim_sms_from").text(sms_info.records[i].number);
					$("#sim_sms_time").text(sms_info.records[i].time);
					$("#sim_sms_content").text(sms_info.records[i].content);				
 				}
				
				if(sms_info.records[i].new_sms)
				{
					SendSMSData
					({
						"action":"set_sms_sim_read", 
						"args":
						{
							"idx":sms_info.records[i].idx
					    }
					}, null);
				}
	 		}
	 	}
	}	
}

function application_draft_popup(index)
{
	var mask = document.getElementById('application_short_draft_mask');
	var popup = document.getElementById('application_short_draft_popup_add');
	mask.style.display = "block";
	popup.style.display = "block";
	$(function(){LoadSMSInfo('get_sms_draft_records', true, sms_draft_list[index].idx, sms_draft_list[index].idx);})
	temp_draft_index = index;
}

function application_draft_popup_close()
{
	var mask = document.getElementById('application_short_draft_mask');
	var popup = document.getElementById('application_short_draft_popup_add');
	mask.style.display = "none";
	popup.style.display = "none";
	RedirectToDraft();
}

function draft_popup_one(draft_info, index)
{
	if(typeof(draft_info.errno) != "undefined" && draft_info.errno != 0)
	{
		alert(draft_info.errmsg);
	}
	else
	{
	 	if (draft_info.records.length > 0) 
		{
	 		for (var i = 0; i < draft_info.records.length; i++)
	 		{
	 			var temp_draft_name = ""; //display detail
	 			for(var j=0;j<draft_info.records[i].sendto.length;j++)
				{

					if ((draft_info.records[i].sendto[j].number).indexOf(";")!=-1) 
					{
						temp_draft_name = temp_draft_name + draft_info.records[i].sendto[j].number;
					}
					else
					{
						temp_draft_name = temp_draft_name + draft_info.records[i].sendto[j].number + "; ";					
					}
				}
				
				if (draft_info.records[i].idx==index)
	 			{
		 			$("#draft_sent_to").text(temp_draft_name);
					$("#draft_sent_content").text(draft_info.records[i].content);						
				}
				temp_draft_name = null;
	 		}				
		}
	}
}

function draft_send_record(draft_info, index)
{	
	if(typeof(draft_info.errno) != "undefined" && draft_info.errno != 0)
	{
		alert(draft_info.errmsg);
	}
	else
	{
	 	if (draft_info.records.length > 0) 
		{
	 		for (var i = 0; i < draft_info.records.length; i++)
	 		{				
				if (draft_info.records[i].idx==index)
	 			{
					SendSMSData
					({
						"action":"set_sms_draft_deleted", 
						"args":
						{
							"idx":index
					    }
					}, null);

					SendSMSData
					({
						"action":"set_sms_send", 
						"args":
						{
							"sendto" : draft_info.records[i].sendto,
							"content" : draft_info.records[i].content
					    }
					}, null);								
				}				
	 		}									
		}
	}
}

function application_draft_edit_popup(index)
{
	var mask = document.getElementById('application_short_draft_mask');
	var popup = document.getElementById('application_short_draft_popup_edit');
	mask.style.display = "block";
	popup.style.display = "block";
	
	$(function(){LoadSMSInfo('get_sms_draft_records', true, sms_draft_list[index].idx, sms_draft_list[index].idx, true);})
	temp_draft_index = index;	
}

function application_draft_edit_popup_close()
{
	var mask = document.getElementById('application_short_draft_mask');
	var popup = document.getElementById('application_short_draft_popup_edit');
	mask.style.display = "none";
	popup.style.display = "none";
	RedirectToDraft();
}

function draft_edit_popup_one(draft_info, index)
{
	if(typeof(draft_info.errno) != "undefined" && draft_info.errno != 0)
	{
		alert(draft_info.errmsg);
	}
	else
	{
	 	if (draft_info.records.length > 0) 
		{
	 		for (var i = 0; i < draft_info.records.length; i++)
	 		{
	 			var temp_draft_name = ""; //display detail
	 			for(var j=0;j<draft_info.records[i].sendto.length;j++)
				{
					if ((draft_info.records[i].sendto[j].number).indexOf(";")!=-1) 
					{
						temp_draft_name = temp_draft_name + draft_info.records[i].sendto[j].number;
					}
					else
					{
						temp_draft_name = temp_draft_name + draft_info.records[i].sendto[j].number + "; ";					
					}					
				}
				
				if (draft_info.records[i].idx==index)
	 			{
		 			$("#sms_draft_edit_to").val(temp_draft_name);
					$("#sms_draft_edit_content").text(draft_info.records[i].content);
				}
				temp_draft_name = null;
	 		}				
		}
	}
}

function sms_inbox_delete()
{
	var id = this.id;
	var arr = id.split("__");
	var idx = parseInt(arr[arr.length-1]);
	var confirm_delete;
	confirm_delete = window.confirm(gettext("Are you sure you want to delete this message?"));
	if(confirm_delete)
	{
		SendSMSData
		({
			"action":"set_sms_inbox_deleted", 
			"args":
			{
				"idx":sms_inbox_list[idx].idx
		    }
		}, doRedirect);
	}
	confirm_delete = null;
}

function sms_outbox_delete()
{
	var id = this.id;
	var arr = id.split("__");
	var idx = parseInt(arr[arr.length-1]);
	var confirm_delete;
	confirm_delete = window.confirm(gettext("Are you sure you want to delete this message?"));
	if(confirm_delete)
	{
		SendSMSData
		({
			"action":"set_sms_outbox_deleted", 
			"args":
			{
				"idx":sms_outbox_list[idx].idx
		    }
		}, doRedirect);
	}
	confirm_delete = null;
}

function short_sim_sms_delete()
{
	var id = this.id;
	var arr = id.split("__");
	var idx = parseInt(arr[arr.length-1]);
	var confirm_delete;
	confirm_delete = window.confirm(gettext("Are you sure you want to delete this message?"));
	if(confirm_delete)
	{
		SendSMSData
		({
			"action":"set_sms_sim_deleted", 
			"args":
			{
				"idx":sim_sms_list[idx].idx
		    }
		}, doRedirect);
	}
	confirm_delete = null;
}

function sms_draft_edit()
{
	var id = this.id;
	var arr = id.split("__");
	var idx = parseInt(arr[arr.length-1]);
	application_draft_edit_popup(idx);
}

function sms_draft_delete()
{
	var id = this.id;
	var arr = id.split("__");
	var idx = parseInt(arr[arr.length-1]);
	var confirm_delete;
	confirm_delete = window.confirm(gettext("Are you sure you want to delete this message?"));
	if(confirm_delete)
	{
		SendSMSData
		({
			"action":"set_sms_draft_deleted", 
			"args":
			{
				"idx":sms_draft_list[idx].idx
		    }
		}, doRedirect);
	}
	confirm_delete = null;
}

function sms_draft_send()
{
	if (!check_pin_status())
	{
		alert(gettext("SIM card error or SIM card is not inserted."));
		return false;	
	}
	if(temp_outbox_count >= 250)
	{
		alert(gettext("There are already 250 Outbox."));
		return false;
	}			
	if(sms_send_status == "sending")
	{
		alert(gettext("There is already a sending message."));								
		return false;
	}	
			
	var id = this.id;
	var arr = id.split("__");
	var index = parseInt(arr[arr.length-1]);

	// get full content before sending the draft
	$(function(){LoadSMSInfo('get_sms_draft_records', true, sms_draft_list[index].idx, sms_draft_list[index].idx, false, true);})		
}

function drawSMSInboxList(table, new_msg, name, number, time, content, array_index)
{
	var row = document.createElement("tr");
	var col;
	var input;
	var cellText;

	/*index*/
	col = document.createElement("td");
	col.width = "16";

	col.align="center";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	cellText = document.createTextNode(array_index+1);
	col.appendChild(cellText);
	row.appendChild(col);

	/*from*/
	col = document.createElement("td");
	col.id = "inbox_from__"+array_index;

	col.align="left";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	row.appendChild(col);

	/*content*/
	col = document.createElement("td");
	col.id = "inbox_content__"+array_index;

	col.align="left";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	row.appendChild(col);

	
	/*action*/
	col = document.createElement("td");
	//col.width = "135";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	
	input = document.createElement("input");
	input.id = "inbox_delete__"+array_index;
	input.name = "inbox_delete__"+array_index;
	input.type = "button";
	input.value = gettext("Delete");
	input.onclick = sms_inbox_delete;
	input.className = "submit_s";
	col.appendChild(input);
	
	row.appendChild(col);
	table.appendChild(row);
	if(name == "")
	{
		if (new_msg)
			document.getElementById("inbox_from__"+array_index).innerHTML = '<a onclick="application_inbox_popup('+array_index+');"><span class="text_warning_small">' + gettext("[new]") + ' </span>' + number + '<br /><span class="text_gray_small">('+time+')</span>' + '</a>';				
		else
			document.getElementById("inbox_from__"+array_index).innerHTML = '<a onclick="application_inbox_popup('+array_index+');">' + number+'<br /><span class="text_gray_small">('+time+')</span>' + '</a>';
	}
	else
	{
		if (new_msg)
			document.getElementById("inbox_from__"+array_index).innerHTML = '<a onclick="application_inbox_popup('+array_index+');"><span class="text_warning_small">' + gettext("[new]") + ' </span>' + name+'<br /><span class="text_gray_small">('+time+')</span>' + '</a>';			
		else			
			document.getElementById("inbox_from__"+array_index).innerHTML = '<a onclick="application_inbox_popup('+array_index+');">' + name+'<br /><span class="text_gray_small">('+time+')</span>' + '</a>';
	}
		
	if (content.length > 30) 
	{
		content = content.substr(0, 30) + "...";
	}
	document.getElementById("inbox_content__"+array_index).innerHTML = '<a class="Text_gray" onclick="application_inbox_popup('+array_index+');">'+content+'</a>';	
}

function drawSMSOutboxList(table, name, time, content, array_index)
{
	var row = document.createElement("tr");
	var col;
	var input;
	var cellText;
	/*index*/
	col = document.createElement("td");
	col.width = "16";

	col.align="center";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	cellText = document.createTextNode(array_index+1);
	col.appendChild(cellText);
	row.appendChild(col);

	/*from*/
	col = document.createElement("td");
	col.id = "outbox_from__"+array_index;

	col.className = "Text_gray";
	col.align="left";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	row.appendChild(col);

	/*content*/
	col = document.createElement("td");
	col.id = "outbox_content__"+array_index;

	col.align="left";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	row.appendChild(col);

	
	/*action*/
	col = document.createElement("td");
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	
	input = document.createElement("input");
	input.id = "outbox_delete__"+array_index;
	input.name = "outbox_delete__"+array_index;
	input.type = "button";
	input.value = gettext("Delete");
	
	input.onclick = sms_outbox_delete;	
	col.appendChild(input);
	
	row.appendChild(col);
	table.appendChild(row);

	document.getElementById("outbox_from__"+array_index).innerHTML = '<a onclick="application_outbox_popup('+array_index+');">'+name+'</a>';		
	/*
	if (time=="")
		document.getElementById("outbox_from__"+array_index).innerHTML = '<a onclick="application_outbox_popup('+array_index+');">'+name+'</a>';		
	else		
		document.getElementById("outbox_from__"+array_index).innerHTML = '<a onclick="application_outbox_popup('+array_index+');">'+name+'<br /><span class="text_gray_small">('+time+')</span>'+'</a>';
	*/
	if (content.length > 30) 
	{
		content = content.substr(0, 30) + "...";
	}
	document.getElementById("outbox_content__"+array_index).innerHTML = '<a onclick="application_outbox_popup('+array_index+');">'+content+'</a>';

}

function drawSIMSMSList(table, new_msg, sms_sent, name, number, time, content, array_index)
{
	var row = document.createElement("tr");
	var col;
	var input;
	var cellText;
	/*index*/
	col = document.createElement("td");
	col.width = "16";

	col.className = "Text_gray";
	col.align="center";
	if (array_index%2 == 1)
		col.bgColor = "#e1e1e1";
	else
		col.bgColor = "#f0f0f0";
	cellText = document.createTextNode(array_index+1);
	col.appendChild(cellText);
	row.appendChild(col);

	/*from*/
	col = document.createElement("td");
	col.id = "sim_sms_from__"+array_index;

	col.className = "Text_gray";
	col.align="left";
	if (array_index%2 == 1)
		col.bgColor = "#e1e1e1";
	else
		col.bgColor = "#f0f0f0";
	row.appendChild(col);

	/*content*/
	col = document.createElement("td");
	col.id = "sim_sms_content__"+array_index;
	col.align="left";
	if (array_index%2 == 1)
		col.bgColor = "#e1e1e1";
	else
		col.bgColor = "#f0f0f0";
	row.appendChild(col);

	
	/*action*/
	col = document.createElement("td");
	if (array_index%2 == 1)
		col.bgColor = "#e1e1e1";
	else
		col.bgColor = "#f0f0f0";
	
	input = document.createElement("input");
	input.id = "sim_sms_delete__"+array_index;
	input.name = "sim_sms_delete__"+array_index;
	input.type = "button";
	input.value = gettext("Delete");
	input.onclick = short_sim_sms_delete;
	col.appendChild(input);
	
	row.appendChild(col);
	table.appendChild(row);

	if (new_msg)
	{
		if (time=="")
			document.getElementById("sim_sms_from__"+array_index).innerHTML = '<a onclick="application_sms_popup('+array_index+');"><span class="text_warning_small">' + gettext("[new]") + ' </span>' + number+ '</a>';			
		else
			document.getElementById("sim_sms_from__"+array_index).innerHTML = '<a onclick="application_sms_popup('+array_index+');"><span class="text_warning_small">' + gettext("[new]") + ' </span>' + number+'<br /><span class="text_gray_small">('+time+')</span>' + '</a>';			
	}
	else if (sms_sent)
	{
		if (time=="")
			document.getElementById("sim_sms_from__"+array_index).innerHTML = '<a onclick="application_sms_popup('+array_index+');"><span class="text_warning_small" style="color:blue;">' + gettext("[sent]") + ' </span>' + number+ '</a>';						
		else	
			document.getElementById("sim_sms_from__"+array_index).innerHTML = '<a onclick="application_sms_popup('+array_index+');"><span class="text_warning_small" style="color:blue;">' + gettext("[sent]") + ' </span>' + number+'<br /><span class="text_gray_small">('+time+')</span>' + '</a>';						
	}
	else
	{
		if (time=="")
			document.getElementById("sim_sms_from__"+array_index).innerHTML = '<a onclick="application_sms_popup('+array_index+');">' + number+ '</a>';				
		else
			document.getElementById("sim_sms_from__"+array_index).innerHTML = '<a onclick="application_sms_popup('+array_index+');">' + number+'<br /><span class="text_gray_small">('+time+')</span>' + '</a>';
	}


	if (content.length > 30) 
	{
		content = content.substr(0, 30) + "...";
	}
	document.getElementById("sim_sms_content__"+array_index).innerHTML = '<a onclick="application_sms_popup('+array_index+');">'+content+'</a>';
}

function drawSMSDraftList(table, name, time, content, array_index)
{
	var row = document.createElement("tr");
	var col;
	var input;
	var cellText;

	/*index*/
	col = document.createElement("td");
	col.width = "16";

	col.align="center";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	cellText = document.createTextNode(array_index+1);
	col.appendChild(cellText);
	row.appendChild(col);

	/*from*/
	col = document.createElement("td");
	col.id = "draft_from__"+array_index;

	col.align="left";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	row.appendChild(col);

	/*content*/
	col = document.createElement("td");
	col.id = "draft_content__"+array_index;

	col.align="left";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	row.appendChild(col);

	
	/*action*/
	col = document.createElement("td");
	//col.width = "135";
	if (array_index%2 == 1)
		col.bgColor = "#F6F6F6";
	else
		col.bgColor = "#EEEEEE";
	
	input = document.createElement("input");
	input.id = "draft_edit__"+array_index;
	input.name = "draft_edit__"+array_index;
	input.type = "button";
	input.value = gettext("Edit");
	input.onclick = sms_draft_edit;
	input.className = "submit_s";
	input.setAttribute("style", "margin-bottom:10px; width:72px;");
	col.appendChild(input);

	input = document.createElement("input");
	input.id = "draft_delete__"+array_index;
	input.name = "draft_delete__"+array_index;
	input.type = "button";
	input.value = gettext("Delete");
	input.onclick = sms_draft_delete;
	input.className = "submit_s";
	input.setAttribute("style", "margin-bottom:10px; width:72px;");	
	col.appendChild(input);	

	input = document.createElement("input");
	input.id = "draft_send__"+array_index;
	input.name = "draft_send__"+array_index;
	input.type = "button";
	input.value = gettext("Send");
	input.onclick = sms_draft_send;
	input.className = "submit_s";
	input.setAttribute("style", "margin-bottom:10px; width:72px;");
	col.appendChild(input);
	
	row.appendChild(col);
	table.appendChild(row);

	document.getElementById("draft_from__"+array_index).innerHTML = '<a onclick="application_draft_popup('+array_index+');">' + name+'</a>';		
	/*
	if (time=="")
		document.getElementById("draft_from__"+array_index).innerHTML = '<a onclick="application_draft_popup('+array_index+');">' + name+'</a>';		
	else	
		document.getElementById("draft_from__"+array_index).innerHTML = '<a onclick="application_draft_popup('+array_index+');">' + name+'<br /><span class="text_gray_small">('+time+')</span>' + '</a>';			
	*/
	if (content.length > 30) 
	{
		content = content.substr(0, 30) + "...";
	}
	document.getElementById("draft_content__"+array_index).innerHTML = '<a class="Text_gray" onclick="application_draft_popup('+array_index+');">'+content+'</a>';	
}

function check_pin_status()
{
	if(sim_status=="inserted" && pin1_status=="disabled" ||
		sim_status=="inserted" && pin1_status=="enabled, verified")
		return true;
	else
		return false;
}

function submit_new_sms_check()
{
	var send_list = $("#new_sms_send_to").val();
	var arr = send_list.split(";");
	var content = $('#new_sms_content').val();
	var phone_no_rule=/^(\+)?([0-9])*$/;

	if(arr.length>11)
	{
		alert(gettext("The maximum contacts is 10."));
		return false;
	}
	new_sms_send_list = new Array();
	for(var i=0;i<arr.length;i++)
	{
		if(arr[i]!="")
		{
			var temp_contact = new Object();
			temp_contact.name = "";
			temp_contact.number = arr[i];
			new_sms_send_list.push(temp_contact);
			temp_contact = null;
		}
	}
	send_list = null;
	arr = null;
	phone_no_rule = null;
	
	if(new_sms_send_list.length == "undefined" || new_sms_send_list.length == 0)
	{
		alert(gettext("Please input phone number."));
		return false;
	}
	else if(content.length == 0)
	{
		alert(gettext("Message contents can not be empty."));
		return false;
	}	
	
	return true;	
}

function submit_edit_draft_check()
{
	var send_list = $("#sms_draft_edit_to").val();
	var arr = send_list.split(";");
	var content = $('#sms_draft_edit_content').val();
	var phone_no_rule=/^(\+)?([0-9])*$/;
	
	if(arr.length>11)
	{
		alert(gettext("The maximum contacts is 10."));
		return false;
	}
	new_sms_draft_list = new Array();
	for(var i=0;i<arr.length;i++)
	{
		if(arr[i]!="")
		{
			arr[i] = arr[i].replace(" ", "");		
			var temp_contact = new Object();
			temp_contact.name = "";
			temp_contact.number = arr[i];
			new_sms_draft_list.push(temp_contact);
			temp_contact = null;
		}
	}
	send_list = null;
	arr = null;
	phone_no_rule = null;
	
	if(new_sms_draft_list.length == "undefined" || new_sms_draft_list.length == 0)
	{
		alert(gettext("Please input phone number."));
		return false;
	}
	else if(content.length == 0)
	{
		alert(gettext("Message contents can not be empty."));
		return false;
	}	
	
	return true;	
}

function disable_sms(sim_ready)
{
	if (!sim_ready)
	{
		if (!disable_sms_menu)
		{
			if (document.getElementById("sms_submenu_focus"))
			    document.getElementById("sms_submenu_focus").setAttribute("class", "leftmenu_disabled");

			if (document.getElementById('app_href')&&document.getElementById('dlna_setting')<=0)
			{
				document.getElementById('app_href').href="../applications/dlna.asp";
				window.location = "../applications/dlna.asp";				
			}		
			else
			{
				$("#center_bg").css("display","");	
			}
			disable_sms_menu=true;
		}
	}
	else
	{
		$("#center_bg").css("display","");		
	}
}

function GetSMSSimInfo(sms_info)
{
	if(typeof(sms_info.errno) != "undefined" && sms_info.errno != 0)
	{
		alert(sms_info.errmsg);
	}
	else
	{
		sim_status = sms_info.sim_status;
		pin1_status = sms_info.pin1_status;
		if(sim_status=="inserted" && pin1_status=="disabled" ||
			sim_status=="inserted" && pin1_status=="enabled, verified")
		{
		}
		else
			alert(gettext("SIM card error or SIM card is not inserted."));
		
	}
}

function GetSMSInd(sms_ind)
{
	if(typeof(sms_ind.errno) != "undefined" && sms_ind.errno != 0)
	{
		alert(sms_ind.errmsg);
	}
	else
	{
		//temporarily solution.
		sim_sms_new_incoming = sms_ind.new_incoming;
		sim_sms_ready = sms_ind.sim_sms_ready;
		if ($("#get_sim_sms_info").length > 0 
			&& !sim_sms_ready 
			&& !sim_sms_ready_count)
		{
			sim_sms_ready_count=1;
			alert(gettext("SIM SMS is not ready."));					
		}
	
		//disable_sms(sim_sms_ready); //keep this to disable sms menu
		//$("#center_bg").css("display","");

		if (typeof(sms_ind.send)=="undefined")
			sms_send_status = "none";
		else
			sms_send_status = sms_ind.send.status;
		
		if(document.getElementById("set_new_sms"))
		{			
			if(sms_send_status == "sending")
				document.getElementById("set_new_sms").disabled = true;
			else
				document.getElementById("set_new_sms").disabled = false;
		}
		
		if(sim_sms_new_incoming != 0)
		{
			if(sim_sms_new_incoming == 1)
				alert(sim_sms_new_incoming+" " + gettext("new message is received."));
			else 
				alert(sim_sms_new_incoming+" " + gettext("new messages are received."));
		}		

		if(sms_send_status == "ok")
		{
			alert(gettext("Send SMS Successfully."));

			//if current page is draft, refresh draft page
			if ($("#get_sms_draft_info").length > 0)
			{
				RedirectToDraft();
			}
		}
		else if(sms_send_status == "failed")
		{
			var failed_array = "";
			for(var i=0;i<sms_ind.failed_array.length;i++)
			{
				if(sms_ind.failed_array[i].name != "")
				{
					failed_array = failed_array + sms_ind.failed_array[i].name+";";
				}
				else
				{
					failed_array = failed_array + sms_ind.failed_array[i].number+";";
				}
			}
			if(sms_ind.failed_array.length > 1)
				alert(gettext("Sending message are failed.\nFailed list are")+ " " + failed_array);
			else
				alert(gettext("Sending message is failed.\nFailed list is")+ " " + failed_array);
			
		}
		setTimeout(function () {LoadSMSInfo('get_sms_ind', false);}, 5000);
	}
}

function GetSMSInfo(sms_info)
{
	if(typeof(sms_info.errno) != "undefined" && sms_info.errno != 0)
	{
		alert(sms_info.errmsg);
	}
	else
	{
		temp_draft_count=sms_info.draft_count;
		temp_outbox_count=sms_info.outbox_count;		
		/*
		if ($("#get_sim_sms_info").length > 0)
		{
			$("#short_sms_total_num").text(sms_info.sim_used);
			$("#short_sms_max_num").text(sms_info.sim_max);
		}
		*/
	}
}
function GetInboxInfo(inbox_info)
{
	if(typeof(inbox_info.errno) != "undefined" && inbox_info.errno != 0)
	{
		alert(inbox_info.errmsg);
	}
	else
	{
		$("#short_inbox_total_num").text(inbox_info.records.length);
		if (inbox_info.records.length >= 250)
		{
			alert(gettext("There are already 250 received messages.\nPlease delete some messages otherwise new messages will be lost."));
		}
		
		if ($("#sms_inbox_table").length > 0) 
		{
			sms_inbox_list = new Array();
		 	if (inbox_info.records.length > 0) 
			{
		 		for (var i = 0; i < inbox_info.records.length; i++)
		 		{
		 			var temp_inbox = new Object();
					temp_inbox.new_sms = inbox_info.records[i].new_sms;
					temp_inbox.name = inbox_info.records[i].name;
					temp_inbox.number = inbox_info.records[i].number;
					temp_inbox.time = inbox_info.records[i].time;
					temp_inbox.content = inbox_info.records[i].content;
					temp_inbox.idx = inbox_info.records[i].idx;
					sms_inbox_list.push(temp_inbox);
		 			
					drawSMSInboxList(
						document.getElementById('sms_inbox_table'), 
						inbox_info.records[i].new_sms,
						inbox_info.records[i].name,
						inbox_info.records[i].number,
						inbox_info.records[i].time, 
						inbox_info.records[i].content,
						i);
					temp_inbox = null;
		 		}
		 	}
		}
	}
}

function GetOutboxInfo(outbox_info)
{
	if(typeof(outbox_info.errno) != "undefined" && outbox_info.errno != 0)
	{
		alert(outbox_info.errmsg);
	}
	else
	{
		$("#short_outbox_total_num").text(outbox_info.records.length);		
		if ($("#sms_outbox_table").length > 0) 
		{
			sms_outbox_list = new Array();
		 	if (outbox_info.records.length > 0) 
			{
		 		for (var i = 0; i < outbox_info.records.length; i++)
		 		{
		 			var temp_outbox = new Object();
					var temp_name = ""; //display table
					var temp_outbox_name = ""; //display detail
					 
					for(var j=0;j<outbox_info.records[i].sendto.length;j++)
					{
						if(outbox_info.records[i].sendto[j].name != "")
							temp_outbox_name = temp_outbox_name + outbox_info.records[i].sendto[j].name + "; ";
						else
							temp_outbox_name = temp_outbox_name + outbox_info.records[i].sendto[j].number + "; ";
						if(j == 0)
						{
							if(outbox_info.records[i].sendto[j].name != "")
								temp_name = temp_name + outbox_info.records[i].sendto[j].name;
							else
								temp_name = temp_name + outbox_info.records[i].sendto[j].number;
						}
					}
					if(outbox_info.records[i].sendto.length > 1)
					{
						temp_name = temp_name + ", and "+(outbox_info.records[i].sendto.length-1)+"ppl.";
					}
					
					temp_outbox.name = temp_outbox_name;
					temp_outbox.time = outbox_info.records[i].time;
					temp_outbox.content = outbox_info.records[i].content;
					temp_outbox.idx = outbox_info.records[i].idx;
					sms_outbox_list.push(temp_outbox);
					
					drawSMSOutboxList(
						document.getElementById('sms_outbox_table'), 
						temp_name,
						outbox_info.records[i].time, 
						outbox_info.records[i].content,
						i);
					temp_outbox = null;
					temp_name = null;
					temp_outbox_name = null;
		 		}
		 	}
		}
	}
}

function GetSIMSMSInfo(sms_info)
{
	if(typeof(sms_info.errno) != "undefined" && sms_info.errno != 0)
	{
		alert(sms_info.errmsg);
	}
	else
	{
		$("#short_sms_total_num").text(sms_info.records.length);
		if ($("#sim_sms_table").length > 0) 
		{
			sim_sms_list = new Array();
		 	if (sms_info.records.length > 0) 
			{
		 		for (var i = 0; i < sms_info.records.length; i++)
		 		{
		 			var temp_sms = new Object();
					if (typeof(sms_info.records[i].new_sms)=="undefined")
						temp_sms.new_sms = false;
					else
						temp_sms.new_sms = sms_info.records[i].new_sms;
					if (typeof(sms_info.records[i].sms_sent)=="undefined")
						temp_sms.sms_sent = false;
					else
						temp_sms.sms_sent = sms_info.records[i].sms_sent;
					
					temp_sms.name = sms_info.records[i].name;
					temp_sms.number = sms_info.records[i].number;
					temp_sms.time = sms_info.records[i].time;
					temp_sms.content = sms_info.records[i].content;
					temp_sms.idx = sms_info.records[i].idx;
					sim_sms_list.push(temp_sms);
		 			
					drawSIMSMSList(
						document.getElementById('sim_sms_table'), 
						sms_info.records[i].new_sms,
						sms_info.records[i].sms_sent,
						sms_info.records[i].name,
						sms_info.records[i].number,
						sms_info.records[i].time, 
						sms_info.records[i].content,
						i);
					temp_sms = null;
		 		}
		 	}
		}
	}
}

function GetDraftInfo(sms_draft_info)
{
	if(typeof(sms_draft_info.errno) != "undefined" && sms_draft_info.errno != 0)
	{
		alert(sms_draft_info.errmsg);
	}
	else
	{	
		$("#short_draft_total_num").text(sms_draft_info.records.length);		
		if ($("#sms_draft_table").length > 0) 
		{
			sms_draft_list = new Array();
		 	if (sms_draft_info.records.length > 0) 
			{
		 		for (var i = 0; i < sms_draft_info.records.length; i++)
		 		{
		 			var temp_draft = new Object();
					var temp_name = ""; //display table
					var temp_draft_name = ""; //display details
					for(var j=0;j<sms_draft_info.records[i].sendto.length;j++)
					{						
						temp_draft_name = temp_draft_name + sms_draft_info.records[i].sendto[j].number + "; ";
						if(j == 0)
						{
							temp_name = temp_name + sms_draft_info.records[i].sendto[j].number;
						}
					}
					if(sms_draft_info.records[i].sendto.length > 1)
					{
						temp_name = temp_name + ", and "+(sms_draft_info.records[i].sendto.length-1)+"ppl.";
					}										
					temp_draft.sendto = sms_draft_info.records[i].sendto;					
					temp_draft.time = sms_draft_info.records[i].time;
					temp_draft.content = sms_draft_info.records[i].content;
					temp_draft.idx = sms_draft_info.records[i].idx;
					sms_draft_list.push(temp_draft);

					drawSMSDraftList(
						document.getElementById('sms_draft_table'), 
						temp_name,
						sms_draft_info.records[i].time, 
						sms_draft_info.records[i].content,
						i);
					
					temp_draft = null;
					temp_name = null;
					temp_draft_name = null;					
		 		}
		 	}
		}
	}
}

function GetSMSCenterNumber(center_number_info)
{
	if(typeof(center_number_info.errno) != "undefined" && center_number_info.errno != 0)
	{
		alert(center_number_info.errmsg);
	}
	else
	{
		$("#sms_center_number").val(center_number_info.sc_address);
	}
}
function LoadSMSInfo(item, type, start, end, edit, send)
{
	var targetUrl = isDebugMode() ? '/testdata/get_application_status.json' : '/cgi-bin/gui.cgi';		
	var senddata;

	if(typeof(edit)=="undefined")
		edit = false;
	if(typeof(send)=="undefined")
		send = false;

	if(item == "get_sms_inbox_records" || item == "get_sms_outbox_records" 
		|| item == "get_sms_sim_records" || item == "get_sms_draft_records")
	{
		if(type)
			senddata = { "action" : item, "args" : { "full_content" : type, "start" : start, "end" : end }};
		else
			senddata = { "action" : item, "args" : { "full_content" : type }};
	}
	else 
		senddata = { "action" : item };
	
	$.ajax({
		type: 'POST',
		url: targetUrl,
		timeout : 30000, // 30 seconds
		contentType: 'json',
		dataType: 'json',
		data: $.toJSON(senddata),
	  	beforeSend: function()
	  	{
			//if(isDebugMode()) { alert("Sending apply JSON: \n" + $.toJSON(senddata)); }	  		
			
			if (item !== "get_sms_ind")
				blockUI();		
	  	},
		error: function(xhr, textStatus, errorThrown)
		{

			if(item == "get_sms_inbox_records")
			{				
				var eT = document.getElementById('sms_inbox_table');
				if(eT.hasChildNodes())
				{
					while(eT.childNodes.length>=1)
					{
						eT.removeChild(eT.firstChild);
					}
				}
				eT = null;				
			}
			else if (item == "get_sms_outbox_records")
			{
				var eT = document.getElementById('sms_outbox_table');
				if(eT.hasChildNodes())
				{
					while(eT.childNodes.length>=1)
					{
						eT.removeChild(eT.firstChild);
					}
				}
				eT = null;
			}
			else if(item =="get_sms_sim_records")
			{
				var eT = document.getElementById('sim_sms_table');
				if(eT.hasChildNodes())
				{
					while(eT.childNodes.length>=1)
					{
						eT.removeChild(eT.firstChild);
					}
				}
				eT = null;
			}
			else if (item == "get_sms_draft_records")
			{
				var eT = document.getElementById('sms_draft_table');
				if(eT.hasChildNodes())
				{
					while(eT.childNodes.length>=1)
					{
						eT.removeChild(eT.firstChild);
					}
				}
				eT = null;
			}	
			unblockUI();
		},
		success: function(msg, textStatus, xhr)
		{						
			if (xhr.status)
			{
				if(msg == null)
				{	
					/*
					if (item !== "get_sms_ind")
						alert(gettext("Response is null"));
					*/
				}
				else
				{
					if (item == "get_sms_sim_info")
					{
						GetSMSSimInfo(msg.sms_sim_info);
					}
					else if(item == "get_sms_ind")
					{
						GetSMSInd(msg.sms_ind);
					}				
					else if(item == "get_sms_info")
					{
						GetSMSInfo(msg.sms_info);
					}
					else if(item == "get_sms_inbox_records")
					{								
						if (!type)
							GetInboxInfo(msg.sms_inbox_records);
						else
							inbox_popup_one(msg.sms_inbox_records, start);					
					}	
					else if (item == "get_sms_outbox_records")
					{	
						if (!type)
							GetOutboxInfo(msg.sms_outbox_records);
						else
							outbox_popup_one(msg.sms_outbox_records, start);
					}
					else if(item == "get_sms_sim_records")
					{
						if (!type)
							GetSIMSMSInfo(msg.sms_sim_records);
						else
							sim_sms_popup_one(msg.sms_sim_records, start);						
					}	
					else if(item == "get_sms_draft_records")
					{
						if (!type)
							GetDraftInfo(msg.sms_draft_records);
						else
						{
							if (edit)
								draft_edit_popup_one(msg.sms_draft_records, start);
							else if (send)
								draft_send_record(msg.sms_draft_records, start);
							else
								draft_popup_one(msg.sms_draft_records, start);
						}
					}
					else if(item == "get_sms_center_number")
					{					
						GetSMSCenterNumber(msg.sms_center_number);
					}
				}
				unblockUI();
			} 
		}
	});
	targetUrl = null;
	senddata = null;
}

function SendSMSData(senddata, onsuccess, onerror)
{
	var targetUrl = isDebugMode() ? '/testdata/get_application_status.json' : '/cgi-bin/gui.cgi' ;
	var send_data_obj = eval('(' + $.toJSON(senddata) + ')');
	var item = send_data_obj.action;
	
	$.ajax({
		type: 'POST',
		url: targetUrl,
		contentType: 'json',
		dataType: 'json',
		data: $.toJSON(senddata),
		beforeSend : function () 
		{
			if(isDebugMode()) { alert("Sending apply JSON: \n" + $.toJSON(senddata)); }
			blockUI();
		},
		error: function(xhr, textStatus, errorThrown) {
			unblockUI();							
		},
		success: function(msg, textStatus, xhr) {
			if (xhr.status) {					
				var ok = true;

				if (msg == null)
				{
					ok = false;
					alert(gettext("Failed to apply action.\nResponse is null."));
				}
				else
				{
				
					if (item=="set_sms_send" && typeof(msg.sms_send)!="undefined" && msg.sms_send.errno < 0)
					{
						ok = false;
						//alert(msg.sms_send.errmsg);
					}
					else if (item=="set_sms_inbox_deleted" && typeof(msg.sms_inbox_deleted)!="undefined" && msg.sms_inbox_deleted.errno < 0)
					{
						ok = false;
						alert(msg.sms_inbox_deleted.errmsg);
					}
					else if (item=="set_sms_inbox_read" && typeof(msg.sms_inbox_read)!="undefined" && msg.sms_inbox_read.errno < 0)
					{
						ok = false;
						alert(msg.sms_inbox_read.errmsg);
					}
					else if (item=="set_sms_save_draft" && typeof(msg.sms_save_draft)!="undefined" && msg.sms_save_draft.errno < 0)
					{
						ok = false;
						alert(msg.sms_save_draft.errmsg);
					}
					else if (item=="set_sms_outbox_deleted" && typeof(msg.sms_outbox_deleted)!="undefined" && msg.sms_outbox_deleted.errno < 0)
					{
						ok = false;
						alert(msg.sms_outbox_deleted.errmsg);
					}
					else if (item=="set_sms_sim_deleted" && typeof(msg.sms_sim_deleted)!="undefined" && msg.sms_sim_deleted.errno < 0)
					{
						ok = false;
						alert(msg.sms_sim_deleted.errmsg);
					}
					else if (item=="set_sms_sim_read" && typeof(msg.sms_sim_read)!="undefined" && msg.sms_sim_read.errno < 0)
					{
						ok = false;
						alert(msg.sms_sim_read.errmsg);
					}
					else if (item=="set_sms_draft_deleted" && typeof(msg.sms_draft_deleted)!="undefined" && msg.sms_draft_deleted.errno < 0)
					{
						ok = false;
						alert(msg.sms_draft_deleted.errmsg);
					}				
					else if (item=="set_sms_center_number" && typeof(msg.sms_center_number)!="undefined" &&  msg.sms_center_number.errno < 0)
					{
						ok = false;
						alert(msg.sms_center_number.errmsg);
					}
				}
					
				if (ok) 
				{
					if(onsuccess) 
						onsuccess();
			 	}
				if (!ok)
				{
					if(onerror)
						onerror();
				}
				ok = null;				
			}	
			unblockUI();
		}
	});
	targetUrl = null;
}
$(document).ready(function()
{
	temp_inbox_index = -2;
	temp_outbox_index = -2;
	temp_sim_sms_index = -2;
	temp_draft_index = -2;


	/*
	if ($("#mainmenu_bg").length > 0)			
	{
		$(function(){LoadSMSInfo('get_sms_ind', false);})
	}
	*/

	if ($("#get_new_sms_info").length > 0)
	{
		$('#new_sms_send_to').val("");
		$('#new_sms_content').val("");		
		$(function(){LoadSMSInfo('get_sms_sim_info', false);})
		$(function(){LoadSMSInfo('get_sms_ind', false);})
		$(function(){LoadSMSInfo('get_sms_info',false);})		
	}
	if ($("#get_sms_inbox_info").length > 0) 
	{
		$(function(){LoadSMSInfo('get_sms_ind', false);})
		$(function(){LoadSMSInfo('get_sms_inbox_records', false);})
	}	
	if ($("#get_sms_outbox_info").length > 0) 
	{
		$(function(){LoadSMSInfo('get_sms_ind', false);})
		$(function(){LoadSMSInfo('get_sms_outbox_records', false);})
	}		
	if ($("#get_sim_sms_info").length > 0)
	{
		$(function(){LoadSMSInfo('get_sms_sim_info', false);})
		$(function(){LoadSMSInfo('get_sms_ind', false);})
		$(function(){LoadSMSInfo('get_sms_info',false);})
		$(function(){LoadSMSInfo('get_sms_sim_records', false);})
	}	
	if ($("#get_sms_draft_info").length > 0)
	{
		$(function(){LoadSMSInfo('get_sms_sim_info', false);})
		$(function(){LoadSMSInfo('get_sms_ind', false);})
		$(function(){LoadSMSInfo('get_sms_info',false);})
		$(function(){LoadSMSInfo('get_sms_draft_records', false);})		
	}
	if ($("#get_sms_center_number").length > 0)
	{
		$(function(){LoadSMSInfo('get_sms_sim_info', false);})
		$(function(){LoadSMSInfo('get_sms_ind', false);})
		$(function(){LoadSMSInfo('get_sms_center_number', false);})
	}
		
	/* new sms start */
	$('#set_new_sms').die();
	$('#set_new_sms').live('click', function(){
		if (submit_new_sms_check())		
		{			
			if(!check_pin_status())
			{
				alert(gettext("SIM card error or SIM card is not inserted."));
				return false;		
			}						
			if(temp_outbox_count >= 250)
			{
				alert(gettext("There are already 250 Outbox."));
				return false;
			}	
			if(sms_send_status == "sending")
			{
				alert(gettext("There is already a sending message."));								
				return false;
			}						
			SendSMSData
			({
				"action":"set_sms_send", 
				"args":
				{
					"sendto" : new_sms_send_list,
					"content" : $('#new_sms_content').val()
			    }
			}, doRedirect);
		}
	});		
	
	$('#save_new_sms').die();
	$('#save_new_sms').live('click', function(){
		if (temp_draft_count >= 250)
		{
			alert(gettext("There are already 250 draft messages."));
			return false;
		}
		if (submit_new_sms_check())		
		{
			SendSMSData
			({
				"action":"set_sms_save_draft", 
				"args":
				{
					"idx":-1,
					"sendto" : new_sms_send_list,
					"content" : $('#new_sms_content').val()
			    }
			}, doRedirect);
		}	
	});
	/* new sms end */
	
	/* inbox sms start */
	$('#inbox_delete_all').die();
	$('#inbox_delete_all').live('click', function(){
		
		if(sms_inbox_list.length == 0)
		{
			alert(gettext("The inbox has no more messages to delete."));
		}
		else
		{
			var confirm_delete;
			confirm_delete = window.confirm(gettext("Are you sure you want to delete all inbox?"));
			if(confirm_delete)
			{
				SendSMSData
				({
					"action":"set_sms_inbox_deleted", 
					"args":
					{
						"idx":-1
				    }
				}, doRedirect);
			}
			confirm_delete = null;
		}
	});	

	$('#inbox_received_delete').die();
	$('#inbox_received_delete').live('click', function(){
		var confirm_delete;
		confirm_delete = window.confirm(gettext("Are you sure you want to delete this message?"));
		if(confirm_delete)
		{
			SendSMSData
			({
				"action":"set_sms_inbox_deleted", 
				"args":
				{
					"idx":sms_inbox_list[temp_inbox_index].idx
			    }
			}, RedirectToInbox);
		}
		confirm_delete = null;
	});		

	$('#inbox_received_previous').die();
	$('#inbox_received_previous').live('click', function(){
		var previous_index = -2;
		if(temp_inbox_index == 0)
		{
			previous_index = sms_inbox_list.length-1;
		}
		else
		{
			previous_index = temp_inbox_index-1;
		}
		temp_inbox_index = previous_index;
		if(sms_inbox_list[previous_index].new_sms)
		{
			SendSMSData
			({
				"action":"set_sms_inbox_read", 
				"args":
				{
					"idx":sms_inbox_list[previous_index].idx
			    }
			}, null);
		}
		$(function(){LoadSMSInfo('get_sms_inbox_records', true, sms_inbox_list[previous_index].idx, sms_inbox_list[previous_index].idx);})
		previous_index = null;
	});	

	$('#inbox_received_next').die();
	$('#inbox_received_next').live('click', function(){
		var next_index = -2;
		if(temp_inbox_index == (sms_inbox_list.length-1))
		{
			next_index = 0;
		}
		else
		{
			next_index = temp_inbox_index+1;
		}
		temp_inbox_index = next_index;
		if(sms_inbox_list[next_index].new_sms)
		{
			SendSMSData
			({
				"action":"set_sms_inbox_read", 
				"args":
				{
					"idx":sms_inbox_list[next_index].idx
			    }
			}, null);
		}
		$(function(){LoadSMSInfo('get_sms_inbox_records', true, sms_inbox_list[next_index].idx, sms_inbox_list[next_index].idx);})
		next_index = null;
	});			
	/* inbox sms end */

	/* outbox sms start */
	$('#outbox_sent_delete').die();
	$('#outbox_sent_delete').live('click', function(){
		var confirm_delete;
		confirm_delete = window.confirm(gettext("Are you sure you want to delete this message?"));
		if(confirm_delete)
		{
			SendSMSData
			({
				"action":"set_sms_outbox_deleted", 
				"args":
				{
					"idx":sms_outbox_list[temp_outbox_index].idx
			    }
			}, RedirectToOutbox);
		}
		confirm_delete = null;
	});	
	$('#outbox_delete_all').die();
	$('#outbox_delete_all').live('click', function(){
		if(sms_outbox_list.length == 0)
		{
			alert(gettext("The Outbox has no more messages to delete."));
			return false;
		}
		else
		{
			var confirm_delete;
			confirm_delete = window.confirm(gettext("Are you sure you want to delete all Outbox?"));
			if(confirm_delete)
			{
				SendSMSData
				({
					"action":"set_sms_outbox_deleted", 
					"args":
					{
						"idx":-1
				    }
				}, doRedirect);
			}
			confirm_delete = null;
		}
	});	

	$('#outbox_sent_previous').die();
	$('#outbox_sent_previous').live('click', function(){
		var previous_index = -2;
		if(temp_outbox_index == 0)
		{
			previous_index = sms_outbox_list.length-1;
		}
		else
		{
			previous_index = temp_outbox_index-1;
		}
		temp_outbox_index = previous_index;
		$(function(){LoadSMSInfo('get_sms_outbox_records', true, sms_outbox_list[previous_index].idx, sms_outbox_list[previous_index].idx);})
		previous_index = null;
	});	

	$('#outbox_sent_next').die();
	$('#outbox_sent_next').live('click', function(){
		var next_index = -2;
		if(temp_outbox_index == (sms_outbox_list.length-1))
		{
			next_index = 0;
		}
		else
		{
			next_index = temp_outbox_index+1;
		}
		temp_outbox_index = next_index;
		$(function(){LoadSMSInfo('get_sms_outbox_records', true, sms_outbox_list[next_index].idx, sms_outbox_list[next_index].idx);})
		next_index = null;
	});	
	/* outbox sms end */

	/* draft sms start */
	$('#draft_delete_all').die();
	$('#draft_delete_all').live('click', function(){
		
		if(sms_draft_list.length == 0)
		{
			alert(gettext("The draft has no more messages to delete."));
		}
		else
		{
			var confirm_delete;
			confirm_delete = window.confirm(gettext("Are you sure you want to delete all draft?"));
			if(confirm_delete)
			{
				SendSMSData
				({
					"action":"set_sms_draft_deleted", 
					"args":
					{
						"idx":-1
				    }
				}, doRedirect);
			}
			confirm_delete = null;
		}
	});	

	$('#draft_received_delete').die();
	$('#draft_received_delete').live('click', function(){
		var confirm_delete;
		confirm_delete = window.confirm(gettext("Are you sure you want to delete this message?"));
		if(confirm_delete)
		{
			SendSMSData
			({
				"action":"set_sms_draft_deleted", 
				"args":
				{
					"idx":sms_draft_list[temp_draft_index].idx
			    }
			}, RedirectToDraft);
		}
		confirm_delete = null;
	});		

	$('#draft_received_previous').die();
	$('#draft_received_previous').live('click', function(){
		var previous_index = -2;
		if(temp_draft_index == 0)
		{
			previous_index = sms_draft_list.length-1;
		}
		else
		{
			previous_index = temp_draft_index-1;
		}
		temp_draft_index = previous_index;
		$(function(){LoadSMSInfo('get_sms_draft_records', true, sms_draft_list[previous_index].idx, sms_draft_list[previous_index].idx);})
		previous_index = null;
	});	

	$('#draft_received_next').die();
	$('#draft_received_next').live('click', function(){
		var next_index = -2;
		if(temp_draft_index == (sms_draft_list.length-1))
		{
			next_index = 0;
		}
		else
		{
			next_index = temp_draft_index+1;
		}
		temp_draft_index = next_index;
		$(function(){LoadSMSInfo('get_sms_draft_records', true, sms_draft_list[next_index].idx, sms_draft_list[next_index].idx);})
		next_index = null;
	});			

	$('#sms_draft_edit_apply').die();
	$('#sms_draft_edit_apply').live('click', function(){
		if (submit_edit_draft_check())		
		{
			SendSMSData
			({
				"action":"set_sms_save_draft", 
				"args":
				{
					"idx":sms_draft_list[temp_draft_index].idx,
					"sendto" : new_sms_draft_list,
					"content" : $('#sms_draft_edit_content').val()
			    }
			}, doRedirect);
		}			
	});	
	/* draft sms end */

	/* SIM SMS start*/
	$('#short_sms_delete_all').die();
	$('#short_sms_delete_all').live('click', function(){
		if(sim_sms_list.length == 0)
		{
			alert(gettext("The SIM SMS has no more messages to delete."));
		}
		else
		{
			var confirm_delete;
			confirm_delete = window.confirm(gettext("Are you sure you want to delete all SMS?"));
			if(confirm_delete)
			{
				SendSMSData
				({
					"action":"set_sms_sim_deleted", 
					"args":
					{
						"idx":-1
				    }
				}, doRedirect);
			}
			confirm_delete = null;
		}
	});	
	$('#sim_sms_delete').die();
	$('#sim_sms_delete').live('click', function(){
		var confirm_delete;
		confirm_delete = window.confirm(gettext("Are you sure you want to delete this message?"));
		if(confirm_delete)
		{		
			SendSMSData
			({
				"action":"set_sms_sim_deleted", 
				"args":
				{
					"idx":sim_sms_list[temp_sim_sms_index].idx
			    }
			}, RedirectToSIMSMS);
		}
		confirm_delete = null;
	});
	$('#sim_sms_previous').die();
	$('#sim_sms_previous').live('click', function(){
		var previous_index = -2;
		if(temp_sim_sms_index == 0)
		{
			previous_index = sim_sms_list.length-1;
		}
		else
		{
			previous_index = temp_sim_sms_index-1;
		}
		temp_sim_sms_index = previous_index;
		
		if(sim_sms_list[previous_index].new_sms)
		{
			SendSMSData
			({
				"action":"set_sms_sim_read", 
				"args":
				{
					"idx":sim_sms_list[previous_index].idx
			    }
			}, null);
		}
		$(function(){LoadSMSInfo('get_sms_sim_records', true, sim_sms_list[previous_index].idx, sim_sms_list[previous_index].idx);})
		previous_index = null;
	});	

	$('#sim_sms_next').die();
	$('#sim_sms_next').live('click', function(){
		var next_index = -2;
		if(temp_sim_sms_index == (sim_sms_list.length-1))
		{
			next_index = 0;
		}
		else
		{
			next_index = temp_sim_sms_index+1;
		}
		temp_sim_sms_index = next_index;
		
		if(sim_sms_list[next_index].new_sms)
		{
			SendSMSData
			({
				"action":"set_sms_sim_read", 
				"args":
				{
					"idx":sim_sms_list[next_index].idx
			    }
			}, null);
		}
		$(function(){LoadSMSInfo('get_sms_sim_records', true, sim_sms_list[next_index].idx, sim_sms_list[next_index].idx);})
		next_index = null;
	});	
	/* SIM SMS end*/
	
	/* SMS Setting start */
	$('#set_sms_center_number').die();
	$('#set_sms_center_number').live('click', function(){
		var phone_number_rule=/^[0-9+#*]*$/;			
		if ($("#sms_center_number").val()=="")
		{
			alert(gettext("SMS center number can not be empty."));
		}
		else if (!phone_number_rule.test($("#sms_center_number").val()))
		{
			alert(gettext('Invalid value! Please input "0-9", "+", "#", "*".'));
		}
		else
		{
			SendSMSData
			({
				"action":"set_sms_center_number", 
				"args":
				{
					"sc_address":$("#sms_center_number").val()
			    }
			}, doRedirect);		
		}
	});	
	/* SMS Setting end */

});

