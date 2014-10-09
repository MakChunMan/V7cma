/****
 * 2014-08-11 Ajax Page Handler for New Mobile Web Site
 */
package com.imagsky.v6.cma.servlet.handler;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.constants.V7JspMapping;
import com.imagsky.exception.BaseException;
import com.imagsky.util.ClearFileUtil;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.utility.MD5Utility;
import com.imagsky.v6.biz.MemberBiz;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.Member;

public class PAGE_Handler extends BaseHandler  {

	private String[] appCodeToken;
	
    protected static final String CLASS_NAME = "PAGE_Handler.java";
    private String thisLang = null;
	
	@Override
	public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) throws BaseException {
		
		SiteResponse thisResp = super.createResponse();
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);

        //No need check login currently
        //thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
        thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
        
		//tokenized URL 
		appCodeToken = (String[])request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN); //[0]: "PAGE", [1]:"Pages"
		
		/****
		- 1.1 Show Email Main page
		- If Register, show input password page (1.2) and chapta
		- if Login, show login password page (1.3)
		****/
		
		if(appCodeToken.length<2){
			thisResp = null;
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.INPUT_LOGIN.name())) {
            thisResp = showLogin(request, response);
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.DO_LOGIN.name())) {
			thisResp = doLogin(request, response);
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.PUB_MAIN.name())) {
			thisResp = showMain(request, response);
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.DO_LOGOUT.name())) {
			thisResp = doLogout(request, response);
		}
		return thisResp;
	}
	
	private SiteResponse doLogout(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		
		ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
		Member logoutUser =  session.getUser();
		
		//File clear
		ClearFileUtil.clearFile(logoutUser, ClearFileUtil.ALL);
		
		//LOGOUT
		session.setUser(null);
		session.setLogined(false);
		
		//FB access token
		session.setFbAccessToken(null);
		
		//Clear Shopping Cart
		request.getSession().removeAttribute(SystemConstants.PUB_CART);
		request.getSession().removeAttribute(SystemConstants.PUB_CART_INFO);
		request.getSession().removeAttribute(SystemConstants.PUB_BULKORDER_INFO);
                
        //Clear Reminder
		request.getSession().removeAttribute(SystemConstants.REQ_ATTR_REMINDER );
                
		request.setAttribute("LOGOUTUSER", logoutUser);
		if(logoutUser!=null){
			request.setAttribute("redirectURL", request.getAttribute("contextPath")+ "/" + logoutUser.getMem_shopurl()+"/.do");
		}
		request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
		"LOGOUT_DONE"));
		thisResp.setTargetJSP(V7JspMapping.LOGOUT);
		
		return thisResp;
	}

	private SiteResponse doLogin(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		
		
		MemberBiz biz = MemberBiz.getInstance();
		try {
			//Check member / email exist
			Member thisLoginMember = biz.doCheckMemberExist(CommonUtil.null2Empty(request.getParameter("login-email")));
			if(thisLoginMember==null){
				//No such member
				thisResp.addErrorMsg(new SiteErrorMessage("LOGIN_NO_MEMBER"));
			} else {
				cmaLogger.debug(MD5Utility.MD5(CommonUtil.null2Empty(request.getParameter("login-password"))));
				cmaLogger.debug(thisLoginMember.getMem_passwd());
				//Validate password
				if(!thisLoginMember.isSys_is_live()){
					//NOT YET ACTIVATE
					thisResp.addErrorMsg(new SiteErrorMessage("LOGIN_ACC_NOT_ACTIVATE"));
				} else if(thisLoginMember.getFb_id()!=null && CommonUtil.isNullOrEmpty(thisLoginMember.getMem_passwd())){
					//FACEBOOK REGISTERED BUT NOT BBM => Redirect to Setting Password
					thisResp.addErrorMsg(new SiteErrorMessage("LOGIN_INV_PASSWD"));
					request.setAttribute("FB_SET_PASSWORD", "Y");
				} else if(biz.doCheckPassword(thisLoginMember, request.getParameter("login-password"))){
					//Update lastloginDate
					thisLoginMember.setMem_lastlogindate(new java.util.Date());
					biz.doSaveMember(thisLoginMember);
					//Store in session
					ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
					session.setLogined(true);
					session.setUser(thisLoginMember);
					request.getSession().setAttribute(SystemConstants.REQ_ATTR_SESSION, session);
					cmaLogger.debug("LOGIN:" + thisLoginMember.getMem_display_name());
					request.setAttribute(
							SystemConstants.REQ_ATTR_DONE_MSG, 
							MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG),"LOGIN_DONE") 
					);
				} else {
					thisResp.addErrorMsg(new SiteErrorMessage("INVALID_PASSWORD"));
				}
			}
			
			if(thisResp.hasError()){
				thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
			} else {
				thisResp.setTargetJSP(V7JspMapping.PUB_MAIN);
			}
		} catch (Exception e){
			thisResp.addErrorMsg(new SiteErrorMessage("UNKNOWN LOGIN ERROR"));
		}
		
		if(thisResp.hasError()){
			thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		} else {
			thisResp.setTargetJSP(V7JspMapping.PUB_MAIN);
		}
		return thisResp;
	}

	private SiteResponse showLogin(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(V7JspMapping.INPUT_LOGIN);
		return thisResp;
	}
	
	
	/****
	 * Display Main Page
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse showMain(HttpServletRequest request, HttpServletResponse response) {
 		SiteResponse thisResp = super.createResponse();
 		thisResp.setTargetJSP(V7JspMapping.PUB_MAIN);
		return thisResp;
	}


	public enum Pages { 
		PUB_MAIN,									//pub_main.jsp
		INPUT_LOGIN,								//inc_login.jsp						-	1.1 Input Password for login
		DO_LOGIN,									//(success) pub_main.jsp , (fail) return error msg
		DO_LOGOUT
	};
}


