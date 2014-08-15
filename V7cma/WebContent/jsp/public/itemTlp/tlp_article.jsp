<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@include file="/init.jsp" %>
<%
    Article thisObj = (Article) request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
    Member thisMember = null;//Shop
    Node thisNode = null;
//SHOP INFO
    if (CommonUtil.null2Empty(request.getAttribute(SystemConstants.PUB_FLG)).equalsIgnoreCase("Y")) {
        thisMember = (Member) request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
    }
//META DATA
    if (request.getAttribute("THIS_NODE") != null) {
        thisNode = (Node) request.getAttribute("THIS_NODE");
    } else {
        thisNode = new Node();
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://ogp.me/ns/fb#" dir="ltr" lang="zh-TW">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="pragma" content="no-cache">
                <meta http-equiv="expires" content="0">
                    <link rel="shortcut icon" href="/favicon.ico" />
                    <meta name="robots" content="all, index, follow" />
                    <meta name="distribution" content="global" />
                    <meta content="<%=CommonUtil.null2Empty(thisNode.getNod_keyword())%>" name="Keywords"/>
                    <meta name="title" content="<%=thisObj.getArti_name()%><% if (!V6Util.isMainsite(request)) {%>@ <%=thisMember.getMem_shopname()%><%}%> | <%=MessageUtil.getV6Message(lang, "TIT_CORP")%>" />
                    <meta name="description" content="<%=CommonUtil.null2Empty(thisNode.getNod_description())%>" />
                    <meta property="og:title" content="<%=thisObj.getArti_name()%> <% if (!V6Util.isMainsite(request)) {%>@ <%=thisMember.getMem_shopname()%><%}%> | <%=MessageUtil.getV6Message(lang, "TIT_CORP")%>"/>
                    <meta property="og:url" content="<%=request.getAttribute("fullRequestURL")%>"/>
                    <%--<meta property="og:image" content="http://ia.media-imdb.com/rock.jpg"/> --%>
                    <meta property="og:description" content="<%=CommonUtil.null2Empty(thisNode.getNod_description())%>"/>
                    <title><%=thisObj.getArti_name()%> <% if (!V6Util.isMainsite(request)) {%>@ <%=thisMember.getMem_shopname()%><%}%> | <%=MessageUtil.getV6Message(lang, "TIT_CORP")%></title>
                    <link href="<%=staticPath%>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
                    <link href="<%=staticPath%>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
                    <link href="<%=staticPath%>/css/flick/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQCSS")%>" rel="stylesheet" type="text/css"/>
                    <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERY")%>"></script>
                    <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERYUI")%>"></script>
                    <!--// script for Google Analystic -->
                    <script type="text/javascript" src="<%=staticPath%>/script/ga.js"></script>
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
                        function pagaInit() {
                            drawmenu("ctnSidebar", sb_setting);
                        }
                        //]]>
                        //--><!]]>
                    </script>
                    <script type="text/javascript">
                        //<![CDATA[

                        // Uncomment the following code to test the "Timeout Loading Method".
                        // CKEDITOR.loadFullCoreTimeout = 5;

                        window.onload = function()
                        {
                            pagaInit();

                        };

                        function setCookie(c_name,value,expiredays)   // c_name: cookie name, value: cookie value, expiredays: cookie 有效天數 
                        {
                            var exdate=new Date();                      
                            exdate.setDate(exdate.getDate()+expiredays);
                            document.cookie=c_name+ "=" +escape(value)+ ((expiredays==null) ? "" : ";expires="+exdate);
                        }
                        function getCookie(c_name)
                        {
                            if (document.cookie.length>0)
                            {
                                var c_list = document.cookie.split("\;");
                                for ( i in c_list )
                                {
                                    var cook = c_list[i].split("=");
                                    if ( cook[0] == c_name )
                                    {
                                        return unescape(cook[1]);
                                    }
                                } 
                            }
                            return null;
                        }
                    </script>
                    <script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
                    </head>
                    <body>
                        <div id="main_container">
                            <jsp:include page="/jsp/common/com_header.jsp"></jsp:include>
                            <div id="content">
                                <div id="ctnMain">
                                    <div id="mod_maincontent" class="mod">
                                        <div class="hd2">
                                            <h2><%=thisObj.getArti_name()%></h2>
                                        </div>
                                        <div class="bd" id="arti-region">
                                            <div id="fb-root"></div>
                                            <% if ("J".equalsIgnoreCase(thisObj.getArti_type())) {%>
                                            <div id="dialog-modal" title="追蹤 BuyBuyMeat社交網頁" style="display:none;font-size:80%">
                                                <p><br/>強烈建議 "追蹤" BuyBuyMeat 社交網頁, 讓我們每天為您更新資訊 ^o^.</p>
                                                <table width="100%" border="1" style="border-color:#eeeeee;border-style:solid;">
                                                    <tr>
                                                        <td style="vertical-align:middle;" align="center">
                                                            <strong><span style="color:#10527D;font-size:120%">Google Plus One</span></strong>
                                                        </td>
                                                        <td>
                                                            <g:plusone  size="tall" count="true"></g:plusone>
                                                        </td>
                                                        <td width="50%">
                                                            <p>
                                                                <fb:like-box href="<%=CommonUtil.getHttpProtocal(request)%>www.facebook.com/pages/Buybuymeat/351567678214145" width="300" show_faces="false" stream="false" header="false">
                                                                </fb:like-box>
                                                            </p>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div style="position:relative;"></div>
                                            </div>
                                            <script>                	 	
                                                $('div#dialog-modal').bind('dialogclose', function(event) {   
                                                    setCookie("FB_LIKE","2",1);
                                                });</script>
                                            <br class="clearfloat"/>
                                            <div class="shortcut_buttons" style="color:#555577">
                                            </div>				
                                            <br class="clearfloat"/>
                                            <br/>
                                            <br/>	
                                            <% }%>								
                                            <%=thisObj.getArti_content()%>
                                            <%--thisObj.getArti_content().replaceAll("https://", CommonUtil.getHttpProtocal(request)).replaceAll("http://", CommonUtil.getHttpProtocal(request))%>--%>
                                            <script>
                                                $('#breadcrumb-tail').html('<a href="#"><strong><%=thisObj.getArti_name()%></strong></a>');
                                                $('#breadcrumb-tail').attr("style","font-size:106%;line-height:1.8em;color:#000;padding-top:1px;");
                                            </script>
                                            <%-- IF ArtiType is not Empty and not JETSO then force LIKE --%>
                                            <% if (!CommonUtil.isNullOrEmpty(thisObj.getArti_type()) && !"J".equalsIgnoreCase(thisObj.getArti_type())) {%>
                                            <div id="LIKE_MSG_CONTENT" style="height:150px;border-style:dashed;border-width:1px;padding:20px">
                                                <p>如欲閱讀隱藏內容，請先按「讚」。</p>
                                                <p>
                                                    <div class="fb-like" href="<%=CommonUtil.getHttpProtocal(request)%>www.facebook.com/pages/Buybuymeat/351567678214145" data-send="true" data-width="450" data-show-faces="false"></div>
                                                </p>
                                            </div>
                                            <script>
                                                if($('#HIDDEN_CONTENT').length == 0 || $('#HIDDEN_CONTENT').html().length == 0){
                                                    $('#LIKE_MSG_CONTENT').hide();
                                                }
                                            </script>
                                            <% }%>					
                                        </div>
                                        <div class="shadow690px"></div>
                                    </div>

                                </div>
                                <div id="ctnSidebar">
                                    <jsp:include page="/jsp/common/com_slidesection.jsp"></jsp:include>
                                </div>
                            </div>
                            <div id="footer">
                                <div id="fb-root"></div>
                                <script>
                                    window.fbAsyncInit = function() {
                                        FB.init({appId: '370877426290056', status: true, cookie: true,  xfbml: true});
                                        FB.getLoginStatus(function (response) {
                                            //var access_token =   FB.getAuthResponse()['accessToken'];
                                            FB.api('/me', function(response) {
                                                user_id = response.id;
                                                var page_id = "351567678214145"; //Page iD
                                                var fql_query = "SELECT uid FROM page_fan WHERE page_id =" + page_id + " and uid=" + user_id;
                                                var the_query = FB.Data.query(fql_query);
                                                the_query.wait(function(rows) {
                                                    if (rows.length == 1 && rows[0].uid == user_id) {
                                                        $('#HIDDEN_CONTENT').show();
                                                        $('#LIKE_MSG_CONTENT').hide();
                                                    } else {
                                                        //NOT LIKE
                                                    }
                                                });
                                            });
                        
                                        });
                                            FB.Event.subscribe('edge.create', function(href, widget) {
                                            $('#HIDDEN_CONTENT').show();
                                            $('#LIKE_MSG_CONTENT').hide();
                                        }
                                    );
                                    };
                                </script>
                                <jsp:include page="/jsp/common/com_footer.jsp"></jsp:include>
                                <script>
                                    function getURLParameter(name) {     
                                        return decodeURI(         (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]     ); 
                                    }
                                </script>
                                <script>
                                    function showDialog(){
                                        $("#dialog-modal" ).dialog({
                                            height: 200, width: 600, modal: true
                                        });
                                    }
                                </script>
                                <% if ("J".equalsIgnoreCase(thisObj.getArti_type())) {
                                        //ONLY JSTSO PAGE Popup encourage LIKE
                                %>
                                <script type="text/javascript" src="<%=staticPath%>/script/articleShowDialog.js"></script>
                                <% }%>
                                <script type="text/javascript" src="<%=staticPath%>/script/walogger.js"></script>	
                            </div>	
                        </div>
                        <div id="navMenu">
                            <jsp:include page="/jsp/common/com_subnav.jsp"></jsp:include>
                        </div>
                        <div id="loadform"></div>
                        <iframe src="javascript:false" id="frameNavElement" ></iframe>
                        <div id="heightTest"></div>
                    </body>
                    </html>
