<html>
<head>
<title>Data Collector</title>
<meta http-equiv='refresh' content='10;url=collector.asp'>
<script language="JavaScript" type="text/javascript">
function SetSelectedValue()
{
	var eth0= document.graphData.eth0.value;//Math.floor(Math.random()*256);
	var wlan2=document.graphData.wlan1.value; //Math.floor(Math.random()*256);
	var wlan5=document.graphData.wlan2.value;//Math.floor(Math.random()*256);
	var vdsl=document.graphData.vdsl.value;//Math.floor(Math.random()*256);
	var cpuutil=document.graphData.cpu.value;// Math.floor(Math.random()*100);
	var deltatx=document.graphData.deltatx.value;//Math.floor(Math.random()*156);
	var dectcalls=document.graphData.dectcalls.value;//Math.floor(Math.random()*6);
	var mmstream=document.graphData.mmstream.value;//Math.floor(Math.random()*6); 
	
	/*var eth0= Math.floor(Math.random()*256);
	var wlan2=Math.floor(Math.random()*256);
	var wlan5=Math.floor(Math.random()*256);
	var vdsl=Math.floor(Math.random()*256);
	var cpuutil=Math.floor(Math.random()*100);
	var deltatx=Math.floor(Math.random()*156);
	var dectcalls=Math.floor(Math.random()*6);
	var mmstream=Math.floor(Math.random()*6);*/
if(parseInt(eth0) > 0)	
	eth0=parseInt(eth0/1024)/1024;
if(parseInt(wlan2) > 0)
	wlan2=parseInt(wlan2/1024)/1024;
if(parseInt(wlan5) > 0 )
	wlan5=parseInt(wlan5/1024)/1024;
if(parseInt(vdsl) > 0 )
	vdsl=parseInt(vdsl/1024)/1024;
if(parseInt(deltatx) > 0)
	deltatx=parseInt(deltatx/1024)/1024; 

	//alert(eth0 + ":" + wlan2 + ":" + wlan5 + ":" + vdsl + ":" + cpuutil + ":" + deltatx + ":" +dectcalls + ":" + mmstream); 	
	parent.setNewReads(eth0,wlan2,wlan5,vdsl,cpuutil,deltatx,dectcalls,mmstream);
}

</script>
</head>
<body onload="SetSelectedValue();">
<form name="graphData" action="">
<input type="text" name="eth0" value="<%ifx_get_graph_statistics("eth0")%>">
<input type="text" name="wlan1" value="<%ifx_get_graph_statistics("wlan1")%>">
<input type="text" name="wlan2" value="<%ifx_get_graph_statistics("wlan2")%>">
<input type="text" name="vdsl" value="<%ifx_get_graph_statistics("vdsl")%>">
<input type="text" name="cpu" value="<%ifx_get_graph_statistics("cpu")%>">
<input type="text" name="deltatx" value="<%ifx_get_graph_statistics("deltatx")%>">
<input type="text" name="dectcalls" value="<%ifx_get_graph_statistics("dectcall")%>">
<input type="text" name="mmstream" value="<%ifx_get_graph_statistics("mmstream")%>">
</form>

</body>
</html>
