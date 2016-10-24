<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
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

function initWifiInfo()
{
  var WifiRadio = <%getWifiRadioAC();%>;
  var RadioArr = WifiRadio.split("#");
  var Mode = RadioArr[0];
  var Channel = RadioArr[1];
  var Width = RadioArr[2];
  var Band = RadioArr[3];
  var Transmit = RadioArr[4];

  Channel = parseInt(Channel, 10);

  //Mode
  switch (Mode)
  {
  	case "a":
       document.getElementById("wifi_mode").selectedIndex=0;
       break;
    case "an":
       document.getElementById("wifi_mode").selectedIndex=1;
       break;
    case "ac":
       document.getElementById("wifi_mode").selectedIndex=2;
       break;
    default:
	   break;
  }

  if(Mode == "a"){   
  	//Channel Spacing: 20
  	document.getElementById("width1").style.display = "";       
	document.getElementById("width2").style.display = "none";
	document.getElementById("width3").style.display = "none";
	document.getElementById("wifi_width1").selectedIndex=0;
	//Channel
	document.getElementById("band20").style.display = "";
	document.getElementById("band80").style.display = "none";
	//Control Side Band
	document.getElementById("wifiband").style.display = "none";
	document.getElementById("band_above").style.display = "none";
	document.getElementById("band_below").style.display = "none";
	//Channel Display
	switch (Channel)
  	{
  	case 36:
       document.getElementById("wifi_channel20").selectedIndex=0;
       break;
    case 40:
       document.getElementById("wifi_channel20").selectedIndex=1;
       break;
    case 44:
       document.getElementById("wifi_channel20").selectedIndex=2;
       break;	
	case 48:
	   document.getElementById("wifi_channel20").selectedIndex=3;
       break;	
	/*case 52:
	   document.getElementById("wifi_channel20").selectedIndex=4;
       break;		
	case 56:
	   document.getElementById("wifi_channel20").selectedIndex=5;
       break;		
	case 60:
	   document.getElementById("wifi_channel20").selectedIndex=6;
       break;		
	case 64:
	   document.getElementById("wifi_channel20").selectedIndex=7;
       break;		
	case 100:
	   document.getElementById("wifi_channel20").selectedIndex=8;
       break;		
	case 104:
	   document.getElementById("wifi_channel20").selectedIndex=9;
       break;		
	case 108:
	   document.getElementById("wifi_channel20").selectedIndex=10;
       break;		
	case 112:
	   document.getElementById("wifi_channel20").selectedIndex=11;
       break;
	case 116:
	   document.getElementById("wifi_channel20").selectedIndex=12;
       break;		
	case 120:
	   document.getElementById("wifi_channel20").selectedIndex=13;
       break;		
	case 124:
	   document.getElementById("wifi_channel20").selectedIndex=14;
       break;		
	case 128:
	   document.getElementById("wifi_channel20").selectedIndex=15;
       break;		
	case 132:
	   document.getElementById("wifi_channel20").selectedIndex=16;
       break;		
	case 136:
	   document.getElementById("wifi_channel20").selectedIndex=17;
       break;		
	case 140:
	   document.getElementById("wifi_channel20").selectedIndex=18;
       break;		
	case 149:
	   document.getElementById("wifi_channel20").selectedIndex=19;
       break;		
	case 153:
	   document.getElementById("wifi_channel20").selectedIndex=20;
       break;		
	case 157:
	   document.getElementById("wifi_channel20").selectedIndex=21;
       break;		
	case 161:
	   document.getElementById("wifi_channel20").selectedIndex=22;
       break;		
	case 165:
	   document.getElementById("wifi_channel20").selectedIndex=23;
       break;
	*/   
    default:
	   break;
  	}
  }else if(Mode == "an"){  
    //Channel Spacing: 20, 2040
    document.getElementById("width1").style.display = "none";
	document.getElementById("width2").style.display = "";
	document.getElementById("width3").style.display = "none";
	if (Width == 20){  
	  document.getElementById("wifi_width2").selectedIndex=0;
	  //Channel
	  document.getElementById("band20").style.display = "";
	  document.getElementById("band80").style.display = "none";
	  //Control Side Band
	  document.getElementById("wifiband").style.display = "none";
	  document.getElementById("band_above").style.display = "none";
	  document.getElementById("band_below").style.display = "none";
	  switch (Channel)
      {
      case 36:
       document.getElementById("wifi_channel20").selectedIndex=0;
       break;
      case 40:
       document.getElementById("wifi_channel20").selectedIndex=1;
       break;
      case 44:
       document.getElementById("wifi_channel20").selectedIndex=2;
       break;	
      case 48:
         document.getElementById("wifi_channel20").selectedIndex=3;
       break;	
      /*case 52:
         document.getElementById("wifi_channel20").selectedIndex=4;
       break;		
      case 56:
         document.getElementById("wifi_channel20").selectedIndex=5;
       break;		
      case 60:
         document.getElementById("wifi_channel20").selectedIndex=6;
       break;		
      case 64:
         document.getElementById("wifi_channel20").selectedIndex=7;
       break;		
      case 100:
         document.getElementById("wifi_channel20").selectedIndex=8;
       break;		
      case 104:
         document.getElementById("wifi_channel20").selectedIndex=9;
       break;		
      case 108:
         document.getElementById("wifi_channel20").selectedIndex=10;
       break;		
      case 112:
         document.getElementById("wifi_channel20").selectedIndex=11;
       break;
      case 116:
         document.getElementById("wifi_channel20").selectedIndex=12;
       break;		
      case 120:
         document.getElementById("wifi_channel20").selectedIndex=13;
       break;		
      case 124:
         document.getElementById("wifi_channel20").selectedIndex=14;
       break;		
      case 128:
         document.getElementById("wifi_channel20").selectedIndex=15;
       break;		
      case 132:
         document.getElementById("wifi_channel20").selectedIndex=16;
       break;		
      case 136:
         document.getElementById("wifi_channel20").selectedIndex=17;
       break;		
      case 140:
         document.getElementById("wifi_channel20").selectedIndex=18;
       break;		
      case 149:
         document.getElementById("wifi_channel20").selectedIndex=19;
       break;		
      case 153:
         document.getElementById("wifi_channel20").selectedIndex=20;
       break;		
      case 157:
         document.getElementById("wifi_channel20").selectedIndex=21;
       break;		
      case 161:
         document.getElementById("wifi_channel20").selectedIndex=22;
       break;		
      case 165:
         document.getElementById("wifi_channel20").selectedIndex=23;
       break;
	  */ 
      default:
         break;
      }
	}else{
	  document.getElementById("wifi_width2").selectedIndex=1;
	  //Channel
	  document.getElementById("band20").style.display = "none";
	  document.getElementById("band80").style.display = "none";
	  //Control Side Band
	  document.getElementById("wifiband").style.display = "";
	  if(Band == "0"){        //Above
        document.getElementById("band_above").style.display = "";
        document.getElementById("band_below").style.display = "none";
		document.getElementById("wifi_band").selectedIndex=0;
		switch (Channel)
        {
          case 36:
           document.getElementById("wifi_channel31").selectedIndex=0;
           break;
          //case 40:
          // document.getElementById("wifi_channel31").selectedIndex=1;
          // break;
          case 44:
           document.getElementById("wifi_channel31").selectedIndex=1;
           break;	
          //case 48:
          // document.getElementById("wifi_channel31").selectedIndex=3;
          // break;	 	
           /*case 36:
             document.getElementById("wifi_channel31").selectedIndex=0;
             break;
           case 44:
             document.getElementById("wifi_channel31").selectedIndex=1;
             break;	
           case 52:
             document.getElementById("wifi_channel31").selectedIndex=2;
             break;		
           case 60:
             document.getElementById("wifi_channel31").selectedIndex=3;
             break;		
           case 100:
             document.getElementById("wifi_channel31").selectedIndex=4;
             break;		
           case 108:
             document.getElementById("wifi_channel31").selectedIndex=5;
             break;		
           case 116:
             document.getElementById("wifi_channel31").selectedIndex=6;
             break;		
           case 124:
             document.getElementById("wifi_channel31").selectedIndex=7;
             break;		
           case 132:
             document.getElementById("wifi_channel31").selectedIndex=8;
             break;		
           case 149:
             document.getElementById("wifi_channel31").selectedIndex=9;
             break;		
           case 157:
             document.getElementById("wifi_channel31").selectedIndex=10;
             break;	
		   */	 
           default:
             break;
         }
      }else{                 //Below
	    document.getElementById("band_above").style.display = "none";
        document.getElementById("band_below").style.display = "";
		document.getElementById("wifi_band").selectedIndex=1;
		switch (Channel)
        {
           //case 36:
           // document.getElementById("wifi_channel32").selectedIndex=0;
           // break;
           case 40:
            document.getElementById("wifi_channel32").selectedIndex=0;
            break;
           //case 44:
           // document.getElementById("wifi_channel32").selectedIndex=2;
           // break;	
           case 48:
            document.getElementById("wifi_channel32").selectedIndex=1;
            break;	
           /*case 40:
             document.getElementById("wifi_channel32").selectedIndex=0;
             break;
           case 48:
             document.getElementById("wifi_channel32").selectedIndex=1;
             break;	
           case 56:
             document.getElementById("wifi_channel32").selectedIndex=2;
             break;		
           case 64:
             document.getElementById("wifi_channel32").selectedIndex=3;
             break;		
           case 104:
             document.getElementById("wifi_channel32").selectedIndex=4;
             break;		
           case 112:
             document.getElementById("wifi_channel32").selectedIndex=5;
             break;		
           case 120:
             document.getElementById("wifi_channel32").selectedIndex=6;
             break;		
           case 128:
             document.getElementById("wifi_channel32").selectedIndex=7;
             break;		
           case 136:
             document.getElementById("wifi_channel32").selectedIndex=8;
             break;		
           case 153:
             document.getElementById("wifi_channel32").selectedIndex=9;
             break;		
           case 161:
             document.getElementById("wifi_channel32").selectedIndex=10;
             break;	
		   */	 
           default:
             break;
         }
	  }
	}
  }else if(Mode == "ac"){      
    //Channel Spacing: 20, 2040, 80
    document.getElementById("width1").style.display = "none";
	document.getElementById("width2").style.display = "none";
	document.getElementById("width3").style.display = "";
	if (Width == 20){  
	  document.getElementById("wifi_width3").selectedIndex=0;
	  //Control Side Band
	  document.getElementById("wifiband").style.display = "none";
	  //Channel
	  document.getElementById("band20").style.display = "";
	  document.getElementById("band80").style.display = "none";
	  document.getElementById("band_above").style.display = "none";
	  document.getElementById("band_below").style.display = "none";
	  switch (Channel)
      {
      case 36:
       document.getElementById("wifi_channel20").selectedIndex=0;
       break;
      case 40:
       document.getElementById("wifi_channel20").selectedIndex=1;
       break;
      case 44:
       document.getElementById("wifi_channel20").selectedIndex=2;
       break;	
      case 48:
         document.getElementById("wifi_channel20").selectedIndex=3;
       break;	
      /*case 52:
         document.getElementById("wifi_channel20").selectedIndex=4;
       break;		
      case 56:
         document.getElementById("wifi_channel20").selectedIndex=5;
       break;		
      case 60:
         document.getElementById("wifi_channel20").selectedIndex=6;
       break;		
      case 64:
         document.getElementById("wifi_channel20").selectedIndex=7;
       break;		
      case 100:
         document.getElementById("wifi_channel20").selectedIndex=8;
       break;		
      case 104:
         document.getElementById("wifi_channel20").selectedIndex=9;
       break;		
      case 108:
         document.getElementById("wifi_channel20").selectedIndex=10;
       break;		
      case 112:
         document.getElementById("wifi_channel20").selectedIndex=11;
       break;
      case 116:
         document.getElementById("wifi_channel20").selectedIndex=12;
       break;		
      case 120:
         document.getElementById("wifi_channel20").selectedIndex=13;
       break;		
      case 124:
         document.getElementById("wifi_channel20").selectedIndex=14;
       break;		
      case 128:
         document.getElementById("wifi_channel20").selectedIndex=15;
       break;		
      case 132:
         document.getElementById("wifi_channel20").selectedIndex=16;
       break;		
      case 136:
         document.getElementById("wifi_channel20").selectedIndex=17;
       break;		
      case 140:
         document.getElementById("wifi_channel20").selectedIndex=18;
       break;		
      case 149:
         document.getElementById("wifi_channel20").selectedIndex=19;
       break;		
      case 153:
         document.getElementById("wifi_channel20").selectedIndex=20;
       break;		
      case 157:
         document.getElementById("wifi_channel20").selectedIndex=21;
       break;		
      case 161:
         document.getElementById("wifi_channel20").selectedIndex=22;
       break;		
      case 165:
         document.getElementById("wifi_channel20").selectedIndex=23;
       break;
	  */ 
      default:
         break;
      }
	}else if (Width == 80){
	  document.getElementById("wifi_width3").selectedIndex=2;
	  //Control Side Band
	  document.getElementById("wifiband").style.display = "none";
	  //Channel
	  document.getElementById("band20").style.display = "none";
	  document.getElementById("band80").style.display = "";
	  document.getElementById("band_above").style.display = "none";
	  document.getElementById("band_below").style.display = "none";
	  switch (Channel)
      {
           case 36:
             document.getElementById("wifi_channel80").selectedIndex=0;
             break;
           case 40:
             document.getElementById("wifi_channel80").selectedIndex=1;
             break;	
           case 44:
             document.getElementById("wifi_channel80").selectedIndex=2;
             break;		
           case 48:
             document.getElementById("wifi_channel80").selectedIndex=3;
             break;		
           /*case 52:
             document.getElementById("wifi_channel80").selectedIndex=4;
             break;		
           case 56:
             document.getElementById("wifi_channel80").selectedIndex=5;
             break;		
           case 60:
             document.getElementById("wifi_channel80").selectedIndex=6;
             break;		
           case 64:
             document.getElementById("wifi_channel80").selectedIndex=7;
             break;		
           case 100:
             document.getElementById("wifi_channel80").selectedIndex=8;
             break;		
           case 104:
             document.getElementById("wifi_channel80").selectedIndex=9;
             break;		
           case 108:
             document.getElementById("wifi_channel80").selectedIndex=10;
             break;	
		   case 112:
             document.getElementById("wifi_channel80").selectedIndex=11;
             break;		   	
		   case 116:
             document.getElementById("wifi_channel80").selectedIndex=12;
             break;		   	
		   case 120:
             document.getElementById("wifi_channel80").selectedIndex=13;
             break;		   	
		   case 124:
             document.getElementById("wifi_channel80").selectedIndex=14;
             break;		   	
		   case 128:
             document.getElementById("wifi_channel80").selectedIndex=15;
             break;		   	
		   case 149:
             document.getElementById("wifi_channel80").selectedIndex=16;
             break;		   	
		   case 153:
             document.getElementById("wifi_channel80").selectedIndex=17;
             break;		   	
		   case 157:
             document.getElementById("wifi_channel80").selectedIndex=18;
             break;		   	
		   case 161:
             document.getElementById("wifi_channel80").selectedIndex=19;
             break;	
		   */	 
           default:
             break;
        }
	}else{
	  document.getElementById("wifi_width3").selectedIndex=1;
	  //Control Side Band
	  document.getElementById("wifiband").style.display = "";
	  //Channel
	  document.getElementById("band20").style.display = "none";
	  document.getElementById("band80").style.display = "none";
	  if(Band == "0"){        //Above
        document.getElementById("band_above").style.display = "";
        document.getElementById("band_below").style.display = "none";
		document.getElementById("wifi_band").selectedIndex=0;
		switch (Channel)
        {
           case 36:
             document.getElementById("wifi_channel31").selectedIndex=0;
             break;
           //case 40:
           //  document.getElementById("wifi_channel31").selectedIndex=1;
           //  break;	
           case 44:
             document.getElementById("wifi_channel31").selectedIndex=1;
             break;		
           //case 48:
           //  document.getElementById("wifi_channel31").selectedIndex=3;
           //  break;	
           /*case 36:
             document.getElementById("wifi_channel31").selectedIndex=0;
             break;
           case 44:
             document.getElementById("wifi_channel31").selectedIndex=1;
             break;	
           case 52:
             document.getElementById("wifi_channel31").selectedIndex=2;
             break;		
           case 60:
             document.getElementById("wifi_channel31").selectedIndex=3;
             break;		
           case 100:
             document.getElementById("wifi_channel31").selectedIndex=4;
             break;		
           case 108:
             document.getElementById("wifi_channel31").selectedIndex=5;
             break;		
           case 116:
             document.getElementById("wifi_channel31").selectedIndex=6;
             break;		
           case 124:
             document.getElementById("wifi_channel31").selectedIndex=7;
             break;		
           case 132:
             document.getElementById("wifi_channel31").selectedIndex=8;
             break;		
           case 149:
             document.getElementById("wifi_channel31").selectedIndex=9;
             break;		
           case 157:
             document.getElementById("wifi_channel31").selectedIndex=10;
             break;		
		   */	 
           default:
             break;
         }
      }else{                 //Below
	    document.getElementById("band_above").style.display = "none";
        document.getElementById("band_below").style.display = "";
		document.getElementById("wifi_band").selectedIndex=1;
		switch (Channel)
        {
           //case 36:
           //  document.getElementById("wifi_channel32").selectedIndex=0;
           //  break;
           case 40:
             document.getElementById("wifi_channel32").selectedIndex=0;
             break;	
           //case 44:
           //  document.getElementById("wifi_channel32").selectedIndex=2;
           //  break;		
           case 48:
             document.getElementById("wifi_channel32").selectedIndex=1;
             break;	
           /*case 40:
             document.getElementById("wifi_channel32").selectedIndex=0;
             break;
           case 48:
             document.getElementById("wifi_channel32").selectedIndex=1;
             break;	
           case 56:
             document.getElementById("wifi_channel32").selectedIndex=2;
             break;		
           case 64:
             document.getElementById("wifi_channel32").selectedIndex=3;
             break;		
           case 104:
             document.getElementById("wifi_channel32").selectedIndex=4;
             break;		
           case 112:
             document.getElementById("wifi_channel32").selectedIndex=5;
             break;		
           case 120:
             document.getElementById("wifi_channel32").selectedIndex=6;
             break;		
           case 128:
             document.getElementById("wifi_channel32").selectedIndex=7;
             break;		
           case 136:
             document.getElementById("wifi_channel32").selectedIndex=8;
             break;		
           case 153:
             document.getElementById("wifi_channel32").selectedIndex=9;
             break;		
           case 161:
             document.getElementById("wifi_channel32").selectedIndex=10;
             break;
		   */	 
           default:
             break;
         }
	  } 
	}
  }

  //Transmit power
  switch (Transmit)
  {
  	case "0":
       document.getElementById("wifi_transmit_power").selectedIndex=0;
       break;
    case "-1":
       document.getElementById("wifi_transmit_power").selectedIndex=1;
       break;
    case "-3":
       document.getElementById("wifi_transmit_power").selectedIndex=2;
       break;
    default:
	   break;
  }
}

function initWifiAP()
{
  var WifiInfo = <%getWifi(2);%>;
  var WifiArr = WifiInfo.split("#");

  document.getElementById("wifi_interval").value=WifiArr[10];
  document.getElementById("wifi_threshold").value=WifiArr[11];
}

function selectMode()
{
  var sMode = document.getElementById("wifi_mode").selectedIndex;
  var sWidth1 = document.getElementById("wifi_width1").selectedIndex; 
  var sWidth2 = document.getElementById("wifi_width2").selectedIndex; 
  var sWidth3 = document.getElementById("wifi_width3").selectedIndex; 
  var sBand = document.getElementById("wifi_band").selectedIndex; 
  if(sMode == 0){  		//a
  	document.getElementById("width1").style.display = "";       
	document.getElementById("width2").style.display = "none";
	document.getElementById("width3").style.display = "none";
	document.getElementById("band20").style.display = "";
	document.getElementById("band80").style.display = "none";
	document.getElementById("wifiband").style.display = "none";
	document.getElementById("band_above").style.display = "none";
	document.getElementById("band_below").style.display = "none";
  }else if(sMode == 1){  //an
    document.getElementById("width1").style.display = "none";
	document.getElementById("width2").style.display = "";
	document.getElementById("width3").style.display = "none";
	if (sWidth2 == 0){  	
	  document.getElementById("band20").style.display = "";
	  document.getElementById("band80").style.display = "none";
	  document.getElementById("wifiband").style.display = "none";
	  document.getElementById("band_above").style.display = "none";
	  document.getElementById("band_below").style.display = "none";
	}else{					
	  document.getElementById("band20").style.display = "none";
	  document.getElementById("band80").style.display = "none";
	  document.getElementById("wifiband").style.display = "";
	  if(sBand == 0){        	//Above
        document.getElementById("band_above").style.display = "";
        document.getElementById("band_below").style.display = "none";
      }else{                   //Below
	    document.getElementById("band_above").style.display = "none";
        document.getElementById("band_below").style.display = "";
	  }
	}
  }else if(sMode == 2){  //ac
    document.getElementById("width1").style.display = "none";
	document.getElementById("width2").style.display = "none";
	document.getElementById("width3").style.display = "";
	if (sWidth3 == 0){  
	  document.getElementById("band20").style.display = "";
	  document.getElementById("band80").style.display = "none";
	  document.getElementById("wifiband").style.display = "none";
	  document.getElementById("band_above").style.display = "none";
	  document.getElementById("band_below").style.display = "none";
	}else if (sWidth3 == 1){
	  document.getElementById("band20").style.display = "none";
	  document.getElementById("band80").style.display = "none";
	  document.getElementById("wifiband").style.display = "";
	  if(sBand == "0"){        //Above
        document.getElementById("band_above").style.display = "";
        document.getElementById("band_below").style.display = "none";
      }else{                   //Below
	    document.getElementById("band_above").style.display = "none";
        document.getElementById("band_below").style.display = "";
	  }
	}else if (sWidth3 == 2){
	  document.getElementById("band20").style.display = "none";
	  document.getElementById("band80").style.display = "";
	  document.getElementById("wifiband").style.display = "none";
	  document.getElementById("band_above").style.display = "none";
	  document.getElementById("band_below").style.display = "none";	
	}
  }
}

function selectWidth2()
{
  document.getElementById("width1").style.display = "none";
  document.getElementById("width2").style.display = "";
  document.getElementById("width3").style.display = "none";
	
  var sWidth2 = document.getElementById("wifi_width2").selectedIndex; 
  var sBand = document.getElementById("wifi_band").selectedIndex; 
  document.getElementById("wifiband").style.display = "none"; 
  if (sWidth2 == 0){  //20MHz            
	  document.getElementById("wifiband").style.display = "none"; 
      document.getElementById("band20").style.display = "";
	  document.getElementById("band80").style.display = "none";
      document.getElementById("band_above").style.display = "none";
      document.getElementById("band_below").style.display = "none";
  }else{	         //20/40MHz
  	  document.getElementById("wifiband").style.display = "";
	  document.getElementById("band20").style.display = "none";	
	  document.getElementById("band80").style.display = "none";	
	  if(sBand == 0){        //Above
        document.getElementById("band_above").style.display = "";
        document.getElementById("band_below").style.display = "none";
      }else{                 //Below
	    document.getElementById("band_above").style.display = "none";
        document.getElementById("band_below").style.display = "";	    
	  }
  }
}

function selectWidth3()
{
  document.getElementById("width1").style.display = "none";
  document.getElementById("width2").style.display = "none";
  document.getElementById("width3").style.display = "";
	
  var sWidth3 = document.getElementById("wifi_width3").selectedIndex; 
  var sBand = document.getElementById("wifi_band").selectedIndex; 
  if (sWidth3 == 0){  		//20MHz            
	  document.getElementById("wifiband").style.display = "none"; 
      document.getElementById("band20").style.display = "";
	  document.getElementById("band80").style.display = "none";
      document.getElementById("band_above").style.display = "none";
      document.getElementById("band_below").style.display = "none";
  }else if (sWidth3 == 2){  //80MHz            
	  document.getElementById("wifiband").style.display = "none"; 
      document.getElementById("band20").style.display = "none";
	  document.getElementById("band80").style.display = "";
      document.getElementById("band_above").style.display = "none";
      document.getElementById("band_below").style.display = "none";
  }else{	         		//20/40MHz
  	  document.getElementById("wifiband").style.display = "";
	  document.getElementById("band20").style.display = "none";	
	  document.getElementById("band80").style.display = "none";	
	  if(sBand == 0){        //Above
        document.getElementById("band_above").style.display = "";
        document.getElementById("band_below").style.display = "none";
      }else{                 //Below
	    document.getElementById("band_above").style.display = "none";
        document.getElementById("band_below").style.display = "";	    
	  }
  }
}

function selectBand()
{
  var sBand = document.getElementById("wifi_band").selectedIndex;
  if(sBand == 0){  //Above
  	document.getElementById("band20").style.display = "none";
	document.getElementById("band80").style.display = "none";
    document.getElementById("band_above").style.display = "";
    document.getElementById("band_below").style.display = "none";
  }else{           //Below
  	document.getElementById("band20").style.display = "none";
	document.getElementById("band80").style.display = "none";
    document.getElementById("band_above").style.display = "none";
    document.getElementById("band_below").style.display = "";	    
  }
}

function checkWIFIAdvSettings()
{
	if(!CheckLoginInfo())
		return false;

	document.wifi_setting.action="/goform/setWifiRadioAC";
	document.wifi_setting.submit();
	return true;
/*
  	var sBeacon = document.getElementById("wifi_interval").value;
    var sthreshold = document.getElementById("wifi_threshold").value;
    var sthreshold_rule =/^[0-9]{3,5}$/;	
    if (sthreshold == "") {
    	alert(gettext("Please input value between 100 ~ 61952."));
    	document.getElementById("wifi_threshold").focus();
    	return false;
    } 
  
    if (sBeacon == "") {
       alert(gettext("Please input 100 multiple between 100 ~ 1000."));
       document.getElementById("wifi_interval").focus();
       return false;
    }
  
    if (!sthreshold_rule.test(sthreshold)) {
    	alert(gettext("Please input value between 100 ~ 61952."));
    	document.getElementById("wifi_threshold").focus();
        return false;
    }
  
    if ((sthreshold < 100) || (sthreshold > 61952)) {
    	alert(gettext("Please input value between 100 ~ 61952."));
    	document.getElementById("wifi_threshold").focus();
        return false;
    }
    
    if (sBeacon < 1001)
	{
    	if((!(sBeacon%100)) && sBeacon>0)
		{
      		document.wifi_setting.action="/goform/setWifiRadioAC";
			document.wifi_setting.submit();
      		return true;
    	} 
		else 
		{
      		alert(gettext("Please input 100 multiple between 100 ~ 1000."));
	  		document.getElementById("wifi_interval").focus();
	  		return false;
    	}
  	} else {
    	alert(gettext("Please input 100 multiple between 100 ~ 1000."));
		document.getElementById("wifi_interval").focus();
		return false;
  	}
*/
}
</script>	
</head>	

<body id="wifiAdvPage" onload="initWifiInfo();initWifiAP();">
<div id="all">

<!-- Main Menu and Submenu Start -->
<%writeMainMenu();%>
<%writeLeftMenu("wifi");%>
<script type="text/javascript">menuChange("wifi_menu");leftSubMenuChange("wifi_submenu", "wifi_advsettings_ac","wifi_802.11ac","wifi_802.11ac_href");</script>
<!-- Main Menu and Submenu End -->

 <div class="contentBg">
   <div class="secH1"><script>document.write(gettext("Wi-Fi Advanced"));</script></div>
   <div class="secBg">
   <div class="secInfo"><br><script>document.write(gettext("Specify advanced configuration settings for the gateways radio from this page."));</script></br></div>
    <form name="wifi_setting" method="post">
    <table class="configTbl">
      <tr>
    	<td><script>document.write(gettext("Mode"));</script></td>
    	<td><select class="configF1" name="wifi_mode" id="wifi_mode" size="1" onChange="selectMode();">
          <option value="a"><script>document.write(gettext("802.11a"));</script>&nbsp;</option>
          <option value="an"><script>document.write(gettext("802.11a/n"));</script>&nbsp;</option>
          <option value="ac"><script>document.write(gettext("802.11ac"));</script>&nbsp;</option>
      	</select></td>
      </tr>
  	  <tr id="width1" style="display:none;">
      <td><script>document.write(gettext("Channel Spacing"));</script></td>
      <td><select class="configF1" name="wifi_width1" id="wifi_width1" size="1">
          <option value="20"><script>document.write(gettext("20 MHz"));</script></option>
      </select></td>      
      </tr>
  	  <tr id="width2" style="display:none;">
      <td><script>document.write(gettext("Channel Spacing"));</script></td>
      <td><select class="configF1" name="wifi_width2" id="wifi_width2" size="1" onChange="selectWidth2();">
          <option value="20"><script>document.write(gettext("20 MHz"));</script></option>
          <option value="2040"><script>document.write(gettext("20/40 MHz"));</script></option>
        </select></td>      
      </tr>
      <tr id="width3" style="display:none;">
      <td><script>document.write(gettext("Channel Spacing"));</script></td>
      <td><select class="configF1" name="wifi_width3" id="wifi_width3" size="1" onChange="selectWidth3();">
          <option value="20"><script>document.write(gettext("20 MHz"));</script></option>
          <option value="2040"><script>document.write(gettext("20/40 MHz"));</script></option>
          <option value="80"><script>document.write(gettext("80 MHz"));</script></option>
        </select></td>      
      </tr>
  	  <tr id="wifiband" style="display:none;">
      <td><script>document.write(gettext("Control Side Band"));</script></td>
      <td><select class="configF1" name="wifi_band" id="wifi_band" size="1" onChange="selectBand();">
          <option value="0"><script>document.write(gettext("Above"));</script></option>
          <option value="1"><script>document.write(gettext("Below"));</script></option>
      </select></td>      
      </tr>
  	  <tr id="band20" style="display:none;">
      <td><script>document.write(gettext("Channel"));</script></td>
      <td>
        <select class="configF1" name="wifi_channel20" id="wifi_channel20" size="1">
          <option value="36"><script>document.write(gettext("Channel"));</script> 36</option>
          <option value="40"><script>document.write(gettext("Channel"));</script> 40</option>
		  <option value="44"><script>document.write(gettext("Channel"));</script> 44</option>
		  <option value="48"><script>document.write(gettext("Channel"));</script> 48</option>
          <!--option value="36"><script>document.write(gettext("Channel"));</script> 36</option>
          <option value="40"><script>document.write(gettext("Channel"));</script> 40</option>
		  <option value="44"><script>document.write(gettext("Channel"));</script> 44</option>
		  <option value="48"><script>document.write(gettext("Channel"));</script> 48</option>
		  <option value="52"><script>document.write(gettext("Channel"));</script> 52</option>
		  <option value="56"><script>document.write(gettext("Channel"));</script> 56</option>
		  <option value="60"><script>document.write(gettext("Channel"));</script> 60</option>
		  <option value="64"><script>document.write(gettext("Channel"));</script> 64</option>
		  <option value="100"><script>document.write(gettext("Channel"));</script> 100</option>
		  <option value="104"><script>document.write(gettext("Channel"));</script> 104</option>
		  <option value="108"><script>document.write(gettext("Channel"));</script> 108</option>
		  <option value="112"><script>document.write(gettext("Channel"));</script> 112</option>
		  <option value="116"><script>document.write(gettext("Channel"));</script> 116</option>
		  <option value="120"><script>document.write(gettext("Channel"));</script> 120</option>
		  <option value="124"><script>document.write(gettext("Channel"));</script> 124</option>
		  <option value="128"><script>document.write(gettext("Channel"));</script> 128</option>
		  <option value="132"><script>document.write(gettext("Channel"));</script> 132</option>
		  <option value="136"><script>document.write(gettext("Channel"));</script> 136</option>
		  <option value="140"><script>document.write(gettext("Channel"));</script> 140</option>
		  <option value="149"><script>document.write(gettext("Channel"));</script> 149</option>
		  <option value="153"><script>document.write(gettext("Channel"));</script> 153</option>
		  <option value="157"><script>document.write(gettext("Channel"));</script> 157</option>		  
		  <option value="161"><script>document.write(gettext("Channel"));</script> 161</option>
		  <option value="165"><script>document.write(gettext("Channel"));</script> 165</option-->
        </select></td>      
    </tr>    
  	  <tr id="band_above" style="display:none;">
      <td><script>document.write(gettext("Channel"));</script></td>
      <td>
        <select class="configF1" name="wifi_channel31" id="wifi_channel31" size="1">
          <option value="36"><script>document.write(gettext("Channel"));</script> 36</option>
          <!--option value="40"><script>document.write(gettext("Channel"));</script> 40</option-->
		  <option value="44"><script>document.write(gettext("Channel"));</script> 44</option>
		  <!--option value="48"><script>document.write(gettext("Channel"));</script> 48</option-->	
          <!--option value="36"><script>document.write(gettext("Channel"));</script> 36</option>
          <option value="44"><script>document.write(gettext("Channel"));</script> 44</option>
		  <option value="52"><script>document.write(gettext("Channel"));</script> 52</option>
		  <option value="60"><script>document.write(gettext("Channel"));</script> 60</option>
		  <option value="100"><script>document.write(gettext("Channel"));</script> 100</option>
		  <option value="108"><script>document.write(gettext("Channel"));</script> 108</option>
		  <option value="116"><script>document.write(gettext("Channel"));</script> 116</option>
		  <option value="124"><script>document.write(gettext("Channel"));</script> 124</option>
		  <option value="132"><script>document.write(gettext("Channel"));</script> 132</option>
		  <option value="149"><script>document.write(gettext("Channel"));</script> 149</option>
		  <option value="157"><script>document.write(gettext("Channel"));</script> 157</option-->
        </select></td>      
    </tr>    
    <tr id="band_below" style="display:none;">
      <td><script>document.write(gettext("Channel"));</script></td>
      <td>
        <select class="configF1" name="wifi_channel32" id="wifi_channel32" size="1">
          <!--option value="36"><script>document.write(gettext("Channel"));</script> 36</option-->
          <option value="40"><script>document.write(gettext("Channel"));</script> 40</option>
		  <!--option value="44"><script>document.write(gettext("Channel"));</script> 44</option-->
		  <option value="48"><script>document.write(gettext("Channel"));</script> 48</option>
          <!--option value="40"><script>document.write(gettext("Channel"));</script> 40</option>
          <option value="48"><script>document.write(gettext("Channel"));</script> 48</option>
		  <option value="56"><script>document.write(gettext("Channel"));</script> 56</option>
		  <option value="64"><script>document.write(gettext("Channel"));</script> 64</option>
		  <option value="104"><script>document.write(gettext("Channel"));</script> 104</option>
		  <option value="112"><script>document.write(gettext("Channel"));</script> 112</option>
		  <option value="120"><script>document.write(gettext("Channel"));</script> 120</option>
		  <option value="128"><script>document.write(gettext("Channel"));</script> 128</option>
		  <option value="136"><script>document.write(gettext("Channel"));</script> 136</option>
		  <option value="153"><script>document.write(gettext("Channel"));</script> 153</option>
		  <option value="161"><script>document.write(gettext("Channel"));</script> 161</option-->
        </select></td>      
    </tr>
    <tr id="band80" style="display:none;">
      <td><script>document.write(gettext("Channel"));</script></td>
      <td>
        <select class="configF1" name="wifi_channel80" id="wifi_channel80" size="1">
          <option value="36"><script>document.write(gettext("Channel"));</script> 36</option>
          <option value="40"><script>document.write(gettext("Channel"));</script> 40</option>
		  <option value="44"><script>document.write(gettext("Channel"));</script> 44</option>
		  <option value="48"><script>document.write(gettext("Channel"));</script> 48</option>
          <!--option value="36"><script>document.write(gettext("Channel"));</script> 36</option>
          <option value="40"><script>document.write(gettext("Channel"));</script> 40</option>
		  <option value="44"><script>document.write(gettext("Channel"));</script> 44</option>
		  <option value="48"><script>document.write(gettext("Channel"));</script> 48</option>
		  <option value="52"><script>document.write(gettext("Channel"));</script> 52</option>
		  <option value="56"><script>document.write(gettext("Channel"));</script> 56</option>
		  <option value="60"><script>document.write(gettext("Channel"));</script> 60</option>
		  <option value="64"><script>document.write(gettext("Channel"));</script> 64</option>
		  <option value="100"><script>document.write(gettext("Channel"));</script> 100</option>
		  <option value="104"><script>document.write(gettext("Channel"));</script> 104</option>
		  <option value="108"><script>document.write(gettext("Channel"));</script> 108</option>
		  <option value="112"><script>document.write(gettext("Channel"));</script> 112</option>
		  <option value="116"><script>document.write(gettext("Channel"));</script> 116</option>
		  <option value="120"><script>document.write(gettext("Channel"));</script> 120</option>
		  <option value="124"><script>document.write(gettext("Channel"));</script> 124</option>
		  <option value="128"><script>document.write(gettext("Channel"));</script> 128</option>
		  <option value="149"><script>document.write(gettext("Channel"));</script> 149</option>
		  <option value="153"><script>document.write(gettext("Channel"));</script> 153</option>
		  <option value="157"><script>document.write(gettext("Channel"));</script> 157</option>		  
		  <option value="161"><script>document.write(gettext("Channel"));</script> 161</option-->
        </select></td>      
    </tr>
    <tr style="display:none;">
      <td style="width:185px"><label class="text_gray"><script>document.write(gettext("Beacon Interval"));</script></label></td>
      <td><input class="fill" type="text" name="wifi_interval" id="wifi_interval" onkeypress="return onkeypress_number_only(event)" maxlength="4"/></td>
      <td style="width:250px">&nbsp;<script>document.write(gettext("(100 multiple between 100~1000)"));</script></td>      
    </tr>
    <tr style="display:none;">
      <td style="width:185px"><label class="text_gray"><script>document.write(gettext("RTS Threshold"));</script></label></td>
      <td><input class="fill" type="text" name="wifi_threshold" id="wifi_threshold" onkeypress="return onkeypress_number_only(event)" maxlength="5"/></td>      
      <td style="width:250px">&nbsp;<script>document.write(gettext("(Between 100~61952)"));</script></td>      
    </tr>
    <tr style="display:none;">
      <td width="185"><script>document.write(gettext("Fragmentation Threshold"));</script></td>
      <td><input class="fill" type="text" /></td>      
    </tr>      
    <tr>
      <td><script>document.write(gettext("Transmit Power"));</script></label></td>
      <td>
        <select class="configF1" name="wifi_transmit_power" id="wifi_transmit_power" size="1">
          <option value="0">100%</option>
          <option value="-1">75%</option>
		  <option value="-3">50%</option>
        </select></td>      
    </tr>
    </table>   
	<div>
   	  <input type="submit" id="wifi_ac_apply" value="Apply" class="tblbtn" title="Apply" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="return checkWIFIAdvSettings();">
   	  <input type="submit" id="wifi_ac_reset" value="Reset" class="tblbtn" title="Reset" name="" onmouseover="this.className = 'tblbtnHover'" onmouseout="this.className = 'tblbtn'" onclick="doRedirect();">
    </div>
   </form> 
   </div>
 </div>
</div><!-- center_bg end -->
<script type="text/javascript">
	document.getElementById('wifi_ac_apply').value=gettext("Apply");
	document.getElementById('wifi_ac_reset').value=gettext("Reset");
</script>
</body>
</html>
