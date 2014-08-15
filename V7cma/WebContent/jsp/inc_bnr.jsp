<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/init.jsp" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="java.util.*" %>
<%
List aList = (List)request.getAttribute("NODELIST");
Member thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/";
String tmpImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/";
%>
<style id="styles" type="text/css">
		.wrapper { width: 600px;}
		div.button {
			border: solid 2px Transparent;
			border-color: #dddddd;
			width:600px;
			height:120px;	
			background: url(<%=staticPath %>/images/pictures_bnr.png) 0 0 no-repeat;
			color: #555555;
		}
		
		.existingimage {
			border: solid 2px Transparent;
			border-color: #dddddd;
		}
		div.button.hover {
			border-color: #555555;
			cursor: pointer;	
		}
		
		div.button.loading {
			background: url(<%=staticPath %>/images/ajax-loader.gif) 0 0 no-repeat;
		}
</style>
<script type="text/javascript" src="<%=staticPath %>/js/ajaxupload.js"></script>
<form id="bannerform">
<table width="100%" class="tbl_form" border=1>
								<colgroup>
									<col width="15%"  />
									<col width="*"  />
								</colgroup>
								<thead>
								<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"TIT_BNR_CHG") %></th></tr>
								</thead>
								<tbody>
								<% if(aList !=null && aList.size()>0){
									Node thisNode = (Node)aList.get(0);
									out.println("<input type=\"hidden\" name=\"NODE_GUID\" value=\""+ thisNode.getSys_guid()+"\"/>");
									if(CommonUtil.isNullOrEmpty(thisNode.getNod_bannerurl())){%>
									<tr><td colspan="2">
									<div class="ui-widget"><div id="formerr"><jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
									<div class="ui-widget"><div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
									<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
										<% if(CommonUtil.isNullOrEmpty(thisMember.getMem_shopbanner())){ %>
											<%=MessageUtil.getV6Message(lang,"BNR_NOT_MAIN_SET")%>
										<% } else { %>
											<%=MessageUtil.getV6Message(lang,"BNR_NOT_SET")%>
										<% } %>
									</div>
									</div>	
									</td></tr>
									<% if(!CommonUtil.isNullOrEmpty(thisMember.getMem_shopbanner())){ %>
									<tr>
									<td colspan="2"><img id="showimage" class="existingimage" src="<%=userImagePath %>/<%=thisMember.getMem_shopbanner() %>" width="600"></img></td>
									</tr>
									<% } %>
									<%} else {%>
										<tr>
										<td colspan="2">
										<%=MessageUtil.getV6Message(lang,"BNR_SET")%><br/>
										<img id="showimage" class="existingimage" src="<%=userImagePath %>/<%=thisNode.getNod_bannerurl() %>" width="600"></img></td>
										</tr>
									<%					
										}
								}
								%>
								<tr><td colspan="2">
								<br/>
								<div id="upload-label" style="display:none"><%=MessageUtil.getV6Message(lang,"BNR_NEW_UPLOAD") %>:</div>
								<div class="wrapper" id="button1_region"><div id="button1" class="button">
								<%=MessageUtil.getV6Message(lang,"BNR_BTN_NEW_UPLOAD")%>
								</div>
								</div>
								<%=MessageUtil.getV6Message(lang,"PRF_MAIN_BANNER_MSG") %><br/>
								<input type="hidden" name="BANNER_IMAGE_1" id="BANNER_button1"/>
								<button id="btn_save" style="display:none"><%=MessageUtil.getV6Message(lang,"BNR_SAVE_NEW") %></button>
								<button id="btn_list_pic" style="display:none"><%=MessageUtil.getV6Message(lang,"BNR_BTN_UPLOADED")%></button>
								</td></tr>
								</tbody>
							</table>
							
</form>								
<script>							
function initAjaxUpload(obj,filename1){
	return new AjaxUpload(
			obj,{
				action: '<%=staticPath %>/upload-banr-handler.php?guid=<%=thisMember.getSys_guid()%>', 
				name: 'userfile',
				onSubmit : function(file, ext){
					 if (! (ext && /^(jpg|png|jpeg|gif)$/i.test(ext))){
	                     alert('Error: invalid file extension');
	                     return false;
	             	}
					document.getElementById(filename1).style.background = "url(<%=staticPath %>/images/ajax-loader.gif)";
					document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
					this.disable();
				},
				onComplete: function(file, response){
					// enable upload button
					if(response.indexOf("success")==0){
						response = response.replace("success:","");
						$('#errmsg'+filename1).remove();
						document.getElementById("BANNER_"+filename1).value = response;
						$("#upload-label").show();

						document.getElementById(filename1).style.background = "url(<%=tmpImagePath%>"+response+")";
						document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
						$("#btn_save").show();
					} else {
						if ($('#errmsg'+filename1).exists()) {
							$('#errmsg'+filename1).replaceWith('<li id="errmsg1"><font color="red">'+response+'</font></li>');
						} 
						document.getElementById(filename1).style.background = "url(<%=staticPath %>/images/pictures_bnr.png)";
						document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
					}
					this.enable();
				}
			}
			);
}
$(document).ready(function(){
	var button1 = $('#button1'), interval;
	initAjaxUpload(button1,"button1");
});	

$(function() {
	$('#btn_save')
			.button()
			.click(function() {
				//AJAX form submit
				$.ajax({  
					url: "<%=request.getAttribute("contextPath") %>/do/BNR?action=DO_SAVE&c="+new Date().getTime(),   
		             type: "POST",  
		             data: $("#bannerform").serialize(),       
		             cache: false,  
		             success: function (html) {                
	                 //if process.php returned 1/true (send mail success)
		            	 $('#banner-region').html(html);
		            	 $('#banner-region').show();
		             }         
	    	     });  
				return false;
			});
});
</script>