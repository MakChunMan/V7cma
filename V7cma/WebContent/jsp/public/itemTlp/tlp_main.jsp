<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.net.URLEncoder" %><% response.addHeader("P3P", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");%>
<%@include file="/init.jsp" %><%
//    if (V6Util.isSSLOn() & !request.isSecure()) {
	
	
//        out.println("<script>self.location='https://" + request.getServerName() + contextPath + "/main.do';</script>");
//    } else {
        Member thisShop = (Member) request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
        String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
                + thisShop.getSys_guid() + "/";
        String prodDetailPath = contextPath + "/" + thisShop.getMem_shopurl() + "/.do?v=";
        FacebookUtil fb = new FacebookUtil();
        fb.setShareTitle(URLEncoder.encode(thisShop.getMem_shopname() + " @ " + MessageUtil.getV6Message(lang, "TIT_CORP"), "UTF-8"));
        fb.setShareThumbnail("http://" + request.getServerName() + "/favicon.ico?v=2");
        fb.setUrl("http://www.facebook.com/sharer.php?u="
                + URLEncoder.encode(((StringBuffer) request.getAttribute("fullRequestURL")).toString(), "UTF-8") + "&t="
                + URLEncoder.encode(MessageUtil.getV6Message(lang, "BUT_FB_SHARE_SHOP") + " " + thisShop.getMem_shopname(), "UTF-8"));
        request.setAttribute("fbButton1", fb);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" dir="ltr" lang="zh-TW">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="shortcut icon" href="/favicon.ico?v=2" type="image/vnd.microsoft.icon" />
        <meta name="robots" content="all, index, follow" />
        <meta name="distribution" content="global" />
    <meta name="google-site-verification" content="bmj0H8uCBK1qAXsDK2_vZJUFxA0xywK5-1ZTGUSOieI" />
        <meta http-equiv="P3P" content='CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"'/>
        <meta content="<%=MessageUtil.getV6Message(lang, "MAIN_KEYWORD")%>" name="Keywords"/>
        <meta content="<%=MessageUtil.getV6Message(lang, "MAIN_DESCRIPTION")%>" name="Description"/>
        <title><%=MessageUtil.getV6Message(lang, "MAIN_TITLE")%> @ <%=MessageUtil.getV6Message(lang, "TIT_CORP")%></title>
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
            //sb_setting.delayOpen=1000;        // in ms, -1 for no delay
            sb_setting.delayOpen=-1;
            sb_setting.maxheight=-1;            // set to -1 for autosize

            //initialize auto complete
            //var ACManager = new autoComplete();
            var config=[{id:"txt_search", hasScroll:false, maxRow:10} ];

            function pagaInit() {
                drawmenu("ctnSidebar", sb_setting);
                //  ACManager.setFields(config);
            }
            //]]>

            //--><!]]>
        </script>
        <style id="styles" type="text/css">
            //.dp25{width:25%; float:left; *margin-right:-1px; height:200px}
            .dp25{width:22%; float:left; margin:5px; padding:0px 7px; *margin-right:-1px; height:280px; border: solid 1px;border-color:#dddddd}
            .dp50{width:50%; float:left; *margin-right:-1px;}
        </style>
        <script type="text/javascript">
            //<![CDATA[

            // Uncomment the following code to test the "Timeout Loading Method".
            // CKEDITOR.loadFullCoreTimeout = 5;

            window.onload = function()
            {
                pagaInit();

            };
        </script>
    </head>
    <body>
        <div id="main_container">
            <div id="header">
                <div class="logo_bar">
                    <h1 class="AE_logo"><a href="/main/.do"><span></span><img src="<%=staticPath%>/images/aelogo.jpg" alt=""/></a></h1>
                    <jsp:include page="/jsp/common/com_langbar.jsp"></jsp:include>
                    </div>
                    <div id="main_nav">
                        <ul class="menu">
                        <jsp:include page="/jsp/common/com_topnav.jsp"></jsp:include>
                        </ul>
                        <div class="search">
                            <form action="/do/SEARCH" method="post">
                                <input  type="hidden" name="source" value="h"/>
                                <input  id="txt_search" name="keyw" type="text" accesskey="h" tabindex="1" value="<%=MessageUtil.getV6Message(lang, "BUT_SEARCH")%>" maxlength="50" onfocus="fn_focusSearch(this);" onblur="fn_blurSearh(this);"  class="txt_search_off" />
                            <input  type="submit" name="btn_go" id="btn_go" value="<%=MessageUtil.getV6Message(lang, "BUT_GO")%>" class="btnGeneric" />
                        </form>
                    </div>
                </div>
                <div class="banner_row">
                    <% if (!V6Util.isMainsite(request)) {%>
                    <jsp:include page="/jsp/common/com_banner.jsp"></jsp:include>
                    <% } else {%>
                    <div id="hdrBanner" style="width:699px">
                        <table width="100%" style="padding: 0px">
                            <tr><td align="center">
                                    <form action="/do/SEARCH" method="post">
                                        <input type="hidden" name="source" value="h"/>
                                        <div><input type="text" name="keyw" class="searchBox"/>
                                            <input type="submit" value="<%=MessageUtil.getV6Message(lang, "BUT_SEARCH")%>" class="btnMainSearch" />
                                        </div>
                                        <%-- !!! Disable Keyword !!!
<div id="hotkeyword" style="position:relative;">                    
        ArrayList<String> keywords = V6Util.genHotKeySearch(lang);
        if(keywords.size()>0) out.println(MessageUtil.getV6Message(lang,"COMMON_KEYWORD_LABEL")+":&nbsp;");
        Iterator<String> it = keywords.iterator();
        while(it.hasNext()){
                String tmp = (String)it.next();
                out.println("&nbsp;"+ tmp+"&nbsp;");
        }
</div>
                                        --%>
                                    </form>
                                </td></tr>
                            <tr><td>
                                    <div style="clear:both;position:relative;top:3px"><img src="<%=staticPath%><%=MessageUtil.getV6Message(lang, "HOME_BANNER")%>"/></div>
                                    <!--  Hot Article region --><%--
                                    <jsp:include page="/jsp/inc_mainhotarticle.jsp"></jsp:include>--%>
                                    <!--  End of Hot Article region --></td>    
                            </tr>
                        </table>
                    </div>
                    <% }%>
                    <div class="login_form" <%=V6Util.isLogined(request) ? "id=\"logined_form\"" : ""%>>
                        <% if (!V6Util.isFBSessionExist(request)) {%>
                        <jsp:include page="/jsp/common/com_login.jsp"></jsp:include>
                        <% } else {%>
                        <jsp:include page="/jsp/common/com_fb_login_profile.jsp"></jsp:include>
                        <% }%>
                    </div>
                </div>
            </div>
            <div id="header_cover"></div>
            <div id="content">
                <div id="ctnMain">
                    <% if (request.getAttribute("HP_ARTI") != null) {
                            Article hpArti = (Article) request.getAttribute("HP_ARTI");
                    %>
                    <div id="mod_1" class="mod">
                        <div class="hd2">
                            <h2><%=hpArti.getArti_name()%></h2>
                        </div>
                        <div class="bd" id="hparti-region">
                            <%=hpArti.getArti_content()%>
                            <% if (request.getAttribute(SystemConstants.PUB_HOME_NEWSHOP) != null && V6Util.isNewshopListOn()) {%>
                            <br/>
                            <%
                                Member[] newShopList = (Member[]) request.getAttribute(SystemConstants.PUB_HOME_NEWSHOP);
                                boolean rowstarted = false;
                                if (newShopList == null || newShopList.length > 0) {%>
                            <hr style="color:#aaaaaa; width:70%"/>
                            <br/>
                            <strong><%=MessageUtil.getV6Message(lang, "TIT_NEWSHOP")%></strong>
                            <br/>
                            <br/>
                            <%
                                }
                                for (int x = 0; x < newShopList.length; x++) {
                                    if (x == 0) {
                                        out.println("<div id='mod_1_a'>");
                                        rowstarted = true;
                                    }
                                    String newShopImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
                                            + newShopList[x].getSys_guid() + "/";
                            %>
                            <div class="dp50">
                                <img src="<%=newShopImagePath + "thm_" + newShopList[x].getMem_shopbanner()%>" alt="<%=newShopList[x].getMem_shopname()%>" height="50px"/>
                                <a href="/<%=newShopList[x].getMem_shopurl()%>.do"><%=newShopList[x].getMem_shopname()%></a>
                            </div>
                            <%
                                        if (x == newShopList.length - 1) {
                                            out.println("</div>");
                                            rowstarted = false;
                                        }
                                    }
                                    out.println("<script>$('#mod_1_a').height(" + newShopList.length + "/2 *150);</script>");
                                }%>
                        </div>
                        <div class="shadow690px"></div>
                    </div>
                    <%}%>
                </div>
                <div id="ctnSidebar">
                    <jsp:include page="/jsp/common/com_slidesection.jsp"></jsp:include>
                </div>
                <%--
                <div id="ctnMainFull">
                    <div id="more-deals-container" class="yui3-g">
                        <!-- (begin) more offers -->
                        <div id="more-deals" class="yui3-u-1">
                            <div class="bd"><jsp:include page="/mainbo.jsp"></jsp:include>        </div>
                                <div class="ft">
                                    <div class="ajax-loader"></div>
                                </div>

                            </div>
                        </div>
                                <script>
                                    $('.bd > a').attr("target","_blank");
                                    $('.bd > .title > a').attr("target","_blank");
                                </script>
                    </div>
                --%>
                <%
                    ArrayList<BulkOrderItem> bo = (ArrayList<BulkOrderItem>) request.getAttribute(SystemConstants.PUB_HOME_BO);
                    if (bo != null && bo.size() > 0) {
                %>

                <div id="ctnMainFull">
                    <div id="more-deals-container" class="yui3-g">
                        <!-- (begin) more offers -->
                        <div id="more-deals" class="yui3-u-1">
                            <div class="bd">
                                <!--REPEAT-->
                                <%
	                                String regenkey = "";
	                                if(!"www.buybuymeat.net".equalsIgnoreCase(request.getServerName()))
	                                    regenkey = "&regen=Y";	                                    
                                    BulkOrderItem tmpProd = null;
                                    boolean rowstarted = false;
                                    Iterator<BulkOrderItem> it = bo.iterator();
                                        int x = 0;
                                        while (it.hasNext()) {
                                            tmpProd = (BulkOrderItem) it.next();%>
                                <div class="deal-module">
                                    <%--div class="hd">
                                        <span class="location"><!-- 上環 --></span>
                                        <div class="notice "></div>
                                    </div> --%>
                                    <div class="bd">
                                        <div class="discount"><span class="value"><%=new Double((tmpProd.getBoiSellPrice() - tmpProd.getBoiPrice1()) / tmpProd.getBoiSellPrice()  * 100).intValue()%>%</span></div>
                                        <a  href="<%=prodDetailPath + tmpProd.getSellitem().getSys_guid()%>&boid=<%=tmpProd.getId()+regenkey%>" title="<%=tmpProd.getSellitem().getProd_name()%>"><img src="<%=userImagePath + "dtl_" + tmpProd.getSellitem().getProd_image1()%>" alt="<%=tmpProd.getSellitem().getProd_name()%>"></a>
                                        <div class="title"><a href="<%=prodDetailPath + tmpProd.getSellitem().getSys_guid()%>&boid=<%=tmpProd.getId()+regenkey%>" title="<%=tmpProd.getSellitem().getProd_name()%>"><%=tmpProd.getSellitem().getProd_name()%> - 只限<%=tmpProd.getBoiPrice1Stock()%>件</a></div>
                                    </div>
                                    <div class="ft">
                                        <div class="yui3-g">
                                            <div class="partner yui3-u-1-2">由 BuyBuyMeat 提供</div>
                                            <%--div class="sold-count yui3-u-1-2"></div> --%>
                                        </div>
                                        <div class="price-info">
                                            <span class="orig-price">$<%=CommonUtil.numericFormatWithComma(tmpProd.getBoiSellPrice())%>.0</span>
                                            <span class="selling-price">$<%=CommonUtil.numericFormatWithComma(tmpProd.getBoiPrice1())%>.0</span>
                                            <button class="detail-btn" onclick=" window.location='<%=prodDetailPath + tmpProd.getSellitem().getSys_guid()%>&boid=<%=tmpProd.getId()%>'">詳情</button>
                                        </div>
                                    </div>
                                </div>
                                <%--script>
                                    $('.bd > a').attr("target","_blank");
                                    $('.bd > .title > a').attr("target","_blank");
                                </script>--%>

                                <% }%>        
                                <!-- End of REPEAT-->                                

                            </div>
                        </div>
                    </div>
                </div>
                <% }%>
            </div>
            <div id="footer">
                <div id="fb-root"></div>
                <% if (V6Util.isSSLOn() && request.isSecure() && V6Util.isBulkOrderModuleOn()) {%>
                <script>
                    window.fbAsyncInit = function() {
                        FB.init({ 
                        	appId   : '<%=FacebookUtil.getAppId()%>',
                        	channelUrl : '//www.buybuymeat.net/files/channel.html',
                        	status : true, 
                        	cookie: true, xfbml: true });
                        FB.getLoginStatus(function(response) {
                            if (response.status=="connected") {
                            	<%--
                            	var uid = response.authResponse.userID;
                            	var accessToken = response.authResponse.accessToken;
                            	var graphapi_url = "https://graph.facebook.com/"+uid+"/likes/351567678214145?access_token="+accessToken;
                            	$.ajax({  
                                    url: graphapi_url,   
                                    type: "GET",  
                                    cache: false,  
                                    success: function (html) {
                                    	if(html.error){
                                    		alert("Error Code:"+html.error.code+" - "+html.error.message);
                                    	}
                                    	alert(html.toString());
                                    }         
                                });--%>
                                FB.api({ method: 'pages.isFan', page_id: '351567678214145', uid: response.authResponse.userID }, 
                                function(resp) {     
                                    if (resp == true) {
                                    	<%-- Like already here--%>
                                        $('.bo_fb_hidden').show();
                                        $('.bo_fb_hidden_replace').hide();
                                        //alert('user_id likes the Application.');     
                                    } else if(resp.error_code) {       
                                        //alert(resp.error_msg);      
                                    } else {       
                                    	<%-- Not Like here--%>
                                        //alert("user_id doesn't like the Application.");     
                                    } 
                                }); 
                            } else {
                            	<%-- Not yet login facebook --%>
                                //alert('Who are you?');      
                            }
                        }); 
                        FB.Event.subscribe('edge.create', function(response) {
                            $('.bo_fb_hidden').show();
                            $('.bo_fb_hidden_replace').hide();
                            //alert(response);
                        });
                    };
                 // Load the SDK asynchronously
                    (function(d, s, id){
                       var js, fjs = d.getElementsByTagName(s)[0];
                       if (d.getElementById(id)) {return;}
                       js = d.createElement(s); js.id = id;
                       js.src = "//connect.facebook.net/en_US/all.js";
                       fjs.parentNode.insertBefore(js, fjs);
                     }(document, 'script', 'facebook-jssdk'));
                </script>
                <% }%>
                <jsp:include page="/jsp/common/com_footer.jsp"></jsp:include>
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
<% //}%>
