<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="java.util.*" %>
<%@include file="/init.jsp" %>  
<% 
Enquiry thisQuestion = (Enquiry)request.getAttribute("REP_QUESTION");
SellItem thisProd = (SellItem)request.getAttribute("SELLITEM");
int previd = -1;
%>
<form id="reply-form" action="" method="post">
<input type="hidden" name="mid" value="<%=thisQuestion.getId() %>"/>
<input type="hidden" name="action" value="REPLY_SAVE"/>
							<div class="ui-widget"><div id="formerr">
								<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
							</div>
							<table width="100%" class="tbl_form">
								<colgroup>
									<col width="20%"  />
									<col width="*"  />
								</colgroup>
								<thead>
								<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"TIT_ENQ_REPLY") %></th></tr>
								</thead>
								<tbody>
								<tr>
									<td><label for="ENQ_RECIPENT"><%=MessageUtil.getV6Message(lang,"ENQ_RECIPENT")%></label></td>
									<td><%=thisQuestion.getFr_member().getNickName()%></td>
								</tr>
								<% if(!"O".equalsIgnoreCase(thisQuestion.getMessage_type())){ %>
								<tr>
									<td><label for="ENQ_MSG_MODE"><%=MessageUtil.getV6Message(lang,"ENQ_MSG_MODE")%></label></td>
									<td><select name="ENQ_MSG_MODE" id="ENQ_MSG_MODE">
											<option value="PUBLIC"><%=MessageUtil.getV6Message(lang,"ENQ_MSG_MODE_OPEN") %></option>
											<option value="PRIVATE"><%=MessageUtil.getV6Message(lang,"ENQ_MSG_MODE_CLOSE") %></option>
									</select>
									</td>
								</tr>	
								<%} else { %>
									<input type="hidden" name="ENQ_MSG_MODE" value="PRIVATE"/>
								<%} %>							
								<tr>
									<td><label for="ENQ_CONTENT"><%=MessageUtil.getV6Message(lang,"ENQ_CONTENT") %></label></td>
									<td><textarea name="ENQ_CONTENT" id="ENQ_CONTENT" cols="25" rows="6" class="text"></textarea></td>
								</tr>								
								</tbody>
							</table>
							<button id="reply-submit"><%=MessageUtil.getV6Message(lang,"BUT_SUBMIT")%></button>	
							<button id="reply-back"><%=MessageUtil.getV6Message(lang,"BUT_BACK")%></button>
</form>
<script>
$(function() {
	$('#reply-submit')
			.button()
			.click(function() {
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/ENQ?c="+new Date().getTime(),   
		             type: "POST",  
		             data: $("#reply-form").serialize(),       
		             cache: false,  
		             success: function (html) {                
		            	 $('#msgmgmt-region').html(html);
		             }         
	    	     });  
				return false;
			});
	$('#reply-back')
	.button()
	.click(function() {
		$.ajax({  
             url: "<%=request.getAttribute("contextPath") %>/do/ENQ?action=LISTAJ&c="+new Date().getTime(),   
             type: "POST",  
             cache: false,  
             success: function (html) {                
            	 $('#msgmgmt-region').html(html);
             }         
	     });  
		return false;
	});	
});
</script>			
