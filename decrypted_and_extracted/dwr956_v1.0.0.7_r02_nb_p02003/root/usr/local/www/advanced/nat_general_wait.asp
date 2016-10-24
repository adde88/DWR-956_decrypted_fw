<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>NEW IAD</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/styles.css" type="text/css" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="Javascript" src="../js/mgmt.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
setTimeout(function () {autoReset()},1000);
function autoReset()
{
  document.setRebootform.action = "/goform/setRebootform";
  document.setRebootform.submit();
  return true;
}
</script>
</head>
<body>
  <hr/>
  <form method="post" name="setRebootform">
    <input type="hidden" name="reboot_dummy" value="0">
  </form>
</body>
</html>
