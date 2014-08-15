<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.net.URLEncoder" %>    
<%@include file="/init.jsp" %>
<%
ArrayList param = new ArrayList();
param.add(request.getAttribute("searchresulttotalcount").toString());
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="/favicon.ico" />
<meta name="robots" content="all, index, follow" />
<meta name="distribution" content="global" />
<meta content="" name="Keywords"/>
<meta content="" name="Description"/>
<title><%=MessageUtil.getV6Message(lang,"TIT_SEARCH_MAIN") + "  \"" + CommonUtil.null2Empty(request.getParameter("keyw")) + "\""%> @ <%=MessageUtil.getV6Message(lang,"TIT_CORP") %></title>
<link href="<%=staticPath %>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=staticPath %>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
<link href="<%=staticPath %>/css/flick/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQCSS") %>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=staticPath %>/js/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQUERY") %>"></script>
<script type="text/javascript" src="<%=staticPath %>/js/<%=MessageUtil.getV6Message(lang,"SYS_JS_JQUERYUI") %>"></script>
<!--// script for pagination //-->
<script type="text/javascript" src="<%=staticPath %>/js/jquery.pagination.js"></script>
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
//--><!]]>
</script>
<style id="styles" type="text/css">
		.pagination {
					text-align: center;
		            font-size: 90%;
		        }
		        
		.pagination a {
		    text-decoration: none;
			border: solid 1px #AAE;
			color: #15B;
		}
		
		.pagination a, .pagination span {
		    display: block;
		    float: left;
		    padding: 0.3em 0.5em;
		    margin-right: 5px;
			margin-bottom: 5px;
		}
		
		.pagination .current {
		    background: #26B;
		    color: #fff;
			border: solid 1px #AAE;
		}
		
		.pagination .current.prev, .pagination .current.next{
			color:#999;
			border-color:#999;
			background:#fff;
		}

	</style>
<script type="text/javascript">
	//<![CDATA[
window.onload = function()
{
	pagaInit();
};
	//]]>

var totalCount = <%=request.getAttribute("searchresulttotalcount")%>;
var startRow = <%=request.getAttribute("startrow")%>;
var rowPerPage = <%=request.getAttribute("rowPerPage")%>;
var currentPage = <%=request.getAttribute("p")%>;

	
	</script>
</head>
<body>
<div id="main_container">
	<jsp:include page="/jsp/common/com_header.jsp"></jsp:include>
	<div id="content">
		<div id="ctnMain">
			<div id="mod_profile" class="mod">
				<div class="hd2">
					<h2><%=MessageUtil.getV6Message(lang,"TIT_SEARCH_MAIN")%></h2>
				</div>
				<div class="bd" id="profile-region">
					<div style="width:699px">
						<table width="100%" style="padding: 0px">
							<tr><td align="center">
							<form action="/do/SEARCH" method="post" id="searchform1" name="searchform1">
							<input type="hidden"  name="source" value="st"/>
							<div><input type="text" class="searchBox" name="keyw" id="keyw_main" value="<%=request.getParameter("keyw") %>"/></div>
							<input type="submit" value="<%=MessageUtil.getV6Message(lang,"BUT_SEARCH") %>"  class="btnMainSearch" />
							</form><br/>
							<div style="font-size:95%;color:#555;position:relative;top:-35px;left:-138px;"><%=MessageUtil.getV6Message(lang,"COMMON_SEARCH_MSG",param) %></div>
						</td></tr></table>							

					</div>
				<% if((Integer)request.getAttribute("searchresulttotalcount")>0){ %>
					<dl id="Searchresult" style="margin-left:8%;margin-right:8%;"></dl>
					<div style="width:699px">
						<table width="100%" style="padding: 0px">
						<tr><td align="center"><div id="Pagination" class="pagination"></div>
						<script>$('#Pagination').width((<%=request.getAttribute("searchresulttotalcount")%>/<%=PropertiesConstants.get(PropertiesConstants.searchRowPerPage)%>)*60 + 150);</script></td></tr>
						<tr><td align="center">
						<form action="/do/SEARCH" method="post">
						<input type="hidden" name="source" value="sb"/>
						<div><input type="text" name="keyw" class="searchBox" value="<%=request.getParameter("keyw") %>"/></div>
						<input type="submit" value="<%=MessageUtil.getV6Message(lang,"BUT_SEARCH") %>" class="btnMainSearch" />
						</form><br/>
						<div style="font-size:95%;color:#555;position:relative;top:-35px;left:-138px;"><%=MessageUtil.getV6Message(lang,"COMMON_SEARCH_MSG",param) %></div>
						</td></tr>
						</table>
					</div>
				<% } %>
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

 <script>
             /**
             * Callback function that displays the content.
             *
             * Gets called every time the user clicks on a pagination link.
             *
             * @param {int}page_index New Page index
             * @param {jQuery} jq the container with the pagination links as a jQuery object
             */
             //Jason Change here: Change members.length
			function pageselectCallback(page_index, jq){
                // Get number of elements per pagionation page from form
                var items_per_page = $('#items_per_page').val();
                var max_elem = Math.min((page_index+1) * items_per_page, totalCount);
                var newcontent = '';
                
                $.ajax({  
               	 url: "<%=contextPath %>/do/SEARCH?action=search_aj&keyw=<%=URLEncoder.encode ( request.getParameter("keyw"), "UTF-8" )%>&c="+new Date().getTime()+"&p="+(page_index+1),   
   	             type: "POST",  
   	             cache: false,  
   	             success: function (html) {    
   	            	 $('#Searchresult').html(html);
   	             }         
      	     	});
      	     	  
                // Prevent click eventpropagation
                return false;
            }

             // The form contains fields for many pagiantion optiosn so you can 
             // quickly see the resuluts of the different options.
             // This function creates an option object for the pagination function.
             // This will be be unnecessary in your application where you just set
             // the options once.
             function getOptionsFromForm(){
                 var opt = {callback: pageselectCallback};
                 // Collect options from the text fields - the fields are named like their option counterparts
                 // Jason Change here:
                 $("input:hidden").each(function(){
                     opt[this.name] = this.className.match(/numeric/) ? parseInt(this.value) : this.value;
                 });
                 // Avoid html injections in this demo
                 var htmlspecialchars ={ "&":"&amp;", "<":"&lt;", ">":"&gt;", '"':"&quot;"}
                 $.each(htmlspecialchars, function(k,v){
                     opt.prev_text = opt.prev_text.replace(k,v);
                     opt.next_text = opt.next_text.replace(k,v);
                 })
                 return opt;
             }

             
             // When document has loaded, initialize pagination and form 
             $(document).ready(function(){
 				// Create pagination element with options from form
                 var optInit = getOptionsFromForm();
                 $(".pagination").pagination(totalCount, optInit);
                
             });
              
 </script>
 <form name="paginationoptions">
			<p><input type="hidden" value="<%=PropertiesConstants.get(PropertiesConstants.searchRowPerPage) %>" name="items_per_page" id="items_per_page" class="numeric"/></p>
			<p><input type="hidden" value="1" name="num_display_entries" id="num_display_entries" class="numeric"/></p>
			<p><input type="hidden" value="2" name="num_edge_entries" id="num_edge_entries" class="numeric"/></p>
			<p><input type="hidden" value="<%=MessageUtil.getV6Message(lang,"BUT_PREV_PAGE") %>" name="prev_text" id="prev_text"/></p>
			<p><input type="hidden" value="<%=MessageUtil.getV6Message(lang,"BUT_NEXT_PAGE") %>" name="next_text" id="next_text"/></p>
</form>
<div id="navMenu">
<jsp:include page="/jsp/common/com_subnav.jsp"></jsp:include>
</div>
<div id="loadform"></div>
<iframe src="javascript:false" id="frameNavElement" ></iframe>
<div id="heightTest"></div>
</body>
</html>
