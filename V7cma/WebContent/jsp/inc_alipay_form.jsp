<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.util.ArrayList" %>
<%
    String tmpImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/";
    String tmpValue = "";
%>
<%@include file="/init.jsp" %>
<script type="text/javascript" src="<%=staticPath%>/js/ajaxupload.js"></script>
<style id="styles" type="text/css">
    .wrapper { width: 500px; margin: 0 auto; }
    div.button {
        border: solid 2px Transparent;
        border-color: #eeeeee;
        height:128px;	
        width: 128px;
        background: url(<%=staticPath%>/images/pictures.png) 0 0;
    }
    div.button.hover {
        border-color: #aaaaaa;
        cursor: pointer;	
    }
    div.button.loading {
        background: url(<%=staticPath%>/images/ajax-loader.gif) 0 0 no-repeat;
    }
</style>
<% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))) {%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <%=(String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
    </div>
</div>
<br/>
<% } else if (CommonUtil.isNullOrEmpty((String) request.getAttribute("confirm"))) {%>
<form id="payment-form">
    <p>  <div style="float:right; width:200px">
        <table width="200" cellpadding="3" border="1">
            <tr><td colspan="2" style="background-color:#ddeeee;"><strong>匯率參考 (<%=MessageUtil.getV6Message(lang, "ALI_RATE")%>)</strong></td></tr>
            <tr><td>RMB</td><td>HKD</td></tr>
            <tr><td>100</td><td><%=100 * new Double(MessageUtil.getV6Message(lang, "ALI_RATE"))%></td></tr>
            <tr><td>200</td><td><%=200 * new Double(MessageUtil.getV6Message(lang, "ALI_RATE"))%></td></tr>
            <tr><td>500</td><td><%=500 * new Double(MessageUtil.getV6Message(lang, "ALI_RATE"))%></td></tr>
            <tr><td>1000</td><td><%=1000 * new Double(MessageUtil.getV6Message(lang, "ALI_RATE"))%></td></tr>
        </table>
    </div>1. 預算充值金額(人民幣) 
    <input id="amount" name="amount" value="<%=CommonUtil.null2Empty(request.getParameter("amount"))%>" size="5" maxlength="5" onkeyup="javascript:showHKD();">RMB
    => 需存入港幣 $<span id="HKDamount" style="color:red;position:relative;top:-4px"></span> HKD<br/>
    <span style="color:#9999aa">匯率為: <%=MessageUtil.getV6Message(lang, "ALI_RATE")%></span>
    <br/><br/>
    *  如充值超過RMB 5000, 可電郵admin@buybuymeat.net查詢更優惠之匯價
</p>
<br/>
<br/>
<br/>
<p>
    2. 將所需金額存入本公司帳戶：<br/>
    <br/>中國銀行 012-898-xxxxxx-3　　　
    <br/>匯豐銀行 652-xxxxxxx-833　　
    <br/>
<div  style="color:#9999aa">
    請保留入數紙保障自己
    <br/>*  會員請選用自動存款方式，如：網上/電話銀行，自動存款機和ATM。
    <br/>** 匯豐戶口不接受櫃台入數
</div>
<br/>
<br/>
</p>
<p>
    3. 填寫下表, 通知本公司入帳：<br/><br/>
 <div class="ui-widget"><div id="formerr">
        <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
</div>

<div style="background-color:#eeeeee;padding:5px">
    <table cellpadding="3" cellspacing="3" border="0" width="100%">
        <tr>
            <td width="110">聯絡人:</td>
            <% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute("c_person"))) {
                    tmpValue = (String) request.getAttribute("c_person");
                } else if (V6Util.isLogined(request)) {
                    tmpValue = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser().getMem_display_name();
                } else {
                    tmpValue = "";
                }%>
            <td width="280"><input name="c_person" value=<%=tmpValue%>></td>
            <td>聯絡電話:</td>
                        <% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute("c_phone"))) {
                    tmpValue = (String) request.getAttribute("c_phone");
                } else  {
                    tmpValue = "";
                }%>
            <td><input name="c_phone" value="<%=tmpValue%>" /></td>
        </tr>
        <tr><td>聯絡電郵:</td>
            <% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute("c_email"))) {
                    tmpValue = (String) request.getAttribute("c_email");
                } else if (V6Util.isLogined(request)) {
                    tmpValue = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser().getMem_login_email();
                } else {
                    tmpValue = "";
                }%>
            <td colspan="3"><input name="c_email" size="30" value="<%=tmpValue%>"/></td></tr>
        <tr><td>已存入金額(港幣):</td><td colspan="3"><input name="c_hkd_amount" size="5" <%=CommonUtil.null2Empty((String) request.getAttribute("c_hkd_amount"))%>/>HKD</td></tr>
        <tr><td>存入銀行:</td><td colspan="3">
                <SELECT name="c_bank" id="c_bank">
                    <option value="HSBC">匯豐銀行</option>
                    <option value="BOC">中國銀行</option>
                </select>
                <script>
                    $('#c_bank').val("<%=CommonUtil.null2Empty((String)request.getAttribute("c_bank"))%>");
                </script>
            </td></tr>
        <tr><td><%=MessageUtil.getV6Message(lang, "TXT_BT_DATE")%>:</td>
              <% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute("c_date"))) {
                    tmpValue = (String) request.getAttribute("c_date");
                } else if (V6Util.isLogined(request)) {
                    tmpValue = CommonUtil.formatDate(new java.util.Date(), "dd-MM-yyyy");
                } else {
                    tmpValue = "";
                }%>
                <td><input name="c_date" maxlength="10" size="10" value="<%=tmpValue%>"/>
                <select name="c_time" id="c_time">
                </select>:
                <select name="c_time_m" id="c_time_m">
                </select>
                <script>
                    var selectValues = ["","00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];
                    var selectMin = ["","00~15","16~30","31~45","46~59"];
                    $.each(selectValues, function(key,value) {   
                        $('#c_time')
                        .append($("<option></option>").attr("value",value).text(value)); 
                    });
                    $.each(selectMin, function(key,value) {   
                        $('#c_time_m')
                        .append($("<option></option>").attr("value",value).text(value)); 
                    });
                    $('#c_time').val("<%=CommonUtil.null2Empty((String)request.getAttribute("c_time"))%>");
                    $('#c_time_m').val("<%=CommonUtil.null2Empty((String)request.getAttribute("c_time_m"))%>");
                </script>
            </td>
        </tr>
        <tr><td style="color:red">充值帳戶(電郵)：</td>
            <td colspan="3" style="color:red"><input name="c_ali_email" size="30" value=<%=(V6Util.isLogined(request)) ? "\"" + ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser().getMem_login_email() + "\"" : "\"" + CommonUtil.null2Empty(request.getParameter("email")) + "\""%>/>(在此填上支付寶帳號/登入電郵)</td></tr>
        <tr><td>帳戶名稱(姓名)：</td>
            <td colspan="3"><input name="c_ali_name" size="20" value="" />(作核對支付寶帳戶之用)</td></tr>                                
        <tr valign="top"><td><%=MessageUtil.getV6Message(lang, "TXT_BT_SCRIPT")%></td>
            <td colspan="3">
                <%=MessageUtil.getV6Message(lang, "TXT_BT_SCRIPT_MSG")%>
                <br/><br/>
                <div class="wrapper" id="button1_region"><div id="button1" class="button" style="border:1px solid #ccc;width:400px">
                    </div><img src="" id="preview" width="300" style="display:none"/></div>
                <input type="hidden" name="SCRIPT_IMAGE_1" id="SCRIPT_button1"/><br/><br/>
            </td>
        </tr>
        <tr><td colspan="4">
                <button id="btn-submit"><%=MessageUtil.getV6Message(lang, "BUT_SUBMIT")%></button>	
            </td>
        </tr>
    </table>
</div>
</p>
<input type=hidden id="submit_action" name="action" value=""/>
</form>
<script>
    function showHKD(){
        var thisObj = $('#amount');
        if(thisObj.val() != "") {
            var value = thisObj.val().replace(/^\s\s*/, '').replace(/\s\s*$/, '');
            var intRegex = /^\d+$/;
            if(!intRegex.test(value)) {
                alert("人民幣金額必須為整數");
                thisObj.val("");
                $('#HKDamount').html("");
                thisObj.focus();
            } else {
                $('#HKDamount').html(Math.round(thisObj.val()*<%=MessageUtil.getV6Message(lang, "ALI_RATE")%>*100)/100);
            }
        }  else {
            thisObj.val("");
            $('#HKDamount').html("");
        }
    }
    
    $(function() {
        $('#btn-submit')
        .button()
        .click(function() {
            $('#submit_action').val("submit_payment");
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/do/ALIPAY",
                type: "POST",  
                data: $("#payment-form").serialize(),       
                cache: false,  
                success: function (html) {                
                    $('#alipay-region').html(html);
                }         
            });  
            return false;
        });
    });
    function initAjaxUpload(obj,filename1){
        return new AjaxUpload(
        obj,{
            action: '<%=staticPath%>/upload-btscript-handler.php?O=<%=CommonUtil.null2Empty(request.getParameter("O"))%>&P=<%=CommonUtil.null2Empty(request.getParameter("P"))%>', 
            name: 'userfile',
            onSubmit : function(file, ext){
                if (! (ext && /^(jpg|png|jpeg|gif)$/i.test(ext))){
                    alert('Error: invalid file extension');
                    return false;
                }
                $('#formerr').html("");
                document.getElementById(filename1).style.background = "url(<%=staticPath%>/images/ajax-loader.gif)";
                document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
                this.disable();
            },
            onComplete: function(file, response){
                if(response.indexOf("success")==0){
                    response = response.replace("success:","");
                    $('#formerr').html("");
                    document.getElementById("SCRIPT_"+filename1).value = response;
                    $('#button1').hide();
                    //alert('<%=staticPath%>'+response);
                    $('#preview').attr("src","<%=staticPath%>"+response);
                    $('#preview').show();
                } else {
                    alert("Error:"+ response);
                    //if ($('#formerr').exists()) {
                    $('#formerr').html('<li id="errmsg1"><font color="red">'+response+'</font></li>');
                    //} 
                    document.getElementById(filename1).style.background = "url(<%=staticPath%>/images/pictures.png)";
                }
                this.enable();
            }
        }
    );
    }
    $(document).ready(function(){
        /* Example 1 */
        var button1 = $('#button1'), interval;
        initAjaxUpload(button1,"button1");
    });
</script>
<% } else {%>
CONFIRM
<% }%>
