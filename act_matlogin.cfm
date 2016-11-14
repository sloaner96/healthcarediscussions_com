<!--- Check the forms for errors --->
<cfif Len(Trim(form.MeetingID)) EQ 0>
  <cflocation url="dsp_login.cfm?e=1&M=&P=#Form.PHID#" addtoken="No">
</cfif>

<cfif Len(trim(form.PHID)) EQ 0 AND (len(trim(form.firstname)) EQ 0 AND len(trim(form.lastname)) EQ 0 AND len(trim(form.zipcode)) EQ 0)>
  <cflocation url="dsp_login.cfm?e=3" addtoken="No">
</cfif>

<!--- Initialize the component --->
<cfobject name="session.materialLogin" component="onlinematerials.com.materials"> 

<!--- Check the Meeting ID against the database --->
<cfset CheckMeeting = session.materialLogin.CheckMeetingCode(Form.MeetingID)>
<!--- <cfif IsDefined("session.DoctorInfo")>
  <cfset session.DoctorInfo.Firstname = "">
  <cfset session.DoctorInfo.Lastname = "">
  <cfset session.DoctorInfo.ZipCode = "">
  <cfset session.DoctorInfo.Salutation = "">
  
</cfif> --->
<!--- If the Meeting Code is bad kick them back with an error --->
<cfif NOT CheckMeeting>
  <cflocation url="dsp_login.cfm?e=1" addtoken="No">
</cfif>

<!--- Check the PHID against the database --->
<cfif Len(Trim(form.PHID)) GT 0>
   
   <cfset ThisDoctorInfo = session.materialLogin.getDoctorInfo(Form.PHID)>

   <cfif ThisDoctorInfo.Recordcount EQ 0>
      <cflocation url="dsp_login.cfm?e=2&M=#form.meetingID#&P=#Form.PHID#" addtoken="No">
   <cfelse>
	    <cflock scope="session" timeout="5" type="exclusive">
		  <cfset session.DoctorInfo.Phid = thisDoctorInfo.Phid>
	      <cfset session.DoctorInfo.Firstname = ThisDoctorInfo.FirstName>
	  	  <cfset session.DoctorInfo.Lastname = ThisDoctorInfo.LastName>
	      <cfset session.DoctorInfo.ZipCode = ThisDoctorInfo.shipto_ZipCode>
		</cflock>
	
		<cfinvoke component="onlinematerials.com.materials" Method="SetLog">
		   <cfinvokeargument name="DateCreated" value="#now()#">
		   <cfinvokeargument name="Status" value="OK">
		   <cfinvokeargument name="Action" value="HCD PHID Login">
		   <cfinvokeargument name="message" value="(#Session.DoctorInfo.Phid#) #session.DoctorInfo.Firstname# #session.DoctorInfo.Lastname# Logged into Healthcare Discussions.com using their PHID and Meeting Code #UCASE(Form.MeetingID)#">
		   <cfinvokeargument name="IPAddr" value="#CGI.REMOTE_ADDR#">
		   <cfinvokeargument name="UserID" value="#Session.DoctorInfo.Phid#">
		   <cfinvokeargument name="UserAgent" value="#CGI.HTTP_USER_AGENT#">
		</cfinvoke>
	
	    <cfinvoke component="onlinematerials.com.materials" Method="setMaterialLog">
	       <cfinvokeargument name="Phid" value="#session.DoctorInfo.Phid#">
	       <cfinvokeargument name="firstname" value="#UCASE(Session.DoctorInfo.Firstname)#">
	       <cfinvokeargument name="lastname" value="#UCASE(Session.DoctorInfo.lastname)#">
	       <cfinvokeargument name="zipcode" value="#Session.DoctorInfo.zipcode#">
	       <cfinvokeargument name="logtype" value="Plogn">
	       <cfinvokeargument name="msgtext" value="Logged In With PHID">
	       <cfinvokeargument name="meetingcode" value="#UCASE(Form.MeetingID)#">
	       <cfinvokeargument name="materialID" value="0">
	     </cfinvoke> 
   </cfif>
</cfif>

<!--- If no Phid Insert the entered information into the audit log --->
<cfif Len(Trim(form.PHID)) EQ 0>
  <cfif len(trim(form.firstname)) EQ 0>
    <cflocation url="dsp_login.cfm?e=3" addtoken="No">
  </cfif>
  <cfif len(trim(form.lastname)) EQ 0>
    <cflocation url="dsp_login.cfm?e=3" addtoken="No">
  </cfif>
  <cfif len(trim(form.zipcode)) EQ 0>
    <cflocation url="dsp_login.cfm?e=3" addtoken="No">
  </cfif>
	
	<cflock scope="SESSION" type="EXCLUSIVE" timeout="5">
	    <cfset session.DoctorInfo.Phid = 0>
		<cfset session.DoctorInfo.Firstname = form.firstname>
		<cfset session.DoctorInfo.Lastname = form.lastname>
		<cfset session.DoctorInfo.ZipCode = form.zipcode>
	</cflock>
	<!--- PlaceHolder for Database insert --->
	<cfinvoke component="onlinematerials.com.materials" Method="SetLog">
	   <cfinvokeargument name="DateCreated" value="#now()#">
	   <cfinvokeargument name="Status" value="OK">
	   <cfinvokeargument name="Action" value="HCD Login">
	   <cfinvokeargument name="message" value="#session.DoctorInfo.Firstname# #session.DoctorInfo.Lastname# #session.DoctorInfo.Zipcode# Logged into Healthcare Discussions.com using their Firstname, Lastname, zipcode and Meeting Code #UCASE(Form.MeetingID)#">
	   <cfinvokeargument name="IPAddr" value="#CGI.REMOTE_ADDR#">
	   <cfinvokeargument name="UserID" value="0">
	</cfinvoke>
	<cfinvoke component="onlinematerials.com.materials" Method="setMaterialLog">
	       <cfinvokeargument name="Phid" value="#session.DoctorInfo.Phid#">
	       <cfinvokeargument name="firstname" value="#UCASE(Session.DoctorInfo.Firstname)#">
	       <cfinvokeargument name="lastname" value="#UCASE(Session.DoctorInfo.lastname)#">
	       <cfinvokeargument name="zipcode" value="#UCASE(Session.DoctorInfo.zipcode)#">
	       <cfinvokeargument name="logtype" value="login">
	       <cfinvokeargument name="msgtext" value="Logged In NO PHID">
	       <cfinvokeargument name="meetingcode" value="#UCASE(Form.MeetingID)#">
	       <cfinvokeargument name="materialID" value="0">
	    </cfinvoke> 
</cfif>

<!--- If They are allowed in let them in, otherwise kick them back with a error --->

   <cfset session.materialMeetingID = form.meetingID>
   <cflocation url="dsp_showMeeting.cfm" addtoken="No">



