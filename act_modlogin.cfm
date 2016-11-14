<!--- Check the forms for errors --->
<cfif Len(Trim(form.username)) EQ 0>
  <cflocation url="/moderators/index.cfm?e=1&M=&P=#Form.PHID#" addtoken="No">
</cfif>

<cfif Len(trim(form.password)) EQ 0>
  <cflocation url="/moderators/index.cfm?e=2" addtoken="No">
</cfif>


<cfscript>
   session.materialLogin = createobject("component", "onlinematerials.com.materials");
   loginModerator = session.materialLogin.ModeratorLogin(form.username, form.password);
   
   if (loginModerator.recordcount GT 0){
      session.modInfo = loginModerator;
	  loguser = session.materialLogin.setLog(now(), 'OK', 'HCD ModLogin', '#Trim(loginModerator.first_name)# #trim(loginModerator.last_name)# logged into the moderator area of Healthcare Discussions', CGI.REMOTE_ADDR, cgi.HTTP_USER_AGENT, loginModerator.rowID);
      getPageContext().forward("/dsp_ModMaterials.cfm");
   } else {
      loguser = session.materialLogin.setLog(now(), 'FAIL', 'HCD ModLogin', 'A user attempted to login to moderator area using (u=#form.username# p=#form.password#), user could not be found', CGI.REMOTE_ADDR, cgi.HTTP_USER_AGENT, 0);
      getPageContext().forward("/moderator/index.cfm?e=3");
   }
   
</cfscript>


