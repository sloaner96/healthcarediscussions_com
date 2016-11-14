<cfcomponent displayname="Materials" hint="This controls the materials section">
   <!--- 
      Initiatize the component with the datasource
	--->
	
   <cfset init()>
	
   <cffunction name="init" access="public" returntype="boolean" displayname="init" description="This is used to initialize the component">
      <cfset instance = structNew()>
	  
	  <cfset instance.datasource = "projman">
	  <cfset instance.ModLoginDSN = "hourday">
	  
	  <cfset instance.initialized = true>
	  <cfreturn instance.initialized />
   </cffunction>
   
   <!-------------------------------------------------------------------
      Check the passed meeting code against the DB to see if it is valid  
     ------------------------------------------------------------------->
   <cffunction name="CheckMeetingCode" access="public" returntype="boolean" displayname="CheckMeetingCode" description="This is used to check that the meeting code is valid">
      <cfargument name="meetingCode" required="YES">
	  
	  <cfquery name="CheckMtgCode" datasource="#instance.datasource#">
	    Select Top 1 Project_code
		From PIW
		Where Project_code = <cfqueryparam value="#arguments.meetingcode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">  
	  </cfquery>
	  <cfif checkMtgCode.recordcount GT 0>
	     <cfset MtgCodeValid = true>
	  <cfelse>
	     <cfset MtgCodeValid = false>	 
	  </cfif>
	  
	  <cfreturn MtgCodeValid />
   </cffunction>
   
   <!----------------------------------------------------------------- 
        Set the Log for Users logging in and for 
    ------------------------------------------------------------------>
   <cffunction name="setLog" access="public" returntype="void" displayname="setLog" description="This function logs user interaction.">
      <cfargument name="DateCreated" type="string" required="YES">
	  <cfargument name="Status" type="string" required="YES">
	  <cfargument name="Action" type="string" required="YES">
	  <cfargument name="message" type="string" required="YES">
	  <cfargument name="IPAddr" type="string" required="YES">
	  <cfargument name="UserAgent" type="string" required="NO">
	  <cfargument name="UserID" type="string" required="NO">
	  
	  <cfquery name="getproj" datasource="#instance.datasource#">
	    Insert Into AuditLog(
		  Status,
		  ActionMsg,
		  Message,
		  IPAddress,
		  UserAgent,
		  UserID, 
		  DateCreated
		)
		 VALUES(
		   '#Arguments.Status#', 
		   '#Arguments.Action#', 
		   '#Arguments.Message#', 
		   '#Arguments.IPAddr#',
		   <cfif IsDefined("Arguments.UserAgent")> 
		    '#Arguments.UserAgent#', 
		   <cfelse>
		    NULL, 
		   </cfif>
		   <cfif IsDefined("Arguments.UserID")>
		     #Arguments.UserID#,
		   <cfelse>
		    NULL,  
		   </cfif>
		   
		   #CreateODBCDateTime(Arguments.DateCreated)#
		   )
	  </cfquery>
   </cffunction>
   
      <!----------------------------------------------------------------- 
        Set the Log for Users logging in and for 
    ------------------------------------------------------------------>
   <cffunction name="setMaterialLog" access="public" returntype="void" displayname="setLog" description="This function logs user interaction.">
      <cfargument name="Phid" type="numeric" required="NO">
	  <cfargument name="firstname" type="string" required="NO">
	  <cfargument name="lastname" type="string" required="NO">
	  <cfargument name="zipcode" type="string" required="NO">
	  <cfargument name="logtype" type="string" required="YES">
	  <cfargument name="msgtext" type="string" required="YES">
	  <cfargument name="meetingcode" type="string" required="YES">
	  <cfargument name="MaterialID" type="numeric" required="YES">
	  
	  <cfquery name="setMatLog" datasource="#instance.datasource#">
	    Insert Into MaterialLog(
		  PHID,
		  Firstname,
		  Lastname,
		  ZipCode,
		  LogType,
		  Msgtext,
		  MeetingCode,
		  MaterialID
		)
		 VALUES(
		    #Arguments.Phid#,
		    '#Arguments.Firstname#',
			'#Arguments.Lastname#',
			'#Arguments.ZipCode#', 
		   '#Arguments.LogType#',
		   <cfif IsDefined("Arguments.msgtext")>'#Arguments.msgtext#'<cfelse>NULL</cfif>,
		   '#Arguments.MeetingCode#',
		   #Arguments.MaterialID#
		   )
	  </cfquery>
   </cffunction>
   <!----------------------------------------------------------------- 
        Get the meeting information based on the passed meeting code 
    ------------------------------------------------------------------>
   <cffunction name="getMeeting" access="public" returntype="query" displayname="getMeeting" description="This function retreives the meeting information.">
      <cfargument name="meetingCode" type="string" required="YES">
	  
	  <cfquery name="getproj" datasource="#instance.datasource#">
	    Select *
		From PIW
		Where Project_code = <cfqueryparam value="#arguments.meetingcode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20"> 
	  </cfquery>
	  
	  <cfreturn getproj />
   </cffunction>
   
   <!--------------------------------------------------------- 
        Check the doctors information based on the PHID passed 
	 --------------------------------------------------------->
   <cffunction name="getDoctorInfo" access="public" returntype="query" displayname="getDoctorInfo" description="This function retreives the doctor info.">
      <cfargument name="Phid" type="numeric" required="YES">
	  
	  <cfquery name="getdoc" datasource="DBMASTER">
	    Select P.*, S.address1, S.address2, S.city, S.state, S.zip as shipto_zipCode
		From physician P, dbo.physicianshipto S
		Where P.Phid = S.Phid 
		AND P.PHID = <cfqueryparam value="#arguments.PHID#" cfsqltype="CF_SQL_INTEGER" maxlength="20"> 
	  </cfquery>
	  
	  <cfreturn getdoc />
   </cffunction>
   
     <!--------------------------------------------------------- 
        Check the doctors Roster Information on the PHID passed 
	 --------------------------------------------------------->
   <cffunction name="getDoctorMtgs" access="public" returntype="query" displayname="getDoctorMtgs" description="This function retreives the Meetings this Doctor is attending now or in the future.">
      <cfargument name="Phid" type="numeric" required="YES">
	  
	  <cfquery name="getdocmtg" datasource="CBAROSTER">
	    Select Distinct Left(EventKey, 9) as ProjectID, C.Phid, C.EventDateTime, P.guide_topic, DateDiff(mm, C.eventdateTime, getdate()) as MonthBetween
		From CI_DB C, pmsProd.dbo.piw P, pmsProd.dbo.Materials_info M
		Where Left(C.EventKey, 9) = RTrim(LTrim(P.Project_Code))
		AND P.Project_Code = M.ProjectCode
		AND C.PHID = <cfqueryparam value="#arguments.PHID#" cfsqltype="CF_SQL_INTEGER" maxlength="20"> 
		AND C.Status IN ('Scheduled', 'Rescheduled')
		AND DateDiff(mm, C.eventdateTime,getdate()) <=12
		Order By C.EventDateTime, 1
		
	  </cfquery>
	  
	  <cfreturn getdocmtg />
   </cffunction>
   <!------------------------------------------------------------- 
        Get all the meeting dates based on the meeting code passed  
	 ------------------------------------------------------------>
   <cffunction name="getMeetingDates" access="public" returntype="query" displayname="getMeetingDates" description="This function retreives the meeting dates.">
      <cfargument name="meetingCode" type="string" required="YES">
	  
	  <cfquery name="getmtgDate" datasource="#instance.datasource#">
	    Select S.MeetingDate, S.ScheduleID, P.Project_Code
		From PIW P, ScheduleMaster S
		Where P.Project_code = S.ProjectID
		AND P.Project_code = <cfqueryparam value="#arguments.meetingcode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20"> 
	    AND s.MeetingDate > = #CreateODBCDate(DateAdd('d', -60, now()))#
		Order By sMeetingDate 
	  </cfquery>
	  
	  <cfreturn getmtgDate />
   </cffunction>
   
   <!--- Get Materials --->
    <cffunction name="getMaterials" access="public" returntype="query" displayname="getMeetingDates" description="This function retreives the Materials.">
      <cfargument name="meetingCode" type="string" required="YES">
	  
	  <cfquery name="getmaterialInfo" datasource="#instance.datasource#">
	    SELECT M.*
		 From Materials_info M
		 Where M.ProjectCode = '#Arguments.meetingCode#'
		 and MaterialType = 'G'
		 AND Exists (Select rowid 
		               FROM dbo.client_proj
					   Where Rtrim(client_proj) = M.ProjectCode
					   AND status IN (1, 2)) 
		 AND LastSync IS NOT NULL
	  </cfquery>
	  
	  <cfreturn getmaterialInfo />
   </cffunction>
   
   <cffunction name="getMaterialFiles" access="public" returntype="query" displayname="getMeetingDates" description="This function retreives the Materials.">
      <cfargument name="MaterialID" type="string" required="YES">
	  
	  <cfquery name="getmaterialInfo" datasource="#instance.datasource#">
	    SELECT M.*
		 From Materials_info M
		 Where MaterialID = #Arguments.MaterialID#
	  </cfquery>
	  
	  <cfreturn getmaterialInfo />
   </cffunction>
   
   <!--- //////////////////////////////
      This is the Moderator Area
   //////////////////////////////// --->
     <!--- Moderator Login Function --->
     <cffunction name="ModeratorLogin" access="public" returntype="query">
      <cfargument name="username" type="string" required="YES">
	  <cfargument name="password" type="string" required="YES">
	  
	  <cfquery name="getmodlogin" datasource="#instance.ModLoginDSN#">
	    Select *
		From user_id
		Where user_login = <cfqueryparam value="#Arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		AND password = <cfqueryparam value="#Arguments.password#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	  </cfquery>
	  
	  <cfreturn getmodlogin />
   </cffunction>
      
   <!--- Check to see if the user is a moderator --->
    <cffunction name="IsModerator" access="public" returntype="boolean">
      <cfargument name="moderatorID" type="numeric" required="YES"> 
	  
	  <cfquery name="getmodInfo" datasource="#instance.ModLoginDSN#">
	    Select *
		From User_ID
		Where rowID = #Arguments.moderatorID# AND mod_ID <> 0 
	  </cfquery>
	  <cfif getModInfo.recordcount EQ 0>
	    <cfset IsMod = false>
	  <cfelse>
	  	<cfset IsMod = true>
	  </cfif>
	  <cfreturn IsMod />
    </cffunction>
	
	<!--- Get the Moderators programs --->
    <cffunction name="GetModeratorMeetings" access="public" returntype="query">
      <cfargument name="moderatorID" type="numeric" required="YES"> 
	  
	  <cfquery name="GetModMeetings" datasource="#instance.datasource#">
	    Select Distinct c.client_proj as Project_Code
		From client_proj C, Speaker.dbo.SpeakerClients s
		WHERE s.SpeakerID =  #Arguments.moderatorID#
		AND s.Type = 'MOD'
	        AND Left(c.client_proj, 5) = Left(s.ClientCode, 5)
			AND C.Status IN (2, 3)
		    AND Exists (Select Top 1 MaterialID 
			From dbo.Materials_info Where ProjectCode = Rtrim(c.client_proj))
		ORDER BY c.client_proj
	  </cfquery>
	  <cfreturn GetModMeetings />
    </cffunction>
	
	<cffunction name="GetModMaterials" access="Public" returnType="Query">
	  <cfargument name="moderatorID" type="string" required="YES"> 
	  <cfargument name="ProjectCode" type="string" required="YES"> 
	  <cfargument name="UserType" type="string" required="YES"> 
	  
	   <cfquery name="GetModMaterials" datasource="#instance.datasource#">
	     SELECT M.*
		 From Materials_info M
		 Where M.ProjectCode = '#Arguments.ProjectCode#'
		 AND M.LastSync IS NOT NULL
		 <cfif Arguments.UserType EQ "M">
		    AND MaterialType <> 'A'
			AND Exists (SELECT Top 1 c.client_proj
		                   From client_proj C, Speaker.dbo.SpeakerClients s
		                   WHERE s.SpeakerID =  #Arguments.moderatorID#
		                   AND s.Type = 'MOD'
	                       	   AND c.client_proj = s.ClientCode
			           AND C.Status IN (2, 3)
				   AND C.client_proj = '#Arguments.projectCode#')
		</cfif>
		order By ProjectCode, MaterialType, LastSync
	   </cfquery>
	   <cfreturn GetModMaterials />
	</cffunction>
	
	<!--- Get All the programs --->
    <cffunction name="getAllMeetings" access="public" returntype="query">
	  
	  <cfquery name="getMeetings" datasource="#instance.datasource#">
	     SELECT Distinct S.ProjectID as Project_code
	     FROM  ScheduleMaster S
			WHERE Exists (Select Top 1 MaterialID 
			From Materials_info Where ProjectCode = ProjectID)		 
		ORDER BY ProjectID
	  </cfquery>
	  
	  <cfreturn getMeetings />
    </cffunction>
	
	<!--- Check to see if the user is a Moderator admin--->
    <cffunction name="CheckModAdmin" access="public" returntype="boolean">
	  <cfargument name="moderatorID" type="string" required="YES">
	  <cfquery name="CheckMod" datasource="#instance.datasource#">
	     Select * 
		 From MaterialsAdmin
		 Where UserID = #Arguments.ModeratorID#
	  </cfquery>
	  
	  <cfif checkmod.recordcount EQ 0>
	    <cfset ModIsAdmin = False>
	  <cfelse>
	    <cfset ModIsAdmin = True>	
	  </cfif>
	  
	  <cfreturn ModIsAdmin />
    </cffunction>
</cfcomponent>