<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.Member" %>
<%@ page import="com.imagsky.common.ImagskySession" %>
<%@ page import="com.imagsky.v6.cma.constants.SystemConstants" %>
<%@ page import="com.imagsky.v6.cma.constants.PropertiesConstants" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG); %>
<%    
String staticPath = PropertiesConstants.get(PropertiesConstants.staticContextRoot);
Member mem = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
Member shop = (Member)request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
boolean isPublic = CommonUtil.null2Empty(request.getAttribute(SystemConstants.PUB_FLG)).equalsIgnoreCase("Y");
String userImagePath = "";
String nodeBanner = (String)request.getAttribute("NODE_BANNER");
String sysBanner = SystemConstants.SYSTEM_BANNER_PREFIX 
	+ (String)request.getAttribute(SystemConstants.REQ_ATTR_APPCODE) 
	+ (CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_ACTION))?"":"_"+(String)request.getAttribute(SystemConstants.REQ_ATTR_ACTION));
if(CommonUtil.isNullOrEmpty(MessageUtil.getMessage(MessageUtil.MOD_V6, lang, sysBanner, false))){
	sysBanner = SystemConstants.SYSTEM_BANNER_PREFIX 
	+ (String)request.getAttribute(SystemConstants.REQ_ATTR_APPCODE);
}

//ARTICLE BANNER DISPATCHED BY TYPE : 20110815
 
if(request.getAttribute(SystemConstants.REQ_ATTR_OBJ) instanceof Article){
	Article thisArti = (Article)request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
	if(!CommonUtil.isNullOrEmpty(thisArti.getArti_type())){
		nodeBanner = MessageUtil.getV6Message(lang, "ARTI_PRESET_BANNER_"+thisArti.getArti_type());	
	}
	
}


if(!CommonUtil.isNullOrEmpty(nodeBanner)){
	userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/";%>
	<div id="hdrBanner"> <img class="bannerImg" src="<%=userImagePath %>/<%=nodeBanner %>" alt="Banner Image" width="699"/>
		<div class="bannerMsg"></div>
	</div>
<% } else if(isPublic && !CommonUtil.isNullOrEmpty(shop.getMem_shopbanner())){
	userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/";%>
	<div id="hdrBanner"> <img class="bannerImg" src="<%=userImagePath %>/<%=shop.getMem_shopbanner() %>" alt="Banner Image" />
		<div class="bannerMsg"></div>
	</div>
<% } else if(isPublic && CommonUtil.isNullOrEmpty(shop.getMem_shopbanner())){%>
	<div id="hdrBanner"> <img class="bannerImg" src="<%=staticPath %>/images/banner_about.jpg" alt="Banner Image" width="699"/>
		<div class="bannerMsg"></div>
	</div>
<% } else if(!CommonUtil.isNullOrEmpty(MessageUtil.getMessage(MessageUtil.MOD_V6, lang, sysBanner, false))){ 
		String[] tokens = CommonUtil.stringTokenize(MessageUtil.getMessage(MessageUtil.MOD_V6, lang, sysBanner, false),"|");
		//System.out.println("--- tokens " + MessageUtil.getMessage(MessageUtil.MOD_V6, lang, sysBanner, false) + " " + tokens.length);
%>
	<div id="hdrBanner"> <img class="bannerImg" src="<%=staticPath %>/images/<%=tokens[0] %>" alt="<%=tokens[1] %>" width="699"/>
		<div class="bannerMsg" style="font-size:160%;color:#444444"><strong></strong></div>
	</div>
<% } else if (mem!=null && CommonUtil.isNullOrEmpty(mem.getMem_shopbanner())){%>
	<div id="hdrBanner"> <img class="bannerImg" src="<%=staticPath %>/images/noBanner.jpg" alt="No Main Site Banner" width="699"/>
		<div class="bannerMsg"></div>
	</div>
<% } else  if (mem!=null && !CommonUtil.isNullOrEmpty(mem.getMem_shopbanner())){
	userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/";%>
	<div id="hdrBanner"> <img class="bannerImg" src="<%=userImagePath %>/<%=mem.getMem_shopbanner() %>" alt="Banner Image" />
		<div class="bannerMsg"></div>
	</div>		
<% } else {%>
	<div id="hdrBanner"> <img class="bannerImg" src="<%=staticPath %>/images/banner_about.jpg" alt="Banner Image" width="699"/>
		<div class="bannerMsg"></div>
	</div>
<% } %>