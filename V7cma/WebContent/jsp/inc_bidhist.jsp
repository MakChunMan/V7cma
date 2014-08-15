<%@page import="com.imagsky.common.ImagskySession"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.servlet.handler.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>    
<%
List aList = (List)request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
if(aList!=null && aList.size()>0){%>
<table width="400">
    <thead><tr>
            <th>出價者</th>
            <th>出價</th>
            <th>時間</th>
        </tr>
        <% Iterator it = aList.iterator();
        Bid aBid = null;
        while(it.hasNext()){
            aBid = (Bid)it.next();
        %>
        <tr><td align="center">
                <%
                if(aBid.getMember()!=null){
                        out.println(CommonUtil.maskEmail(aBid.getMember().getMem_login_email(), 2, "x", false));
               } else {
                        out.println(aBid.getMember_f_name());
            }%></td>
            <td align="center"><%=aBid.getBid_price()%></td>
            <td align="center"><%=CommonUtil.formatDate(aBid.getLast_update_date())%></td>
        </tr>
        <%}%>
    </thead>
</table>
<% } else { %>
沒有出價記錄
<% } %>