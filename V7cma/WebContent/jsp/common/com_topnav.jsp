<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.common.ImagskySession" %>    
<%@ page import="com.imagsky.v6.domain.Member" %>
<%@ page import="com.imagsky.v6.domain.OrderSet" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="java.util.TreeMap" %>
<%
//Member thisMember = null;
Member thisSite = (Member)request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
String thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
boolean isPublicView = CommonUtil.null2Empty(request.getAttribute(SystemConstants.PUB_FLG)).equalsIgnoreCase("Y");
if(isPublicView){
	thisSite = (Member)request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
} else {
	//Ignore Self Login
	//thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
}

//Display 
%>
<li><a href="<%=request.getAttribute("contextPath") %>/<%=SystemConstants.MAIN_SITE_URL%>.do" class="nav_current" onmouseover="fnMenuShowHolder('',this);" onmouseout="fnMenuHide();">
<%=MessageUtil.getV6Message(thisLang,"TIT_HOMEPAGE") %></a></li>
<li> | </li>
<li><a href="<%=request.getAttribute("contextPath") %>/do/PROFILE" onmouseover="fnMenuShowHolder('navMgmtShop',this);" onmouseout="fnMenuHide();"><%=MessageUtil.getV6Message(thisLang,"TIT_MYPROFILE") %></a></li>
<% if(V6Util.isAuctionModuleOn()){ %>
<li> | </li>
<li><a href="<%=request.getAttribute("contextPath") %>/do/BID2" onmouseover="fnMenuShowHolder('navAuction',this);" onmouseout="fnMenuHide();"><%=MessageUtil.getV6Message(thisLang,"TIT_BID") %></a></li>
<% } %>
<% if(!V6Util.isMainsite(request) && isPublicView){ %>
<li> | </li>
<li><a href="" onmouseover="fnMenuShowHolder('navShop',this);" onmouseout="fnMenuHide();">
	<%=MessageUtil.getV6Message(thisLang,"TIT_VISITNOW") %>
	</a></li>
<% } %>
<%
String filepage = null;

String guid = (thisSite==null)?PropertiesConstants.get(PropertiesConstants.mainSiteGUID):thisSite.getSys_guid();
try{ 
	filepage = CommonUtil.getHttpProtocal(request)+ PropertiesConstants.get(PropertiesConstants.externalHost)+
			PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+
			SystemConstants.PATH_COMMON_JSP_TOPNAV + guid+"_"+ thisLang +".jsp";
	if(!CommonUtil.isNullOrEmpty(filepage)){%>
		<c:import url="<%=filepage %>" />
	<%}	%>
<% } catch (Exception e){
	cmaLogger.error("Jsp Top Navigation file ("+filepage+") is missing"); 
 }
 
//Shopping Cart
TreeMap shoppingCart = null;
shoppingCart = (TreeMap)request.getSession().getAttribute(SystemConstants.PUB_CART);
if(shoppingCart!=null && shoppingCart.size()>0){
	%>
<li> | </li>
<li><a href="<%=request.getAttribute("contextPath") %>/do/PUBLIC?action=CHECKOUT" onmouseover="fnMenuShowHolder('navCart',this);" onmouseout="fnMenuHide();">
<%=MessageUtil.getV6Message(thisLang,"TIT_CART") %>
</a></li>
<% 	
}
//End of Shopping Cart
%>