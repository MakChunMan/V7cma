<%
//response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>

<%@include file="/init.jsp" %> 
<div class="ui-widget">
<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
								<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
<%=request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%></div></div>