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

public class APP_Handler extends BaseHandler {

	private String[] appCodeToken;
	private Member thisMember;
	
    protected static final String CLASS_NAME = "APP_Handler.java";
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
		appCodeToken = (String[])request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN); //[0]: "PAGE", [1]:"Pages"
		
		if(appCodeToken.length<2){
			thisResp = null;
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.APP_MAIN.name())) {
            thisResp = showAppMain(request, response); //ajax;
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.AJ_APP_ADD.name())) {
			thisResp = doAddSave(request, response);
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.AJ_LIST.name())) {
			thisResp = list(request, response);
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.AJ_SHOWEDIT.name())) {
			thisResp = showEdit(request, response);
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.DO_EDIT_SAVE.name())) {
			thisResp = doEditSave(request, response);
		}
		return thisResp;
	}
	
	private SiteResponse doEditSave(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		try{
			AppBiz appBiz = AppBiz.getInstance(thisMember, request);
			App app = appBiz.update();
			
			MemberBiz biz = MemberBiz.getInstance();
			ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
			session.setUser(biz.reloadMember(thisMember));
			request.getSession().setAttribute(SystemConstants.REQ_ATTR_SESSION, session);
		} catch (Exception e){
			cmaLogger.error("doEditSave Error", request, e);
		}
		if(thisResp.hasError()){
			thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		} else {
			request.setAttribute(V8SystemConstants.AJAX_RESULT, V8SystemConstants.AJAX_RESULT_TRUE);
			request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, "Save Successfully");
			thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		}
		return thisResp;
	}

	private SiteResponse showEdit(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		String guid = CommonUtil.null2Empty(request.getParameter("guid"));
		if(CommonUtil.isNullOrEmpty(guid)){
			thisResp.addErrorMsg(new SiteErrorMessage("Empty guid"));
		} else {
			for(App thisApp : thisMember.getApps()){
				if(guid.equalsIgnoreCase(thisApp.getSys_guid())){
					request.setAttribute(SystemConstants.REQ_ATTR_OBJ, thisApp);
					break;
				}
			}
			if(request.getAttribute(SystemConstants.REQ_ATTR_OBJ)==null){
				thisResp.addErrorMsg(new SiteErrorMessage("No such app from user"));
			}
		}
		if(thisResp.hasError()){
			thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		} else {
			request.setAttribute(V8SystemConstants.AJAX_RESULT, V8SystemConstants.AJAX_RESULT_TRUE);
			thisResp.setTargetJSP(V7JspMapping.APP_AJ_SHOWEDIT);
		}
		return thisResp;
	}

	private SiteResponse list(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(V7JspMapping.APP_AJ_LIST);
		return thisResp;
	}

	private SiteResponse doAddSave(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		try{
			AppBiz appBiz = AppBiz.getInstance(thisMember, request);
			App app = appBiz.addApp();
			
			MemberBiz biz = MemberBiz.getInstance();
			ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
			session.setUser(biz.reloadMember(thisMember));
			request.getSession().setAttribute(SystemConstants.REQ_ATTR_SESSION, session);
		} catch (Exception e){
			cmaLogger.error("doAddSave Error", request, e);
		}
		if(thisResp.hasError()){
			thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		} else {
			request.setAttribute(V8SystemConstants.AJAX_RESULT, V8SystemConstants.AJAX_RESULT_TRUE);
			request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV8Message(thisLang, "COMMON_LABEL_SUCCESS_CREATE"));
			thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		}
		return thisResp;
	}

	private SiteResponse showAppMain(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(V7JspMapping.APP_MAIN);
		return thisResp;
	}

	public enum Pages { 
		APP_MAIN,									
		AJ_APP_ADD,								
		AJ_LIST,
		AJ_SHOWEDIT,
		DO_EDIT_SAVE
	};

}
