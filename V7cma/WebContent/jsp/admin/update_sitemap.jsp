<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%
out.println(SitemapUtil.generate()+"<br/>");
%>