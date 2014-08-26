<%--
2014-09-02 Add GoDaddy Site seal
 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%><%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>    
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.utility.Base64" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String lang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
    Iterator it;
    boolean isPublicView = false;
    boolean hasSlidingSection = false;
    String filepage = null;
    Member thisMember = null;
    Member thisShop = null;
    ImagskySession thisSession = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION));
    thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    String thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
    String categoryListCacheURL = null;


//SHOPPING CART
    TreeMap shoppingCart = (TreeMap) request.getSession().getAttribute(SystemConstants.PUB_CART);
    OrderSet orderSet = null;

//MY BULK ORDER
    OrderSet myBulkOrder = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
//0000
    if (CommonUtil.null2Empty(request.getAttribute(SystemConstants.PUB_FLG)).equalsIgnoreCase("Y")) {
        thisShop = (Member) request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
        isPublicView = true;
        categoryListCacheURL = CommonUtil.getHttpProtocal(request) + PropertiesConstants.get(PropertiesConstants.externalHost)
                + PropertiesConstants.get(PropertiesConstants.uploadContextRoot)
                + SystemConstants.PATH_COMMON_JSP_SLIDING_CAT + thisShop.getSys_guid() + "_" + thisLang + ".jsp";
        //orderSet = (OrderSet)request.getSession().getAttribute(SystemConstants.PUB_CART);
    }%>
<%
//0001
    if (V6Util.isBoboModuleOn()) {
        String slideSectionFile = CommonUtil.getHttpProtocal(request) + PropertiesConstants.get(PropertiesConstants.externalHost)
                + PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/" + SystemConstants.PATH_COMMON_JSP_CACHE + "boSlideSection_" + thisLang + ".jsp";
        try {
%>
<c:import url="<%=slideSectionFile%>" />
<%
            hasSlidingSection = true;
        } catch (Exception e) {
            cmaLogger.error("NOT FOUND", e);
        }
    }
//0002	
    if (myBulkOrder != null && myBulkOrder.getOrderItems().size() > 0) {
        hasSlidingSection = true;%>
<div id="mod_cart" class="mod list_item">
    <div class="hd2">
        <h2><%=MessageUtil.getV6Message(thisLang, "TIT_MYBULKORDER")%></h2>
        <span></span> 
    </div>
    <div class="bd">
        <div class="ctn">
            <ul class="other_news">
                <%
                    it = myBulkOrder.getOrderItems().iterator();
                    OrderItem item;
                    String userImagePath = null;
                    int itemCount = 0;
                    while (it.hasNext()) {
                        item = (OrderItem) it.next();
                        userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
                                + item.getShop().getSys_guid() + "/thm_" + item.getProdImage();
                %>
                <li class="bulletLink"> 
                    <% if (!CommonUtil.isNullOrEmpty(item.getProdImage().trim())) {%>
                    <img src="<%=userImagePath%>" height="32"></img>
                    <%}%><%=item.getProdName()%> x <%=item.getQuantity()%>
                </li>
                <%
                        itemCount++;
                    }
                    if (itemCount > 0) {
                        out.println("<br/><br/>");
                        out.println("<li class=\"bulletLink\"><a href=\"" + request.getAttribute("contextPath") + "/do/PUBLIC?action=CHECKOUT&type=BO\">"
                                + MessageUtil.getV6Message(thisLang, "COUT_NOW") + "</a></li>");
                    }
                %>
            </ul>
        </div>
    </div>
</div>
<% }%>
<%-- 0003 Default Mainsite Product Category Index Hardcode-
<%
    SellItemCategory[] mainsiteCategory = MainSiteUtil.getOnLineCategory();
    if (mainsiteCategory != null && mainsiteCategory.length > 0) {%>
<% hasSlidingSection = true;%>
<div id="mod_maincat" class="mod list_item">
    <div class="hd2">
        <h2><%=MessageUtil.getV6Message(thisLang, "CAT_NAME")%></h2>
        <span></span> 
    </div>
    <div class="bd">
        <div class="ctn">
            <ul class="other_news">
                <% for (int x = 0; x < mainsiteCategory.length; x++) {
                        if ("A".equalsIgnoreCase(mainsiteCategory[x].getCate_type())) {%>
                <%= "<li class=\"bulletLink\"><a href=\"do/BID2?action=MAIN\">" + mainsiteCategory[x].getCate_name() + "</a></li>\n\r"%>                            
                <% } else {%>
                <%= "<li class=\"bulletLink\"><a href=\"/" + MainSiteUtil.getMainSiteObject(false).getMem_shopurl() + mainsiteCategory[x].getCate_url() + "\">" + mainsiteCategory[x].getCate_name() + "</a></li>\n\r"%>
                <% }%>
                <% }%>
            </ul>
        </div>
    </div>
</div>
<% }%>                                        
<%-- 0003 End of Default Mainsite Product Category Index Hardcode--%>
<% if (shoppingCart != null && shoppingCart.size() > 0) {
        hasSlidingSection = true;%>		
<div id="mod_cart" class="mod list_item">
    <div class="hd2">
        <h2><%=MessageUtil.getV6Message(thisLang, "TIT_CART")%></h2>
        <span></span> 
    </div>
    <div class="bd">
        <div class="ctn">
            <ul class="other_news">
                <%
                    Iterator itA = shoppingCart.descendingKeySet().iterator();
                    OrderItem item;
                    String userImagePath = null;
                    OrderSet tmp = null;
                    orderSet = new OrderSet();
                    int itemCount = 0;
                    while (itA.hasNext()) {
                        tmp = (OrderSet) shoppingCart.get((String) itA.next());
                        it = tmp.getOrderItems().iterator();
                        while (it.hasNext()) {
                            item = (OrderItem) it.next();
                            userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
                                    + item.getShop().getSys_guid() + "/thm_" + item.getProdImage();
                %>
                <li class="bulletLink"> 
                    <% if (!CommonUtil.isNullOrEmpty(item.getProdImage().trim())) {%>
                    <img src="<%=userImagePath%>" height="32"></img>
                    <%}%><%=item.getProdName()%> x <%=item.getQuantity()%>
                </li>
                <%}
                        itemCount++;
                    }
                    if (itemCount > 0) {
                        out.println("<br/><br/>");
                        out.println("<li class=\"bulletLink\"><a href=\"" + request.getAttribute("contextPath") + "/do/PUBLIC?action=CHECKOUT\">"
                                + MessageUtil.getV6Message(thisLang, "COUT_NOW") + "</a></li>");
                    }
                %>
            </ul>
        </div>
    </div>
</div>
<% }%>
<%-- 
//Category list if not MAINSITE
if(!V6Util.isMainsite(request)){ 
                String ajaxUrl = "";
                if(!isPublicView){
                        if(V6Util.isLogined(request)){
                            ajaxUrl = request.getAttribute("contextPath") +"/do/CAT?action=SLIDE_AJ&c=";
                            hasSlidingSection = true;
                        }
                } else if(!CommonUtil.isNullOrEmpty(categoryListCacheURL)){
                    ajaxUrl = categoryListCacheURL+"?c=";
                    hasSlidingSection = true;
                } 
                cmaLogger.debug("Ajax URL "+ajaxUrl);
                if(!CommonUtil.isNullOrEmpty(ajaxUrl)){
%>
<div id="mod_catlist" class="mod list_item">
        <div class="hd2">
                <h2><%=MessageUtil.getV6Message(thisLang,"CAT_NAME")%></h2>
                <span></span> 
        </div>
        <div class="bd">
                <div class="ctn">
                        <ul class="tool_list" id="mod_catlist_ul">
                        <script>
                                $(function() {
                                $.ajax({  
                             url: "<%=ajaxUrl%>"+new Date().getTime(),
                             type: "POST",  
                             cache: false,  
                             success: function (html) {                
                                 $('#mod_catlist_ul').html(html);
                             },
                             error: function (objRquest){
                                 $('#mod_catlist_ul').html("");
                             }         
                     });  
                        });
                        </script>
                        </ul>
                </div>
        </div>
</div>
        <%} %>
<% } --%>
<% if (thisShop != null || thisMember != null) {
        hasSlidingSection = true;%>
<div id="mod_srvdsk" class="mod list_item">
    <div class="hd2">
        <h2><%=MessageUtil.getV6Message(thisLang, "TIT_NEWS")%></h2>
        <span></span> </div>
    <div class="bd">
        <div class="ctn">
            <ul class="tool_list" id="mod_arti_highlight">
                <%
                    try {
                        if (isPublicView) {
                            filepage = CommonUtil.getHttpProtocal(request) + PropertiesConstants.get(PropertiesConstants.externalHost)
                                    + PropertiesConstants.get(PropertiesConstants.uploadContextRoot)
                                    + SystemConstants.PATH_COMMON_JSP_HIGHLIGHT + thisMember.getSys_guid() + "_" + thisLang + ".jsp";
                        } else if (thisMember != null && thisSession.isLogined()) {
                            filepage = CommonUtil.getHttpProtocal(request) + PropertiesConstants.get(PropertiesConstants.externalHost)
                                    + PropertiesConstants.get(PropertiesConstants.uploadContextRoot)
                                    + SystemConstants.PATH_COMMON_JSP_HIGHLIGHT + thisMember.getSys_guid() + "_" + thisLang + ".jsp";
                        }
                %>
                <c:import url="<%=filepage%>" />
                <% } catch (Exception e) {%>
                <%
                        out.println("<li>" + MessageUtil.getV6Message(thisLang, "COMMON_NO_NEWS") + "</li>\n");
                        cmaLogger.error("Highlight file (" + filepage + ") is missing", request);
                    }%>
            </ul>
        </div>
    </div>
</div>
<% }%>
<% if (thisMember != null && thisSession.isLogined()) {
        hasSlidingSection = true;%>
<div id="mod_shoptools" class="mod list_item">
    <div class="hd2">
            <h2><%=(!CommonUtil.isNullOrEmpty(thisMember.getMem_shopname()))
                    ? MessageUtil.getV6Message(thisLang, "TIT_MGMT_SHOP") + thisMember.getMem_shopname() : MessageUtil.getV6Message(thisLang, "TIT_MGMT_SHOP2")%></h2>
        <span></span> </div>
    <div class="bd">
        <div class="ctn">
            <ul class="tool_list" id="mod_tools_highlight">
                <% if (V6Util.isMainsiteLogin(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser())) {%>
                <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/CAT"><%=MessageUtil.getV6Message(lang, "TIT_CAT")%></a></li>
                <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/PROD"><%=MessageUtil.getV6Message(lang, "TIT_PROD")%></a></li>
                <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/ARTI"><%=MessageUtil.getV6Message(lang, "TIT_ARTICLE")%></a></li>
                <% }%>
                <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/ENQ"><%=MessageUtil.getV6Message(lang, "TIT_MSGMGMT")%></a></li>
                <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/TXN"><%=MessageUtil.getV6Message(lang, "TIT_ORDERRECORD")%></a></li>
                <%-- 20120420 Reopen when 網上充值 ready<li class="bulletLink"><a href="<%=request.getAttribute("contextPath") %>/do/TXN?action=CA_LIST"><%=MessageUtil.getV6Message(lang,"TIT_BALANCE") %></a></li>--%>
                <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/PROFILE?action=EDIT"><%=MessageUtil.getV6Message(lang, "TIT_PROFILE")%></a></li>
                <% if (ACLUtil.isValid(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser(), ACLUtil.BNR01)) {%>
                <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/BNR"><%=MessageUtil.getV6Message(lang, "TIT_BANNER")%></a></li>
                <% }%>
            </ul>
        </div>
    </div>
</div>			
<% }%>
<% if (hasSlidingSection) {%>
<div class="column_end"></div>
<% }%>
<%--
<script src="<%=CommonUtil.getHttpProtocal(request) %>connect.facebook.net/zh_HK/all.js#appId=262088817134906&amp;xfbml=1"></script>
<fb:like-box href="<%=CommonUtil.getHttpProtocal(request) %>www.facebook.com/#!/pages/BuyBuyMeatnet/174593745913460" width="240" height="120" show_faces="true" stream="false" header="true">
</fb:like-box>
--%>
<br/>
<br/>		
<script>
    drawmenu("ctnSidebar", sb_setting);
</script>
<% if(V6Util.isSSLOn()){%>
<span id="siteseal"><script type="text/javascript" src="https://seal.godaddy.com/getSeal?sealID=18yoP7Uie29kBQA00L8eSbSP0q3nPYjzUCvNWQoDq7makcK6Zsr7"></script></span>
<% } %>