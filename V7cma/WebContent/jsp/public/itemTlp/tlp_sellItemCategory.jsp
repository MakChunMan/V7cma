<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@include file="/init.jsp" %>
<% 
SellItemCategory thisCat = (SellItemCategory)request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
List thisProdList = (List)request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
SellItem tmpProd = null;
Member thisShop = (Member)request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/"+
	thisShop.getSys_guid() +"/";
String prodDetailPath = request.getAttribute("contextPath")+"/"+thisShop.getMem_shopurl()+"/.do?v="; 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="/favicon.ico" />
<meta name="robots" content="all, index, follow" />
<meta name="distribution" content="global" />
<meta content="" name="Keywords"/>
<meta name="title" content="<%=thisCat.getCate_name()%> <% if(V6Util.isMainsite(request)){ %>@ <%=thisShop.getMem_shopname() %><%} %> | <%=MessageUtil.getV6Message(lang,"TIT_CORP") %>" />
<meta name="description" content="" />
<title><%=thisCat.getCate_name()%> <% if(V6Util.isMainsite(request)){ %>@ <%=thisShop.getMem_shopname() %><%} %> | <%=MessageUtil.getV6Message(lang,"TIT_CORP") %></title>
<link href="<%=staticPath %>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=staticPath %>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
<link href="<%=staticPath %>/css/flick/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQCSS") %>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=staticPath %>/js/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQUERY") %>"></script>
<script type="text/javascript" src="<%=staticPath %>/js/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQUERYUI") %>"></script>
<!--// script for Google Analystic -->
<script type="text/javascript" src="<%=staticPath %>/script/ga.js"></script>
<!--// script for sliding sidebar //-->
<script src="<%=staticPath %>/script/common_DOMControl.js" type="text/javascript"></script>
<script src="<%=staticPath %>/script/slidemenu.js" type="text/javascript"></script>
<!--// script for dropdown menu //-->
<script src="<%=staticPath %>/script/init.js" type="text/javascript"></script>
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
<style id="styles" type="text/css">
		#tabs li .ui-icon-close { float: left; margin: 0.4em 0.2em 0 0; cursor: pointer; }
		div.editable
		{
			border: solid 2px Transparent;
			padding-left: 15px;
			padding-right: 15px;
		}
		div.editable:hover
		{
			border-color: black;
		}
		.dp50{width:22%; float:left; margin:3px; padding:0px 4px; *margin-right:-1px; height:220px; border: solid 1px;border-color:#dddddd}
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
			<div id="mod_how_to_earn_miles" class="mod">
				<div class="hd2">
					<h2><%=thisShop.getMem_shopname()%> - <%=thisCat.getCate_name()%></h2>
				</div>
				<div class="bd" id="prolist-region">
                                                                        <% if("A".equalsIgnoreCase(thisCat.getCate_type())){%>
                                                                        <script>self.location="/do/BID2?action=MAIN";</script>
                                                                        <% } else if(thisProdList.size()> 0){ %>
					<br class="clearfloat;"/>
	                	<div class="shortcut_buttons"><a name="fb_share" type="button_count" href="<%=CommonUtil.getHttpProtocal(request) %>www.facebook.com/sharer.php?u=<%=URLEncoder.encode(((StringBuffer)request.getAttribute("fullRequestURL")).toString()) %>&t=<%=URLEncoder.encode(thisShop.getMem_shopname() + " - " + thisCat.getCate_name()) %>">
		                	<%=MessageUtil.getV6Message(lang,"BUT_FB_SHARE") %>   	</a>
						<script src="<%=CommonUtil.getHttpProtocal(request) %>static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
						</div>
					<br class="clearfloat;"/>
					<br/><br/>
		            <% }
					if(thisProdList.size()> 0){
						int itemPerRow = 4;
						double numOfRow = java.lang.Math.ceil(new Double(thisProdList.size())/itemPerRow);
						boolean rowstarted = false;
						for (int x = 0; x< thisProdList.size(); x++){
							if(x % itemPerRow ==0){
								out.println("<div>");
								rowstarted = true;
							}
							out.println("<div class=\"dp50\">");
							if(x < thisProdList.size()){
								tmpProd = (SellItem)thisProdList.get(x);%>
								<div style="text-align:center;display:block;">
								<img src="<%=userImagePath + "thm_"+tmpProd.getProd_image1()%>" alt="<%=tmpProd.getProd_name()%>"/>
								</div>
								<br/>
								<p style="padding-left: 5px;"><a href="<%=prodDetailPath+tmpProd.getSys_guid() %>"><strong><%=tmpProd.getProd_name() %></strong></a></p>
								<% if(tmpProd.getProd_price2()!=null && !tmpProd.getProd_price2().equals(new Double(0))){ %>
								<p style="padding-left: 5px;"><%=MessageUtil.getV6Message(lang,"PROD_PRICE") %>: <del>$<%=CommonUtil.numericFormatWithComma(tmpProd.getProd_price()) %></del></p>
					            <p style="padding-left: 5px;"><%=MessageUtil.getV6Message(lang,"PROD_SP_PRICE") %>: $<%=CommonUtil.numericFormatWithComma(tmpProd.getProd_price2()) %>
                                                            <%-- if(!CommonUtil.isNullOrEmpty(tmpProd.getProd_remarks())){ %><%=tmpProd.getProd_remarks()%><%} --%>
                                                    </p>
					            <% } else {%>
					            <p style="padding-left: 5px;"><%=MessageUtil.getV6Message(lang,"PROD_PRICE") %>: $<%=CommonUtil.numericFormatWithComma(tmpProd.getProd_price()) %></p>
					            <% } %>
							<%}		
							out.println("</div>");	
							
							if(x % itemPerRow == (itemPerRow-1)){
								out.println("</div>");
								rowstarted = false;
							}
						}
					 %>
				</div>
				<script>
					$('#prolist-region').height(100+<%=numOfRow%>*220);
				</script>
					<% } else { %>
					<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
					<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
					<%=MessageUtil.getV6Message(lang,"PROD_NO_FOUND")%>					
					</div></div>	
					<%} %>
				</div>	
				<div class="shadow940px"></div>
			</div>
		</div>
                                    <%--
		<div id="ctnSidebar">
			<jsp:include page="/jsp/common/com_slidesection.jsp"></jsp:include>
		</div>
                             --%>
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
