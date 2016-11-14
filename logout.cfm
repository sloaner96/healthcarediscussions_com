<cfset structClear("#Session#")>

<cfif url.t EQ 1>
  <cflocation url="index.cfm" addtoken="NO">
<cfelse>
  <cflocation url="Moderator/index.cfm" addtoken="NO">
</cfif>