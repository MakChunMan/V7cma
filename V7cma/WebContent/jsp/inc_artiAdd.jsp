<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
String staticPath =  PropertiesConstants.get(PropertiesConstants.staticContextRoot);
String tmpImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/";
%>
<script type="text/javascript" src="<%=staticPath %>/js/ajaxupload.js"></script>
<script>
var editor;
function createEditor(editContainerId)
{	
	$('#btnOPEN').hide();
	$('#btnCLOSE').show();

	if ( editor ) return;
	var html = document.getElementById( editContainerId+'_content' ).innerHTML;
	document.getElementById( editContainerId+'_content' ).style.display="none";
	// Create a new editor inside the <div id="editor">
	editor = CKEDITOR.appendTo(editContainerId, {
        toolbar : 'MyToolbar'
    });
	editor.setData( html );
}
 
function removeEditor(editContainerId)
{	
	if ( !editor )	return;
	// Retrieve the editor contents. In an Ajax application, this data would be
	// sent to the server or used in any other way.
	document.getElementById( editContainerId+'_content' ).innerHTML = editor.getData();
	document.getElementById( editContainerId+'_content' ).style.display = '';
 
	// Destroy the editor.
	editor.destroy();
	editor = null;

	$('#btnOPEN').show();
	$('#btnCLOSE').hide();
}
</script>
<%
String article_lang="";
String article_guid="";
Article obj = (Article)request.getAttribute("THIS_OBJ");
if(obj==null){
	obj = new Article();
}
%>
<style id="styles" type="text/css">
		.wrapper { width: 128px; margin: 0 auto; }
		
		div.button {
			border: solid 2px Transparent;
			border-color: #eeeeee;
			height:128px;	
			width: 128px;
			background: url(<%=staticPath %>/images/pictures.png) 0 0;
		}
		/* 
		We can't use ":hover" preudo-class because we have
		invisible file input above, so we have to simulate
		hover effect with JavaScript. 
		 */
		div.button.hover {
			border-color: #aaaaaa;
			cursor: pointer;	
		}
		
		div.button.loading {
			background: url(<%=staticPath %>/images/ajax-loader.gif) 0 0 no-repeat;
		}
</style>
<form id="arti_add_form" action="" method="post">
<input type="hidden" name="action" value="SAVE"/>
<div class="ui-widget"><div id="formerr">
	<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
</div>
<% if(!CommonUtil.isNullOrEmpty(obj.getSys_guid())){ %>
<input type="hidden" name="ARTI_GUID" value="<%=obj.getSys_guid() %>"/><%} %>
<table width="95%" cellpadding="5">
<tr><td><%=MessageUtil.getV6Message(lang,"ARTI_TITLE") %></td><td><input type="text" name="ARTI_NAME" size="30" maxlength="30" value="<%=CommonUtil.null2Empty(obj.getArti_name()) %>"/></td> </tr>
<tr><td><%=MessageUtil.getV6Message(lang,"ARTI_LANG") %></td><td><SELECT name="ARTI_LANG">
									<OPTION value="zh" <%=CommonUtil.isSelected(article_lang,"zh") %>><%=MessageUtil.getV6Message(lang,"COMMON_LANG_ZH") %></OPTION>
									</SELECT>
									</td>
									</tr>
<% if(!CommonUtil.isNullOrEmpty(obj.getSys_guid())){ %>									
<tr><td><%=MessageUtil.getV6Message(lang,"ARTI_NODE_URL") %><br/>
<%=MessageUtil.getV6Message(lang,"ARTI_CACHE_URL") %></td><td>
	<%
	Node thisNode = (Node)request.getAttribute("THIS_NODE");
	out.println(CommonUtil.null2Empty(thisNode.getNod_url()+"<BR/>"));
	out.println(CommonUtil.null2Empty(obj.getArti_exp_file()+"<BR/>"));
	%>									
	</td>
</tr>
<% } else if(ACLUtil.isValid(((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser(),ACLUtil.ART03)){ %>
<tr><td><%=MessageUtil.getV6Message(lang,"ARTI_NODE_URL") %></td>
	<td>/jetso/<%=CommonUtil.formatDate(new java.util.Date(),"MMdd") %>-<input name="NODE_URL"/>.do</td>
</tr>
<% }  %>
<tr><td><%=MessageUtil.getV6Message(lang,"ARTI_LOCATE") %></td><td>
<input type="checkbox" name="ARTI_IS_TOPNAV" <%=(obj.isArti_isTopNav())?"checked":"" %> value="Y"/><%=MessageUtil.getV6Message(lang,"ARTI_LOC_TOPNAV") %><br/>
<input type="checkbox" name="ARTI_IS_SUBNAV" <%=(obj.isArti_isSubNav())?"checked":"" %> value="Y"/><%=MessageUtil.getV6Message(lang,"ARTI_LOC_SUBNAV1") %> <SELECT name="ARTI_PARENT_GUID" id="ARTI_PARENT_GUID">
<option value=""><%=MessageUtil.getV6Message(lang,"COMMON_CHOOSE") %></option>
<%=request.getAttribute("TOPNAV_OPTIONS") %></SELECT><%=MessageUtil.getV6Message(lang,"ARTI_LOC_SUBNAV2") %><br/>
<% if(!CommonUtil.isNullOrEmpty(obj.getArti_parent_guid())){ %>
<script>
$('#ARTI_PARENT_GUID').val("<%=obj.getArti_parent_guid()%>");
</script>
<% } %>
<input type="checkbox" name="ARTI_IS_HIGHLIGHT" <%=(obj.isArti_isHighlightSection())?"checked":"" %> value="Y"/><%=MessageUtil.getV6Message(lang, "ARTI_LOC_SLI") %><br/>
</td></tr>
<% if(ACLUtil.isValid(((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser(),ACLUtil.ART01)){ %>
<tr><td><%=MessageUtil.getV6Message(lang,"ARTI_TYPE")%></td>
	<td><SELECT name="ARTI_TYPE" id="ARTI_TYPE"><option value="">--</option>
		<option value="J">Share Jetso</option>
		<option value="S">有趣分享</option>
	</SELECT>
	<script>
	$('#ARTI_TYPE').val("<%=obj.getArti_type()%>");
	</script>
	</td></tr>
<% } %>
<% if(ACLUtil.isValid(((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser(),ACLUtil.ART02)){ %>
<tr><td colspan="2">
	<br/>
	<%=MessageUtil.getV6Message(lang,"PROD_IMAGE")%> <%=MessageUtil.getV6Message(lang,"PROD_IMAGE_MSG")%>
	<br/>
	<br/>
	<table width="90%">
	<tr valign="top">
			<td><div class="wrapper" id="button1_region"><div id="button1" class="button"></div></div>
			<input type="hidden" name="PROD_IMAGE_1" id="IMG_button1"/>
			<script type="text/javascript">
			jQuery.fn.exists = function(){return jQuery(this).length>0;}
			<%--
			<% if(!CommonUtil.isNullOrEmpty(obj.getProd_image1())){ %>
			document.getElementById("IMG_button1").value = "<%=obj.getProd_image1()%>";
			document.getElementById("button1").style.background = "url(<%=userImagePath%>thm_<%=obj.getProd_image1()%>)";
			document.getElementById("button1").style.backgroundRepeat = "no-repeat";
			<%}%>
			--%>
			var onactiveimage;
			var isSetImage = false;
			function initAjaxUpload(obj,filename1){
				return new AjaxUpload(
						obj,{
							action: '<%=staticPath %>/upload-handler.php?type=j&sid=<%=request.getSession().getId()%>', 
							name: 'userfile',
							onSubmit : function(file, ext){
								 if (! (ext && /^(jpg|png|jpeg|gif)$/i.test(ext))){
				                     // extension is not allowed
				                     alert('Error: invalid file extension');
				                     // cancel upload
				                     return false;
				             	}
								 document.getElementById(filename1).style.background = "url(<%=staticPath %>/images/ajax-loader.gif)";
								 document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
								 //this.disable();
							},
							onComplete: function(file, response){
								// enable upload button
								if(response.indexOf("success")==0){
									response = response.replace("success:","");
									$('#errmsg'+filename1).remove();
									//SET image button background : TO BE REMOVE
									document.getElementById("IMG_"+filename1).value = response;
									document.getElementById(filename1).style.background = "url(<%=staticPath%>/images/pictures.png)";
									$('#ARTI_CONTENT_content').html("<img src=\"<%=tmpImagePath%>jetso/"+response + "\"/>" + $('#ARTI_CONTENT_content').html());
									isSetImage = true;
									if(editor){
										editor.destroy();
										editor = null;
									}
									createEditor('ARTI_CONTENT');
								} else {
									if ($('#errmsg'+filename1).exists()) {
										$('#errmsg'+filename1).replaceWith('<li id="errmsg1"><font color="red">'+response+'</font></li>');
									} else {
									}
									//$('#'+filename1+'_region').html($('#'+filename1+'_region').html +	response); 
									document.getElementById(filename1).style.background = "url(<%=staticPath%>/images/pictures.png)";
									//this.enable();
								}
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
			</td>
	</tr>
	</table>
</td></tr>									
<% } %>
</table>

	<%=MessageUtil.getV6Message(lang,"ARTI_CONTENT")%>
	<p>
		<input id="btnOPEN" style="display:none" class="btnGeneric" onclick="createEditor('ARTI_CONTENT');" type="button" value="<%=MessageUtil.getV6Message(lang,"ARTI_EDITOR_OPEN")%>" />
		<input id="btnCLOSE" class="btnGeneric" onclick="removeEditor('ARTI_CONTENT');" type="button" value="<%=MessageUtil.getV6Message(lang,"ARTI_EDITOR_CLOSE")%>" />
	</p>
<input type="hidden" name="ARTI_CONTENT" id="ARTI_hidden_content"/>
<div id="ARTI_CONTENT">
</div>
<div id="ARTI_CONTENT_content">
<% if(CommonUtil.isNullOrEmpty(obj.getArti_content())){ 
	out.println(MessageUtil.getV6Message(lang,"ARTI_DUMMY_CONTENT"));
 } else { %>
<%=CommonUtil.null2Empty(obj.getArti_content()) %><%} %>
</div>
<% if(ACLUtil.isValid(((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser(),ACLUtil.MET01)){ %>
<jsp:include page="/jsp/inc_web_meta.jsp"></jsp:include>
<% } %>
<br/>
<br/>
<script>
if(editor){
	editor.destroy();
	editor = null;
}
createEditor('ARTI_CONTENT');</script>
</form>
<div id="button_bar">
<button id="arti-submit"><%=MessageUtil.getV6Message(lang,"BUT_SUBMIT") %></button>	
<button id="arti-back"><%=MessageUtil.getV6Message(lang,"BUT_BACK") %></button>
</div>		
<script type="text/javascript">
jQuery.fn.exists = function(){return jQuery(this).length>0;}
</script>

<script>
$(function() {
	$('#arti-submit')
			.button()
			.click(function() {
				removeEditor('ARTI_CONTENT');
				document.getElementById('ARTI_hidden_content').value = 
					$('#ARTI_CONTENT_content').html();
				$("#button_bar").html("<img src=\"<%=staticPath %>/images/loader.gif\"/>");
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/ARTI?c="+new Date().getTime(),   
		             type: "POST",  
		             data: $("#arti_add_form").serialize(),       
		             cache: false,  
		             success: function (html) {                
		            	 $("#arti-region").html(html);
		             }         
	    	     });  
				return false;
			});
});

$(function() {
	$('#arti-back')
			.button()
			.click(function() {
				removeEditor('ARTI_CONTENT');
				$("#button_bar").html("<img src=\"<%=staticPath %>/images/loader.gif\"/>");
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/ARTI?action=LISTAJ&c="+new Date().getTime(),   
		             type: "POST",  
		             cache: false,  
		             success: function (html) {                
		            	 $("#arti-region").html(html);
		             }         
	    	     });  
				return false;
			});
});

</script>