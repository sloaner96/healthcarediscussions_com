<cfparam name="url.e" default="0">
<!--- Meeting Code: This could get passed via the url from an email--->
<cfparam name="url.M" default="">

<!--- PHID: This could get passed via the url from an email---> 
<cfparam name="url.P" default="">

<cfparam name="attributes.siteType" default="P">

<cfparam name="attributes.logoDisplay" default="M">


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>Healthcare Discussions</title>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<style type="text/css">
	  .TopMast{
	  	background-image: url('/images/topMast.gif');
	  	background-repeat: repeat-y;
	  }
	  .bottomMast{
	  	background-image: url('/images/bottomMast.gif');
	  	background-repeat: repeat-x;

	  }
	  .copyright{
	  	font-size: 10px;
	  	font-family: verdana, arial, courier;
	  	padding-bottom: 10px;
	  	padding-left: 5px;
	  	padding-top: 10px;
	  	color: #ffffff;
	  }
	  .mainView{
	  	font-size: 11px;
	  	font-family: verdana, arial, courier;
	  	padding-left: 5px;
	  	padding-right: 5px;
	  	overflow: scroll;
	  }
	  td{
	   font-family: verdana, arial, courier;
	   font-size: 11px;
	  }
	  H3{
	  	font-size: 14px;
	  	font-family: arial,verdana,  courier;
	  	color: #006699;
	  }
</style>
</head>

<body topmargin="0">
<table border="0" cellpadding="0" cellspacing="0" width="800" align="center">
  <tr>
    <td>
	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	     <tr>
	        <td class="topMast" background="/images/topmast.gif">
			  <table border="0" cellpadding="0" cellspacing="0"align="right">
                <tr>
                   <td align="right"><a href="/index.cfm"><img src="/images/MainHDLogo.gif" alt="Healthcare Discussions is brought to you by Pharmakon, LLC., A PDI Company." border="0"></a></td>
                </tr>
              </table>           
			</td>
	     </tr>
	     <tr>
			   <td background="/images/navbar_fill.gif" width="100%" align="right">
				    <cfif Attributes.siteType EQ "P">
				     <table border="0" cellpadding="0" cellspacing="0">
		               <tr>
					       <td><a href="/index.cfm"><img name="about" src="/images/btn_home_off.gif" alt="" border="0" onmouseover="this.src='/images/btn_home_on.gif'" onmouseout="this.src='/images/btn_home_off.gif'"></a></td>
						   <td><img src="/images/nav_Divider.gif" alt="" border="0"></td>
		                   <td><a href="/dsp_aboutus.cfm"><img name="about" src="/images/btn_aboutus_off.gif" alt="" border="0" onmouseover="this.src='/images/btn_aboutus_on.gif'" onmouseout="this.src='/images/btn_aboutus_off.gif'"></a></td>
						   <td><img src="/images/Nav_Divider.gif" alt="" border="0"></td>
						   <td><a href="/dsp_ShowMeeting.cfm"><img name="online" src="/images/Btn_MtgMaterials_off.gif" alt="" border="0" onmouseover="this.src='/images/Btn_MtgMaterials_on.gif'" onmouseout="this.src='/images/Btn_MtgMaterials_off.gif'"></a></td>
		               </tr>
		             </table>
					<cfelse>
					  &nbsp;            
					</cfif> 
				 </td>
	     </tr>
	  </table>
	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
         <tr>
		   <cfswitch expression="#Attributes.logoDisplay#">
		     <cfcase value="H">
			    <td><img src="/images/Welcome_Top.jpg" alt="Welcome to Healthcare Discussions" width="418" height="65" border="0"></td>
			 </cfcase>
			 <cfcase value="A">
			    <td><img src="/images/AboutUS_top.jpg" width="418" height="65" alt="About Healthcare Discussions" border="0"></td>
			 </cfcase>
			 <cfcase value="M">
			    <td><img src="/images/MtgMaterials_top.jpg" width="418" height="65" alt="Healthcare Discussions Meeting Materials" border="0"></td>
			 </cfcase>
			 <cfcase value="P">
			    <td><img src="/images/ProgramReg_top.jpg" width="418" height="65" alt="Register for a new program today." border="0"></td>
			 </cfcase>
			 <cfcase value="R">
			    <td><img src="/images/Honoraria_top.jpg" width="418" height="65" alt="Redeem your Honoraria Online." border="0"></td>
			 </cfcase>
			 <cfcase value="O">
			    <td><img src="/images/mod_top.jpg" width="418" height="65" alt="Moderator Materials" border="0"></td>
			 </cfcase>
			 <cfcase value="S">
			    <td><img src="/images/Privacy_top.jpg" width="418" height="65" alt="Our Privacy Statement" border="0"></td>
			 </cfcase>
			 <cfcase value="L">
			    <td><img src="/images/Login_top.jpg" width="418" height="65" alt="Please Login to our secure site" border="0"></td>
			 </cfcase>
			 <cfdefaultcase>
			    <td><img src="/images/Welcome_top.jpg" width="418" height="65" alt="Welcome to Healthcare Discussions" border="0"></td>
			 </cfdefaultcase>
		   </cfswitch>
            
			<td><img src="/images/LogoPic1.jpg" width="128" height="65" alt="" border="0"></td>
			<td><img src="/images/logoPic2.jpg" width="146" height="65" alt="" border="0"></td>
			<td><img src="/images/LogoPic3.jpg" width="108" height="65" alt="" border="0"></td>
         </tr>
		 <tr>
		   <td colspan=4 background="/images/banner_bottom.gif">
		      <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
				   <cfswitch expression="#Attributes.logoDisplay#">
				     <cfcase value="H">
					    <td width="307"><img src="/images/welcome_bottom.jpg" alt="" width="418" height="19" border="0"></td>
					 </cfcase>
					 <cfcase value="A">
					    <td width="307"><img src="/images/aboutus_bottom.jpg" width="418" height="19" alt="" border="0"></td>
					 </cfcase>
					 <cfcase value="M">
					    <td width="307"><img src="/images/MtgMaterials_Bottom.jpg" width="418" height="19" alt="" border="0"></td>
					 </cfcase>
					 <cfcase value="P">
					    <td width="307"><img src="/images/programReg_bottom.jpg" width="418" height="19" alt="" border="0"></td>
					 </cfcase>
					 <cfcase value="R">
					    <td width="307"><img src="/images/honoraria_bottom.jpg" width="418" height="19" alt="" border="0"></td>
					 </cfcase>
					 <cfcase value="S">
					    <td width="307"><img src="/images/privacy_bottom.jpg" width="418" height="19" alt="" border="0"></td>
					 </cfcase>
					 <cfcase value="L">
					    <td width="307"><img src="/images/Login_bottom.jpg" width="418" height="19" alt="" border="0"></td>
					 </cfcase>
					 <cfcase value="O">
					    <td width="307"><img src="/images/mod_bottom.jpg" alt="" width="418" height="19" border="0"></td>
					 </cfcase>
					 
					 <cfdefaultcase>
					    <td width="307"><img src="/images/welcome_bottom.jpg" width="418" height="19" alt="" border="0"></td>
					 </cfdefaultcase>
				   </cfswitch>
		       </tr>
             </table>           
		   </td>
		 </tr>
      </table> 