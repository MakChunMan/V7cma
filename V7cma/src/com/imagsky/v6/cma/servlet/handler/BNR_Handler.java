package com.imagsky.v6.cma.servlet.handler;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


import com.imagsky.v6.dao.ArticleDAO;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.dao.NodeDAO;
import com.imagsky.v6.dao.OrderSetDAO;
import com.imagsky.v6.dao.SellItemCategoryDAO;
import com.imagsky.v6.dao.SellItemDAO;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Node;
import com.imagsky.v6.domain.OrderSet;
import com.imagsky.v6.domain.SellItem;
import com.imagsky.v6.domain.SellItemCategory;
import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.*;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.PropertiesUtil;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;
import com.imagsky.utility.*;

public class BNR_Handler  extends BaseHandler {

	//Show criteria page : Whole page
	public static final String SHOW_SEARCH = "SHOW_SEARCH";
	
	//AJAX list arti / Category list by Search Type
	public static final String AJ_OPTIONS = "AJ_OPTION";
	
	//AJAX show search result
	public static final String AJ_DO_SEARCH = "AJ_SEARCH";
	
	//SAVE change
	public static final String DO_SAVE = "DO_SAVE";
	
	//List existing banner(popup)
	public static final String POPUP_LIST_BNR = "DO_LIST_POPUP";
	
	private Member thisMember = null;
	private String thisLang = null;
	
	protected static final String CLASS_NAME = "BNR_Handler.java";
	
	/* (non-Javadoc)
	 * @see com.asiamiles.website.handler.Action#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);		
		
		String action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));
		
		cmaLogger.debug("Action = "+ action);
		
		thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
		thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
		
		if(action.equalsIgnoreCase(AJ_OPTIONS)){
			thisResp = findOptionAJ(request, response);
		}  else if(action.equalsIgnoreCase(AJ_DO_SEARCH)){
			thisResp = doSearch(request, response);
		}  else if(action.equalsIgnoreCase(DO_SAVE)){
			thisResp = doSave(request, response);			
		}  else if(action.equalsIgnoreCase(POPUP_LIST_BNR)){
			thisResp = doList(request, response);			
		}  else {
			thisResp = showSearch(request, response);
		}
		
		
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}

	
	private SiteResponse doSave(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		String nodeGUID = CommonUtil.null2Empty(request.getParameter("NODE_GUID"));
		String bannerURL = CommonUtil.null2Empty(request.getParameter("BANNER_IMAGE_1"));
		
		if(!CommonUtil.isNullOrEmpty(nodeGUID) && !CommonUtil.isNullOrEmpty(bannerURL)){
			try{
				NodeDAO nDAO = NodeDAO.getInstance();
				Node aNode = new Node();
				aNode.setSys_guid(nodeGUID);
				aNode.setNod_bannerurl(bannerURL);
				nDAO.update(aNode);
				request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
				"BNR_DONE"));
			} catch (BaseDBException e){
				thisResp.addErrorMsg(new SiteErrorMessage("BNR_SAVE_ERR"));
				cmaLogger.error("BRN_Handler doSave Exception :", request, e);
			}
		}
		thisResp.setTargetJSP(CMAJspMapping.JSP_BNR_SERACH_AJ);
		return thisResp;
	}


	private SiteResponse showSearch(HttpServletRequest request,
			HttpServletResponse response) {
		
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(CMAJspMapping.JSP_BNR_SEARCH);
		return thisResp;
	}


	private SiteResponse doSearch(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		
		if(CommonUtil.isNullOrEmpty(request.getParameter("PAGE_TYPE"))){
			thisResp.addErrorMsg(new SiteErrorMessage("BNR_PAGETYPE_EMPTY"));
		}
		if(CommonUtil.isNullOrEmpty(request.getParameter("CONTENT_GUID"))){
			thisResp.addErrorMsg(new SiteErrorMessage("BNR_PAGECONTENT"));
		}	
		if(!thisResp.hasError()){
			NodeDAO nDAO = NodeDAO.getInstance();
			try{
				Node enqObj = new Node();
				enqObj.setNod_owner(thisMember.getSys_guid());
				enqObj.setNod_contentGuid(request.getParameter("CONTENT_GUID"));
				List nodeList = nDAO.findListWithSample(enqObj);
				if(nodeList==null || nodeList.size()==0){
					thisResp.addErrorMsg(new SiteErrorMessage("BNR_NOT_FOUND"));
				}
				request.setAttribute("NODELIST",nodeList);
			} catch (BaseDBException e){
				cmaLogger.error("BNR_Handler doSearch Error: ", request, e);
				thisResp.addErrorMsg(new SiteErrorMessage("BNR_SEARCHERR"));
			}
		}
		thisResp.setTargetJSP(CMAJspMapping.JSP_BNR_EDIT_AJAX);
		return thisResp;
	}


	private SiteResponse findOptionAJ(HttpServletRequest request,
			HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		String searchContentType = CommonUtil.null2Empty(request.getParameter("PAGE_TYPE"));
		ArrayList<String[]> resultList = new ArrayList<String[]>();
		if("CAT".equalsIgnoreCase(searchContentType)){
			SellItemCategoryDAO sDAO = SellItemCategoryDAO.getInstance();
			SellItemCategory enqObj = new SellItemCategory();
			enqObj.setCate_owner(thisMember.getSys_guid());
			enqObj.setCate_lang(thisLang);
			try{
				List aList = sDAO.findListWithSample(enqObj);
				Iterator it = aList.iterator();
				SellItemCategory tmp = null;
				while(it.hasNext()){
					tmp = (SellItemCategory)it.next();
					resultList.add(new String[]{tmp.getSys_guid(),tmp.getCate_name()});
				}
			} catch (BaseDBException e){
				cmaLogger.error("BNR_Handler exception - findOptionAJ:",	request, e);
			}
		} else if("ARTI".equalsIgnoreCase(searchContentType)){
			ArticleDAO aDAO = ArticleDAO.getInstance();
			Article enqObj = new Article();
			enqObj.setArti_owner(thisMember.getSys_guid());
			enqObj.setArti_lang(thisLang);
			try{
				List aList = aDAO.findListWithSample(enqObj);
				Iterator it = aList.iterator();
				Article tmp = null;
				while(it.hasNext()){
					tmp = (Article)it.next();
					resultList.add(new String[]{tmp.getSys_guid(),tmp.getArti_name()});
				}
			} catch (BaseDBException e){
				cmaLogger.error("BNR_Handler exception - findOptionAJ:",	request, e);
			}
		}
		
		request.setAttribute("optionList", resultList);
		thisResp.setTargetJSP(CMAJspMapping.JSP_BNR_EDITOPTION_AJAX);
		return thisResp;
	}

	private SiteResponse doList(HttpServletRequest request,
			HttpServletResponse response){
		
		SiteResponse thisResp = super.createResponse();
		
		String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadDirectory)+ "/"+
		thisMember.getSys_guid() +"/";
		
		try{
			File uploadDirectory = new File(userImagePath);
			cmaLogger.debug("userImagePath: "+ userImagePath);
			FilenameFilter bannerFilter = new FilenameFilter() {
			    public boolean accept(File dir, String name) {
			    	if(name.startsWith(".")){
			    		return false;
			    	} else if(name.startsWith("bnr_")){
			    		return true;
			    	}
			        return false;
			    }
			};
		
			File[] children = uploadDirectory.listFiles(bannerFilter);
			request.setAttribute("filelist", children);
		}catch (Exception e){
			cmaLogger.error("Existing Banner Listing Exception: ", e);
		}
		thisResp.setTargetJSP(CMAJspMapping.JSP_TXNLIST);
		return thisResp;
		
	}
}


