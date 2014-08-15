<%
//response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%><%@ page language="java" contentType="text/html; charset=UTF-8"
           pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.v6.domain.Payment" %>
<%@ page import="com.imagsky.v6.domain.OrderSet" %>
<%@ page import="com.imagsky.v6.domain.OrderItem" %>
<%@ page import="com.imagsky.v6.domain.Member" %>
<%@ page import="com.imagsky.v6.domain.BulkOrderItem" %>
<%@ page import="com.imagsky.common.ImagskySession" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="java.util.*" %>
<%@include file="/init.jsp" %>
<% try {%>
<style>
    div.column1 { float:left; padding:3px; width:220px; vertical-align:middle; height:25px; }
    div.column { float:left; padding:3px; width:70px; vertical-align:middle; height:25px; }

    div#footer { clear:both; }
</style>
<div class="ui-widget"><div id="formerr">
        <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
    </div>
    <form id="checkout_form">
    <%
        //String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);


        Member thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();

        boolean isBO = !CommonUtil.isNullOrEmpty(request.getParameter("type")) && "bo".equalsIgnoreCase(request.getParameter("type"));
        
        OrderSet shoppingCart = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
        //OrderSet cartInfo = (OrderSet)request.getSession().getAttribute(SystemConstants.PUB_CART_INFO);
        if (thisMember != null && shoppingCart.getMember() == null) {
            shoppingCart.setMember(thisMember);
            shoppingCart.setReceiver_email(thisMember.getMem_login_email());
            shoppingCart.setReceiver_firstname(thisMember.getMem_firstname());
            shoppingCart.setReceiver_lastname(thisMember.getMem_lastname());
        }

        if (thisMember == null) {
            thisMember = new Member();
        }

        String mode = (String) CommonUtil.null2Empty(request.getAttribute("mode"));
        String userImagePath = "";
        OrderItem item = null;
        boolean reset = true;
    if (shoppingCart != null && shoppingCart.getOrderItems().size() > 0) {%>
    <table width="100%" class="tbl_form">
        <colgroup>
            <col width="10%"  />
            <col width="28%"  />
            <col width="30%"  />
            <col width="15%"  />
            <col width="*"  />
        </colgroup>
        <thead>
            <tr><th colspan="7"><%=MessageUtil.getV6Message(lang, "COUT_BO_INFO")%></th></tr>
            <%--
            <tr><td colspan="7">
                <div class="ui-widget"> <div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;">
                        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span></div></div>
                        <br/><%=MessageUtil.getV6Message(lang,"BO_RULES") %></td></tr>--%>
                        <%
                            Iterator itItem = shoppingCart.getOrderItems().iterator();
                            BulkOrderItem boItem = null;
                            //2013-08-20: Not use
                            //BulkOrderItem boItem = notify();
                            reset = true;
                            while (itItem.hasNext()) {
                                item = (OrderItem) itItem.next();
                                boItem = PropertiesUtil.getBulkOrderItem(item.getContentGuid());
                                userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
                                        + item.getShop().getSys_guid() + "/thm_" + item.getProdImage();

                                if (mode.equalsIgnoreCase("confirm")) {
                                    //Readonly - Confirm Page
                                    if (item.getQuantity() > 0) {%>
								            <tr>
								            <td><% if (!CommonUtil.isNullOrEmpty(item.getProdImage())) {%><img src="<%=userImagePath%>" height="48"/><%}%></td>
								            <td><strong><%=item.getProdName()%></strong><br/> 
                                                <%=MessageUtil.getV6Message(lang, "BO_PRICE")%>:$&nbsp;<span id="ap<%=item.getContentGuid()%>"><%=CommonUtil.numericFormatWithComma(item.getBoPrice())%></span><br/>
                                                <div style="color:#999999"><del><%=MessageUtil.getV6Message(lang, "COUT_PRICE")%>:$&nbsp;<span id="op<%=item.getContentGuid()%>"><%=CommonUtil.numericFormatWithComma(item.getOrdPrice())%></span></del></div></td>
								            <td><%=MessageUtil.getV6Message(lang, "COUT_QTY")%>:<span id="qty<%=item.getContentGuid()%>"/><%=item.getQuantity()%></span>
								             -                                                                                                     
                                                <%=MessageUtil.getV6Message(lang, "COUT_QTY_VAL")%>
                                                <%=MessageUtil.getV6Message(lang, "COUT_SUBTOT")%>:$&nbsp;<span id="amount<%=item.getContentGuid()%>" class="sub_total_amt"></span>
								            <div style="color:#999999"> - -  -  -  -  -  -  -  -  -  -  - </br>
								            <div id=detailspec style="color:#999999"></div>
                                                <script>
                                                $('#qty<%=item.getContentGuid()%>').val(<%=item.getQuantity()%>);
                                                $('#amount<%=item.getContentGuid()%>').html($('#qty<%=item.getContentGuid()%>').val()*<%=item.getActuPrice()%>);
                                                var jsonstr = '<%=CommonUtil.null2Empty(item.getOptionsJsonString())%>';
                                                var opt = JSON.parse(jsonstr);
                                                if(typeof(opt.Options)!=="undefined" && opt.Options!=null){
                                                    var list1 = opt.Options;
                                                    var str = "";
                                                    for(i = 0; i < list1.length; i++){
                                                        if(list1[i].opt1!=="undefined" && list1[i].opt1!=null)
                                                        	str+= list1[i].opt1+"(<%=boItem.getBoiOption1Name()%>)";
                                                        if(list1[i].opt2!=="undefined" && list1[i].opt2!=null)
                                                        	str+= list1[i].opt2+"(<%=boItem.getBoiOption2Name()%>)";
                                                        if(list1[i].opt3!=="undefined" && list1[i].opt3!=null)
                                                            str+= list1[i].opt3+"(<%=boItem.getBoiOption3Name()%>)";
                                                        if(list1[i].opt1!=="undefined" && list1[i].opt1!=null)
                                                            str+= " x " + list1[i].qty+"<br/>";
                                                    }
                                                    $('#detailspec').html(str);
                                                } 
                                                </script>
								            </td>
								            <td><%=MessageUtil.getV6Message(lang, "COUT_SUBTOT")%>:$&nbsp;<%=CommonUtil.numericFormatWithComma(item.getActuPrice() * item.getQuantity())%></td>
								            <td><%=item.getItemRemarks()%></td>
								            </tr>
            
                            <%} //End of Confirm Page
                           } else {
                        	    //Edit Page Start%>
								            <tr>
								            <td><% if (!CommonUtil.isNullOrEmpty(item.getProdImage())) {%><img src="<%=userImagePath%>" height="48"/><%}%></td>
								            <td>
								                <strong><%=item.getProdName()%></strong><br/> 
								                <%=MessageUtil.getV6Message(lang, "BO_PRICE")%>:$&nbsp;<span id="ap<%=item.getContentGuid()%>"><%=CommonUtil.numericFormatWithComma(item.getBoPrice())%></span><br/>
                                                <div style="color:#999999"><del><%=MessageUtil.getV6Message(lang, "COUT_PRICE")%>:$&nbsp;<span id="op<%=item.getContentGuid()%>"><%=CommonUtil.numericFormatWithComma(item.getOrdPrice())%></span></del></div></td>
								            <td><%=MessageUtil.getV6Message(lang, "COUT_QTY")%>:<input type=hidden name="qty<%=item.getContentGuid()%>" id="qty<%=item.getContentGuid()%>" class="qty"
								                                                                       refid="<%=item.getContentGuid()%>">
                                                <span  id="qty<%=item.getContentGuid()%>" style="width:200"><%=item.getQuantity() %></span> - 								                                                                       
								                <%=MessageUtil.getV6Message(lang, "COUT_SUBTOT")%>:$&nbsp;<span id="amount<%=item.getContentGuid()%>" class="sub_total_amt"></span><br/>
								                <div style="color:#999999"> - -  -  -  -  -  -  -  -  -  -  - 
								                <div id=detailspec style="color:#999999"></div>
								                <script>
								                $('#qty<%=item.getContentGuid()%>').val(<%=item.getQuantity()%>);
								                $('#amount<%=item.getContentGuid()%>').html($('#qty<%=item.getContentGuid()%>').val()*<%=item.getActuPrice()%>);
                                                $('#qty<%=item.getContentGuid()%>').val(<%=item.getQuantity()%>);
                                                $('#amount<%=item.getContentGuid()%>').html($('#qty<%=item.getContentGuid()%>').val()*<%=item.getActuPrice()%>);
                                                var jsonstr = '<%=CommonUtil.null2Empty(item.getOptionsJsonString())%>';
                                                var opt = JSON.parse(jsonstr);
                                                if(typeof(opt.Options)!=="undefined" && opt.Options!=null){
                                                    var list1 = opt.Options;
	                                                var str = "";
                                                for(i = 0; i < list1.length; i++){
                                                    if(list1[i].opt1!=="undefined" && list1[i].opt1!=null)
                                                        str+= list1[i].opt1+"(<%=boItem.getBoiOption1Name()%>)";
                                                    if(list1[i].opt2!=="undefined" && list1[i].opt2!=null)
                                                        str+= list1[i].opt2+"(<%=boItem.getBoiOption2Name()%>)";
                                                    if(list1[i].opt3!=="undefined" && list1[i].opt3!=null)
                                                        str+= list1[i].opt3+"(<%=boItem.getBoiOption3Name()%>)";
                                                    if(list1[i].opt1!=="undefined" && list1[i].opt1!=null)
                                                        str+= " x " + list1[i].qty+"<br/>";
                                                }
                                                    $('#detailspec').html(str);
                                                }
                                                
								                </script>
								                </div> 
								            </td>
								            <td align=center><textarea name="remarks<%=item.getContentGuid()%>" id="remarks<%=item.getContentGuid()%>" style="width:80%"><%=CommonUtil.null2Empty(item.getItemRemarks())%></textarea></td>
								            <td align=center>
								            <button class="editbtn" refid="<%=item.getContentGuid() %>"  refname="<%=item.getProdName()%>" refboid="<%=item.getBoitemid() %>"/>修改</button>
								            <button class="delbtn" refid="<%=item.getContentGuid() %>"  refname="<%=item.getProdName()%>"/>刪除</button></td>
								            </tr>
                   <%
                        }//End of Edit Page
                    } //End while
                    out.println("</table>");
                } else {
                	%><div class="ui-widget" id="BO_EMPTY_CART_CHECKOUT" >  <div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
                                                        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>您的清單內未有東西
                        </div></div>
                    <%                                              
                    cmaLogger.error("[CHECKOUT] Checkout an empty cart.", request);
                }
            %>
            <script>
                $(function() {
                    $('.qty')
                    .bind("change", function()
                    {
                        var ref = $(this).attr("refid");
                        $('#amount'+ref).html($('#qty'+ref).val()*$('#ap'+ref).html());
                        $('#tot_amount').html(calSum());
                        return false;
                    });
                });
                function calSum(){
                    var totalsum = 0;
                    $('.sub_total_amt').each(function(i){
                        totalsum += 1 * $(this).html();
                    });

                <% if (V6Util.isLogined(request)) {%>
                        if(totalsum <= <%=thisMember.getMem_cash_balance()%>){
                            $('.acc_de_all').show();
                            $('.acc_de').hide();
                        } else if(<%=thisMember.getMem_cash_balance()%>>0){
                            $('.acc_de_all').hide();
                            $('.acc_de').show();
                            $('.remain_pay').html(totalsum - <%=thisMember.getMem_cash_balance()%>);
                        }
                <% }%>
                        return totalsum;
                    }
            </script>
            <br/>
            <br/>
            <% if (mode.equalsIgnoreCase("confirm")) {%>
            <table width="100%" class="tbl_form">
                <colgroup>
                    <col width="15%"  />
                    <col width="*"  />
                </colgroup>
                <thead>
                    <tr><th colspan="2"><%=MessageUtil.getV6Message(lang, "COUT_BUYER_INFO")%></th></tr>
                </thead>
                <tr><td width="20%"><%=MessageUtil.getV6Message(lang, "COUT_BEMAIL")%></td><td><%=CommonUtil.null2Empty(shoppingCart.getReceiver_email())%></td></tr>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_BNAME")%></td><td><%=CommonUtil.null2Empty(shoppingCart.getReceiver_firstname())%>
                    &nbsp;<%=CommonUtil.null2Empty(shoppingCart.getReceiver_lastname())%>
                </td></tr>
                <tr><td width="20%"><%=MessageUtil.getV6Message(lang, "COUT_BPHONE")%></td><td><%=CommonUtil.null2Empty(shoppingCart.getReceiver_phone())%></td></tr>
            </table>
            <% if (!CommonUtil.isNullOrEmpty(shoppingCart.getReceiver_addr1())
            || !CommonUtil.isNullOrEmpty(shoppingCart.getReceiver_addr2())) {%>
            <table width="100%" class="tbl_form">
                <colgroup>
                    <col width="20%"  />
                    <col width="*"  />
                </colgroup>
                <thead>
                    <tr><th colspan="2"><%=MessageUtil.getV6Message(lang, "COUT_RECEIVER")%></th></tr>
                </thead>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_DEL_OPTIONS")%></td>
                <td><%=("MAIL".equalsIgnoreCase(shoppingCart.getDelivery_options())) ? MessageUtil.getV6Message(lang, "COUT_DEL_MAIL") : ""%>
                    <%=("FACE".equalsIgnoreCase(shoppingCart.getDelivery_options())) ? MessageUtil.getV6Message(lang, "COUT_DEL_FACE") : ""%>
                </td>
                </tr>
                <tr><td width="20%"><%=MessageUtil.getV6Message(lang, "COUT_RADDR")%></td><td>
                    <%=CommonUtil.null2Empty(shoppingCart.getReceiver_addr1())%><br/>
                    <%=CommonUtil.null2Empty(shoppingCart.getReceiver_addr2())%><br/>
                </td></tr>
            </table>
            <% }%>
            <table width="100%" class="tbl_form">
                <colgroup>
                    <col width="20%"  />
                    <col width="*"  />
                </colgroup>
                <thead>
                    <tr><th colspan="2"><%=MessageUtil.getV6Message(lang, "COUT_DESCRIPTION")%></th></tr>
                </thead>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_PAYMENT_METHOD")%></td><td>
                    <%
                        if (shoppingCart.getPaymentMethod().equalsIgnoreCase(
                                Payment.TYPE_PAYPAL)) {
                    %><%=MessageUtil.getV6Message(lang, "COUT_PAYMENT_PAYPAL")%><% } else if (shoppingCart.getPaymentMethod().equalsIgnoreCase(
                            Payment.TYPE_BT)) {
                    %><%=MessageUtil.getV6Message(lang, "COUT_PAYMENT_BANK")%><% } else if (shoppingCart.getPaymentMethod().equalsIgnoreCase(
                            Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_PAYPAL)) {
                    %><%=MessageUtil.getV6Message(lang, "COUT_CASH_PL", (shoppingCart.getOrder_amount() - thisMember.getMem_cash_balance()) + "")%>
                    <% } else if (shoppingCart.getPaymentMethod().equalsIgnoreCase(
                            Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT)) {
                    %><%=MessageUtil.getV6Message(lang, "COUT_CASH_BANK", (shoppingCart.getOrder_amount() - thisMember.getMem_cash_balance()) + "")%>
                    <% } else if (shoppingCart.getPaymentMethod().equalsIgnoreCase(
                            Payment.TYPE_ACC_DEDUCTION)) {
                    %><%=MessageUtil.getV6Message(lang, "COUT_ACC_DEDUCTION")%>
                    <% }%>
                </td></tr>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_TOTAL_AMT")%></td><td>
                    $<%=shoppingCart.getOrder_amount()%>
                </td></tr>
                <% if (shoppingCart.getPaymentMethod().equalsIgnoreCase(
                            Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_PAYPAL)) {%>
                <tr><td>由帳戶扣除</td><td>$<%=thisMember.getMem_cash_balance()%> <%=MessageUtil.getV6Message(lang, "COUT_REMAIN", "0")%></td></tr>
                <tr><td>Paypal 付款</td><td>$<%=shoppingCart.getOrder_amount() - thisMember.getMem_cash_balance()%></td></tr>
                <% }%>
                <tr><td colspan="2">
                    <%=CommonUtil.null2Empty(shoppingCart.getBuyer_remarks())%>
                </td></tr>
            </table>
            <% } else if(shoppingCart!=null){%>
            <table width="100%" class="tbl_form">
                <colgroup>
                    <col width="15%"  />
                    <col width="*"  />
                </colgroup>
                <thead>
                    <tr><th colspan="2"><%=MessageUtil.getV6Message(lang, "COUT_BUYER_INFO")%></th></tr>
                </thead>
                <tr><td width="20%"><%=MessageUtil.getV6Message(lang, "COUT_BEMAIL")%></td>
                <% if (CommonUtil.isNullOrEmpty(shoppingCart.getReceiver_email())) {%>
                <td><input type="text" name="buyer_email" id="buyer_email" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_email())%>"/>
                </td>
                <% } else {%>
                <td><input type="hidden" name="buyer_email" id="buyer_email" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_email())%>"/>
                    <%=CommonUtil.null2Empty(shoppingCart.getReceiver_email())%></td>
                    <% }%>
                </tr>
                <% if (!V6Util.isLogined(request)) {%>
                <tr><td width="20%"><%=MessageUtil.getV6Message(lang, "COUT_PASSWD")%></td><td><input type="password" name="buyer_passwd" id="buyer_passwd" value=""/><br/><br/>
                <button id="btn_checkoutlogin"/><%=MessageUtil.getV6Message(lang, "COUT_LOGIN")%></button>
                <button id="btn_joinnow"/><%=MessageUtil.getV6Message(lang, "COUT_REG")%></button><br/>
                <br/><div style="width:150px;text-align:center">------ 或者 ------</div>
                <br/><br/>
                <a href="javascript:void(0);" onclick="facebook_requestSession();"><img src="<%=staticPath%>/images/facebook.png" alt="Connect" border="0"/></a><div id="FB_REDIRECT_FLG"/>
                </td></tr>
                <% }%>

                <% if (V6Util.isLogined(request)) {%>
                <% if (CommonUtil.isNullOrEmpty(shoppingCart.getReceiver_firstname())
                            || CommonUtil.isNullOrEmpty(shoppingCart.getReceiver_lastname())) {%>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_BNAME")%></td><td><%=MessageUtil.getV6Message(lang, "COUT_BFIRSTNAME")%>  <input type="text" name="buyer_first" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_firstname())%>" size="10"/>
                    <%=MessageUtil.getV6Message(lang, "COUT_BLASTNAME")%>&nbsp;<input type="text" name="buyer_lastname" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_lastname())%>" size="10"/>
                </td></tr>
                <% } else {%>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_BNAME")%></td><td><input type="hidden" name="buyer_first" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_firstname())%>"/>
                    <input type="hidden" name="buyer_lastname" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_lastname())%>"/>
                    <%=CommonUtil.null2Empty(shoppingCart.getReceiver_firstname())%>&nbsp;<%=CommonUtil.null2Empty(shoppingCart.getReceiver_lastname())%>
                </td></tr>
                <% }%>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_DEL_OPTIONS")%></td>
                <td>
                    <%--
                    <input type="radio" name="delivery_option" value="MAIL" <%=("MAIL".equalsIgnoreCase(shoppingCart.getDelivery_options()) || CommonUtil.isNullOrEmpty(shoppingCart.getDelivery_options())) ? "checked" : ""%>/><%=MessageUtil.getV6Message(lang, "COUT_DEL_MAIL")%><br/>
                     --%>
                    <input checked type="radio" name="delivery_option" value="FACE" <%=("FACE".equalsIgnoreCase(shoppingCart.getDelivery_options())) ? "checked" : ""%>/><%=MessageUtil.getV6Message(lang, "COUT_DEL_FACE") + MessageUtil.getV6Message(lang, "COUT_DEL_FACE_MSG")%><br/>
                </td></tr>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_BPHONE")%></td><td><input type="text" name="buyer_phone" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_phone())%>"/></td></tr>
                <tr><td colspan=2 style="color:#888888">
                    如因為填報虛假或錯誤資料而引致商品交收失誤, 本公司概不負責</td></tr>
                <%--
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_RADDR")%></td><td>
                    <input type="text" name="rec_addr1" size="40" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_addr1())%>"/><br/>
                    <input type="text" name="rec_addr2" size="40" value="<%=CommonUtil.null2Empty(shoppingCart.getReceiver_addr2())%>"/><br/>
                </td></tr>
                 --%>
                <% }%>
            </table>
            <%-- Checkout Form for Login already --%>
            <% if (V6Util.isLogined(request)) {%>
            <table width="100%" class="tbl_form">
                <colgroup>
                    <col width="20%"  />
                    <col width="*"  />
                </colgroup>
                <thead>
                    <tr><th colspan="2"><%=MessageUtil.getV6Message(lang, "COUT_DESCRIPTION")%></th></tr>
                </thead>
                <% if (V6Util.isLogined(request)) {%>
                <tr style="color:#888888"><td>BuyBuyMeat 帳戶結餘</td><td>
                    $<%=thisMember.getMem_cash_balance()%>
                </td></tr>
                <% }%>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_PAYMENT_METHOD")%></td><td>
                    <% if (V6Util.isMainsiteLogin(thisMember)) {%>
                    <input type=radio class="pay_radio" name="payment_method" value="<%=Payment.TYPE_PAYPAL%>"/><%=MessageUtil.getV6Message(lang, "COUT_PAYMENT_PAYPAL")%><br/>
                    <% }%>
                    <input type=radio class="pay_radio"  name="payment_method" value="<%=Payment.TYPE_BT%>"/><%=MessageUtil.getV6Message(lang, "COUT_PAYMENT_BANK")%></br/>
                    <div class="acc_de" style="display:none" >
                        <input type=radio class="pay_radio"   name="payment_method" value="<%=Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_PAYPAL%>"/><%=MessageUtil.getV6Message(lang, "COUT_CASH_PL")%></br/>
                        <input type=radio class="pay_radio"   name="payment_method" value="<%=Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT%>"/><%=MessageUtil.getV6Message(lang, "COUT_CASH_BT")%></br/>
                    </div>
                    <div class="acc_de_all" style="display:none" >
                        <input type=radio class="pay_radio"   name="payment_method" value="<%=Payment.TYPE_ACC_DEDUCTION%>"/><%=MessageUtil.getV6Message(lang, "COUT_ACC_DEDUCTION")%>
                    </div>
                    <script>
                        <% if (!CommonUtil.isNullOrEmpty(shoppingCart.getPaymentMethod())) {%>
                            $('.pay_radio').val(["<%=shoppingCart.getPaymentMethod()%>"]);
                        <% } else {%>
                            $('.pay_radio').val(["<%=Payment.TYPE_BT%>"]);
                        <% }%>
                    </script>
                </td></tr>
                <tr><td><%=MessageUtil.getV6Message(lang, "COUT_TOTAL_AMT")%></td><td>
                <input type=hidden name="payment_schema" value="M_T"/>$<span id="tot_amount">
                    <script>$('#tot_amount').html(calSum());</script></span>
                </td></tr>
                <tr><td colspan="2"><%=MessageUtil.getV6Message(lang, "COUT_DESCRIPTION_MSG")%><br/>
                    <textarea cols="40" rows="5" name="buyer_remarks"><%=CommonUtil.null2Empty(shoppingCart.getBuyer_remarks())%></textarea>
                </td></tr>
            </table>
            <% }%>
            <%-- End of Checkout Form for Login already --%>
            <% }%>
            <br/>
            <% if (mode.equalsIgnoreCase("confirm")) {%>
            <button id="checkout-back"><%=MessageUtil.getV6Message(lang, "COUT_EDIT")%></button>
            <button id="checkout-proceed"><%=MessageUtil.getV6Message(lang, "COUT_NOW")%></button><div style="display:none" class="loadinggif">處理中, 請稍候<img src="<%=staticPath%>/images/loader.gif"/></div>

            <% } else if (V6Util.isLogined(request)) {%>
            <button id="checkout-submit"><%=MessageUtil.getV6Message(lang, "COUT_NOW")%></button><div style="display:none" class="loadinggif">處理中, 請稍候<img src="<%=staticPath%>/images/loader.gif"/></div>
                <% }%>
            </form>
            <script>
                $(function() {
                    $('#checkout-submit')
                    .button()
                    .click(function() {
                        $('.loadinggif').show();
                        $('#checkout-submit').hide();
                        $.ajax({
                            url: "<%=request.getAttribute("contextPath")%>/do/PUBLIC/?action=CHECKOUT&type=BO&step=confirm&c="+new Date().getTime(),
                            type: "POST",
                            cache: false,
                            data: $("#checkout_form").serialize(),
                            success: function (html) {
                                $("#checkout-region").html(html);
                                $.ajax({
                                    url: "<%=request.getAttribute("contextPath")%>/do/PUBLIC/?action=REFRESH&c="+new Date().getTime(),
                                    type: "POST",
                                    cache: false,
                                    success: function (html) {
                                        $("#ctnSidebar").html(html);
                                    }
                                });
                            }
                        });
                        return false;
                    });
                    $('#checkout-back')
                    .button()
                    .click(function() {
                    	self.location = "<%=request.getAttribute("contextPath")%>/main.do?action=CHECKOUT&type=BO&c="+new Date().getTime();
                    	return false;
                    });
                    $('#checkout-proceed')
                    .button()
                    .click(function() {
                        $('#checkout-back').hide();
                        $('#checkout-proceed').hide();
                        $('.loadinggif').show();
                        $.ajax({
                            url: "<%=request.getAttribute("contextPath")%>/do/PUBLIC/?action=CHECKOUT&step=proceed&type=BO&c="+new Date().getTime(),
                            type: "POST",
                            cache: false,
                            success: function (html) {
                                $("#checkout-region").html(html);
                            }
                        });
                        return false;
                    });
                    $('.delbtn')
                    .button()
                    .click(function() {
                        var ref = $(this).attr("refid");
                        var refname = $(this).attr("refname");
                        if(confirm("您要刪除\""+ refname + "\" 嗎?")){
                        $.ajax({
                            url: "<%=request.getAttribute("contextPath")%>/do/PUBLIC?action=CHECKOUTDEL&type=BO&guid="+ref+"c="+new Date().getTime(),
                            type: "GET",
                            cache: false,
                            success: function (html) {
                                self.location="<%=request.getAttribute("contextPath")%>/main.do?action=CHECKOUT&type=BO"
                            }
                        });
                        }
                        return false;
                    });
                    
                    $('.editbtn')
                    .button()
                    .click(function() {
                        var ref = $(this).attr("refid");
                        var refname = $(this).attr("refname");
                        var boid = $(this).attr("refboid");
                        self.location = "<%=request.getAttribute("contextPath")%>/main.do?v="+ref+"&boid="+boid;
                        return false;
                    });                    
                    $('#btn_joinnow')
                    .click(function(){
                        if($("#loadform").html()==""){
                            $.ajax({
                                url: "<%=request.getAttribute("contextPath")%>/jsp/registerBuyer.jsp?<%=SystemConstants.REQ_ATTR_LANG + "=" + request.getAttribute(SystemConstants.REQ_ATTR_LANG)%>&id="+ $('#buyer_email').val() + "&c="+new Date().getTime(),
                                type: "POST",
                                cache: false,
                                success: function (html) {
                                    $("#loadform").html(html);
                                    setTimeout("$('#dialogRegBuyer-form').dialog('open');",1000);
                                }
                            });
                        } else {
                            $('#dialogRegBuyer-form').dialog('open');
                            $("#REG_MEM_EMAIL").val($('#buyer_email').val());
                        }
                        return false;
                    });

                    $('#btn_checkoutlogin')
                    .click(function(){
                        $('#txtMbrID_cout').val($('#buyer_email').val());
                        $('#txtMbrPIN_cout').val($('#buyer_passwd').val());
                        $('#checkoutlogin').submit();
                        return false;
                    });
                });
            </script>
            <form action="<%=request.getAttribute("contextPath")%>/do/LOGIN" id="checkoutlogin" method="post">
                <input type="hidden" name="action" value="LOGIN"/>
                <input type="hidden" name="txtMbrID" id="txtMbrID_cout"/>
                <input type="hidden" name="txtMbrPIN" id="txtMbrPIN_cout"/>
                <input type="hidden" name="redirectURL" value="<%=request.getAttribute("contextPath")%>/do/PUBLIC?action=CHECKOUT&type=BO"/>
            </form>
            <% } catch (Exception e) {
                    cmaLogger.error("Error:", e);
                }
            %>