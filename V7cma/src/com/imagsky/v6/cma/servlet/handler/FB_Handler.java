package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteResponse;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.Member;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




public class FB_Handler  extends BaseHandler {

	private Member thisMember = null;
	private String thisLang = null;
	
	public static final String SIGNIN = "SIGNIN";
	public static final String DO_SAVE = "SAVE";
	
	protected static final String CLASS_NAME = "FB_Handler.java";
	
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
		
		request.setAttribute("action", action);
		
		if(action.equalsIgnoreCase(DO_SAVE)){
			//thisResp = doSave(request, response);
		} else if(action.equalsIgnoreCase(SIGNIN)){
			//thisResp = receiveToken(request, response);
		} else {
			//thisResp = receiveToken(request, response);
		}
		
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}
	
	/***
	private SiteResponse receiveToken(HttpServletRequest request,
			HttpServletResponse response){

		SiteResponse thisResp = super.createResponse();
		
		if(CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME)).equalsIgnoreCase(SIGNIN)){
			String accessToken = request.getParameter("access_token");
			if(!CommonUtil.isNullOrEmpty(accessToken)){
				ImagskySession session = SessionManager.getSession(request);
				cmaLogger.debug("Access Token = "+ accessToken);
				session.setFbAccessToken(accessToken);
				//TODO: Perform BBM login
				MemberBiz biz = MemberBiz.getInstance();
				
				try {
					//Member fbMember = biz.getFBMemberInformation(URLEncoder.encode(accessToken,"UTF-8"));
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
				}
			}
		}
		thisResp.setTargetJSP(CMAJspMapping.JSP_FB_POPUP_CLIENT);
		return thisResp;
	}***/
}


