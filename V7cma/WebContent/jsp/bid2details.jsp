<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@page import="com.imagsky.common.ImagskySession"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.servlet.handler.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>    
<%
    String thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
    BidItem bi = (BidItem) request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
    SellItem thisObj = bi.getSellitem();
    String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
            + thisObj.getProd_owner() + "/";
    Member thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    boolean isExpired = (bi.getBid_end_date().getTime() <= (new java.util.Date()).getTime() || bi.getBid_status().equals(BidItem.BidStatus.CANCELLED) || bi.getBid_status().equals(BidItem.BidStatus.FINISHED));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" dir="ltr" lang="zh-TW">
    <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# <%=FacebookUtil.getNamespace()%>: http://ogp.me/ns/fb/<%=FacebookUtil.getNamespace()%>#">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta content="" name="Keywords"/>
        <meta content="" name="Description"/>    
        <meta property="fb:app_id" content="<%=FacebookUtil.getAppId()%>" /> 
        <meta property="og:type"   content="<%=FacebookUtil.getNamespace()%>:item" /> 
        <meta property="og:url"    content="<%=SystemConstants.HTTP + PropertiesConstants.get(PropertiesConstants.externalHost) + "/do/BID2?action=details&biid=" + bi.getId()%>" /> 
        <meta property="og:title"  content="<%=thisObj.getProd_name()%>" /> 
        <meta property="og:image"  content="<%=SystemConstants.HTTP + PropertiesConstants.get(PropertiesConstants.externalHost) + userImagePath + "thm_" + thisObj.getProd_image1()%>" />

        <title><%=MessageUtil.getV6Message(lang, "TIT_BID")%> @ <%=MessageUtil.getV6Message(lang, "TIT_CORP")%></title>
        <link href="<%=staticPath%>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="<%=staticPath%>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
        <link href="<%=staticPath%>/css/flick/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQCSS")%>" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="<%=staticPath%>/js/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERYUI")%>"></script>
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
            function postPlaceBid(thisid,newValue){
                    <% if(PropertiesConstants.get(PropertiesConstants.externalHost).substring(0,9).equalsIgnoreCase("localhost")){%>
                        $('#dialog_form').attr("action","/do/BID2?action=newbid&fr_biditem_id="+ thisid+"&fr_biditem_value="+newValue+"&c="+new Date().getTime());
                        $('#dialog_form').submit();
                        return true; 
                    <% } else { %>
                if(access_token==""){
                    alert("請重新登入Facebook.");
                    self.location="/do/BID2";
                    return false;
                }
                FB.api('/me/<%=FacebookUtil.getNamespace()%>:bid?item=<%=SystemConstants.HTTP + PropertiesConstants.get(PropertiesConstants.externalHost) + "/do/BID2/details/" + bi.getId()%>&access_token='+access_token,
                'post',
                function(response) {
                    var msg = 'Error occured';
                    if (!response || response.error) {
                        if (response.error) {
                            msg += "\n\nType: "+response.error.type+"\n\nMessage: "+response.error.message;
                        }
                        alert(msg);
                        return false;
                    } 
                    else {
                        $('#dialog_form').attr("action","/do/BID2?action=newbid&fr_biditem_id="+ thisid+"&fr_biditem_value="+newValue+"&c="+new Date().getTime());
                        $('#dialog_form').submit();
                        return true;
                    }
                });
                <% } %>
            }
        </script>
    </head>
    <body>
        <a href="javascript:void(0);" name="top"></a>
        <div id="main_container">
            <jsp:include page="/jsp/common/com_header.jsp"></jsp:include>
                <div id="content">
                    <div id="ctnMainFull">
                        <div id="mod_txn" class="mod">
                            <div class="hd2">
                                <h2>$1 拍賣專區</h2>
                            </div>
                            <div class="bd" id="bid-region">
                            <%
                                if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image1())) {%>
                            <div class="img320Right" style="float:right">
                                <img class="dtl_image imgBorder" id="dtl_image1" src="<%=userImagePath + "dtl_" + thisObj.getProd_image1()%>" alt="<%=thisObj.getProd_name()%>" />
                                <img class="dtl_image imgBorder" id="dtl_image2" src="<%=userImagePath + "dtl_" + thisObj.getProd_image2()%>" alt="<%=thisObj.getProd_name()%>" style="display:none"/>
                                <img class="dtl_image imgBorder" id="dtl_image3" src="<%=userImagePath + "dtl_" + thisObj.getProd_image3()%>" alt="<%=thisObj.getProd_name()%>" style="display:none"/>
                                <br/>
                                <table align="right">
                                    <tr>
                                        <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image1())) {%>
                                        <td><a href="#" onMouseover="changeImage(1);"><img class="imgBorder" src="<%=userImagePath + "thm_" + thisObj.getProd_image1()%>" width="70"/></a></td>
                                        <% }%>
                                        <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image2())) {%>
                                        <td><a href="#" onMouseOver="changeImage(2);"><img class="imgBorder" src="<%=userImagePath + "thm_" + thisObj.getProd_image2()%>" width="70"/></a></td>
                                        <% }%>	
                                        <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image3())) {%>
                                        <td><a href="#" onMouseover="changeImage(3);"><img class="imgBorder" src="<%=userImagePath + "thm_" + thisObj.getProd_image3()%>" width="70"/></a></td>
                                        <% }%>
                                    </tr>
                                </table>
                                <script>
                                    function changeImage(ix){
                                        $('.dtl_image').hide();
                                        $('#dtl_image'+ix).show();
                                    }
                                </script>
                            </div>
                            <% }%>
                            <div style="width:60%;background-color:#ccaaee;font-size:128%;padding:5px"><h3><%=thisObj.getProd_name()%></h3></div>
                            <br/>
                            <div style="font-size:114%">
                                <table>
                                    <tr><td width="120"><%=MessageUtil.getV6Message(lang, "TXT_LAST_PRICE")%></td><td><strong>HKD <%=bi.getBid_current_price()%></strong></td></tr>
                                    <tr><td><%=MessageUtil.getV6Message(lang, "TXT_TIME_LEFT")%></td><td><Strong>
                                                <script language="JavaScript">
                                       TargetDate = "<%=CommonUtil.formatDate(bi.getBid_end_date(), "MM/dd/yyyy HH:mm")%>";//12/31/2020 5:00 AM
                                       BackColor = "pink";
                                       ForeColor = "black";
                                       CountActive = true;
                                       CountStepper = -1;
                                       LeadingZero = true;
                                       DisplayFormat = "%%D%% 日, %%H%% 小時, %%M%% 分, %%S%% 秒";
                                       FinishMessage = "已結束!";
                                                </script>
                                                <script language="JavaScript" src="/files/js/countdown.js"></script>          
                                            </strong> 
                                        </td></tr>
                                    <tr><td><%=MessageUtil.getV6Message(lang, "TXT_ENDDATE")%></td><td><%=CommonUtil.formatDate(bi.getBid_end_date())%> 
                                        </td></tr>
                                    <tr><td><%=MessageUtil.getV6Message(lang, "TXT_TIMES")%></td><td><%=bi.getBid_count()%></td></tr>
                                    <tr><td colspan="2">
                                            <br/><br/>
                                            <div style="width:30%;background-color:#edcbff;font-size:102%;padding:3px"><h3>拍賣備註</h3></div>
                                            <%=MessageUtil.getV6Message(lang, "BID_AUCTION_MSG")%><br/><br/>
                                        </td></tr>
                                        <% if(!isExpired){%>
                                        <% if (thisMember == null || bi.getBid_last_bidMember() == null || !bi.getBid_last_bidMember().getMem_login_email().equalsIgnoreCase(thisMember.getMem_login_email())) {%>
                                    <tr style="border-style:dotted;border-width:2px;border-color: plum;height:50px"><td><strong>我要出價</strong></td><td>
                                            <button class="bid_btn" v="2" bid="<%=bi.getId()%>">+$2</button><button class="bid_btn" v="5" bid="<%=bi.getId()%>">+$5</button><button class="bid_btn" v="10" bid="<%=bi.getId()%>">+$10</button><button class="bid_btn" v="50" bid="<%=bi.getId()%>">+$50</button><br/>
                                        </td></tr>
                                        <% } else {%>
                                    <tr><td>***</td><td>暫時以您的出價最高</td></tr>
                                    <% }%>
                                    <%}%>
                                </table>     

                                <br/>
                                <br/>
                            </div>
                            <div style="width:30%;background-color:#edcbff;font-size:102%;padding:3px"><h3>拍賣商品資訊</h3></div>
                            <br/>
                            <%=thisObj.getProd_desc()%>

                            <table>
                                <% if(!isExpired){%>
                                <% if (thisMember == null || bi.getBid_last_bidMember() == null || !bi.getBid_last_bidMember().getMem_login_email().equalsIgnoreCase(thisMember.getMem_login_email())) {%>
                                <tr style="border-style:dotted;border-width:2px;border-color: plum;height:50px"><td width="120"><strong>我要出價</strong></td><td>
                                        <button class="bid_btn" v="2" bid="<%=bi.getId()%>">+$2</button><button class="bid_btn" v="5" bid="<%=bi.getId()%>">+$5</button><button class="bid_btn" v="10" bid="<%=bi.getId()%>">+$10</button><button class="bid_btn" v="50" bid="<%=bi.getId()%>">+$50</button><br/>
                                    </td></tr>
                                    <% }%>
                                    <% }%>
                            </table>     
                            <br/>
                            <br/>
                            <center>
                                <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image1())) {%>
                                <img src="<%=userImagePath + "raw_" + thisObj.getProd_image1()%>"/><br/><br/>
                                <% }%>
                                <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image2())) {%>
                                <img src="<%=userImagePath + "raw_" + thisObj.getProd_image2()%>"/><br/><br/>
                                <% }%>	
                                <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image3())) {%>
                                <img src="<%=userImagePath + "raw_" + thisObj.getProd_image3()%>"/><br/><br/>
                                <% }%>
                            </center>
                            <br/>
                            <table>
                                <% if(!isExpired){%>
                                <% if (thisMember == null || bi.getBid_last_bidMember() == null || !bi.getBid_last_bidMember().getMem_login_email().equalsIgnoreCase(thisMember.getMem_login_email())) {%>
                                <tr style="border-style:dotted;border-width:2px;border-color: plum;height:50px"><td width="120"><strong>我要出價</strong></td><td>
                                        <button class="bid_btn" v="2" bid="<%=bi.getId()%>">+$2</button><button class="bid_btn" v="5" bid="<%=bi.getId()%>">+$5</button><button class="bid_btn" v="10" bid="<%=bi.getId()%>">+$10</button><button class="bid_btn" v="50" bid="<%=bi.getId()%>">+$50</button><br/>
                                    </td></tr>
                                    <% }%>
                                    <% }%>
                            </table>     
                            <ul class="other_news">
                                <li class="bulletLink"><a href="/do/BID2?action=main">返回拍賣主頁</a></li>
                                <li class="bulletLink"><a href="#top">回到最上</a></li>
                            </ul>    
                            <% if(!isExpired){%>
                            <div id="dialog" title="要拍這件嗎?" style="display:none;font-size:75%">
                                <form id="dialog_form">
                                    <Table class="tbl_form" style="color:#888888">
                                        <tr><td rowspan="2"><img src="<%=userImagePath + "thm_" + thisObj.getProd_image1()%>"/></td><td id="dia_name"><%=thisObj.getProd_name()%></td></tr>
                                        <tr><td>你的出價: HKD <font color="red"><strong><span id="dia_newbid"></span></strong></font>
                                                <br/><br/>- - - <br/>
                                                您要用以上的價錢出價嗎?
                                            </td></tr>
                                    </table>
                                </form>
                            </div>
                            <%}%>

                            <%--FB--%>
                            <div id="fb-root"></div>
                            <script>
                                var access_token = "";
                                window.fbAsyncInit = function() {
                                    FB.init({
                                        appId      : '<%=FacebookUtil.getAppId()%>', // App ID
                                        status     : true, // check login status
                                        cookie     : true, // enable cookies to allow the server to access the session
                                        xfbml      : true  // parse XFBML
                                    });
                                    FB.getLoginStatus(function (response) {
                                        access_token =   FB.getAuthResponse()['accessToken'];
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
                                    });
                                };
                            </script>
                            <script>
                                $('.bid_btn').button().css("font-size","80%");
                                $('.bid_btn').button().click(function(){
                                            <% if(!FacebookUtil.isFBLoginedForAuction(request)){%>
                                                    //alert("請先按\"連接登入Facebook\"按鈕.");
                                                    self.location="/do/BID2?biid="+$(this).attr("bid");
                                            <% } else { %>
                                    var thisid = $(this).attr("bid");
                                    var newValue = parseFloat(<%=bi.getBid_current_price()%>)+parseFloat($(this).attr("v"));
                                    $('#dia_newbid').html(newValue);
                                    $("#dialog").dialog({
                                        height: 300, width: 450, modal: true,
                                        buttons: {
                                            "確定下拍": function() {
                                                postPlaceBid(thisid, newValue);
                                                $( this ).dialog( "close" );                                
                                            }}
                                    });
                                    <%} %>
                                });
                            </script>    

                        </div>
                    </div>
                    <div class="shadow940px"></div>
                    <div id="footer">
                        <jsp:include page="/jsp/common/com_footer.jsp"></jsp:include>
                        </div>	
                    </div>
                    <div id="navMenu">
                    <jsp:include page="/jsp/common/com_subnav.jsp"></jsp:include>
                </div>
                <div id="loadform"></div>
            </div></div>
        </div>
        <iframe src="javascript:false" id="frameNavElement" ></iframe>
        <div id="heightTest"></div>
    </body>
</html>
