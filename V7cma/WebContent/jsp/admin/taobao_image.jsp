<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.imagsky.util.*"%>
<%
String step = CommonUtil.null2Empty(request.getParameter("step"));
if(step.equalsIgnoreCase("crawl_1")){
	request.getSession().removeAttribute("obj");
	AlibabaProductUtil a = new AlibabaProductUtil(request.getParameter("product_url"),request.getParameter("proxy_url"));
	%>
	<script>
		function checkCode(){
			alert(document.getElementById('bbm_code').value().length());
			/***
			if(document.getElementById('bbm_code').value()==''){
				alert("Empty Code!");
				document.getElementById('bbm_code').focus();
				return false;
			} else {
				return true;
			}***/
			return false;
		}
	</script>
	<form action="ali_image.jsp" method="post">
	BuyBuymeat Code:<input type="text" name="bbm_code" value=""/><br/>
	Local Folder<input type="text" name="base_path" value="c:/BO"/><br/>
	<input type="hidden" name="step" value="crawl_2"/>
	<%
	out.println("<pre>"+a.getBasicInfo().replaceAll("hidden","text")+"</pre>");
	int x =0;
	for(Object tmp : a.getImageURL().toArray()){
		out.println("<img src=\""+(String)(tmp)+"\" width=\"150px\"><input type=\"text\" size=\"1\" name=\"img"+(x++)+"\"><BR/>");
		out.println("<hr width=\"80%\"><br/>");
	}
	%><input type="submit" onclick="checkCode();"/></form><%
	request.getSession().setAttribute("obj", a);
} else if(step.equalsIgnoreCase("crawl_2")){
	AlibabaProductUtil a = (AlibabaProductUtil)request.getSession().getAttribute("obj");
	ArrayList<String> saveImageLink = new ArrayList<String>();
	TreeMap<Integer, String> t = new TreeMap<Integer, String>();
	for(int x = 0; x < a.getImageURL().size(); x++){
		if(!CommonUtil.isNullOrEmpty(request.getParameter("img"+x))){
			t.put(new Integer(request.getParameter("img"+x)),a.getImageURL().get(x));
		} else {
			t.put(new Integer(99+x),a.getImageURL().get(x));
		}
	}
	out.println(t.toString());
	Iterator<Integer> it = t.keySet().iterator();
	while(it.hasNext()){
		saveImageLink.add(t.get((Integer)it.next()));
	}
	out.println(saveImageLink.toString());
	AlibabaProductUtil.saveImage(request.getParameter("bbm_code"), request.getParameter("base_path"),
			saveImageLink);
} else {
%>
<form action="ali_image.jsp" method="post">
<input type="hidden" name="step" value="crawl_1"/>
Local PHP Proxy:<input type="text" name="proxy_url" value="http://192.168.1.200/files/ali_image.php"/><br/>    
Taobao Product Detail Link:<input type="text" name="product_url"/><br/>
<input type="submit"/>
</form>
<% } %>