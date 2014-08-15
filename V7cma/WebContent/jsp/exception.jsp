<%@ page isErrorPage="true" %>
<%@ page import="com.imagsky.util.logger.*"%>
<% 
cmaLogger.error(exception.getMessage());
exception.printStackTrace(response.getWriter()); %>