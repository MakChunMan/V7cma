<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.Article" %>
<%@ page import="java.util.*" %>
<%@include file="/init.jsp" %> 
<%=CommonUtil.null2Empty(request.getAttribute(SystemConstants.REQ_ATTR_GENERAL_MSG)) %>
					<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute("redirectURL"))){ %>
					<br/><%=MessageUtil.getV6Message(lang,"GENMSG_WAIT",(ArrayList<String>)request.getAttribute(SystemConstants.REQ_ATTR_GENERAL_PARAM)) %>
					<% } %>
					<BR/>
					<BR/>
					<a href="<%=contextPath %>/" class="bulletlink"><%=MessageUtil.getV6Message(lang,"BUT_BACK_HOME") %></a>