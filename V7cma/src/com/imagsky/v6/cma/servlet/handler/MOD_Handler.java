package com.imagsky.v6.cma.servlet.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.common.*;
import com.imagsky.constants.V7JspMapping;
import com.imagsky.exception.BaseException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.V8Util;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.Member;
import com.imagsky.v8.biz.AppBiz;
import com.imagsky.v8.biz.ModuleBiz;
import com.imagsky.v8.constants.V8SystemConstants;
import com.imagsky.v8.domain.App;
import com.imagsky.v8.domain.ModAboutPage;
import com.imagsky.v8.domain.ModForm;
import com.imagsky.v8.domain.Module;
import com.imagsky.v8.domain.serialized.AppForJson;

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
      		
		//Action Dispatcher
		if(appCodeToken.length<2){
			thisResp = null;
		} else if (appCodeToken[1].equalsIgnoreCase(Pages.MOD_ADD_MAIN.name())) {
            thisResp = showAddModuleMain(request, response); 
		} else if(appCodeToken[1].equalsIgnoreCase(Pages.MOD_LIST_MOD.name())) {
			thisResp = ajaxListCreatedModule(request, response); //ajax;
		} else if(appCodeToken[1].equalsIgnoreCase(Pages.MOD_SAVE.name())) {
					thisResp = modSave(request, response); //ajax;
		} else if(appCodeToken[1].equalsIgnoreCase(Pages.MOD_EDIT_ABOUTUS.name())){
					thisResp = modShowAboutUs(request, response);
		} else if(appCodeToken[1].equalsIgnoreCase(Pages.MOD_EDIT_FORM.name())){
			thisResp = modShowForm(request, response);					
		}  else if(appCodeToken[1].equalsIgnoreCase(Pages.DO_SAVE_MOD_CONTENT.name())){
					thisResp = doSaveModContent(request, response); //Save Module Content / Details
		}  else if(appCodeToken[1].equalsIgnoreCase(Pages.DO_DEL_MOD.name())){
					thisResp = doDelModContent(request, response); //Save Module Content / Details
		}
		return thisResp;
	}
	
	private SiteResponse doDelModContent(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		ModuleBiz biz = ModuleBiz.getInstance(thisMember, request);
		/***
		if(CommonUtil.isNullOrEmpty(request.getParameter("MODTYPE"))){
			thisResp.addErrorMsg(new SiteErrorMessage("MISSING_MODTYPE"));
		} else if(CommonUtil.isNullOrEmpty(request.getParameter("MODGUID"))){
			thisResp.addErrorMsg(new SiteErrorMessage("MISSING_MODGUID"));
		//} else if(CommonUtil.isNullOrEmpty(request.getParameter("MODTYPE"))){			
		}  else {
			biz.deleteModule(request.getParameter("MODTYPE"), request.getParameter("MODGUID"));
			request.setAttribute(V8SystemConstants.AJAX_RESULT, V8SystemConstants.AJAX_RESULT_TRUE);
			request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, "Save Successfully");
		}***/
		workingApp = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getWorkingApp();
		if(appCodeToken.length>3 && !CommonUtil.isNullOrEmpty(appCodeToken[3])){
			String guid = appCodeToken[2];
			String modType = appCodeToken[3];
			biz.deleteModule(workingApp, modType, guid);
		}
		request.setAttribute(V8SystemConstants.AJAX_RESULT, V8SystemConstants.AJAX_RESULT_TRUE);
		request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, "Save Successfully");
		thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		return thisResp;
	}

	//Generic Save Module Details (For different type of module details)
	private SiteResponse doSaveModContent(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		ModuleBiz biz = ModuleBiz.getInstance(thisMember, request);
		AppBiz appBiz = AppBiz.getInstance(thisMember, request);
		
		if(CommonUtil.isNullOrEmpty(request.getParameter("MODTYPE"))){
			thisResp.addErrorMsg(new SiteErrorMessage("MISSING_MODTYPE"));
		} else if(CommonUtil.isNullOrEmpty(request.getParameter("MODGUID"))){
			thisResp.addErrorMsg(new SiteErrorMessage("MISSING_MODGUID"));
		} else {
			Module obj = biz.updateModule(request.getParameter("MODTYPE"), request.getParameter("MODGUID"));
			request.setAttribute(SystemConstants.REQ_ATTR_OBJ, obj);
		}
		
		if(thisResp.hasError()){
			thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		} else {
			request.setAttribute(V8SystemConstants.AJAX_RESULT, V8SystemConstants.AJAX_RESULT_TRUE);
			request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, "Save Successfully");
			thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		}
		//Reload working app
		ImagskySession aSession = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION));
		App thisApp = aSession.getWorkingApp();
		
		aSession.setWorkingApp(appBiz.reloadApp(aSession.getWorkingApp()));
		request.getSession().setAttribute(SystemConstants.REQ_ATTR_SESSION,aSession);
		return thisResp;
	}

	//Load About Us Edit Form
	private SiteResponse modShowAboutUs(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		//Find saved details if necessary
		if(appCodeToken.length>2 && !CommonUtil.isNullOrEmpty(appCodeToken[2])){
			ModuleBiz biz = ModuleBiz.getInstance(thisMember, request);
			ModAboutPage obj = (ModAboutPage)biz.getModule(Module.ModuleTypes.ModAboutPage.name(), appCodeToken[2]);
			request.setAttribute(SystemConstants.REQ_ATTR_OBJ, obj);
		}
		thisResp.setTargetJSP(V7JspMapping.MOD_EDIT_ABOUTUS);
		return thisResp;
	}

	//Load Form Edit Form
	private SiteResponse modShowForm(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		//Find saved details if necessary
		if(appCodeToken.length>2 && !CommonUtil.isNullOrEmpty(appCodeToken[2])){
			ModuleBiz biz = ModuleBiz.getInstance(thisMember, request);
			ModForm obj = (ModForm)biz.getModule(Module.ModuleTypes.ModForm.name(), appCodeToken[2]);
			request.setAttribute(SystemConstants.REQ_ATTR_OBJ, obj);
		}
		thisResp.setTargetJSP(V7JspMapping.MOD_EDIT_FORM);
		return thisResp;
	}
	
	/***
	 * TODO: Update priority or change something by batch (Drag and drop)
	 * Description:  MY MODULE section -Save the order and create module (Dummy) into the App
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse modSave(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		ModuleBiz biz = ModuleBiz.getInstance(thisMember, request);
		AppBiz appBiz = AppBiz.getInstance(thisMember, request);
		
		for(int x = 1 ; x <= V8SystemConstants.V8_MAX_NO_MODULE ; x++){
			if(!CommonUtil.isNullOrEmpty(request.getParameter("module"+x))){
				//No change
			} else if(!CommonUtil.isNullOrEmpty(request.getParameter("newModule"+x))) {
				//New Module added
				workingApp = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getWorkingApp();
				biz.createModule(x, workingApp, request.getParameter("newModule"+x));
				//Reload working app
				ImagskySession aSession = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION));
				aSession.setWorkingApp(appBiz.reloadApp(aSession.getWorkingApp()));
			}
		}
		request.setAttribute(V8SystemConstants.AJAX_RESULT, V8SystemConstants.AJAX_RESULT_TRUE);
		request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, "Save Successfully");
		thisResp.setTargetJSP(V7JspMapping.COMMON_AJAX_RESPONSE);
		return thisResp;
	}

	private SiteResponse ajaxListCreatedModule(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		thisResp.setTargetJSP(V7JspMapping.MOD_AJ_LIST);
		return thisResp;
	}

	private SiteResponse showAddModuleMain(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		//Assign working App by GUID
		if(appCodeToken.length>=3){
			App sessionWorkingApp = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getWorkingApp(); 
			workingApp = getCurrentApp(thisMember, appCodeToken[2]);
			if(sessionWorkingApp!=null && sessionWorkingApp.getSys_guid().equalsIgnoreCase(workingApp.getSys_guid())){
				workingApp = sessionWorkingApp;
			}
			((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).setWorkingApp(workingApp);
		}
		if(workingApp!=null){
			AppForJson toJson = new AppForJson(workingApp);
			cmaLogger.debug("App:"+toJson.getJsonString());
		}
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
		MOD_LIST_MOD,
		MOD_SAVE,
		MOD_EDIT_ABOUTUS,
		MOD_EDIT_FORM,
		DO_SAVE_MOD_CONTENT,
		DO_DEL_MOD
	};
}
