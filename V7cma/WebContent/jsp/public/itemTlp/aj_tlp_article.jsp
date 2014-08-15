<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@include file="/init.jsp" %>
<% 
Article thisObj = (Article)request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
Member thisMember = null;//Shop
if(CommonUtil.null2Empty(request.getAttribute(SystemConstants.PUB_FLG)).equalsIgnoreCase("Y")){
	thisMember = (Member)request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
}
%><%=thisObj.getArti_content() %>

