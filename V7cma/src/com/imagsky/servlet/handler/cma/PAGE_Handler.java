/****
 * 2014-08-11 Ajax Page Handler for New Mobile Web Site
 */
package com.imagsky.servlet.handler.cma;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;

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
		
		if(appCodeToken.length<2){
			thisResp = null;
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.INPUT_EMAIL.name())) {
            thisResp = showMainEmail(request, response);
        } else if (appCodeToken[1].equalsIgnoreCase(Pages.INPUT_PASS.name())) {
            thisResp = doLogin(request, response);
        }
		return thisResp;
	}
	
	

	private SiteResponse doLogin(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		return null;
	}



	private SiteResponse showMainEmail(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		return null;
	}



	public enum Pages { 
		INPUT_EMAIL,								//inc_mainemail.jsp			- 	Input Email
		//New Register
		INPUT_PASS,								//inc_login.jsp						-	Input Password for login
		INPUT_NEW_PASS_APPNAME	//inc_newregister.jsp			-	New register app name and password
	};
}


