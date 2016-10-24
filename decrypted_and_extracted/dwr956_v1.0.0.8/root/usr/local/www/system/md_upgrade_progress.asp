<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>4G Router</title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="../style/all.css" type="text/css" />
<script language="JavaScript" src="../js/lteProgressBar.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

</script>
</head>

<body onload="lteProgressBarCall ();">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
			<td align="center" valign="top">
				<div class="w1000">
					<div class="midBg" id="upgrade_module">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center" valign="top">
								<div class="contentBg0_new">
									<div class="secH1_new">4G Module Firmware Upgrade</div>
									<div class="secBg_xx">
										<div class="secInfo">&nbsp;</div>
										<div align="center">
										<form name="statusForm" method="post" action="">
										<input type="hidden" id="i18n_modelUpgradeFailed" value= "4G module firmware upgrade failed" />
										</form>
										<table cellspacing="0" class="configTbl">
											<tr>
												<td id="lblStatusMsgLte">&nbsp;</td>
											</tr>
											<tr>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td align="center">
													<table id="tblProgressLte" frame="box" rules="none" border="0" style="border-collapse: collapse" width="80%" height="10" cellpadding="0">
														<tr>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
															<td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td><td name="tblTdProgressLte" width="1">&nbsp;</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>&nbsp;</td>
											</tr>
											</table>
											</div>
										<div class="secInfo">&nbsp;</div>
									</div>
								</div>
						</td></tr>
						</table>
					</div>
					<div class="midBg" id="module_upgrage_status" style="display:none;">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center" valign="top">
					  <div class="contentBg0_new">
							<div class="secH1_new">4G Module Firmware Upgrade</div>
							<div class="secBg_xx">
								<div class="secInfo">&nbsp;</div>
								<div align="center">
								<table cellspacing="0" class="configTbl">
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="statusMsg">The upgrade process will take a few minutes, please wait patiently.</td>
									</tr>
									<tr>
										<td class="statusMsg" id="mdm_message">Starting upgrade 4G module firmware</td>
									</tr>
									<tr>
										<td class="statusMsg" id="mdm_progressing">Progressing: 0</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									</table>
									</div>
								<div class="secInfo">&nbsp;</div>
							</div>
						</div>
						</td></tr>
						</table>
					</div>
					<div class="midBg" id="module_reboot" style="display:none;">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center" valign="top">
					<div class="contentBg0_new">
							<div class="secH1_new">Status Message</div>
							<div class="secBg_new">
								<div class="secInfo" style="color:#FF6600">&nbsp;</div>
								<div align="center">
								<form name="statusForm" method="post" action="platform.cgi">
								<input type="hidden" name="thispage" value="statusPage.htm">
								<input type="hidden" name="button.status.index" value="1">
								</form>
								<table cellspacing="0" class="configTbl">
									<tr>
										<td></td>
									</tr>
									<tr>
										<td >&nbsp;</td>
									</tr>
									<tr>
										<td class="statusMsg" id="lblStatusMsg">Please wait...&nbsp;&nbsp;</td>
									</tr>
									<tr>
										<td >&nbsp;</td>
									</tr>
									</table>
									</div>
								<div class="secInfo">&nbsp;</div>
							</div>
						</div>
						</td></tr>
						</table>
					
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>



