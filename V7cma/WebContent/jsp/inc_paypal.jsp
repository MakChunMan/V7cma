<%
//response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%><%@ page language="java" contentType="text/html; charset=UTF-8"
           pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.domain.Payment" %>
<%@ page import="com.imagsky.v6.domain.OrderSet" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@include file="/init.jsp" %> 
<%
    OrderSet aOrderSet = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
// PART 1: Acquire Token from Paypal
    if (CommonUtil.isNullOrEmpty(request.getParameter("tx"))) {
%>
<div class="ui-widget">
    <div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><%=MessageUtil.getV6Message(lang, "PAYMENT_LOADING")%></div></div>
        <% out.flush();%>
<div class="loadinggif"><img src="<%=staticPath%>/images/loader.gif"/></div>
<FORM id="paypalform" action="<%=PaypalUtil.getPaypalURL()%>" method="post">
    <%=HTMLRender.hiddenFieldRendering(PaypalUtil.getParamMap(aOrderSet))%>
</FORM>
<% cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 3. Redirect to Paypal from JSP...", request);%>
<script>document.getElementById('paypalform').submit();</script>
<%
} else {
//PART 2: Do Payment%>
<div id="paypal_complete">
    <div class="ui-widget">
        <div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
            <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><%=MessageUtil.getV6Message(lang, "PAYMENT_NOW")%></div></div>
    <img src="<%=staticPath%>/images/loader.gif"/></div>
<%
        OrderUtil.proceedBulkOrderPaypal(request, aOrderSet, "4");
        if (aOrderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_PAYPAL)) {
            OrderUtil.paymentAccountDeduction(aOrderSet);
        }

        if (OrderUtil.finalizeBulkOrder(request, aOrderSet)) {
            out.println("<script>$('#paypal_complete').hide();</script>");
            out.println("<p>" + MessageUtil.getV6Message(lang, "PALPAL_DONE_MSG1", aOrderSet.getCode()) + "</p>");
            /*** TODO
            out.println("<p>" + MessageUtil.getV6Message(lang, "PAYPAL_DONE_MSG2", CommonUtil.formatDate(PropertiesUtil.getBulkOrder().getBo_end_date(), "dd-MM-yyyy")) + "</p>");
            TODO:***/
            if (aOrderSet.getPrice_idc().equalsIgnoreCase("O")) {
                out.println("<p>" + MessageUtil.getV6Message(lang, "COUT_DONE_BO_IDC") + "</p>");
            }
            OrderUtil.clearSession(request);
        } else {
            OrderUtil.paymentFallback(aOrderSet, "6");
        }
    }%>