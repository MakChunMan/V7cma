package com.imagsky.v6.cma.servlet.handler;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import com.imagsky.v6.cma.constants.*;
import com.imagsky.v6.domain.Member;
import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteResponse;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.util.logger.*;
import com.imagsky.util.CommonUtil;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;


public class REFRESH_Handler  extends BaseHandler {

	public static final String DO_SUBNAV = "SUBNAV";
	public static final String DO_TOPNAV = "TOPNAV";
	public static final String DO_HIGHLIGHT = "HIL";
	
	protected static final String CLASS_NAME = "REFRESH_Handler.java";
	
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
		
		//TODO: Login check in mainServlet
		thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
		thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
		
		if(action.equalsIgnoreCase(DO_SUBNAV)){
			thisResp = refreshSubNav(request, response);
		} else if(action.equalsIgnoreCase(DO_TOPNAV)){
			thisResp = refreshTopNav(request, response);
		} else if(action.equalsIgnoreCase(DO_HIGHLIGHT)){
				thisResp = refreshHighlight(request, response);			
		} else {
			//thisResp = doList(request, response, false); //Default
		}
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}

	private SiteResponse refreshHighlight(HttpServletRequest request,
			HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
			thisResp.setTargetJSP(CMAJspMapping.JSP_COM_AJ_SLIDESECTION);
	return thisResp;
	}

	private SiteResponse refreshSubNav(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
			thisResp.setTargetJSP(CMAJspMapping.JSP_COM_AJ_SUBNAV);
		return thisResp;
	}

	private SiteResponse refreshTopNav(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
			thisResp.setTargetJSP(CMAJspMapping.JSP_COM_AJ_TOPNAV);
		return thisResp;
	}
}


