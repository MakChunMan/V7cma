<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.common.SiteResponse" %>
<%@ page import="com.imagsky.common.SiteErrorMessage" %>
<%@ page import="com.imagsky.v6.cma.constants.SystemConstants" %>
<%@ page import="com.imagsky.util.logger.cmaLogger" %>
<%@ page import="com.imagsky.util.MessageUtil" %>
<%@ page import="com.imagsky.v6.domain.StringMessage" %>
<%
SiteResponse sR = (SiteResponse) request.getAttribute(SystemConstants.REQ_ATTR_RESPOSNE);
try{
	if(sR!=null) { 
	java.util.List errorList= sR.getErrorMsgList();
	if(errorList!=null && errorList.size()>0){
		java.util.Iterator it = errorList.iterator();%>
			<div class="ui-state-error ui-corner-all"> 
		<%
		while(it.hasNext()){
			SiteErrorMessage tmp = (SiteErrorMessage)it.next();
			cmaLogger.debug("Site Response Error :" + tmp.getMsgCode(), request);
			/***
			TODO: Default zh in lang;
			*/
			%>
			<p><span class="ui-icon ui-icon-alert" style="float:left; margin-right:0.3em;"></span> 
			<%=MessageUtil.getV6Message("zh",tmp.getMsgCode())%></p>
			<%
			
		}
		%></div><br/><%
	}
	}
} catch (Exception e){
	cmaLogger.error("Error in rendoring JSP error message",e);
} finally{
	out.println("<script>window.scrollTo(0,200)</script>");
}
%>