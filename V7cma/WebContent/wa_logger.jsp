<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="com.imagsky.util.logger.*"%>
<%@ page import="com.imagsky.util.*"%>
<% 
try{
String referer = CommonUtil.null2Empty(request.getParameter("ref"));
cmaLogger.info("[WA] "+ request.getRemoteAddr()+ "|" + request.getParameter("src") + "|"+ referer,request); 
} catch (Exception e){}
%>