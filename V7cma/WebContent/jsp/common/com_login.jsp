<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@include file="/init.jsp" %>
<%--PLACED IN FOOTER <script src="<%=CommonUtil.getHttpProtocal(request) %>connect.facebook.net/zh_HK/all.js"></script>--%>
<%    
Member mem = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
if(mem==null){
%>
<div id="main_login">
	<div style="position:relative;left:45px;top:22px;">
	<a id="fb_connect_link" href="#" onclick="facebook_requestSession();" >
	  <img id="fb_login_image" src="<%=staticPath %>/images/facebook.png" alt="Connect" border="0"/></a>
	<br/>
	<a href="javascript:showHelp();" class="bulletLink"><%=MessageUtil.getV6Message(lang,"COMMON_FB_BTN_HELP") %></a>
	<div id="fb_connect_msg" style="color:#888888;display:none"><%=MessageUtil.getV6Message(lang, "COMMON_FB_CONNECT") %> <img src="<%=staticPath %>/images/ajax-loader.gif"/></div>
	</div>
<script>
        function facebook_requestSession() 
        {
            var loginurl = '<%=PropertiesConstants.get(PropertiesConstants.fb_tokenurl)
            .replaceAll("@@1@@",PropertiesConstants.get(PropertiesConstants.fb_appid))
            .replaceAll("@@2@@",URLEncoder.encode((String)request.getAttribute("fullRequestURLQueryString"),"UTF-8"))%>&locale=zh_HK';
			self.location = loginurl;
			$('#fb_connect_msg').css("display","");
        }
        function showHelp(){
	        $( "#fb-help-modal" ).dialog({
				height: 200, width: 640, modal: true
			});
			$("#fb-help-modal").show();
        }
</script>
</div>
<form id="fb_login" style="display:none">
<input type="hidden" name="fb_id" id="fb_id"/>
<input type="hidden" name="fb_email" id="fb_email"/>
<input type="hidden" name="fb_name" id="fb_name"/>
<input type="hidden" name="fb_firstname" id="fb_firstname"/>
<input type="hidden" name="fb_lastname" id="fb_lastname"/>
<input type="hidden" name="fb_profile_url" id="fb_profile_url"/>
<input type="hidden" name="fb_accesstoken" id="fb_accesstoken"/>
</form>
<div id="fb-help-modal" title='<%=MessageUtil.getV6Message(lang,"COMMON_FB_BTN_HELP") %>' style="display:none;font-size:70%">
<%=MessageUtil.getV6Message(lang,"COMMON_FB_BTN_HELP_MSG") %></div>
<form id="bbm_login" style="display:none;color:#666666" action="<%=request.getAttribute("contextPath") %>/do/LOGIN?action=LOGIN" method="post">
	<input type="hidden" name="action" value="LOGIN"/>
	<table class="tbl_transparent">
		<tr>
			<td colspan="2"><label for="txtMbrID"><%=MessageUtil.getV6Message(lang, "PRF_EMAIL") %></label>
				<input  name="txtMbrID" id="txtMbrID" type="text" title="" class="text" />
			</td>
		</tr>
		<tr>
			<td colspan="2"><label for="txtMbrPIN"><%=MessageUtil.getV6Message(lang,"PRF_PASSWORD") %></label>
				<input  name="txtMbrPIN" id="txtMbrPIN" type="password"  title="Enter your PIN here" class="text" />
			</td>
		</tr>
		<tr>
			<td>&nbsp;
			</td>
			<td><div><%=MessageUtil.getV6Message(lang,"PRF_MSG1")%> <a href="#" id="link_joinnow">
				<strong><%=MessageUtil.getV6Message(lang,"PRF_MSG2")%></strong></a>
				<input type="button" value="<%=MessageUtil.getV6Message(lang,"BUT_BACK") %>" onclick="resume()" class="btnGeneric"/>
				<input type="submit" name="btn_login" id="btn_login" value="<%=MessageUtil.getV6Message(lang,"COUT_LOGIN") %>" class="btnGeneric"/>
				</div>
				<a href="<%=request.getAttribute("contextPath")%>/do/LOGIN?action=FPWD"><%=MessageUtil.getV6Message(lang,"TIT_FORGETPWD") %></a><br/>
			</td>
		</tr>
	</table>
</form>
<Script>
function resume(){
	$('#bbm_login').hide();
	$('#main_login').show()
}
</Script>
<% } else { %>
<form>
<table class="tbl_transparent" style="color:#666666" border="0">
<tr><td><%=MessageUtil.getV6Message(lang,"PRF_WELCOME")+ " " + mem.getMem_display_name() %>
<%-- if(CommonUtil.isNullOrEmpty(mem.getMem_shopname()) || 
		CommonUtil.isNullOrEmpty(mem.getMem_shopurl())){
	if(CommonUtil.isNullOrEmpty(mem.getMem_firstname())){
		out.println( mem.getMem_lastname());
	} else {
		out.println(mem.getMem_firstname() + "," + mem.getMem_lastname());
	}
} else {
	out.println(CommonUtil.null2Empty(mem.getMem_shopname())+ " " + MessageUtil.getV6Message(lang,"PRF_SHOPKEEPER")); 
} --%>
</td></tr>
<tr><td align="right">
<div style="float:left;position:relative;top:10px"><%=MessageUtil.getV6Message(lang,"PRF_FEEDBACK_POINT") %> (<%=""+ CommonUtil.null2Zero(mem.getMem_feedback()) %>)</div>
<div style="float:right;position:relative;top:10px"><a href="<%=request.getAttribute("contextPath") %>/do/LOGIN?action=LOGOUT" id="link_logout">
<%=MessageUtil.getV6Message(lang,"BUT_LOGOUT") %></a></div></td></tr>
<% if(CommonUtil.isNullOrEmpty(mem.getMem_firstname()) && CommonUtil.isNullOrEmpty(mem.getMem_lastname())){ %>
<tr><td><br/>
# <%=MessageUtil.getV6Message(lang,"PRF_ASKINFO") %>
</td></tr>
<% } %>
</table>
</form>
<% } %>
<script>
        if(window.location.hash.length != 0){
        	$('#fb_connect_msg').css("display","");
        	accessToken = window.location.hash.substring(1);
        	graphUrl = "<%=PropertiesConstants.get(PropertiesConstants.fb_graph)%>me?action=SIGNIN&"+accessToken+"&callback=fbUser";
			$('#fb_accesstoken').val(accessToken);
			var script = document.createElement("script");
	         script.src = graphUrl;
	         document.body.appendChild(script);
        }

        function fbUser(user) {
            $('#fb_id').val(user.id);
            $('#fb_email').val(user.email);
            $('#fb_name').val(user.name);
            $('#fb_firstname').val(user.first_name);
            $('#fb_lastname').val(user.last_name);
            $('#fb_profile_url').val(user.link);
            $.ajax({  
            	 url: "<%=request.getAttribute("contextPath") %>/do/LOGIN?action=FBLOGIN&c="+new Date().getTime(),   
	             type: "POST",  
	             cache: false,  
	             data: $("#fb_login").serialize(),
	             success: function (html) {                
	            	 $(".login_form").html(html);
	            	 if($('#FB_REDIRECT_FLG').length>0){
	            		 location.reload(true);	 
	            	 }
	             }         
	   	     }); 
        }
</script>