<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%
String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
String contextPath = (String)request.getAttribute("contextPath");
String staticPath = PropertiesConstants.get(PropertiesConstants.staticContextRoot);
%>