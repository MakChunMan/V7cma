<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
Node thisNode = (Node)request.getAttribute("THIS_NODE");
if(thisNode==null) thisNode = new Node();
%>
<table width="95%" cellpadding="5">
<tr>
	<td><%=MessageUtil.getV6Message(lang,"COMMON_KEYWORD") %></td><td><input name="nod_keyword" type="text" maxlength="255" size="50" value="<%=CommonUtil.null2Empty(thisNode.getNod_keyword()) %>"></input></td>
</tr>
<tr>
	<td><%=MessageUtil.getV6Message(lang,"COMMON_DESCRIPTION") %></td><td><input name="nod_description" type="text" maxlength="255" size="50" value="<%=CommonUtil.null2Empty(thisNode.getNod_description()) %>"></input></td>
</tr>
</table>