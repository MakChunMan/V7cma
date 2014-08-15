<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@include file="/init.jsp" %>
<%
Member mem = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
String access_token = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getFbAccessToken();
if(mem==null || access_token==null){
	//out.println("<script>self.location='"+ request.getAttribute("contextPath") +"/main.do';</script>\n");
} else {
%>
<form style="position:relative;left:-10px">
<table class="tbl_transparent" style="color:#666666" border="0">
<tr>
<td><img id="fb_profile_pic" src="https://graph.facebook.com/me/picture?access_token=<%=access_token %>"/></td>
<td>
<div style="float:left;position:relative;top:0px;left:5px;"><%=MessageUtil.getV6Message(lang,"PRF_WELCOME") %><%
	if(CommonUtil.isNullOrEmpty(mem.getMem_firstname())){
		out.println( mem.getMem_lastname());
	} else {
		out.println(mem.getMem_firstname() + "," + mem.getMem_lastname());
	}

	//out.println(CommonUtil.null2Empty(mem.getMem_shopname())+ " " + MessageUtil.getV6Message(lang,"PRF_SHOPKEEPER")); 
%>
</div>
<br/>
<div style="float:left;position:relative;top:0px;left:5px;"><%=MessageUtil.getV6Message(lang,"PRF_FEEDBACK_POINT") %> (<%=""+ CommonUtil.null2Zero(mem.getMem_feedback()) %>)</div>
<div style="float:right;position:relative;top:0px"><a href="<%=request.getAttribute("contextPath") %>/do/LOGIN?action=LOGOUT" id="link_logout">
<%=MessageUtil.getV6Message(lang,"BUT_LOGOUT") %></a></div>
</td></tr>
<% if(CommonUtil.isNullOrEmpty(mem.getMem_firstname()) && CommonUtil.isNullOrEmpty(mem.getMem_lastname())){ %>
<tr><td>
# <%=MessageUtil.getV6Message(lang,"PRF_ASKINFO") %>
</td></tr>
<% } %>
</table>
</form>
<% } %>