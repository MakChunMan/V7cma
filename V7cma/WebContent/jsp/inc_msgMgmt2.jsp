<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.Enquiry" %>
<%@ page import="com.imagsky.v6.domain.SellItem" %>
<%@ page import="com.imagsky.v6.domain.Member" %>
<%@ page import="com.imagsky.common.ImagskySession" %>
<%@ page import="java.util.*" %>
<%@include file="/init.jsp" %>  
<% if (!CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))){%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
<%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
</div></div>
<% } %>
<div class="ui-widget"><div id="formerr">
<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div></div>
<%
ArrayList<Enquiry> sellItemList = (ArrayList<Enquiry>)request.getAttribute("ITEM_LIST");
ArrayList<Enquiry> enqList = (ArrayList<Enquiry>)request.getAttribute("ENQUIRY_LIST");

Member thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
int previd = -1;
boolean noRecord = true;

if(sellItemList==null || sellItemList.size()==0){
	out.println("<table width=\"100%\" class=\"tbl_form\"><thead><tr>");
	out.println("<th>"+ MessageUtil.getV6Message(lang,"MSG_PROD_NAME")+"</th><th>"+ 
			MessageUtil.getV6Message(lang,"MSG_CONTENT") + "</th></tr></thead>");
	out.println("<tr><td colspan=\"4\">");
	out.println("		<div class=\"ui-widget\">	<div class=\"ui-state-highlight ui-corner-all\" style=\" margin-top:10px; margin-bottom:10px; padding: 0 .7em;\">"); 
	out.println("		<span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span>");
	out.println(MessageUtil.getV6Message(lang,"MSG_NOT_FOUND"));	
	out.println("</div></div>");
	out.println("</td></tr>\n");
	out.println("</table>");
} else {
Enquiry tmpItem = null; //Contain product information
Enquiry tmpEnq = null; //Contain Enquiry list
out.println("<table width=\"100%\" class=\"tbl_form\"><thead><tr>");
out.println("<th></th>");
out.println("<th>"+MessageUtil.getV6Message(lang,"MSG_DATE")+"</th>");
out.println("<th>"+MessageUtil.getV6Message(lang,"MSG_FROM")+"</th>");
out.println("<th>"+MessageUtil.getV6Message(lang,"ENQ_RECIPENT")+"</th>");
out.println("<th>"+MessageUtil.getV6Message(lang,"TXT_ORDER_NO")+"</th>");
out.println("<th>"+MessageUtil.getV6Message(lang,"MSG_STATUS")+"</th>");
out.println("</tr></thead>");
for (int x= 0; x<sellItemList.size(); x++){
	tmpItem = (Enquiry)sellItemList.get(x);
	for(int y =0; y < ((List)enqList.get(x)).size(); y++){
		tmpEnq = (Enquiry)((List)enqList.get(x)).get(y);
		if(!tmpEnq.isDeleted(thisMember)){
			noRecord = false;
		if(y==0){
			previd = -1;
		}
		if(tmpEnq.getParentid() != previd){
			if(previd != -1){
				//out.println("</table>\n");
			}
			
			out.println("<tr>");
			out.println("<td></td>");
			out.println("<td>"+CommonUtil.formatDate(tmpEnq.getCreate_date())+"</td>");
			out.println("<td><span title=\""+ tmpEnq.getFr_member().getMem_login_email() + "\">"+tmpEnq.getFr_member().getNickName()+"</td>");
			out.println("<td><span title=\""+ tmpEnq.getTo_member().getMem_login_email() + "\">"+ tmpEnq.getTo_member().getNickName() +"</td>");
			out.println("<td>"+(CommonUtil.isNullOrEmpty(tmpItem.getMessageContent())?tmpItem.getContentid():tmpItem.getMessageContent())+"</td>");
			out.println("<td>"+MessageUtil.getV6Message(lang, tmpEnq.getShow_flg()?"MSG_STATUS_SHOW":"MSG_STATUS_HIDE") +"</th>");
			out.println("</tr>");
			/***	
			out.println("<th colspan=\"2\"><img id=\"new"+ tmpEnq.getParentid()+ "\" src=\""+ staticPath + "/images/unread.png\" style=\"display:none\" alt=\""+ MessageUtil.getV6Message(lang,"ENQ_NEW") + "\">" + 
					(CommonUtil.isNullOrEmpty(tmpItem.getMessageContent())?
							MessageUtil.getV6Message(lang,"TXT_ORDER_NO")+ ": "+ tmpItem.getContentid():
							tmpItem.getMessageContent())	+"</th></tr></thead>");
		
			if(!tmpEnq.getFr_member().getMem_login_email().equalsIgnoreCase(thisMember.getMem_login_email())){
				out.println(	"<input class=\"msgedit\" type=\"radio\" id=\""+tmpEnq.getId()+"\" value=\"REPLY\"><img src=\""+ staticPath + "/images/icon_tango_mail_reply.png\"/>" + MessageUtil.getV6Message(lang, "ENQ_REPLY"));
			}
			out.println(	"<input class=\"msgedit\" type=\"radio\" id=\""+tmpEnq.getId()+"\" value=\"DEL_ALL\">" + MessageUtil.getV6Message(lang, "MSG_DEL_ALL")+ "<br/>\n");
			if(tmpEnq.getShow_flg()){
				out.println(	"<input class=\"msgedit\" type=\"radio\" id=\""+tmpEnq.getId()+"\" value=\"HIDE_ALL\">" + MessageUtil.getV6Message(lang, "MSG_HIDE_ALL"));
			}				
			out.println("</p></td>");
			out.println("<td>"+tmpEnq.getMessageContent() + "</td>\n");
			out.println(	"</tr>\n");
			***/
		} else {
			
			out.println("<tr>");
			out.println("<td>****</td>");
			out.println("<td>"+CommonUtil.formatDate(tmpEnq.getCreate_date())+"</td>");
			out.println("<td><span title=\""+ tmpEnq.getFr_member().getMem_login_email() + "\">"+tmpEnq.getFr_member().getNickName()+"</td>");
			out.println("<td><span title=\""+ tmpEnq.getTo_member().getMem_login_email() + "\">"+ tmpEnq.getTo_member().getNickName() +"</td>");
			out.println("<td>"+(CommonUtil.isNullOrEmpty(tmpItem.getMessageContent())?tmpItem.getContentid():tmpItem.getMessageContent())+"</td>");
			out.println("<td>"+MessageUtil.getV6Message(lang, tmpEnq.getShow_flg()?"MSG_STATUS_SHOW":"MSG_STATUS_HIDE") +"</td>");
			out.println("</tr>");
			/***
			out.println("<tr><td colspan=\"2\"><hr width=\"85%\"></td></tr>");
			out.println("<tr><td >"+
					"<img id=\"new"+ tmpEnq.getParentid()+ "\" src=\""+ staticPath + "/images/unread.png\" style=\"display:none\" alt=\""+ MessageUtil.getV6Message(lang,"ENQ_NEW") + "\">"+
					"<p><strong>"+ MessageUtil.getV6Message(lang,"MSG_DATE")+ ":</strong> " + CommonUtil.formatDate(tmpEnq.getCreate_date())+"</p>"+
					"<p><strong>"+ MessageUtil.getV6Message(lang,"MSG_FROM")+ ":</strong> <span title=\""+ tmpEnq.getFr_member().getMem_login_email() + "\">"+ tmpEnq.getFr_member().getNickName()+ "</span></p>"+  
					"<p><strong>"+ MessageUtil.getV6Message(lang,"ENQ_RECIPENT")+ ":</strong> <span title=\""+ tmpEnq.getTo_member().getMem_login_email() + "\">"+ tmpEnq.getTo_member().getNickName() + "</span></p>"+
					"<p><strong>"+ MessageUtil.getV6Message(lang,"MSG_STATUS")+ ":</strong> " + MessageUtil.getV6Message(lang, tmpEnq.getShow_flg()?"MSG_STATUS_SHOW":"MSG_STATUS_HIDE") + "</p>\n");
			out.println("<p>");			
			if(!tmpEnq.getFr_member().getMem_login_email().equalsIgnoreCase(thisMember.getMem_login_email())){
				out.println(	"<input class=\"msgedit\" type=\"radio\" id=\""+tmpEnq.getId()+"\" value=\"REPLY\"><img src=\""+ staticPath + "/images/icon_tango_mail_reply.png\"/>" + MessageUtil.getV6Message(lang, "ENQ_REPLY"));
			}
			out.println(
					"<input class=\"msgedit\" type=\"radio\" id=\""+tmpEnq.getId()+"\" value=\"DEL\">" + MessageUtil.getV6Message(lang, "MSG_DEL")+
					"<span style=\"width:70px\">&nbsp;</span>\n");
			if(tmpEnq.getShow_flg()){					
					out.println("<input class=\"msgedit\" type=\"radio\" id=\""+tmpEnq.getId()+"\" value=\"HIDE\">" + MessageUtil.getV6Message(lang, "MSG_HIDE"));
			}
			out.println("</p></td>");
			out.println("<td>"+tmpEnq.getMessageContent() + "</td>\n");
			out.println("</tr>\n");
			***/
		}
		/***
		if(!CommonUtil.isBeforeAdd(tmpEnq.getCreate_date(), new java.util.Date(),Calendar.DAY_OF_MONTH,7)){
			out.println("<script>$('#new"+ tmpEnq.getParentid()+"').show();</script>\n");
		}***/
		
		previd = tmpEnq.getParentid();
	}
	}
}
%>
<script>
	$(".msgedit")
	.bind("click", function(){
		var msg = "";
		if($(this).val() == "DEL_ALL"){
			msg = "<%=MessageUtil.getV6Message(lang,"BUT_DEL_ALL_ENQ")%>";
		} else if($(this).val() == "HIDE_ALL"){
			msg = "<%=MessageUtil.getV6Message(lang,"BUT_HIDE_ALL_ENQ")%>";
		} else if($(this).val() == "DEL"){
			msg = "<%=MessageUtil.getV6Message(lang,"BUT_DEL_ENQ")%>";
		} else if($(this).val() == "HIDE"){
			msg = "<%=MessageUtil.getV6Message(lang,"BUT_HIDE_ENQ")%>";
		}

		if(msg==""){
			$.ajax({  
	             url: '<%=request.getAttribute("contextPath") %>/do/ENQ?action=REPLYAJ&mid=' + $(this).attr("id") + "&c="+new Date().getTime(),   
	             type: "POST",  
	             cache: false,  
	             success: function (html) {                
	            	 $('#msgmgmt-region').html(html);
	             }         
   	     	});  
		} else if (confirm(msg)){
			var url = '<%=request.getAttribute("contextPath") %>/do/ENQ?action=UPD&mid=' + $(this).attr("id") + "&mode="+ $(this).val();
			self.location = url;
		} else {
			$(this).attr('checked', false);
		}
		return false;
	});
</script>
<% } %>
<% if(sellItemList.size()>0 && noRecord){ 
	out.println("<table width=\"100%\" class=\"tbl_form\"><thead><tr>");
	out.println("<th>"+ MessageUtil.getV6Message(lang,"MSG_PROD_NAME")+"</th><th>"+ 
			MessageUtil.getV6Message(lang,"MSG_CONTENT") + "</th></tr></thead>");
	out.println("<tr><td colspan=\"4\">");
	out.println("		<div class=\"ui-widget\">	<div class=\"ui-state-highlight ui-corner-all\" style=\" margin-top:10px; margin-bottom:10px; padding: 0 .7em;\">"); 
	out.println("		<span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span>");
	out.println(MessageUtil.getV6Message(lang,"MSG_NOT_FOUND"));	
	out.println("</div></div>");
	out.println("</td></tr>\n");
	out.println("</table>");

 } %>	
</table>