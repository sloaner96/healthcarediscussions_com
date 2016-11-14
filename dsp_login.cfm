<!--- Meeting Code: This could get passed via the url from an email--->
<cfparam name="url.M" default="">

<!--- PHID: This could get passed via the url from an email---> 
<cfparam name="url.P" default="">

<cfmodule template="Includes/header.cfm" logoDisplay="L"><br><br>
<cfif url.e EQ 1>
   <p style="color:red;"><strong>Error! You must enter a valid meeting code below.</strong></p>
 <cfelseif url.e EQ 2>
   <p style="color:red;"><strong>Error! We could not match the Personal ID that you entered below.</strong></p>
 <cfelseif url.e EQ 3>
  <p style="color:red;"><strong>Error! You must enter a Personal ID or you firstname, lastname, and zipcode.</strong></p>
 </cfif>
<table border="0" cellpadding="0" cellspacing="4" width="100%">
   <tr>
       <td align="center">
	     <table border="0" cellpadding="0" cellspacing="0" width="225">
            <tr>
               <td><img src="/images/Logon_Head.gif" width="225" height="20" alt="" border="0"></td>
            </tr>
			<tr>
               <td bgcolor="#f1f2f2">
			      <table border="0" cellpadding="3" cellspacing="0" width="225">
				    <tr>
				       <td align="left">Below you may login using the meeting code provided to you in your confirmation letter and either your Personal ID (PHID) number or your firstname, lastname, and zipcode.</td>
				    </tr>
					
					<tr>
					   <td>
						  <cfform name="login" action="#Application.SecureURL#/act_matlogin.cfm" method="POST">
						    <table border="0" cellpadding="4" cellspacing="0" id="materiallogin">
						      <tr>
						         <td align="left"><strong style="font:verdana; font-size:9px;<cfif url.e EQ 1>color:red;</cfif>">Meeting Code</strong></td>
						         <td align="left"><cfinput type="text" name="meetingID" size="10" maxlength="10" value="#URL.M#" passthrough="style='font-size:10px;'" required="Yes" message="You must include your Meeting Code"> <a href="#" onclick="window.open('dsp_Material_help.cfm?type=m','newWindow','top=300,left=300,width=300,height=250,scrollbars=no');self.name='main';" style="font-size:9px;"><img src="/images/btn_help_gray.gif" width="18" height="18" alt="Help with this item" border="0" align="absmiddle"></a></td>
							  </tr>
							  <tr>
							     <td colspan=2><strong style="color:#009900;">AND</strong></td>
							  </tr>
							  <tr>
							     <td align="left"><strong style="font:verdana; font-size:9px;<cfif url.e EQ 2>color:red;</cfif>">Personal ID</strong></td>
							     <td align="left"><cfinput type="text" name="PHID" size="10" maxlength="15" value="#URL.P#" passthrough="style='font-size:10px;'"> <a href="#" onclick="window.open('dsp_Material_help.cfm?type=p','newWindow','top=300,left=300,width=300,height=250,scrollbars=no');" style="font-size:9px;"><img src="/images/btn_help_gray.gif" width="18" height="18" alt="Help with this item" border="0" align="absmiddle"></a></td>
							  </tr>
							  <tr>
							     <td colspan=2><strong style="color:#990000;">OR</strong></td>
							  </tr>
							  <tr>
							     <td align="left"><strong style="font:verdana; font-size:9px;<cfif url.e EQ 3>color:red;</cfif>">Firstname</strong></td>
							     <td align="left"><cfinput type="text" name="firstname" size="20" maxlength="50" value="" passthrough="style='font-size:10px;'"></td>
							  </tr>
							  <tr>
							     <td align="left"><strong style="font:verdana; font-size:9px;<cfif url.e EQ 3>color:red;</cfif>">Lastname</strong></td>
							     <td align="left"><cfinput type="text" name="lastname" size="20" maxlength="50" value="" passthrough="style='font-size:10px;'"></td>
							  </tr>
							  <tr>
							     <td align="left"><strong style="font:verdana; font-size:9px;<cfif url.e EQ 3>color:red;</cfif>">Zip Code</strong></td>
							     <td align="left"><cfinput type="text" name="zipcode" size="9" maxlength="10" value="" passthrough="style='font-size:10px;'"></td>
							  </tr>
							  <tr>
							    <td></td>
								<td align="right"><input type="image" name="submit" value="Login >>" src="/images/btn_login_off.jpg"></td>
							  </tr>
						    </table>
						   </cfform> 
					   </td>
					</tr>
				  </table>           
			   </td>
            </tr>
			<tr>
               <td><img src="/images/Logon_foot.gif" width="225" height="14" alt="" border="0"></td>
            </tr>
			
         </table>           
	   </td>
      </tr>
</table>   
 <p align="center" style="font-size:10px;">Don't know your meeting code?<br>Call us at (800) 617-8254 between 8AM and 5PM CST or email us at <a href="mailto:support@healthcarediscussions.com">support@healthcarediscussions.com</a></p><br>      
<cfmodule template="Includes/footer.cfm">