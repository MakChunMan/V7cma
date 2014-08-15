<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%
final String path = "C:/t-select/";
final String target = "http://t-select.livedoor.com/shirts/up_1/jpg/";
final String ext = ".jpg";

Integer x = (request.getParameter("id")!=null)?new Integer(request.getParameter("id")):new Integer("1");
out.println(target+x+ext+"<br/>");
out.println(path+x+ext+"<br/>");
cmaLogger.debug("1");
boolean isDownloaded = HttpClientUtil.httpRequestBinaryDownload(target+x+ext,path+x+ext);
if(isDownloaded){
		out.println(x + " is downloaded");
}
%>
<html>

<head>
<script>
	function go(){
		self.location="http://192.168.1.200/jsp/admin/t-select.jsp?id=<%=++x%>";
	}
	setTimeout("go();",3000);
</script>
</head>
<body>
</body>
</html>