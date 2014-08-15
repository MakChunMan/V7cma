<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>
<%
    boolean isHTTPS = false;
    String file = CommonUtil.getHttpServerHost(request, isHTTPS)
            + PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + request.getAttribute(SystemConstants.REQ_ATTR_URL);
    cmaLogger.debug("CACHE:" + file);

    /**
     * *
     * response.setStatus(301); response.setHeader( "Location",
     * CommonUtil.getHttpServerHost(request, isHTTPS) +
     * PropertiesConstants.get(PropertiesConstants.uploadContextRoot) +
     * request.getAttribute(SystemConstants.REQ_ATTR_URL) ); response.setHeader(
     * "Connection", "close" );
**
     */
    try {
%>
<c:import url="<%=file%>"  charEncoding="UTF-8"/>
<%
} catch (Exception e) {
    cmaLogger.error("Error tlp_cache.jsp", e);
%>
<script>
    $.ajax({  
        url: "/files/export_sellitem.php?v=<%=CommonUtil.null2Empty(request.getParameter("v")) + "&boid=" + CommonUtil.null2Empty(request.getParameter("boid"))%>",
        type: "GET",  
        cache: false,  
        success: function (html) {                
            self.location="<%=request.getAttribute("fullRequestURL") + "&regen=Y"%>";
        }         
    });  
</script>
<%}
    long requestEnd = System.currentTimeMillis();
    Long requestStart = (Long) request.getSession().getAttribute("P_TIMER");
    if (requestStart != null) {
        cmaLogger.info("[PERFORM] " + (requestEnd - requestStart.longValue()) + "ms"
                + "|"
                + request.getAttribute("fullRequestURL") + "|CACHED", request);
        request.getSession().removeAttribute("P_TIMER");
    }
%>
</html>