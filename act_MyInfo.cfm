<!--- Do Error Checking --->
   <cfif Len(Trim(form.Phid)) eq 0>
      <cflocation url="dsp_login.cfm" addtoken="NO"> 
   </cfif>
   <cfif Len(Trim(form.firstname)) eq 0>
      <cflocation url="dsp_myinfo.cfm?e=1" addtoken="NO"> 
   </cfif> 
   <cfif Len(Trim(form.lastname)) eq 0>
      <cflocation url="dsp_myinfo.cfm?e=2" addtoken="NO"> 
   </cfif> 
   
   <cfif Len(Trim(form.Phone1)) eq 0>
       <cflocation url="dsp_myinfo.cfm?e=3" addtoken="NO"> 
   </cfif> 
   <cfif Len(Trim(form.officeaddr1)) eq 0>
       <cflocation url="dsp_myinfo.cfm?e=4" addtoken="NO"> 
   <cfelse>
      <cfif Len(Trim(form.officeCity)) eq 0 OR Len(Trim(form.officeState)) eq 0 OR Len(Trim(form.officeZIP)) eq 0>
	     <cflocation url="dsp_myinfo.cfm?e=5" addtoken="NO">
	  </cfif> 	   
   </cfif> 
   <cfif Len(Trim(form.shipaddr1)) Neq 0>
      <cfif Len(Trim(form.ShipCity)) eq 0 OR Len(Trim(form.ShipState)) eq 0 OR Len(Trim(form.ShipZIP)) eq 0>
	     <cflocation url="dsp_myinfo.cfm?e=6" addtoken="NO">
	  </cfif> 	  
   </cfif> 
   <cfif Len(Trim(form.email)) NEQ 0>
      <cfif FindNoCase('@', form.email, 1) EQ 0>
	     <cflocation url="dsp_myinfo.cfm?e=7" addtoken="NO">
	  </cfif>
	  <cfif FindNoCase('.', form.email, 1) EQ 0>
	     <cflocation url="dsp_myinfo.cfm?e=7" addtoken="NO">
	  </cfif>
   </cfif>
<!--- Update Doctor Info --->
<cfinvoke component="onlinematerials.com.registration" method="UpdateDocInfo" returnvariable="UpdateSucceed">
   <cfinvokeargument name="PhID"       Value="#trim(form.Phid)#">
   
   <cfif Len(Trim(form.MeNUM)) GT 0>
      <cfinvokeargument name="MENUM" 	 Value="#trim(form.MeNUM)#">
   </cfif>
   
   <cfinvokeargument name="Firstname"  Value="#trim(Form.Firstname)#">
   
   <cfif Len(Trim(form.middlename)) GT 0>
     <cfinvokeargument name="Middlename" Value="#trim(form.MiddleName)#">
   </cfif>
   
   <cfinvokeargument name="Lastname" 	 Value="#trim(Form.LastName)#">
   
   <cfinvokeargument name="Phone1"     Value="#trim(replacelist(Form.Phone1, '/,(,),.,-, ', ''))#">
   
   <cfif Len(trim(form.phone2)) GT 0>
      <cfinvokeargument name="Phone2"     Value="#trim(replacelist(Form.Phone2, '/,(,),.,-, ', ''))#">
   </cfif>
   
   <cfif Len(trim(form.fax)) GT 0>
     <cfinvokeargument name="FaxNo"      Value="#trim(replacelist(Form.Fax, '/,(,),.,-, ', ''))#">
   </cfif>
   
   <cfif Len(trim(form.eMail)) GT 0>
     <cfinvokeargument name="Email"      Value="#trim(form.Email)#">
   </cfif>
   <!--- <cfargument name="CetPhone"   Value="#trim(form.CETPhone)#"> --->
   
   <cfinvokeargument name="Addr1"      Value="#trim(form.Officeaddr1)#">
   <cfif Len(trim(form.Officeaddr2)) GT 0>
     <cfinvokeargument name="Addr2"      Value="#trim(form.Officeaddr2)#">
   </cfif>	 
   <cfinvokeargument name="City"       Value="#trim(form.OfficeCity)#">
   <cfinvokeargument name="State"      Value="#trim(form.OfficeState)#">
   <cfinvokeargument name="ZipCode"    Value="#trim(form.Officezip)#">
   
   <cfif Len(trim(form.ShipAddr1)) GT 0>
     <cfinvokeargument name="ShipAddr1"  Value="#trim(form.ShipAddr1)#">
      <cfif Len(trim(form.ShipAddr2)) GT 0>
	    <cfinvokeargument name="ShipAddr2"  Value="#trim(form.ShipAddr1)#">
	  </cfif>	
     <cfinvokeargument name="ShipCity"   Value="#trim(form.Shipcity)#">
     <cfinvokeargument name="ShipState"  Value="#trim(form.ShipState)#">
     <cfinvokeargument name="ShipZip"    Value="#trim(form.Shipzip)#">
   </cfif>
</cfinvoke> 

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
	     <!--- say thank you --->
		 <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <cfif UpdateSucceed>
               <tr>
                  <td><strong>Thank You!</strong><br> You have sucessfully updated your information with the Pharmakon family of companies and Group Dynamics. To return to your meeting materials <a href="dsp_ShowMeeting.cfm">click here</a>. </td>
               </tr>
            <cfelse>
               <tr>
                 <td><strong>We're Sorry.</strong><br> We could not update your information at this time due to a system error. An Administrator has been alerted to this problem and we will have this issue resolved as soon as possible. To return to your meeting materials <a href="dsp_ShowMeeting.cfm">click here</a>.</td>
               </tr>
            </cfif>
            </table>           
	   </td>
      </tr>
  </table>                     
<br><br>
<cfmodule template="Includes/footer.cfm">

