<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.SellItemCategory" %>
<%@ page import="java.util.*" %>
<% 
String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
List objList = (List)request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
if(objList!=null){
Iterator it = objList.iterator();
SellItemCategory tmpObj = null;
while(it.hasNext()){
	tmpObj =(SellItemCategory)it.next();%>		
	<li><a href="<%=request.getAttribute("contextPath")+"/do/PROD?CAT_GUID="+tmpObj.getSys_guid() %>" ><%=tmpObj.getCate_name() %></a></li>
<% } }%>
<% if(objList!=null && objList.size()==0){ %>
<%=MessageUtil.getV6Message(lang,"CAT_NOT_FOUND") %><br/>
<a href="<%=request.getAttribute("contextPath")+"/do/CAT?action=ADD"%>"><%=MessageUtil.getV6Message(lang,"CAT_ADD") %></a>
<%} %>