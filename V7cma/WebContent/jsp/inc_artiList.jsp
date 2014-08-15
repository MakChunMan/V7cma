<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.domain.Member" %>
<%@ page import="com.imagsky.v6.domain.Article" %>
<%@ page import="java.util.*" %>
<% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG); %>
<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))){ %>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
<%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
<script>
$(function() {
	$.ajax({  
            url: "<%=request.getAttribute("contextPath") %>/do/REFRESH?action=TOPNAV&c="+new Date().getTime(),   
            type: "POST",  
            cache: false,  
            success: function (html) {                
               //if process.php returned 1/true (send mail success)
           	 $('#top_nav_aj').html(html);
	         $.ajax({  
	    	        url: "<%=request.getAttribute("contextPath") %>/do/REFRESH?action=SUBNAV&c="+new Date().getTime(),   
	    	        type: "POST",  
	    	        cache: false,  
	    	        success: function (html) {                
	    	           //if process.php returned 1/true (send mail success)
	    	       	 $('#navMenu').html(html);
		    	     $.ajax({  
		    	             url: "<%=request.getAttribute("contextPath") %>/do/REFRESH?action=HIL&c="+new Date().getTime(),   
		    	             type: "POST",  
		    	             cache: false,  
		    	             success: function (html) {                
		    	             //if process.php returned 1/true (send mail success)
		    	            	 $('#ctnSidebar').html(html);
		    	             }         
		    		 });
	    	        }         
	         });
            }         
  	     });
});
</script>
</div>
</div>
<br/>
<%} %>
<div class="ui-widget"><div id="formerr">
<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
</div>			
<% if(request.getAttribute("JETSO_POPUP")!=null){
	out.println(request.getAttribute("JETSO_POPUP"));
}%>
<% 
Member loginMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
if(V6Util.isMainsiteLogin(loginMember)){ %>
<form id="arti_search_form">
<input type="hidden" name="action" value="LISTAJ"/>
<SELECT name="arti_type_search" id="arti_type_search">
<option value="">--</option>
<option value="J">Jetso</option>
<option value="S">Sharing</option>
</SELECT><input id=arti_search_submit type=button value="<%=MessageUtil.getV6Message(lang,"BTN_FIND") %>"/>
</form>
<br/>
<script>
	<% 
	if(!CommonUtil.isNullOrEmpty(request.getParameter("arti_type_search"))){
		out.println("$('#arti_type_search').val('"+request.getParameter("arti_type_search")+"');");	
	}
	%>
$(function() {	
	$('#arti_search_submit')
			.button()
			.click(function() {
				//AJAX form submit
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/ARTI?c="+new Date().getTime(),   
		             type: "POST",  
		             cache: false,  
		             data: $('#arti_search_form').serialize(),
		             success: function (html) {                
		            	 $('#arti-region').html(html);
		             }         
	    	     });  
				return false;
			});
});
</script>	
<% } %>
<div class="catlist">
<ul id="sortable">
	<% 
	List objList = (List)request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
	if(objList!=null){
		Iterator it = objList.iterator();
		Article tmpObj = null;
		while(it.hasNext()){
			tmpObj =(Article)it.next();
			if(!CommonUtil.isNullOrEmpty(request.getParameter("arti_type_search")) ||
					CommonUtil.isNullOrEmpty(tmpObj.getArti_type())){%>
		<li id="<%=tmpObj.getSys_guid() %>" class="ui-state-default">
				<span class="ui-icon ui-icon-arrowthick-2-n-s"></span>
				<span class="ui-icon ui-icon-pencil" title="<%=MessageUtil.getV6Message(lang,"BUT_EDIT") %>" name="<%=tmpObj.getSys_guid() %>"></span>
				<span class="ui-icon ui-icon-closethick" title="<%=MessageUtil.getV6Message(lang,"BUT_DEL") %>" name="<%=tmpObj.getSys_guid() %>" artiname="<%=tmpObj.getArti_name() %>"></span>
				<a href="#" alt="<%=MessageUtil.getV6Message(lang,"BUT_EDIT") %>" class="a_pencil ui-icon-pencil" name="<%=tmpObj.getSys_guid() %>" artiname="<%=tmpObj.getArti_name() %>">
				<span><%=MessageUtil.getV6Message(lang,"BUT_EDIT") %></span></a>		
				<a href="#" alt="<%=MessageUtil.getV6Message(lang,"BUT_DEL") %>" class="a_closethick ui-icon-closethick" name="<%=tmpObj.getSys_guid() %>" artiname="<%=tmpObj.getArti_name() %>">
				<span><%=MessageUtil.getV6Message(lang,"BUT_DEL") %></span></a>			
				<%=tmpObj.getArti_name() %>
		</li>		
		<%}
		}
	}
	%>
</ul>
</div>
<style type="text/css">
	#sortable { list-style-type: none; margin: 0; padding: 0; width: 600px; }
	#sortable li { margin: 0 2px 2px 2px; padding: 0.4em; padding-left: 1.5em; font-size:1.2em;}
	#sortable li span.ui-icon-arrowthick-2-n-s	{ position: absolute; margin-left: -1.3em; }
	#sortable li span.ui-icon-closethick		{ position: absolute; margin-left: 500px;}
	#sortable li span.ui-icon-pencil		{ position: absolute; margin-left: 450px;}
	#sortable li a{ font-size:0.8em;text-color:#AAAAAA;}	
	#sortable li a:hover{ text-color:#555555; text-decoration: underline;}
	#sortable li a.a_pencil{ position: absolute; margin-left: 465px;}	
	#sortable li a.a_closethick{ position: absolute; margin-left: 520px;}	
</style>
<script type="text/javascript">
$(function() {
	$("#sortable").sortable();
	$("#sortable").disableSelection();
});
$(function() {
	$('#add-arti')
			.button()
			.click(function() {
				//AJAX form submit
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/ARTI?action=ADDAJ&c="+new Date().getTime(),   
		             type: "POST",  
		             cache: false,  
		             success: function (html) {                
	                 //if process.php returned 1/true (send mail success)
		            	 $('#arti-region').html(html);
		             }         
	    	     });  
				return false;
			});
	$('#saveorder-arti')
	.button()
	.click(function() {
		//AJAX form submit
		$.ajax({  
             url: "<%=request.getAttribute("contextPath") %>/do/ARTI?action=SAVE_ORDER&c="+new Date().getTime(),   
             type: "POST",  
             data: "guids="+$("#sortable").sortable("toArray"),
             cache: false,  
             success: function (html) {                
             //if process.php returned 1/true (send mail success)
            	 $('#arti-region').html(html);
             }         
	     });  
		return false;
	});	
	
	$(".ui-icon-closethick")
	.bind("click", function(){
		if (confirm("<%=MessageUtil.getV6Message(lang,"BUT_DEL_CONFIRM_MSG")%> \""+ $(this).attr("artiname")+"\"?")){
			$.ajax({  
	            url: "<%=request.getAttribute("contextPath") %>/do/ARTI?action=DELAJ&c="+new Date().getTime(),   
	            type: "POST",  
	            data: "guid="+$(this).attr("name"),
	            cache: false,  
	            success: function (html) {                
	            //if process.php returned 1/true (send mail success)
	           	 $('#arti-region').html(html);
	            }         
		     });  
		}
		return false;
	});
	
	$('.ui-icon-pencil')
	.bind("click", function(){
		$.ajax({  
            url: "<%=request.getAttribute("contextPath") %>/do/ARTI?action=EDITAJ&c="+new Date().getTime(),   
            type: "POST",  
            data: "guid="+$(this).attr("name"),
            cache: false,  
            success: function (html) {                
	           	 $('#arti-region').html(html);
            }         
	     });
	});
			
});
</script>
<button id="add-arti"><%=MessageUtil.getV6Message(lang,"BUT_ADD")%></button>
<button id="saveorder-arti"><%=MessageUtil.getV6Message(lang,"BUT_SAVE_ORDER") %></button>
