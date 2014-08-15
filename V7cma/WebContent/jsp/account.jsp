<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>  
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />   
<meta http-equiv="Cache-Control" content="no-cache"/>   
<meta http-equiv="Expires" content="0" />  
<meta content="NOINDEX, NOFOLLOW" name="ROBOTS" /> 
<meta content="" name="Keywords"/>
<meta content="" name="Description"/>
<title><%=MessageUtil.getV6Message(lang,"TIT_TXN") %> @ <%=MessageUtil.getV6Message(lang,"TIT_CORP") %></title>
<link href="<%=staticPath %>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=staticPath %>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
<link href="<%=staticPath %>/css/flick/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQCSS") %>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=staticPath %>/js/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQUERY") %>"></script>
<script type="text/javascript" src="<%=staticPath %>/js/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQUERYUI") %>"></script>
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
	<div id="content">
		<div id="ctnMainFull">
			<div id="mod_txn" class="mod">
				<div class="hd2">
					<h2><%=MessageUtil.getV6Message(lang,"TIT_TXN") %></h2>
				</div>
				<div class="bd" id="txn-region">
					<jsp:include page="/jsp/inc_transaction.jsp"/>
				</div>
				<div class="shadow940px"></div>
			</div>
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
<div id="fbform" style="display:none"><div id="feedback-form" title="<%=MessageUtil.getV6Message(lang,"TIT_FEEDBACK") %>">
<style type="text/css">
		#dialog-form fieldset { padding:0; border:0; margin-top:25px;font-size:80%; }
		#dialog-form h1 { font-size: 1.2em; margin: .6em 0; }
		div#users-contain { width: 350px; margin: 20px 0; }
		div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
		.validateTips { border: 1px solid transparent; padding: 0.3em; }
</style>
<%-- This form is used for negative feedback only --%>
<p><%=MessageUtil.getV6Message(lang,"TXT_FEEDBACK_MSG") %></p>
<form action="<%=request.getAttribute("contextPath") %>/do/TXN?action=FEED" method="post" id="feedbackform">
	<input type="hidden" name="osid" id="osid"/>
	<input type="hidden" name="v" value="-1"/>
	<fieldset>
		<textarea type="text" name="FB_REMARKS" id="FB_REMARKS" class="text ui-widget-content ui-corner-all" style="width:100%" rows="4"/></textarea>
	</fieldset>
</form>
</div></div>
<iframe src="javascript:false" id="frameNavElement" ></iframe>
<div id="heightTest"></div>
</body>
</html>
