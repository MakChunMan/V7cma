<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.imagsky.utility.Base64" %>
<%@page import="com.imagsky.util.*" %>
<%@page import="java.net.URLEncoder" %>
<%@page import="java.net.URLDecoder"%><html>
<head>
<title><%=URLDecoder.decode(request.getParameter("sharetitle"),"UTF-8")%></title>
<script type="text/javascript" src="/files/js/jquery-1.4.2.min.js"></script>
<meta content="<%=request.getParameter("sharedescription") %>" name="Description"/>
<% if(!CommonUtil.isNullOrEmpty(request.getParameter("sharethumbnail"))){ %>
<link rel="image_src" href="<%=request.getParameter("sharethumbnail") %>" />
<% } %>
</head>
<div><a id="fb_share" name="fb_share" type="button_count" href="<%=Base64.decode(request.getParameter("shareurl"))%>">
<%=MessageUtil.getV6Message("zh","BUT_FB_SHARE") %></a>
</div>

<script>
self.location="<%=Base64.decode(request.getParameter("shareurl"))%>";
</script>
</html>