<cfparam name="url.doc" default="0" type="numeric">
<cfset MaterialInfo = session.MaterialLogin.getMaterialFiles(URL.Doc)>

<cfset ThisFilePath = "#Application.SitePath#\files\#trim(MaterialInfo.ProjectCode)#\#trim(MaterialInfo.FileName)#">

<cfif FileExists("#ThisFilePath#")>
 <cfif IsDefined("session.DoctorInfo")>
  <cfinvoke component="onlinematerials.com.materials" Method="SetLog">
	   <cfinvokeargument name="DateCreated" value="#now()#">
	   <cfinvokeargument name="Status" value="OK">
	   <cfinvokeargument name="Action" value="HCD DWNLD">
	   <cfinvokeargument name="message" value="#session.DoctorInfo.Firstname# #session.DoctorInfo.Lastname# #session.DoctorInfo.Zipcode# Downloaded #trim(MaterialInfo.ProjectCode)#\#trim(MaterialInfo.FileName)#">
	   <cfinvokeargument name="IPAddr" value="#CGI.REMOTE_ADDR#">
	   <cfinvokeargument name="UserID" value="#Session.DoctorInfo.Phid#">
	</cfinvoke> 
	
	     
	    <cfinvoke component="onlinematerials.com.materials" Method="setMaterialLog">
	       <cfinvokeargument name="Phid" value="#session.DoctorInfo.Phid#">
	       <cfinvokeargument name="firstname" value="#Session.DoctorInfo.Firstname#">
	       <cfinvokeargument name="lastname" value="#Session.DoctorInfo.lastname#">
	       <cfinvokeargument name="zipcode" value="#Session.DoctorInfo.zipcode#">
	       <cfinvokeargument name="logtype" value="dwnld">
	       <cfinvokeargument name="msgtext" value="Material Downloaded">
	       <cfinvokeargument name="meetingcode" value="#session.materialMeetingID#">
	       <cfinvokeargument name="materialID" value="#URL.Doc#">
	    </cfinvoke> 
	<cfelse>
	  <cfinvoke component="onlinematerials.com.materials" Method="SetLog">
	   <cfinvokeargument name="DateCreated" value="#now()#">
	   <cfinvokeargument name="Status" value="OK">
	   <cfinvokeargument name="Action" value="HCD MOD DWNLD">
	   <cfinvokeargument name="message" value="#session.modinfo.First_name# #session.ModInfo.Last_name# Downloaded #trim(MaterialInfo.ProjectCode)#\#trim(MaterialInfo.FileName)#">
	   <cfinvokeargument name="IPAddr" value="#CGI.REMOTE_ADDR#">
	   <cfinvokeargument name="UserID" value="#Session.ModInfo.rowid#">
	</cfinvoke> 	
	</cfif>
  <cfcontent type="application/pdf" file="#ThisFilePath#" deletefile="NO"> 
<cfelse>
  <cfmodule template="Includes/header.cfm">
    <br><br><br>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
       <tr>
          <td align="center" style="color:#cc0000; font-weight:bold;">The File you are attempting to download could not be found<br></td>
      </tr>
   </table>
   <cfoutput><!--<strong style="font-size:10px;">#ThisFilePath#</strong>--> </cfoutput> 
   <br><br><br>
   <br><br><br>
   <br><br><br>         
  <cfmodule template="Includes/footer.cfm">
</cfif>