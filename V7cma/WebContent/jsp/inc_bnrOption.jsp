<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.util.logger.cmaLogger" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="org.apache.commons.lang.*" %>
[
<%
ArrayList<String[]> aList = (ArrayList<String[]>)request.getAttribute("optionList");
cmaLogger.debug("OPTION list size:"+ aList.size());
if(aList!=null){
	Iterator it = aList.iterator();
	while(it.hasNext()){
		String[] atmp = (String[])it.next();	
		out.print("{\"optionValue\":\""+ atmp[0]+ "\",\"optionDisplay\": \""+ StringEscapeUtils.escapeHtml(atmp[1])+"\"}");
		if(it.hasNext()) out.println(",");
	}
}
%>
]