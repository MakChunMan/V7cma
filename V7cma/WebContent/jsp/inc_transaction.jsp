<%--
JSP: inc_transaction.jsp

2013-09-20 - Enable Tab-2 (Sell Record only for MainSite)


 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.ImagskySession" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %> 
   <%
       int hasAlert = 0;
       Iterator itR = null;
       Iterator its = null;
       OrderSet os = null;
       OrderItem oi = null;
       List bidList = (List) request.getAttribute("bidCompleteRecords");
       List mainSiteSellList = (List) request.getAttribute("mainSiteSellCompleteRecords");
       boolean isMainSiteLogin = V6Util.isMainsiteLogin(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser());
%>
<div id="tabs">
    <ul>
        <%--
        <li><a href="#tabs-1"><%=MessageUtil.getV6Message(lang, "TIT_TXN_BIDDING")%></a></li>
        <li><a href="#tabs-2" id="tabs_id2_title"><%=MessageUtil.getV6Message(lang, "TIT_TXN_BID_COMPLETE")%></a></li>
         --%>
        <li><a href="#tabs-3"><%=MessageUtil.getV6Message(lang, "TIT_TXN_PURCHASE")%></a></li>
        <% if(isMainSiteLogin){ %>
        <li><a href="#tabs-2"><%=MessageUtil.getV6Message(lang,"TIT_TXN_SELL") %></a></li>
        <% } %>
    </ul>
    <%--
    <div id="tabs-1">
        <% List bidList = (List) request.getAttribute("bidRecords");
            if (bidList == null || bidList.isEmpty()) {
                out.println("<div class=\"ui-widget\">");
                out.println("<div class=\"ui-state-highlight ui-corner-all\" style=\"margin-top: 20px; padding: 0 .7em;\">");
                out.println("<span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span>");
                out.println(MessageUtil.getV6Message(lang, "TXT_NO_RECORD"));
                out.println("</div>");
                out.println("</div>");
            } else {
                Iterator it = bidList.iterator();
                Bid bi = null;
                BidItem tmp = null;
                boolean showNotFound = true;
                Map bItem = (Map) request.getAttribute("bidItemMap");
                out.println("<table width=\"100%\" class=\"tbl_form\"><thead><tr>");
                out.println("<th></th><th>" + MessageUtil.getV6Message(lang, "TXT_BID_NAME") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_YOUR_PRICE") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_LAST_PRICE") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_TIMES") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_ENDDATE") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_TIME_LEFT") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_ACTION") + "</th></thead>");

                while (it.hasNext()) {
                    bi = (Bid) it.next();
                    tmp = (BidItem) (bItem.get(bi.getBiditem_id()));
                    if (tmp != null) {
                        showNotFound = false;
                        out.println("<tr><td width=45><img width=40 src='"
                                + PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/" + tmp.getSellitem().getProd_owner()
                                + "/thm_" + tmp.getSellitem().getProd_image1() + "'/></td>"
                                + "<td>" + tmp.getSellitem().getProd_name() + "</td>");
                        out.println("<td>" + bi.getBid_price() + "</td>");
                        out.println("<td>" + tmp.getBid_current_price() + "</td>");
                        out.println("<td>" + tmp.getBid_count() + "</td>");
                        out.println("<td>" + CommonUtil.formatDate(tmp.getBid_end_date()) + "</td>");
                        out.println("<td>" + CommonUtil.getDateDiffFullString("zh", new java.util.Date(), tmp.getBid_end_date(), 2) + "</td>");
                        out.println("<td>" + ((bi.getMember().getSys_guid().equalsIgnoreCase(tmp.getBid_last_bidMember().getSys_guid())) ? MessageUtil.getV6Message(lang, "TXN_BID_SAME")
                                : "<a href=\"javascript:go('" + tmp.getId() + "');\">" + MessageUtil.getV6Message(lang, "TXN_BID_NOW") + "</a>") + "</td></tr>");
                    }
                    out.println("</table>");
                }
                   if (showNotFound) {
                        out.println("<div class=\"ui-widget\">");
                        out.println("<div class=\"ui-state-highlight ui-corner-all\" style=\"margin-top: 20px; padding: 0 .7em;\">");
                        out.println("<span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span>");
                        out.println(MessageUtil.getV6Message(lang, "TXT_NO_RECORD"));
                        out.println("</div>");
                        out.println("</div>");
                    }
             }
        
        %>
    </div>--%>
    <div id="tabs-2">
        <%
        if(isMainSiteLogin){
            if (mainSiteSellList == null || mainSiteSellList.isEmpty()) {
                out.println("<div class=\"ui-widget\">");
                out.println("<div class=\"ui-state-highlight ui-corner-all\" style=\"margin-top: 20px; padding: 0 .7em;\">");
                out.println("<span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span>");
                out.println(MessageUtil.getV6Message(lang, "TXT_NO_RECORD"));
                out.println("</div>");
                out.println("</div>");
            } else {
                itR = mainSiteSellList.iterator();
                out.println("<table width=\"100%\" style='font-size:80%'  class=\"tbl_form\"><thead><tr>");
                out.println("<th width='10%'>" + MessageUtil.getV6Message(lang, "TXT_ORDER_NO") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_BUY_DAY") + "</th><th>"
                        + "電郵</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_AMOUNT") + "</th><th width='15%'>"
                        + MessageUtil.getV6Message(lang, "TXT_ITEM") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_STATUS") + "</th></tr></thead>");

                
                java.util.Date collectionEndDate = null; 
                while (itR.hasNext()) {
                    os = (OrderSet) itR.next();
                    out.println("<tr><td><u><a href=\"/do/TXN?action=BS_LIST&OID=" + os.getCode() + "\">" + os.getCode() + "</a></u></td>");
                    out.println("<td>" + CommonUtil.formatDate(os.getOrder_create_date()) + "</td>");
                    out.println("<td>" + os.getMember().getMem_login_email() + "<br/>"+os.getMember().getMem_display_name()+"</td>");
                    out.println("<td>$ " + CommonUtil.numericFormatWithComma(os.getOrder_amount()) + "</td>");
                    out.println("<td>");
                    its = os.getOrderItems().iterator();

                    while (its.hasNext()) {
                        oi = (OrderItem) its.next();
                        out.println((oi.getBoitemid()==null?"":"[團購] ")+oi.getProdName());
                    }
                    out.println("</td>");
                    out.println("<td>");
                        if(os.getPendingBTPayment()==null){
                            out.println("沒有付款記錄");
                        } else if("I".equalsIgnoreCase(os.getPendingBTPayment().getPay_status())) {
                            out.println("未付款 或 沒有上載入數紙");
                        } else if("D".equalsIgnoreCase(os.getOrder_status())){
                            out.println("已付款");
                        } else if("P".equalsIgnoreCase(os.getOrder_status())){
                        	out.println("<div style=\"background-color:YELLOW\">[請核實]上載了入數紙</div>");
                        } else {
                            out.println("未知 (" + os.getOrder_status()+")");
                        }
                    out.println("</td>");
                    out.println("</tr>");
                }
                if (mainSiteSellList.size() > 0) {
                    out.println("</table>");
                } 
            }
        }
        %>
    </div>
  
    <div id="tabs-3">
        <% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))) {%>
        <div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
                <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                <%=(String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
            </div>
        </div>
        <br/>
        <%}%>
        <div class="ui-widget"><div id="formerr">
                <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
        </div>
        <%
            List purchaseRecords = (List) request.getAttribute("purchaseRecords");

            if (purchaseRecords == null || purchaseRecords.isEmpty()) {
                out.println("<div class=\"ui-widget\">");
                out.println("<div class=\"ui-state-highlight ui-corner-all\" style=\"margin-top: 20px; padding: 0 .7em;\">");
                out.println("<span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span>");
                out.println(MessageUtil.getV6Message(lang, "TXT_NO_RECORD"));
                out.println("</div>");
                out.println("</div>");
            } else {
                itR = purchaseRecords.iterator();
                out.println("<table width=\"100%\" class=\"tbl_form\"><thead><tr>");
                out.println("<th>" + MessageUtil.getV6Message(lang, "TXT_ORDER_NO") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_BUY_DAY") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_AMOUNT") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_ITEM") + "</th><th>"
                        + MessageUtil.getV6Message(lang, "TXT_STATUS") + "</th><th>"
                        + "下載</th></tr></thead>");
                int actualCount = 0;
                boolean isBo = false;
                java.util.Date collectionEndDate = null;
                while (itR.hasNext()) {
                    os = (OrderSet) itR.next();
                    //Non-Auction Records
                    if(!"A".equalsIgnoreCase(os.getPrice_idc())){
                    actualCount++;
                    out.println("<tr><td>"+os.getCode() +"</td><td>" + CommonUtil.formatDate(os.getOrder_create_date()) + "</td><td>" + CommonUtil.numericFormatWithComma(os.getOrder_amount()) + "</td>");
                    out.println("<td>");
                    its = os.getOrderItems().iterator();
                    while (its.hasNext()) {
                        oi = (OrderItem) its.next();
                        out.println(oi.getProdName() + ": $" + CommonUtil.numericFormatWithComma(oi.getActuPrice()) + " x " + oi.getQuantity() + "<br/>");
                        if(oi.getBoitemid()!=null){
                        	isBo = true;
                        	collectionEndDate = oi.getCollectionEndDate();
                        }
                    }
                    out.println("</td><td>");
                    if(os.getPendingBTPayment()==null){
                        out.println("沒有付款記錄");
                    } else if("I".equalsIgnoreCase(os.getPendingBTPayment().getPay_status())) {
                          String btUploadUrl = "http://"+ PropertiesConstants.get(PropertiesConstants.externalHost)+"/main.do?action=BTUPLOAD&O="+os.getCode()+ "&P="+ os.getPendingBTPayment().getPay_id();
                          btUploadUrl = "<a href=\""+ btUploadUrl + "\">!!! 未付款 或 沒有上載入數紙</a><br/>";
                          out.println("<div class='ui-state-error'>"+btUploadUrl+ "</div>");
                    } else if("D".equalsIgnoreCase(os.getOrder_status())){
                        out.println("已付款");
                    } else if("P".equalsIgnoreCase(os.getPendingBTPayment().getPay_status())) {
                        out.println("等候管理員核對付款");
                    } else {
                        out.println("未知");
                    }
                    out.println("</td>");
                    if(isBo && "D".equalsIgnoreCase(os.getOrder_status()) && collectionEndDate!=null && collectionEndDate.after(new java.util.Date())){
                        out.println("<td><a href=\"/rpt/print?ORDERNO="+os.getCode()+"\">列印優惠劵</a></td>");
                    } else if(isBo && "D".equalsIgnoreCase(os.getOrder_status()) && collectionEndDate!=null && !collectionEndDate.after(new java.util.Date())){
                    	out.println("<td>已過換領日期</td>");
                    } else {
                        out.println("<td>- -</td>");
                    }
                    out.println("</tr>");
                    } //End if not "A"
                }
                if (purchaseRecords.size() > 0) {
                    out.println("</table>");
                }
                if(actualCount==0){
                    out.println("<div class=\"ui-widget\">");
                    out.println("<div class=\"ui-state-highlight ui-corner-all\" style=\"margin-top: 20px; padding: 0 .7em;\">");
                    out.println("<span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span>");
                    out.println(MessageUtil.getV6Message(lang, "TXT_NO_RECORD"));
                    out.println("</div>");
                    out.println("</div>");
                }
            }
        %>
    </div>
  
</div>
<script>
<%-- if(hasAlert>0){%>
        $('#tabs_id3_title').attr("style","color:red");
        $('#tabs_id3_title').html($('#tabs_id3_title').html() + "(未付款:<%=hasAlert%>項)");
<% }--%>
    $(function(){
        var $tabs = $('#tabs').tabs({
        });
        <% if("SELL".equalsIgnoreCase(request.getParameter("tab"))){%>
        $tabs.tabs('option', 'selected', 1 );
        <%}%>        
    });
    
    $(function() {
        $('.feedback_submit')
        .bind("change",
        function(){
            if($(this).val()=="-1"){
                $('#tmpID').val($(this).attr("id"));
                $("#feedback-form").dialog({
                    autoOpen: true, height: 420, width: 350, modal: true,
                    buttons: {
                        '<%=MessageUtil.getV6Message(lang, "BUT_CANCEL")%>': function() {
                            $('#'+$('#tmpID').val()).val("");
                            $(this).dialog('close');
                        },
                        '<%=MessageUtil.getV6Message(lang, "BUT_SUBMIT")%>': function() {
                            $('#osid').val($('#tmpID').val());	
                            $.ajax({  
                                url: "<%=request.getAttribute("contextPath")%>/do/TXN?action=FEED&c="+new Date().getTime(),   
                                cache: false,  
                                type: "POST",  
                                data: $("#feedbackform").serialize(),
                                success: function (html) {                
                                    $('#txn-region').html(html);
                                }         
                            });
                            $(this).dialog('close');
                        }
                    },
                    close: function() { $(this).val("");}
                });
            } else if($(this).val()!=""){
                if(confirm("<%=MessageUtil.getV6Message(lang, "TXT_FEED_MSG")%>")){
                    $.ajax({  
                        url: "<%=request.getAttribute("contextPath")%>/do/TXN?action=FEED&v="+ $(this).val() +　"&osid="+ $(this).attr("id") +　"&c="+new Date().getTime(),   
                        cache: false,  
                        success: function (html) {                
                            $('#txn-region').html(html);
                        }         
                    });
                } else {
                    $(this).val("");
                }
            } else {
                return true;
            }
        });
    });

    function go(biid){
        self.location="<%=request.getAttribute("contextPath")%>/do/BID2?action=details&biid="+biid;
    }
</script>		
<input type="hidden" id="tmpID" value=""/>