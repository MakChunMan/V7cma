<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG); %>
<% 
String catName = "";
String catLang = "";
String catGuid = "";
String catType = "";
SellItemCategory obj = (SellItemCategory)request.getAttribute("THIS_OBJ");
Node thisNode = (Node)request.getAttribute("THIS_NODE");
Member thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
if(obj!=null){
	catName = obj.getCate_name();
	catLang = obj.getCate_lang();
	catGuid = obj.getSys_guid();
	catType = obj.getCate_type();
}
%>
<form id="edit-form" action="" method="post">
<input type="hidden" name="action" value="SAVE"/>
            <div class="ui-widget"><div id="formerr">
                    <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
            </div>
            <% if(!catGuid.equalsIgnoreCase("")){ %>
            <input type="hidden" name="CAT_GUID" value="<%=catGuid %>"/><%} %>
            <table width="100%" class="tbl_form">
                    <colgroup>
                            <col width="15%"  />
                            <col width="*"  />
                    </colgroup>
                    <tbody>
                    <% if(V6Util.isMainsiteLogin(thisMember)){ %>
                    <tr>
                            <td><label for="CAT_NAME"><%=MessageUtil.getV6Message(lang,"CAT_TYPE") %></label></td>
                            <td>
                            <SELECT name="CAT_TYPE" id="CAT_TYPE">
                                    <option value=""><%=MessageUtil.getV6Message(lang,"CAT_TYPE_NORMAL") %></option>
                                    <option value="A"><%=MessageUtil.getV6Message(lang,"CAT_TYPE_AUCTION") %></option>
                                    <option value="B"><%=MessageUtil.getV6Message(lang,"CAT_TYPE_BULKORDER") %></option>
                            </SELECT>
                            <% if(!CommonUtil.isNullOrEmpty(catType)){ %>
                            <script>$('#CAT_TYPE').val("<%=catType%>");</script>
                            <% }  %>
                            </td>
                    </tr>								
                    <% } %>
                    <tr>
                            <td><label for="CAT_NAME"><%=MessageUtil.getV6Message(lang,"CAT_NAME") %></label></td>
                            <td><input type="text" name="CAT_NAME" id="CAT_NAME" value="<%=CommonUtil.null2Empty(catName) %>" maxLength="50" class="text"></td>
                    </tr>								
                    <tr>
                            <td><label for="CAT_LANG"><%=MessageUtil.getV6Message(lang,"ARTI_LANG") %></label></td>
                            <td><SELECT name="CAT_LANG">
                            <OPTION value="zh" <%=CommonUtil.isSelected(catLang,"zh") %>><%=MessageUtil.getV6Message(lang,"COMMON_LANG_ZH") %></OPTION>
                            </SELECT>
                            </td>
                    </tr>								
                    <tr>
                            <td><label for="CAT_LANG"><%=MessageUtil.getV6Message(lang,"NOD_NAME") %></label></td>
                            <td><%=(thisNode!=null)?thisNode.getNod_url():""%></td>
                            </td>
                    </tr>								
                    </tbody>
            </table>
            <button id="cat-submit"><%=MessageUtil.getV6Message(lang,"BUT_SUBMIT") %></button>	
            <button id="cat-back"><%=MessageUtil.getV6Message(lang,"BUT_BACK") %></button>
</form>
<script>
$(function() {
	$('#cat-submit')
			.button()
			.click(function() {
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/CAT?c="+new Date().getTime(),   
		             type: "POST",  
		             data: $("#edit-form").serialize(),       
		             cache: false,  
		             success: function (html) {                
		            	 $('#cat-region').html(html);
		             }         
	    	     });  
				return false;
			});
});

$(function() {
	$('#cat-back')
			.button()
			.click(function() {
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/CAT?action=LISTAJ&c="+new Date().getTime(),   
		             type: "POST",  
		             cache: false,  
		             success: function (html) {                
		            	 $('#cat-region').html(html);
		             }         
	    	     });  
				return false;
			});
});
</script>