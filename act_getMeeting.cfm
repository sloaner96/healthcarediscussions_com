<cfset session.materialMeetingID = Trim(form.mtgdate)>
<cflocation url="dsp_ShowMeeting.cfm" addtoken="NO">
