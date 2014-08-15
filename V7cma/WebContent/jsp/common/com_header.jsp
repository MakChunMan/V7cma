<%
//response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>
<!-- Start Header -->
	<div id="header">
		<div class="logo_bar">
			<h1 class="AE_logo"><a href="/main/.do"><span></span><img src="<%=staticPath %>/images/aelogo.jpg" alt=""/></a></h1>
			<jsp:include page="/jsp/common/com_langbar.jsp"></jsp:include>
		</div>
		<div id="main_nav">
			<ul class="menu">
				<jsp:include page="/jsp/common/com_topnav.jsp"></jsp:include>
			</ul>
			<div class="search">
				<form action="/do/SEARCH" method="post">
				<input  type="hidden" name="source" value="h"/>
				<input  id="txt_search" name="keyw" type="text" accesskey="h" tabindex="1" value="<%=MessageUtil.getV6Message(lang,"BUT_SEARCH") %>" maxlength="50" onfocus="fn_focusSearch(this);" onblur="fn_blurSearh(this);"  class="txt_search_off" />
				<input  type="submit" name="btn_go" id="btn_go" value="<%=MessageUtil.getV6Message(lang,"BUT_GO") %>" class="btnGeneric" />
				</form>
			</div>
		</div>
		<div class="banner_row">
			<jsp:include page="/jsp/common/com_banner.jsp"></jsp:include>
			<div class="login_form" <%=V6Util.isLogined(request)?"id=\"logined_form\"":"" %>>
				<% if(!V6Util.isFBSessionExist(request)){ %>
				<jsp:include page="/jsp/common/com_login.jsp"></jsp:include>
				<% } else { %>
				<jsp:include page="/jsp/common/com_fb_login_profile.jsp"></jsp:include>
				<% } %>
			</div>
		</div>
		<div id="breadcrumb"><ul><jsp:include page="/jsp/common/com_breadcrumb.jsp"/><li id="breadcrumb-tail"></li></ul></div>
	</div>
	<div id="header_cover"></div>
<!-- END Header -->	