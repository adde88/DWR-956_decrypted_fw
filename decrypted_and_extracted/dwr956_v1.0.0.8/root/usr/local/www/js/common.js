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
     alert(el_ap + " : " + "The SSID is not allowed to be empty.");
     return false;
   }
   var pattern = /[\#]+$/;
   var field = el_ssid.value;
   if (pattern.test(field))
   {
    alert(el_ap + " : " + "Invalid SSID.");
    return false;
   }
   return true;
 },
 onsubmit_wep: function(el_pass, el_ap, el_key_num)
 {
   if(el_pass.value.length == 0)
   {
     alert(el_ap + " : " + "The WEP Key " + el_key_num + " is not allowed to be empty.");
     return false;
   }
   return true;
 },
 onsubmit_wpa: function(el_pass, el_ap)
 {
   if(el_pass.value.length == 0)
   {
     alert(el_ap + " : " + "The WPA Key is not allowed to be empty.");
     return false;
   }
   else if ((el_pass.value.length < 8) || (el_pass.value.length > el_pass.maxLength))
   {
     alert(el_ap + " : " + "Invalid Encryption Key.");
     return false;
   }
   return true;
 }
}
