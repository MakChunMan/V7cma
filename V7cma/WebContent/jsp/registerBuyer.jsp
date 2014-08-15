<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>    
<%@ page import="com.imagsky.util.logger.*" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", -1); //prevents caching at the proxy server
String lang = (String)request.getParameter(SystemConstants.REQ_ATTR_LANG);
%>
<div id="dialogRegBuyer-form" title="<%=MessageUtil.getV6Message(lang,"TIT_REGFORM") %>">
<style type="text/css">
		#dialogRegBuyer-form label { display:block; }
		#dialogRegBuyer-form input { display:block; }
		#dialogRegBuyer-form input.text { margin-bottom:6px; width:80%; padding: .2em; }
		#dialogRegBuyer-form fieldset { padding:0; border:0; margin-top:25px;font-size:80%; }
		#dialogRegBuyer-form h1 { font-size: 1.2em; margin: .6em 0; }
</style>
<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include>
<form action="LOGIN?action=REG" method="post" id="regform">
<input type="hidden" name="regtype" value="checkout"/>
<input type="hidden" name="redirectURL" value="PUBLIC?action=CHECKOUT"/>
	<fieldset>
		<label for="REG_MEM_EMAIL"><%=MessageUtil.getV6Message(lang,"PRF_EMAIL") %></label>
		<input type="text" name="REG_MEM_EMAIL" id="REG_MEM_EMAIL" value="<%=CommonUtil.null2Empty(request.getParameter("id")) %>" class="text ui-widget-content ui-corner-all" />
		<label for="REM_MEM_PASSWD"><%=MessageUtil.getV6Message(lang,"PRF_PASSWORD") %></label>
		<input type="password" name="REM_MEM_PASSWD" id="REM_MEM_PASSWD" value="" class="text ui-widget-content ui-corner-all" />
		<label for="REM_MEM_PASSWDC"><%=MessageUtil.getV6Message(lang,"PRF_PWD_NEW2") %></label>
		<input type="password" name="REM_MEM_PASSWDC" id="REM_MEM_PASSWDC" value="" class="text ui-widget-content ui-corner-all" />		
	</fieldset>		
</form>
</div>
<script type="text/javascript">
	$(function() {
		$("#dialogRegBuyer-form").dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				'<%=MessageUtil.getV6Message(lang,"BUT_CANCEL")%>': function() {
					$(this).dialog('close');
				},
				'<%=MessageUtil.getV6Message(lang,"BUT_SUBMIT")%>': function() {
					var bValid = true;
					if (bValid) {
						$("#regform").submit();
						$(this).dialog('close');
					}
				}
			},
			close: function() {
			}
		});
	});
</script>