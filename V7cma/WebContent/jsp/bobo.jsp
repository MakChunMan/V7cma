<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%--
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);

<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.common.SiteResponse" %>
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
<title><%=MessageUtil.getV6Message(lang,"TIT_BALANCE") %> @ <%=MessageUtil.getV6Message(lang,"TIT_CORP") %></title>
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
		<div id="ctnMain">
			<div class="ui-widget"><div id="formerr">
				<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
			</div>		
			<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))){ %>
			<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
			<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
			</div>
			</div>
			<%} %>
			<div id="mod_txn" class="mod">
				<div class="hd2">
					<h2><%=MessageUtil.getV6Message(lang,"TIT_BALANCE") %></h2>
				</div>
				<div class="bd" id="bobo-incoming-region">
					<% 
					SiteResponse sR = (SiteResponse) request.getAttribute(SystemConstants.REQ_ATTR_RESPOSNE);
					if(!sR.hasError()){
					BoboSellItem sb = (BoboSellItem)request.getSession().getAttribute("BOBO_OBJ");
					ArrayList<String> aList = new ArrayList<String>();
					Iterator it = sb.getOrderSet().getOrderItems().iterator();
					StringBuffer sbuffer = new StringBuffer();
					String url = null;
					Map<String,String> aMap = (HashMap)request.getAttribute("BOBO_MAP");												
					while(it.hasNext()){
						OrderItem itm = (OrderItem)it.next();
						String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/"+
						itm.getShop().getSys_guid() +"/thm_"+itm.getProdImage();
						url = "http://"+ PropertiesConstants.get(PropertiesConstants.externalHost) + "/main.do?v=" + itm.getContentGuid()+ "&boid=" + aMap.get(itm.getContentGuid());
						sbuffer.append("<tr><td><a href=\""+ url + "\"><img src=\""+userImagePath+"\"></a></td><td><a href=\""+url+"\">");
						sbuffer.append(itm.getProdName()+"</a></td></tr>\n");
					}
					aList.add(CommonUtil.formatDate(sb.getBobo_exp_date(),"dd-MM-yyyy"));
					aList.add(sbuffer.toString());
					aList.add(CommonUtil.numericFormatWithComma(new Double(MessageUtil.getV6Message(lang, "SYS_PARAM_BOBO_REF_DEC_RATE")) * 100));
					out.println(MessageUtil.getV6Message(lang, "BOBO_INCOMING_MSG",aList));
					}
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
<%-- This form is used for negative feedback only
</div></div>
<iframe src="javascript:false" id="frameNavElement" ></iframe>
<div id="heightTest"></div>
</body>
</html>
 --%>
