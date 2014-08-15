<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
%>  
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Pragma" content="no-cache" />   
        <meta http-equiv="Cache-Control" content="no-cache"/>   
        <meta http-equiv="Expires" content="0" />  
        <meta content="NOINDEX, NOFOLLOW" name="ROBOTS" /> 
        <meta content="" name="Keywords"/>
        <meta content="" name="Description"/>
        <title><%=MessageUtil.getV6Message(lang, "TIT_BALANCE")%> @ <%=MessageUtil.getV6Message(lang, "TIT_CORP")%></title>
        <link href="<%=staticPath%>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="<%=staticPath%>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
        <link href="<%=staticPath%>/css/flick/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQCSS")%>" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERY")%>"></script>
        <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERYUI")%>"></script>
        <script type="text/javascript" src="<%=staticPath%>/ckeditor/ckeditor.js"></script>
        <script type="text/javascript" src="<%=staticPath%>/ckfinder/ckfinder.js"></script>
        <!--// script for sliding sidebar //-->
        <script src="<%=staticPath%>/script/common_DOMControl.js" type="text/javascript"></script>
        <script src="<%=staticPath%>/script/slidemenu.js" type="text/javascript"></script>
        <!--// script for dropdown menu //-->
        <script src="<%=staticPath%>/script/init.js" type="text/javascript"></script>
        <script type="text/javascript">
            <!--//--><![CDATA[//><!--

            //initialize slider
            sb_setting=new Object();
            sb_setting.opened_item=0;
            sb_setting.allowMultiopen=false;
            //sb_setting.delayOpen=1000;		// in ms, -1 for no delay
            sb_setting.delayOpen=-1;
            sb_setting.maxheight=-1;			// set to -1 for autosize

            //initialize auto complete
            //var ACManager = new autoComplete();
            var config=[{id:"txt_search", hasScroll:false, maxRow:10} ];

            function pagaInit() {
                drawmenu("ctnSidebar", sb_setting);
                //	ACManager.setFields(config);
            }
            var tabCount = 1;
            var tabMax = 2;
            //]]>
            //--><!]]>
        </script>
        <style id="styles" type="text/css">
            #tabs li .ui-icon-close { float: left; margin: 0.4em 0.2em 0 0; cursor: pointer; }
        </style>
        <script type="text/javascript">
            //<![CDATA[
            window.onload = function()
            {
                pagaInit();

            };
        </script>
    </head>
    <body>
        <div id="main_container">
            <jsp:include page="/jsp/common/com_header.jsp"></jsp:include>
            <div id="content">
                <div id="ctnMainFull">
                    <div id="mod_txn" class="mod">
                        <div class="hd2">
                            <h2><%=MessageUtil.getV6Message(lang, "TIT_TXN_BS")%></h2>
                        </div>
                        <div class="bd" id="txn-bs-region">
                            <%
                                OrderSet os = (OrderSet) request.getAttribute("ORDERSET");
                                List plist = (List) request.getAttribute("PAYMENTLIST");
                                if (os != null) {%>
                                    <div>訂單編號:<%=os.getCode()%></div>
                                    <div>訂單日期:<%=CommonUtil.formatDate(os.getOrder_create_date(), "dd.MM.yyyy HH:mm")%></div>
                                    <div>金額: HKD <%=os.getOrder_amount()%> </div>
                                    <div>客戶電郵: <%=os.getMember().getMem_login_email()%> </div><br/><br/>
                                <%}
                                String btPaymentCode = "";
                                if (plist != null) {
                            %>
                            <table class="tbl_form">
                                <cols>
                                    <col width="5%"/>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                    <col/>							
                                    <col/>
                                    <col width="30%"/>
                                </cols>
                                <thead>
                                    <tr><th>#</th>
                                        <th>付款方式</th>
                                        <th>付款日期</th>
                                        <th>最新狀態</th>
                                        <th>金額</th>
                                        <th>備註</th>
                                    </tr>
                                </thead>
                                <%
                                        Iterator it = plist.iterator();
                                        boolean settled = true;
                                        boolean hasPending = false;
                                        int x = 1;
                                        Map aStatus = new HashMap();
                                        aStatus.put("I", "未入數");
                                        aStatus.put("P", "等候Admin本確認");
                                        aStatus.put("D", "已確認");
                                        while (it.hasNext()) {
                                            Payment p = (Payment) it.next();
                                            if (p.getPay_type().equalsIgnoreCase(Payment.TYPE_BT)) {
                                                btPaymentCode = p.getPay_id() + "";
                                                settled = p.getPay_status().equalsIgnoreCase("D");
                                            }

                                            if("P".equalsIgnoreCase(p.getPay_status())){
                                                hasPending = true;
                                            }
                                            out.println("<tr><td>" + (x++) + "</td>");
                                            out.println("<td>" + ("BT".equalsIgnoreCase(p.getPay_type()) ? "銀行入數" : p.getPay_type()) + "</td>");
                                            out.println("<td>" + CommonUtil.formatDate(p.getPay_receive_date()) + "</td>");
                                            out.println("<td>" + aStatus.get(p.getPay_status()) + "</td><td> HKD " + p.getPay_amount() + "</td><td>"
                                                    + p.getPay_remarks());
                                            if (!CommonUtil.isNullOrEmpty(p.getPay_bt_upload_file())
                                                    && p.getPay_type().equalsIgnoreCase(Payment.TYPE_BT)) {
                                                out.println("<br/><br/><a href=\"" + staticPath + p.getPay_bt_upload_file() + "\" target=\"_blank\" style=\"background-color:YELLOW\">檢視入數紙</a>");
                                            } 
                                            out.println("</td></tr>");
                                        }
                                    out.println("</table>");
                                %>

                                <form id="CONFIRM_BT_FORM">
                                    <% if (!settled) {%>
                                    <input type="hidden" name="PID" value="<%=btPaymentCode%>"/>
                                    <% if(hasPending){%>
                                    <button id="confirm_pay_btn"><%=MessageUtil.getV6Message(lang, "BUT_CONFIRM_PAY")%></button>
                                    <% } %>
                                    <%}%>
                                    <button id="confirm_back"><%=MessageUtil.getV6Message(lang, "BUT_BACK")%></button>
                                </form>
                                <script>
                                    $("#confirm_pay_btn")
                                    .button()
                                    .click(function() {
                                    	$.ajax({  
                                            url: "<%=request.getAttribute("contextPath")%>/do/TXN?action=BS_SAVE&tab=SELL&c="+new Date().getTime(),   
                                            type: "POST",  
                                            data: $("#CONFIRM_BT_FORM").serialize(),
                                            cache: false,  
                                            success: function (html) {                
                                                $("#txn-bs-region").html(html);
                                            }         
                                        });
                                        return false;
                                    });
                                    $("#confirm_back")
                                    .button()
                                    .click(function() {
                                        self.location="/do/TXN?tab=SELL";
                                        return false;
                                    });
                                </script>
                                <% } %>
                                    
<%-- 
## 2013-09-03 Combine Bank Transfer Admin Page to Sell Record Page

                                    if (request.getAttribute ( 
                                        "ORDERSET_LIST") != null) {
                                <table class="tbl_form">
                                    <cols>
                                        <col width="5%"/>
                                        <col width="20%"/>
                                        <col width="20%"/>
                                        <col/>							
                                        <col/>
                                        <col width="30%"/>
                                    </cols>
                                    <thead>
                                        <tr><th>#</th>
                                            <th>訂單日期</th>
                                            <th>訂單編號</th>
                                            <th>最新狀況</th>
                                            <th>金額</th>
                                            <th>客戶電郵</th>
                                        </tr>
                                    </thead>
                                    <%
                                        int x = 1;
                                        List aList = (List) request.getAttribute("ORDERSET_LIST");
                                        for (Object atmp : aList) {
                                            OrderSet aSet = (OrderSet) atmp;%>
                                    <tr><td><%=x++%></td>
                                        <td><%=CommonUtil.formatDate(aSet.getOrder_create_date())%></td>
                                        <td><%="<a href=\"/do/TXN?action=BS_LIST&OID=" + aSet.getCode() + "\">" + aSet.getCode() + "</a>"%></td>
                                        <td style="text-align:center">
                                            <% if ("P".equalsIgnoreCase(aSet.getOrder_status()) && !OrderUtil.isPaymentSuccess(aSet, true)) {%>
                                                            未付款 或 入數紙未上載
                                            <% } else if("D".equalsIgnoreCase(aSet.getOrder_status()) && OrderUtil.isPaymentSuccess(aSet, true)){%>
                                                            已付款
                                            <% } else {%>
                                            <%=aSet.getOrder_status()%> | <%=OrderUtil.isPaymentSuccess(aSet, true)%>
                                            <% }  %>
                                        </td>
                                        <td>HKD <%=CommonUtil.numericFormatWithComma(aSet.getOrder_amount())%></td>
                                        <td><%=aSet.getMember().getMem_login_email()%></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>						
                                <%}
                                --%>
                        </div>
                        <div class="shadow940px"></div>
                    </div>
                </div>
                <!-- 
                <div id="ctnSidebar">
                <jsp:include page="/jsp/common/com_slidesection.jsp"></jsp:include>
        </div>
                -->
            </div>
            <div id="footer">
                <jsp:include page="/jsp/common/com_footer.jsp"></jsp:include>
            </div>	
        </div>
        <div id="navMenu">
            <jsp:include page="/jsp/common/com_subnav.jsp"></jsp:include>
        </div>
        </div></div>
        <iframe src="javascript:false" id="frameNavElement" ></iframe>
        <div id="heightTest"></div>
    </body>
</html>
