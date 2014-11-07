package com.imagsky.v6.cma.servlet.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.common.*;
import com.imagsky.constants.V7JspMapping;
import com.imagsky.exception.BaseException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.V8Util;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.biz.MemberBiz;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.Member;
import com.imagsky.v8.biz.AppBiz;
import com.imagsky.v8.constants.V8SystemConstants;
import com.imagsky.v8.domain.App;

public class MOD_Handler extends BaseHandler {

	private String[] appCodeToken;
	private Member thisMember;
	
	private App workingApp;
	
    protected static final String CLASS_NAME = "MOD_Handler.java";
    private String thisLang = null;

	@Override
	public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) throws BaseException {
		SiteResponse thisResp = super.createResponse();
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);

        //Check Login
        if(CommonUtil.isNullOrEmpty(V8Util.v8CheckLogin(thisResp, request).getTargetJSP())){
        	return thisResp; //Return to Login Page
        }

        thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
        thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
        
		//tokenized URL 
		appCodeToken = (String[])request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN); //[0]: "MOD", [1]:"PAGE_ACTION", [2]:"APP_GUID"
		//Assign working App by GUID
		if(appCodeToken.length>=3){
			workingApp = getCurrentApp(thisMember, appCodeToken[2]);
			((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).setWorkingApp(workingApp);
		}
		
		//Action Dispatcher
		if(appCodeToken.length<2){
			thisResp = null;
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.MOD_ADD_MAIN.name())) {
            thisResp = showAddModuleMain(request, response); 
		} else if(appCodeToken[1].equalsIgnoreCase(Pages.MOD_LIST_MOD.name())) {
			thisResp = ajaxListCreatedModule(request, response); //ajax;
		}
		return thisResp;
	}
	
	private SiteResponse ajaxListCreatedModule(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(V7JspMapping.MOD_AJ_LIST);
		return thisResp;

	}

	private SiteResponse showAddModuleMain(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(V7JspMapping.MOD_ADD_MAIN);
		return thisResp;
	}
	
	private static App getCurrentApp(Member thisMember, String appGuid){
		if(thisMember == null ){
			cmaLogger.error("[V8-ModHandler-getCurrentApp] Not Yet Login");
			return null;
		} else {
			for(App aApp : thisMember.getApps()){
				if(aApp.getSys_guid().equalsIgnoreCase(appGuid)){
					return aApp;
				}
			}
			cmaLogger.error("[V8-ModHandler-getCurrentApp] Not Found such app - "+ appGuid);
		}
		return null;
	}

	public enum Pages { 
		MOD_ADD_MAIN,
		MOD_LIST_MOD
	};
}