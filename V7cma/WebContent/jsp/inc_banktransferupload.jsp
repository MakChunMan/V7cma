<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.util.ArrayList" %>
<% 
String tmpImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/";
%>
<%@include file="/init.jsp" %>
<script type="text/javascript" src="<%=staticPath %>/js/ajaxupload.js"></script>
<style id="styles" type="text/css">
		.wrapper { width: 500px; margin: 0 auto; }
		div.button {
			border: solid 2px Transparent;
			border-color: #eeeeee;
			height:128px;	
			width: 128px;
			background: url(<%=staticPath %>/images/pictures.png) 0 0;
		}
		div.button.hover {
			border-color: #aaaaaa;
			cursor: pointer;	
		}
		div.button.loading {
			background: url(<%=staticPath %>/images/ajax-loader.gif) 0 0 no-repeat;
		}
</style>
<% if(!CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))){ %>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
<%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
</div>
</div>
<br/>
<% } else { %>
<form id="payment-form">
<div class="ui-widget"><div id="formerr">
	<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
</div>
<% if(CommonUtil.isNullOrEmpty((String)request.getAttribute("guard"))){ %>
<table width="100%" class="tbl_form">
		<colgroup>
			<col width="20%"  />
			<col width="*"  />
		</colgroup>
		<thead>
		<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"PRF_INFO")%></th></tr>
		</thead>
		<tbody>
		<tr><td><%=MessageUtil.getV6Message(lang, "TXT_ORDER_NO") %></td><td><input type="text" name="O" value="<%=CommonUtil.null2Empty(request.getParameter("O")) %>" readonly/></td></tr>
		<tr><td><%=MessageUtil.getV6Message(lang, "PRF_EMAIL") %></td><td><input type="text" name="email"
		value=<%=(V6Util.isLogined(request))?"\""+((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser().getMem_login_email() + "\" readonly ":"\""+CommonUtil.null2Empty(request.getParameter("email"))+"\"" %>/></td></tr>
		<tr><td><%=MessageUtil.getV6Message(lang, "TXT_BT_DATE") %></td><td><input name="input_date" maxlength="10" size="10" value="<%=CommonUtil.formatDate(new java.util.Date(), "dd-MM-yyyy") %>"/></td></tr>
		<tr><td><%=MessageUtil.getV6Message(lang, "TXT_AMOUNT") %></td>
		      <td><input name="amount" value="<%=CommonUtil.null2Empty(request.getParameter("amount")) %>">
		          <select name="bank">
                      <option value="">-- 銀行 --</option>		          
		              <option value="匯豐銀行">匯豐銀行</option>
		              <option value="中國銀行">中國銀行</option>
		          </select>
		</td></tr>
		<tr><td><%=MessageUtil.getV6Message(lang,"TXT_BT_REF")%></td><td><input type="text" name="bank_ref"/></td></tr>
		<tr><td><%=MessageUtil.getV6Message(lang,"TXT_BT_SCRIPT")%></td><td>
		<%=MessageUtil.getV6Message(lang,"TXT_BT_SCRIPT_MSG") %><br/><br/>
		<div class="wrapper" id="button1_region"><div id="button1" class="button" style="border:1px solid #ccc">
		</div><img src="" id="preview" width="300" style="display:none"/></div>
		<input type="hidden" name="SCRIPT_IMAGE_1" id="SCRIPT_button1"/><br/><br/>
		<div style="display:none" class="loadinggif">處理中, 請稍候<img src="<%=staticPath%>/images/loader.gif"/></div>
		</td></tr>
		</tbody>
</table>
<button id="btn-submit"><%=MessageUtil.getV6Message(lang,"BUT_SUBMIT") %></button>	
<input type=hidden name="P" value="<%=CommonUtil.null2Empty(request.getParameter("P")) %>"/>
</form>
<script>
$(function() {
	$('#btn-submit')
			.button()
			.click(function() {
				$(this).hide();
				$('.loadinggif').show();
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/main.do?action=BTUPLOAD&c="+new Date().getTime(),   
		             type: "POST",  
		             data: $("#payment-form").serialize(),       
		             cache: false,  
		             success: function (html) {                
		            	 $('#payment-region').html(html);
		             }         
	    	     });  
				return false;
			});
});
function initAjaxUpload(obj,filename1){
	return new AjaxUpload(
			obj,{
				action: '<%=staticPath %>/upload-btscript-handler.php?O=<%=CommonUtil.null2Empty(request.getParameter("O"))%>&P=<%=CommonUtil.null2Empty(request.getParameter("P"))%>', 
				name: 'userfile',
				onSubmit : function(file, ext){
					 if (! (ext && /^(jpg|png|jpeg|gif)$/i.test(ext))){
	                     alert('Error: invalid file extension');
	                     return false;
	             	}
					 $('#formerr').html("");
					document.getElementById(filename1).style.background = "url(<%=staticPath %>/images/ajax-loader.gif)";
					document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
					this.disable();
				},
				onComplete: function(file, response){
					if(response.indexOf("success")==0){
						response = response.replace("success:","");
						$('#formerr').html("");
						document.getElementById("SCRIPT_"+filename1).value = response;
						$('#button1').hide();
						//alert('<%=staticPath%>'+response);
						$('#preview').attr("src","<%=staticPath%>"+response);
						$('#preview').show();
					} else {
						alert("Error:"+ response);
						//if ($('#formerr').exists()) {
							$('#formerr').html('<li id="errmsg1"><font color="red">'+response+'</font></li>');
						//} 
						document.getElementById(filename1).style.background = "url(<%=staticPath %>/images/pictures.png)";
					}
					this.enable();
				}
			}
			);
}
$(document).ready(function(){
	/* Example 1 */
	var button1 = $('#button1'), interval;
	initAjaxUpload(button1,"button1");
});
</script>
<% } %>
<% } %>