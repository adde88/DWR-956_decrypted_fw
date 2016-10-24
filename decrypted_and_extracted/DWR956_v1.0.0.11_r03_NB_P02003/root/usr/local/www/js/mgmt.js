/* mgmt.js - API library for HTML input components management functions */

/*
* Copyright (c) 2010 TeamF1, Inc.
* All rights reserved.
*/

/*
modification history
------------------------
*/

function gettext( msg_tag )
{
	return msg_tag;
}
function get_by_id(id){
	with(document)
	{
		return getElementById(id);
	}
} 
function logout()
{
	document.top_logout_form.submit();	
}

function fieldStateSet (chkFldIdArr, unchkFldIdArr)
{
	if (chkFldIdArr)
	{
		chkFldIdArr= chkFldIdArr.split (" ");
		for (idx in chkFldIdArr)
			document.getElementById(chkFldIdArr[idx]).checked = true;
	}
	if (unchkFldIdArr)
	{
		unchkFldIdArr= unchkFldIdArr.split (" ");
		for (idx in unchkFldIdArr)
			document.getElementById(unchkFldIdArr[idx]).checked = false;
	}
}
function depFieldCheck (parent, state, disNrec, disRec, enNrec, enRec)
{
	if (!parent)
		return;
	var obj = document.getElementById(parent);
	if (obj.disable) return;
	if (obj.checked != state)
		return;
	return (fieldStateChangeWr (disNrec, disRec, enNrec, enRec));
}
function fieldCssClassChange (fieldId, flag)
{
	var DISABLE_STYLE_SUFFIX = "_dis";
	if (fieldId.className == DISABLE_STYLE_SUFFIX)
	{
		alert (gettext("'_dis' is a reserved style name.")+"\n"+
		gettext("Please use a different style name"));
		return;
	}
	if ((fieldId.type == 'text') || (fieldId.type == 'password') ||
	(fieldId.type == 'submit') || (fieldId.type == 'select-one') ||
	(fieldId.type == 'button') || (fieldId.type == 'submit'))
	{
		var enabledStyle;
		var disabledStyle;
		var idx = fieldId.className.lastIndexOf (DISABLE_STYLE_SUFFIX);
		if (idx == -1)
		{
			enabledStyle = fieldId.className;
			disabledStyle = fieldId.className + DISABLE_STYLE_SUFFIX;
		}
		else
		{
			enabledStyle = fieldId.className.substring (0, idx);
			disabledStyle = fieldId.className;
		}
		fieldId.className = flag ? disabledStyle : enabledStyle ;
	}
	else if (fieldId.type == 'image' || (!fieldId.type && fieldId.src))
	{
		var imgSrc = fieldId.src
		var enableSrc = imgSrc;
		var disableSrc = imgSrc;
		var idx = imgSrc.lastIndexOf("Dis");
		if (idx != -1)
	    {
		    enableSrc = imgSrc.substring (0, idx);
		    enableSrc += imgSrc.substring (idx + 3, imgSrc.length);
	    }
		else
	    {
		    idx = imgSrc.lastIndexOf(".");
		    if (idx != -1)
	        {
		        disableSrc = imgSrc.substring (0, idx);
		        disableSrc += "Dis" + imgSrc.substring (idx, imgSrc.length);
	        }
	    }
		fieldId.src = flag ? disableSrc : enableSrc;
	}
}
function fieldArrStateChange (fieldsArr, state)
{
	for (var idx = 0; idx < fieldsArr.length; idx++)
	{
		if (!fieldsArr[idx]) continue;
			fieldsArr[idx].disabled = state;
		fieldCssClassChange (fieldsArr[idx], state);
	}
}
function fieldStateChangeWr (disNrec, disRec, enNrec, enRec)
{
	if (disNrec)
		fieldStateChange (disNrec, true, false);
	if (disRec)
		fieldStateChange (disRec, true, true);
	if (enNrec)
		fieldStateChange (enNrec, false, false);
	if (enRec)
		fieldStateChange (enRec, false, true);
}
function fieldStateChange (idStr, state, recurse)
{
	var inputObjs;
	var objIdArr = idStr.split (" ");
	for (idx in objIdArr)
	{
		if (recurse)
		{
			inputObjs = (document.getElementById(objIdArr[idx])).getElementsByTagName("INPUT");
			fieldArrStateChange (inputObjs, state);
			inputObjs = (document.getElementById(objIdArr[idx])).getElementsByTagName("SELECT");
			fieldArrStateChange (inputObjs, state);
			inputObjs = (document.getElementById(objIdArr[idx])).getElementsByTagName("IMG");
			fieldArrStateChange (inputObjs, state);
		}
		else
		{
			var inputObj = document.getElementById(objIdArr[idx]);
			if (inputObj)
		    {
			    inputObj.disabled = state;
			    fieldCssClassChange (inputObj, state);
		    }
		}
	}
}
function radioCheckedValueGet (rdbName)
{
	var rdbObjArr = document.getElementsByName (rdbName);
	if (rdbObjArr.length < 1) return null;
		var value = null;
		for (var i = 0; i < rdbObjArr.length; ++i)
		{
			if ((!rdbObjArr[i].disabled) && rdbObjArr[i].checked)
			{
				value = rdbObjArr[i].value;
				break;
			}
		}
	return value;
}
function radioObjWithValueSelect (rbjObjName, valueToSelect)
{
	var rdbObjArr = document.getElementsByName (rbjObjName);
	if (rdbObjArr.length < 1) return;
	var value = null;
	for (var i = 0; i < rdbObjArr.length; ++i)
	{
		if (rdbObjArr[i].value == valueToSelect)
		{
			rdbObjArr[i].checked = true;
			break;
		}
	}
	return;
}
function radGroupFuncSet (radGrpName, funcName)
{
	if (!radGrpName)
	return;
		var rdbObjArr = document.getElementsByName (radGrpName);
	if (rdbObjArr.length < 1) return;
	for (var i = 0; i < rdbObjArr.length; ++i)
	{
		if (funcName)
			rdbObjArr[i].onclick = funcName;
		else
			rdbObjArr[i].onclick = function () {return;};
	}
	return;
}
function comboSelectedValueGet (selObjId)
{
	var selObj = document.getElementById (selObjId);
	if (!selObj || selObj.disabled) return null;
	return selObj.options[selObj.selectedIndex].value;
}
function comboSelectedIndexGet (selObjId)
{
	var selObj = document.getElementById (selObjId);
	if (!selObj || selObj.disabled) return null;
	return selObj.selectedIndex;
}
function comboValueSet (selObjId, selIdx)
{
	if (!selObjId || (selIdx == null)) return;
	var selObj = document.getElementById (selObjId);
	if (!selObj) return;
	selObj.selectedIndex = selIdx;
}
function optionValueSelect (selObjId, fldId)
{
	if (!selObjId || !fldId) return;
	var selObj = document.getElementById (selObjId);
	if (!selObj) return;
	var fldObj = document.getElementById (fldId);
	if (!fldObj || !(fldObj.value.length)) return;
	var valueToSelect = fldObj.value;
	var idx = 0;
	for (idx = 0; idx < selObj.options.length; ++idx)
	{
		if (selObj.options[idx].value == valueToSelect)
		break;
	}
	if (idx != selObj.options.length)
	selObj.selectedIndex = idx;
	return;
}
function optionTextSelect (selObjId, fldId)
{
	if (!selObjId || !fldId) return;
	var selObj = document.getElementById (selObjId);
	if (!selObj) return;
	var fldObj = document.getElementById (fldId);
	if (!fldObj || !(fldObj.value.length)) return;
	var valueToSelect = fldObj.value;
	var idx = 0;
	for (idx = 0; idx < selObj.options.length; ++idx)
	{
		if (selObj.options[idx].text == valueToSelect)
		break;
	}
	if (idx != selObj.options.length)
	selObj.selectedIndex = idx;
	return;
}
function umiActionIdChange (umiActionObjId, umiActionId)
{
	var umiActionObj = document.getElementById(umiActionObjId);
	var actionStr = umiActionObj.name;
	var newStr = actionStr.substring (0, (actionStr.lastIndexOf (".") + 1));
	umiActionObj.name = newStr + umiActionId;
	return true;
}
function umiActionIdChangeSelWrapper (umiActionObjId, selObj)
{
	if (!umiActionObjId || !selObj) return false;
	return umiActionIdChange (umiActionObjId, selObj.options[selObj.selectedIndex].value);
}
/*
* isChkboxEnabled - This routine is used to check whether the given check box is enabled or not.
*
* Input args:
* idArr - check box id(s) list seperated by spaces.
* mode - checking mode
* 0 - all check box in the list should be enabled (default).
* 1 - any one of the check box in the list should be enabled.
* errMsg - Error message to display if the specified condition is not met.
*
* Returns:
* TRUE - if the specified condition met.
* FALSE - if the specified condition not met.
*/
function isChkboxEnabled (idArr, mode, errMsg)
{
	if (idArr == null)
	{
		alert(gettext ('isChkboxEnabled : Invalid arguments'));
		return false;
	}
	/* set default */
	if (mode == null)
	mode = 0;
	var returnValue = false;
	var fldIdArray = idArr.split (" ");
	for (idx in fldIdArray)
	{
		if (document.getElementById(fldIdArray[idx]).checked)
		{
			if (mode == 1) {
				returnValue = true;
				break;
			}
		}
		else
		{
			if (mode == 0) {
				returnValue = false;
				if (errMsg) alert (errMsg);
				break;
			}
		}
	}
	return returnValue;
}

/* display or hide field Start*/

function displayOrHideFields (hideFieldsLst,showFieldsLst)
    {
    if (hideFieldsLst && hideFieldsLst != "")
        {
        var fieldsArray = hideFieldsLst.split (" ");
        if (!fieldsArray || fieldsArray.length == 0) return;
        for (var idx = 0; idx < fieldsArray.length; idx++)
            {
            var trObj = document.getElementById("tr" + fieldsArray[idx]);
            if (trObj) trObj.className = "hide";
            }
        }
    if (showFieldsLst && showFieldsLst != "")
        {
        var fieldsArray = showFieldsLst.split (" ");
        if (!fieldsArray || fieldsArray.length == 0) return;
        for (var idx = 0; idx < fieldsArray.length; idx++)
            {
            var trObj = document.getElementById("tr" + fieldsArray[idx]);
            if (trObj) trObj.className = "show";
            }
        }
    }

/* display or hide field End*/

/********************************************************************
* accessLevelCheck - checks for access level of the user
*
* Checkes if user has administrative priviledges.
*
* RETURNS: true or false
*/

function accessLevelCheck ()
    {
    var accessLevel = document.getElementById ('hdUserPriv').value;
    if (!accessLevel || isNaN (accessLevel)) return true;
    if (parseInt (accessLevel, 10) != 0)
        {
        lblWarning.innerHTML = "Administrator privilages required"
        return false;
        }
    return true;
    }

/********************************************************************
* addRow - Add rows into table
*
*
*
* RETURNS:
*/
var tableRowCount = 2;
var pktTableRowCount = 2;

function addRow(tableId, chkEnable, firstTxtId,SecondTxtId, firstTxtValue, SecondTxtValue)
{
    var tbody = document.getElementById(tableId);
    tbody.align = "center";
    var idRowCount = tableRowCount;//tbody.rows.length - 1;
    var rowCount = tbody.rows.length;
    //alert(tableRowCount.toString());
    var row = tbody.insertRow(rowCount);	
    row.id = "list_" + idRowCount.toString();

    var cell1 = row.insertCell(0);
    var element1 = document.createElement("input");
    element1.type = "checkbox";
    element1.className = "submit";
    element1.id =  "listable_check" + idRowCount.toString();
    element1.name =  "listable_check" + idRowCount.toString();
    element1.checked = chkEnable;
    element1.disabled = false;
	//element2.style.height = "40";
	//element2.width = "40";
    //element1.setAttribute('onclick', "if(this.checked) { ip_reservstion_list('" + row.id + "', true); } else { ip_reservstion_list('" + row.id + "', false); }");

    cell1.appendChild(element1);

    var cell2 = row.insertCell(1);
	cell2.align = "center";
	cell2.style.verticalAlign = "middle";
	cell2.height = "34";
    var element2 = document.createElement("input");
    //alert(tbody.rows[0].cells[1].width.toString());
    //element2.width = tbody.rows[1].cells[1].width;
    element2.type = "text";
    element2.className = "box";
    element2.id =  firstTxtId + idRowCount.toString();
    element2.name =  firstTxtId + idRowCount.toString();
    element2.disabled = true;
    element2.value = firstTxtValue;
	element2.style.backgroundColor = "#F6F6F6";
	//element2.style.height = "40";
	element2.style.fontSize = "14px";
	element2.style.width = "210px";	
    //element2.setAttribute('onkeyup', "check_addr_text_isempty('" + firstTxtId + "','" + SecondTxtId + "','" + row.id + "');");
    cell2.appendChild(element2);

    var cell3 = row.insertCell(2);
	cell3.align = "center";
	cell3.style.verticalAlign = "middle";
	cell3.height = "34";
    var element3 = document.createElement("input");
    //alert(tbody.rows[0].cells[2].width.toString());
    //element3.width = tbody.rows[1].cells[2].width;
    element3.type = "text";
    element3.className = "box";
    element3.id =  SecondTxtId + idRowCount.toString();
    element3.name =  SecondTxtId + idRowCount.toString();
    element3.disabled = true;
    element3.value = SecondTxtValue;
	element3.style.backgroundColor = "#F6F6F6";
	//element3.style.height = "40";
	element3.style.fontSize = "14px";
	element3.style.width = "210px";	
    //element3.setAttribute('onkeyup', "check_addr_text_isempty('" + row.id + "');");
    cell3.appendChild(element3);
/*
    var cell4 = row.insertCell(3);
    var element4 = document.createElement("input");
    element4.type = "button";
    element4.className = "submit_s";
    element4.id =  "editlist" + idRowCount.toString();
    element4.name =  "editlist" + idRowCount.toString();
    element4.value="Edit";
    element4.disabled = false;
    element4.setAttribute('onclick', "edit_mac_ip_addr('" + row.id + "','" + firstTxtId + "','" + SecondTxtId + "',this.value);");
    cell4.appendChild(element4);

    var element5 = document.createElement("input");
    element5.type = "button";
    element5.className = "submit_s";
    element5.id =  "deletelist" + idRowCount.toString();
    element5.name =  "deletelist" + idRowCount.toString();
    element5.value="Delete";
    element5.disabled = true;
    element5.setAttribute('onclick', "deleteRow('listable', this.id);");
    cell4.appendChild(element5);
*/
    tableRowCount++;
}

function addPacketFilterRow(tableId, chkEnable, Ip_addr,Protocol, start_port, end_port, txt_Descrip, valIpAddr,valProtocol)
{
    var tbody = document.getElementById(tableId);
    tbody.align = "center";
    var idRowCount = pktTableRowCount;//tbody.rows.length - 1;
    var rowCount = tbody.rows.length;
    //alert(tableRowCount.toString());
    var row = tbody.insertRow(rowCount);	
    row.id = "list_" + idRowCount.toString();

    var cell1 = row.insertCell(0);
    var element1 = document.createElement("input");
    element1.type = "checkbox";
    element1.className = "submit";
    element1.id =  "listable_check" + idRowCount.toString();
    element1.name =  "listable_check" + idRowCount.toString();
    element1.checked = chkEnable;
    element1.disabled = false;
	//element2.style.height = "40";
	//element2.width = "40";
    //element1.setAttribute('onclick', "if(this.checked) { ip_reservstion_list('" + row.id + "', true); } else { ip_reservstion_list('" + row.id + "', false); }");

    cell1.appendChild(element1);

    var cell2 = row.insertCell(1);
	cell2.align = "center";
	cell2.style.verticalAlign = "middle";
	cell2.height = "34";
    var element2 = document.createElement("input");
    //alert(tbody.rows[0].cells[1].width.toString());
    //element2.width = tbody.rows[1].cells[1].width;
    element2.type = "text";
    element2.className = "box";
    element2.id =  firstTxtId + idRowCount.toString();
    element2.name =  firstTxtId + idRowCount.toString();
    element2.disabled = true;
    element2.value = firstTxtValue;
	element2.style.backgroundColor = "#F6F6F6";
	//element2.style.height = "40";
	element2.style.fontSize = "14px";
	element2.style.width = "210px";	
    //element2.setAttribute('onkeyup', "check_addr_text_isempty('" + firstTxtId + "','" + SecondTxtId + "','" + row.id + "');");
    cell2.appendChild(element2);

    var cell3 = row.insertCell(2);
	cell3.align = "center";
	cell3.style.verticalAlign = "middle";
	cell3.height = "34";
    var element3 = document.createElement("input");
    //alert(tbody.rows[0].cells[2].width.toString());
    //element3.width = tbody.rows[1].cells[2].width;
    element3.type = "text";
    element3.className = "box";
    element3.id =  SecondTxtId + idRowCount.toString();
    element3.name =  SecondTxtId + idRowCount.toString();
    element3.disabled = true;
    element3.value = SecondTxtValue;
	element3.style.backgroundColor = "#F6F6F6";
	//element3.style.height = "40";
	element3.style.fontSize = "14px";
	element3.style.width = "210px";	
    //element3.setAttribute('onkeyup', "check_addr_text_isempty('" + row.id + "');");
    cell3.appendChild(element3);
/*
    var cell4 = row.insertCell(3);
    var element4 = document.createElement("input");
    element4.type = "button";
    element4.className = "submit_s";
    element4.id =  "editlist" + idRowCount.toString();
    element4.name =  "editlist" + idRowCount.toString();
    element4.value="Edit";
    element4.disabled = false;
    element4.setAttribute('onclick', "edit_mac_ip_addr('" + row.id + "','" + firstTxtId + "','" + SecondTxtId + "',this.value);");
    cell4.appendChild(element4);

    var element5 = document.createElement("input");
    element5.type = "button";
    element5.className = "submit_s";
    element5.id =  "deletelist" + idRowCount.toString();
    element5.name =  "deletelist" + idRowCount.toString();
    element5.value="Delete";
    element5.disabled = true;
    element5.setAttribute('onclick', "deleteRow('listable', this.id);");
    cell4.appendChild(element5);
*/
    pktTableRowCount++;
}

/********************************************************************
* deleteRow - Remove row from table
*
*
*
* RETURNS:
*/
function deleteRow(tableID, id)
{
     try {
        var table = document.getElementById(tableID);
        var rowCount = table.rows.length;

        for(var i=0; i<rowCount; i++)
        {
            var row = table.rows[i];
            var delList = row.cells[3].lastChild.id;

            if( delList && delList == id )
            {
                table.deleteRow(i);
                rowCount--;
                i--;
                break;
            }

        }
    }
    catch(e)
    {
        alert(e);
    }
}

function check_addr_text_isempty(ParentId)
{
    var enableEdit = false;
    var ElementItem = document.getElementById(ParentId);
    var ElementText = ElementItem.getElementsByClassName('box');

    var len = 0;

    for (len = 0; len < ElementText.length; len++) {
        var subItem = ElementText[len];
        if(subItem.value.length != 0 )
            enableEdit = true
        //window.alert(enableEdit.toString());
    }

    for (len = 0; len < ElementButton.length; len++) {
            var subItem = ElementButton[len];
            if(subItem.value == "Apply" && enableEdit == false)
                subItem.value = "Edit";

            subItem.disabled = !enableEdit;
        }
}

function edit_mac_ip_addr(listId, firstTxtId, SecondTxtId, btnEditValue )
{
    var container = document.getElementById(listId);
    var Index = listId.split('_');
    var inputElements = container.getElementsByTagName('input');
    for (var Len = 0; Len < inputElements.length; Len++)
    {
        if(inputElements[Len].type == "checkbox")
            inputElements[Len].disabled = false;
        else
        {
          if(btnEditValue == "Apply")
          {
              if(inputElements[Len].value != "Apply")
                  inputElements[Len].disabled = true;
              else
                  inputElements[Len].value = "Edit";

              changeBkColor(firstTxtId +Index[1] , false);
              changeBkColor(SecondTxtId +Index[1] , false);
          }
          else
          {
              if(inputElements[Len].value != "Edit")
                  inputElements[Len].disabled = false;
              else
                  inputElements[Len].value = "Apply";
              changeBkColor(firstTxtId +Index[1] , true);
              changeBkColor(SecondTxtId +Index[1] , true);
          }
        }
    }
}

function empty_text(ParentId)
{
    var ElementItem = document.getElementById(ParentId);
    var ElementText = ElementItem.getElementsByClassName('box');
    var ElementButton = ElementItem.getElementsByClassName('submit_s');
    var len = 0;

    for (len = 0; len < ElementText.length; len++) {
        var subItem = ElementText[len];
        subItem.value = "";
    }
    for (len = 0; len < ElementButton.length; len++) {
        var subItem = ElementButton[len];
        if( subItem.value == "Edit" || subItem.value == "Apply")
        {
            subItem.value = "Apply";
            subItem.disabled = false;
        }
    }
    check_addr_text_isempty(ParentId);
}

function en_ip_reservation_checkbox(chkId, checked, NewTxtId1, NewTxtId2)
        {
            var container;
            var trElements;
            var strempty = "";
            container = document.getElementById('listable');
            trElements = document.getElementsByTagName('tr');
            document.getElementById(chkId).checked = checked;
            for (var trLen = 0; trLen < trElements.length; trLen++) {
                var subItems = trElements[trLen].getElementsByTagName('input');

                if(subItems.length > 0) {
                    for (var subtrLen = 0; subtrLen < subItems.length; subtrLen++) {
                        if(subItems[subtrLen].type=="checkbox" || subItems[subtrLen].value == "Edit"  || subItems[subtrLen].value == "Apply")
                            subItems[subtrLen].disabled = !checked;
                        else
                            subItems[subtrLen].disabled = true;
                    }

                }
            }
            document.getElementById(chkId).checked = checked;
            document.getElementById('add_new').disabled = !checked;
            document.getElementById(NewTxtId2).disabled = !checked;
            document.getElementById(NewTxtId1).disabled = !checked;
            document.getElementById('Apply').disabled = !checked;
            document.getElementById('discard').disabled = !checked;
        }

function changeBkColor(id, enable)
    {
        var col;
        if (!enable)
            col = "#EEE";
        else
            col = "#FFF";

            document.getElementById(id).style.backgroundColor = col;
            //document.getElementById(id).style.color = col;
    }

    function ip_reservstion_list(id, checked){
                        var container = document.getElementById(id);
                        var inputElements = container.getElementsByTagName('input');
                        for (var Len = 0; Len < inputElements.length; Len++)
                        {
                                //window.alert(inputElements[Len].type);
                                if(inputElements[Len].type != "checkbox")
                                {
                                        if(inputElements[Len].type == "button")
                                                {
                                                        if(inputElements[Len].name.indexOf("delete") >= 0)
                                                                inputElements[Len].disabled = !checked;
                                                        else if(inputElements[Len].name.indexOf("edit") >= 0)
                                                                inputElements[Len].disabled = !checked;
                                                        else
                                                                inputElements[Len].disabled = true;
                                                }
                                }
                        }

                }

function menuChange(menuItemId)
{
  var identity = document.getElementById(menuItemId);
  var menuItemId_href = menuItemId + '_href';
  if (menuItemId == 'home_menu') {
   document.getElementById('home_menu_img').src='../images/menu/Top_Menu_Home_Down.png';
  } else if (menuItemId == 'lte_menu') {
   document.getElementById('lte_menu_img').src='../images/menu/Top_Menu_Internet_Down.png';
  } else if (menuItemId == 'wifi_menu') {
   document.getElementById('wifi_menu_img').src='../images/menu/Top_Menu_Wifi_Down.png';
  } else if (menuItemId == 'lan_menu') {
   document.getElementById('lan_menu_img').src='../images/menu/Top_Menu_Lan_Down.png';
  } else if (menuItemId == 'adv_menu') {
   document.getElementById('adv_menu_img').src='../images/menu/Top_Menu_Advanced_Down.png';
  } else if (menuItemId == 'sys_menu') {
   document.getElementById('sys_menu_img').src='../images/menu/Top_Menu_System_Down.png';
  }

  document.getElementById(menuItemId_href).removeAttribute("href");
  document.getElementById(menuItemId_href).setAttribute("style", "color: #000000");

  identity = null;
  menuItemId_href = null;
}

function leftMenuChange(menuItemId1,menuItemId2)
{
	if(document.getElementById(menuItemId1))
 		document.getElementById(menuItemId1).setAttribute("class", "leftbuhover");
	if(document.getElementById(menuItemId2))
	{
 		//document.getElementById(menuItemId2).removeAttribute("href"); //temp
 		document.getElementById(menuItemId2).setAttribute("style", "color: #02c1f7; font-size: 16px; font-weight:bold");
	}
}

function leftSubMenuChange(submenuId1,submenuId2,menuItemId1,menuItemId2)
{
	if(document.getElementById(submenuId1))
	{
 		document.getElementById(submenuId1).style.display = "block";
 		//document.getElementById(submenuId2).setAttribute("class", "leftbuhover");
		if (menuItemId1 != '')
		{
			document.getElementById(menuItemId1).setAttribute("class", "ddbuhover");
		}
	}
	if(document.getElementById(menuItemId2))
	{
		if (menuItemId2 != '')
		{
			//document.getElementById(menuItemId2).removeAttribute("href"); //temp
			document.getElementById(menuItemId2).setAttribute("style", "color: #02c1f7; font-size: 16px; font-weight:bold");
		}
	}
}

/* show loading animation */
var block=false;
function blockUI()
{
	if(document.getElementById('progressMask') && block != true)
	{
		var mask = document.getElementById('progressMask');
		var popup = document.getElementById('progressImg');
		block = true;
		mask.style.display = "block";
		popup.style.display = "block";
	}
}
function unblockUI()
{
	if(document.getElementById('progressMask'))
	{
		var mask = document.getElementById('progressMask');
		var popup = document.getElementById('progressImg');
		block = false;
		mask.style.display = "none";
		popup.style.display = "none";
	}
}

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
};

key_num = function (e) 
{
    if (window.event) // IE
	{ 
        return window.event.keyCode;
    } 
	else if (e.which) // Netscape/Firefox/Opera
	{ 
        return e.which;
    }
    return null;
}

onkeypress_number_only = function(e) 
{
    var keynum;
    var keychar;
    var numcheck;

    keynum = key_num(e);
    if (keynum == 8 || !keynum) 
	{
        return true;
    }
    keychar = String.fromCharCode(keynum);
    numcheck = /\d/;
    return numcheck.test(keychar);
}

function check_ip_format()
{

	pattern = /^(\d{1,3}\.){3}\d{1,3}$/g;
	elem.value = x.match(pattern) ? x.match(pattern) : "";

}

check_ip_format = function(el)
{
	var pattern = /^(\d{1,3}\.){3}\d{1,3}$/g;		
	if (el.value.match(pattern))
		return true;
	else
		return false;
}
keypress_ip_format = function(e) 
{
    var keynum;
    var keychar;
    var numcheck;

    keynum = key_num(e);
    if (keynum == 8 || !keynum) 
	{
        return true;
    }
    keychar = String.fromCharCode(keynum);
    numcheck = /[0-9.]/;
    return numcheck.test(keychar);
}

function check_domain_name(domain)
{
	var domain_name = domain;
	var domain_name_replace = domain.replace(".", "");
	var str = encodeURIComponent(domain_name);
	var	len = str.replace(/%[A-F\d]{2}/g, 'U').length;
	var arr = domain_name.split(".");
	var num = /^\d*$/;
	var check_name_flag = false;
	for(var i=0;i<arr.length;i++)
	{
		if(arr[i].length == 0)
		{
			check_name_flag = true;
			break;
		}
	}
	/*if(domain_name == "")
	{
		alert("The Domain Name can not be empty.");
		return false;
	}
	else */
	if(num.test(domain_name.substr(0, 1)))
	{
		alert(gettext("The first character of Domain Name cannot be a number."));
		return false;
	}
	else if(domain_name.length == domain_name_replace.length)
	{
		alert(gettext('The Domain Name should include the "." sign.'));
		return false;
	}
	else if(check_name_flag == true)
	{
		alert(gettext('Failed to set Domain Name, the first character after \".\" can not be null.'));
		return false;
	}
	else if(domain_name.length == 1 && domain_name == ".")
	{
		alert(gettext('The Domain Name should contain alphanumeric characters and the "." sign.'));
		return false;
	}
	else if(domain_name.substr(0, 1) == ".")
	{
		alert(gettext("The first character cannot be \".\""));
		return false;
	}
	else if(domain_name.length!=len)
	{
		alert(gettext('Invalid value! Please input [0-9, a-z, A-Z, "."].'));
		return false;
	}
	else
	{
		return true;				
	}
}

check_ascii = function(el)
{
    for(var i = 0 ; i < el.value.length ; i++) 
	{
        var ch = el.value.charCodeAt(i);
        if (ch > 126 || ch < 32) 
		{
           return false;
        }
    }
    return true;	
}

keypress_ascii = function(e) 
{
    var keynum;
    keynum = key_num(e);
    if (keynum == 8 || !keynum) 
	{
        return true;
    }

	if (keynum > 126 || keynum < 32)
	{
		return false;
	}
	return true;
}


function isLocalFirmwareSelected(objId,exten,flag,mode)
{
	var fileObj = document.getElementById(objId);
	if(!fileObj.disabled) /* if not disabled */
	{
		var filenamepath = fileObj.value;
		var ext = fileObj.value;
		ext = ext.substring(ext.lastIndexOf('.')+1,ext.length);
		ext = ext.toLowerCase();

		if(exten == "none")
		{
		    var Objdevice_img = confirm(gettext("The Device is going to start the upgrade process.") + gettext("Click OK to continue else click Cancel.\n") + gettext("After rebooting, please clear your browser history."));
	        if (Objdevice_img){
				document.SYSTEM_FW_UPGRADE.action = "/cgi-bin/upload.cgi";
				document.getElementById("mainMenu1").style.display="none";
				document.getElementById("mainMenu2").style.display="none";
				document.getElementById("left_bg").style.display="none";
				document.getElementById("contentBg").style.display="none";
    			document.getElementById("fullpagemsg_table").style.display="block";
    			document.getElementById("waitmsg").style.display="block";
				document.SYSTEM_FW_UPGRADE.submit();
	        }else{
	        	return false;
	        }
		}else{
		/*
		if (ext.length > 4)
		{
			
			var i18n_selecta = gettext("please select a .");
		
			var i18n_file = gettext(" file");

			if (mode == "0"){
     		    alert(i18n_selecta+"cpt"+i18n_file);
			}else{
			  	alert(i18n_selecta+"img or .cpt"+i18n_file);
			}
			return false;
		}
		else if(ext != exten)
		{
			//alerT("ext="+ext+"\n exten="+exten);
			var i18n_youSelect = gettext("You selected a .");
			
			var i18n_pleaseSelect = gettext(" file; please select a .");
			
			var i18n_fileInstead = gettext(" file instead!");

			var i18n_dontSelect = gettext("You don't select a file; please select a .");
			
			if (ext != "cpt")
			{
			  	if (mode == "0")
			  	{
			  		if(ext.length == 0)
						alert(i18n_dontSelect+"cpt"+i18n_fileInstead);
					else
    					alert(i18n_youSelect+ext+i18n_pleaseSelect+"cpt"+i18n_fileInstead);
			  	}
			  	else
			  	{
			  		if(ext.length == 0)
						alert(i18n_dontSelect+"img or .cpt"+i18n_fileInstead);
					else
			    		alert(i18n_youSelect+ext+i18n_pleaseSelect+"img or .cpt"+i18n_fileInstead);
    		  	}	
			  	return false;
			}  
		}
		else if (ext == "zip")
		{
			//alert(filenamepath);
			var filename = filenamepath.substring(filenamepath.lastIndexOf("\\")+1,filenamepath.length);
			//alert(filename);
			//alert(filename.substring(0,7));
			/*if (filename.substring(0,6) == "D16Q1_")
			{
				//alert("prefix test");
				return true;
			}
			else
			{
				alert("filename should be started with D16Q1_")
				return false;
			}
		}*/
		if(exten == "img" || exten == "cpt")
		{
		    var Objdevice_img = confirm(gettext("The Device is going to start the upgrade process.") + gettext("Click OK to continue else click Cancel.\n") + gettext("After rebooting, please clear your browser history."));
	        if (Objdevice_img){
				document.SYSTEM_FW_UPGRADE.action = "/cgi-bin/upload.cgi";
				document.getElementById("mainMenu1").style.display="none";
				document.getElementById("mainMenu2").style.display="none";
				document.getElementById("left_bg").style.display="none";
				document.getElementById("contentBg").style.display="none";
    			document.getElementById("fullpagemsg_table").style.display="block";
    			document.getElementById("waitmsg").style.display="block";
				document.SYSTEM_FW_UPGRADE.submit();
	        }else{
	        	return false;
	        }
		}
		if(exten == "zip")
		{
		    var Objdevice_zip = confirm(gettext("The Device is going to start the upgrade process.") + gettext("Click OK to continue else click Cancel.\n") + gettext("After upgrade module firmware, please clear your browser history."));
	        if (Objdevice_zip){
				document.MODULE_FW_UPGRADE.action = "/cgi-bin/uploadMD.cgi";
				document.getElementById("mainMenu1").style.display="none";
				document.getElementById("mainMenu2").style.display="none";
				document.getElementById("left_bg").style.display="none";
				document.getElementById("contentBg").style.display="none";
    			document.getElementById("fullpagemsg_table").style.display="block";
    			document.getElementById("waitmsg").style.display="block";
				document.MODULE_FW_UPGRADE.submit();
	        }else{
	        	return false;
	        }
		}
		return true;
	  }	
	}
	else
		return true;
}
function deviceReboot()
{
	
}
function editAllow (tableId)
{
	if (!tableId) 
		return false;
	var objArr = document.getElementById(tableId).getElementsByTagName("INPUT");
	if (!objArr.length) 
		return false;
	/* allow if atleast one checkbox is checked */
	var count = 0;
	var index = -1;
	for (var i = 0; i < objArr.length; i++)
	{
	    if (objArr[i].type == 'checkbox' && objArr[i].checked && !objArr[i].disabled)
	    {
	        if (objArr[i].id != objArr[0].id)
			{
	            count = count + 1;
				index = i;
	        }
	    }
	}
	if(count != 0 && count == 1)
	    return index;
	else
	    alert (gettext("Please select a row to be edited."));
	return false;
}

function deleteAllow1 (tableId)
{
	if (!tableId) 
		return false;
	var objArr = document.getElementById(tableId).getElementsByTagName("INPUT");
	if (!objArr.length) 
		return false;
	/* allow if atleast one checkbox is checked */
	for (var i = 0; i < objArr.length; i++)
		if (objArr[i].type == 'checkbox' && objArr[i].checked && !objArr[i].disabled)
			if (objArr[i].id != objArr[0].id)
				return true;
	/*
	if (objArr[i].type == 'radio' && objArr[i].checked && !objArr[i].disabled)
	return true;
	*/
	
	alert (gettext('Please select items from the list to be deleted.')); 
	return false;
}

function secChkBoxSelectOrUnselectAll (sectionId, fldName, chkObj)
{
	if (!sectionId || !fldName) 
		return;
	secObj = document.getElementById(sectionId);
	if (!secObj) 
		return;
	objArr = secObj.getElementsByTagName("INPUT");
	if (!objArr) 
		return;
	if (chkObj)
	{
	    for (i=0; i < objArr.length; i++)
	    {
	    	if (objArr[i].type == 'checkbox' && !objArr[i].disabled)
	    	{
	    		if (chkObj.id == "imgSelectAll")
			 		objArr[i].checked = true;
			 	else if (chkObj.id == "imgSelectAllPlay")
			 	{			 		
			 		objArr[i].checked = true;
			 	}
			 	else if (chkObj.id == "imgUnCheckAll")
			 		objArr[i].checked = false;
			 	else if (chkObj.id == "imgUnCheckAllPlay")
			 		objArr[i].checked = false;
		 		}
		 	}			
		/* Change icon */
		if (chkObj.id == "imgSelectAll")
		{
			chkObj.src = "images/iconX.png";
			chkObj.id = "imgUnCheckAll"
			chkObj.title = "Deselect All"
		}
		else if (chkObj.id == "imgSelectAllPlay")
		{
			chkObj.src = "images/iconX.png";
			chkObj.id = "imgUnCheckAllPlay"
			chkObj.title = "Deselect All"
		}		
		else if (chkObj.id == "imgUnCheckAll")
		{
			chkObj.src = "images/iconY.png";
			chkObj.id = "imgSelectAll"
			chkObj.title = "Select All"
		}
		else if (chkObj.id == "imgUnCheckAllPlay")
		{
			chkObj.src = "images/iconY.png";
			chkObj.id = "imgSelectAllPlay"
			chkObj.title = "Select All"
		}
	 }
	else
	{
		for (i=0; i < objArr.length; i++)
		{
			if (objArr[i].type == 'checkbox' && !objArr[i].disabled)
			{
				objArr[i].checked = false;
			}
		}			
	}
 	return;
}

/* [0-9],[a-z],[A-Z],'_','-','.' and '@' */
function checkCommonNameField(fieldId, fieldTitle, fieldErrMsg)
{
	var errStr = gettext("Only allow to input [a-z], [A-Z], [0-9], '_', '-', '.' and '@' characters.");
	var errStr2 = gettext("The first character cannot be '_', '-', '.' or '@'.");
	var pattern = /^[a-zA-Z0-9-_@\.]+$/;

	var field = document.getElementById(fieldId).value;
 var field_first = field.substr(0, 1);
 if((field_first == '_') || (field_first == '-') || (field_first == '.') || (field_first == '@'))
 {
			alert(fieldTitle + ": " + errStr2);
			return false;
 }
	if (!pattern.test(field))
	{
		if (fieldErrMsg)
			alert(fieldTitle + ": " + fieldErrMsg);
		else
			alert(fieldTitle + ": " + errStr);
		return false;
	}
	return true;
}

//field: 0 or more
function checkDescriptionField(fieldId, fieldTitle)
{
	var errStr = gettext("Semicolon, Single Quote and Double Quote characters are not supported for this field.");

	var field = document.getElementById(fieldId).value;
 for(var i = 0 ; i < field.length ; i++) {
   var ch = field.charCodeAt(i);
   if (ch == 34 || ch == 39 || ch == 59)
   {
     alert(fieldTitle + ": " + errStr);
     return false;
   }
 }
	return true;
}

var popwindow;
function pop(url)
{ popwindow=window.open(url,'name','height=400,width=500,left=100,top=100,resizable=no,scrollbars=yes,toolbar=no,status=no');
if (window.focus) {popwindow.focus()}
}

function checkFieldExist(tableName, prefixName, fieldName, action, errName, errCause)
{
	if (action=="add")
		return false;
	
	var tableLength=document.getElementById(tableName).getElementsByTagName("INPUT").length;	
	//row 0: title bar
	for (var i=1; i<tableLength; i++)
	{
		var idx=prefixName+i;
		var name=document.getElementById(idx).innerHTML;
		if (fieldName==name)
		{
			var errMsg="";
			if (action=="edit")						
			{
				errMsg="The" + " " + errName + " " + fieldName + " cannot be edited.\n" +
					errCause+ " " + "is in use.";							
			}
			else if (action=="delete")
			{	
				errMsg="The" + " " + errName + " " + fieldName + " cannot be deleted.\n" +
					errCause + " " + "is in use.";							
			}
			document.getElementById('statusMsg').innerHTML=errMsg;
			alert(errMsg);		
			return true;
		}
	}
	return false;
}

function isBlank(s)
{	
	for (var i=0;i<s.length;i++)	
	{		
		c=s.charAt(i);		
		if ((c!=' ') && (c!='\n') && (c!='\t'))			
			return false;	
	}	
	return true;
}

function isSpace(s)
{
    var j,x = 0;
    for (var i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (c == ' ')
        {
            return true;
        }
    }
}

function isValidName(name)
{
	var i = 0;	

	for(i=0;i<name.length;i++)
	{
		if(isNameUnsafe(name.charAt(i)) == true)
			return false;
	}

	return true;
}

function isDecimal(s)
{
    var j,x = 0;

    for (var i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (c == '.')
        {
            return true;
        }
    }
}

function isNameUnsafe(compareChar)
{
	var unsafeString = "\"<>%\\^[]`\+\$\,='#&:\t";

	if(unsafeString.indexOf(compareChar) == -1 && compareChar.charCodeAt(0) > 32 && compareChar.charCodeAt(0) < 123 )
		return false; // found no unsafe chars, return false
	else
		return true;
}   

function yearCheck(obj)
{
	var i18n_enterValidYear = gettext("Please enter a valid year");
	
	var i18n_yr4Format = gettext("Please enter year in 4 digits Format: '2010'");
	
	if (!obj || isNaN(obj.value))
	{
		alert (i18n_enterValidYear);
		return false;
	}

	var yearVal = obj.value;
	if (yearVal.length != 4)
	{
		alert (i18n_yr4Format);
		return false;
	}

	var intYearVal = parseInt(obj.value, 10);
	if (intYearVal<1970 || intYearVal>2037)
	{
		alert(gettext("The Year value should be between 1970 and 2037."));
		return false;
	}

	return true;
	}

function monthCheck(obj)
{
	var i18n_enterValidMon = gettext("Please enter a valid month");
	var i18n_mon2Format = gettext("Please enter month in 2 digits Format: '06'");
	var i18n_invalidMonth = gettext("Invalid Month. ");

	if (!obj || isNaN(obj.value))
	{
		alert (i18n_enterValidMon);
		return false;
	}

	if (obj.value.length != 2)
	{
		alert (i18n_mon2Format);
		return false;
	}
		
	if (numericValueRangeCheck(obj, '', '', 1, 12, true, i18n_invalidMonth, '') == false)
		return false;
}
function isLeapYear(year)
{
    if ( ( (year%4==0)&&(year%100 != 0) ) || (year%400==0) ) 
	   return true;
	return false;
}

function dateCheck(obj)
{
	var i18n_enterValidDay = gettext("Please enter a valid day");
	var i18n_day2Format = gettext("Please enter day in 2 digits Format: '02'");
	var i18n_invalidDay = gettext("Invalid Day. ");
	var i18n_forMonFeb = gettext("for the month February");
	var i18n_forFebLeap = gettext("for the month February in a Leap Year");
	var i18n_forMonJMMJAOD = gettext("for months January, March, May, July, August, October, December");
	var i18n_forMonsAJSN = gettext("for months April, June, September, November");

	if (!obj || isNaN(obj.value))
	{
		alert (i18n_enterValidDay);
		return false;
	}

	var dateVal = obj.value;
	if (dateVal.length != 2)
	{
		alert (i18n_day2Format);
		return false;
	}

	var monthObj = document.getElementById('txtMonth');
	if (!monthObj || monthObj.value == "" || isNaN(monthObj.value))
	{
		if (numericValueRangeCheck(obj, '', '', 1, 31, true, i18n_invalidDay, '') == false)
			return false;
	}
	else
	{
		var dayVal = parseInt(monthObj.value, 10);
		if (dayVal == 2)
		{
			var yearObj = document.getElementById('txtYear');
			if (!yearObj || yearObj.value == "" || isNaN(yearObj.value))
			{
				if (numericValueRangeCheck(obj, '', '', 1, 28, true, i18n_invalidDay, i18n_forMonFeb) == false)
					return false;
			}
			else
			{
				if (isLeapYear(parseInt(yearObj.value, 10)))
				{
					if (numericValueRangeCheck(obj, '', '', 1, 29, true, i18n_invalidDay, i18n_forFebLeap) == false)
						return false;
				}
				else
				{
					if (numericValueRangeCheck(obj, '', '', 1, 28, true, i18n_invalidDay, i18n_forMonFeb) == false)
						return false;
				}
			}
		}
		else if (dayVal == 1 || dayVal == 3 || dayVal == 5 || dayVal == 7 || dayVal == 8 || dayVal == 10 || dayVal == 12)
		{
			if (numericValueRangeCheck(obj, '', '', 1, 31, true, i18n_invalidDay, i18n_forMonJMMJAOD) == false)
				return false;
		}
		else
		{
			if (numericValueRangeCheck(obj, '', '', 1, 30, true, i18n_invalidDay, i18n_forMonsAJSN) == false)
				return false;
		}
	}

	return true;
}

function hoursCheck(obj)
{
	var i18n_enterValidHour = gettext("Please enter a valid hours");
	var i18n_hour2Format = gettext("Please enter hours in 2 digits Format: '06'");
	var i18n_invalidHours = gettext("Invalid Hours. ");
	if (!obj || isNaN(obj.value))
	{
		alert (i18n_enterValidHour);
		return false;
	}

	if (obj.value.length != 2)
	{
		alert (i18n_hour2Format);
		return false;
	}
		
	if (numericValueRangeCheck(obj, '', '', 0, 23, true, i18n_invalidHours, '') == false)
		return false;
}

function minutsCheck(obj)
{
	var i18n_enterValidMins = gettext("Please enter a valid minutes");
	var i18n_mins2Format = gettext("Please enter minutes in 2 digits Format: '06'");
	var i18n_invalidMins = gettext("Invalid Minutes. ");

	if (!obj || isNaN(obj.value))
	{
		alert (i18n_enterValidMins);
		return false;
	}

	if (obj.value.length != 2)
	{
		alert (i18n_mins2Format);
		return false;
	}
		
	if (numericValueRangeCheck(obj, '', '', 0, 59, true, i18n_invalidMins, '') == false)
		return false;
}

function secondsCheck(obj)
{
	var i18n_enterValidSecs = gettext("Please enter a valid seconds");
	var i18n_secs2Format = gettext("Please enter seconds in 2 digits Format: '06'");
	var i18n_invalidSecs = gettext("Invalid Seconds. ");

	if (!obj || isNaN(obj.value))
	{
		alert (i18n_enterValidSecs);
		return false;
	}

	if (obj.value.length != 2)
	{
		alert (i18n_secs2Format);
		return false;
	}
		
	if (numericValueRangeCheck(obj, '', '', 0, 59, true, i18n_invalidSecs, '') == false)
		return false;
}

(function() {
  var global = this;
  if (typeof COMPS == 'undefined') {
    global.COMPS = {};
  }
})();

COMPS.WIFI =
{
  onsubmit_ssid: function(el_ssid, el_ap)
  {
   if(el_ssid.value.length == 0)
   {
     alert(el_ap + " : " + gettext("The SSID is not allowed to be empty."));
     return false;
   }
   var pattern = /[\#]+$/;
   var field = el_ssid.value;
   if (pattern.test(field))
   {
    alert(el_ap + " : " + gettext("Invalid SSID."));
    return false;
   }
   return true;
 },
 onsubmit_wep: function(el_pass, el_ap, el_key_num)
 {
   if(el_pass.value.length == 0)
   {
     alert(el_ap + " : " + gettext("The WEP Key ") + el_key_num + gettext(" is not allowed to be empty."));
     return false;
   }
   return true;
 },
 onsubmit_wpa: function(el_pass, el_ap)
 {
   if(el_pass.value.length == 0)
   {
     alert(el_ap + " : " + gettext("The WPA Key is not allowed to be empty."));
     return false;
   }
   else if ((el_pass.value.length < 8) || (el_pass.value.length > el_pass.maxLength))
   {
     alert(el_ap + " : " + gettext("Invalid Encryption Key."));
     return false;
   }
   return true;
 }
}
