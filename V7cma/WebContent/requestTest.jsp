<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@page import="java.util.*" %>
<%@page import="com.imagsky.util.*" %>
<%@page import="com.imagsky.util.logger.*" %>
<% 
try{
	MailUtil mailUtil = new MailUtil();
	mailUtil.setFromAddress("admin@buybuymeat.net");
	mailUtil.setToAddress("waltz_mak@yahoo.com.hk");
	boolean result = mailUtil.send();
	if(result){
		out.println("Send Sucess");
	} else {
		out.println("Send fail");
	}
} catch (Exception e){
	cmaLogger.error("Test Mail Error:", e);
}

%>