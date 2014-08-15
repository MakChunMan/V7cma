<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="java.util.*" %>
<% 
boolean isPublicView = false;
String filepage = null;
Member thisMember = null;
String thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
TreeMap shoppingCart = null;
if(CommonUtil.null2Empty(request.getAttribute(SystemConstants.PUB_FLG)).equalsIgnoreCase("Y")){
	thisMember = (Member)request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
	isPublicView = true;
	shoppingCart = (TreeMap)request.getSession().getAttribute(SystemConstants.PUB_CART);
	
} else {
	thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
}

String parentGuid = null;
			try{
				if(request.getAttribute(SystemConstants.REQ_ATTR_OBJ)==null){
				
                } else if(!CommonUtil.isNullOrEmpty(request.getParameter("boid"))){
                	ArrayList<BulkOrderItem> bo = PropertiesUtil.getBulkOrder(request);
                	BulkOrderItem boItem = bo.get(0);
					if(V6Util.isBulkOrderModuleOn() && bo!=null){
						String homepageName = MessageUtil.getV6Message(thisLang, "BRM_HOMEPAGE");
						String homepage = "<li><a href=\""+ request.getAttribute("contextPath") +"/" + "\">"+ homepageName + "</a></li><li> &gt; </li>" +
							"<li><a href=\"#\">"+ boItem.getBoiName() + "</a></li>";
						out.println(homepage);
					}
                                                                        
				} else if( request.getAttribute(SystemConstants.REQ_ATTR_OBJ).getClass() ==
						SellItem.class){
						parentGuid = ((SellItem)request.getAttribute(SystemConstants.REQ_ATTR_OBJ)).getProd_cate_guid();
						if(CommonUtil.isNullOrEmpty(parentGuid)){
							parentGuid = ((SellItem)request.getAttribute(SystemConstants.REQ_ATTR_OBJ)).getSys_guid();
						}
						filepage = CommonUtil.getHttpProtocal(request)+ PropertiesConstants.get(PropertiesConstants.externalHost)+
						PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ 
						SystemConstants.PATH_COMMON_JSP_SELLITEM_BREADCRUMB +thisMember.getSys_guid()+ "_" + thisLang + ".jsp";
				} else if(request.getAttribute(SystemConstants.REQ_ATTR_OBJ).getClass() ==
						Article.class){
						parentGuid = ((Article)request.getAttribute(SystemConstants.REQ_ATTR_OBJ)).getArti_parent_guid();
						if(CommonUtil.isNullOrEmpty(parentGuid)){
							parentGuid = ((Article)request.getAttribute(SystemConstants.REQ_ATTR_OBJ)).getSys_guid();
						}
						filepage = CommonUtil.getHttpProtocal(request)+ PropertiesConstants.get(PropertiesConstants.externalHost)+
						PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ 
						SystemConstants.PATH_COMMON_JSP_ARTI_BREADCRUMB +thisMember.getSys_guid()+ "_" + thisLang + ".jsp";
				}
				
				if(!CommonUtil.isNullOrEmpty(filepage)){
				filepage = filepage + "?guid="+ CommonUtil.null2Empty(parentGuid);
			%><c:import url="<%=filepage %>" />
			<% 
				cmaLogger.debug("Breadcrumb file found:"+ filepage, request); 
				}
			 } catch (Exception e){
				cmaLogger.error("Breadcrumb file  is missing:"+ filepage, request,e); 
			 } %>