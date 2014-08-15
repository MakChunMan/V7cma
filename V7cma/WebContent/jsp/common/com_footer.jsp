<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG); %>
<div class="links"> 
<a href="/main/contactus.do" ><%=MessageUtil.getV6Message(lang,"COMMON_FT_CONTACT") %></a> | 
<a href="/main/pledge.do" ><%=MessageUtil.getV6Message(lang,"COMMON_FT_PLEDGE") %></a> | 
<a href="/main/faq.do" ><%=MessageUtil.getV6Message(lang,"COMMON_FT_FAQ") %></a> |  
<a href="/main/terms.do" ><%=MessageUtil.getV6Message(lang,"COMMON_FT_T&C") %></a> | 
<a href="/main/privacy.do" ><%=MessageUtil.getV6Message(lang,"COMMON_FT_PRIVACY") %></a> | 
<a href="/main/disclaimer.do" ><%=MessageUtil.getV6Message(lang,"COMMON_FT_DISCM") %></a> | 
<a href="/main/sitemap.do" ><%=MessageUtil.getV6Message(lang,"COMMON_FT_SITEMAP") %></a> | 
<%--<a href="/main/help.do" ><%=MessageUtil.getV6Message(lang,"COMMON_FT_HELP") %>Help</a> --%> 
</div> 
<div class="copyright"><%=MessageUtil.getV6Message(lang,"COMMON_FOOTER_CR") %></div>
<script>
$(function() {
$('#link_joinnow')
.click(function(){
	$.ajax({  
            url: "<%=request.getAttribute("contextPath") %>/jsp/register.jsp?<%=SystemConstants.REQ_ATTR_LANG%>=<%=request.getAttribute(SystemConstants.REQ_ATTR_LANG)%>&c="+new Date().getTime(),   
            type: "POST",  
            cache: false,  
            success: function (html) {
           	 $("#loadform").html(html);
           	 $('#dialog-form').dialog('open');          
            }         
 	}); 
});	
});

(function() {
    var e = document.createElement('script');
    e.type = 'text/javascript';
    e.src = document.location.protocol +
        '//connect.facebook.net/zh_HK/all.js';
    e.async = true;
    if(document.getElementById('fb-root')){
        document.getElementById('fb-root').appendChild(e);
    }
}());
</script>
<%
long requestEnd = System.currentTimeMillis();
Long requestStart = (Long)request.getSession().getAttribute("P_TIMER");
if(requestStart!=null){
	cmaLogger.info("[PERFORM] "+ (requestEnd-requestStart.longValue()) + "ms"+
		"|"+
		request.getAttribute("fullRequestURL"),request);
	request.getSession().removeAttribute("P_TIMER");
}
%>
