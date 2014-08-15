<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.common.ImagskySession" %>    
<%@ page import="com.imagsky.v6.domain.Member" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.util.*" %>
<%--
2013-08-28 : Enable "Cash Balance " and "Transaction"



 --%>
<%
    String filepage = "";
    String catpage = "";
    Member thisMember = null;
    String thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
    boolean isPublicView = false;
    if (CommonUtil.null2Empty(request.getAttribute(SystemConstants.PUB_FLG)).equalsIgnoreCase("Y")) {
        thisMember = (Member) request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
        isPublicView = true;
    } else {
        thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    }

    try {
        filepage = CommonUtil.getHttpProtocal(request) + PropertiesConstants.get(PropertiesConstants.externalHost)
                + PropertiesConstants.get(PropertiesConstants.uploadContextRoot)
                + SystemConstants.PATH_COMMON_JSP_SUBNAV + thisMember.getSys_guid() + "_" + thisLang + ".jsp";
        if (isPublicView && !V6Util.isMainsite(request)) {
            //filepage = PropertiesConstants.get(PropertiesConstants.externalHost)+
            //PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ 
            //SystemConstants.PATH_COMMON_JSP_SUBNAV +thisMember.getSys_guid()+ "_" + thisLang + ".jsp";
            catpage = CommonUtil.getHttpProtocal(request) + PropertiesConstants.get(PropertiesConstants.externalHost)
                    + PropertiesConstants.get(PropertiesConstants.uploadContextRoot)
                    + SystemConstants.PATH_COMMON_JSP_SUBNAV_CAT + thisMember.getSys_guid() + "_" + thisLang + ".jsp";
        }
%>
<c:import url="<%=filepage%>" />
<%

    } catch (Exception e) {
        cmaLogger.error("Jsp Navigation file (" + filepage + ") is missing", request);
                    }%>
<div id="navShop">
    <ul id="navShop_UL">
        <% if (!CommonUtil.isNullOrEmpty(catpage)) {%>
        <li><span><%=thisMember.getMem_shopname()%></span></li>
        <%
                                    try {%>
        <c:import url="<%=catpage%>"/>
        <% 	} catch (Exception e) {
                    cmaLogger.debug("CATPAGE = " + catpage);
                }
            }
        %>
    </ul>
</div>
<div id="navMgmtShop">
    <ul>
        <li><span>帳戶管理</span></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/ENQ" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_MSGMGMT")%></a></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/TXN" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_ORDERRECORD")%></a></li>
        <% if (thisMember != null) {%>
        <% if (V6Util.isMainsiteLogin(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser()) && V6Util.isLogined(request)) {%>
        <li><a href="#<%=request.getAttribute("contextPath") %>/do/TXN?action=SHARE" rel="nofollow"><%=MessageUtil.getV6Message(thisLang,"TIT_SHARE") %> (未開放)</a>
        <li><a href="#<%=request.getAttribute("contextPath")%>/do/TXN?action=CA_LIST" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_BALANCE")%> (未開放)</a></li>
        <% }} %>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/PROFILE?action=EDIT" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_PROFILE")%></a></li>
        <% if (thisMember != null) {%>
        <% if (V6Util.isMainsiteLogin(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser()) && V6Util.isLogined(request)) {%>
        <li><span>我的商店</span></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/CAT?action=DO_CAT_ADD" rel="nofollow" ><%=MessageUtil.getV6Message(thisLang, "TIT_ADD_CAT")%></a></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/PROD?action=DO_PROD_ADD" rel="nofollow" ><%=MessageUtil.getV6Message(thisLang, "TIT_ADD_PROD")%></a></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/ARTI?action=DO_ARTI_ADD" rel="nofollow" ><%=MessageUtil.getV6Message(thisLang, "TIT_ADD_ARTI")%></a></li>
        <% }%>
        <% }%></ul>
</div>
<% if (V6Util.isAuctionModuleOn()) {%>
<div id="navAuction">
    <%--
    <ul>
        <li><span>我要...</span></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/BID?action=POST" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_BID_SELL_DO")%></a></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/AUCTION" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_BID_BUY_DO")%></a></li>
        <li><span>拍賣記錄</span></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/BID?action=SELL" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_BID_SELL")%></a></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/BID?action=BUY" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_BID_BUY")%></a></li>
        <li><a href="<%=request.getAttribute("contextPath")%>/do/BID?action=HIST" rel="nofollow"><%=MessageUtil.getV6Message(thisLang, "TIT_BID_HIST")%></a></li>
    </ul>
    --%>
</div>
<% }%>
<script>
    initNavMenu();
</script>