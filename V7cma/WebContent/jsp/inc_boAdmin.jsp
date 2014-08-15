<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.common.*"%>
<%@ page import="com.imagsky.util.*"%>
<%@ page import="com.imagsky.v6.cma.servlet.handler.BO_Handler" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.util.*" %>
<%@include file="/init.jsp" %>
<%--
JSP:            inc_boAdmin.jsp
2013-09-02:         BO List Status (Chinese) and some minor display issue
 --%>
 <%
 HashMap aMap = new HashMap();
 aMap.put("I","設定中");
 aMap.put("A","生效中");
 aMap.put("C","已中止");
 %>
<div class="ui-widget"><div id="formerr">
        <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
    </div>
<% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))) {%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <%=(String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
    </div>
</div>
<% }%>
<%
    Member thisShop = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
            + thisShop.getSys_guid() + "/";

    boolean isList = request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST) != null;
    List<Object> boList = (List<Object>) request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
    //System.out.println(boList);
    BulkOrderItem tmpBo;
    if (isList && boList.size() > 0) {
        StringBuilder sb = new StringBuilder();
        sb.append("<table width=\"100%\" class=\"tbl_form\">\n");
        sb.append("<thead><tr><th width=\"40\">").append("編號").append("</th>");
        sb.append("<th colspan=\"2\">").append(MessageUtil.getV6Message(lang, "BO_NAME")).append("</th>");
        sb.append("<th>").append(MessageUtil.getV6Message(lang, "BO_START_DATE")).append("</th>");
        sb.append("<th>").append(MessageUtil.getV6Message(lang, "BO_END_DATE")).append("</th>");
        sb.append("<th>").append(MessageUtil.getV6Message(lang, "BO_STATUS")).append("</th>");
        sb.append("<th>").append(MessageUtil.getV6Message(lang, "BO_PRICE_TITLE")).append("</th>");
        sb.append("<th>").append("已售出").append("</th>");
        sb.append("</tr></thead>");
        out.println(sb.toString());
        for (Object tmpObj : boList) {
            tmpBo = (BulkOrderItem) tmpObj;
%>
<tr valign="middle">
    <td><%=tmpBo.getId()%></td>
    <td><a class="edit_link" href="javascript:return false;" bo_id="<%=tmpBo.getId()%>"><img src="<%=userImagePath+"thm_"+tmpBo.getSellitem().getProd_image1()%>" width="32"/></a></td>
        <td><a class="edit_link" href="javascript:return false;" bo_id="<%=tmpBo.getId()%>" style="font-size:50%"><%=tmpBo.getBoiName()%> -  <%=tmpBo.getSellitem().getProd_name()%></a></td>
    <td><%=CommonUtil.formatDate(tmpBo.getBoiStartDate(), CommonUtil.dateOnlyFormatString)%></td>
    <td><%=CommonUtil.formatDate(tmpBo.getBoiEndDate(), CommonUtil.dateOnlyFormatString)%></td>
    <td><%=aMap.get(tmpBo.getBoiStatus())%> <%=CommonUtil.isBefore(tmpBo.getBoiEndDate(), new java.util.Date())?"（已過期）":"" %></td>
    <td><span style="text-decoration:line-through"><%=tmpBo.getBoiSellPrice()%></span> | <%=CommonUtil.null2Empty(tmpBo.getBoiPrice1())%> | <%=CommonUtil.null2Empty(tmpBo.getBoiPrice2())%></td>
    <td><%=CommonUtil.null2Zero(tmpBo.getBoiCurrentQty())%></td>
</tr><%
}
out.println("</table>\n");
}
%>
<button id="bo-new"><%=MessageUtil.getV6Message(lang, "BUT_ADD")%></button>
<script>
    $('#bo-new')
    .button()
    .click(function() {
        $.ajax({  
            url: "<%=request.getAttribute("contextPath")%>/do/BO?action=<%=BO_Handler.DO_BO_ADD_AJ%>&c="+new Date().getTime(),
            type: "POST",  
            cache: false,  
            success: function (html) {                
                $("#boAdmin-region").html(html);
            }         
        });  
        return false;
    });
     $(".edit_link")
    .button()
    .click(function() {
        $.ajax({  
            url: "<%=request.getAttribute("contextPath")%>/do/BO?action=<%=BO_Handler.DO_BO_ADD_AJ%>&c="+new Date().getTime()+"&boid="+$(this).attr("bo_id"),
            type: "POST",  
            cache: false,  
            success: function (html) {                
                $("#boAdmin-region").html(html);
            }         
        });  
        return false;
    });
</script>        
