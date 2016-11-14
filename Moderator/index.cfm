
<cfmodule template="../Includes/header.cfm" siteType="M">  
	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
         <tr>
           <td width="624" class="mainView">
		     	<h3>Moderator Login</h3>
				<p>
					Below you may login using your username and password to view materials for your programs.
				</p>
				  <cfif url.e EQ 1>
				    <p style="color:red;"><strong>Error! You must enter your username.</strong></p>
				  <cfelseif url.e EQ 2>
				    <p style="color:red;"><strong>Error! You must enter your password.</strong></p>
				  <cfelseif url.e EQ 3>
				   <p style="color:red;"><strong>Error! The username and password combination you entered could not be found.</strong></p>
				  </cfif>
				  
				  <cfform name="login" action="../act_modlogin.cfm" method="POST">
				    <table border="0" cellpadding="4" cellspacing="0" id="materiallogin">
				      <tr>
					    <td><strong>Username:</strong></td>
						<td><input type="text" name="username" value="" width="25" maxlength="100"></td>
					  </tr>
					  <tr>
					    <td><strong>Password:</strong></td>
						<td><input type="password" name="password" value="" width="30" maxlength="100"></td>
					  </tr>
					  <tr>
					    <td></td>
						<td><input type="submit" name="submit" value="Login >>"></td>
					  </tr>
				    </table>
				   </cfform> 
				   <p align="center" style="font-size:10px;">Forgot your password?<br><a href="forgotPassword.cfm">Click here</a> to retrieve it.</p> 
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