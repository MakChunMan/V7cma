package com.imagsky.v6.cma.servlet.handler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;


import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.persistence.config.SystemProperties;

import com.imagsky.v6.dao.ArticleDAO;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.dao.NodeDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.Node;
import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.util.logger.*;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.JPAUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;
import com.imagsky.util.*;

public class ARTI_Handler  extends BaseHandler {

	public static final String DO_ARTI_LIST = "LIST";
	public static final String DO_ARTI_LIST_AJ = "LISTAJ";
	public static final String DO_ARTI_ADD = "ADD";
	public static final String DO_ARTI_ADD_AJ = "ADDAJ";
	public static final String DO_ARTI_EDIT_AJ = "EDITAJ";
	public static final String DO_ARTI_DEL_AJ = "DELAJ";
	public static final String DO_ARTI_SAVE = "SAVE";
	public static final String DO_ARTI_SAVE_ORDER = "SAVE_ORDER";
	
	public static final String DO_ARTI_SAVE_EXPORT_INFO_AJ = "SAVE_EXPAJ";
	
	public static final String DO_ARTI_SLIDE = "SLIDE_AJ";
	public static final String DO_ARTI_TOPNAV = "TOPNAV_AJ";
	public static final String DO_ARTI_SUBNAV = "SUBNAV_AJ";
	
	protected static final String CLASS_NAME = "ARTI_Handler.java";
	
	private Member thisMember = null;
	private String thisLang = null;
	
	private String action = null;
	
	/* (non-Javadoc)
	 * @see com.asiamiles.website.handler.Action#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);		
		
		action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));
		
		cmaLogger.debug("Action = "+ action);
		
		thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
		thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
		
		if(action.equalsIgnoreCase(DO_ARTI_LIST)){
			thisResp = doList(request, response, false);
		} else if(action.equalsIgnoreCase(DO_ARTI_LIST_AJ)){
			thisResp = doList(request, response, true);
		} else if(action.equalsIgnoreCase(DO_ARTI_ADD)){
			thisResp = showAdd(request, response, false);
		} else if(action.equalsIgnoreCase(DO_ARTI_ADD_AJ)){
			thisResp = showAdd(request, response, true);
		} else if(action.equalsIgnoreCase(DO_ARTI_EDIT_AJ)){
			thisResp = showAdd(request, response, true);			
		} else if(action.equalsIgnoreCase(DO_ARTI_SAVE)){
			thisResp = doSave(request, response);
		} else if(action.equalsIgnoreCase(DO_ARTI_SAVE_ORDER)){
			thisResp = doSaveOrder(request, response);
		} else if(action.equalsIgnoreCase(DO_ARTI_DEL_AJ)){
			thisResp = doDel(request, response);
		} else if(action.equalsIgnoreCase(DO_ARTI_SLIDE)){
			thisResp = doList(request, response, true);
		} else if(action.equalsIgnoreCase(DO_ARTI_TOPNAV)){
			thisResp = doList(request, response, true);			
		} else if(action.equalsIgnoreCase(DO_ARTI_SUBNAV)){
			thisResp = doList(request, response, true);
		} else if(action.equalsIgnoreCase(DO_ARTI_SAVE_EXPORT_INFO_AJ)){
			thisResp = doUpdateExportInfo(request, response, true);			
		} else {
			thisResp = doList(request, response, false); //Default
		}
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}
	
	private SiteResponse doUpdateExportInfo(HttpServletRequest request,
			HttpServletResponse response, boolean b) {
		
		SiteResponse thisResp = super.createResponse();
		if(!CommonUtil.isNullOrEmpty(request.getParameter("guid"))){
			try{
				ArticleDAO dao = ArticleDAO.getInstance();
				Article article = new Article();
				article.setSys_guid(request.getParameter("guid"));
				cmaLogger.debug("doUpdateExportInfo guid:"+ article.getSys_guid());
				article.setArti_exp_file(request.getParameter("expfile")); //eg. /20110810/21.htm
				cmaLogger.debug("doUpdateExportInfo exp_file:"+ article.getArti_exp_file());
				article.setArti_exp_date(new Date());
				dao.updateExportInfo(article);
				
				NodeDAO ndao = NodeDAO.getInstance();
				Node node = new Node();
				node.setNod_contentGuid(article.getSys_guid());
				node  = (Node)ndao.findListWithSample(node).get(0);
				
				node.setNod_cacheurl("/"+ MessageUtil.getV6Message(thisLang, "NODE_URL_"+ request.getParameter("arti_type")) + request.getParameter("expfile"));
				ndao.update(node);
				
			} catch (Exception e){
				cmaLogger.error("ARTI_Handler.doUpdateExportInfo ERROR: ", request, e);
				//thisResp.addErrorMsg(new SiteErrorMessage("ARTI_DEL_ERROR"));
			}
		}
		return thisResp; //Should be no result page
	}

	private SiteResponse doDel(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		if(!CommonUtil.isNullOrEmpty(request.getParameter("guid"))){
			try{
				ArticleDAO dao = ArticleDAO.getInstance();
				dao.delete(request.getParameter("guid"));
				request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
				"ARTI_DEL_DONE"));
				V6Util.disassociate(request.getParameter("guid"), thisMember);
				
				//Update if it is homepage article
				if(request.getParameter("guid").equalsIgnoreCase(thisMember.getMem_shop_hp_arti())){
					MemberDAO mDAO = MemberDAO.getInstance();
					thisMember.setMem_shop_hp_arti("");
					mDAO.update(thisMember);
					((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).setUser(thisMember);
				}
			}catch (Exception e){
				cmaLogger.error("ARTI_Handler.doDel ERROR: ", request, e);
				thisResp.addErrorMsg(new SiteErrorMessage("ARTI_DEL_ERROR"));
			}
		} else {
			cmaLogger.error("ARTI_Handler.doDel ERROR: NO GUID for DEL");
			thisResp.addErrorMsg(new SiteErrorMessage("ARTI_DEL_ERROR"));
		}
		thisResp = doList(request, response, true, true);
		return thisResp;
	}

	private SiteResponse doSaveOrder(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		String[] guids = null;
		if(!CommonUtil.isNullOrEmpty(request.getParameter("guids"))){
			guids = CommonUtil.stringTokenize(request.getParameter("guids"), ",");
			try{
				ArticleDAO dao = ArticleDAO.getInstance();
				dao.updatePriority(guids);
			} catch (Exception e){
				thisResp.addErrorMsg(new SiteErrorMessage("ARTI_SAVE_ORDER_ERROR"));
			}
		} else {
			thisResp.addErrorMsg(new SiteErrorMessage("ARTI_SAVE_ORDER_ERROR"));
		}
		
		if(!thisResp.hasError()){
			request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
			"ARTI_SAVE_DONE"));
		}
		thisResp = doList(request, response, true);
		return thisResp;
	}

	private SiteResponse doSave(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		
		boolean isAdd = CommonUtil.isNullOrEmpty(request.getParameter("ARTI_GUID"));
		Node thisNode = null;
		
		InputParams inReq = new InputParams(request);
		
		Article arti = new Article();
		arti.setSys_guid(inReq.get("ARTI_GUID"));
		arti.setArti_lang(inReq.get("ARTI_LANG"));
		arti.setArti_name(inReq.get("ARTI_NAME"));
		//if(!CommonUtil.isNullOrEmpty(inReq.get("ARTI_TYPE"))){
			arti.setArti_type(inReq.get("ARTI_TYPE"));
		//}
		arti.setArti_isTopNav(!CommonUtil.isNullOrEmpty(inReq.get("ARTI_IS_TOPNAV")));
		arti.setArti_isSubNav(!CommonUtil.isNullOrEmpty(inReq.get("ARTI_IS_SUBNAV")));
		arti.setArti_isHighlightSection(!CommonUtil.isNullOrEmpty(inReq.get("ARTI_IS_HIGHLIGHT")));
		arti.setArti_content(inReq.get("ARTI_CONTENT"));
		arti.setSys_update_dt(new Date());
		arti.setSys_updator(thisMember.getMem_login_email());
		
		if(arti.isArti_isSubNav()){
			arti.setArti_parent_guid(CommonUtil.null2Empty(inReq.get("ARTI_PARENT_GUID"))); //TODO: Single level at this stage
			if(CommonUtil.isNullOrEmpty(arti.getArti_parent_guid())){
				thisResp.addErrorMsg(new SiteErrorMessage("ARTI_CHOOSE_PARENT_ARTI"));
			}
		} else {
			arti.setArti_parent_guid(null);
		}

		if(CommonUtil.isNullOrEmpty(arti.getArti_name())){
			thisResp.addErrorMsg(new SiteErrorMessage("ARTI_NAME_EMPTY"));
		}
		
		/*
		if(!arti.isArti_isHighlightSection() && 
				!arti.isArti_isSubNav() &&
				!arti.isArti_isTopNav()){
			thisResp.addErrorMsg(new SiteErrorMessage("ARTI_MUST_CHOOSE_LOCATION"));
		}*/
		
		if(!thisResp.hasError()){
			ArticleDAO dao = ArticleDAO.getInstance();
			Article returnObj = null;
			try{
				if(isAdd){
					//Save Add
					arti.setSys_cma_name(arti.getArti_name() + " (" + arti.getArti_lang() + ")");
					arti.setSys_create_dt(new Date());
					arti.setSys_creator(thisMember.getMem_login_email());
					arti.setArti_owner(thisMember.getSys_guid());
					//Default content setting
					arti.setSys_is_live(true);
					arti.setSys_is_node(false);
					arti.setSys_is_published(true);

					returnObj = (Article)dao.create(arti);
					//URL
					String nodeUrl = null;
					if(!CommonUtil.isNullOrEmpty(request.getParameter("NODE_URL"))){
						nodeUrl = "/" + CommonUtil.formatDate(new java.util.Date(), "MMdd") + "-" + request.getParameter("NODE_URL") + ".do";
					}
					//Keyword / Description
					String[] keywordDescription = new String[2];
					if(request.getParameter("nod_keyword")!=null){
						if(!CommonUtil.isNullOrEmpty(CommonUtil.escape(request.getParameter("nod_keyword")))){
							keywordDescription[0] = CommonUtil.escape(request.getParameter("nod_keyword"));
						}
						if(!CommonUtil.isNullOrEmpty(CommonUtil.escape(request.getParameter("nod_description")))){
							keywordDescription[1] = CommonUtil.escape(request.getParameter("nod_description"));
						}
					} 
					thisNode = V6Util.autoAssociate(returnObj,thisMember, keywordDescription, nodeUrl); //Auto Assoication
					
				} else {
					//Save Edit
					arti.setSys_cma_name(arti.getArti_name() + " (" + arti.getArti_lang() + ")");
					//Default content setting
					arti.setSys_is_live(true);
					arti.setSys_is_node(false);
					arti.setSys_is_published(true);
					if(!dao.update(arti)){
						thisResp.addErrorMsg(new SiteErrorMessage("ARTI_UDPATE_ERROR"));
					} else if(request.getParameter("nod_keyword")!=null){
						cmaLogger.debug("Save keyword" + arti.getSys_guid());
						//Update keyword / description
						NodeDAO ndao = NodeDAO.getInstance();
						ArrayList<Object> aList = new ArrayList<Object>();
						aList.add(arti);
						Map nodeMap = ndao.findNodeListWithSample(aList, SystemConstants.NODMAP_KEY_C_GUID);
						if(nodeMap!=null && nodeMap.get(arti.getSys_guid())!=null){
							cmaLogger.debug("Node Found");
							Node aNode = (Node)nodeMap.get(arti.getSys_guid());
							thisNode = aNode;
							if(!CommonUtil.isNullOrEmpty(CommonUtil.escape(request.getParameter("nod_keyword")))){
								aNode.setNod_keyword(CommonUtil.escape(request.getParameter("nod_keyword")));
							}
							if(!CommonUtil.isNullOrEmpty(CommonUtil.escape(request.getParameter("nod_description")))){
								aNode.setNod_description(CommonUtil.escape(request.getParameter("nod_description")));
							}
							ndao.update(aNode);
						}
					}
					returnObj = arti;
				}
			} catch (Exception e){
				cmaLogger.error("ARTI_Handler.doSave Exception", e);
			}
			request.setAttribute("THIS_OBJ", returnObj);
		}
		
		if(thisResp.hasError()){
			List errorList = thisResp.getErrorMsgList();
			request.setAttribute("guid", arti.getSys_guid());
			thisResp = showAdd(request, response, true);
			request.setAttribute("THIS_OBJ", arti);
			thisResp.addErrorMsg(errorList);
		} else {
			if("J".equalsIgnoreCase(arti.getArti_type())){
					request.setAttribute("THIS_JETSO_NODE", thisNode);
					if(isAdd){
						request.setAttribute("ISADD","Y"); //FLG to tell popup window to post back to update export file information
					}
			}
			
		}
			thisResp = doList(request, response, true, true);
			request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
			"ARTI_SAVE_DONE"));
			return thisResp;
	}

	private SiteResponse showAdd(HttpServletRequest request,
			HttpServletResponse response, boolean isAjax) {

		SiteResponse thisResp = super.createResponse();
		
		boolean isEdit = !(CommonUtil.isNullOrEmpty(request.getParameter("guid")) && CommonUtil.isNullOrEmpty((String)request.getAttribute("guid")));
		String editGuid = CommonUtil.isNullOrEmpty(request.getParameter("guid"))?(String)request.getAttribute("guid"):request.getParameter("guid");
		
		//Obtain top Nav
		ArticleDAO dao =  ArticleDAO.getInstance();
		Article listEnqObj = new Article();
		listEnqObj.setArti_owner(thisMember.getSys_guid());
		listEnqObj.setArti_isTopNav(true);
/*		listEnqObj.setSys_is_live(true);
		listEnqObj.setSys_is_published(true);*/
		
		StringBuffer selector = new StringBuffer();
		try{
			List<Object> topNavList = dao.findListWithSample(listEnqObj);
			Article tmpObj = null;
			if(topNavList!=null && topNavList.size()>0){
				for (int x= 0; x< topNavList.size(); x++){
					tmpObj = ((Article)topNavList.get(x));
					selector.append("<option value=\""+tmpObj.getSys_guid()+"\">"+tmpObj.getArti_name()+"</option>\n");
				}
			}
			request.setAttribute("TOPNAV_OPTIONS", selector.toString());
		} catch (Exception e){
			cmaLogger.error("ARTI_HANDLER.showAdd : Fail to obtain top navigation items", request);
			thisResp.addErrorMsg(new SiteErrorMessage("ARTI_OBTAIN_TOPNAV_ERR"));
		}
		
		
		if(isEdit){
			try{
				isAjax = true;
				
				Article enqObj = new Article();
				
				enqObj.setSys_guid(editGuid);
				//enqObj.setSys_is_live(true);
				List list = dao.findListWithSample(enqObj);
				if(list==null || list.size()==0){
					cmaLogger.error("ARTI_HANDLER.showAdd : NOT FOUND GUID for edit ("+ enqObj.getSys_guid()+")", request);
					thisResp.addErrorMsg(new SiteErrorMessage("ARTI_NOT_FOUND_FOR_EDIT_ERR"));
				} else {
					request.setAttribute("THIS_OBJ", (Article)list.get(0));
				}
				
				//Node Information
				Node thisNode = new Node();
				NodeDAO nDAO = NodeDAO.getInstance();
				try{
					ArrayList<Object> aList = new ArrayList();
					aList.add(enqObj);
					Map nodemap = nDAO.findNodeListWithSample(aList, SystemConstants.NODMAP_KEY_C_GUID);
					if(nodemap.get(editGuid)!=null){
						request.setAttribute("THIS_NODE", (Node)nodemap.get(editGuid));
					}
				} catch (Exception ne){
					
				}
			} catch (Exception e){
				cmaLogger.error("ARTI_HANDLER.showAdd : NOT FOUND GUID for edit ("+ editGuid+")", request);
				thisResp.addErrorMsg(new SiteErrorMessage("ARTI_NOT_FOUND_FOR_EDIT_ERR"));
			}
			
		}
		
		if(isAjax){
			thisResp.setTargetJSP(CMAJspMapping.JSP_ARTIADD_AJAX);
		} else {
			request.setAttribute(SystemConstants.REQ_ATTR_INC_PAGE, CMAJspMapping.JSP_ARTIADD_AJAX);
			thisResp.setTargetJSP(CMAJspMapping.JSP_ARTI);
		}
		return thisResp;
	}
	
	private  SiteResponse doList(HttpServletRequest request,
			HttpServletResponse response, boolean isAjax, boolean regenerateCache){

		SiteResponse thisResp = super.createResponse();
		ArticleDAO dao = ArticleDAO.getInstance();
		
		try{
			Article enqObj = new Article();
			enqObj.setArti_lang("zh");
			//enqObj.setSys_is_live(true);
			enqObj.setArti_owner(thisMember.getSys_guid());
			
			//FOR MAIN ADMIN ONLY: List Article By Type
			String arti_type_search = request.getParameter("arti_type_search");
			if(!CommonUtil.isNullOrEmpty(arti_type_search)){
				enqObj.setArti_type(request.getParameter("arti_type_search"));
			}
			cmaLogger.debug("arti_type_search:"+arti_type_search);
			List returnList = dao.findListWithSample(enqObj);
			request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, returnList);
			
			if(regenerateCache){
				//Clear cache
				cmaLogger.debug("[START regeneration]");
				NodeDAO ndao = NodeDAO.getInstance();
				Map nodeMap = ndao.findNodeListWithSample(returnList, SystemConstants.NODMAP_KEY_C_GUID);
				generateHighlights(request,
						response, returnList, nodeMap);
				generateNavigator(request,
						response, returnList, nodeMap);
				generateSellItemBreadcrumb(request,
						response, returnList, nodeMap);
				if(request.getAttribute("THIS_JETSO_NODE")!=null){
					generateJetsoPage(request, response, (Node)request.getAttribute("THIS_JETSO_NODE"));
				}
				cmaLogger.debug("[END regeneration]");
				
			}
			cmaLogger.debug("ARTI_Handler.doList = " + returnList.size());
		} catch (Exception e){
			e.printStackTrace();
			cmaLogger.error("ARTI_Handler.doList exception: ", request, e);
		}
		
		if(action.equalsIgnoreCase(DO_ARTI_SLIDE)){
			thisResp.setTargetJSP(CMAJspMapping.JSP_ARTI_SLIDE);
		} else if(action.equalsIgnoreCase(DO_ARTI_SUBNAV)){
			thisResp.setTargetJSP(CMAJspMapping.JSP_ARTI_SUBNAV);			
		} else if(action.equalsIgnoreCase(DO_ARTI_TOPNAV)){
			thisResp.setTargetJSP(CMAJspMapping.JSP_ARTI_TOPNAV);			
		} else if(isAjax){
			thisResp.setTargetJSP(CMAJspMapping.JSP_ARTILIST_AJAX);
		} else {
			request.setAttribute(SystemConstants.REQ_ATTR_INC_PAGE, CMAJspMapping.JSP_ARTILIST_AJAX);
			thisResp.setTargetJSP(CMAJspMapping.JSP_ARTI);
		}
		
		return thisResp;
	}

	private SiteResponse doList(HttpServletRequest request,
			HttpServletResponse response, boolean isAjax) {
		return doList(request, response, isAjax, false);

	}
	
	private void generateJetsoPage(HttpServletRequest request, 
			HttpServletResponse response, Node thisNode) throws Exception{
		
		String postback = "";
		if("Y".equalsIgnoreCase((String)request.getAttribute("ISADD"))){
			postback = "pb=1&"; //Tell popup window to post back to update export information
		} else {
			Article arti = new Article();
			arti.setSys_guid(thisNode.getNod_contentGuid());
			try{
				ArticleDAO aDAO = ArticleDAO.getInstance();
				List aList = aDAO.findListWithSample(arti);
				cmaLogger.debug("ArticleList size:"+ aList.size());
				arti = (Article)aList.get(0);
				if(CommonUtil.isNullOrEmpty(arti.getArti_exp_file())){
					postback = "pb=1&"; //Tell popup window to post back to update export information
				} else {
					postback = "url="+arti.getArti_exp_file() + "&";
				}
			} catch (Exception e){
				cmaLogger.error("Generate Jetso Page Error:" + arti.getSys_guid(), request, e);
			}
			
		}
		StringBuffer sb = new StringBuffer("<script>")
		.append("window.open('")
		.append(CommonUtil.getHttpServerHostWithPort(request))
		.append("/files/export_page.php?type=j&"+postback+"node=")
		.append(thisNode.getNod_url())
		.append("&t="+new Date().getTime()+"&guid="+thisNode.getNod_contentGuid()+"','jetso_export','width=600,height=200,toolbar=no,")
		.append("location=no,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=no');")
		.append("</script>");
		request.setAttribute("JETSO_POPUP", sb.toString());
	}
	
	
	private void generateSellItemBreadcrumb(HttpServletRequest request,
			HttpServletResponse response, List articleList, Map nodeMap){
		
		OutputStreamWriter out = null;
		String url = null;
		Node tmpNode = null;
		
		try{
			String filename = PropertiesConstants.get(PropertiesConstants.uploadDirectory)+ SystemConstants.PATH_COMMON_JSP_ARTI_BREADCRUMB+ thisMember.getSys_guid()+ "_"+thisLang+".jsp";
			
			cmaLogger.debug("BREADCRUMB :"+ filename);

			
			File file = new File(filename);

		    // Create file if it does not exist
		    boolean success = file.createNewFile();
		    if(success)
		    	cmaLogger.info("[ARTI BREADCRUMB] Newly created:"+ filename);
		    
			out = new OutputStreamWriter(
					new FileOutputStream(filename),"UTF-8"); 
					           
			String homepageName = MessageUtil.getV6Message(thisLang, "BRM_HOMEPAGE");
			String homepage = "<li><a href=\\\""+ request.getAttribute("contextPath") +"/" +
				thisMember.getMem_shopurl()+ "/"+ SystemConstants.PUBLIC_SUFFIX + "\\\">"+ homepageName + "</a></li>";
			
			String tmpStr = "";
			
			StringBuffer sb = new StringBuffer("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>");
			sb.append("<%@page import=\"java.util.*\" %>\n");
			sb.append("<% TreeMap artiBreadcrumb = new TreeMap();\n");
			sb.append(" String parentGuid  = request.getParameter(\"guid\");\n");
			Article tmpObj = null;
			if(articleList!=null && articleList.size()> 0){
				for (int x= 0; x< articleList.size(); x++){
					tmpObj = (Article)articleList.get(x);
					tmpNode = (Node)nodeMap.get(tmpObj.getSys_guid());
					if(tmpObj.isSys_is_live() && tmpObj.isSys_is_published()){
						if(!CommonUtil.isNullOrEmpty(tmpObj.getArti_type())){
							//For Special Article Type
							url = request.getAttribute("contextPath")+ "/" + thisMember.getMem_shopurl() + "/doc/"+  MessageUtil.getV6Message(thisLang, "NODE_URL_"+tmpObj.getArti_type())+".do";
							tmpStr = homepage + "<li> &gt; </li>" + "<li><a href=\\\""+ url +"\\\" >"+ MessageUtil.getV6Message(thisLang, "NODE_NAME_"+tmpObj.getArti_type()) +"</a></li>";
							sb.append("artiBreadcrumb.put(\""+tmpObj.getSys_guid()+"\",\"" +
									tmpStr.replaceAll("\"", "\\\"")+"\");\n");
						} else {
							url = request.getAttribute("contextPath")+ "/" + thisMember.getMem_shopurl() + "/doc"+  tmpNode.getNod_url();
							tmpStr = homepage + "<li> &gt; </li>" + "<li><a href=\\\""+ url +"\\\" >"+tmpObj.getArti_name()+"</a></li>";
							sb.append("artiBreadcrumb.put(\""+tmpObj.getSys_guid()+"\",\"" +
									tmpStr.replaceAll("\"", "\\\"")+"\");\n");
						}
					}
				}
			} else {
			}
			sb.append("if((String)artiBreadcrumb.get(parentGuid)!=null){\n");
			sb.append("out.println((String)artiBreadcrumb.get(parentGuid) +  \"<li> &gt; </li>\");\n");
			sb.append("}\n");
			sb.append("%>\n");
			out.write(sb.toString()); 
	        out.flush(); 
	        out.close();
		} catch (Exception e){
			e.printStackTrace();
			cmaLogger.error("ARTI_Handler.generateSellItemBreadcrumb exception: ", request, e);
		}
		
	}
	
	/****
	 * Generate Article List in the sliding highlight region where the article is published and live
	 * @param request
	 * @param response
	 * @param articleList
	 * @param nodeMap
	 */
	private void generateHighlights(HttpServletRequest request,
			HttpServletResponse response, List articleList, Map nodeMap){
		
		//FileWriter highlightFile = null;
		OutputStreamWriter out = null;
				            
		try{
			String filename = PropertiesConstants.get(PropertiesConstants.uploadDirectory)+ SystemConstants.PATH_COMMON_JSP_HIGHLIGHT+ thisMember.getSys_guid()+ "_"+ thisLang + ".jsp";
			cmaLogger.debug("HIGHLIGHT :"+ filename);
			
			File file = new File(filename);

		    // Create file if it does not exist
		    boolean success = file.createNewFile();
		    if(success)
		    	cmaLogger.info("[ARTI HIGHLIGHT] Newly created:"+ filename);
		    
			out = new OutputStreamWriter(
					new FileOutputStream(filename),"UTF-8"); 
			
			StringBuffer sb = new StringBuffer("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>");
			Article tmpObj = null;
			String url = null;
			Node tmpNode = null;
			
			if(articleList!=null && articleList.size()> 0){
				for (int x= 0; x< articleList.size(); x++){
					tmpObj = (Article)articleList.get(x);
					if(tmpObj.isArti_isHighlightSection() && tmpObj.isSys_is_live() && tmpObj.isSys_is_published()){
						tmpNode = (Node)nodeMap.get(tmpObj.getSys_guid());
						cmaLogger.debug("Content GUID : " + tmpObj.getSys_guid()+ ((tmpNode==null)?" Not Found":" Found Node"));
						url = request.getAttribute("contextPath")+ "/" + thisMember.getMem_shopurl() + "/doc"+  tmpNode.getNod_url();
						
						sb.append("<li><a href=\""+ url + "\" >"+tmpObj.getArti_name()+"</a></li>\n");
					}
				}
			}
			out.write(sb.toString()); 
	        out.flush(); 
	        out.close();
		} catch (Exception e){
			e.printStackTrace();
			cmaLogger.error("ARTI_Handler.generateHighlights exception: ", request, e);
		}
		
	}
	
	 

			            
	private void generateNavigator(HttpServletRequest request,
			HttpServletResponse response, List articleList, Map nodeMap){
		
		//FileWriter topNavFile = null;
		//FileWriter subNavFile = null;
		
		OutputStreamWriter topOut = null;
		OutputStreamWriter subOut = null;
		
		Article enqObj = null;
		Article tmpObj = null;
		String url = null;
		Node tmpNode = null;
		
		ArticleDAO dao = ArticleDAO.getInstance();
		NodeDAO ndao = NodeDAO.getInstance();
		try{
			String topfilename = PropertiesConstants.get(PropertiesConstants.uploadDirectory)+ SystemConstants.PATH_COMMON_JSP_TOPNAV+ thisMember.getSys_guid()+ "_"+ thisLang + ".jsp";
			String subfilename = PropertiesConstants.get(PropertiesConstants.uploadDirectory)+ SystemConstants.PATH_COMMON_JSP_SUBNAV+ thisMember.getSys_guid()+ "_"+ thisLang + ".jsp";
			cmaLogger.debug("TOP NAV :"+ topfilename);
			cmaLogger.debug("SUB NAV :"+ subfilename);
			
			File topfile = new File(topfilename);
			File subfile = new File(subfilename);

		    // Create file if it does not exist
		    if(topfile.createNewFile())
		    	cmaLogger.info("[ARTI TOPNAV] Newly created:"+ topfilename);
		    if(subfile.createNewFile())
		    	cmaLogger.info("[ARTI SUBNAV] Newly created:"+ topfilename);
		    
			topOut = new OutputStreamWriter(
					new FileOutputStream(topfilename),"UTF-8");
			
			subOut = new OutputStreamWriter(
					new FileOutputStream(subfilename),"UTF-8"); 			
			
		List subList = null;
		StringBuffer sb = new StringBuffer("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><!--- Generated at "+ new java.util.Date()+"-->");
		StringBuffer sbSub = new StringBuffer("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><!--- Generated at "+ new java.util.Date()+"-->");
		Article tmpSubObj = null;
		Map tmpSubNodeMap = null;
			if(articleList!=null && articleList.size()> 0){
				for (int x= 0; x< articleList.size(); x++){
					tmpObj = (Article)articleList.get(x);
					if(tmpObj.isArti_isTopNav()){
						tmpNode = (Node)nodeMap.get(tmpObj.getSys_guid());
						//20110816 Change relative path to absolute path to eliminate HTTPS
						url = SystemConstants.HTTP + PropertiesConstants.get(PropertiesConstants.externalHost)
							+ request.getAttribute("contextPath")+ "/" + thisMember.getMem_shopurl() + "/doc"+  tmpNode.getNod_url();
						sb.append("<li> | </li>\n");
						sb.append("<li><a href=\""+ url +"\" onmouseover=\"fnMenuShowHolder('nav"+tmpObj.getSys_guid()+"',this);\" onmouseout=\"fnMenuHide();\">"+tmpObj.getArti_name()+"</a></li>\n");
					
						sbSub.append("<div id=\"nav"+tmpObj.getSys_guid()+"\">\n");
						sbSub.append("<ul>\n");
						
						enqObj = new Article();
						enqObj.setArti_lang("zh");
						//enqObj.setSys_is_live(true);
						enqObj.setArti_isSubNav(true);
						enqObj.setArti_owner(thisMember.getSys_guid());
						enqObj.setArti_parent_guid(tmpObj.getSys_guid());
						
						subList = dao.findListWithSample(enqObj);
						tmpSubNodeMap = ndao.findNodeListWithSample(subList, SystemConstants.NODMAP_KEY_C_GUID);
						for(int y =0; y< subList.size(); y++){
							tmpSubObj = (Article)subList.get(y);
							tmpNode = (Node)tmpSubNodeMap.get(tmpSubObj.getSys_guid());
							url = SystemConstants.HTTP + PropertiesConstants.get(PropertiesConstants.externalHost) +
								request.getAttribute("contextPath")+ "/" + thisMember.getMem_shopurl() + "/doc"+  tmpNode.getNod_url();
							sbSub.append("<li><a href=\""+url+"\" >"+tmpSubObj.getArti_name()+"</a></li>\n");
						}
						
						sbSub.append("</ul>\n");
						sbSub.append("</div>\n");
					}
				}
			}
			topOut.write(sb.toString());
			subOut.write(sbSub.toString());
			
			topOut.flush(); 
			topOut.close();
	        
	        subOut.flush(); 
	        subOut.close();
		} catch (Exception e){
			e.printStackTrace();
			cmaLogger.error("ARTI_Handler.generateNavigator exception: ", request, e);
		}
	}
	
	
}


