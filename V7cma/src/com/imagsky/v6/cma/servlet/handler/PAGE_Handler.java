/****
 * 2014-08-11 Ajax Page Handler for New Mobile Web Site
 */
package com.imagsky.v6.cma.servlet.handler;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.common.SiteResponse;
import com.imagsky.constants.V7JspMapping;
import com.imagsky.exception.BaseException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;

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
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.INPUT_EMAIL.name())) {
            thisResp = showMainEmail(request, response);
        } else if (appCodeToken[1].equalsIgnoreCase(Pages.INPUT_PASS.name())) {
            thisResp = showPassword(request, response);
        } else {
        	thisResp = showMain(request, response);
        }
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



	private SiteResponse showPassword(HttpServletRequest request, HttpServletResponse response) {
 		SiteResponse thisResp = super.createResponse();
 		cmaLogger.debug("PAGE :"+request.getParameter("main_email"), request);
 		thisResp.setTargetJSP(V7JspMapping.INPUT_PASS);
		return thisResp;
	}


	/*****
	 * Display email input field (AJAX)
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse showMainEmail(HttpServletRequest request, HttpServletResponse response) {
 		SiteResponse thisResp = super.createResponse();
 		thisResp.setTargetJSP(V7JspMapping.INPUT_EMAIL);
		return thisResp;
	}



	public enum Pages { 
		PUB_MAIN,
		INPUT_EMAIL,								//inc_mainemail.jsp			- 	1.1 Input Email
		//New Register
		INPUT_PASS,								//inc_login.jsp						-	1.3 Input Password for login
		INPUT_NEW_PASS_APPNAME	//inc_newregister.jsp			-	1.4 New register app name and password
	};
}


