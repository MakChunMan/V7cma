<%@page import="com.imagsky.common.ImagskySession"%>
<%@page import="java.net.URLEncoder"%>
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
<%@ page import="com.imagsky.v6.cma.servlet.handler.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" dir="ltr" lang="zh-TW">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Pragma" content="no-cache" />   
        <meta http-equiv="Cache-Control" content="no-cache"/>   
        <meta http-equiv="Expires" content="0" />  
        <meta content="NOINDEX, NOFOLLOW" name="ROBOTS" /> 
        <meta content="" name="Keywords"/>
        <meta content="" name="Description"/>
        <title><%=MessageUtil.getV6Message(lang, "TIT_ALIPAY")%> @ <%=MessageUtil.getV6Message(lang, "TIT_CORP")%></title>
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
        </script>
    </head>
    <body>
        <div id="main_container">
            <jsp:include page="/jsp/common/com_header.jsp"></jsp:include>
            <% if (V6Util.isSSLOn() && !request.isSecure()) {%>
            <script> self.location = "https://www.buybuymeat.net/do/ALIPAY";</script>
            <% }%>
            <div id="content">
                <div id="ctnMainFull">
                    <div id="mod_txn" class="mod">
                        <div class="hd2">
                            <h2><%=MessageUtil.getV6Message(lang, "TIT_ALIPAY")%></h2>
                        </div>
                        <div class="bd" id="alipay-region">
                            <center>
                                <div style="width:400px;border-style:dotted; border-width: 2px; border-color: #999999;padding: 15px">
                                    <% if (request.getParameter("ALISTEP") == null) {%>
                                    <div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
                                            <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                            <%=MessageUtil.getV6Message(lang, "MSG_LOGIN_FB_ALIPAY")%>
                                        </div></div>
                                    <span id="FB_LINK" <%=request.getParameter("loading") != null ? "style=\"display:none\"" : ""%>>
                                        <a href="javascript:void()"><img src="<%=staticPath%>/images/facebook.png"/></a>
                                    </span>
                                    <script>
                                        $('#FB_LINK').click(function(){
                                            $('#FB_LINK').hide();
                                            $('#LOADING').show();
                                            var loginurl = '<%=PropertiesConstants.get(PropertiesConstants.fb_tokenurl).replaceAll("@@1@@", PropertiesConstants.get(PropertiesConstants.fb_appid)).replaceAll("@@2@@", URLEncoder.encode((String) request.getAttribute("fullRequestURLQueryString") + "&loading=1", "UTF-8"))%>&locale=zh_HK';
                                           self.location = loginurl;
                                        });
                                        if(window.location.hash.length != 0){
                                            $('#fb_connect_msg').css("display","");
                                            accessToken = window.location.hash.substring(1);
                                            graphUrl = "<%=PropertiesConstants.get(PropertiesConstants.fb_graph)%>me?action=SIGNIN&"+accessToken+"&callback=fbUser";
                                            $('#fb_accesstoken').val(accessToken);
                                            var script = document.createElement("script");
                                            script.src = graphUrl;
                                            document.body.appendChild(script);
                                        }
                         
                                        function fbUser(user) {
                                            $('#fb_id').val(user.id);
                                            $('#fb_email').val(user.email);
                                            $('#fb_name').val(user.name);
                                            $('#fb_firstname').val(user.first_name);
                                            $('#fb_lastname').val(user.last_name);
                                            $('#fb_profile_url').val(user.link);
                                            $.ajax({  
                                                url: "<%=request.getAttribute("contextPath")%>/do/LOGIN?action=FBLOGIN&c="+new Date().getTime(),   
                                                type: "POST",  
                                                cache: false,  
                                                data: $("#fb_login").serialize(),
                                                success: function (html) {                
                                                    self.location="/do/ALIPAY?ALISTEP=2<%=(!CommonUtil.isNullOrEmpty(request.getParameter("biid"))) ? "&biid=" + request.getParameter("biid") : ""%>";
                                                    //$(".login_form").html(html);
                                                }         
                                            }); 
                                        }
                                    </script>
                                    <%}%>
                                    <div id="LOADING" <%=request.getParameter("loading") != null ? "" : "style=\"display:none\""%>>
                                        載入中, 請稍後...<img src="<%=staticPath%>/images/ajax-loader.gif"/>
                                    </div>                          
                                    <div id="LIKE_NOT" style="display:none">                                                                            
                                        <a name="fblike"></a>
                                        <fb:like href="<%=CommonUtil.getHttpProtocal(request)%>www.facebook.com/pages/Buybuymeat/351567678214145" show_faces="false" width="450" font=""></fb:like>
                                    </div>                                                                        
                                    <br/>
                                    <br/> 30秒完成註冊及登入程序<br/>
                                    <span style="color:gray">(注意:使用者需擁有Facebook帳戶)</span><br/>
                                </div>
                                <br/><br/>
                                <div style="width:600px;border-style:dotted; border-width: 2px; border-color: #999999;padding: 15px">
                                    <table>
                                        <tr><td><h3 style="color:#444444">註冊及登入程序</h3><br/><br/>
                                                <img src="<%=staticPath%>/images/step1.jpg"/><br/><br/><br/>
                                                <img src="<%=staticPath%>/images/step2.jpg"/>
                                            </td></tr></table>
                                </div>
                            </center>
                        </div>
                    </div>
                    <div id="footer">
                        <div id="fb-root"></div>
                        <% if (V6Util.isSSLOn() && request.isSecure() && "2".equals(request.getParameter("ALISTEP"))) {%>
                        <script>
                            window.fbAsyncInit = function() {
                                FB.init({
                                    appId   : '<%=FacebookUtil.getAppId()%>',
                                    status  : true, // check login status
                                    cookie  : true, // enable cookies to allow the server to access the session
                                    xfbml   : true // parse XFBML
                                });
            
                                var user_id;  
                                FB.getLoginStatus(function (response) {
                                    var access_token =   FB.getAuthResponse()['accessToken'];
                                    FB.api('/me', function(response) {
                                        user_id = response.id;
                                        var page_id = "351567678214145"; //Page iD
                                        var fql_query = "SELECT uid FROM page_fan WHERE page_id =" + page_id + " and uid=" + user_id;
                                        var the_query = FB.Data.query(fql_query);
                                        the_query.wait(function(rows) {
                                            if (rows.length == 1 && rows[0].uid == user_id) {
                                                $('#FB_LINK').hide();
                                                    self.location = "/do/ALIPAY?action=main&uid="+ user_id +"&like=Y";
                                                } else {
                                                    $('#LIKE_NOT').show();
                                                    $('#FB_LINK').hide();
                                                }
                                            });
                                        });
                                    });
                    
                                    FB.Event.subscribe('edge.create', function(href, widget) {
                                    self.location = "/do/ALIPAY?action=main&uid="+ user_id +"&like=Y";
                                    }
                                );
                                };
                        </script>
                        <% }%>
                        <jsp:include page="/jsp/common/com_footer.jsp"></jsp:include>
                        </div>	
                    </div>
                    <div id="navMenu">
                    <jsp:include page="/jsp/common/com_subnav.jsp"></jsp:include>
                </div>
                <div id="loadform"></div>
            </div></div>
        <iframe src="javascript:false" id="frameNavElement" ></iframe>
        <div id="heightTest"></div>
    </body>
</html>
