<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.Enquiry" %>
<%@ page import="java.util.*" %>
<% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG); %>
<script>
var options = $('#ENQ_RESP_ID').attr("options");

</script>
<%
Enquiry enq = null;
List enquiryList = (List)request.getAttribute("ENQUIRY_LIST");
Integer prv_parentid = -1;
int count =0;
if(enquiryList!=null && enquiryList.size()>0){
	for(int x = 0; x < enquiryList.size(); x++){
		enq = (Enquiry)enquiryList.get(x);%>
		<%--
		<script>$('#ENQ_RESP_ID').append(new Option('#<%=++count + " "+ enq.getMessageContent().substring(0,15).replaceAll("'","")+ "..."%>', '<%=enq.getParentid()%>'));</script>
		 --%>
		
		<%
		if(enq.getParentid().intValue()!=prv_parentid.intValue()){
			if(prv_parentid!=-1){
				out.println("</table>\n");
			}%>
			<script>
			if(options!=null){
			options[options.length] = new Option('<%=MessageUtil.getV6Message(lang,"PROD_RESP_LABEL")%> #<%=++count + " "+ 
					((enq.getMessageContent().length()>=20)?enq.getMessageContent().substring(0,20):enq.getMessageContent())
					.replaceAll("'","")
					.replaceAll(System.getProperty("line.separator"),"")+ "..."%>', '<%=enq.getParentid()%>');}	</script>
			<%
			out.println("<table width=\"100%\">");
			out.println("<tr><td style=\"padding-top:5px;padding-bottom:5px;padding-left:8px;padding-right:8px;background-color:#b8c9dc\"><strong>#"+  (count)+ "    "  + CommonUtil.formatDate(enq.getCreate_date()) + 
					"<span style=\"float:right\">"+ MessageUtil.getV6Message(lang, "PROD_ENQ_LABEL")+": " + enq.getFr_member().getMem_login_email() + "</span></strong></td></tr>");
			out.println("<tr><td style=\"padding-top:8px;padding-bottom:5px;padding-left:8px;\">"+ enq.getMessageContent()+ "</td></tr>");
			if(V6Util.isLogined(request)){
			out.println("<tr><td align=\"right\" style=\"padding-bottom:5px\"><span class=\"bulletLink\">"+
					"<a href=\"javascript:reply("+ enq.getParentid()+")\" class=\"reply_link\">"+ MessageUtil.getV6Message(lang,"PROD_ENQUIRY_REPLY") + "</a></span></td></tr>\n");
			}
		} else {
			out.println("<tr><td style=\"padding-left:50px;\"><div style=\"padding-top:3px;padding-bottom:3px;padding-left:8px;padding-right:8px;background-color:#e1e9fc\"><strong>"+ CommonUtil.formatDate(enq.getCreate_date()) + 
					"<span style=\"float:right\">"+ MessageUtil.getV6Message(lang,"PROD_RESP_LABEL")+": " + enq.getFr_member().getMem_login_email() + "</span></strong></div></td></tr><tr><td style=\"padding-left:55px;padding-top:8px;padding-bottom:5px\">"+ enq.getMessageContent()+ "</td></tr>\n");
		}
		prv_parentid = enq.getParentid();
%>
<% 	} 
} else {%>
		<table>
		<tr><td>
		<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
		<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
		<%=MessageUtil.getV6Message(lang,"PROD_ENQ_NOT_FOUND")%>
		</div></div>
		</td>
	<% }
	out.println("</table>\n");
%>
<script>
function reply(enqid){
	$('#ENQ_RESP_ID').val(enqid);
	document.getElementById('enquiry_content').focus();
}
</script>			