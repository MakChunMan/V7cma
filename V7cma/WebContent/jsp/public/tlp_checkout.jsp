<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="com.imagsky.v6.domain.OrderSet" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@include file="/init.jsp" %>
<% boolean isBO = CommonUtil.null2Empty(request.getParameter("type")).equalsIgnoreCase("BO"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="/favicon.ico" />
<meta name="robots" content="noindex,nofollow" /> 
<meta http-equiv="Pragma" content="no-cache" />   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0" />  
<meta name="distribution" content="global" />
<meta content="" name="Keywords"/>
<meta content="" name="Description"/>
<title><%=MessageUtil.getV6Message(lang,"TIT_CHECKOUT") %> @ <%=MessageUtil.getV6Message(lang,"TIT_CORP") %></title>
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
	<jsp:include page="/jsp/common/com_header.jsp"></jsp:include>
	<div id="content">
		<div id="ctnMain<%=isBO?"Full":"" %>">
			<div id="mod_checkout" class="mod">
				<div class="hd2">
					<h2><%=MessageUtil.getV6Message(lang,"TIT_CHECKOUT") %></h2>
				</div>
				<div class="bd" id="checkout-region">
					<% if(!isBO){ %>
					<jsp:include page="/jsp/inc_checkout.jsp"></jsp:include>
					<% } else if(request.getParameter("type").equalsIgnoreCase("BO") && "paypal".equalsIgnoreCase(request.getParameter("step"))){ %>
					<jsp:include page="/jsp/inc_paypal.jsp"></jsp:include>
					<% } else if(request.getParameter("type").equalsIgnoreCase("BO")){ %>
					<jsp:include page="/jsp/inc_checkoutBO.jsp"></jsp:include>
					<% } else {
						cmaLogger.error("[CHECKOUT] Unknown checkout type: "+ request.getParameter("type"), request);
						out.println("<script>self.location='/';</script>");
					} %>
				</div>
				<% if(isBO){ %>
				<div class="shadow940px"></div>
				<% } else { %>
				<div class="shadow690px"></div>
				<% } %>
			</div>
			
		</div>
		<% if(!isBO){ %>
		<div id="ctnSidebar">
			<jsp:include page="/jsp/common/com_slidesection.jsp"></jsp:include>
		</div>
		<%} %>
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
