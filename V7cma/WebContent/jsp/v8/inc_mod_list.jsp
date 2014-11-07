<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.imagsky.v8.constants.*" %>
 <%@ page import="com.imagsky.common.*" %>
 <%@ page import="com.imagsky.v6.cma.constants.*" %>
 <%@ page import="com.imagsky.v6.domain.Member" %>
 <%@ page import="com.imagsky.util.*" %>
 <%@ page import="com.imagsky.v8.domain.App" %>
 <%@ page import="java.util.*" %>
 <% 
 String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
 Member thisUser = null;
 App thisApp = null;
 if(!V6Util.isLogined(request)){
     out.println("<script>self.location='/v81/zh/page_ready_login.php';</script>");
 } else {
     thisUser = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
     thisApp = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getWorkingApp();
 %>
<div class="row block-section">
                <% for (int x =0 ; x < 6 ;x++){ %>
                <div class="col-xs-2" id="module<%=(x+1)%>">
                    <button class="btn btn-lg btn-success"><i class="fa fa-plus"></i> Add</button>
                </div>
                <% } %>
                
              <div class="col-xs-2" id="module1">
                  <button class="btn btn-lg btn-success"><i class="fa fa-plus"></i> Add</button>
              </div>
              <div class="col-xs-2" id="module2">
                  <button class="btn btn-sm btn-default disabled"><i class="fa fa-plus"></i> Empty</button>
              </div>
              <div class="col-xs-2" id="module3">
                  <button class="btn btn-sm btn-default disabled"><i class="fa fa-plus"></i> Empty</button>
              </div>
              <div class="col-xs-2" id="module4">
                  <button class="btn btn-sm btn-default disabled"><i class="fa fa-plus"></i> Empty</button>
              </div>
              <div class="col-xs-2" id="module5">
                  <button class="btn btn-sm btn-default disabled"><i class="fa fa-plus"></i> Empty</button>
              </div>
              <div class="col-xs-2" id="module6">
                  <button class="btn btn-sm btn-default disabled"><i class="fa fa-plus"></i> Empty</button>
              </div>
</div>
<% } %>