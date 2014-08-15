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
<title><%=MessageUtil.getV6Message(lang,"TIT_BALANCE") %> @ <%=MessageUtil.getV6Message(lang,"TIT_CORP") %></title>
<link href="<%=staticPath %>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=staticPath %>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
<link href="<%=staticPath %>/css/flick/jquery-ui-1.8.custom.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=staticPath %>/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=staticPath %>/js/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="<%=staticPath %>/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<%=staticPath %>/ckfinder/ckfinder.js"></script>
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
			<div id="mod_txn" class="mod">
				<div class="hd2">
					<h2><%=MessageUtil.getV6Message(lang,"TIT_TXN_SHARE") %></h2>
				</div>
				<div class="bd" id="txn-share-region">
					<p><%=MessageUtil.getV6Message(lang,"TXN_SHARE_MSG") %><p/>
					<br/>
					<table class="tbl_form">
					<col align="left" />
					<col align="left" />
					<col align="left" width="120px"/>					
					<col align="centre" width="100px" />
					<thead>
					<tr>
						<th><%=MessageUtil.getV6Message(lang,"TXN_SHARE_CODE") %></th>
						<th><%=MessageUtil.getV6Message(lang,"TXN_SHARE_URL") %></th>
						<th><%=MessageUtil.getV6Message(lang,"TXN_SHARE_EXP_DATE") %></th>
						<th><%=MessageUtil.getV6Message(lang,"TXN_SHARE_DEC_RATE") %></th>
					</tr>
					</thead>
					<%
					List os = (List)request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
					if(os!=null){
						Iterator it = os.iterator();
						/***
						while(it.hasNext()){
							BoboSellItem p = (BoboSellItem)it.next();
							out.println("<tr><td>"+ p.getBobo_code() +"</td><td style=\"font-size:80%\">"+ 
									"<a href=\"http://"+ PropertiesConstants.get(PropertiesConstants.externalHost) + 
									"/do/PUBLIC?action=REWARDS&CODE="+ p.getBobo_code()+"\">"+
									"http://"+ PropertiesConstants.get(PropertiesConstants.externalHost) + 
										"/do/PUBLIC?action=REWARDS&CODE="+ p.getBobo_code()				
							
							);
							out.println("</a></td><td>"+ CommonUtil.formatDate(p.getBobo_exp_date(),"dd-MM-yyyy") + "</td>\n");
							out.println("<td>"+ p.getBobo_decline_rate()*100 + "%</td></tr>\n");
						}***/
					}
					%>
					</table>
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
</div></div>
<iframe src="javascript:false" id="frameNavElement" ></iframe>
<div id="heightTest"></div>
</body>
</html>
