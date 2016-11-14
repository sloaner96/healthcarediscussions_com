<cfif IsDefined("session.DoctorInfo.Phid")>
 <cfscript>
   registration = createobject("component", "onlinematerials.com.registration");
   Util = createobject("component", "onlinematerials.com.utilities");
   
   getDocInfo = registration.getDocInfo(session.DoctorInfo.Phid);
   getStates  = Util.getStates();
 </cfscript>	
  	
<cfelse>
   <cflocation url="dsp_ShowMeeting.cfm" addtoken="NO">
</cfif>

<cfinclude template="Includes/FORMATPHONE.cfm">

<!--- Format The Numbers --->
	 <cfif Len(trim(getDocInfo.Phone1))>
	    <cfset Thisphone1 = formatPhone(trim(getDocInfo.Phone1))>
	 <cfelse>
	    <cfset Thisphone1 ="">
	 </cfif>
	 
	 <cfif Len(trim(getDocInfo.Phone2))>
	    <cfset Thisphone2 = formatPhone(trim(getDocInfo.Phone2))>
	 <cfelse>
	    <cfset Thisphone2 ="">
	 </cfif>
	 
	 <cfif Len(trim(getDocInfo.FaxNo))>
	    <cfset ThisFax = formatPhone(trim(getDocInfo.FaxNo))>
	 <cfelse>
	    <cfset ThisFax ="">
	 </cfif>
	 
	 <cfif Len(trim(getDocInfo.CETPhone))>
	    <cfset ThisCET = formatPhone(Trim(getDocInfo.CETPhone))>
	 <cfelse>
	    <cfset ThisCET ="">
	 </cfif>
	 
<cfmodule template="Includes/header.cfm" logoDisplay="M"> 
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
       <td class="rightnav" valign="top" width="170">
	     <table border="0" cellpadding="3" cellspacing="0" width="170">
		   <tr>
		     <td>
				  <div style="font-family:verdana, Arial,Helvetica,sans-serif; font-size:11px;padding-right:4px;">
				    <img src="images/myInfo.gif" width="198" height="28" alt="Update My Information" border="0"><br>
					  <a href="dsp_showMeeting.cfm"><< Back to Materials Page</a>
				  </div>		 
			 </td>
		   </tr>
         </table>           
	   </td>
	   <td width="1" background="images/vertdivider.gif"><img src="images/blank.gif" width="1" height="1" border="0"></td>
	   <td class="mainView" valign="top"><br>
	     <table border="0" cellpadding="4" cellspacing="0" width="100%" class="mainView">
           <tr>
              <td class="mainView">
			     <cfoutput>
				   <p><strong><cfif Len(Trim(Session.DoctorInfo.Firstname)) GT 0>#trim(Session.DoctorInfo.Firstname)# #trim(session.DoctorInfo.Lastname)#</cfif><cfif IsDefined("Session.DoctorInfo.degree")>, #Session.DoctorInfo.degree#</cfif></strong>, the information that we have on file for you is displayed below. If any of the information is incorrect, please correct the inaccurate information and click the "Update My Profile" Button at the bottom of the page.</p>
				 </cfoutput> 
				 <cfif url.e NEQ 0>
					 <div style="padding-top:10px;padding-bottom:10px;">
					   <cfif url.e EQ 1>
					     <strong style="color:#990000;font-size:14px;">Error! You must include your Firstname.</strong>
					   <cfelseif url.e EQ 2>
					     <strong style="color:#990000;">Error! You must include your Lastname.</strong>
					   <cfelseif url.e EQ 3>
					     <strong style="color:#990000;">Error! You must include your Office Phone Number.</strong>
					   <cfelseif url.e EQ 4>
					     <strong style="color:#990000;">Error! You must include your Office Address.</strong>
					   <cfelseif url.e EQ 5>
					     <strong style="color:#990000;">Error! You must include your Office City, State and ZipCode.</strong>
					   <cfelseif url.e EQ 6>
					     <strong style="color:#990000;">Error! You must complete your Shipping City, State and ZipCode.</strong>
					   <cfelseif url.e EQ 7>
					     <strong style="color:#990000;">Error! The Email Address you entered is invalid.</strong>
					   
					   </cfif>
					 </div>
				 </cfif>
				 <cfoutput query="getDocInfo">
				     
					 <cfform name="updateContact" action="act_MyInfo.cfm" method="POST">
					  <input type="hidden" name="PHID" value="#getDocInfo.Phid#"> 
					  <table border="0" cellpadding="4" cellspacing="0">
						 <tr>
						   <td colspan="2"><strong style="color:##cc0000;">* Required Fields</strong></td>
						 </tr>
						 <tr bgcolor="##eeeeee">
						   <td colspan="2"><strong>Contact Information</strong></td>
						 </tr>
						 <tr>
						    <td><strong>First Name:</strong></td>
						    <td><cfinput type="text" name="Firstname" value="#getDocInfo.Firstname#" size="25" maxlength="100" required="YES" message="You must include your firstname"> <strong style="color:##cc0000;">*</strong></td> 
						 </tr>
						 <tr>
						    <td><strong>Middle Name:</strong></td>
						    <td><cfinput type="text" name="Middlename" value="#trim(getDocInfo.MiddleName)#" size="25" maxlength="100"></td> 
						 </tr>
						 <tr>
						    <td><strong>Last Name:</strong></td>
						    <td><cfinput type="text" name="Lastname" value="#getDocInfo.lastName#" size="25" maxlength="100" required="YES" message="You must include your lastname"> <strong style="color:##cc0000;">*</strong></td> 
						 </tr>
						 <tr>
						   <td><strong>ME Number:</strong></td>
						   <td><cfinput type="text" name="menum" value="#Trim(getDocInfo.menum)#" size="12" maxlength="11"></td> 
						 </tr>
						 <tr>
						   <td><strong>Email:</strong></td>
						   <td><cfinput type="text" name="email" value="#getDocInfo.emailID#" size="35" maxlength="100"></td> 
						 </tr>
						 <tr>
						    <td colspan="2">&nbsp;</td>
						 </tr>
						 <tr bgcolor="##eeeeee">
						   <td colspan="2"><strong>Phone Numbers</strong></td>
						 </tr>
						 <tr>
						   <td><strong>Office Phone:</strong></td>
						   <td><cfinput type="text" name="phone1" value="#thisPhone1#" size="15" maxlength="14"> <strong style="color:##cc0000;">*</strong></td> 
						 </tr>
						 <tr>
						   <td><strong>Alternate Phone:</strong></td>
						   <td><cfinput type="text" name="phone2" value="#thisPhone2#" size="15" maxlength="14"></td> 
						 </tr>
						 <tr>
						   <td><strong>Fax Number:</strong></td>
						   <td><cfinput type="text" name="fax" value="#ThisFax#" size="15" maxlength="14"></td> 
						 </tr>
						 <!--- <tr>
						   <td><strong>CET Phone:</strong></td>
						   <td><cfinput type="text" name="cetphone" value="#ThisCET#" size="15" maxlength="14"></td> 
						 </tr> --->
						 <tr>
						    <td colspan="2">&nbsp;</td>
						 </tr>
						 <tr bgcolor="##eeeeee">
						    <td colspan="2"><strong>Address Information</strong></td>
						 </tr>
						 <tr>
						   <td valign="top"><strong>Office Address:</strong> <strong style="color:##cc0000;">*</strong></td>
						   <td>
							 <table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
								   <td>Address:</td>
								   <td><cfinput type="text" name="officeAddr1" value="#getDocInfo.address1#" size="25" maxlength="50"></td>
								</tr>
								<tr>
								   <td>Address 2:</td>
								   <td><cfinput type="text" name="officeAddr2" value="#getDocInfo.address2#" size="25" maxlength="50"></td>
								</tr>
								<tr>
								   <td colspan="2">
								     <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                           <td>City:</td>
										   <td><cfinput type="text" name="officeCity" value="#getDocInfo.City#" size="20" maxlength="50"></td>
										   <td align="center">State:</td>
										   <td><select name="officeState">
											      <cfloop query="getStates">
											      <option value="#getStates.StateAbbr#" <cfif getStates.StateAbbr EQ getDocInfo.State>Selected</cfif>>#getStates.StateAbbr#</option>
											      </cfloop>
											   </select>
										   </td>
										   <td align="center">ZipCode:</td>
										   <td><cfinput type="text" name="OfficeZip" value="#getDocInfo.Zip#" size="10" maxlength="10"></td>
                                        </tr>
                                     </table>
								   </td>
								</tr>
							</table>
						   </td>
						<tr>  
						<tr>
						  <td colspan="2">&nbsp;</td>
						</tr>
						</tr> 
						   <td valign="top"><strong>Shipping Address:</strong></td>
						   <td>
							 <table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
								   <td>Address:</td>
								   <td><cfinput type="text" name="shipAddr1" value="#getDocInfo.shipaddr1#" size="25" maxlength="50"></td>
								</tr>
								<tr>
								   <td>Address 2:</td>
								   <td><cfinput type="text" name="shipAddr2" value="#getDocInfo.shipaddr2#" size="25" maxlength="50"></td>
								</tr>
								<tr>
								   <td colspan="2">
								     <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                           <td>City:</td>
										   <td><cfinput type="text" name="shipCity" value="#getDocInfo.shipCity#" size="20" maxlength="50"></td>
										   <td align="center">State:</td>
										   <td><select name="shipState">
											      <cfloop query="getStates">
											      <option value="#getStates.StateAbbr#" <cfif getStates.StateAbbr EQ getDocInfo.shipState>Selected</cfif>>#getStates.StateAbbr#</option>
											      </cfloop>
											   </select>
										   </td>
										   <td align="center">ZipCode:</td>
										   <td><cfinput type="text" name="shipZip" value="#getDocInfo.shipZip#" size="10" maxlength="10"></td>
                                        </tr>
                                     </table>
								   </td>
								</tr>
							</table>
						   </td> 
						 </tr>
						 <tr>
						   <td colspan="2"><input type="submit" name="submit" value="Update My Info >>"></td>
						 </tr>
					  </table>
					 </cfform> 
				 </cfoutput>
			  </td>
           </tr>
         </table>           
	   </td>
      </tr>
   </table>           
<br><br>
<cfmodule template="Includes/footer.cfm">