function parse(str){
var patt1=/((\w+):(\w+)@)/gi; // Both Username and Password
var patt2=/((\d+\.\d+\.\d+\.\d+)|([a-zA-Z0-9]*\.[a-zA-Z.]*))/gi; // IP Address
var patt3=/(:[0-9]+)/gi; // Port
var patt4=/(;transport=[a-zA-Z]+)/gi; // Protocol
var patt5=/((\w+):(\w+)@)(\d+\.\d+\.\d+\.\d+)(:[0-9]+)(;transport=[a-z]+)/gi; //Full String
var patt6=/(^(\w+)@)/gi; // Username

UUA=str.match(patt1);
UAddr=str.match(patt2);
UPort=str.match(patt3);
UProtocol=str.match(patt4);
UUN=str.match(patt6);

var Username="NULL";
var Password="NULL";
if (UUA != null) {
	var String1 = new String(UUA);
	var Pos = String1.indexOf(':');
	var Len = String1.length;
	var Username = String1.substring(0, Pos);
	var Password = String1.substring(Pos + 1, Len - 1);
}
else 
	if (UUN != null) {
		var String1 = new String(UUN);
		var Username = String1.substring(0, String1.length - 1);
}

var Port="NULL";
if (UPort != null) {
	var String2 = new String(UPort);
	var Port = String2.substring(1, String2.length);
}

var Protocol="NULL";
if (UProtocol != null) {
	var String3 = new String(UProtocol);
	var ProPos = String3.indexOf('=');
	var Protocol = String3.substring(ProPos + 1, String3.length);
}

var Address="NULL";
if(UAddr!=null)
	Address=new String(UAddr);

var Return=new Array();
Return[0]=new String(Username);
Return[1]=new String(Password);
Return[2]=new String(Address);
Return[3]=new String(Port);
Return[4]=new String(Protocol);

return Return;
}

function isPSTN(str){
   var ValidChars = "0123456789";
   var IsNumber=true;
   var Char;
   
   for (i = 0; i < str.length && IsNumber == true; i++) 
      { 
      Char = str.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   return IsNumber;
}

function convertProto(str)
   {
    if (str.toLowerCase() == "UDP".toLowerCase()) 
     return 1;
    else if (str.toLowerCase() == "TCP".toLowerCase()) 
     return 2;
    else if (str.toLowerCase() == "Auto".toLowerCase()) 
     return 0;
   }
