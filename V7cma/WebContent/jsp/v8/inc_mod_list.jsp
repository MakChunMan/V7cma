<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.imagsky.v8.constants.*" %>
 <%@ page import="com.imagsky.common.*" %>
 <%@ page import="com.imagsky.v6.cma.constants.*" %>
 <%@ page import="com.imagsky.v6.domain.Member" %>
 <%@ page import="com.imagsky.util.*" %>
 <%@ page import="com.imagsky.v8.domain.App" %>
 <%@ page import="com.imagsky.v8.domain.Module" %>
 <%@ page import="java.util.*" %>
 <% 
 String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
 Member thisUser = null;
 App thisApp = null;
 Module thisModule = null;
 ArrayList al = null;
 boolean isCurrentFirst = true;
 if(!V6Util.isLogined(request)){
     out.println("<script>self.location='/v81/zh/page_ready_login.php';</script>");
 } else {
     thisUser = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
     thisApp = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getWorkingApp();
 %>
<div class="row block-section">
<% for (int x =0 ; x < 6 ;x++){ 
                       if(thisApp.getModules()!=null && thisApp.getModules().size()>x){
                    	    if(al==null) al = new ArrayList(thisApp.getModules());                    	   
                    	   thisModule = (Module)al.get(x);
                    	   out.println(ModuleTemplateUIConstants.getUIHtml_modListPage(thisModule.getModuleTypeName()));
                       } else if(isCurrentFirst){
                    	    isCurrentFirst = false;
                       %>
                    	<div class="col-xs-2" id="module<%=(x+1)%>">
                            <button class="btn btn-lg btn-success" onClick="javascript:$('#moduleTemplateRow').show();$('#moduleEditRow').hide();return false;"><i class="fa fa-plus"></i> Add</button>
                        </div>
                 <% } else { %>
                        <div class="col-xs-2" id="module<%=(x+1)%>">
                            <button class="btn btn-sm btn-default disabled"><i class="fa fa-plus"></i> Empty</button>
                        </div>    	   
                <%  } %>       
<% } %>
</div>
<div class="block-section" id="block_save_btn" style="display:none">
          <button type="button" class="btn btn-block btn-primary">Save Button</button>
</div>

<% } %>