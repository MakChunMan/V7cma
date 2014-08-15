<%@page import="com.imagsky.v6.cma.constants.SystemConstants"%>
<%@page import="com.imagsky.util.CommonUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%=CommonUtil.null2Empty(request.getAttribute(SystemConstants.REQ_ATTR_JSONDATA))%>