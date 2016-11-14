<cfcomponent displayname="projects" output="No">
   
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "projects_cfc">

	<!--- Constructor --->
	<cfset init()>
				
	<!--- Initialize datasources --->
	<cfset instance.projdsn = "Projman">
	<cfset instance.rosterdsn = "CBARoster">
	
   <!---************************* 
      Initialize the component 
     ************************--->
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
   
  <!---***************************************
	Get the Pharmakon staff ID and Type  
   ***************************************--->
   <cffunction name="getStaffID" access="public" returntype="query">
       <cfargument name="project_code" type="string" required="yes">
	   <cfargument name="StaffType" type="string" required="no">
	   
	    <cfquery name="getspeakerid" datasource="#instance.projdsn#">
			select Distinct SpeakerID, Type
			FROM ScheduleSpeaker
			WHERE left(MeetingCode, 9) = '#arguments.project_code#' 
			AND type = #arguments.StaffType#
			AND SpeakerID IS NOT NULL
			AND SpeakerID <> ' '
			ORDER BY SpeakerID, Type
		</cfquery>	  
		<cfreturn getSpeakerID />
   </cffunction>
   
   
</cfcomponent>