<cfapplication name="Onlinematerials"
	       clientManagement="yes"
	       sessionManagement="yes"
	       setclientcookies="yes"
	       sessionTimeOut="#CreateTimeSpan(0,0,45,0)#"
>

<cfif Not IsDefined("Application.SecureURL")>
   <cflock scope="APPLICATION" timeout="5" type="EXCLUSIVE">
	 <cfset Application.sitepath = "w:\websites\HealthCareDiscussions_com">
	 <cfset Application.SecureURL = "https://www.healthcarediscussions.com">
  </cflock>	
</cfif>