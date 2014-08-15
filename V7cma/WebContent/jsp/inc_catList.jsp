<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.SellItemCategory" %>
<%@ page import="java.util.*" %>
<% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG); %>
<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))){ %>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
<%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
<script>
$(function() {
	$.ajax({  
            url: "<%=request.getAttribute("contextPath") %>/do/CAT?action=SLIDE_AJ&c="+new Date().getTime(),   
            type: "POST",  
            cache: false,  
            success: function (html) {                
               //if process.php returned 1/true (send mail success)
           	 $('#mod_catlist_ul').html(html);
            }         
  	     });
	$.ajax({  
	        url: "<%=request.getAttribute("contextPath") %>/do/CAT?action=NAV_AJ&c="+new Date().getTime(),   
	        type: "POST",  
	        cache: false,  
	        success: function (html) {                
	       	 $('#navShop_UL').html(html);
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
<div class="catlist">
<ul id="sortable">
	<% 
	List objList = (List)request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
	if(objList!=null){
		Iterator it = objList.iterator();
		SellItemCategory tmpObj = null;
		while(it.hasNext()){
			tmpObj =(SellItemCategory)it.next();%>
		<li id="<%=tmpObj.getSys_guid() %>" class="ui-state-default">
				<span class="ui-icon ui-icon-arrowthick-2-n-s"></span>
				<span class="ui-icon ui-icon-pencil" title="<%=MessageUtil.getV6Message(lang,"BUT_EDIT") %>" name="<%=tmpObj.getSys_guid() %>"></span>
				<span class="ui-icon ui-icon-copy" title="<%=MessageUtil.getV6Message(lang,"BUT_COPY") %>" name="<%=tmpObj.getSys_guid() %>"></span>
				<span class="ui-icon ui-icon-closethick" title="<%=MessageUtil.getV6Message(lang,"BUT_DEL") %>" name="<%=tmpObj.getSys_guid() %>" catname="<%=tmpObj.getCate_name() %>"></span>
				<a href="javascript:void(0);" alt="<%=MessageUtil.getV6Message(lang,"BUT_EDIT") %>" class="a_pencil ui-icon-pencil" name="<%=tmpObj.getSys_guid() %>" catname="<%=tmpObj.getCate_name() %>">
				<span><%=MessageUtil.getV6Message(lang,"BUT_EDIT") %></span></a>		
				<a href="javascript:void(0);" alt="<%=MessageUtil.getV6Message(lang,"BUT_COPY") %>" class="a_copy ui-icon-copy" name="<%=tmpObj.getSys_guid() %>" catname="<%=tmpObj.getCate_name() %>">
				<span><%=MessageUtil.getV6Message(lang,"BUT_COPY") %></span></a>				
				<a href="javascript:void(0);" alt="<%=MessageUtil.getV6Message(lang,"BUT_DEL") %>" class="a_closethick ui-icon-closethick" name="<%=tmpObj.getSys_guid() %>" catname="<%=tmpObj.getCate_name() %>">
				<span><%=MessageUtil.getV6Message(lang,"BUT_DEL") %></span></a>			
				<%=tmpObj.getCate_name() %> (<%=SellItemCategory.getCateTypeDescription(tmpObj.getCate_type(),lang) %>)
		</li>		
		<%}
	}
	%>
</ul>
	<% if(objList!=null && objList.size()==0){ %>
		<%=MessageUtil.getV6Message(lang,"CAT_NOT_FOUND")%><br/>
		<a href="<%=request.getAttribute("contextPath")+"/do/CAT?action=ADD"%>">
			<%=MessageUtil.getV6Message(lang,"CAT_ADD")%></a><br/><br/>
	<%} %>
</div>
<style type="text/css">
	#sortable { list-style-type: none; margin: 0; padding: 0; width: 600px; }
	#sortable li { margin: 0 2px 2px 2px; padding: 0.4em; padding-left: 1.5em; font-size:1.2em;}
	#sortable li span.ui-icon-arrowthick-2-n-s	{ position: absolute; margin-left: -1.3em; }
	#sortable li span.ui-icon-pencil		{ position: absolute; margin-left: 395px;}
	#sortable li span.ui-icon-copy		{ position: absolute; margin-left: 450px;}	
	#sortable li span.ui-icon-closethick		{ position: absolute; margin-left: 500px;}
	
	#sortable li a{ font-size:0.8em;text-color:#AAAAAA;}	
	#sortable li a:hover{ text-color:#555555; text-decoration: underline;}
	#sortable li a.a_pencil{ position: absolute; margin-left: 410px;}
	#sortable li a.a_copy{ position: absolute; margin-left: 465px;}	
	#sortable li a.a_closethick{ position: absolute; margin-left: 520px;}	
</style>
<script type="text/javascript">
$(function() {
	$("#sortable").sortable();
	$("#sortable").disableSelection();
});
$(function() {
	$('#add-cat')
			.button()
			.click(function() {
				//AJAX form submit
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/CAT?action=ADDAJ&c="+new Date().getTime(),   
		             type: "POST",  
		             cache: false,  
		             success: function (html) {                
	                 //if process.php returned 1/true (send mail success)
		            	 $('#cat-region').html(html);
		             }         
	    	     });  
				return false;
			});
	$('#saveorder-cat')
	.button()
	.click(function() {
		//AJAX form submit
		$.ajax({  
             url: "<%=request.getAttribute("contextPath") %>/do/CAT?action=SAVE_ORDER&c="+new Date().getTime(),   
             type: "POST",  
             data: "guids="+$("#sortable").sortable("toArray"),
             cache: false,  
             success: function (html) {                
             //if process.php returned 1/true (send mail success)
            	 $('#cat-region').html(html);
             }         
	     });  
		return false;
	});	
	
	$(".ui-icon-closethick")
	.bind("click", function(){
		if (confirm("<%=MessageUtil.getV6Message(lang,"BUT_DEL_CONFIRM_MSG")%>\""+ $(this).attr("catname")+"\"?")){
			$.ajax({  
	            url: "<%=request.getAttribute("contextPath") %>/do/CAT?action=DELAJ&c="+new Date().getTime(),   
	            type: "POST",  
	            data: "guid="+$(this).attr("name"),
	            cache: false,  
	            success: function (html) {                
	           	 $('#cat-region').html(html);
	            }         
		     });  
		}
		return false;
	});
	
	$('.ui-icon-pencil')
	.bind("click", function(){
		$.ajax({  
            url: "<%=request.getAttribute("contextPath") %>/do/CAT?action=EDITAJ&c="+new Date().getTime(),   
            type: "POST",  
            data: "guid="+$(this).attr("name"),
            cache: false,  
            success: function (html) {                
              	 $('#cat-region').html(html);
            }
	     });
		
	});
	$('.ui-icon-copy')
	.bind("click", function(){
		$.ajax({  
            url: "<%=request.getAttribute("contextPath") %>/do/CAT?action=COPY&c="+new Date().getTime(),   
            type: "POST",  
            data: "guid="+$(this).attr("name"),
            cache: false,  
            success: function (html) {                
           	 $('#cat-region').html(html);
            }         
	     });
	});	
			
});
</script>
<button id="add-cat"><%=MessageUtil.getV6Message(lang,"BUT_ADD")%></button>
<button id="saveorder-cat"><%=MessageUtil.getV6Message(lang,"BUT_SAVE_ORDER") %></button>