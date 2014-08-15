<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>    
<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))){ %>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
<%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
</div>
</div>
<br/>
<%} %>
<form id="banner-form" action="" method="post">
							<table width="100%" class="tbl_form">
								<colgroup>
									<col width="15%"  />
									<col width="*"  />
								</colgroup>
								<thead>
								<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"TIT_BNR_SEARCH") %></th></tr>
								</thead>
								<tbody>
								<tr>
									<td><%=MessageUtil.getV6Message(lang,"BNR_PAGETYPE") %></td>
									<td><input type=radio value="CAT" name="PAGE_TYPE"/><%=MessageUtil.getV6Message(lang,"BNR_TYPECAT") %><br/>
										<input type=radio value="ARTI" name="PAGE_TYPE"/><%=MessageUtil.getV6Message(lang,"BNR_TYPEARTI") %>
									</td>
								</tr>
								<tr>
									<td><%=MessageUtil.getV6Message(lang,"BNR_PAGETITLE") %></td>
									<td><SELECT id="CONTENT_GUID" name="CONTENT_GUID"><option><%=MessageUtil.getV6Message(lang,"BNR_CHOOSE") %></option></SELECT>
										<img id="loaderimg" src="<%=staticPath %>/images/ajax-loader.gif" style="display:none"/>
									</td>
								</tr>								
								<tr>
									<td colspan="2"><button id="search-submit"><%=MessageUtil.getV6Message(lang,"BUT_SEARCH")%></button></td>
								</tr>								
								</tbody>
							</table>
							
							<br/>
							<div id="bnr_edit_region" style="display:none">
							</div>
</form>
<script>
$(function() {
	$('#search-submit')
			.button()
			.click(function() {
				//AJAX form submit
				$.ajax({  
					url: "<%=request.getAttribute("contextPath") %>/do/BNR?action=AJ_SEARCH&c="+new Date().getTime(),   
		             type: "POST",  
		             data: $("#banner-form").serialize(),       
		             cache: false,  
		             success: function (html) {                
	                 //if process.php returned 1/true (send mail success)
		            	 $('#bnr_edit_region').html(html);
		            	 $('#bnr_edit_region').show();
		             }         
	    	     });  
				return false;
			});

	$("form input:radio")
		.click(function(){
			$("#loaderimg").show();
		    $.getJSON("<%=request.getAttribute("contextPath") %>/do/BNR?action=AJ_OPTION&c="+new Date().getTime()+"&PAGE_TYPE="+$(this).val(),
		    	    function(j){
		      var options = '';
		      for (var i = 0; i < j.length; i++) {
		        options += '<option value="' + j[i].optionValue + '">' + j[i].optionDisplay + '</option>';
		      }
		      $('#CONTENT_GUID').html(options);
		      $("#loaderimg").hide();
		    })
	  })
});
</script>			
