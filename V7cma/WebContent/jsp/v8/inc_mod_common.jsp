<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.imagsky.common.*" %>
 <%@ page import="com.imagsky.v6.cma.constants.*" %>
 <%@ page import="com.imagsky.v6.domain.Member" %>
 <%@ page import="com.imagsky.v8.domain.App" %>
 <%@ page import="com.imagsky.v8.domain.Module" %>
 <%@ page import="com.imagsky.v8.domain.Module.*" %>
 <%@ page import="com.imagsky.v8.domain.ModAboutPage" %>
 <%@ page import="com.imagsky.v8.constants.*" %>
 <%@ page import="com.imagsky.util.*" %>
 <%
 String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
 Module thisMod = (Module)request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
 %>
        <div class="form-group">
              <label class="col-md-3 control-label" for="edit-mod-bg"><%=MessageUtil.getV8Message(lang,"MOD_BACKGROUND") %></label>
              <div class="col-md-9">
                   <div id="mod_bg_response">
                   <% if(thisMod.getModBackground()!=null){ %>
                   <img width='300' src='<%=V8SystemConstants.V8_PATH %>userfiles/tmp/<%=thisMod.getModBackground().getImageUrl() %>'>
                   <input type=hidden name=edit-mod-bg value='<%=thisMod.getModBackground().getImageUrl() %>'/>
                   <% } %>
                   </div>
                  <button type=button  class="btn btn-effect-ripple btn-warning" onclick="javascript:return uploadOnClick('mod_bg_response','BGD_');">
                  <%=MessageUtil.getV8Message(lang,"MOD_BG_LABEL") %></button>
              </div>
       </div>
        <div class="form-group">
              <label class="col-md-3 control-label" for="edit-mod-icon"><%=MessageUtil.getV8Message(lang,"MOD_ICON") %></label>
              <div class="col-md-9">
                   <div id="mod_icon_response">
                   <% if(thisMod.getModIcon()!=null){ %>
                   <img width='300' src='<%=V8SystemConstants.V8_PATH %>userfiles/tmp/<%=thisMod.getModIcon().getImageUrl() %>'>
                   <input type=hidden name=edit-mod-icon value='<%=thisMod.getModIcon().getImageUrl() %>'/>
                   <% } %>
                   </div>
                  <button type=button  class="btn btn-effect-ripple btn-warning" onclick="javascript:return uploadOnClick('mod_icon_response','ICN_');">
                  <%=MessageUtil.getV8Message(lang,"MOD_ICON_LABEL") %></button>
              </div>
       </div>       