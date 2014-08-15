<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.util.logger.cmaLogger"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.*"  %>
<%@include file="/init.jsp" %>
<%
ArrayList<BulkOrderItem> bo = PropertiesUtil.getBulkOrderList();
Member thisShop = (Member) request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
        + thisShop.getSys_guid() + "/";
String prodDetailPath = contextPath + "/" + thisShop.getMem_shopurl() + "/.do?v=";
if(bo!=null){
    Collections.shuffle(bo);
    Iterator<BulkOrderItem> it = bo.iterator();
    BulkOrderItem  tmpProd = null;
    while(it.hasNext()){
        tmpProd = (BulkOrderItem)it.next();%>
        <div>
        <div style="float:left;width:105px" >
        <a  href="<%=prodDetailPath + tmpProd.getSellitem().getSys_guid()%>&boid=<%=tmpProd.getId()%>" title="<%=tmpProd.getSellitem().getProd_name()%>"><img src="<%=userImagePath + "thm_" + tmpProd.getSellitem().getProd_image1()%>" alt="<%=tmpProd.getSellitem().getProd_name()%>" width="100"></a>
        </div>
        <div class="title" style="float:right;width:140px" ><a href="<%=prodDetailPath + tmpProd.getSellitem().getSys_guid()%>&boid=<%=tmpProd.getId()%>" title="<%=tmpProd.getSellitem().getProd_name()%>"><%=tmpProd.getSellitem().getProd_name()%></a></div>
        <div style="clear:both;height:15px"></div>
        </div>   	
    <%}
}
%>