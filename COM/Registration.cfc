<cfcomponent name="Registration" output="No">
     <!--- 
      Initiatize the component with the datasource
	--->
	
   <cfset init()>
	
   <cffunction name="init" access="public" returntype="boolean" displayname="init" description="This is used to initialize the component">
      <cfset instance = structNew()>
	  
	  <cfset instance.datasource = "projman">
	  <cfset instance.ModLoginDSN = "hourday">
	  <cfset instance.RosterLogin = "DBMASTER">
	  
	  <cfset instance.initialized = true>
	  <cfreturn instance.initialized />
   </cffunction>

   <cffunction name="getDocInfo" access="Public" returnType="query" description="Use this to get info about the doctor" output="No">
	   <cfargument name="PhID" type="Numeric" required="YES">
	   
	   <cfset var getDoc = "">
	    <cfquery name="getDoc" datasource="#instance.RosterLogin#">
		    SELECT P.Phid, P.Menum, P.Firstname, P.MiddleName, P.Lastname, 
			       C.Phone1, C.Phone2, C.faxNo, C.EmailID, 
			       C.CETPhone, A.Address1, A.Address2, A.City, A.State, A.Zip,
			       S.Address1 as ShipAddr1, S.Address2 as ShipAddr2, S.City as ShipCity, S.State as ShipState, S.Zip as ShipZip
			FROM  
			       Physician P, PhysicianContact C, PhysicianShipTo S, PhysicianAddress A
			WHERE 
			       P.Phid = C.Phid
			    AND 
			       P.Phid = S.Phid
			    AND 
			       P.Phid = A.Phid
			    AND 
			       P.Phid = #arguments.phid#   
			 order BY lastname, Firstname  
	    </cfquery>
	   
	    <cfreturn getDoc />
   </cffunction>
   
    <cffunction name="UpdateDocInfo" access="Public" returnType="boolean" description="Use this to update info about the doctor" output="No">
	   <cfargument name="PhID"       type="Numeric" required="YES">
	   <cfargument name="MENUM" 	 type="String"  required="NO">
	   <cfargument name="Firstname"  type="String"  required="YES">
	   <cfargument name="Middlename" type="String"  required="YES">
	   <cfargument name="Lastname" 	 type="String"  required="YES">
	   <cfargument name="Phone1"     type="Numeric" required="YES">
	   <cfargument name="Phone2"     type="Numeric" required="NO">
	   <cfargument name="FaxNo"      type="Numeric" required="NO">
	   <cfargument name="Email"      type="String"  required="NO">
	   <cfargument name="CetPhone"   type="Numeric" required="NO">
	   <cfargument name="Addr1"      type="String"  required="YES">
	   <cfargument name="Addr2"      type="String"  required="YES">
	   <cfargument name="City"       type="String"  required="YES">
	   <cfargument name="State"      type="String"  required="YES">
	   <cfargument name="ZipCode"    type="String"  required="YES">
	   <cfargument name="ShipAddr1"  type="String"  required="NO">
	   <cfargument name="ShipAddr2"  type="String"  required="NO">
	   <cfargument name="ShipCity"   type="String"  required="NO">
	   <cfargument name="ShipState"  type="String"  required="NO">
	   <cfargument name="ShipZip"    type="String"  required="NO">
	   
	   <cfset CommitIt = true>
	   
	   <cftransaction action="BEGIN">
		   <cftry>
			    <cfquery name="UpdatePhysician" datasource="#instance.RosterLogin#">
				   UPDATE Physician
				     SET Menum      = <cfif IsDefined("Arguments.MEnum")>'#arguments.MENUM#'<cfelse>NULL</cfif>,
						 Firstname  = '#arguments.firstName#',
						 MiddleName = <cfif IsDefined("Arguments.MiddleName")>'#arguments.MiddleName#'<cfelse>NULL</cfif>,
						 Lastname   = '#Arguments.Lastname#'
					WHERE Phid = #arguments.phid#   
			    </cfquery>
				
			    <cfquery name="UpdateContact" datasource="#instance.RosterLogin#">
				    UPDATE PhysicianContact
					  SET  Phone1   = <cfif IsDefined("Arguments.Phone1")>'#Arguments.Phone1#'<cfelse>NULL</cfif>, 
					       Phone2   = <cfif IsDefined("Arguments.Phone2")>'#Arguments.Phone2#'<cfelse>NULL</cfif>, 
						   faxNo    = <cfif IsDefined("Arguments.FaxNo")>'#Arguments.FaxNo#'<cfelse>NULL</cfif>, 
						   EmailID  = <cfif IsDefined("Arguments.Email")>'#Arguments.Email#'<cfelse>NULL</cfif>
					       <!--- CETPhone = <cfif IsDefined("Arguments.CETPhone")>'#Arguments.CETPhone#'<cfelse>NULL</cfif> ---> 
					WHERE Phid = #arguments.phid#  
			    </cfquery>
				
				<cfquery name="UpdateAddress" datasource="#instance.RosterLogin#">
				    UPDATE PhysicianAddress 
					   SET Address1 = '#Arguments.addr1#', 
					       Address2 = <cfif IsDefined("Arguments.addr2")>'#Arguments.addr2#'<cfelse>NULL</cfif>, 
						   City     = '#Arguments.city#', 
						   State    = '#Arguments.state#', 
						   Zip      = '#Arguments.ZipCode#'
					 WHERE Phid = #arguments.phid# 
			    </cfquery>
				
				<cfif ISDefined("Arguments.Shipaddr1")>
					<cfquery name="UpdateShipTo" datasource="#instance.RosterLogin#">
					   UPDATE PhysicianShipTo 
						 SET   Address1 = '#Arguments.Shipaddr1#', 
						       Address2 = <cfif IsDefined("Arguments.Shipaddr2")>'#Arguments.Shipaddr2#'<cfelse>NULL</cfif>, 
							   City     = '#Arguments.Shipcity#', 
							   State    = '#Arguments.Shipstate#', 
							   Zip      = '#Arguments.ShipZip#'
						WHERE Phid = #arguments.phid#  
				    </cfquery>
			   </cfif>
			   
			   
			<cfcatch type="Any">
			  <cftransaction action="ROLLBACK" />
			  <cfset commitIt = False>
			</cfcatch>
			
			</cftry>
			
			<cfif CommitIt>
			   <cftransaction action="COMMIT" />
			</cfif>
		</cftransaction>
		
		<cfreturn CommitIt />
   </cffunction>

</cfcomponent>