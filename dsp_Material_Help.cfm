<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Meeting Materials Login Help</title>
	<style type="text/css">
	  body{
	     font-family:verdana;
		 font-size: 11px;
	  }
	</style>
</head>

<body onload="self.focus();">
<div align="right"><a href="#" onclick="self.close();">X Close</a></div><br>
<cfif url.Type EQ "M"> 
  The Meeting Code is located in the top right hand corner of your confirmation letter; As shown highlighted in red in the image below.<br>
  <img src="images/whatis_mtgcode.gif" width="300" height="156" alt="The Meeting Code is located in the top right hand corner of your confirmation letter." border="0" hspace="5" vspace="8">
  <br>
   
<cfelse>
   The Personal ID is located in the top right hand corner of your confirmation letter; As shown highlighted in red in the image below.<br>
  <img src="images/whatis_Phid.gif" width="300" height="156" alt="The Personal is located in the top right hand corner of your confirmation letter." border="0" hspace="5" vspace="8">
  <br>
   
</cfif>
 
</body>
</html>
