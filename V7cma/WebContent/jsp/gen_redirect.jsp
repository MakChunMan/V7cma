<% if(request.getAttribute("redirectURL")!=null ){%>
<script>self.location='<%=(String)request.getAttribute("redirectURL")%>';</script>
<% } %>