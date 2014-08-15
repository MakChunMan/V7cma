<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@include file="/init.jsp" %>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><%=MessageUtil.getV6Message(lang, "COUT_DONE") %>
</div>
</div>
<%=MessageUtil.getV6Message(lang, "COUT_BT_DONE")%><br/>
<% if(V6Util.isBoboModuleOn()){
	out.println(CommonUtil.null2Empty(request.getAttribute("BOBO_PROMO_MSG")));
}%>
<br/>