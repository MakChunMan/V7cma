<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.imagsky.common.*" %>
 <%@ page import="com.imagsky.v6.cma.constants.*" %>
 <%@ page import="com.imagsky.v6.domain.Member" %>
 <%@ page import="com.imagsky.v8.domain.App" %>
 <%@ page import="com.imagsky.util.*" %>
<% 
String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);  
App thisApp = (App)request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
%>
<!-- Horizontal Form Title -->
      <div class="block-title">
          <h2><%=MessageUtil.getV8Message(lang,"APP_EDIT_TITLE") %></h2>
      </div>
      <!-- END Horizontal Form Title -->

      <!-- Horizontal Form Content -->
      <form id="app_edit_form" method="post" class="form-horizontal form-bordered" onsubmit="return false;">
           <input type=hidden name="edit_guid" value="<%=thisApp.getSys_guid()%>"/>
          <div class="form-group">
              <label class="col-md-3 control-label" for="edit-app-name"><%=MessageUtil.getV8Message(lang,"APP_NAME") %></label>
              <div class="col-md-9">
                  <input type="text" id="edit-app-name" name="edit-app-name" class="form-control" value="<%=thisApp.getAPP_NAME()%>">
                  <span class="help-block"><%=MessageUtil.getV8Message(lang,"APP_NAME_LABEL") %></span>
              </div>
          </div>
          <div class="form-group">
              <label class="col-md-3 control-label" for="edit-app-desc"><%=MessageUtil.getV8Message(lang,"APP_DESC") %></label>
              <div class="col-md-9">
                  <input type="text" id="edit-app-desc" name="edit-app-desc" class="form-control" value="<%=CommonUtil.null2Empty(thisApp.getAPP_DESC())%>">
                  <span class="help-block"><%=MessageUtil.getV8Message(lang,"APP_DESC_LABEL") %></span>
              </div>
          </div>
          <div class="form-group">
              <label class="col-md-3 control-label"><%=MessageUtil.getV8Message(lang,"APP_TYPE") %></label>
              <div class="col-md-9">
                  <label class="radio-inline" for="apptype_basic">
                      <input type="radio" id="apptype_basic" name="edit-app-type" value="1" <%=(thisApp.getAPP_TYPE()==1)?"checked":"" %>><%=MessageUtil.getV8Message(lang,"APP_TYPE_BASIC") %>
                  </label>
                  <label class="radio-inline" for="apptype_shop">
                      <input type="radio" id="apptype_shop" name="edit-app-type" value="2" <%=(thisApp.getAPP_TYPE()==2)?"checked":"" %>><%=MessageUtil.getV8Message(lang,"APP_TYPE_SHOP") %> 
                  </label>
                  <label class="radio-inline" for="apptype_pda">
                      <input type="radio" id="apptype_pda" name="edit-app-type" value="3" <%=(thisApp.getAPP_TYPE()==3)?"checked":"" %>><%=MessageUtil.getV8Message(lang,"APP_TYPE_PDA") %>
                  </label>
              </div>
          </div>
          <div class="form-group form-actions">
              <div class="col-md-9 col-md-offset-3">
                  <button type="submit" id="app_edit_submit" class="btn btn-effect-ripple btn-primary"><%=MessageUtil.getV8Message(lang,"BTN_SUBMIT") %></button>
                  <button type="reset" class="btn btn-effect-ripple btn-danger"><%=MessageUtil.getV8Message(lang,"BTN_RESET") %></button>
              </div>
          </div>
      </form>
      <!-- END Horizontal Form Content -->
      <script>
      $('#app_edit_submit').click(function(){
    	  $.ajax({
    		  url:"/do/APP/DO_EDIT_SAVE",
              data: $('#app_edit_form').serialize(),
              type: "post",               
              cache: false
          }).done(function( html ) {
              if($.trim(html).match("^Error")){
                  // Server side validation and display error msg
                  $('#error-msg').html(html.replace("Error:","")+"<br/>");
              } else {
            	  $('#APP_EDIT_FORM').html(
            	  '<div class="alert alert-success alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+
                  '<h4><strong><%=MessageUtil.getV8Message(lang, "COMMON_LABEL")%></strong></h4>' +
                  '<p>'+html.replace("Msg:","")+'</p></div>');
            	  //Reload List
                  $.ajax({
                      url:"/do/APP/AJ_LIST",
                      cache: false
                  }).done(function( html ) {
                          $('#app-list').html(html);
                  });
              }
          });
      });
      </script>