<cfif Not IsDefined("session.modInfo")>
  <cflocation url="moderator/index.cfm">
</cfif>
<cfparam name="URL.projectCode" default="">
<cfscript>
   if (Not IsDefined("Session.MaterialLogin")) {
        session.materialLogin = createobject("component", "onlinematerials.com.materials");
   }
   
   IsUserModerator = session.materialLogin.IsModerator(session.modInfo.rowID);
   
   if (IsUserModerator){
     //Check to see if the Moderator is on the superadmin list
	 IsSuperAdmin = session.materialLogin.CheckModAdmin(session.modInfo.rowID);
	 
	 if(IsSuperAdmin){
	    getMyMeetings = session.materialLogin.getAllMeetings(); 
	    Session.IsModerator = false;
	    Session.UserType = "A";
	 } else {
	   //Get the meetings the moderator is assigned to
         GetMyMeetings = session.materialLogin.GetModeratorMeetings(session.modInfo.mod_ID);
	  //set the Session.IsModerator Button to True and the usertype to M
	    Session.IsModerator = true;
	    Session.UserType = "M";
	 }
   } else {
     getMyMeetings = session.materialLogin.getAllMeetings(); 
	 Session.IsModerator = false;
	 Session.UserType = "A";
   }
   
</cfscript>

<!--- look up the Person to see if they are a moderator --->

<!--- If I am a moderator only show me my materials, otherwise show me all online materials --->

<cfmodule template="Includes/header.cfm" siteType="M" logoDisplay="O"> 
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	   <tr>
	     <cfoutput>
	       <td class="rightnav" valign="top" width="170">
		     <table border="0" cellpadding="3" cellspacing="0" width="170">
			   <tr>
			     <td colspan=2><br>
				   <img src="/images/selectamtg.gif" border="0" alt="select a meeting below"></td>
			   </tr>
			   <cfloop query="GetMyMeetings">
			     <tr>
				    <td width="5"></td>
			        <td><cfif Trim(URL.projectCode) NEQ Trim(GetMyMeetings.Project_Code)><a href="dsp_ModMaterials.cfm?projectCode=#trim(GetMyMeetings.project_Code)#">#trim(GetMyMeetings.project_Code)#</a><cfelse><strong style="font-size:11px; color:##969696;">#GetMyMeetings.project_Code#</strong></cfif></td>
			     </tr>
			   </cfloop>
			   <tr>
			     <td>&nbsp;</td>
			   </tr>
			   <tr>
			     <td colspan="2"><a href="logout.cfm?t=2" style="font-size:10px;">[Logout]</a></td>
			   </tr>
	         </table>           
		   </td>
		   </cfoutput>
		   <td width="1" background="images/vertdivider.gif"><img src="images/blank.gif" width="1" height="1" border="0"></td>
		   <td class="mainView" valign="top"><br>
		     <table border="0" cellpadding="4" cellspacing="0" width="100%" class="mainView">
	           <tr>
			     <td></td>
			   </tr>
			   <tr>
			      <cfoutput>
	              <td><h3>Welcome #session.modInfo.first_name# #session.modInfo.last_name#</h3>
				  </cfoutput>
				  <cfif URL.projectCode NEQ "">
				    
				    <cfset getMaterials = session.materialLogin.GetModMaterials(session.modInfo.mod_ID, URL.projectCode, Session.UserType)>
				    <cfoutput>
					<p>Below you will find the materials you will need for the <strong>#URL.ProjectCode#</strong> meeting.</p>
					</cfoutput>
					 <table border="0" cellpadding="3" cellspacing="0" width="100%">
                       <cfoutput query="getMaterials" group="MaterialType">
					     <tr <cfif getmaterials.MaterialType EQ "G">bgcolor="##336699"<cfelseif getmaterials.MaterialType EQ "M">bgcolor="##666600"<cfelseif getmaterials.MaterialType EQ "A">bgcolor="##006666"</cfif>>
						   <td colspan="2"><strong style="color:##ffffff;"><cfif getmaterials.MaterialType EQ "G">Participant Materials<cfelseif getmaterials.MaterialType EQ "M">Moderator Materials<cfelseif getmaterials.MaterialType EQ "A">Admin Materials</cfif></strong></td>
						 </tr>
					     <cfoutput>
						   <tr>
                             <td width="20" style="font-size:10px; color:##757575;"><img src="/images/pdf_icon_small.jpg" border="0" alt="Download The PDF" align="absmiddle">&nbsp;(#Round(evaluate(getMaterials.FileSize/1000))#&nbsp;KB)</td>
						     <td width="85%"><a href="act_showDoc.cfm?doc=#getMaterials.MaterialID#" target="_blank" style="color:##0000ff;">View #getMaterials.MaterialTitle#</a></td>
						   </tr>
						   <tr>
							 <td style="color:##818181;" colspan="2">#getMaterials.MaterialDesc#</td>
						   </tr>
						 </cfoutput>
						  <tr>
						    <td colspan="2">&nbsp;</td>
						  </tr>
					   </cfoutput>
				     </table>
					<cfelse>
					  <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                          <td><img src="/images/TotheLeft.gif" border="0" align="absmiddle"> Click on the link to the left to view materials for that program</td>
                        </tr>
                      </table>           
					  <br>
					  <hr noshade size="1">
					</cfif> 
					<br><br>
					<div style="font-family:verdana, Arial,Helvetica,sans-serif; font-size:10px;" align="center">
					<p style="font-size:11px;" align="left">
					   <strong>To View</strong> your materials, simply click the link of the materials you would like to view. <br>
					   <strong>To Download</strong> your materials, right-click on the link, select 'Save target as...' and save the document to your computer hard drive.
					</p> 
					<br>
					<p>Adobe<sup>&reg;</sup> Acrobat Reader or Plugin is required to view your Online Meeting Materials.<br><br>  
					   <a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank"><img src="/images/get_adobe_reader.gif" alt="Download Adobe Reader" border="0"></a>
					</p>   
				  </td>
	           </tr>
	         </table>      
		   </td>
	      </tr>
	   </table>
              
<br><br>
<cfmodule template="Includes/footer.cfm">