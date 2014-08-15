<%@page import="com.imagsky.common.ImagskySession"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
    String thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
%>  
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.servlet.handler.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>    
<style id="styles" type="text/css">
    .dp25{width:28%; float:left; margin:5px; padding:0px 7px; *margin-right:-1px; height:330px; border: solid 1px;border-color:#dddddd} 
    .dp50{width:50%; float:left; *margin-right:-1px;}
</style>
<% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))) {%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <%=(String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
    </div></div>
<%}%>
<% if("MSG_INPUT_ADDRESS".equalsIgnoreCase((String)request.getSession().getAttribute(SystemConstants.REQ_ATTR_REMINDER))){%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <%=MessageUtil.getV6Message(lang,"MSG_INPUT_ADDRESS")%>
    </div></div>
<%} %>
<br/>
<%--FB--%>
<div id="fb-root"></div>
<script>
    window.fbAsyncInit = function() {
        FB.init({
            appId      : '<%=FacebookUtil.getAppId()%>', // App ID
            status     : true, // check login status
            cookie     : true, // enable cookies to allow the server to access the session
            xfbml      : true  // parse XFBML
        });
        FB.getLoginStatus(function (response) {
            access_token =   FB.getAuthResponse()['accessToken'];
            if(access_token!=""){
                FB.api('/me', function(response) {
                    user_id = response.id;
                    var page_id = "351567678214145"; //Page iD
                    var fql_query = "SELECT uid FROM page_fan WHERE page_id =" + page_id + " and uid=" + user_id;
                    var the_query = FB.Data.query(fql_query);
                    the_query.wait(function(rows) {
                        if (rows.length == 1 && rows[0].uid == user_id) {
                            //alert('like: ' + access_token);
                        } else {
                            self.location="/do/BID2?step=2";//Not Like
                        }
                    });
                });
            }
        });
    };
</script>
<%
    Member thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/";
    List aList = (List) request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
    java.util.Date now = new java.util.Date();
%>
<div class="ui-widget"><div id="formerr">
        <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
    </div>			
<%
    Collection<BidItem> newProds = aList;
    BidItem tmpProd = null;
    boolean rowstarted = false;
    Iterator<BidItem> its = newProds.iterator();
    int x = 0;

    while (its.hasNext()) {
        if (x == 0) {
            out.println("<div id='bo-region-a'>");
            rowstarted = true;
        }
        out.println("<div class=\"dp25\">");
        tmpProd = (BidItem) its.next();%>
<div style="text-align:center;display:block;">
    <a href="BID2/details/<%=tmpProd.getId()%>">
        <img id="imgsrc_<%=tmpProd.getId()%>" src="<%=userImagePath + tmpProd.getSellitem().getProd_owner() + "/dtl_" + tmpProd.getSellitem().getProd_image1()%>" width="250px">
    </a>
    <%--<img src="<%=userImagePath + "thm_" + tmpProd.getProd_image1()%>" alt="<%=tmpProd.getProd_name()%>"/>--%>
</div>
<!-- span class="imgCont120 ico_new" /> -->
<br/>
<div style="height:38px;padding-left: 5px;">
    <a href="BID2/details/<%=tmpProd.getId()%>"><strong><span id="bidname_<%=tmpProd.getId()%>"><%=tmpProd.getSellitem().getProd_name()%></span></strong></a>
</div>
<div  style="padding-left: 5px;color:#888888">
    <table border="0" width="100%">
        <tr><td width="50%">HKD <font color="red"><strong><span id="v_<%=tmpProd.getId()%>"><%=tmpProd.getBid_current_price()%></strong></font></td>
            <td align="right">出價次數 <a href="javascript:showHist('<%=tmpProd.getId()%>');"><%=tmpProd.getBid_count()%></a></td>
        </tr>
        <tr><td colspan="2">剩餘  <strong><%=CommonUtil.getDateDiffFullString(thisLang, now, tmpProd.getBid_end_date(), 2)%></strong></td></tr>
        <tr height="50" valign="middle">        
            <td align="center" colspan="2">
                <% if (thisMember == null || tmpProd.getBid_last_bidMember() == null || !tmpProd.getBid_last_bidMember().getMem_login_email().equalsIgnoreCase(thisMember.getMem_login_email())) {%>
                <button class="bid_btn" v="2" bid="<%=tmpProd.getId()%>">+$2</button><button class="bid_btn" v="5" bid="<%=tmpProd.getId()%>">+$5</button><button class="bid_btn" v="10" bid="<%=tmpProd.getId()%>">+$10</button><button class="bid_btn" v="50" bid="<%=tmpProd.getId()%>">+$50</button><br/>
                <% } else {%>
                這是您的出價, 暫時以您的出價最高
                <% }%>
            </td>
        </tr>
    </table>
</div>	 
<%
        out.println("</div>");
        if (x == newProds.size() - 1) {
            out.println("</div>");
            rowstarted = false;
        }
        x++;
    }
    out.println("<script>$('#bo-region-a').height(" + Math.ceil(new Double(newProds.size()) / 3) + " *350);</script>");
%>

<div id="dialog" title="要拍這件嗎?" style="display:none;font-size:75%">
    <form id="dialog_form">
        <Table class="tbl_form" style="color:#888888">
            <tr><td rowspan="2"><img id="dia_img"/></td><td id="dia_name"></td></tr>
            <tr><td>你的出價: HKD <font color="red"><strong><span id="dia_newbid"></span></strong></font>
                    <br/><br/>- - - <br/>
                    您要用以上的價錢出價嗎?
                </td></tr>
        </table>
    </form>
</div>

<script>
    $('.bid_btn').button().css("font-size","80%");
    $('.bid_btn').button().click(function(){
        <% if(!FacebookUtil.isFBLoginedForAuction(request)){%>
                //alert("請先按\"連接登入Facebook\"按鈕.");
                self.location="/do/BID2";
        <% } else { %>
        var thisid = $(this).attr("bid");
        $('#dia_img').attr("src",$('#imgsrc_'+thisid).attr("src"));
        $('#dia_name').html($('#bidname_'+thisid).html());
        var newValue = parseFloat($('#v_'+thisid).html())+parseFloat($(this).attr("v"));
        $('#dia_newbid').html(newValue);
        $("#dialog").dialog({
            height: 300, width: 450, modal: true,
            buttons: {
                "確定出價": function() {
                    postPlaceBid(thisid, newValue);
                    $( this ).dialog( "close" );      
                }}});
        <% } %>
    });
    function showHist(biid){
        $.ajax({  
            url: "/do/BID2?action=hist_AJ&biid="+ biid,   
            type: "GET",  
            cache: false,  
            success: function (html) {                
                $('#dialog_hist').html(html);}
        });  
        $("#dialog_hist").dialog({
            height: 300, width: 450, modal: true,
            close: function() {
                $( this ).dialog( "close" );                                
            }});                                        
    }
</script>
<div id="dialog_hist" title="出價歷史" style="display:none;font-size:65%"></div>