
<cfmodule template="../Includes/header.cfm" siteType="M">  
	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
         <tr>
           <td width="624" class="mainView" valign="top">
		     	<h3>Forgot Your Password</h3>
				<cfif Not IsDefined("form.email")>
				  <p>
					Use the form below to have your password emailed to you.
				  </p>
				  
				  
				  <cfform name="login" action="forgotpassword.cfm" method="POST">
				     <table border="0" cellpadding="3" cellspacing="0">
					   <tr>
					      <td><strong>Email Address:</strong></td>
						  <td><input type="text" name="email" size="25" maxlength="90"></td>
					   </tr>
					   <tr>
					      <td><strong>Lastname:</strong></td>
						  <td><input type="tex" name="lastname" size="25" maxlength="50"></td>
					   </tr>	  
					   <tr>
					     <td colspan="2" align="center"><input type="submit" name="submit" value="Send Password >>"></td>
					   </tr>
					  </table>           
				   </cfform>
				<cfelse>
				  <!--- $$$$$$$$$$$$$$$$$$$
				     Add Code to send login to user
					 
				  
				  $$$$$$$$$$$$$$$$$$$$$$$$$ --->
				  <p style="color:#009933; font-size:14px; font-weight:bold;">Your Login information has been sucessfully sent to your email account.</p>
				  <p><a href="index.cfm">Click here</a> to go back to the login screen.</p>
				</cfif>
		   </td>
		   <td width="176" align="right" valign="Top" bgcolor="#013467">
		     <table border="0" cellpadding="0" cellspacing="0" width="176">
               <tr>
                  <td><img src="/images/RightBarTop.jpg" width="176" height="160" alt="" border="0"></td>
               </tr>
			   <tr>
                  <td><img src="/images/RightBarBottom.jpg" width="176" height="168" alt="" border="0"></td>
               </tr>
             </table>           
		   </td>
         </tr>
      </table>      
<cfmodule template="../Includes/footer.cfm">