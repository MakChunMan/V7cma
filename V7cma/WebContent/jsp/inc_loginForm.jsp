<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>
<%
boolean isLogined = V6Util.isLogined(request);
if(!isLogined){
%>


<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))){%>
	<div class="ui-widget"><div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;">
	<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
	<%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
	</div>
	</div>
	<%
} else {
	SiteResponse sR = (SiteResponse) request.getAttribute(SystemConstants.REQ_ATTR_RESPOSNE);
	if(sR==null || !sR.hasError()){%>
		<div class="ui-widget"><div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;">
		<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
		<%=MessageUtil.getV6Message(lang,"NEED_LOGIN")%>
		</div>
		</div>
	<%
	}
} %>
<form id="login-form" method="post">
<input type="hidden" name="action" value="AJ_LOGIN"/>
<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute("redirectURL"))){ %>
<input type="hidden" name="redirectURL" value="<%=request.getAttribute("redirectURL") %>"/>
<% } %>
							<div class="ui-widget"><div id="formerr">
								<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
							</div>
							<% if(CommonUtil.null2Empty(request.getAttribute("FB_SET_PASSWORD")).equalsIgnoreCase("Y")){ %>
							<div class="ui-widget"><div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;">
							<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
							<%=MessageUtil.getV6Message(lang,"COMMON_FB_SET_PASSWORD_MSG")%>
							</div>
							</div>
							<% } %>
							<table width="100%" class="tbl_form">
								<colgroup>
									<col width="20%"  />
									<col width="*"  />
								</colgroup>

								<tbody>
								<tr>
									<td><label for="txtMbrID"><%=MessageUtil.getV6Message(lang,"PRF_EMAIL") %></label></td>
									<td><input type="text" name="txtMbrID" id="txtMbrID" maxLength="25" value="<%=CommonUtil.null2Empty(request.getAttribute("LOGIN_EMAIL")) %>" class="text"></td>
								</tr>
								<tr>
									<td><label for="txtMbrPIN"><%=MessageUtil.getV6Message(lang,"PRF_PASSWORD") %></label></td>
									<td><input type="password" name="txtMbrPIN" id="REM_MEM_PASSWD" maxLength="25" value="" class="text">							<button id="login-submit"><%=MessageUtil.getV6Message(lang,"BUT_SUBMIT") %></button>	</td>
								</tr>
								<%
								if( (CommonUtil.null2Empty(((StringBuffer)request.getAttribute("fullRequestURL")).toString())).indexOf("LOGOUT") <0){;
								%>
								<tr>
									<td colspan="2">
										<br/><div style="width:150px;text-align:center">------ 或者 ------</div>
										<br/><br/>
										<a href="javascript:void(0);" onclick="facebook_requestSession();"> <img id="fb_login_image" src="<%=staticPath %>/images/facebook.png" alt="Connect" border="0"/></a>
										<div id="FB_REDIRECT_FLG"/>
									</td>
								</tr>
								<% } %>
								</tbody>
							</table>
</form>
<script>
$(function() {
	$('#login-submit')
			.button()
			.click(function() {
				//AJAX form submit
				$.ajax({
		             url: "<%=request.getAttribute("contextPath") %>/do/LOGIN?action=AJ_LOGIN&c="+new Date().getTime(),
		             type: "POST",
		             data: "guids="+$("#login-form").serialize(),
		             cache: false,
		             success: function (html) {
	                 //if process.php returned 1/true (send mail success)
		            	 $('#login-form-region').html(html);
		             }
	    	     });
				return false;
			});
});
</script>
<% } else { %>
			<div class="ui-widget">
				<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;">
					<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
					<%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG) %>
					</p>
				</div>
			</div>
			<script>
			<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute("redirectURL"))){%>
			self.location = "<%=request.getAttribute("redirectURL")%>";
			<% } else {%>
			self.location = "<%=request.getAttribute("contextPath") %>/do/PROFILE";
			<% } %>
			</script>
<% } %>
