<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@include file="/init.jsp" %>
<%
//BulkOrder thisBO = (BulkOrder)request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
    ArrayList thisBO = (ArrayList) request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
    Member thisShop = (Member) request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
    String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
            + thisShop.getSys_guid() + "/";
    String prodDetailPath = contextPath + "/" + thisShop.getMem_shopurl() + "/.do?v=";
//Member thisShop = (Member)request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
//String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/"+
//	thisShop.getSys_guid() +"/";
//String prodDetailPath = request.getAttribute("contextPath")+"/"+thisShop.getMem_shopurl()+"/.do?v="; 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="shortcut icon" href="/favicon.ico" />
        <meta name="robots" content="all, index, follow" />
        <meta name="distribution" content="global" />
        <meta content="" name="Keywords"/>
        <meta name="title" content=" 今期團購 <% if (V6Util.isMainsite(request)) {%>@ <%=thisShop.getMem_shopname()%><%}%> | <%=MessageUtil.getV6Message(lang, "TIT_CORP")%>" />
        <meta name="description" content="" />
        <title>今期團購  <% if (V6Util.isMainsite(request)) {%>@ <%=thisShop.getMem_shopname()%><%}%> | <%=MessageUtil.getV6Message(lang, "TIT_CORP")%></title>
        <link href="<%=staticPath%>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="<%=staticPath%>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
        <link href="<%=staticPath%>/css/flick/jquery-ui-1.8.custom.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="<%=staticPath%>/js/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="<%=staticPath%>/js/jquery-ui-1.8.custom.min.js"></script>
        <!--// script for Google Analystic -->
        <script type="text/javascript" src="<%=staticPath%>/script/ga.js"></script>
        <!--// script for sliding sidebar //-->
        <script src="<%=staticPath%>/script/common_DOMControl.js" type="text/javascript"></script>
        <script src="<%=staticPath%>/script/slidemenu.js" type="text/javascript"></script>
        <!--// script for dropdown menu //-->
        <script src="<%=staticPath%>/script/init.js" type="text/javascript"></script>
        <style id="styles" type="text/css">
            //.dp25{width:25%; float:left; *margin-right:-1px; height:200px}
            .dp25{width:28%; float:left; margin:5px; padding:0px 7px; *margin-right:-1px; height:280px; border: solid 1px;border-color:#dddddd}
            .dp50{width:50%; float:left; *margin-right:-1px;}
        </style>
        <script type="text/javascript">
            <!--//--><![CDATA[//><!--

            //initialize slider
            sb_setting=new Object();
            sb_setting.opened_item=0;
            sb_setting.allowMultiopen=false;
            //sb_setting.delayOpen=1000;		// in ms, -1 for no delay
            sb_setting.delayOpen=-1;
            sb_setting.maxheight=-1;			// set to -1 for autosize

            var config=[{id:"txt_search", hasScroll:false, maxRow:10} ];

            function pagaInit() {
                drawmenu("ctnSidebar", sb_setting);
            }
            //]]>
            //--><!]]>
        </script>
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
                    <div id="ctnMain">
                        <div id="mod_how_to_earn_miles" class="mod">
                            <div class="hd2">
                                <h2>今期團購 - 逢星期一更新</h2>
                            </div>
                            <div class="bd" id="prolist-region">
                            <%
                                Collection<BulkOrderItem> newProds = thisBO;
                                BulkOrderItem tmpProd = null;
                                boolean rowstarted = false;
                                Iterator<BulkOrderItem> it = newProds.iterator();
                                int x = 0;
                                while (it.hasNext()) {
                                    if (x == 0) {
                                        out.println("<div id='bo-region-a'>");
                                        rowstarted = true;
                                    }
                                    out.println("<div class=\"dp25\">");
                                    tmpProd = (BulkOrderItem) it.next();%>
                            <div style="text-align:center;display:block;">
                                <img src="<%=userImagePath + "thm_" + tmpProd.getSellitem().getProd_image1()%>" alt="<%=tmpProd.getSellitem().getProd_name()%>"/>
                            </div>
                            <!-- span class="imgCont120 ico_new" /> -->
                            <br/>
                            <div style="height:38px;padding-left: 5px;">
                                <a href="<%=prodDetailPath + tmpProd.getSellitem().getSys_guid()%>&boid=<%=tmpProd.getId()%>"><strong><%=tmpProd.getSellitem().getProd_name()%></strong></a>
                            </div>
                            <p style="padding-left: 5px;color:#666666"><%=MessageUtil.getV6Message(lang, "BO_NORMAL_PRICE")%>: <span style="text-decoration: line-through">$<%=CommonUtil.numericFormatWithComma(tmpProd.getBoiSellPrice())%></span></p>
                            <div  style="padding-left: 5px;">
                                <div style="float:left;color:#333333"><%=MessageUtil.getV6Message(lang, "BO_PRICE")%>: 
                                    <% if (tmpProd.getBoiPrice1() != null) {%>
                                    $<%=CommonUtil.numericFormatWithComma(tmpProd.getBoiPrice1())%> (<%=CommonUtil.null2Empty(tmpProd.getBoiPrice1Description())%>)
                                    <% }%></div>
                            </div>	 
                            <%
                                    out.println("</div>");
                                    if (x == newProds.size() - 1) {
                                        out.println("</div>");
                                        rowstarted = false;
                                    }
                                    x++;
                                }
                                out.println("<script>$('#bo-region-a').height(" + Math.ceil(new Double(newProds.size()) / 3) + " *300);</script>");
                            %>
                        </div>	
                        <div class="shadow690px"></div>
                    </div>
                </div>
                <div id="ctnSidebar">
                    <jsp:include page="/jsp/common/com_slidesection.jsp"></jsp:include>
                    </div>
                </div>
                <div id="footer">
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
