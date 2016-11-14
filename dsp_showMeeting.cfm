<cfif Not ISDefined("Session.materialMeetingID")>
  <cflocation url="dsp_login.cfm" addtoken="no">
</cfif>

 <!--- initialize the project --->
	<CFOBJECT COMPONENT="onlinematerials.com.project"
	          NAME="project">	
	<CFOBJECT COMPONENT="onlinematerials.com.speaker"
	          NAME="speakers">
			  
<cfif IsDefined("form.mtgDates")>
  <cfset session.materialMeetingID = form.mtgDates>
</cfif>			  

<cfset ThisMeeting = session.MaterialLogin.getMeeting(session.materialMeetingID)>

<cfif IsDefined("session.DoctorInfo.Phid")>
   <cfset Mtgdates = session.MaterialLogin.getDoctorMtgs(session.DoctorInfo.Phid)>		
</cfif>

<cfset getMaterials = session.MaterialLogin.getMaterials(session.materialMeetingID)>  

<cfmodule template="Includes/header.cfm" logoDisplay="M"> 
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
       <cfif session.DoctorInfo.Phid NEQ 0>
	       <td class="rightnav" valign="top" width="170">
		     <table border="0" cellpadding="3" cellspacing="0" width="170">
			   <tr>
			     <td><cfif IsDefined("Mtgdates")>
				        <cfif MtgDates.recordcount GT 0>
						  <div style="font-family:verdana, Arial,Helvetica,sans-serif; font-size:11px;padding-right:4px;">
						   <br>
						   <img src="/images/selectamtg.gif" border="0" alt="select a meeting below">
								
									
										<!--- <cfdump var="#MtgDates#"> --->
										  <div>
											  
											   <br>Select another meeting you are registered for to view materials.
											
												<form name="chngMeeting" action="act_getMeeting.cfm" Method="POST">
													<select name="mtgdate" style="font-size:10px;" onchange="form.submit();">
													 <option value="">--select one--</option>
													 <cfoutput query="MtgDates"> 
													 <option value="#MtgDates.ProjectID#">#DateFormat(MtgDates.EventDateTime, 'mm/dd/yy')#-#Left(Trim(MtgDates.guide_topic), 30)#...</option>
													 </cfoutput>
													</select> 
												</form>
											  
									      </div>
								   
							    <br>
						  </div>
						</cfif>	
					 </cfif>	
					  <div align="center">
					     <br>
						 <a href="dsp_Myinfo.cfm"><img src="/images/infoCorrectBanner.jpg" border="0" alt="Alert: Do We have your information correct?"></a>
					  </div>  
					  <div align="center">
					     <br><br>
						 <a href="logout.cfm?t=1">[ Logout ]</a>
					  </div>  
					  
				 </td>
			   </tr>
	         </table>           
		   </td>
	     <td width="1" background="images/vertdivider.gif"><br><img src="images/blank.gif" width="12" height="1" border="0"></td>
	   </cfif>
	   <td class="mainView" valign="top"><br>
	     <table border="0" cellpadding="4" cellspacing="0" width="100%" class="mainView">
           <tr>
              <td class="mainView">
			     <cfoutput>
					<h3>WELCOME <cfif Len(Trim(Session.DoctorInfo.Firstname)) GT 0>#trim(Session.DoctorInfo.Firstname)# #trim(session.DoctorInfo.Lastname)#</cfif><cfif IsDefined("Session.DoctorInfo.degree")><cfif len(trim(Session.Doctorinfo.degree)) GT 0>#trim(session.doctorInfo.degree)#</cfif></cfif> </h3>
							
					<p>Thank you for registering for the <cfif left(session.materialMeetingID,1) EQ "C">C. Beck<cfelseif left(session.materialMeetingID,1) EQ "E">Edcomm HC<cfelseif left(session.materialMeetingID,1) EQ "G">Group Dynamics<cfelseif left(session.materialMeetingID,1) EQ "P">Pharmakon<cfelseif left(session.materialMeetingID,1) EQ "S">Sharecom<cfelseif left(session.materialMeetingID,1) EQ "V">Vistacom</cfif> program <strong>#ThisMeeting.guide_topic#</strong></p>
					<cfif getmaterials.recordcount GT 0>
						<p>Below you will find the materials you can download or view for your meeting.</p>
						<table border="0" cellpadding="3" cellspacing="0" width="100%">
	                      <cfloop query="getMaterials">
							<tr>
	                           <td width="15%" style="font-size:10px; color:##757575;"><img src="/images/pdf_icon_small.jpg" border="0" alt="Download The PDF" align="absmiddle">&nbsp;(#Round(evaluate(getMaterials.FileSize/1000))#&nbsp;KB)</td>
							   <td width="85%"><a href="act_showDoc.cfm?doc=#getMaterials.MaterialID#" target="_blank" style="color:##0000ff;">View #getMaterials.MaterialTitle# Guide Book</a></td>
						    </tr>
							<tr bgcolor="##eeeeee">
							   <td style="color:##666666;" colspan="2">#getMaterials.MaterialDesc#</td>
							</tr>
						  </cfloop>
					    </table>           
						<!---<br>
						<cfset getSpkr = project.getStaffID(session.materialMeetingID, 2)>	
						 <table border="0" cellpadding="3" cellspacing="0" width="100%" style="font-family:verdana, Arial,Helvetica,sans-serif; font-size:11px;">
						   <tr bgcolor="##336699">
						       <td><strong style="color:##ffffff;font-size:12px;">Speaker(s) Info:</strong></td>
						   </tr>
						  </table>           
						   <table border="0" cellpadding="3" cellspacing="0" width="100%">
                             <cfloop query="getSpkr">
							   <tr>
                                 <td width="5">&nbsp;</td> 
							     <td><cfset getSpkrName = speakers.getSpeaker(getSpkr.staff_id)>
							         - <cfif Len(Trim(getSpkrName.Salutation)) NEQ "">#getSpkrName.Salutation#</cfif> #getSpkrName.firstname# #getSpkrName.lastname#<cfif Len(Trim(getSpkrName.Degree)) GT 0>, #getSpkrName.Degree#</cfif>
						         </td>
                               </tr>
						     </cfloop> 
                             </table> --->           
							    <br><br>
								<div style="font-family:verdana, Arial,Helvetica,sans-serif; font-size:10px;" align="center">
							    <p style="font-size:11px;" align="left">
								<strong>To View</strong> your materials, simply click the link of the materials you would like to view. <br>
								<strong>To Download</strong> your materials, right-click on the link, select 'Save target as...' and save the document to your computer hard drive.
								</p> <br>
							    Adobe<sup>&reg;</sup> Acrobat Reader or Plugin is required to view your Online Meeting Materials.<br><br>  
							    <a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank"><img src="/images/get_adobe_reader.gif" alt="Download Adobe Reader" border="0"></a>
						        </div>
				   <cfelse>
				     <table border="0" cellpadding="3" cellspacing="0" width="100%">
					    <tr>
						  <td align="center" style="color:##848484;"><img src="/images/warning.gif" alt="" border="0" align="absmiddle"> The materials for this program are not currently available. Please check back again soon.</td>
						</tr>	
						<tr>
						  <td>&nbsp;</td>
						</tr>  
					 </table>	
				    </cfif>		
				</cfoutput>	
			  </td>
           </tr>
         </table>           
	   </td>
      </tr>
   </table>           
<br><br>
<cfmodule template="Includes/footer.cfm">