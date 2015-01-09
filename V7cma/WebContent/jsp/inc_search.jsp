<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>
<%
String userfilePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/";
//String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
SearchRank[] results = (SearchRank[])request.getAttribute("searchresult");

//Search Parameter;
/**
int totalCount = new Integer((String)request.getAttribute("searchresulttotalcount"));
int startRow = 	new Integer((String)request.getAttribute("startrow"));
int rowPerPage = new Integer((String)request.getAttribute("rowPerPage"));
int currentPage = 	new Integer((String)request.getAttribute("p"));//Current Page
***/
/***
BulkOrder bo = PropertiesUtil.getBulkOrder();

if(results==null || results.length<=0){
	out.println(MessageUtil.getV6Message(lang,"SEARCH_NOT_FOUND"));
} else {
	 for (int x = 0; x < results.length; x++){%>
       		<div style="height:20px;font-size:130%;padding: 5px 5px;background:url(<%=staticPath %>/images/box_header_search.jpg)"><a href="
       		<%=CommonUtil.getHttpServerHostWithPort(request)+ results[x].getSearchRankPK().getRank_url()+ (BulkOrder.isProductInBulkOrder(bo,results[x].getRank_type())?"&boid="+bo.getId():"")%>" style="text-decoration:underline">
                        <%=results[x].getRank_title() %> @ <%=results[x].getRank_txtfield2() %>
            </a></div>
			<div style="float:left;position:relative;top:5px;width:130px"><img src="<%=userfilePath + results[x].getRank_owner()+"/thm_"+results[x].getRank_txtfield1()%>" width="100px"/></div>
			<div style="padding:0px 20px 25px 0px;">                    
                <br/>
                   <div style="height:80px">
                   <%=MessageUtil.getV6Message(lang,"TXT_SHOP") + ": " %><%=results[x].getRank_txtfield2() %>
                   <div style="float:right"><%=MessageUtil.getV6Message(lang,"PRF_FEEDBACK_POINT") %>(<%=CommonUtil.numericFormatWithComma(results[x].getRank_numfield1()) %>)</div>
                   <div style="float:clear;"></div>
                   <br/>
                   <% if(!CommonUtil.isNullOrEmpty(results[x].getRank_teaser())){ %>
                   ...<%=CommonUtil.null2Empty(results[x].getRank_teaser()) %><br/>
                   <% } %>
                   <span class="url" style="font-size:95%;color:#aaaaaa;"><%=CommonUtil.getHttpServerHostWithPort(request)+ results[x].getSearchRankPK().getRank_url()+
                   (BulkOrder.isProductInBulkOrder(bo,results[x].getRank_type())?"&boid="+bo.getId():"")%></span>
                   </div>
               </div>
               <div style="float:clear;"></div>
       		<% }
}***/
 %>
 