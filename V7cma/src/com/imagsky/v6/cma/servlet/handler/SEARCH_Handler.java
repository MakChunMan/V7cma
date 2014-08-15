package com.imagsky.v6.cma.servlet.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.v6.dao.SearchDAO;
import com.imagsky.v6.dao.SearchLogDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.SearchRank;
import com.imagsky.v6.domain.SearchRecord;
import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.util.logger.*;
import com.imagsky.util.CommonUtil;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;

public class SEARCH_Handler  extends BaseHandler {

	protected static final String CLASS_NAME = "SEARCH_Handler.java";
	
	private String DO_SEARCH = "search";
	private String DO_SEARCH_AJ = "search_aj";
	
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
		
		if(action.equalsIgnoreCase(DO_SEARCH) || action.equalsIgnoreCase(DO_SEARCH_AJ)){
			thisResp = doKeywordSearch(request, response);
		} else {
			thisResp = doKeywordSearch(request, response); //Default
		}
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}
	
	private SiteResponse doKeywordSearch(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		String keyword = CommonUtil.null2Empty(request.getParameter("keyw"));
		boolean isNewSearch = false;
		int page = 1;
		if(CommonUtil.isNullOrEmpty(request.getParameter("p"))){
			page = 1;
			isNewSearch = true;
		} else if(!CommonUtil.isValidInteger(request.getParameter("p"))){
			page = 1;
		} else {
			page = new Integer(request.getParameter("p"));
		}
		 
		int rowPerPage = new Integer(PropertiesConstants.get(PropertiesConstants.searchRowPerPage));
		if(!keyword.equalsIgnoreCase("")){
			int startRow = ( page -1 ) * rowPerPage;
			try{
				SearchDAO dao = SearchDAO.getInstance();
				SearchRank[] result = dao.keyWordSearchSellItem(
						keyword, 
						thisLang, 
						new Integer(startRow).toString(), 
						new Integer(rowPerPage).toString());
				cmaLogger.debug("Search Result in current page ("+ keyword+  ") :" + result.length);
				
				int totalCount = dao.keyWordSearchCount(keyword, thisLang);
				cmaLogger.debug("Search Result total count ("+ keyword + ") :" + totalCount);
				request.setAttribute("searchresult", result);
				request.setAttribute("searchresulttotalcount", totalCount);
				request.setAttribute("startrow", startRow);
				request.setAttribute("rowPerPage", rowPerPage);
				request.setAttribute("p", page);//Current Page
				
				//Search Log
				if(isNewSearch){
					SearchLogDAO sdao = SearchLogDAO.getInstance();
					SearchRecord sr = new SearchRecord();
					sr.setCreate_date(new java.util.Date());
					sr.setKeyword(keyword);
					sr.setSource(request.getParameter("source"));
					sr.setSessionid(request.getSession().getId());
					sdao.create(sr);
				}
			} catch (Exception e){
				cmaLogger.error("SEARCH_ERROR", request, e);
				thisResp.addErrorMsg(new SiteErrorMessage("SEARCH_ERROR"));
			}
		} else {
			thisResp.addErrorMsg(new SiteErrorMessage("SEARCH_ERROR"));
		}
		
		if(action.equalsIgnoreCase(DO_SEARCH)){
			thisResp.setTargetJSP(CMAJspMapping.PUB_SEARCH);
		} else if(action.equalsIgnoreCase(DO_SEARCH_AJ)){
			thisResp.setTargetJSP(CMAJspMapping.PUB_SEARCH_AJ);
		} else {
			thisResp.setTargetJSP(CMAJspMapping.PUB_SEARCH);	
		}
		return thisResp;
	}

	
}


