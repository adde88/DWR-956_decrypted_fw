// Memu_xxx  functions
function MM_swapImgRestore() { //v3.0
	var i,x,a=document.MM_sr;
	for (i=0; a && i<a.length && (x=a[i]) && x.oSrc;i++)
		x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
	var d=document;
	if (d.images)
	{
		if (!d.MM_p)
			d.MM_p=new Array();
		var i,j=d.MM_p.length,a=MM_preloadImages.arguments;
		for (i=0; i<a.length; i++)
			if (a[i].indexOf("#")!=0)
			{
				d.MM_p[j]=new Image;
				d.MM_p[j++].src=a[i];
			}
	}
}

function MM_findObj(n, d) { //v4.0
	var p,i,x;
	if (!d)
		d=document;
	if ((p=n.indexOf("?"))>0&&parent.frames.length)
	{
		d=parent.frames[n.substring(p+1)].document;
		n=n.substring(0,p);
	}
	if (!(x=d[n])&&d.all)
		x=d.all[n];
	for (i=0; !x && i<d.forms.length;i++)
		x=d.forms[i][n];
	for (i=0; !x && d.layers && i<d.layers.length; i++)
		x=MM_findObj(n,d.layers[i].document);
	if (!x && document.getElementById)
		x=document.getElementById(n);
	return x;
}

function MM_swapImage() { //v3.0
	var i,j=0,x,a=MM_swapImage.arguments;
	document.MM_sr=new Array;
	for (i=0; i<(a.length-2); i+=3)
		if ((x=MM_findObj(a[i])) != null)
		{
			document.MM_sr[j++]=x;
			if (!x.oSrc)
				x.oSrc=x.src;
			x.src=a[i+2];
		}
}

// Common function for variablies checking
function isBlank(s)
{
	for (i=0;i<s.length;i++)
	{
		c=s.charAt(i);
		if ((c!=' ') && (c!='\n') && (c!='\t'))
			return false;
	}
	return true;
}


function isNValidIP(s)
{
	if (isBlank(s)||isNaN(s)||s<0||s>255)
		return true;
	else
		return false;
}

function isNValidMask(mask)
{
  if (!isBlank(mask))
  {
    var digt_array=mask.split(".");
    var i=0;
    var prev_byte=255;
    var net_id=0;
    if (digt_array.length!=4)
    {
      return false;
    }
    for (i=0;i<4;i++)
    {
      if(isNaN(digt_array[i]))
      {
        return false;
      }
      if(net_id == 1 && digt_array[i]>0)
      {
        return false;
      }
      if (isBlank(digt_array[i]))
      {
        return false;
      }
      if(digt_array[i]<0 || digt_array[i]>255 || digt_array[i]>prev_byte)
      {
        return false;
      }
      if(digt_array[i]<prev_byte || digt_array[i]==0)
      {
        net_id = 1;
      }
      prev_byte=digt_array[i];
    }
  }
  return true;
}

function isHex(s)
{
	var j,x = 0;
	
	/*if (s.length != 12)
		return false;*/
		
	for (var i = 0; i < s.length; i++)
	{
		var c = s.charAt(i);
		if ((c < '0' || c > '9') && (c < 'a' || c > 'f') && (c < 'A' || c > 'F'))
			return false;
		
		j = parseInt(c,16);
		if (j<0 || j>15)
			return false;
	}
	
	/*if(parseInt(s,16) > 255 || parseInt(2,16) < 0 || isNaN(parseInt(s,16)))
		return false;	*/

return true;
}

function isNValid(s)
{
	if(isBlank(s) || !isHex(s))
		return true;
	else
		return false;
}

function isNValidPort(s)
{
	if (isBlank(s) || isNaN(s) || s>65535 || s<1)
		return true;
	else
		return false;
} 
function isNValidRtpPort(s)
{
	if (isBlank(s) || isNaN(s) || s>65535 || s<1024)
		return true;
	else
		return false;
}
function isNValidSIPPort(s)
{
       if ( s == 0)
           return false;

	if (isBlank(s)||isNaN(s)||s<1024||s>65535)
		return true;
	else
		return false;
}
function getObject(elementId)
{
	var theElement=null;
	if (document.getElementById) {
		theElement = document.getElementById (elementId);
	}else if (document.all)
	{
		theElement = document.all [elementId];
	}
	return theElement;
}

function isNValidIPs(ip,isSubnet)
{
	if (isSpace(ip))
        {
            return false;
        }
        if ( ip == '0.0.0.0' || ip == '255.255.255.255'  || ip == '127.0.0.1')
        return false;
        if (!isBlank(ip))
	{
		var digt_array=ip.split(".");
		var i=0;
		if (digt_array.length!=4)
		{
			return false;
		}
		for (i=0;i<4;i++)
		{
			if(i==0 && (digt_array[i]==0 || digt_array[i]>223))
                        return false;  
                        if (isBlank(digt_array[i]))
			{
				return false;
			}
			if (isNValidIP(digt_array[i]))
			{
				if (!(isSubnet=="2" && (digt_array[i]==0 || digt_array[i]==255)))
				{
					return false;
				}
			}
                        if((isSubnet=="1" || isSubnet=="*") && i==3 && (digt_array[i]==0 || digt_array[i]==255))
                        return false;
		}
	}
	return true;
}

function isNValidmac(mac)
{
	if (isSpace(mac))
  {
        return true;
  }
  if (!isBlank(mac))
	{
		var digit_array=mac.split(":");
		var i=0;
    var macAddr="";
		if (digit_array.length!=6)
		{
			return true;
		}
		for (i=0;i<6;i++)
		{
       macAddr += digit_array[i];
    }
    if (isBlank(macAddr)) { return true;}
  	if (isNValid(macAddr)) {	return true;} 
	  if (!isHex(macAddr))  { return true;}
  } 
	return false;
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
function isNValidRegExpTime(s)
{
    if (isBlank(s)||isNaN(s)||s<100||s>32768||isDecimal(s))
        return true;
    else
        return false;
}

function isNAN(s)
{
  var numeric = s;
	for(var j=0; j<numeric.length; j++)
	{
	  var alpha = numeric.charAt(j);
		var hh = numeric.charCodeAt(j);

 		if((hh > 47 && hh<58))
    {
    }
    else{
      return false;
	  }
	}
	return true;
}

function validateIP(inputStr) {
  var validChars = '.0123456789';

	if (!inputStr)
     return false;

	dots = 0;

  for (var i = 0; i < inputStr.length; i++) {
    var chr = inputStr.substring(i,i+1);
    if (validChars.indexOf(chr) == -1)
      return false;
    if (chr == '.') {
      dots++;
      eval('dot' + dots + ' = ' + i);
	  }
																									     }
	  if (dots != 3)
      return false;

    if (inputStr.substring(0,1) == '.' || inputStr.substring(inputStr.length,inputStr.length+1) == '.')
      return false;

    ip1 = inputStr.substring(0,dot1);
    if (!ip1 || ip1 >255)
      return false;
    ip2 = inputStr.substring(dot1+1,dot2);
	    if (!ip2 || ip2 >255)
        return false;
    ip3 = inputStr.substring(dot2+1,dot3);
	    if (!ip3 || ip3 >255)
        return false;
    ip4 = inputStr.substring(dot3+1,inputStr.length+1);
	    if (!ip4 || ip4 >255)
        return false;

    if (ip1 == 0 && ip2 == 0 && ip3 == 0 && ip4 == 0)
       return false;
  return true;
}

function validateDomain(nname)
{
  var mai = nname;
	var val = true;

	var dot = mai.lastIndexOf(".");
	var dname = mai.substring(0,dot);
	var ext = mai.substring(dot,mai.length);

	if(dot>2 && dot<57)
	{
	  for(var j=0; j<dname.length; j++)
	  {
			var dh = dname.charAt(j);
			var hh = dh.charCodeAt(0);
			if((hh > 47 && hh<59) || (hh > 64 && hh<91) || (hh > 96 && hh<123) || hh==45 || hh==46)
			{
			  if((j==0 || j==dname.length-1) && hh == 45)
				{
				  //alert("Domain name should not begin or end with '-'");
				  return false;
				}
			}
			else {
				//alert("Your domain name should not have special characters");
				return false;
			}
		}
	}
	else
	{
	  //alert("Your Domain name is too short/long");
	  return false;
	}

	return true;
}


function isValidIPorDomain(s)
{
  var numeric = s;
	for(var j=0; j<numeric.length; j++)
	{
	  var alpha = numeric.charAt(j);
		var hh = numeric.charCodeAt(j);

		if((hh > 47 && hh<59) || (hh > 64 && hh<91) || (hh > 96 && hh<123) || (alpha == '.'))
		{
		}
		else{
		  return false;
		}
	}
	return true;
}


function ChangeSystemForm()
{
	var selForm = document.tF0.option.selectedIndex;
	switch (selForm)
	{
	    case 0:
	  location = "voip_sip_stun.asp"
  	  break;
      case 1:
	  location = "voip_sip_callbar.asp"
  	  break;
      case 2:  	  
	  location = "voip_sip_countryset.asp"
  	  break;
      case 3:  	  
	  location = "voip_sip_rtp.asp"
  	  break;
      case 4:  	  
	  location = "voip_sip_param.asp"
  	  break;
      case 5:  	  
	  location = "voip_sip_dialplan.asp"
  	  break;  	
//  	case 6:  	  
//	  location = "voip_sip_dspfw.asp"
//  	  break;  
      case 6:
	  location = "voip_sip_gwmode.asp"
  	  break;
      case 7:
	  location = "voip_sip_t38.asp"
  	  break;
      case 8:
	  location = "voip_sip_ver.asp"
  	  break;
      case 9:
	  location = "voip_sip_debug.asp"
  	  break;  	    	  
      case 10:
	  location = "voip_system.asp"
  	  break;  	    	  
       	    	  
	}
	

  return true;
}

function ChangeLineForm()
{
	var selForm = document.tF0.option.selectedIndex;
	switch (selForm)
	{
	case 0:
	  location = "voip_sip_linesettings.asp"
  	  break;
      case 1:
	  location = "voip_sip_user.asp"
  	  break;
      case 2:  	  
	  location = "voip_sip_vsc.asp"
  	  break;
      case 3:  	  
	  location = "voip_sip_addrbook.asp"
  	  break;
      case 4:  	  
	  location = "voip_sip_phone.asp"
  	  break;
      case 5:  	  
	  location = "voip_sip_cr.asp"
  	  break;  	
      case 6:  	  
	  location = "voip_sip_callbk.asp"
  	  break;  	
  	      
	}	

  return true;
}

function ChangeProfileForm()
{
	var selForm = document.tF0.option.selectedIndex;
	switch (selForm)
	{
	case 0:
	  location = "voip_sip_server.asp"
  	  break;
      case 1:
	  location = "voip_sip_jitter.asp"
  	  break;
      case 2:  	  
	  location = "voip_sip_rm.asp"
  	  break;
      case 3:  	  
	  location = "voip_sip_fax.asp"
  	  break;
      case 4:  	  
	  location = "voip_sip_vms.asp"
  	  break;
	}	

  return true;
}

function isNValidPorts(ports)
{
	if (!isBlank(ports))
	{
		var parray=ports.split(",");
		var i=0;
		for(i=0;i<parray.length;i++)
		{
			if(isNValidPort(parray[i]))
			{
				return false;
			}
		}
	}
	return true;
}

function isNameUnsafe(compareChar)
{
	var unsafeString = "\"<>%\\^[]`\+\$\,='#&:\t";

	if(unsafeString.indexOf(compareChar) == -1 && compareChar.charCodeAt(0) > 32 && compareChar.charCodeAt(0) < 123 )
		return false; // found no unsafe chars, return false
	else
		return true;
}   

function isValidPasswd(passwd)
{
        var unsafeString = "\"\\%`";
        var i = 0;
        for(i=0;i<passwd.length;i++)
        {
          if(!(unsafeString.indexOf(passwd.charAt(i)) == -1 && passwd.charAt(i).charCodeAt(0) > 32 && passwd.charAt(i).charCodeAt(0) < 123 ))
          return false;
        }
        return true;
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

function UnSafeChar(val)
{
   var i = 0;
   for(i=0; i<val.length; i++)
   {
      var ch = val.charAt(i);
      if(ch == '%')
      {
         return true;
      }
   }
   return false;
}
function isValidIP (IPvalue) {
errorString = "";
theName = "IPaddress";

var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
var ipArray = IPvalue.match(ipPattern);

if (IPvalue == "0.0.0.0")
errorString = errorString + theName + ': '+IPvalue+' is a special IP address and cannot be used here.';
else if (IPvalue == "255.255.255.255")
errorString = errorString + theName + ': '+IPvalue+' is a special IP address and cannot be used here.';
if (ipArray == null)
errorString = errorString + theName + ': '+IPvalue+' is not a valid IP address.';
else {
for (i = 1; i < 5; i++) {
thisSegment = ipArray[i];
if (thisSegment > 255) {
errorString = errorString + theName + ': '+IPvalue+' is not a valid IP address.';
i = 5;
}
if ((i == 0) && (thisSegment > 255)) {
errorString = errorString + theName + ': '+IPvalue+' is a special IP address and cannot be used here.';
i = 5;
      }
   }
}
extensionLength = 3;
if (errorString == "")
{
 return true;
}
else
{
 alert (errorString);
 return false;
}
}

function isValidDomain(nname)
{
var arr = new Array(
'.com','.net','.org','.biz','.coop','.info','.museum','.name',
'.pro','.edu','.gov','.int','.mil','.ac','.ad','.ae','.af','.ag',
'.ai','.al','.am','.an','.ao','.aq','.ar','.as','.at','.au','.aw',
'.az','.ba','.bb','.bd','.be','.bf','.bg','.bh','.bi','.bj','.bm',
'.bn','.bo','.br','.bs','.bt','.bv','.bw','.by','.bz','.ca','.cc',
'.cd','.cf','.cg','.ch','.ci','.ck','.cl','.cm','.cn','.co','.cr',
'.cu','.cv','.cx','.cy','.cz','.de','.dj','.dk','.dm','.do','.dz',
'.ec','.ee','.eg','.eh','.er','.es','.et','.fi','.fj','.fk','.fm',
'.fo','.fr','.ga','.gd','.ge','.gf','.gg','.gh','.gi','.gl','.gm',
'.gn','.gp','.gq','.gr','.gs','.gt','.gu','.gv','.gy','.hk','.hm',
'.hn','.hr','.ht','.hu','.id','.ie','.il','.im','.in','.io','.iq',
'.ir','.is','.it','.je','.jm','.jo','.jp','.ke','.kg','.kh','.ki',
'.km','.kn','.kp','.kr','.kw','.ky','.kz','.la','.lb','.lc','.li',
'.lk','.lr','.ls','.lt','.lu','.lv','.ly','.ma','.mc','.md','.mg',
'.mh','.mk','.ml','.mm','.mn','.mo','.mp','.mq','.mr','.ms','.mt',
'.mu','.mv','.mw','.mx','.my','.mz','.na','.nc','.ne','.nf','.ng',
'.ni','.nl','.no','.np','.nr','.nu','.nz','.om','.pa','.pe','.pf',
'.pg','.ph','.pk','.pl','.pm','.pn','.pr','.ps','.pt','.pw','.py',
'.qa','.re','.ro','.rw','.ru','.sa','.sb','.sc','.sd','.se','.sg',
'.sh','.si','.sj','.sk','.sl','.sm','.sn','.so','.sr','.st','.sv',
'.sy','.sz','.tc','.td','.tf','.tg','.th','.tj','.tk','.tm','.tn',
'.to','.tp','.tr','.tt','.tv','.tw','.tz','.ua','.ug','.uk','.um',
'.us','.uy','.uz','.va','.vc','.ve','.vg','.vi','.vn','.vu','.ws',
'.wf','.ye','.yt','.yu','.za','.zm','.zw');

var mai = nname;
var val = true;

var dot = mai.lastIndexOf(".");
var dname = mai.substring(0,dot);
var ext = mai.substring(dot,mai.length);
//alert(ext);

if (isNaN(ext))
{
	
if(dot>0 && dot<57)
{
	for(var i=0; i<arr.length; i++)
	{
	  if(ext == arr[i])
	  {
	 	val = true;
		break;
	  }	
	  else
	  {
	 	val = false;
	  }
	}
	if(val == false)
	{
	  	 alert("Your domain extension "+ext+" is not correct");
		 return false;
	}
	else
	{
		for(var j=0; j<dname.length; j++)
		{
		  var dh = dname.charAt(j);
		  var hh = dh.charCodeAt(0);
		  if((hh > 47 && hh<59) || (hh > 64 && hh<91) || (hh > 96 && hh<123) || hh==45 || hh==46)
		  {
			 if((j==0 || j==dname.length-1) && hh == 45)	
		  	 {
		 	  	 //alert("Domain name should not begin are end with '-'");
			      return false;
		 	 }
		  }
		else	
		  {
		  	 //alert("Your domain name should not have special characters");
			 return false;
		  }
		}
	}
}
else
{
 //alert("Your Domain name is too short/long");
 return false;
}
}
else
{
if(!isValidIP(nname))
return false;
}

return true;
}

function isValidSIPServiceProviderName(name)
{
		for(var j=0; j<name.length; j++)
		{
		  var dh = name.charAt(j);
		  var hh = dh.charCodeAt(0);
		  if((hh > 47 && hh<59) || (hh > 64 && hh<91) || (hh > 96 && hh<123) || hh==45 || hh==46)
		   {
			 if((j==0 || j==name.length-1) && hh == 45)
			  { 
			    alert("SIP Service Provider name should not begin or end with '-'");
			    return false;
			  }
		   }
		   else
		   {
		    alert("SIP Service Provider name should not have special characters");
			return false;
		   }
	    }
		
return true;
}

function isValidPhone(ph)
{
 for(var j=0; j<ph.length; j++)
   {
	var dh = ph.charAt(j);
	var hh = dh.charCodeAt(0);
	if(!((hh > 47 && hh<58)  || hh==43 || hh==32))
	  {
	   return false;
	  }
   }
 return true;
}

function isValidURL(url)
{
    var RegExp = /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/;
	if(RegExp.test(url))
	 {
	  return true;
	  }
	  else
	  {
	  return false;
	  }
} 

function isValidEmail(email)
{
   	var RegExp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
	if(RegExp.test(email))
	 {
	  return true;
	 }
	 else
	 {
	  return false;
	 }
} 

function isValidPrefix(ph)
{
 for(var j=0; j<ph.length; j++)
   {
	var dh = ph.charAt(j);
	var hh = dh.charCodeAt(0);
	if(!((hh > 47 && hh<58)  || hh==42 || hh==35 || hh==91 || hh==93 || hh==45 ))
	  {
	   return false;
	  }
   }
return true;
}
function scrollToElement(){

  if((document.body)&&(document.body.scrollTop || document.body.scrollLeft)){

   X = document.body.scrollLeft;
   Y = document.body.scrollTop;
  }else if((document.body.bodyElement)&&(document.body.bodyElement.scrollTop || document.bodyElement.scrollLeft)){
   
    X = document.body.bodyElement.scrollLeft;
    Y = document.body.bodyElement.scrollTop;
  
   }else if(window.pageXOffset || window.pageYOffset){
 
     X = window.pageXOffset;
     Y = window.pageYOffset;
    }
  top.XX = X;
  top.YY = Y;
}

function isHeaderUnsafe(compareChar)
{
  var unsafeString = "\"<>%\\^[]`\+\$\,='#&:\t";

  if(unsafeString.indexOf(compareChar) == -1 && compareChar.charCodeAt(0) > 31 && compareChar.charCodeAt(0) < 123 )
    return false; // found no unsafe chars, return false
  else
    return true;
}

function isValidHeader(name)
{
  var i = 0;

  for(i=0;i<name.length;i++)
  {
    if(isHeaderUnsafe(name.charAt(i)) == true)
      return false;
  }

  return true;
}

