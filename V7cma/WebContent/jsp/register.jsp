<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>    
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", -1); //prevents caching at the proxy server
String lang = (String)request.getParameter(SystemConstants.REQ_ATTR_LANG);
%>
    
<div id="dialog-form" title="<%=MessageUtil.getV6Message(lang,"TIT_REGFORM") %>">
<style type="text/css">
		#dialog-form label { display:block; }
		#dialog-form input { display:block; }
		#dialog-form input.text { margin-bottom:6px; width:80%; padding: .2em; }
		#dialog-form fieldset { padding:0; border:0; margin-top:25px;font-size:80%; }
		#dialog-form h1 { font-size: 1.2em; margin: .6em 0; }
		div#users-contain { width: 350px; margin: 20px 0; }
		div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
/*		.ui-dialog .ui-state-error { padding: .3em; }*/
		.validateTips { border: 1px solid transparent; padding: 0.3em; }
</style>
<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include>
<form action="/do/LOGIN?action=REG" method="post" id="regform">
	<fieldset>
		<label for="name"><%=MessageUtil.getV6Message(lang,"PRF_SHOP_URL")%> <br/>
		<span style="font-size: 85%">http://www.buybuymeat.net/&lt;&lt;<%=MessageUtil.getV6Message(lang,"PRF_YR_URL_LABEL")%>&gt;&gt;</span> </label>
		<input type="text" name="REG_SHOPURL" id="REG_SHOPURL" class="text ui-widget-content ui-corner-all" />
		<label for="email"><%=MessageUtil.getV6Message(lang,"PRF_EMAIL") %></label>
		<input type="text" name="REG_MEM_EMAIL" id="REG_MEM_EMAIL" value="" class="text ui-widget-content ui-corner-all" />
		<label for="password"><%=MessageUtil.getV6Message(lang,"PRF_PASSWORD")%></label>
		<input type="password" name="REM_MEM_PASSWD" id="REM_MEM_PASSWD" value="" class="text ui-widget-content ui-corner-all" />
	</fieldset>
</form>
</div>
<script type="text/javascript">
	$(function() {
		$("#dialog-form").dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				'<%=MessageUtil.getV6Message(lang,"BUT_CANCEL")%>': function() {
					$(this).dialog('close');
				},
				'<%=MessageUtil.getV6Message(lang,"BUT_OPEN_SHOP")%>': function() {
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